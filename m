Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06175
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:28:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA17624
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:28:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA17620
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:28:41 GMT
Date: Thu, 13 Jun 2002 09:28:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <emger@norwich.edu>, <selinux@tycho.nsa.gov>
Subject: Re: XFS and LSM
In-Reply-To: <20020613131435.77B3340BF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206130925150.23212-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 13 Jun 2002, Russell Coker wrote:

> Stephen says that the quota changes in question are already in 2.5 kernels,
> so if you can find a 2.5.x kernel patch for XFS then it should not cause any
> difficulty (unless you use IA64).

I'd actually suggest backporting the quotactl and *xattr hooks from
the 2.5 LSM and SELinux to the 2.4 kernel with XFS merged.

> Ext2/3 are not the only file systems that will work without problems.
> ReiserFS is working well for me, there's no reason to expect a problem with
> Minix or any other Inode based file system either.

The SELinux kernel module only tries using a persistent label mapping if
it recognizes the filesystem type as being one of a set of known types
that are known to have persistent and unique inode numbers.  It will
currently only try to do this with ext2, ext3, and reiserfs unless you
patch the module.  We'll likely make this configurable so that you can
specify the set of legitimate filesystem types in the policy
configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
