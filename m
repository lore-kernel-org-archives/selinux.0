Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16487
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 14:15:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0GJFjI12204
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 19:15:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0GJFjf12200 for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 19:15:45 GMT
Message-Id: <200301161923.OAA18426@moss-shockers.ncsc.mil>
Date: Thu, 16 Jan 2003 14:23:06 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: RH 7.3 compile problem
To: selinux@tycho.nsa.gov, j.logsdon@lancaster.ac.uk
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> gcc -D__KERNEL__ -I/usr/local/rpm-tgzs/selinux/lsm-2.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=tty_io  -DEXPORT_SYMTAB
> -c tty_io.c
> tty_io.c: In function `release_mem':
> tty_io.c:1040: Internal error: Segmentation fault.
> Please submit a full bug report.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.

> I  haven't reported it to bugzilla since it is not the latest RH anyway
> but has anyone a clue as to why the compilation should cough pm tty_io?  I
> can furnish other information if needed.

A simple search for 'gcc segmentation' in the RH bugzilla turns up a number
of similar reports.  I don't think that this is specific to building the
SELinux-patched kernel; you can likely reproduce it when building a vanilla
Linux kernel or other package.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
