using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour {

	public GameObject target;

	public float xMax;
	public float xMin;
	public float yMax;
	public float yMin;

	private Transform targetTransform;

	private Transform transform;

	// Use this for initialization
	void Start () {
		targetTransform = target.GetComponent<Transform>();
		transform = GetComponent<Transform>();
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = new Vector3(Mathf.Clamp(targetTransform.position.x, xMin, xMax), Mathf.Clamp(targetTransform.position.y, yMin, yMax), transform.position.z);
	}
}
