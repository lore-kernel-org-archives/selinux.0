Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIoFgA029193
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:50:15 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIioBa004936
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:44:51 GMT
Subject: Re: [ libsepol 6/6] Summary
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE71F.40602@tresys.com>
References: <1121968509.9844.47.camel@celtics.boston.redhat.com>
	 <42DFE71F.40602@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:43:12 -0400
Message-Id: <1121971392.9844.79.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Depends on what you are doing. The scope checks to see if symbols being 
> refered to are in scope. In the module language there is an optional 
> command that has a scope different from the global (symbols required for 
> the optional to be activated are added to the active scope).
> 
> For purely monolithic policies it won't have an effect but with modules 
> it must be done to ensure internal consistency in the policy.

I am checking if a context is valid. I don't have the slightest idea
where the context came from - whether it's from a module language,
or policy language, or any kind of language at all, as opposed
to some database. 

>From what you're saying, it sounds like this scope stuff would only go
into checkpolicy & co, not in any of the libsepol code.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
