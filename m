Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EKVIHa014613
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 16:31:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6EKUInJ005825
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 20:30:18 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6EKUHhr005820
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 20:30:17 GMT
Subject: Re: enforcement and initrds
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
References: <1058151822.9620.25.camel@columbia>
	 <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1058214662.19392.31.camel@columbia>
Mime-Version: 1.0
Date: 14 Jul 2003 16:31:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-14 at 08:33, Stephen Smalley wrote:

> If CONFIG_SECURITY_SELINUX_DEVELOP=n, then the kernel is always in
> enforcing mode, so you won't be able to defer setting enforcing mode to
> the initrd. 

That's a good point, but then again we could just make DEVELOP=n instead
mean that once enforcing mode was switched on, it couldn't be switched
off.

>  You can assign a single type to all of the ramfs entries
> via genfs_contexts (but nothing more granular without further support
> either in the ramfs code or in the SELinux module) and then grant
> permissions to it. 

I tried this, but there appears to be a bootstrapping problem; the
policy says that romfs uses genfs; but the policy has to be loaded from
the initrd, which isn't labeled until we know what the policy is.

>  Or you can grant permissions to unlabeled_t to
> permit booting.

How?  Again that's part of the policy, so we face the same bootstrapping
problem.  

One other alternative would be to make kernel_t (SECINITSID_KERNEL) a
special SID that can do anything.  Anything with that type is a kernel
thread anyways, right?  So it could really do anything.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
