Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA27796
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 17:03:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA01028
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 21:02:59 GMT
Received: from mailgw1a.lmco.com (mailgw1a.lmco.com [192.31.106.7])
	by jazzband.ncsc.mil  with ESMTP id VAA01023
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 21:02:58 GMT
Date: Mon, 16 Jul 2001 15:02:53 -0600
From: "Weaver, Mike D (N-CSC)" <mike.d.weaver@lmco.com>
Subject: RE: Linux and Posix compliance
To: drepper@cygnus.com, James A Griffin <agriffin@cpcug.org>
Cc: Ramsey Wally Contr AFRL/IFEB <Wally.Ramsey@rl.af.mil>,
        "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Message-id: <31A81CDD9175D411815100508BE32AA6062A882A@emss02m13.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ulrich,

You are wrong on a few minor points.

1) NT V3.51 passed successfully the test for POSIX 1003.1 (at the time that
was all that was complete)  they never made any effort to accomplish
anything else.  MKS went to some effort to provide 1003.2 when it became
complete and did actually provide a full 1003.1/1003.2 set of functionality
and when combined with the set of tools they provided was a superset of the
POSIX functionality. As for compliance beyond 3.51 you may be correct, (ie
4.0, 2000, etc) who knows... and I'm sure the testing will only continue if
absolutely necessary)  Bottom line is that it will only continue as long as
the requirement (read: sales volume) drives the continued testing.

2) The tests do not cost a fortune since the IEEE still (I believe) owns
them, what costs a fortune is the certification by an independent body that
a candidate platform meets the tests.  The bar was always set high to
preclude the unscrupulous vendor from cheating, as many would be prone to
do.  If one wanted to test Linux it would be fairly cheap if not free to do
the testing.  And as I mailed Wally privately it would likely come pretty
close to passing (my subjective guess would be that it would be about 80%
compliant) with no changes, and with some work around certain IPC constructs
could probably be made to comply.

3) As you say NT has become an exception throughout the US government.  You
are so correct.  This is not however by ANY written or spoken exception
process legal or otherwise.  They simply are selectively ignoring their own
mandates (another point I made privately with Wally) for their own reasons
of narrowing the bidding field.  The process has been totally and completely
driven by the sales volume of the MS platforms, and MS's grudging acceptance
of government requirements for things like security, posix compliance, etc.

As for the tests, compliance of platforms being meaningless. You nailed it!
The appropriate body in this case is NIST, which is in bed with the IEEE,
however NIST, and in Wally's case the USAF can ignore standards compliance
(or in NT's case the lack thereof) on a completely arbitrary basis to meet
the 'needs' of the organization (or to rule out a candidate
product/solution).

Cheers,

mdw ;-)

PS.  I also sent Wally a couple of pointers on the
http://www.freestandards.org/ldps/
efforts of the Linux standardization community.

-----Original Message-----
From: Ulrich Drepper [mailto:drepper@redhat.com]
Sent: Monday, July 16, 2001 2:11 PM
To: James A Griffin
Cc: Ramsey Wally Contr AFRL/IFEB; 'NSA SELinux Mailing List'
Subject: Re: Linux and Posix compliance


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
