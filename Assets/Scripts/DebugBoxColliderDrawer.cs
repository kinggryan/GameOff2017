using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class DebugBoxColliderDrawer : MonoBehaviour {

	BoxCollider2D box;
	Vector2 point1;
	Vector2 point2;
	Vector2 point3;
	Vector3 point4;

	// Use this for initialization
	void Start () {
		box = GetComponent<BoxCollider2D> ();

		point1 = transform.TransformPoint (box.offset + 0.5f*Vector2.right*box.size.x + 0.5f*Vector2.up*box.size.y);
		point2 = transform.TransformPoint (box.offset + 0.5f*Vector2.right*box.size.x + 0.5f*Vector2.down*box.size.y);
		point3 = transform.TransformPoint (box.offset + 0.5f*Vector2.left*box.size.x + 0.5f*Vector2.down*box.size.y);
		point4 = transform.TransformPoint (box.offset + 0.5f*Vector2.left*box.size.x + 0.5f*Vector2.up*box.size.y);
	}

	// Update is called once per frame
	void Update () {
		Debug.DrawLine (point1, point2, Color.black);
		Debug.DrawLine (point2, point3, Color.black);
		Debug.DrawLine (point3, point4, Color.black);
		Debug.DrawLine (point4, point1, Color.black);
	}
}
