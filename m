Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA22708
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 07:38:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA29298
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 11:37:50 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA29294
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 11:37:49 GMT
Date: Tue, 2 Jul 2002 07:37:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: problems with mount
In-Reply-To: <000501c22143$ad74beb0$6501a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0207020716560.24653-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 1 Jul 2002, Ryan Bergauer wrote:

> I'm having problems with mount. Before I issue a mount command,
> /mnt/cdrom is of type file_t. Immediately after running mount,
> /mnt/cdrom is labeled as unlabeled_t. Is that supposed to happen? That
> causes no end to problems in getting data from a CD in enforcing mode,
> if I'm correct.

Before you run mount, /mnt/cdrom resolves to an empty mountpoint directory
in the root filesystem.  After you run mount, /mnt/cdrom resolves to the
mounted directory on the CDROM, which is likely using an iso9660
filesystem.  There is no labeling information on the CDROM.  Naturally,
the import of unlabeled information into the system should be rigorously
controlled, and you'll need to add permissions if you want to permit it.

The newer genfs_contexts configuration should allow you to assign a
particular type to iso9660 filesystems so that you can then grant
permissions to that type while still leaving unlabeled_t inaccessible.
That isn't in the current release, but will be in the next one.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
