Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10431
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 11:28:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA05455
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 16:27:16 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA05451 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 16:27:15 GMT
Date: Fri, 18 Jan 2002 11:27:18 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: devfs_contexts
In-Reply-To: <20020118160058.2498232FE08@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201181118440.3743-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 18 Jan 2002, Russell Coker wrote:

> How exactly is devfs_contexts supposed to work, when is it applied?

The devfs_contexts file is consulted for each devfs inode when that inode
is first caught by a LSM hook.  So subsequent updates to devfs_contexts
won't be propagated to existing inodes.  Try using chcon on existing
nodes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
