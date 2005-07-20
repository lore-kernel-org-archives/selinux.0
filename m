Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KIuPgA019613
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 14:56:25 -0400 (EDT)
Received: from palrel10.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KIpvDg000941
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 18:51:57 GMT
Message-ID: <42DE9D3B.7020504@hp.com>
Date: Wed, 20 Jul 2005 14:51:39 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Jonathan Kim <jkim@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Chad Hanson <chanson@TrustedCS.com>,
   selinux@tycho.nsa.gov
Subject: Re: init running at s9 by default on a MLS system?
References: <36282A1733C57546BE392885C0618592AF290B@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592AF290B@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jonathan Kim wrote:
> Yes the line is updated originally by TCS and wrapped with mls_policy
> tunable later. 
> 
> I applied current Dan Walsh's selinux-policy-mls-1.25.2-5 on on Fedora
> Rawhide to FC4 and I see the init process is running correctly at
> s0-s9:c0.c127.
> 

I am running version 1.25.2-5 of Dan's MLS policy RPM and looking at the 
source version of the policy RPM I see the range_transition line and if 
I recompile the policy the line is present in the policy.conf file.

However, if I reboot the machine using either the policy that I have 
recompiled or Dan's original policy it appears that init is running in 
system_u:system_r:init_t:s9:c0.c127 not s0-s9:c0.c127.

Am I missing something?

> 
>>-----Original Message-----
>>From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>>Sent: Tuesday, July 19, 2005 1:58 PM
>>To: Chad Hanson
>>Cc: Paul Moore; selinux@tycho.nsa.gov
>>Subject: Re: init running at s9 by default on a MLS system?
>>
>>
>>Chad Hanson wrote:
>>
>>
>>>>How do you specify in policy that kernel_t transitions to 
>>>>init_t but at 
>>>>level s0?
>>>>
>>>>   
>>>>
>>>
>>>Like as follows:
>>>
>>># run init_t at OS_LO-OS_HI
>>>range_transition kernel_t init_exec_t s0 - s9:c0.c127;
>>>
>>>-Chad
>>> 
>>>
>>
>>That line is already in policy.
>>
>>-- 
>>
>>
>>
>>--
>>This message was distributed to subscribers of the selinux 
>>mailing list.
>>If you no longer wish to subscribe, send mail to 
>>majordomo@tycho.nsa.gov with
>>the words "unsubscribe selinux" without quotes as the message.
>>
> 
> 


-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
