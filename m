Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06025
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2001 09:08:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA25269
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2001 14:08:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA25265
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2001 14:08:07 GMT
Date: Thu, 27 Dec 2001 09:07:35 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: su etc
In-Reply-To: <20011222211804.479731A62@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0112270847430.24418-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 22 Dec 2001, Russell Coker wrote:

> I'm now thinking about what to do with su.  Should su change the security of
> the tty with chsid() before spawning a new shell and then change it back
> afterwards as login does?  Or is there some difference in the way that su and
> login work that requires some different code?

We intentionally chose to not modify the su program for SELinux.  Hence,
su only changes the Linux identity attributes, not the SELinux security
context.  su is most commonly used to obtain Linux capabilities for
administrative tasks by becoming the superuser, but this merely reflects a
change in privilege, not a real change in the user who is performing the
tasks.  We would prefer to leave the SELinux user identity unmodified for
user accountability in this case.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
