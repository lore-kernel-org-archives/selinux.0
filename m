Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LItMgA029270
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:55:22 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LInwBa006051
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:49:58 GMT
Message-ID: <42DFEE73.5030402@tresys.com>
Date: Thu, 21 Jul 2005 14:50:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 6/6] Summary
References: <1121968509.9844.47.camel@celtics.boston.redhat.com>	<42DFE71F.40602@tresys.com> <1121971392.9844.79.camel@celtics.boston.redhat.com>
In-Reply-To: <1121971392.9844.79.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>Depends on what you are doing. The scope checks to see if symbols being 
>>refered to are in scope. In the module language there is an optional 
>>command that has a scope different from the global (symbols required for 
>>the optional to be activated are added to the active scope).
>>
>>For purely monolithic policies it won't have an effect but with modules 
>>it must be done to ensure internal consistency in the policy.
>>    
>>
>
>I am checking if a context is valid. I don't have the slightest idea
>where the context came from - whether it's from a module language,
>or policy language, or any kind of language at all, as opposed
>to some database. 
>
>  
>
right, but the policydb format can include scoping information so 
therefore you should check it, but only if it's a non-expanded policy.

>>From what you're saying, it sounds like this scope stuff would only go
>into checkpolicy & co, not in any of the libsepol code.
>  
>
No, the scope is preserved in the module format so anything that works 
with modules will need to handle it. I'll have to think about the best 
place to add users into the policy, post-link or post-expand and that 
will really determine whether you need to worry about this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
