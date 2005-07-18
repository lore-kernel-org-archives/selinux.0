Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IIZSgA000660
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 14:35:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IIVKlV002682
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 18:31:21 GMT
Subject: RE: [RFC] selinux management API
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592AF262D@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592AF262D@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 14:28:52 -0400
Message-Id: <1121711333.9178.1.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > After some discussion about the newly introduced libsemod and the user 
> > management that Red Hat wants to introduce we've tried to come up with 
> > an API that all management applications can use, which allow management 
> > of many components of SELinux policy, including users, booleans states, 
> > and soon ports. It's written with the expectation to add more managed 
> 
> Are nodes and interfaces on this list as well? These are very necessary
> IMHO.

Can you give a usage scenario... 

Joshua, will you be renaming libsemod to libsemanage soon?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
