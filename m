Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09254
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 16:50:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA12673
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 21:50:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id VAA12669
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 21:50:36 GMT
Date: Mon, 12 Feb 2001 16:49:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: hwclock
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152407F@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010212163303.24816e-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> allow hwclock_t sysadm_tty_device_t:chr_file rw_file_perms;

The need for permission to sysadm_tty_device_t (as opposed to
tty_device_t) reflects an oversight in our INSTALL instructions. When you
login or run newrole, your terminal is relabeled from its initial type of
tty_device_t to a type that is appropriate for your role/domain
(user_tty_device_t for user_r:user_t and sysadm_tty_device_t
for sysadm_r:sysadm_t).  When the login session ends or you exit the
newrole shell, the terminal label is reset to its original value.
However, when the system is rebooted, the terminals for any existing login
sessions or newrole shells don't get reset to the original value.  On our
systems, we've tweaked the /etc/rc.d/rc.sysinit script to reset
the label on terminal devices to system_u:object_r:tty_device_t,
but instructions to do that never made it into the INSTALL file.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
