Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00205
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 08:28:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA05950
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 13:28:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA05946
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 13:28:13 GMT
Date: Wed, 28 Nov 2001 08:28:24 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils,
 fileutils, and [xkg]dm
In-Reply-To: <20011127212006.257D725E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0111280821160.1519-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 27 Nov 2001, Russell Coker wrote:

> What is probably of more interest to you is the locations that I've put
> header files in, here's what I'm currently installing:
> /usr/include

Well, this will naturally break the build of all of the userland
components of SELinux.  Why do you need to change the installation
directories from what we use?

> /usr/include/linux/flask

This change is probably harmless for building the userland components,
since the same #include directives will still work (#include
<linux/flask/foo.h>).  But what about the <linux/asm-i386/unistd.h>
and the <linux/asm-i386/flask/unistd.h> files?  These are also needed
for building the userland components.

> /usr/include/selinux

This change will require changes to the userland components of SELinux,
and I'm not planning on making these changes to our distribution unless
there is a real justification.  What's wrong with
/usr/local/selinux/include?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
