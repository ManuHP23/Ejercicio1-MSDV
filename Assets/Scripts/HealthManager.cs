using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HealthManager : MonoBehaviour
{
    
    public int currentHealth;
    public int maxHealth;

    public Text healthText;

    //respawn del player al perder la vida completa
    public PlayerController thePlayer;
    private bool isRespawning;
    private Vector3 respawnPoint;
    public float respawnLength;

    //efecto pantalla en la muerte del palyer
    //black porque originalmente la pantalla de muerte era negra
    //luego la cambié por una personalizada
    public RawImage blackScreen;
    private bool isFadeToBlack;
    private bool isFadeFromBlack;
    public float fadeSpeed;
    public float waitForFade;

    //barra de salud
    public RawImage healthBar;
    public float maxHealthBar;
    public float currentHealthBar;

    //efectos de sonido
    public AudioSource hamSound;
    public AudioSource hurtSound;
    
    void Start()
    {
        currentHealth = maxHealth;
        healthText.text = "Health: " + currentHealth;

        //thePlayer = FindObjectOfType<PlayerController>();

        respawnPoint = thePlayer.transform.position;

        maxHealthBar = (maxHealth * 0.184f);
        currentHealthBar = (currentHealth * 0.184f);
    }

    
    void Update()
    {
        healthText.text = "Health: " + currentHealth;

        if (isFadeToBlack)
        {
            blackScreen.color = new Color(blackScreen.color.r, blackScreen.color.g, blackScreen.color.b, Mathf.MoveTowards(blackScreen.color.a, 1f, fadeSpeed * Time.deltaTime));
            if (blackScreen.color.a == 1f)
            {
                isFadeToBlack = false;
            }
        }

        if (isFadeFromBlack)
        {
            blackScreen.color = new Color(blackScreen.color.r, blackScreen.color.g, blackScreen.color.b, Mathf.MoveTowards(blackScreen.color.a, 0f, fadeSpeed * Time.deltaTime));
            if (blackScreen.color.a == 0f)
            {
                isFadeFromBlack = false;
            }
        }

        //healthbar

        healthBar.GetComponent<RawImage>().rectTransform.localScale = new Vector3(currentHealthBar, 1, 1);

        if (currentHealthBar <= 0)
        {
            currentHealthBar = maxHealthBar;
        }

        if (currentHealthBar > maxHealthBar)
        {
            currentHealthBar = maxHealthBar;
        }

    }

    public void HurtPlayer(int damage)
    {
        
        currentHealth -= damage;
        currentHealthBar -= 0.184f;

        if (currentHealth <= 0)
        {
            Respawn();
        }

        hurtSound.Play();
    }

    public void Respawn()
    {
        thePlayer.transform.position = respawnPoint;
        currentHealth = maxHealth;
        if (!isRespawning)
        {
            StartCoroutine("RespawnCo");
        }
    }

    public IEnumerator RespawnCo()
    {
        
        isRespawning = true;
        thePlayer.gameObject.SetActive(false);

        yield return new WaitForSeconds(respawnLength);

        isFadeToBlack = true;

        yield return new WaitForSeconds(waitForFade);

        isFadeFromBlack = true;
        
        isRespawning = false;
       

        thePlayer.gameObject.SetActive(true);
        thePlayer.transform.position = respawnPoint;
        currentHealth = maxHealth;
    }

    public void HealPlayer(int healAmount)
    {
        currentHealth += healAmount;
        currentHealthBar += 0.184f;

        if (currentHealth > maxHealth)
        {
            currentHealth = maxHealth;
        }

        hamSound.Play();
    }
}
