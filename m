Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EaXXZ005840
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:36:34 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2EZD4G010066
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:35:13 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 09:36:28 -0500
Message-ID: <00bc01c4c0e9$59d01aa0$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099405366.31739.65.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> MLS requires some way to identify trusted subjects and grant them the
> necessary privileges to override the BLP restrictions.  How would you
> do it?  Conventional approaches include POSIX.1e capabilities (e.g.
> if the process has the CAP_MAC_WRITE capability, it can write down)
> or TE (e.g. if the policy contains "allow foo_t bar_t:file
> mls_writedown;" then a process in "foo_t" can write down to files
> labeled "bar_t").  Either approach lets you bind MLS privileges to
> specific programs, but the TE-based approach is clearly finer-grained
> (per-object) and provides better support for protecting and isolating
> the trusted subject.  We didn't invent this idea, TE has been used in
> this manner from the beginning IIUC (and we have certainly used it in
> this manner in research predecessors of SELinux).

OK, then TE is deemed a more fundamental protection scheme, like rings, and MLS
a higher-level access control policy dependent upon TE's protection features.
I'm OK with that model, as long as we treat the TE more basic and important than
MLS, and not contort TE to fix MLS problems.  

I better understand the desire now, it truly isn't related to MLS, but TE
privilege management in general.  The problem truly is the lack of an efficient
means to switch between domains. I would suggest our continued exploring more
controlled means of managing privilege (such the type hierarchy I mentioned)
than the ability to state arbitrary relationships (if we must go down this
path).  Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
