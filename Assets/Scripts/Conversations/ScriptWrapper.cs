using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class ScriptWrapper : MonoBehaviour {

	// Set this file to your compiled json asset
	public TextAsset inkAsset;

	// The ink story that we're wrapping
	static Story _inkStory;

	void Awake()
	{
		if(_inkStory == null) 
			_inkStory = new Story(inkAsset.text);
	}

	public bool CanGetNextLine() {
		return _inkStory.canContinue;
	}

	public bool CanGetChoices() {
		return _inkStory.currentChoices.Count > 0;
	}

	/// <summary>
	/// Gets the next line of the story.
	/// </summary>
	/// <returns>The next line.</returns>
	public string GetNextLine()
	{
		var nextLine = _inkStory.Continue ();
//		Debug.Log ("Next line: " + nextLine);
		return nextLine;
	}

	public string GetCurrentLine()
	{
		return _inkStory.currentText;
	}

	public List<Choice> GetChoices() {
		return _inkStory.currentChoices;
	}

	public void ChooseChoiceIndex(int index) {
		_inkStory.ChooseChoiceIndex (index);
	}

	public List<string> GetTags() {
		return _inkStory.currentTags;
	}
}
