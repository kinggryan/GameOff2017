using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

[System.Serializable]
public class EventAndName {
	public string name;
	public SoundEvent soundEvent;
}

public class SoundEngine : MonoBehaviour {

	public EventAndName[] events;
    

	public void PlaySoundWithName(string name) {
		print("Picking sound");
		var playedSound = false;
		foreach (var eventAndName in events) {
			if (eventAndName.name == name) {
				eventAndName.soundEvent.PlaySound ();
				playedSound = true;
			}
		}

		// Debugging thing
		if (!playedSound) {
			Debug.LogError("Couldn't find sound for name: " + name);
		}
	}
}
