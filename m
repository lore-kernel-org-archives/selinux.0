Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIO8gA028774
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:24:09 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIJVrg001453
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:19:31 GMT
Message-ID: <42DFE71F.40602@tresys.com>
Date: Thu, 21 Jul 2005 14:19:11 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 6/6] Summary
References: <1121968509.9844.47.camel@celtics.boston.redhat.com>
In-Reply-To: <1121968509.9844.47.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>There is no 6/6.. i started counting at 0.
>Just wanted to mention some things:
>  
>
meh.

>- Note that no new functions are exposed
>via the shared interface, following the plan
>to make this library static.
>
>- Hopefully internal data structures can
>eventually be removed from headers, and
>we can rely on external data structures.
>
>  
>
probably not, there isn't really a need to add a layer of abstraction 
between checkpolicy and libsepol as checkpolicy is very tied to the 
policydb structure.

>- If you have complaints about the API,
>please let me know, and I'll fix it - I
>received no comments on my users patch
>when I posted it last time, so I followed
>the same approach.
>
>- Checkpolicy code should be routed to those new
>functions, and so should libsemanage.
>
>- I haven't put in a scope check (is_id_in_scope),
>which checkpolicy currently does -
>I didn't understand quite how that works. 
>If it is necessary, please let me know.
>
>  
>
Depends on what you are doing. The scope checks to see if symbols being 
refered to are in scope. In the module language there is an optional 
command that has a scope different from the global (symbols required for 
the optional to be activated are added to the active scope).

For purely monolithic policies it won't have an effect but with modules 
it must be done to ensure internal consistency in the policy.

>- manpages still need to be written
>  
>
don't you mean info pages ;)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
