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
	public float fadeInTime;
	private float fadeInTimer = 0;
	private bool fadeIn = false;
	public float fadeOutTime;
	public float fadeOutTimer = 1;
	private bool fadeOut = false;

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
	    
	private float playerDistance;
	private float playerXDistance;
	private float playerYDistance;
	private Transform transform;

	private List<AudioSource> sourceList;
	    
	private bool soundPlayed = false;
    
    
    public void PlaySound ()
    {
        AudioSource source = gameObject.AddComponent<AudioSource>();
        soundPlayed = true;
        if(fadeInTime > 0){
            fadeIn = true;
            source.volume = 0;
        }
        else {
            source.volume = volume * externalVolumeModifier;
        }
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
        
        audioSource = source;

        source.Play();
        print("Sound Played");
        if (!loop)
        {
            Destroy(source, audioClip[clip].length);
            print("Destroyed");
        }
        else {
            sourceList.Add(source);
        }
    }

    public void StopSound(){
        if(fadeOutTime > 0){
            fadeOut = true;
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
        sourceList = new List<AudioSource>();
        if (playOnAwake)
        {
            PlaySound();
        }
    }
    
    void Update()
    {
        

        if (fadeIn){
                fadeInTimer += Time.deltaTime / fadeInTime;
                //print("fadeInTimer: " + fadeInTimer);
            if (fadeInTimer >= 1)
            {
                print("Fade done");
                fadeInTimer = 0;
                fadeIn = false;
            }
        }
        else if (fadeOut){
                fadeOutTimer -= Time.deltaTime / fadeInTime;
                //print("fadeOutTimer: " + fadeOutTimer);
            if (fadeOutTimer <= 0)
            {
                print("Fade done");
                fadeOutTimer = 1;
                soundPlayed = false;
                Destroy(audioSource);
                fadeOut = false;
            }
        }
        
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
            else if (threeDee && fadeIn)
            {
                audioSource.volume = Mathf.Clamp(volume * threeDeeVolume * fadeInTimer, 0, volume);
                audioSource.panStereo = Mathf.Clamp((playerXDistance - playerYDistance) * panMultiplier, -1, 1);
            }
            else if (threeDee && fadeOut)
            {
                audioSource.volume = Mathf.Clamp(volume * threeDeeVolume * fadeInTimer, 0, volume);
                audioSource.panStereo = Mathf.Clamp((playerXDistance - playerYDistance) * panMultiplier, -1, 1);
            }
            else if (fadeIn)
            {
                audioSource.volume = volume * externalVolumeModifier * fadeInTimer;
            }
            else if (fadeOut)
            {
                audioSource.volume = volume * externalVolumeModifier * fadeOutTimer;
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
