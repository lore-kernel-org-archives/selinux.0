Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07376
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 11:52:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00417
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:52:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id QAA00413
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:52:17 GMT
Date: Thu, 8 Nov 2001 11:52:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: <selinux@tycho.nsa.gov>
Subject: Re: How can i configure this?
In-Reply-To: <3BEAF3B5.3EF2777A@cti.com.ar>
Message-ID: <Pine.GSO.4.33.0111081148500.17720-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 8 Nov 2001, Hugo F. Martinez wrote:

>     I've just have installed  selinux on my notebook to test it and
> implement it on several servers if all my test works, and for acomplish
> my tests in need your help if you can. On my new flask-kernel I've got
> several messages from the AVC reporting that an action is denied. For
> example i got the following when starting my pcmcia services:

What is your base platform (e.g. RedHat 7.1)?  Did you do a full
installation of SELinux?

> Nov  8 09:06:46 radon-ntb kernel: avc:  denied  { } for  pid=510
> exe=/sbin/cardmgr path=/dev dev=00:05 ino=1
> Nov  8 09:06:46 radon-ntb kernel:
> scontext=system_u:system_r:cardmgr_t
> Nov  8 09:06:46 radon-ntb kernel:
> tcontext=system_u:object_r:unlabeled_t
> Nov  8 09:06:46 radon-ntb kernel:    tclass=file

Is /dev just a normal directory in an ext2 filesystem, or are you
using devfs?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
