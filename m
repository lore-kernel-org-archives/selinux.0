Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2CnHXZ004849
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 07:49:17 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2CnCAw013918
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 12:49:16 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions - a seteuid parallel
Date: Tue, 2 Nov 2004 07:49:12 -0500
Message-ID: <00aa01c4c0da$5acdd960$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The DoD and associated communities have long requested and utilized
> the privilege bracketing technique for information sharing solutions.
> Thus the majority of existing applications are built to this
> framework. TCS and other ISVs have a large existing code base of
> fielded accredited solutions based on this framework.

To be fair, privilege bracketing came about primarily as a compromise of how to
meet the B2 requirements.  The ideal was something like ring brackets from the
Multics hardware, or even the simplified execution privilege levels from x86
architecture.  I'm sure that on of the first places privilege bracketing
argument was used was the B2 Trusted XENIX project, where we stretched greatly
the B2 requirements of least privilege and separation of security relevant code,
and successfully used the concept of privilege bracketing as en evaluation
strategy.

So I'll admit my culpability in weakening the B2 requirements, but that does not
mean privilege bracketing is a good idea just because we used it in the pass as
a means to expedite evaluations.  Rings and x86 privilege levels are truly
separate, distinct security domains.  Privilege bracketing is not (all software
in the process will typically have complete control over what privileges it
desires to use).  Unfortunately, like Trusted XENIX (and any Unix), the only
really distinct execution domains we have are processes, which has much greater
overhead cost for switching than rings.  

So if we were honest, the real reason we want to change security content is for
performance reasons, not security assurance reason.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
