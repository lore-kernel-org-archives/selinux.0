Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00187
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 14:37:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA13952
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 19:34:04 GMT
Received: from ziplip.com (mail.ziplip.com [128.242.109.119])
	by jazzswing.ncsc.mil  with ESMTP id TAA13948
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 19:34:03 GMT
Message-ID: <MPCKDQD2D5PXECB1KMMIFRPTCEPZOPB0IJGLEHIP@ziplip.com>
Date: Sun, 16 Feb 2003 11:35:32 -0800 (PST)
From: Dusty Hall <draper7@ziplip.com>
Reply-To: draper7@ziplip.com
To: SELinux@tycho.nsa.gov
Subject: spasswd.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  
  I'm having trouble compiling utils, specifically spasswd.  I've read through the spasswd README and glanced at the Makefile but to no avail.  First of all I'm compiling on Owl Linux with 2.2.22 if that makes a difference.  I've got the new kernel built following the instructions and made it down to compiling utils but thats where I'm having problems.  Here's the error I'm getting:

[root@localhost:~/downloads/selinux/utils/spasswd] make
cc -Wall -g -I/usr/local/selinux/include  -L/usr/local/selinux/lib  spasswd.c   -o spasswd
spasswd.c: In function `sig_handler':
spasswd.c:47: warning: implicit declaration of function `kill'
spasswd.c: In function `main':
spasswd.c:66: storage size of `sa' isn't known
spasswd.c:149: `SA_SIGINFO' undeclared (first use in this function)
spasswd.c:149: (Each undeclared identifier is reported only once
spasswd.c:149: for each function it appears in.)
spasswd.c:150: warning: implicit declaration of function `sigaction'
spasswd.c:150: `SIGHUP' undeclared (first use in this function)
spasswd.c:151: `SIGINT' undeclared (first use in this function)
spasswd.c:152: `SIGQUIT' undeclared (first use in this function)
spasswd.c:153: `SIGPIPE' undeclared (first use in this function)
spasswd.c:154: `SIGTERM' undeclared (first use in this function)
spasswd.c:66: warning: unused variable `sa'
make: *** [spasswd] Error 1


  Any advise would be greatly appreciated.

Thanks,


-Dusty
draper7@<NOSPAM>slashseven.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
