using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerTrap5 : MonoBehaviour
{
    
    public float force;
    public Rigidbody stoneBall;

    void Start()
    {
        
    }

    
    void FixedUpdate()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            stoneBall.GetComponent<Rigidbody>().isKinematic = false;
            stoneBall.GetComponent<Rigidbody>().AddForce(force, 0, 0, ForceMode.Impulse);
   
        }
    }
}
