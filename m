Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28135
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 09:17:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25823
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 14:15:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id OAA25819 for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 14:15:57 GMT
Message-Id: <200211211425.JAA18087@moss-shockers.ncsc.mil>
Date: Thu, 21 Nov 2002 09:25:15 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: login (new default_contexts, run-time detection)
To: selinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Is there a simple method to determine which flavor of login (i.e., which
> version of selinux) is being used at run time?  

Are you asking for a means by which your user management tool can determine
whether or not it needs to update /etc/security/{default_context,cron_context}
(the old version) or not (the new version)?  You can just check for the
existence of /etc/security/default_context vs. /etc/security/default_contexts to 
see which version of SELinux was installed.  Of course, if you upgrade
an older version to the current version, you'll have both files in /etc/security
but only the new one will be used.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
