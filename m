Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA01660
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 08:18:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA28769
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 12:17:47 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA28765
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 12:17:46 GMT
Date: Mon, 24 Jun 2002 08:17:59 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: compressed policy DB
In-Reply-To: <20020602001216.4F1A77125@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206240804030.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2 Jun 2002, Russell Coker wrote:

> 12 hours ago I gave a talk to the Nederlandse Linux Gebruikers Groep on SE
> Linux.  During the talk one of the audience members asked why the policy db
> can't be gzip compressed.
>
> This seems to be a good idea, the kernel already contains code for the gzip
> algorithm which is used for compressed initrd images, cramfs, and ppp.  Using
> the same code for policy db's would not add any significant code to the
> kernel, and would save significant amounts of disk space on an initrd.
>
> What do you think?

Sounds reasonable, but I'm not sure about the actual code re-use.  It
appears that the boot code and the ramdisk code each use an #include'd
copy of lib/inflate.c, the ppp code #include's drivers/net/zlib.c, and
cramfs relies on fs/inflate_fs.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
