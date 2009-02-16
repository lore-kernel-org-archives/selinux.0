Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1GFIhE0009503
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 10:18:43 -0500
Received: from trauma.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1GFFMrR017103
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 15:15:22 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Mon, 16 Feb 2009 10:18:34 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15BA02BB@HAVOC.tcs-sec.com>
References: <20090212211531.619341973@hp.com> <170D6ABBBA770349AA49582A86FCED15BA0199@HAVOC.tcs-sec.com> <49962F60.3090206@schaufler-ca.com>
From: <chanson@TrustedCS.com>
To: <casey@schaufler-ca.com>
Cc: <paul.moore@hp.com>, <refpolicy@oss.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
I realized I was imprecise in my description of "network object" when
writing this. I was more specifically referring to enforcement of
"Network / Host Level Access Decisions" of packets entering/exiting the
system. I concur that Trusted OSes have allowed trusted processes to
change socket attributes, such as labels, or read higher level data as
Glenn and you have mentioned. This coincides with the existing MLS
networking overrides in the MLS constraints today.

-Chad

> -----Original Message-----
> From: Casey Schaufler [mailto:casey@schaufler-ca.com] 
> 
> chanson@TrustedCS.com wrote:
> > Traditionally network objects in a MLS system are not 
> usually subject 
> > to the usual privilege overrides.
> Hum. That wasn't true of Trusted Irix where sockets were the 
> network objects.
> Of course, you can only apply privilege on the sending end 
> because the privilege state isn't transmitted.
> 
> On Smack the network object is the process, and privilege is 
> required to muck with the attributes of your own sockets, but 
> otherwise it's the same, again the privilege isn't getting 
> transmitted, so you can't determine if it's there on the other end.
> 
> If you want to transmit the privilege state, and SELinux 
> (appears to) allow that, you really ought to allow for that 
> on the other end. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
