Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18738
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 07:37:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA21837
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:35:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA21833 for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:35:47 GMT
Date: Mon, 8 Jul 2002 07:36:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: JW <jw@centraltexasit.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ReiserFS, ext3 and other file systems
In-Reply-To: <200207060201.11154.jw@centraltexasit.com>
Message-ID: <Pine.GSO.4.33.0207080734110.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 6 Jul 2002, JW wrote:

> I was just reading the install file and I saw the statment, that "if you're
> usign ext3, be sure to enable support for it".
>
> What exactly is the nature of "ext3" support? I would not think SE Linux
> would care that much about what FS it was on.
>
> I use ReiserFS, which I am rather fond of -- does SE Linux work on that?

The default kernel configuration (the defconfig file that ships with the
mainstream Linux kernel) doesn't enable the options for ext3 filesystem
support.  Hence, you need to enable that option when you configure the
kernel if you are using ext3 filesystems.  Likewise for reiserfs.

SELinux works with ext2, ext3, and (reportedly) reiserfs.  You need a
filesystem type that provides unique and persistent inode numbers for
files, so that SELinux can map inode numbers to security contexts
(indirectly via persistent SIDs).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
