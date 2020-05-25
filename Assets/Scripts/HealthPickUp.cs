using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthPickUp : MonoBehaviour
{
    public int healAmount;
    
    void Start()
    {
        
    }

    
    void Update()
    {
        
    }

    private void OnTriggerEnter (Collider other)
    {
        if (other.tag =="Player")
        {

            FindObjectOfType<HealthManager>().HealPlayer(healAmount);
            
            Destroy(gameObject);

        }
    }
}
