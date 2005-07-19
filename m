Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JEoegA006861
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 10:50:41 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JEkO3G020692
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:46:25 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF27EE@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>,
   selinux@tycho.nsa.gov
Subject: RE: [RFC] selinux management API
Date: Tue, 19 Jul 2005 10:48:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Tuesday, July 19, 2005 9:09 AM
> To: Chad Hanson
> Cc: gyurdiev@redhat.com; Joshua Brindle; selinux@tycho.nsa.gov
> Subject: Re: [RFC] selinux management API
> 
> >
> But I don't like the idea of Admins modifying policy in order to 
> customize their system.  This is what we
> are trying to get away from.    Try to explain to an administrator that 
> you only want the apache web site to
> be allowed to listen on your intranet side and not on the 
> internet.  I would have a hard time writing policy for

It really could be done be expanding can_network or other macro to take a
value, such as the interface, and restrict the network access to just a
specific interface instead of all interfaces.


> that.   I can imagine it could be fairly easy using iptables type syntax 
> to do it though.
> 
> We (Red Hat) want to get to the point where we eliminate policy-sources 
> and it becomes just policy.src.rpm.  The
> same way we did with kernel-sources.
> 

I agree that this customization is bad. My example could have been better. A
better topic is just talking about the contents of the net_contexts file,
particularly nodes and interfaces.  Currently all of netifcon and nodecon
rules are static. One, this isn't modular and doesn't fall into the category
if not in use remove it, and second if server has four ethernet interface
cards the fourth defaults back to the initial sid instead of policy defined
in net_contexts. The same would hold true for virtual interfaces. Nodes have
a similiar issue. In MLS, the interface and node rules need to be customized
for attaching the desired MLS label (such as unclassified, secret, etc...).
In TE, you can definitely use strict rules to prevent certain types from
transmitting data to interfaces or nodes, possibly this should be an
addition to the mls or strict policy initially. I would think we would want
the ability to configure these objects even if everyone doesn't choose to. I
can guarantee in a guard environment, it would be highly desirable for the
policy to restrict a process to communicate on one interface only.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
