Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA00667
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 06:49:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA11415
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 11:47:18 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
        by jazzband.ncsc.mil  with ESMTP id LAA11411 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 11:47:18 GMT
Message-Id: <200211291147.LAA11411@jazzband.ncsc.mil>
Date: Fri, 29 Nov 2002 6:45:55 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: Building SELinux - System requirement and 'warning' messages
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am running Slackware Linux 8.1 on one of my spare systems and am trying to install SELinux on this system.
It is a holiday project I guess.  I have been following the instructions in the README files in 'selinux' directory.
My build process has stopped 3 times so far complaining about some missing packages such as PAM, Kerberos and now BSD lib.
Is there a library or system requirements list for SELinux?

One other note is that I noticed lots (I mean lots) of warning messages while building SELinux.
	sshd.c	clientloop.c	auth1.c	servconf.c	session.c	ssh-keygen.c	sysctl.c
The above are a few files to name but there are several more files in the list with tons of warning messages.  Is this Slackware distro problem or
SELinux code problem?  The build completes but it is not comforting to see so many warning messages while building it.  It makes you wonder of
 the programmer's skill level.

Subba Rao
sailorn@attglobal.net
2002-11-29



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
