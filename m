Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17674
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 14:20:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24407
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:19:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA24403 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:19:05 GMT
Date: Thu, 11 Jul 2002 14:19:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
In-Reply-To: <00da01c22903$fff54520$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207111416400.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Ed Street wrote:

> Hello,
>
> OK my /etc/syslogd.conf file contains this
>
> *.*	/dev/tty24
>
> when I boot or run-init I get this
>
> allow syslogd_t tty_device_t:chr_file { append };
>         #EXE=/sbin/syslogd  PATH=/dev/tty24   :  append
>
> The avc from kern.log is this
>
> Jul 11 13:51:17 debian kernel: avc:  denied  { append } for  pid=160
> exe=/sbin/syslogd path=/dev/tty24 dev=72:01 ino=2175725
> scontext=system_u:system_r:syslogd_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

Right, this is what I would expect to happen.  What is your question,
exactly?  If you want syslogd to be able to write to a tty, you need to
grant syslogd_t the necessary permission.  If you want to ensure that only
syslogd can write to the tty, then define a new type, assign it to the tty
in types.fc (or use chcon directly), and grant syslogd_t permission to the
new type.  Otherwise, just allow syslogd_t tty_device_t:chr_file append;

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
