Message-ID: <526800C8.5050306@tycho.nsa.gov>
Date: Wed, 23 Oct 2013 13:00:56 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>
CC: Dominick Grift <dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382541329.3041.88.camel@d30> <5267F222.5010606@tycho.nsa.gov>
In-Reply-To: <5267F222.5010606@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/23/2013 11:58 AM, James Carter wrote:
> On 10/23/2013 11:15 AM, Dominick Grift wrote:
>> On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
>>> I pushed an update of CIL to bitbucket.
>>
>> I noticed that cilpolicy does not have refpolicies
>> "selinux_labeled_boolean" interface
>>
>
> This interface causes many problems.
>
> First, when trying to convert Refpolicy to CIL, the conversion program tries to
> infer parameter types (language types, not SELinux types). This interface causes
> an error because the parameter which is the boolean name is used as both a
> string and a boolean.
>
> Second, the conversion program can't recognize general string concatenation
> (although it does specifically handle type mangling).
>
> Third, CIL does not allow conversion from one language type to another.
>
> Fourth, CIL does not have the ability to concatenate strings.
>
> All of these problems could probably be worked around, but I would prefer not to
> have general string concatenation and language type conversions in CIL.
>
> This is a perfect example of something that a higher-level language could
> provide. Although that doesn't help you now.
>
>> I tried to implement it myself but i cannot get it to parse ARG2 no
>> matter what i try
>>
>> This is what i currently have:
>>
>> macro:
>>
>>> ; Associate the specified type and name with booleans
>>>
>>> (macro selinux_labeled_boolean ((type ARG1) (name ARG2))
>>>    (call selinux_boolean_type (ARG1))
>>>    (genfscon "selinuxfs" ARG2 (system_u object_r ARG1 ((s0)
>>>              (s0)))))
>>
>> call:
>>
>>> (type secure_mode_insmod_t)
>>> (call selinux_labeled_boolean (secure_mode_insmod_t
>>>               "/booleans/secure_mode_insmod"))
>>
>> result:
>>
>>> # seinfo --genfscon | grep secure_mode_insmod
>>>     genfscon selinuxfs ARG2      system_u:object_r:secure_mode_insmod_t
>>
>> Is there a work around for this?
>>
>
> Sorry, there is not.
>
>> I realize that the nature of cil make these kind of things less useful
>> but it would have been nice if it worked
>>

I am sorry. I got so caught up in the painful memories of having to deal with 
the selinux_labeled_boolean interface that I missed what you were actually 
trying to do.

What you want to do here is quite reasonable and we should make it possible in CIL.

Thanks again for the feedback.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
