Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00968
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 11:14:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA16513
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:11:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA16509
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:11:58 GMT
Message-Id: <200212021621.LAA25269@moss-shockers.ncsc.mil>
Date: Mon, 2 Dec 2002 11:21:34 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: RH 8.1
To: selinux@tycho.nsa.gov, sailorn@attglobal.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> Until I get a Debian distro I plan to try to install SELinux on RH 8.1.  A 
basic question I have, is SELinux distro version specific?
> In the LSM README files, the instructions do say RH 7.1 or RH 7.2.  Can I 
install SELinux on RH 8.1?

Do you mean RH8.0?  The SELinux release does appear to install ok on RH8.0,
but the policy configuration will need some updating for it.  Also, the
patched utilities and daemons are based on older versions (from RH7.x), so
you will ultimately want to port the patches forward to the RH8.0 base
sources, although you may be able to use the older versions in the short
term.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
