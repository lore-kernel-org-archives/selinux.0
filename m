Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15441
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2001 11:05:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23589
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2001 15:05:07 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id PAA23585
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2001 15:05:07 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id f9HF5BA27499
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2001 11:05:11 -0400 (EDT)
Date: Wed, 17 Oct 2001 11:05:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Updated release
In-Reply-To: <200110162203.SAA06342@coalpipe.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0110171035500.18757-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


A few additional notes about this release:

1) A new run_init utility program and domain have been created to allow
administrators to run the init scripts with the appropriate security
context (e.g. to restart daemons) in a secure manner.  This was requested
by several SELinux users.  See the updated README, utils/run_init, and
utils/appconfig/initrc_context.

2) Step 4 of the updated README discusses the issues in running X on
SELinux, whether via startx after an ordinary login or via an X display
manager like xdm, gdm, or kdm.  You must uncomment certain allow
statements in the policy to grant the X server the necessary permissions,
as explained in the README.  Mark Westerman's gdm policy has been merged
into the example policy in order to ensure that it is consistent and kept
up-to-date with the rest of the policy, but you will need to obtain his
modified gdm program separately if you want to use gdm on SELinux.

3) Download Options 4 and 5 were revised in response to the feedback from
the Debian packagers.  The SELinux kernel module is provided as a patch
against the LSM kernel patch (which is identical to the lsm-2001_10_11
patch against 2.4.12 from lsm.immunix.org) rather than being part of the
archive.  The module Makefiles have been revised to ensure that the
architecture-specific symbolic links are generated during the normal
'make dep'.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com










--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
