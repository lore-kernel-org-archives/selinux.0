Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBGLr4Ii028168
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 16:53:04 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBGLr6qv002588
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 21:53:06 GMT
Subject: Re: Tomcat policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Nick Gray <nick-lists@austin.rr.com>, SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103233142.12552.77.camel@nexus.verbum.private>
References: <1103224127.32688.49.camel@hawaii.grays-systems.com>
	 <1103233142.12552.77.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1103233677.1463.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Dec 2004 16:47:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-16 at 16:39, Colin Walters wrote:
> Simply don't allow tomcat_t access to passwd_t.

No permissions to etc_t:file if we are talking about /etc/passwd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
