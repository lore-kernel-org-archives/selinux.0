Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA29646
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 15:32:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA03374
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 20:32:48 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id UAA03370
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 20:32:48 GMT
Date: Fri, 16 Mar 2001 15:31:25 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Mark Lucas <mlucas@imagelinks.com>
cc: selinux@tycho.nsa.gov
Subject: Re: seLinux and ReiserFS
In-Reply-To: <p04320404b6d82173b391@[208.24.120.15]>
Message-ID: <Pine.SOL.3.95.1010316151300.16239C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


It shouldn't be difficult to add support for ReiserFS to SELinux, but we
don't use it here, so we are unlikely to implement such support ourselves
unless there is a significant demand for it.  We provide general support
for all file systems for mapping persistent security identifiers (PSIDs)
to security contexts in fs/psid.c, so each file system type only needs to
implement support for binding a PSID to each on-disk inode.  With ext2, we
were able to use an unused field in the on-disk inode to store the PSID.
If ReiserFS has no unused fields in the on-disk inode, then one could
alternatively implement a mapping from inode numbers to PSIDs in a regular
file in a similar manner to the general mapping from PSIDs to security
contexts, at some loss in performance. 

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
