Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17918
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 14:36:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA25223
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:35:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA25219 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:35:12 GMT
Date: Thu, 11 Jul 2002 14:35:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
In-Reply-To: <00dc01c22908$391e27f0$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207111433320.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Ed Street wrote:

> Should the /dev/tty24 be sysadm_tty_device_t instead of tty_device_t?
> Now here's the odd thing, I change /dev/tty24 to tty1, tty2 or tt3 and I
> get sysadm_tty_device_t and there's no denied messages

So this suggests that:
a) Your policy includes a 'allow syslogd_t
sysadm_tty_device_t:chr_file..." rule.  Check your policy.conf.
b) tty[1-3] are currently in use or were last used by a sysadm_r:sysadm_t
user session.

You can certainly assign sysadm_tty_device_t to /dev/tty24 if you want.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
