Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h382THI4019232
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 22:29:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h382TExH005479
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 02:29:14 GMT
Received: from windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
        by jazzband.ncsc.mil  with ESMTP id h382TDDl005476 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 02:29:14 GMT
Message-ID: <001d01c2fd77$1721c5a0$398314d1@windowpane.com>
From: "ccallen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: NTFS / bitkeeper problem
Date: Mon, 7 Apr 2003 19:32:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I kicked off bitkeeper with "bk clone bk://lsm.bkbits.net:lsm-2.5", it made
it as far as "include/linux/netfilter_ipv4/SCCS/s.ipt_dscp.h" and displayed
the message below. Is it going to be impossible to clone the repository to
NTFS, or is there a way to do this? I could put my linux machine online, but
I wanted to get selinux configured first.

Is the Mainline 2.5 basically the same thing as the lsm-2.5 bits, just
cleaned up in preperation for release with the kernel?

Conan

Bitkeeper Message
==========================================================================
Sfio has detected a name conflict between
"include/linux/netfilter_ipv4/SCCS/s.i
pt_dscp.h" and "include/linux/netfilter_ipv4/SCCS/s.ipt_DSCP.h";
This usually happens when you transfer file from a case-sensitive file
system (e.g. Unix) to a case insensitive file system (e.g FAT, NTFS)
Please rename one of the files and retry (see also "bk helptool mv")
Note: You must do the rename in the sending repository.
==========================================================================
write on fd gzip_in gunzip2fd: Broken pipe
ERROR: process 304 is exiting and it has left the repository at
. write locked!!  This is the result of a process that has been
killed prematurely or is a bug.
socket2pipe: reader error 2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
