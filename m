Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07020
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 10:37:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14771
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 14:36:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA14767 for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 14:36:18 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: XFS and LSM
Date: Thu, 13 Jun 2002 16:37:31 +0200
Cc: <emger@norwich.edu>, <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206130925150.23212-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206130925150.23212-100000@raven>
MIME-Version: 1.0
Message-Id: <20020613143731.6726F336@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jun 2002 15:28, Stephen Smalley wrote:
> On Thu, 13 Jun 2002, Russell Coker wrote:
> > Stephen says that the quota changes in question are already in 2.5
> > kernels, so if you can find a 2.5.x kernel patch for XFS then it should
> > not cause any difficulty (unless you use IA64).
>
> I'd actually suggest backporting the quotactl and *xattr hooks from
> the 2.5 LSM and SELinux to the 2.4 kernel with XFS merged.

It's probably easier that way.  Or you can just remove the few lines of code 
in question as I did.  If you don't need SE functionality on quotas that's an 
OK interim solution.

> > Ext2/3 are not the only file systems that will work without problems.
> > ReiserFS is working well for me, there's no reason to expect a problem
> > with Minix or any other Inode based file system either.
>
> The SELinux kernel module only tries using a persistent label mapping if
> it recognizes the filesystem type as being one of a set of known types
> that are known to have persistent and unique inode numbers.  It will
> currently only try to do this with ext2, ext3, and reiserfs unless you
> patch the module.  We'll likely make this configurable so that you can
> specify the set of legitimate filesystem types in the policy
> configuration.

Having it configurable would be good, but in the mean time it's not difficult 
to patch hooks.c .

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
