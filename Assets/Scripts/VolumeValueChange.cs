using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class VolumeValueChange : MonoBehaviour
{
    //referencia al componente de audio
    private AudioSource audioSrc;

    //el valor del columen de musica se modifica con el slider
    private float musicVolume = 1f;

    void Start ()
    {
        //asignamos el componente audiosource para controlarlo
        audioSrc = GetComponent<AudioSource>();
    }

    private void Update()
    {
        //se establece que el valor de la opción de volumen debe ser igual al volumen de la música
        audioSrc.volume = musicVolume;
    }

    //método llamado por el slider
    //toma un valor de volumen pasado por el slider
    //y lo establece como valor del volumen

    public void SetVolume (float vol)
    {
        musicVolume = vol;
    }


}
