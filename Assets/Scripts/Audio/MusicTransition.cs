using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicTransition : MonoBehaviour {

	public SoundEvent source;
	public SoundEvent destination;

	public float transitionTime;
	public bool crossfade;
	private bool transition;

	public void ChangeMusic(){
		print("changing music");
		transition = true;
		if (!crossfade){
			source.StopSound();
		}
	}

	

	// Use this for initialization
	void Start () {
		source.externalVolumeModifier = 1;
		destination.externalVolumeModifier = 0;
	}


	
	// Update is called once per frame
	void Update () {

		/*if (Input.GetKeyDown("space")){
            ChangeMusic();
        }*/
		if (transition){
			if (crossfade){
				source.externalVolumeModifier -= Time.deltaTime / transitionTime;
				destination.externalVolumeModifier += Time.deltaTime / transitionTime;
			}
			else {
				if (source.fadeOutTimer <= 0.02f){
					destination.externalVolumeModifier = 1;
					destination.PlaySound();
					transition = false;
				}

			}
			
		}

	}
}
