Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15866
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 12:56:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA18814
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:55:21 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA18810 for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:55:21 GMT
Date: Wed, 1 May 2002 12:56:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: f980215 <f980215@mailandnews.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: help: about boot message
In-Reply-To: <001a01c1ee54$093c60e0$780aa8c0@r213>
Message-ID: <Pine.GSO.4.33.0205011251290.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 28 Apr 2002, f980215 wrote:

> * /var/log/messages
>   =================
>   Apr 28 16:13:57 sea2 kernel:
>   Apr 28 16:13:57 sea2 /sbin/mingetty[892]: /dev/tty2: Permission denied
>   Apr 28 16:13:57 sea2 kernel: avc:  denied  { setattr } for  pid=881 exe=/sbin/mingetty path=/dev/tty3 dev=03:43 ino=36350 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:file_t tclass=chr_file

The tty has the wrong type (file_t instead of tty_device_t).  Did you run
'make relabel' before booting the SELinux kernel?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
