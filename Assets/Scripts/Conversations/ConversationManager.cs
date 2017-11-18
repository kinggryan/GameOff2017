using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

[RequireComponent(typeof(ScriptWrapper))]
public class ConversationManager : MonoBehaviour {

	public GameObject conversationUIParent;
	private ConversationUIManager uiManager;
	private ScriptWrapper story;
	private bool inConversation = false;

	float delayTime = 0.5f;

	void Awake() {
		story = GetComponent<ScriptWrapper> ();
		uiManager = UnityEngine.Object.FindObjectOfType<ConversationUIManager> ();
	}

	void Update() {
		delayTime -= Time.deltaTime;
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
		if (delayTime >= 0)
			return;

		// If there's a line of dialogue, display it
		if (story.CanGetNextLine ()) {
			DisplayDialogue (story.GetNextLine ());
		} else if (story.CanGetChoices ()) {
			DisplayChoices (story.GetChoices ());
		} else {
			EndDialogue ();
		}

		delayTime += delayTime;
	}

	public void ChoiceSelected(int choiceIndex) {
		if (delayTime >= 0)
			return;
		
		story.ChooseChoiceIndex(choiceIndex);
		ProgressConversation();
	}

	void DisplayDialogue(string dialogue) {
		Debug.Log (Time.time + " Displaying dialogue " + dialogue);
		uiManager.DisplayDialogue (dialogue);
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
}
