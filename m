Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA72kYuW026930
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 21:46:34 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA72kV1s012721
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 02:46:32 GMT
Message-ID: <4731275E.6060606@ak.jp.nec.com>
Date: Wed, 07 Nov 2007 11:47:58 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: Re: security context for SPD entries of labeled IPsec
References: <D709A20F2164C84E8B7014B0301F5EF87C71DD@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF87C71DD@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> KaiGai Kohei wrote:
>>> We have to set up several SPD entries with a security context
>>> to apply labeled IPsec, like as:
>>>
>>>   spdadd 192.168.1.10 192.168.1.20 any
>>>   -ctx 1 1 "system_u:object_r:unconfined_t:s0"
>>>   -P in ipsec esp/transport//require;
>>>
>>> What is the most appropriate context to be specified?
> 
> First of all, you don't have one SPD rule for each domain. You
> would typically have one SPD rule labeled with ipsec_spd_t,
> for example and have all the domains that need to use that
> SPD rule to perform labeled IPsec communication to have
> association.polmatch access to ipsec_spd_t. So, the policy defines
> one context ipsec_spd_t that you can use for all your SPD rules,
> unless you need to distinguish between different SPD rules based
> on the label, in which case you can have more than one specified
> for the same host pair and have different domains polmatch'ing
> to the appropriate rules so the corresponding IPSec policy is
> enforced.

Thanks, your explanation makes me clear to understand.
Because I tried to read an intention of the author from the security
policy, I got a confusion.

> Joshua Brindle has an article including labeled-ipsec at:
> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

I saw, it is a good summary.

>>> Or, is the security policy to be modified?
>>>
>>> In the current reference policy, several domain have permissions
>>> of association class for 'self' or 'unlabeled_t'.
>>> However, it can cause a matter when 'unconfined_t' processes tries
>>> to connect 'postgresql_t' process running on another host 
>> via labeled
>>> IPsec, for instance.
> 
> There are 2 aspects:
> 
> 1. IPsec policy matching discussed above:
>    allow domain-that-should-use-labeled-ipsec ipsec_spd_t:association { polmatch };
> 
> 2. Use of IPsec associations themselves:
> 
>    For sending:
>    allow domain-that-should-use-labeled-ipsec-to-label-its-packets self:association { sendto };
> 
>    For receiving:
>    allow domain-that-should-received-from-peer  peer-domain self:association { recvfrom };

When we consider the case unconfined_t process tries to communicate with a postgresql_t
process running on another host via labeled IPsec, the following policy will be needed.

1.  allow unconfined_t ipsec_spd_t : association { polmatch };
2s. allow unconfined_t self : association { sendto };
2r. allow postgresql_t unconfined_t : association { recvfrom };

Is it correct?

The current security policy defines (2s) rule, but (1) and (2r) are not defined.

Chris, could you give us your opinion?
I think (1) should be added to "unconfined_domain_noaudit" in system/unconfined.if,
and an interface to provide (2r) should be added to somewhere.

>>> We can add additional permissions to avoid the matter, as follows:
>>>   allow postgresql_t unconfined_t : association { ... };
>>>
>>> But IMO it makes a bit confusable to apply process's domain as
>>> a type of SPD entries, like unconfined_t and so on.
> 
> Definitely so, which is the reason there's ipsec_spd_t defined in the policy
> to be used for all SPD rules that should perform labeled IPsec.

OK, I understood.

>>> I prefer the following description to separate subject and object.
>>>   allow postgresql_t postgresql_spd_t : association { ... };
>>>   allow unconfined_t postgresql_spd_t : association { ... };
>> In policy/modules/system/ipsec.te, ipsec_spd_t is defined as a default
>> type for IPSEC SPD entries, as follows:
>>
>>   # Default type for IPSEC SPD entries
>>   type ipsec_spd_t;
>>       :
>>   allow racoon_t ipsec_spd_t:association setcontext;
>>       :
>>   allow setkey_t ipsec_spd_t:association setcontext;
>>       :
>>
>> However, setkey_t and racoon_t are the all which have any permission
>> on ipsec_spd_t.
>> Is it more preferable than applying a domain as a type of SPD entries?
> 
> Yes. Hope the above helps.
> 
>> Thanks,
>>
>>> Is there any reason why SPD entries have same type with domains?
>>>
>>> Thanks,
>> -- 
>> OSS Platform Development Division, NEC
>> KaiGai Kohei <kaigai@ak.jp.nec.com>
>>
>> --
>> This message was distributed to subscribers of the selinux 
>> mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
