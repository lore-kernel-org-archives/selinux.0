Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LAP6gA024362
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 06:25:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LAKXrg022286
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:20:33 GMT
Subject: RE: [RFC] selinux management API
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592AF27EE@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592AF27EE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 06:22:31 -0400
Message-Id: <1121941351.19340.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I believe we're discussing the same thing, from different points 
of view, and a solution can be designed that fits everyone's needs.

> > But I don't like the idea of Admins modifying policy in order to 
> > customize their system.  This is what we
> > are trying to get away from.   

Dan's concern is from usability point of view.
The policy source is not a good way for a sysadmin
to modify security restrictions. It is better suited
for specifying static parts of policy, shipped by
the vendor, which require rich language to
properly describe..

I'm not sure setools are an acceptable replacement 
either. There are existing tools and systems,
which we could integrate with. From our discussions at Red Hat, 
I understand that Dan wants iptables to be used as a frontend
to configuring certain parts of policy. He also
wants to hide the interface security context from the user.
I can only assume that he wants the port context hidden too.
On the other hand he'd like to be able to specify the
source context (application context) and match against it. 

I'm not sure whether all of this is a good idea or not,
(or wheter entirely possible), but it seems clear that 
any policy manipulation should occur through 
libsemanage, and eventually through libsepol.
Any iptables integration (if implemented) would have
to occur via those libaries.

So yes, it seems to me that it would be appropriate
to provide an API for managing network interfaces.
Whether we support changing the context of an interface,
or simply querying it, is an implementation detail.
I started writing some libsepol support with
the query operation today. I've also implemented
query on ports (give sepol a number, or a range,
get back the security context).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
