Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JECNgA006507
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 10:12:23 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JE863G015628
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:08:06 GMT
Message-ID: <42DD0967.5080206@redhat.com>
Date: Tue, 19 Jul 2005 10:08:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>,
   selinux@tycho.nsa.gov
Subject: Re: [RFC] selinux management API
References: <36282A1733C57546BE392885C0618592AF2746@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592AF2746@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:

>A use case and example below.
>
>  
>
>>-----Original Message-----
>>From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>>Sent: Monday, July 18, 2005 2:36 PM
>>To: gyurdiev@redhat.com
>>Cc: Chad Hanson; Joshua Brindle; selinux@tycho.nsa.gov
>>Subject: Re: [RFC] selinux management API
>>
>>    
>>
>>>>Are nodes and interfaces on this list as well? These are 
>>>>        
>>>>
>>very necessary
>>    
>>
>>>>IMHO.
>>>>   
>>>>
>>>>        
>>>>
>>>Can you give a usage scenario... 
>>>
>>>
>>>      
>>>
>>I belieive the way to make this work from the users 
>>perspective is via iptables.  I am not sure if iptables would talk
>>directly to the kernel or would use libsemanage to rewrite rules.
>>
>>So you could say something like
>>iptables allow named_t to listen on eth0
>>iptables allow mail to write on eth1
>>
>>    
>>
>
>In the current setup you can use the interface and node rules to limit
>traffic, both by TE and MLS. This is especially important in MLS and TE
>separation of networks. I'll show a case for interface rules.
>
>In the current global_macros.te:712 there is the following rule
>
>allow $1 netif_type:netif *;
>
>where netif_type is an attribute on netif_lo_t, netif_eth0_t, netif_eth1_t,
>etc.... 
>
>If you have three interfaces on a machine lo, eth0, eth1, you could prevent
>traffic from unconfined_t to eth1 by changing to the follwing rules:
>
>#allow $1 netif_type:netif *;
>allow $1 netif_lo_t:netif *;
>allow $1 netif_eth0_t:netif *;
>
>In practice MLS and TE systems used for network domain separation you would
>want to assign types and MLS labels to intefaces and nodes (networks) to
>prevent data from going where it shouldn't.  An MLS/TE example is making one
>interface INSIDE and another OUTSIDE. You could then have node rules for
>network descriptions of INSIDE/OUTSIDE.
>
>-Chad
>
>
> 
>  
>
But I don't like the idea of Admins modifying policy in order to 
customize their system.  This is what we
are trying to get away from.    Try to explain to an administrator that 
you only want the apache web site to
be allowed to listen on your intranet side and not on the internet.  I 
would have a hard time writing policy for
that.   I can imagine it could be fairly easy using iptables type syntax 
to do it though.

We (Red Hat) want to get to the point where we eliminate policy-sources 
and it becomes just policy.src.rpm.  The
same way we did with kernel-sources.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
