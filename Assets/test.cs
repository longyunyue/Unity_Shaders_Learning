using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour {
    
    private bool signal_1=true;
	// Use this for initialization
	void Start () {
        StartCoroutine(wait());
	}
	
	// Update is called once per frame
	void Update () {
        //if (signal_1)
        //{
        //    this.GetComponent<Animation>().Play();
        //    signal_1 = false;

        //}

            
	}

    IEnumerator wait()
    {
        yield return new WaitForSeconds(5);
        this.GetComponent<Animator>().runtimeAnimatorController = Instantiate(Resources.Load("cube2")) as RuntimeAnimatorController;
    }

}
