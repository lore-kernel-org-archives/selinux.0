Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IG8xgA029351
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 12:08:59 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IG4rlV018024
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 16:04:53 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF262D@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: RE: [RFC] selinux management API
Date: Mon, 18 Jul 2005 12:06:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Joshua Brindle [mailto:jbrindle@tresys.com]
> Sent: Friday, July 15, 2005 9:47 AM
> To: selinux@tycho.nsa.gov
> Subject: [RFC] selinux management API
> 
> 
> After some discussion about the newly introduced libsemod and the user 
> management that Red Hat wants to introduce we've tried to come up with 
> an API that all management applications can use, which allow management 
> of many components of SELinux policy, including users, booleans states, 
> and soon ports. It's written with the expectation to add more managed 

Are nodes and interfaces on this list as well? These are very necessary
IMHO.

-Chad

> components later, without disturbing the API. We plan on make a new 
> library called libsemanage with this API exported through a shared 
> library and getting rid of libsemod.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
