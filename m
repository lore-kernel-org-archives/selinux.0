Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA27905
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 17:18:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA27430
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 21:18:00 GMT
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by jazzswing.ncsc.mil  with ESMTP id VAA27426
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 21:17:59 GMT
To: "Weaver, Mike D (N-CSC)" <mike.d.weaver@lmco.com>
Cc: James A Griffin <agriffin@cpcug.org>,
        Ramsey Wally Contr AFRL/IFEB <Wally.Ramsey@rl.af.mil>,
        "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
References: <31A81CDD9175D411815100508BE32AA6062A882A@emss02m13.ems.lmco.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
From: Ulrich Drepper <drepper@redhat.com>
Date: 16 Jul 2001 14:14:19 -0700
In-Reply-To: "Weaver, Mike D's message of "Mon, 16 Jul 2001 15:02:53 -0600"
Message-ID: <m34rscpoes.fsf@otr.mynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Weaver, Mike D (N-CSC)" <mike.d.weaver@lmco.com> writes:

> 1) NT V3.51 passed successfully the test for POSIX 1003.1 (at the time that
> was all that was complete)

That's the point.  Who cares about the old .1/.2?  All applications
are using features from the additions.  There is no such support and
this is why there is the exception for NT.

> 2) The tests do not cost a fortune since the IEEE still (I believe) owns
> them,

There exists no test suite for the current standard, leave alone a
free one.  Standard labs are working on updates but there isn't
certification offered yet.  All which is freely available is a test
for a subset for the old .1 spec.  This is completely inadequate and
the test suite itself is so full of bugs that it's not even funny
(bugs = assumptions made which are not part of the standard).  The
IEEE test suite is AFAIK directly and automatically derived from the
2003 standards which were not updated since the first release.

I've tried getting test suites and all you hear from the OpenGroup or
similar organizations is how much they want to charge you.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
