Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA24104
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 05:41:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA06762
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 09:40:55 GMT
Received: from mx03.uni-tuebingen.de (mx03.uni-tuebingen.de [134.2.3.13])
	by jazzswing.ncsc.mil  with ESMTP id JAA06758
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 09:40:55 GMT
Received: from linux16.zdv.uni-tuebingen.de (linux16.zdv.uni-tuebingen.de [134.2.18.16])
	by mx03.uni-tuebingen.de (8.9.3/8.9.3) with ESMTP id LAA00386
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 11:41:26 +0200
Date: Mon, 2 Jul 2001 11:41:25 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: checkpolicy fails
Message-ID: <Pine.LNX.4.30.0107021131100.4791-100000@linux16.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello there,

finally I started installing SELinux on a redhat 7.0. I took the
Everything in one large file. I went on doing everything described in the
doc/INSTALL file.

I succeded in building the kernel and installing it, but I had some
trouble to build the tools. I got lots of warnings stating that some
method does not return integers and some saying, that something else was
not initialized... - have I forgot the header files?

But finally, after I manually configured the tools/tar with
./configure --with-flask
the build succeded (still with warnings), and so did the install.

But as I tried to do the
make initinstall
it ended up saying the initpolicy.conf contained errors. Well, the
initpolicy.conf seems sane to me (I didn't change a thing), so probably
the error lies in checkpolicy. Here are the last lines of make
initinstall:

[...]
m4 -s security_classes initial_sids access_vectors  init.te rbac users constraints  initial_sid_contexts fs_contexts net_contexts > initpolicy.conf
../kernel/security/checkpolicy -o initpolicy initpolicy.conf
../kernel/security/checkpolicy:  loading policy configuration from initpolicy.conf

error in the statement ending on line 2196 (token ';'): unknown class capability used in rule

../kernel/security/checkpolicy:  error(s) encountered while parsing configuration
make: *** [initpolicy] Error 1

I'd be glad if you could help me get along,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
