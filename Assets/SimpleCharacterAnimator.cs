using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleCharacterAnimator : MonoBehaviour 
{

	public bool static_b;
	public float speed;
	public int AnimationNumber;
	public int WeaponNumber;
	private Animator animator;

	private void Start()
	{
		animator = GetComponent<Animator>();
	}

	void Update () 
	{
		animator.SetInteger( "Animation_int", AnimationNumber);
		animator.SetInteger("WeaponType_int", WeaponNumber);
		animator.SetBool("Static_b", static_b);
		animator.SetFloat("Speed_f", speed);

	}
}
