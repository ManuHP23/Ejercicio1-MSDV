using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Transform target;

    public Vector3 offset;

    public bool useOffsetValues;

    public float rotateSpeed;

    public Transform pivot;

    public float maxViewAngle;
    public float minViewAngle;

    
    void Start()
    {
        if (!useOffsetValues)
        {
            offset = target.position - transform.position;
        }
        //se mueve el pivote a donde se mueve el player
        pivot.transform.position = target.transform.position;
        //he comentado la siguiente linea para que el player rote el pivote según la cámara
        //el efecto será el de correr en varias direcciones en lugar de una sola
        //pivot.transform.parent = target.transform;
        
        //para tener la cámara como posibe prefab en el futuro 
        //no quiero  sacar manualmente el pivote como hijo de la camara desde la interfaz
        pivot.transform.parent = null;

        //bloquear el cursor del centro de la ventana de juego
        Cursor.lockState = CursorLockMode.Locked;
    }
    
    void LateUpdate()
    {
        //rotar el pivote
        pivot.transform.position = target.transform.position;
        
        //obtener la posición X del ratón y rotar el target
        float horizontal = Input.GetAxis("Mouse X") * rotateSpeed;
        pivot.Rotate(0, horizontal, 0);

        //obtener la posición Y del ratón y rotar el pivote
        float vertical = Input.GetAxis("Mouse Y") * rotateSpeed;
        pivot.Rotate(-vertical, 0, 0);

        //para controlar el flip de la cámara cuando el pivote pasa de 90 grados
        //hay que establecer un límite de cuánto la cámara puede subir y bajar
        if (pivot.rotation.eulerAngles.x > maxViewAngle && pivot.rotation.eulerAngles.x < 180f)
        {
            pivot.rotation = Quaternion.Euler(maxViewAngle, 0, 0);
        }

        if (pivot.rotation.eulerAngles.x > 180f && pivot.rotation.eulerAngles.x < 360f + minViewAngle)
        {
            pivot.rotation = Quaternion.Euler(360f + minViewAngle, 0, 0);
        }

        //mover la cámara según la rotación actual del target y el offset original
        float desiredYAngle = pivot.eulerAngles.y;
        float desiredXAngle = pivot.eulerAngles.x;

        Quaternion rotation = Quaternion.Euler(desiredXAngle, desiredYAngle, 0);
        transform.position = target.position - (rotation * offset);
        
        //transform.position = target.position - offset;
        
        //controlar que la cámara no atraviese objetos
        if (transform.position.y < target.position.y)
        {
            transform.position = new Vector3(transform.position.x, target.position.y - 0.5f, transform.position.z);
        }
        
        
        transform.LookAt(target); 
    }
}
