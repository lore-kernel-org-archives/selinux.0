Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2CwZXZ004929
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 07:58:35 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2CvE4G002666
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 12:57:14 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions - a seteuid parallel
Date: Tue, 2 Nov 2004 07:58:31 -0500
Message-ID: <00b201c4c0db$a9bdde20$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The alternatives are to overprivilege the application which is not
> acceptable or to rewrite all of the applications before they can be
> used on this new platform. The latter is goal which can and should be
> achieved or time. Applications can streamlined and reorganized to fit
> into the modular framework and of cooperating applications. This is a
> considerable effort and major roadblock to utilizing SELinux and
> therefore Linux for these types of applications.

I think the case is not stated accurately.  What you want is to fundamentally
change a key property of the most important security property of type
enforcement (process type tranquility) in order to allow software the
*discretion* to turn on and off some of its privileges, arbitrarily.  I
certainly have no problem with software's ability to decide not to use its
privileges, but I an quite concerned that achieving this small victory cause
significant damage to the core mandatory security assurance.

> The other main roadblocks are already being addressed with Linux
> getting CAPP EAL3 and soon to be EAL4 certifications. Add LSPP and
> RBAC and you have Linux system suitable to address secure information
> sharing needs. 

No, privilege bracketing is not (or should not be) a concerned at EAL4 and
below.  I try my best to forget the CC :-) but I'm quite sure of this.  Maybe if
you're talking about EAL5 (the B2 like requirement), but again that's just an
evaluation strategy, not necessarily "good."  I know for a fact that the EAL4
evaluation strategy for a certain non-Unix OS never concerned itself with such
an issue.  

If the Linux guys are wrapped around privileges within a single process for an
EAL4 evaluation, seek better advice!  This is simply the wrong issue to be
focusing the evaluators on.

Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
