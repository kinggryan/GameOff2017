using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class ScriptWrapper : MonoBehaviour {

	// Set this file to your compiled json asset
	public TextAsset inkAsset;

	// The ink story that we're wrapping
	Story _inkStory;

	void Awake()
	{
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
		return _inkStory.Continue ();
	}

	public List<Choice> GetChoices() {
		return _inkStory.currentChoices;
	}

	public void ChooseChoiceIndex(int index) {
		_inkStory.ChooseChoiceIndex (index);
	}
}
