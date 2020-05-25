using UnityEngine;

public class EndTrigger : MonoBehaviour
{
    public GameManager gameManager;

    public AudioSource ohYeahSound;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            gameManager.CompleteLevel();

            ohYeahSound.Play();


        }
    }
}
