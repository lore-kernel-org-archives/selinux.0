Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01110
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 11:19:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA12698
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:17:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id QAA12694 for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:17:56 GMT
Message-Id: <200212021627.LAA25272@moss-shockers.ncsc.mil>
Date: Mon, 2 Dec 2002 11:27:17 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux compile errors
To: russell@coker.com.au, selinux@tycho.nsa.gov, sailorn@attglobal.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


SELinux isn't inherently dependent on PAM or kerberos.  If your system is not
using PAM, then you'll need to adjust the configure options in
utils/Makefile and the flags in the newrole and run_init Makefiles.
Likewise with the configure options for kerberos in utils/Makefile.

But I can't really recommend that you proceed down this path.  Porting
SELinux to Slackware properly requires more than just hacking up configure
options and Makefiles.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
