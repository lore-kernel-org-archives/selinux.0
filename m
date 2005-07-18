Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IJdvgA001265
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 15:39:58 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IJZklV009267
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 19:35:50 GMT
Message-ID: <42DC0498.7020107@redhat.com>
Date: Mon, 18 Jul 2005 15:35:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Chad Hanson <chanson@TrustedCS.com>, Joshua Brindle <jbrindle@tresys.com>,
   selinux@tycho.nsa.gov
Subject: Re: [RFC] selinux management API
References: <36282A1733C57546BE392885C0618592AF262D@chaos.tcs.tcs-sec.com> <1121711333.9178.1.camel@celtics.boston.redhat.com>
In-Reply-To: <1121711333.9178.1.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>After some discussion about the newly introduced libsemod and the user 
>>>management that Red Hat wants to introduce we've tried to come up with 
>>>an API that all management applications can use, which allow management 
>>>of many components of SELinux policy, including users, booleans states, 
>>>and soon ports. It's written with the expectation to add more managed 
>>>      
>>>
>>Are nodes and interfaces on this list as well? These are very necessary
>>IMHO.
>>    
>>
>
>Can you give a usage scenario... 
>
>Joshua, will you be renaming libsemod to libsemanage soon?
>
>  
>
I belieive the way to make this work from the users perspective is via 
iptables.  I am not sure if iptables would talk
directly to the kernel or would use libsemanage to rewrite rules.

So you could say something like
iptables allow named_t to listen on eth0
iptables allow mail to write on eth1

>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
