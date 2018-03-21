using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour {

    public float inputDelay = 0.1f;
    public float moveVel = 5f;

    float moveInputZ;
    float moveInputX;

    Rigidbody rBody;

	// Use this for initialization
	void Start () {
        if (GetComponent<Rigidbody>())
            rBody = GetComponent<Rigidbody>();
        else
            Debug.LogError(("need RigidBody"));
        moveInputZ=moveInputX = 0f;

        
	}
	
	// Update is called once per frame
	void Update () {
        GetInput();
	}

    private void FixedUpdate()
    {
        Move();
    }

    void GetInput()
    {
        moveInputZ = Input.GetAxis("Horizontal");
        moveInputX = Input.GetAxis("Vertical");
    }

    void Move()
    {
        if(Mathf.Abs(moveInputZ) > inputDelay)
        {
            //move
            rBody.velocity = new Vector3(1f, 0f, 0f) * moveInputZ * moveVel;
            Debug.Log(rBody.velocity);
        }
       

        else if (Mathf.Abs(moveInputX) > inputDelay)
        {
            //move
            rBody.velocity = transform.forward * moveInputX * moveVel;
            Debug.Log(rBody.velocity);
        }
        else
        {
            //zero vel
            rBody.velocity = Vector3.zero;
        }

    }
}
