using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundEvent : MonoBehaviour {


public bool loop;
public bool random;
public bool playOnAwake;
[Range(0.0f, 1.0f)]
public float volume;
[Range(-12.0f, 12.0f)]
public float pitch;
[Range(-12.0f, 12.0f)]
public float pitchRandomization;
public AudioClip[] audioClip;
    
private int clip = 0;
private int randomClip;
private float actualPitch;
public Transform listener;
public bool threeDee;
public float threeDeeMultiplier = 1;
public float panMultiplier;
public float externalVolumeModifier = 1;
public float externalPitchModifier = 0;
private AudioSource audioSource;
    
public float playerDistance;
public float playerXDistance;
public float playerYDistance;
private Transform transform;
    
private bool soundPlayed = false;
    
    
    public void PlaySound ()
    {
        AudioSource source = gameObject.AddComponent<AudioSource>();
        soundPlayed = true;
        if (random)
        {
            randomClip = Random.Range(0, audioClip.Length);
            checkIfSameAsLast(clip, randomClip);
            source.clip = audioClip[randomClip];
            clip = randomClip;

        }
        else
        {
            clip += 1;
            if (clip >= audioClip.Length)
            {
                clip = 0;
            }
            source.clip = audioClip[clip];
        }
        actualPitch = pitch + externalPitchModifier + Random.Range(-pitchRandomization, pitchRandomization);
        source.pitch = Mathf.Pow(1.05946f, actualPitch);
        source.loop = loop;
        source.volume = volume * externalVolumeModifier;
        audioSource = source;

        source.Play();
        print("Sound Played");
        if (!loop)
        {
            Destroy(source, audioClip[clip].length);
            print("Destroyed");
        }

    }
    
    void checkIfSameAsLast(int last, int current)
    {
        if (last == current)
        {
            randomClip = Random.Range(0, audioClip.Length);
            checkIfSameAsLast(last, randomClip);
        }
    }
    
    void Start ()
    {
        transform = gameObject.GetComponent<Transform>();
        if (playOnAwake)
        {
            PlaySound();
        }
    }
    
    void Update()
    {
        
        
        playerXDistance = transform.position.x - listener.position.x;
        playerYDistance = transform.position.y - listener.position.y;
        if (Mathf.Abs(playerXDistance) >= Mathf.Abs(playerYDistance))
        {
            playerDistance = Mathf.Abs(playerXDistance);
        }
        else
        {
            playerDistance = Mathf.Abs(playerYDistance);
        }
        
        
        float threeDeeVolume = 1 / (playerDistance * threeDeeMultiplier);
        
        if (soundPlayed)
        {
            if (threeDee)
            {
                audioSource.volume = Mathf.Clamp(volume * threeDeeVolume, 0, volume);
                audioSource.panStereo = Mathf.Clamp((playerXDistance - playerYDistance) * panMultiplier, -1, 1);
            }
            else if (loop)
            {
                 audioSource.volume = volume * externalVolumeModifier;
            }
            else
            {

            }
        }
    }
    
}
