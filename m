Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20816
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 09:58:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA17835
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 14:57:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA17831
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 14:57:53 GMT
Date: Mon, 19 Nov 2001 09:57:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Harald von Fellenberg <Harald.Von-Fellenberg@sun.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux and non-ext[23] file systems
In-Reply-To: <200111191451.fAJEpsE26751@zurich-mail1.Swiss.Sun.COM>
Message-ID: <Pine.GSO.4.33.0111190953140.27226-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Nov 2001, Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office wrote:

> This said, I would like to re-raise the importance of non-ext2 file system
> support, notably ReiserFS. It has been pointed out before, by Stephen Smalley,
> that this should in principle be easy to integrate (the per-node sec context
> needs to be stored in a file rather than in an unused field of the on-disk inode
> structure). However, I am not aware of anyone tackling this implementation.

Only the original SELinux prototype was limited to the ext2 filesystem,
due to the use of a spare field in the on-disk ext2 inode to store the
persistent security identifier (PSID).  When we transitioned to LSM, we
extended the persistent label mapping to maintain the inode-to-PSID
mapping as a regular file because LSM does not provide filesystem-specific
hooks.  Hence, the LSM-based SELinux prototype should be able to use
ReiserFS, although we haven't tried it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
