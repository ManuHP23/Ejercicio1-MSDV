using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerTrap2 : MonoBehaviour
{
    public GameObject spikedBall;
    
    void Start()
    {
        
    }

    
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            spikedBall.GetComponent<Rigidbody>().isKinematic = false;
        }
    }
}
