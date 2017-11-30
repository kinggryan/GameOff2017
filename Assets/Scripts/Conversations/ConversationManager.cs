using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using Ink.Runtime;

[RequireComponent(typeof(ScriptWrapper))]
public class ConversationManager : MonoBehaviour {

	public GameObject conversationUIParent;
	public ConversationUIManager uiManager;
	public SoundEngine soundEngine;

	private ScriptWrapper story;
	private bool inConversation = false;
	private bool justHandledEventOrLoadedScene = false;

	float delayDuration = 0.5f;
	float delayTimer = 0.5f;

	int sceneIndexToLoadOnFadeOut = -1;

	void Start() {
		story = GetComponent<ScriptWrapper> ();
		uiManager.conversationManager = this;
//		uiManager = UnityEngine.Object.FindObjectOfType<ConversationUIManager> ();

		// Show the current line of story
		DisplayDialogue(story.GetCurrentLine());
	}

	void Update() {
		delayTimer -= Time.deltaTime;
	}

	public void StartConversation() {
		if (inConversation)
			return;
		inConversation = true;

		// Unhide the UI
		conversationUIParent.SetActive(true);

		// Progress Conversation
		ProgressConversation();
	}

	public void ProgressConversation() {
		if (delayTimer >= 0)
			return;

		foreach (var tag in story.GetTags()) {
			Debug.Log ("Tag " + Time.time + " " + tag);
		}

		// If we need to do a different thing
		if (story.CanGetNextLine ()) {
			justHandledEventOrLoadedScene = false;
			// Show the next line if we only showed a nameplate just now
			if (DisplayDialogue (story.GetNextLine ()) && story.CanGetChoices()) {
				DisplayChoices (story.GetChoices ());
			}
		} else if (story.CanGetChoices ()) {
			justHandledEventOrLoadedScene = false;
			Debug.Log ("Getting choices");
			DisplayChoices (story.GetChoices ());
		} else {
			justHandledEventOrLoadedScene = false;
			Debug.Log ("Ending dialogue");
			EndDialogue ();
		}

		// Load game events or scenes if we got that tag
		if (StoryHasGameEvent ()) {
			// Do the thing
			HandleGameEvent();
		} else if (StoryShouldLoadNewScene ()) {
			LoadNextScene ();
		}

		PlaySoundsForThisLine ();

		delayTimer += delayDuration;
	}

	public void ChoiceSelected(int choiceIndex) {
		if (delayTimer >= 0)
			return;
		
		story.ChooseChoiceIndex(choiceIndex);
		ProgressConversation();
	}

	bool StoryHasGameEvent() {
		if (justHandledEventOrLoadedScene)
			return false;

		var tags = story.GetTags ();
		foreach (var tag in tags) {
			if (tag.Contains ("gameEvent"))
				return true;
		}
		return false;
	}

	bool StoryShouldLoadNewScene() {
		if (justHandledEventOrLoadedScene)
			return false;
		
		var tags = story.GetTags ();
		foreach (var tag in tags) {
			if (tag.Contains ("loadScene"))
				return true;
		}
		return false;
	}

	bool DisplayDialogue(string dialogue) {
		return uiManager.DisplayDialogue (dialogue);
	}

	void DisplayChoices(List<Choice> choices) {
		Debug.Log ("Displaying choices: " + choices);	
		uiManager.DisplayChoices (choices);
	}

	void EndDialogue() {
		Debug.Log ("Ending conversation");
		conversationUIParent.SetActive(false);
		inConversation = false;
	}

	void HandleGameEvent() {
		var tags = story.GetTags ();
		foreach (var str in tags) {
			if (str.Contains("gameEvent")) {
				DoEventName (str.Substring ("gameEvent ".Length));
			}
		}

		// Do a thing
		justHandledEventOrLoadedScene = true;
	}

	void DoEventName(string name) {
		// Do the event name
	}

	void LoadNextScene() {
		var tags = story.GetTags ();
		foreach (var str in tags) {
			if (str.Contains("loadScene")) {
				var sceneName = str.Substring ("loadScene ".Length);
				var sceneIndex = IndexForSceneName (sceneName);
				if (sceneIndex >= 0) {
					sceneIndexToLoadOnFadeOut = sceneIndex;
					uiManager.FadeOut ();
				}

				break;
			}
		}

		justHandledEventOrLoadedScene = true;
	}

	int IndexForSceneName(string str) {
		switch (str) {
		case "Outside":
			return 0;
		case "parlor1":
			return 1;
		case "dining":
			return 2;
		case "parlor2":
			return 3;
		case "parlor3":
			return 4;
		}
		return -1;
	}

	public void OnScreenFadeOutComplete() {
		SceneManager.LoadScene (sceneIndexToLoadOnFadeOut);
	}

	void PlaySoundsForThisLine() {
		foreach (var tag in story.GetTags()) {
			PlaySoundWithTag (tag);
		}
	}

	void PlaySoundWithTag(string tag) {
		if (tag.Contains ("playSound")) {
			var soundName = tag.Substring ("playSound ".Length);
			Debug.Log ("Playing sound with name " + soundName);
			soundEngine.PlaySoundWithName (soundName);
		}
	}
}
