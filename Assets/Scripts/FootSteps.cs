using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FootSteps : MonoBehaviour
{
    public AudioSource audioSteps;
    public CharacterController cc;

    void Start()
    {
        cc = GetComponent<CharacterController>();
    }

    
    void Update()
    {
        if (cc.isGrounded == true && cc.velocity.magnitude < 0.1f)
        {
            audioSteps.Play();
        }
    }
}
