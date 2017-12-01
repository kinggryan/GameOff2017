using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(UnityEngine.UI.Text))]
public class FaderOuter : MonoBehaviour {

	float fadeoutTimer;
	float fadeoutDelay = 2f;
	float fadeoutDuration = 2f;
	UnityEngine.UI.Text image;

	// Use this for initialization
	void Start () {
		image = GetComponent<UnityEngine.UI.Text> ();
		fadeoutTimer = fadeoutDelay + fadeoutDuration;
	}
	
	// Update is called once per frame
	void Update () {
		fadeoutTimer -= Time.deltaTime;
		var color = image.color;
		color.a = Mathf.Clamp(fadeoutTimer / fadeoutDuration,0,1);
		image.color = color;
	}
}
