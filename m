Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28438
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:17:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA00496
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:15:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA00492 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:15:35 GMT
Date: Tue, 9 Jul 2002 10:16:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: automatic type transitions for pts in devfs
In-Reply-To: <3D2AECED.8090302@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207091011390.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Debian User wrote:

> So I focus on hooks.c. This is basically getting the inodes labelled
> correctly.
> Either we add some new fields(?) in the inode structure or we insert a
> condition that would make the inode get the proper label. Is that correct?

You could add a test within the sbsec->uses_genfs case to see whether the
filesystem type is devfs and whether the inode corresponds to a /pts node.
If so, then you want to use a transition SID as with the sbsec->uses_trans
case.  Otherwise, you would use genfs_contexts as usual.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
