using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerTrap2 : MonoBehaviour
{

    public GameObject spikedBall;
    public GameObject spikedBall2;
    public GameObject spikedBall3;


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
            spikedBall2.GetComponent<Rigidbody>().isKinematic = false;
            spikedBall3.GetComponent<Rigidbody>().isKinematic = false;
        }
    }
}
