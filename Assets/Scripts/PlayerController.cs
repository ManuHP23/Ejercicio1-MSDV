using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{

    public float moveSpeed;
    public float jumpForce;
    public CharacterController controller;
    
    private Vector3 moveDirection;
    public float gravityScale;

    //referencia al animator
    public Animator anim;

    //referencia al pivote para que el personaje encare la dirección del pivote
    public Transform pivot;
    //y cuanto de rapido es este movimiento
    public float rotateSpeed;

    //para la rotación del character
    public GameObject playerModel;

    void Start()
    {
        controller = GetComponent<CharacterController>();
    }
    //LateUpdate para asegurarnos de que la cámara se mueve después de mover al player.
    void LateUpdate()
    {
            //el player avanza según la dirección que le demos con la vista
            //moveDirection = new Vector3(Input.GetAxis("Horizontal") * moveSpeed, moveDirection.y, Input.GetAxis("Vertical") * moveSpeed);
            float yStore = moveDirection.y;
            moveDirection = (transform.forward * Input.GetAxis("Vertical")) + (transform.right * Input.GetAxis("Horizontal"));
            //controlar la velocidad al pulsar ambas direcciones a la vez (normalizar el vector)
            moveDirection = moveDirection.normalized * moveSpeed;
            moveDirection.y = yStore;
        
            if (controller.isGrounded)
            {
                moveDirection.y = 0f;
            
                if (Input.GetButtonDown("Jump"))
                {
                    moveDirection.y = jumpForce;
                }
            }
        
        moveDirection.y = moveDirection.y + (Physics.gravity.y * gravityScale * Time.deltaTime);
        controller.Move(moveDirection * Time.deltaTime);

        //mover el player en diferentes direcciones según la dirección de la cámara
        if (Input.GetAxis("Horizontal") != 0 || Input.GetAxis("Vertical") != 0)  
        {
            transform.rotation = Quaternion.Euler(0f, pivot.rotation.eulerAngles.y, 0f);
            Quaternion newRotation = Quaternion.LookRotation(new Vector3(moveDirection.x, 0f, moveDirection.z));
            //Slerp se usa en unity para interpolar vectores no de forma lineal (lerp) sino esférica
            //para mayor suavidad en la rotación
            playerModel.transform.rotation = Quaternion.Slerp(playerModel.transform.rotation, newRotation, rotateSpeed * Time.deltaTime);
        }


        anim.SetBool("isGrounded", controller.isGrounded);
        anim.SetFloat("Speed", (Mathf.Abs(Input.GetAxis("Vertical")) + Mathf.Abs(Input.GetAxis("Horizontal"))));
        
       
    }

   
}
