Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA10231
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:38:01 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MLc0I15557
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 21:38:01 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
        by jazzband.ncsc.mil  with SMTP id h0MLbxf15553 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 21:38:00 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id VAA08083
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 21:40:50 GMT
Date: Wed, 22 Jan 2003 21:40:49 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: gcc problem
Message-ID: <Pine.LNX.4.10.10301222128260.6823-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

Having tried the other day to compile with gcc-2.96-112 and 113 and
failed, I have updated to RH8.0 and gcc-3.2-7.  The earlier errors may
have been hardware although the system has been running for quite a few
years without any obvious errors.

I am trying to compile the lsm-2.4-selinux-2002121210.tgz from the NSA
site but with gcc-3.2 it coughs because in the utils it is looking for
files from the 2.96 library - that it there are error messages like:

make -C logrotate-3.6.5
make[2]: Entering directory
`/usr/local/rpm-tgzs/selinux/selinux/utils/logrotate-3.6.5'
make[2]: *** No rule to make target
`/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/stddef.h', needed by
`logrotate.o'.  Stop.

Other than copying over some 2.96 files from another machine (which
probably wouldn't work anyway) or editing the files in the source tree
(g/2\.96/s//3\.2/g sort of thing) what is the best way to proceed?

FWIW there are 262 files mainly in utils and a few in selopt that are
asking for the following files:

/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/float.h
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/limits.h
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/stdarg.h
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/stdbool.h
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/stddef.h
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/syslimits.h

Is it possible that my previous unsuccessful compilation has left these
around and in which case, since there is no make clean in the Makefile,
what is the best way to start afresh.

Sorry to ask such a basic question - I am not used to compiling kernels,
only my own programs!  Should I have downloaded from the CVS tree?

TIA

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
