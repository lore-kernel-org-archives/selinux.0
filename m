Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA20733
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 16:14:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA01052
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 21:14:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id VAA01048
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 21:14:05 GMT
Date: Mon, 26 Nov 2001 16:14:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Jones, Robyn M." <Robyn.Jones@jhuapl.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: 7.1 installation
In-Reply-To: <91D1D51C2955D111B82B00805F1998950C23CA92@aples2.jhuapl.edu>
Message-ID: <Pine.GSO.4.33.0111261611230.21971-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Nov 2001, Jones, Robyn M. wrote:

> im attempting to install the latest version on red hat 7.1.  when i reboot
> (step 12 of the instructions), the only option is to boot with linux (no
> option for selinux).  what change did i miss?

Step 12 explains how to configure LILO to boot the SELinux kernel (aka the
LSM-patched kernel).  Did you update /etc/lilo.conf and run /sbin/lilo?
Are you using LILO or are you using some other boot manager?

As a side note, please be sure that you applied the selinux_inode_delete
patch that I posted after the latest release was made.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
