Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04988
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 13:47:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA18844
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 17:47:12 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA18838
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 17:47:12 GMT
Date: Mon, 24 Jun 2002 13:46:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ichsid
In-Reply-To: <Pine.GSO.4.33.0206241322320.10386-301000@raven>
Message-ID: <Pine.GSO.4.33.0206241343570.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 24 Jun 2002, Stephen Smalley wrote:

> Afterward, 'setfiles -i pathname ino context' can be used to set the
> context of an inode, where pathname is the path of any file within the
> desired filesystem and ino is the inode number.  If run on a SELinux
> kernel, it will use the new ichsid call; otherwise, it will directly
> mutate the persistent label mapping.

Sorry, I mis-spoke.  pathname should be the path of the root of the
desired filesystem, as with the typical setfiles usage.  Otherwise, when
run on a non-SELinux kernel, setfiles won't find the persistent label
mapping properly.  When run on a SELinux kernel, pathname can actually be
any path within the filesystem, since the ichsid call merely extracts the
superblock from the looked up inode.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
