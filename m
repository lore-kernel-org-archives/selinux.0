Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16995
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:21:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA21057
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:20:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA21053 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:20:29 GMT
Date: Thu, 11 Jul 2002 13:21:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: sysadm_tty_device_t
In-Reply-To: <00cc01c228f5$d73b6e10$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207111319430.15869-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Ed Street wrote:

> Was working with putting syslog on /dev/tty24 (entry in /etc/syslog.conf
> is
> *.*	/dev/tty24
>
> Selinux shows /dev/tty1 as syadm_tty_device_t but /dev/tty24 is just
> tty_device_t.  I started poking around looking for sysadm_tty_device_t
> but not exactly sure what tty's are being set to this.  My question is
> where is the control file, is it /etc/securetty?

ttys are initialized to tty_device_t by 'make relabel'.  They are then
relabeled by the modified login program based on the user's context for
user sessions, and are also relabeled by the newrole program for shells in
different roles.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
