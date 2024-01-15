using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class NewBehaviourScript : MonoBehaviour
{
    private void Update()
    {
        GetComponent<Image>().material.SetFloat("_Wide", GetComponent<RectTransform>().sizeDelta.x);
        GetComponent<Image>().material.SetFloat("_Hight", GetComponent<RectTransform>().sizeDelta.x);
    }
}
