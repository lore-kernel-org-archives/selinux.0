Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA27270
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 16:15:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA28513
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 20:14:55 GMT
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by jazzband.ncsc.mil  with ESMTP id UAA28509
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 20:14:52 GMT
To: James A Griffin <agriffin@cpcug.org>
Cc: Ramsey Wally Contr AFRL/IFEB <Wally.Ramsey@rl.af.mil>,
        "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
References: <D98BF3C61B66D311BA820000D11B4BDF01438540@FSJREZ03.adm.rl.af.mil>
	<3B533733.BE3E2167@cpcug.org>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
From: Ulrich Drepper <drepper@redhat.com>
Date: 16 Jul 2001 13:10:43 -0700
In-Reply-To: James A Griffin's message of "Mon, 16 Jul 2001 14:49:23 -0400"
Message-ID: <m3hewcprcs.fsf@otr.mynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James A Griffin <agriffin@cpcug.org> writes:

> One thing that I have noticed for years is the boot time message "POSIX
> conformance testing by UNIFIX".  The message appears just after the CPU
> testing and before the PCI: Probe.  UNIFIX is a UK company, IIRC.  What
> the results of the "conformance testing" are, I do not know.

I think (and hope) they've finally removed this output.  It never was
true and is anyway completely outdated.

There hasn't been any formal POSIX testing done.  The reason is
simple: who'd pay this?  POSIX testing is done by the certification
labs which charge enormous amounts of money for this.

The kernel people has done tests based on available standard tests
occasionally.  I've done for the C library quite some testing and
wrote many tests myself.  This still does not guarantee compliance,
though.


As for use in government and military.  The current route seems to be
to get for Linux the same kind of exception which exists for NT.  NT
does not conform to POSIX either and can be used.  You might want to
check your appropriate standardization bureau about the status of
this.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
