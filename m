Message-ID: <44CB7CB0.7000201@tresys.com>
Date: Sat, 29 Jul 2006 11:20:16 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Jeremy A. Mowery" <jmowery@tresys.com>
Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
References: <6FE441CD9F0C0C479F2D88F959B0158832A937@exchange.columbia.tresys.com> <44C91F31.1070103@mentalrootkit.com>
In-Reply-To: <44C91F31.1070103@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Joshua Brindle wrote:
>>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
>>> Joshua Brindle wrote:
>>>    
>>>> @@ -366,6 +366,7 @@
>>>>     uint32_t policy_type;
>>>>     char *name;
>>>>     char *version;
>>>> +    int invalid;
>>>>
>>>>       
>>> Expanding the avrules doesn't really make the policydb invalid, 
>>> right? It jubt makes it non-standard (tainted :) )
>>>
>>>     
>>
>> Putting neverallows in the avtab is invalid (the reader will bail if it
>> tries to read one)
>>
>>   
> 
> I disagree - the policydb is still valid, otherwise there would be no 
> point doing analysis on it. I think the more correct semantic is that 
> this policydb cannot be represented by the on disc format. So the 
> variable would be better called something like 
> policydb->unsupported_format.
> 
> Wait, just because the neverallows are expanded doesn't mean that the 
> unexpanded aren't also there, meaning that the policydb could be written 
> to disc with no loss of information. This reinforces my notion that the 
> policy is valid. Why not just skip saving the neverallows in the format 
> and document the behavior?
> 


Ok, after talking to karl about this offline the basic sentiment is that 
extra work would have to be done to support writing a policy with 
expanded neverallows (namely recalulating the avtab number of elements) 
which is extra work for something that really shouldn't be happening 
anyway. He believes that "invalid" is too strong and suggests that the 
policydb is totally bogus. While this is a matter for interpretation 
what he suggested above (p->unsupported_format) might be better.

>>>>     }
>>>> @@ -2156,7 +2159,7 @@
>>>>         goto cleanup;
>>>>     hashtab_map_remove_on_error(state.out->p_types.table,
>>>>                     type_attr_remove, type_destroy, state.out);
>>>> -    if (check) {
>>>> +    if (check && !(out->invalid)) {
>>>>         if (hierarchy_check_constraints(handle, state.out))
>>>>             goto cleanup;
>>>>
>>>>       
>>> Why disallow hierarchy checking?
>>>     
>>
>> It disables all checking for invalid policies, there is no reason to do
>> checking if you've marked a policy invalid since it can't be written
>> anyway 
> 
> 1) The policy is still valid.
> 2) If this is for analysis I would imagine you would want the 
> neverallows and _also_ know if the policy violates hierarchy constraints.
> 3) It is surprising since the caller explicitly requests both the 
> checking and the expansion. If these parameters really are exclusive an 
> error should be raised rather than silently not performing the action.

I guess I can see this, I doubt that someone who requests an 
unsupported_format would also request checking so the explicit check is 
not necessary.

> 
>> (invalid will probably mean other things in the future, such as a
>> policy with disabled rules expanded out and conflicting type transitions
>> in the avtab for access control checking).
>>
>>  
>>>> Index: trunk/libsepol/src/write.c
>>>> ===================================================================
>>>> --- trunk/libsepol/src/write.c    (revision 951)
>>>> +++ trunk/libsepol/src/write.c    (working copy)
>>>> @@ -1411,6 +1411,9 @@
>>>>     struct policy_data pd;
>>>>     char *policydb_str;
>>>>
>>>> +    if (p->invalid)
>>>> +        return -1;
>>>> +
>>>>       
>>> A separate return code is needed so that the caller can distinguish 
>>> between general, likely fatal errors and a policydb that can't be 
>>> written because the format doesn't support it.
>>>

Ok, can add.

>>>     
>>
>> -2? ;)
>>
>> -1 is currently used if, for example, policy->policyvers is invalid,
>> same deal.. These are programming errors not user errors. I'd be fine
>> with it being an assert() personally.
>>   
> 
> See above - I think that the write should just work and ignore the 
> expanded neverallows.
> 

more work for no benefit, we can make this unsupported since it probably 
won't be written anyway

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
