using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
[RequireComponent(typeof(Animator))]
public class PlayerMovementController : MonoBehaviour {

	private float maxSpeed = 1.5f;
	Vector2 movementVector = Vector2.zero;
	float movementLerpSpeed = 20f;

	Animator animator;
	Rigidbody2D rbody;

	// Use this for initialization
	void Start () {
		rbody = GetComponent<Rigidbody2D> ();
		animator = GetComponent<Animator> ();
	}
	
	// Update is called once per frame
	void Update () {
		var movementInput = new Vector2 (Input.GetAxis ("Horizontal"), Input.GetAxis ("Vertical"));
		if (movementInput.magnitude > 1) {
			movementInput.Normalize ();
		}
		rbody.velocity = Vector2.Lerp (rbody.velocity, movementInput*maxSpeed, movementLerpSpeed * Time.deltaTime);

		// Set animation parameters
		var walking = movementInput.magnitude > 0.01f;
		animator.SetBool ("walking", walking);
		if(walking) {
			// The walk directions are:
			// 0 - left
			// 1 - up
			// 2 - right
			// 3 - down
			var walkDirection = 0;
			if (Mathf.Abs (movementInput.x) > Mathf.Abs (movementInput.y)) {
				if (movementInput.x > 0) {
					walkDirection = 2;
				} else {
					walkDirection = 0;
				}
			} else {
				if (movementInput.y > 0) {
					walkDirection = 1;
				} else {
					walkDirection = 3;
				}
			}
			animator.SetInteger ("direction", walkDirection);
		}
	}
}
