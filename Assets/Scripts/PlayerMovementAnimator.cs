using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
[RequireComponent(typeof(Animator))]
public class PlayerMovementAnimator : MonoBehaviour {

	public interface PlayerMovementAnimatorCompletionCallback {
		void MovementCompleted();
	}

	public class MovementStep
	{
		public Vector2 velocity;
		public float duration;
	}

	public MovementStep[] movementSteps;
	public PlayerMovementAnimatorCompletionCallback callback;

	int currentStep = 0;
	float timeIntoStep = 0f;
	float movementLerpSpeed = 20f;
	Rigidbody2D rbody;
	Animator animator;

	// Use this for initialization
	void Start () {
		rbody = GetComponent<Rigidbody2D> ();
		animator = GetComponent<Animator> ();
	}
	
	// Update is called once per frame
	void Update () {
		if (currentStep >= movementSteps.Length)
			return;

		// Update our current step if needed
		if (timeIntoStep >= movementSteps [currentStep].duration) {
			timeIntoStep -= movementSteps [currentStep].duration;
			currentStep++;
			// Stop and make the callback if needed
			if (currentStep >= movementSteps.Length) {
				rbody.velocity = Vector2.zero;
				SetWalkingAnimationParams ();
				callback.MovementCompleted ();
				return;
			}
		}

		// Move
		rbody.velocity = Vector2.Lerp (rbody.velocity, movementSteps[currentStep].velocity, movementLerpSpeed * Time.deltaTime);
		timeIntoStep += Time.deltaTime;
		SetWalkingAnimationParams ();
	}

	void SetWalkingAnimationParams() {
		// NOTE: This is bad code duplication from PlayerMovementController.cs
		// Set animation parameters
		var walking = rbody.velocity.magnitude > 0.01f;
		animator.SetBool ("walking", walking);
		if(walking) {
			// The walk directions are:
			// 0 - left
			// 1 - up
			// 2 - right
			// 3 - down
			var walkDirection = 0;
			if (Mathf.Abs (rbody.velocity.x) > Mathf.Abs (rbody.velocity.y)) {
				if (rbody.velocity.x > 0) {
					walkDirection = 2;
				} else {
					walkDirection = 0;
				}
			} else {
				if (rbody.velocity.y > 0) {
					walkDirection = 1;
				} else {
					walkDirection = 3;
				}
			}
			animator.SetInteger ("direction", walkDirection);
		}
	}
}
