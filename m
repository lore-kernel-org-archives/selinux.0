Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AIVrRb017007
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:31:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4AIVpYW027754
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 18:31:51 GMT
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
        by jazzband.ncsc.mil  with ESMTP id i4AIVoBf027751 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 18:31:51 GMT
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
From: Serge Hallyn <hallyn@cs.wm.edu>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1084213955.17955.6.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Date: Mon, 10 May 2004 13:32:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  The only things that
> aren't addressed are the BSD Jail's use of the task_(alloc|free)_security and
> network restrictions (which would require some major rethinking for
> usage in a stacked LSM).

Hi,

Both the /proc and network restrictions are done in ways which are
probably not acceptable to the kernel maintainers anyway.  For /proc, I
am considering doing a simpler inode_permission on pathname based
restriction.  This may be a part of the next version (which I have to
put out to handle iopl() and shared memory anyway.)

For network restrictions, I'm open to suggestions for another way to
implement these.

Regarding the task_security.  One possibility would be for selinux to
have a task_security->secondary pointer, and change get_security and
set_security in bsdjail.c to use task_security->secondary if it found it
was loaded under selinux.

Of course, another possibility which I prefer is to use the stacker lsm
and rewrite selinux to use that  :)

-serge


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
