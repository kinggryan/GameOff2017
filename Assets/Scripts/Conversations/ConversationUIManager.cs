using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class ConversationUIManager : MonoBehaviour {

	public UnityEngine.UI.Image blackScreen;
	public UnityEngine.UI.Text nameBox;
	public UnityEngine.UI.Text dialogueBox;
	public GameObject choicesParent;
	public UnityEngine.UI.Text[] choiceBoxes;
	public ConversationManager conversationManager;

	private bool showBlackScreen = false;
	private float blackScreenFadeRate = 3f;
	private float fadedMessageThreshold = 0.005f;

	private struct Dialogue {
		public string name;
		public string text;
	}

	// Use this for initialization
	void Start () {
//		gameObject.SetActive (false);
		var blackScreenColor = blackScreen.color;
		blackScreenColor.a = 1f;
		blackScreen.color = blackScreenColor;
	}
	
	// Update is called once per frame
	void Update () {
		AdjustScreenFade ();
	}


	/// <summary>
	/// Returns true if we need to display choices after displaying this line.
	/// IE the line displayed was just a title.
	/// </summary>
	/// <returns><c>true</c>, if dialogue was displayed, <c>false</c> otherwise.</returns>
	/// <param name="dialogueRaw">Dialogue raw.</param>
	public bool DisplayDialogue(string dialogueRaw) {
		dialogueBox.enabled = true;
		choicesParent.SetActive (false);
		var dialogue = GetDialogueFromString(dialogueRaw);
		dialogueBox.text = dialogue.text;
		nameBox.text = dialogue.name;

//		Debug.Log ("N: " + dialogue.name + " T: '" + dialogue.text + "'");

		// If we only showed a nameplate, return true
		if (dialogue.name != "" && (dialogue.text == "" || dialogue.text == "\n")) {
			return true;
		}

		return false;
	}

	public void DisplayChoices(List<Choice> choices) {
		// Disable all the choice boxes first to ensure we don't display old options
		choicesParent.SetActive(true);
		dialogueBox.enabled = false;
		foreach (var choiceBox in choiceBoxes) {
			choiceBox.enabled = false;
		}

		for (var i = 0; i < choices.Count; i++) {
			var choice = choices [i];
			choiceBoxes [i].enabled = true;
			choiceBoxes [i].text = choice.text;
		}
	}

	private Dialogue GetDialogueFromString(string dialogue) {
		var seperators = new char[]{ ':' };
		var twoStrings = dialogue.Split (seperators, dialogue.Length);
		var retDialogue = new Dialogue ();
		if (twoStrings.Length == 1) {
			retDialogue.text = dialogue;
			retDialogue.name = "";
		} else {
			retDialogue.text = twoStrings [1];
			retDialogue.name = twoStrings [0];
		}
		return retDialogue;
	}

	void AdjustScreenFade() {
		if (showBlackScreen) {
			var blackScreenColor = blackScreen.color;
			var oldAlpha = blackScreenColor.a;
			blackScreenColor.a = Mathf.Lerp (blackScreenColor.a, 1f, blackScreenFadeRate * Time.deltaTime);
			blackScreen.color = blackScreenColor;

//			Debug.Log ("Fade Out - New color " + blackScreenColor);

			// If we faded in enough, broadcast the message
			if (oldAlpha < 1 - fadedMessageThreshold && blackScreenColor.a >= 1 - fadedMessageThreshold) {
				conversationManager.OnScreenFadeOutComplete ();
			}
		} else {
			var blackScreenColor = blackScreen.color;
			var oldAlpha = blackScreenColor.a;
			blackScreenColor.a = Mathf.Lerp (blackScreenColor.a, 0f, blackScreenFadeRate * Time.deltaTime);
			blackScreen.color = blackScreenColor;
//			Debug.Log ("New color " + blackScreenColor);

			// If we faded in enough, broadcast the message
			if (oldAlpha > fadedMessageThreshold && blackScreenColor.a <= fadedMessageThreshold) {
				BroadcastMessage ("OnScreenFadeInComplete", SendMessageOptions.DontRequireReceiver);
			}
		}
	}

	public void FadeOut() {
		showBlackScreen = true;
	}
}
