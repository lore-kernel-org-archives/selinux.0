Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15900
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 13:00:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA19422
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:58:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA19416
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:58:41 GMT
Date: Wed, 1 May 2002 13:00:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: f980215 <f980215@mailandnews.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: boot  messages and mount
In-Reply-To: <001201c1eff7$b0e765c0$780aa8c0@r213>
Message-ID: <Pine.GSO.4.33.0205011256280.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 30 Apr 2002, f980215 wrote:

> when boot, found error messages:
> =================================
> Apr 28 21:05:16 sea2 ipsec: execvp: Permission denied
> kernel: avc:  denied  { execute } for  pid=679 exe=/sbin/initlog path=/etc/rc.d/init.d/ipsec dev=03:43 ino=680615 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_lock_t tclass=file
> Apr 28 20:27:09 sea2 ipsec: execvp: Permission denied
> Apr 28 20:27:09 sea2 rc: Starting ipsec:  failed

This indicates that /etc/rc.d/init.d/ipsec has the wrong type (var_lock_t
rather than etc_t).  Be sure that you run make relabel, and that you
don't switch back and forth between an ordinary Linux kernel and
the SELinux kernel without performing such a relabel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
