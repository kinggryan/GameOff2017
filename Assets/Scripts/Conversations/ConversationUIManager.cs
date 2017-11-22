using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class ConversationUIManager : MonoBehaviour {

	public UnityEngine.UI.Text nameBox;
	public UnityEngine.UI.Text dialogueBox;
	public GameObject choicesParent;
	public UnityEngine.UI.Text[] choiceBoxes;

	private struct Dialogue {
		public string name;
		public string text;
	}

	// Use this for initialization
	void Start () {
//		gameObject.SetActive (false);
	}
	
	// Update is called once per frame
	void Update () {
		
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

//		var heightBetweenChoices = (choicesParent.GetComponent<RectTransform> ().rect.height - choiceBoxes[0].rectTransform.rect.height)/(choiceBoxes.Length-1);
//		var currentOffset =  (choices.Count - 1) * heightBetweenChoices / 2;
		for (var i = 0; i < choices.Count; i++) {
			var choice = choices [i];
			choiceBoxes [i].enabled = true;
			choiceBoxes [i].text = choice.text;
//			var transformPos = choiceBoxes [i].rectTransform.position;
//			transformPos.y = currentOffset;
//			choiceBoxes [i].rectTransform.position = transformPos;
//			currentOffset += heightBetweenChoices;
		}
	}

	private Dialogue GetDialogueFromString(string dialogue) {
		var seperators = new char[]{ ':' };
		var twoStrings = dialogue.Split (seperators, dialogue.Length);
//		Debug.Log ("Strings: " + twoStrings.Length);
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
}
