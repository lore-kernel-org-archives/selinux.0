Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA27295
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 08:43:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08535
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:42:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA08531
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:42:35 GMT
Date: Tue, 9 Jul 2002 08:43:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: lsm3 notes
In-Reply-To: <005301c2270a$350a2a10$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207090836321.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Ed Street wrote:

> I keep seeing /dev/xconsole avc's.
> This is from startup
> allow initrc_t device_t:fifo_file { setattr };
>         #EXE=/bin/chmod  PATH=/dev/xconsole   :  setattr

/dev/xconsole doesn't exist on my systems.  Feel free to define an
appropriate type and submit a patch to types/device.te and
file_contexts/type.fc, along with a patch to whatever domains require
access.  What creates this FIFO?

> startup as well
> allow initrc_t resolv_conf_t:file { setattr };
>         #EXE=/bin/chmod  PATH=/etc/resolv.conf   :  setattr

Why are your rc scripts changing the mode on /etc/resolv.conf?
In any event, this is probably harmless.

> when I ssh into the box
> allow sshd_t sysadm_home_t:dir { search };
>         #EXE=/usr/sbin/sshd  PATH=/root   :  search

Do you really need to login directly as root?

> when I tried to tail syslog as user_r
> allow user_t var_log_t:file { getattr read };
>         #EXE=/bin/bash  PATH=/var/log/syslog   :  getattr
>         #EXE=/usr/bin/tail  PATH=/var/log/syslog   :  read

Do you really want to permit ordinary users to read your logs?

> Most notably problems with sysklogd, and it's not writing events to
> /var/log/syslog

Are klogd and syslogd running in the right domains?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
