Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02482
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 14:57:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB4JvSI29947
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 19:57:28 GMT
Received: from zok.sgi.com (zok.SGI.COM [204.94.215.101])
        by jazzband.ncsc.mil  with ESMTP id gB4JvQf29937 for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 19:57:27 GMT
Message-ID: <3DEE5E03.BCA7A357@sgi.com>
Date: Wed, 04 Dec 2002 11:56:51 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: egoodwin@unimatrix.com
Subject: Re: SGI Challenge XL
References: <OF4CFC5AAA.4DF982B3-ON85256C83.004AE823-85256C83.004B53A4@unimatrix.net> <200212021716.58396.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> 
> On Mon, 2 Dec 2002 14:50, egoodwin@unimatrix.com wrote:
> > Has anyone worked with an SGI Challenge XL server and SE Linux as yet?  We
> > would like to bring this server back from retirement and consider this
> > project an excellent reason to do so.  While we still have IRIX 6.5.2
> > loaded to the machine, we would rather have it running Linux.  Is it
> > possible to patch IRIX's kernel, or should we go with Linux?  There is a
> > version of Linux compiled for the Challenge XL, although its not exactly
> > one that is in "active development".

True enough. We don't support Linux on our MIPS platforms, but
we do try to keep an eye out for people doing interesting things
with it. To date, I know of no one who has put SELinux onto a
MIPS platform.

> SE Linux is not going to apply to other OSs without a lot of work.

Give that man the Understatement of the Week Award!

> I suspect that the IRIX kernel may have more in common with FreeBSD than Linux and
> therefore TrustedBSD may be of more use to someone wanting to get a hardened
> IRIX.  Of course this requires IRIX source code...

Just an aside, but Irix is "hardened" already. The base OS is
Common Criteria evaluated  (that's a good thing) and includes
ACLs, audit, and POSIX capabilties. There's also a "Trusted Irix"
add on (costs extra, and I get credit for it!) with Mandatory Access
Control and the SuperUser removed.

> SE Linux could be ported to MIPS CPUs, and it shouldn't be that difficult.
> But it may be a lot easier to just buy a new Intel machine.  A quick google
> search suggests that we're talking about 8yo hardware, it shouldn't be
> difficult to buy a small cluster of Intel machines to deliver greater
> performance (which will probably cost you less than paying someone to port SE
> Linux to MIPS).

Most likely true.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 877.557.3184

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
