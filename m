Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1MaZXZ001334
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 17:36:35 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1MaYfG012318
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 22:36:34 GMT
Message-ID: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions - a seteuid parallel
Date: Mon, 1 Nov 2004 17:37:18 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Luke Kenneth Casson Leighton wrote:

> okay, so this dynamic context transitions idea is pretty much
> identical to the seteuid equivalence proposals, and doing
> an equivalent of seteuid() it has been made abundantly clear
> [many times], and why, that it should not be done.
> 
> ... question: what it is about MLS that makes it so necessary to
> implement dynamic context transitions?
>

The DoD and associated communities have long requested and utilized the
privilege bracketing technique for information sharing solutions. Thus the
majority of existing applications are built to this framework. TCS and other
ISVs have a large existing code base of fielded accredited solutions based
on this framework.
 
> what are the alternatives?
> 

The alternatives are to overprivilege the application which is not
acceptable or to rewrite all of the applications before they can be used on
this new platform. The latter is goal which can and should be achieved or
time. Applications can streamlined and reorganized to fit into the modular
framework and of cooperating applications. This is a considerable effort and
major roadblock to utilizing SELinux and therefore Linux for these types of
applications.

The other main roadblocks are already being addressed with Linux getting
CAPP EAL3 and soon to be EAL4 certifications. Add LSPP and RBAC and you have
Linux system suitable to address secure information sharing needs.

-Chad

> l.
> 
> p.s. not that i actually understand MLS enough to understand 
> any answers
> [yet] but i'm just encouraging people to bounce ideas.
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
