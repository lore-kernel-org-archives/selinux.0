Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9EENbNs006881
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 10:23:38 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9EELPHa000004
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 14:21:25 GMT
Message-ID: <36282A1733C57546BE392885C0618592D3952A@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: RE: MLS policy
Date: Fri, 14 Oct 2005 10:23:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 
> Currently a default root login gets a default level of s2.  This means
that 
> daemons initially run with the range s0-s9 but run with the range s2-s9
after 
> being restarted.  Should we have range-transition rules in the
daemon_domain 
> family of macros to deal with this?
> 

We do have range_transition policy to handle this. This will be included in
a MLS policy update we are working on. 

> What is the benefit of assigning root the default level of s2 anyway?
> 

Historically on MLS users login in above the lowest level. Part of this
reason is for integrity, which is not necessary for on a system with TE.

A last comment is that an MLS/RBAC/CAPP system should not allow direct root
logins, but instead just the ability to su.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
