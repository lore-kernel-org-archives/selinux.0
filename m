Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17193
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:40:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA22116
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:38:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA22112 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:38:39 GMT
Date: Thu, 11 Jul 2002 13:39:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
In-Reply-To: <00d901c228ff$d2589f30$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207111336390.15869-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Ed Street wrote:

> And sysadm_tty_device_t?

That was my point.  The ttys start in tty_device_t.  If login or newrole
creates a sysadm_r:sysadm_t shell, then it relabels the tty to
sysadm_tty_device_t.  If login or newrole creates a user_r:user_t shell,
then it relabels the tty to user_tty_device_t.  These relabeling
operations are based on type_change rules in the policy configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
