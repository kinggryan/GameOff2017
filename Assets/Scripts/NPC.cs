using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour {

	float talkingDistance = 0.33f;
	PlayerMovementController player;

	// Use this for initialization
	void Start () {
		player = Object.FindObjectOfType<PlayerMovementController> ();
	}
	
	// Update is called once per frame
	void Update () {
		var playerPos2D = Vector3.ProjectOnPlane (player.transform.position, Vector3.forward);
		var pos2D = Vector3.ProjectOnPlane (transform.position, Vector3.forward);
		if (Input.GetMouseButtonDown (0) && Vector3.Distance (playerPos2D, pos2D) <= talkingDistance) {
			StartConversation ();
		}
	}

	void StartConversation() {
		Debug.Log ("Blah blah blah");
	}
}
