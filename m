Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96FDwUc028337
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:13:58 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96FCi4o001003
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:12:45 GMT
Message-ID: <452672AB.4020309@tresys.com>
Date: Fri, 06 Oct 2006 11:13:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: Re: Networking policy patch
References: <36282A1733C57546BE392885C0618592015CFBBB@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFBBB@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>
>>> +mlsconstrain association { recvfrom }
>>> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
>>> +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>>> +	 ( t1 == mlsnetread ) or
>>> +	 ( t2 == unlabeled_t ));
>>>       
>> Don't we want network_t instead of unlabeled_t?
>>     
>
> Actually, the above only applies to the compat_net case
> and there unlabeled_t is just fine.
>
>   
why isn't compat_net using the same default sid for associations?
> So, there are different MLS constraints (and policy) for
> the compat_net case as opposed to the new secmark controls.
>
>   
there shouldn't be, compat_net and secmark use different object classes 
(except association) and the behaviors should not conflict
> I guess you are planning to have one policy for compat_net
> and another for secmark?
>
>   
I'll let Chris comment here but I don't think that is ideal.
>>> +mlsconstrain association { sendto }
>>> +	(( l1 eq l2 ) and ( h1 eq h2 ));
>>>       
>> or (t2 == network_t) ?
>>     
>
> No. Not in the secmark case.
>   
If there are no ipsec associations at all it will default to 
network_t:SystemHigh-SystemLow so this would only allow domains that are 
SystemHigh-SystemLow to send plaintext? Not sure this is what we want

> <snip>
>>> +constrain association sendto
>>> +	( u1 == u2 and r1 == r2 and t1 == t2 );
>>>       
>> I talked with Joshua and we determined that there is a case were we
>> don't want this constraint (looking forward to policy management
>> server's use of labeled networking), so I've dropped it.
>>     
>
> The above constraint is necessary for the kernel portions of SELinux
> to work properly. In fact I was going to originally implement it in the
> kernel and when Darrel made me aware of the constraint framework and the
> benefits with avc caching, etc., I decided to use it.
>
>   
This completely disallows the use of setsockcreatecon() with labeled 
networking, not good.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
