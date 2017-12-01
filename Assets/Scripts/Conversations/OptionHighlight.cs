using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(UnityEngine.UI.Text))]
public class OptionHighlight : MonoBehaviour {

	UnityEngine.UI.Text text;
	public Color highlightColor;
	Color unhighlightColor = Color.black;
	bool highlight;

	// Use this for initialization
	void Start () {
		text = GetComponent<UnityEngine.UI.Text> ();
	}
	
	// Update is called once per frame
	void Update () {
		var targetColor = highlight ? highlightColor : unhighlightColor;
		text.color = Color.Lerp (text.color, targetColor, 10 * Time.deltaTime);
	}

	public void Highlight() {
		highlight = true;
	}

	public void Unhighlight() {
		highlight = false;
	}
}
