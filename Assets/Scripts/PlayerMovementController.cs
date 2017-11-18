using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class PlayerMovementController : MonoBehaviour {

	public float maxSpeed = 1f;
	Vector2 movementVector = Vector2.zero;
	float movementLerpSpeed = 20f;

	Rigidbody2D rbody;

	// Use this for initialization
	void Start () {
		rbody = GetComponent<Rigidbody2D> ();
	}
	
	// Update is called once per frame
	void Update () {
		var movementInput = new Vector2 (Input.GetAxis ("Horizontal"), Input.GetAxis ("Vertical"));
		if (movementInput.magnitude > 1) {
			movementInput.Normalize ();
		}
		rbody.velocity = Vector2.Lerp (rbody.velocity, movementInput*maxSpeed, movementLerpSpeed * Time.deltaTime);
	}
}
