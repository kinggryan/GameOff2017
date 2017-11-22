using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class ConversationUIManager : MonoBehaviour {

	public UnityEngine.UI.Text dialogueBox;
	public GameObject choicesParent;
	public UnityEngine.UI.Text[] choiceBoxes;

	// Use this for initialization
	void Start () {
//		gameObject.SetActive (false);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void DisplayDialogue(string dialogue) {
		dialogueBox.enabled = true;
		choicesParent.SetActive (false);
		dialogueBox.text = dialogue;
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
}
