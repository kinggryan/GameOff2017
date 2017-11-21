using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class spriteRotator : MonoBehaviour {

public Sprite[] sprite;
private float timer;
public float rndRange;
public float minTime;
private int currentSprite = 0;

private float interval;

	void Awake() {
		RotateSprite();
	}


	void RotateSprite() {
		timer = 0;
		interval = Random.Range(0,rndRange) + minTime;
		int spriteInt = Random.Range(0,2) - 1;
		currentSprite += spriteInt;
		if (currentSprite > sprite.Length)
		{
			currentSprite = 0;
		}
		else if (currentSprite < 0)
		{
			currentSprite = 3;
		}
		GetComponent<SpriteRenderer>().sprite = sprite[currentSprite];
	}
	
	void Update () {
		timer += Time.deltaTime;
		if (timer >= interval)
		{
			RotateSprite();
		}
	}
}
