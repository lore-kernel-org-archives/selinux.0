Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28627
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 09:55:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA27301
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 14:54:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA27297
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 14:54:37 GMT
Date: Fri, 8 Feb 2002 09:54:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Vanuxem <gvanuxem@club-internet.fr>
cc: <selinux@tycho.nsa.gov>
Subject: Re: LVM and devfs_contexts (Was: your mail)
In-Reply-To: <ADEEIKPBIEHIINPOFGAOKEMGCAAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0202080930430.15099-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 7 Feb 2002, Vanuxem wrote:

> Does anyone know if SElinux is working with LVM
> and how can I configure the devfs_context ???

We have not tried using LVM with SELinux, and offhand I don't know how it
would interact with SELinux.  Naturally, any new operations implemented by
LVM won't be controlled by SELinux unless they happen to use the existing
capable or permission interfaces for checking privileges/permissions.

We aren't using devfs ourselves, but the policy/devfs_contexts file does
allow you to specify initial contexts for devfs entries if you are using
it.  The example file is fairly sketchy, so you are likely to need
to specify a number of other devfs entries for a working system.
Russell Coker has posted some additions that he found necessary to use it,
e.g.:
	/vc	system_u:object_r:devtty_t
	/pts	system_u:object_r:devtty_t

After adding entries to devfs_contexts, you will need to reboot for them
to take effect.  Russell Coker might be working on changes to devfsd to
dynamically manage the security contexts for devfs entries.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
