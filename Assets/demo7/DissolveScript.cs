using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DissolveScript : MonoBehaviour {

    public Material dissolveMat;
    public float speed, max;
    private float currentY, startTime;

    private void Update()
    {
        //If  this is during the animtion
        if(currentY < max)
        {
            dissolveMat.SetFloat("_DissolveY",currentY);
            currentY += Time.deltaTime * speed;

        }

        if(Input.GetKeyDown(KeyCode.A))
        {
            TriggerEffect();   
        }
    }

    private void TriggerEffect()
    {
        startTime = Time.time;
        currentY = 0;

    }
}
