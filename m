Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA09162
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 13:15:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA01100
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 18:15:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA01096
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 18:15:01 GMT
Date: Thu, 29 Nov 2001 13:14:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils,
 fileutils, and [xkg]dm
In-Reply-To: <20011129160254.D637335C4D9@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0111291310540.23362-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 29 Nov 2001, Russell Coker wrote:

> It's forbidden for any Debian packages to put files there for any reason.
>
> Whether a package is optional or required makes no difference.

Well, maybe we can work toward making our /usr/local/selinux hierarchy
and the builds for the userland SELinux components more easily
relocatable.  If you can contribute suggestions and patches to help with
this task, that would be useful.  Otherwise, I'm not sure when we'll get
to it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
