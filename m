Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA03107
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 15:27:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA28819
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 20:25:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id UAA28815 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 20:25:12 GMT
Message-Id: <200211292034.PAA23915@moss-shockers.ncsc.mil>
Date: Fri, 29 Nov 2002 15:34:35 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Building SELinux - System requirement and 'warning' messages
To: selinux@tycho.nsa.gov, sailorn@attglobal.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I am running Slackware Linux 8.1 on one of my spare systems and am trying to 
install SELinux on this system.
> It is a holiday project I guess.  I have been following the instructions in 
the README files in 'selinux' directory.
> My build process has stopped 3 times so far complaining about some missing 
packages such as PAM, Kerberos and now BSD lib.
> Is there a library or system requirements list for SELinux?

No, but the web site notes that we have only built and used SELinux
on RedHat 7.x.  The modified daemons and utilities are mostly derived from
the RedHat 7.2 sources, so you need to port the SELinux patches for the
modified applications if you want to use another distribution.   You also
need to adapt the policy configuration for other distributions.  Russell Coker 
has done this work for Debian, and Carsten Grohmann has done some
work on SuSE policy changes.  See http://selinux.sourceforge.net/distros.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
