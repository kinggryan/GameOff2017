using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour {

	float talkingDistance = 2f;
	PlayerMovementController player;
	ConversationManager conversationManager;

	// Use this for initialization
	void Start () {
		player = Object.FindObjectOfType<PlayerMovementController> ();
		conversationManager = Object.FindObjectOfType<ConversationManager> ();
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
		conversationManager.StartConversation ();
	}
}
