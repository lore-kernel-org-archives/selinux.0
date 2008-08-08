Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78GU2pD006015
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 12:30:02 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78GTqvJ006470
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 16:29:53 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id m78GUOIq024108
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 12:30:24 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id m78GUOrX024106
	for selinux@tycho.nsa.gov; Fri, 8 Aug 2008 12:30:24 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78FkViR029599
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 11:46:31 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78FkU5c011850
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 15:46:30 GMT
Received: from basement.kutulu.org ([70.121.200.185])
          by cdptpa-omta05.mail.rr.com with ESMTP
          id <20080808154630.KTXD757.cdptpa-omta05.mail.rr.com@basement.kutulu.org>
          for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 15:46:30 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by basement.kutulu.org (Postfix) with ESMTPS id C2F091143D
	for <selinux@tycho.nsa.gov>; Fri,  8 Aug 2008 11:46:27 -0400 (EDT)
Message-ID: <489C6A4F.3020704@kutulu.org>
Date: Fri, 08 Aug 2008 11:46:23 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Help: SELinux causing(?) boot failures...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've been having a major problem with one particular system trying to 
convert it to an SELinux-enabled system.  Several people in #selinux 
have been very helpful, but so far nothing's working out, so I guess 
I'll ask here:

I have a VMWare Virtual Machine running a 2.6.25 kernel with SELinux 
support compiled in, and a full SELinux userland (it's Gentoo Hardened, 
in case it matters).  When I attempt to boot the machine, none of my 
startup scripts run and my terminal's getty processes repeatedly die off 
until init shuts them down.  At the pont where the boot scripts should 
be running, INIT just skips right to the next step in the boot process, 
which now looks like this:

----------

{some AVCs about init}
INIT: v2.86 booting
INIT: Entering runlevel: 3

printk: 42 messages suppressed.
{a few SELinux AVC's about agetty}

This is (none).

This is (none).

INIT: Index "c1" respawning too fast: disabled for 5 minutes
INIT: Index "c2" respawning too fast: disabled for 5 minutes
		.
		.
		.
INIT: no more processed left in this runlevel

----------

The reason I strongly suspect SELinux is the problem (or at least a 
major factor), is that adding "selinux=0" to my boot command line 
corrects the problem, and the system boots fine.  Everything appears to 
be installed and configured correctly, except obviously SELinux is now 
disabled.  The filesystems are all labeled correctly, and even on the 
failing boot the AVC messages display the correct labels, like 
tty_device_t and urandom_device_t.


This is a VM so I have ready access to its serial port for debugging, 
and can install, patch, etc. anything needed to resolve the problem.  I 
just have no idea where to start.  Can anyone help me out here?

Thanks,

--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
