Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56NQxPU012175
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:26:59 -0400
Message-ID: <466742C2.5090103@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 19:26:58 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/5] libselinux: rename existing name<->value functions
 for	compat
References: <1181157051.6578.36.camel@sgc.columbia.tresys.com> <46671547.5010604@tycho.nsa.gov> <46673242.1060909@tresys.com>
In-Reply-To: <46673242.1060909@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Eamon Walsh wrote:
>> Christopher J. PeBenito wrote:
>>
>> [snip]
>>
>>> -const char *security_class_to_string(security_class_t tclass)
>>> +static const char *security_class_to_string_compat(security_class_t 
>>> tclass)
>>>  {
>>>      tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
>>>      return class_to_string_data.str + class_to_string[tclass];
>>>  }
>>>  
>> This will have to be rebased to the errno patch r2463 in trunk.  Also, 
>> the behavior should be identical on the new functions (return EINVAL in 
>> the same manner).
>>
>> This patchset should go in prior to the mapping patchset I posted today.
>>
> 
> Has anyone stacked these patches yet to see if they integrate as 
> expected? I assume they will since Chris' patches just change the 
> interfaces that you were using to obtain the kernel values.

For users, the interfaces have to work with the mapped values, so I have 
to go into the new string_to_foo()/foo_to_string() functions and add 
map_foo()/unmap_foo() calls.  Probably the best way to do this would be 
to store the mapped values in the discover_class nodes so that the 
conversions would only be done when selinuxfs is queried.

Also, I just realized that when a mapping is set, the caches have to be 
flushed.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
