Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA00283
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 04:16:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA18603
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 08:16:03 GMT
Received: from mailgate.rdg.opengroup.org (mailgate.rdg.opengroup.org [192.153.166.4])
	by jazzswing.ncsc.mil  with SMTP id IAA18599
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 08:16:03 GMT
Received: from skye.rdg.opengroup.org [192.153.166.247] by smtp.opengroup.org via smtpd  V1.38 (00/07/25 13:18:13) for <selinux@tycho.nsa.gov> ; Tue Jul 17 09:17 BST 2001
Date: Tue, 17 Jul 2001 09:12:43 +0100
From: Andrew Josey <ajosey@rdg.opengroup.org>
Message-Id: <1010717081242.ZM14867@skye.rdg.opengroup.org>
In-Reply-To: JOSEPH I. BERGMANN's message as of Jul 17, 12:09am.
References: <5.0.2.1.2.20010717000846.01f728e0@mail00708.popserver.pop.net>
Reply-To: ajosey@rdg.opengroup.org (Andrew Josey)
To: "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ulrich writes in response to another posting:

> > 2) The tests do not cost a fortune since the IEEE still (I believe) owns
> > them,
>
>There exists no test suite for the current standard, leave alone a
>free one.  Standard labs are working on updates but there isn't
>certification offered yet.  All which is freely available is a test
>for a subset for the old .1 spec.  This is completely inadequate and
>the test suite itself is so full of bugs that it's not even funny
>(bugs = assumptions made which are not part of the standard).  The
>IEEE test suite is AFAIK directly and automatically derived from the
>2003 standards which were not updated since the first release.

The current standard is IEEE Std 1003.1-1990 plus its
amendments, the nature of the amendments process is that
it is additive and so what is out there ought to be current.
In the case of the NIST PCTS test suite, this was lasted updated in 1995,
and is known to be problematic.   This is not the only
test suite for POSIX, and The Open Group has test suites
for all of POSIX, and makes freely available a core set.
The equivalent test suite  to the NIST PCTS for ISO/IEC 9945-1:1990
is known as the VSX-PCTS test suite and this is regularly maintained
and updated.


>

>I've tried getting test suites and all you hear from the OpenGroup or
>similar organizations is how much they want to charge you.
>
I think this is a little unfair -- The Open Group makes freely available many
test suites as part of its support for the community. See
http://www.opengroup.org/testing/downloads.html,
which has tests for IEEE POSIX.1-1990 (VSX-PCTS), POSIX.2-1992 (VSC-lite) and
POSIX.1c-1995 (VSTH-lite) (also the LSB FHS tests, the LSB-VSX,
X Window System, Motif, Corba and various test frameworks and tools).

The VSX-PCTS is being used as the core part of the LSB test
and certification activities, where The Open Group is contributing
new testcases beyond the POSIX subset in the LSB-OS testsuite.

Yes, we do charge for some of our other test suites for other areas
such as UNIX certification which have greater test coverage --  we operate
as a  not-for-profit and selling licenses and support services is how
we pay our salaries.

We are commencing work on the update to the tests for the forthcoming
revision to POSIX (see http://www.opengroup.org/austin/ for the
spec) and do plan to continue to make a  POSIX subset available.
If any folks are interested in assisting with the funding for
this effort let me know.

best regards
Andrew


-----
Andrew Josey                                The Open Group
Director, Server Platforms                  Apex Plaza,Forbury Road,
Email: a.josey@opengroup.org                Reading,Berks.RG1 1AX,England

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
