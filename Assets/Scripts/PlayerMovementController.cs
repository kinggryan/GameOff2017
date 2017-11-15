using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovementController : MonoBehaviour {

	float maxSpeed = 0.3f;
	Vector2 movementVector = Vector2.zero;
	float movementLerpSpeed = 70f;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		var movementInput = new Vector2 (Input.GetAxis ("Horizontal"), Input.GetAxis ("Vertical"));
		if (movementInput.magnitude > 1) {
			movementInput.Normalize ();
		}
		movementVector = Vector2.Lerp (movementVector, movementInput, movementLerpSpeed * Time.deltaTime);

		transform.position += new Vector3 (movementVector.x, movementVector.y)*Time.deltaTime*maxSpeed;
	}
}
