Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00841
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 14:44:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA16697
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 19:43:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA16693
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 19:43:40 GMT
Date: Wed, 16 Jan 2002 14:43:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Miara, Richard J." <rjmiara@missi.ncsc.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: RH 7.1 Selinux Install fails in step 7 - /usr/sbin/sshd not
 found
In-Reply-To: <200201161909.g0GJ99513708@stingray.missi.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0201161440310.7787-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Jan 2002, Miara, Richard J. wrote:

>    if [ ! -f /usr/sbin/sshd.old ]; then mv /usr/sbin/sshd
> /usr/sbin/sshd.old fi
>    mv: cannot stat '/usr/sbin/sshd' no such file or directory
>    make: *** [install] Error1
>
> I'm not sure how to proceed from here?

Just remove that line from the install target of utils/Makefile and try
again.  The line is intended to move aside your existing ssh daemon
program prior to performing the installation of the SELinux-modified ssh
daemon.  But you apparently don't have the ssh daemon installed at all, so
this fails.  We'll fix the Makefile to perform an explicit test here.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
