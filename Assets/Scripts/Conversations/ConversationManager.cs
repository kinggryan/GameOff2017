using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

[RequireComponent(typeof(ScriptWrapper))]
public class ConversationManager : MonoBehaviour {

	public GameObject conversationUIParent;
	public ConversationUIManager uiManager;
	private ScriptWrapper story;
	private bool inConversation = false;

	float delayDuration = 0.5f;
	float delayTimer = 0.5f;

	void Start() {
		story = GetComponent<ScriptWrapper> ();
//		uiManager = UnityEngine.Object.FindObjectOfType<ConversationUIManager> ();
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

		// If there's a line of dialogue, display it
		if (story.CanGetNextLine ()) {
			Debug.Log ("Getting next line");
			DisplayDialogue (story.GetNextLine ());
		} else if (story.CanGetChoices ()) {
			Debug.Log ("Getting choices");
			DisplayChoices (story.GetChoices ());
		} else {
			Debug.Log ("Ending dialogue");
			EndDialogue ();
		}

		delayTimer += delayDuration;
	}

	public void ChoiceSelected(int choiceIndex) {
		if (delayTimer >= 0)
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
