Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AIckRb017077
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:38:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4AIciYW028212
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 18:38:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4AIciBf028209 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 18:38:44 GMT
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1084214318.23757.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 May 2004 14:38:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-05-09 at 22:38, Valdis.Kletnieks@vt.edu wrote:
> 1) if you have an LSM that's non-modular, you can't call the
> register_sysctl_table() function from the security_initcall(), because it
> happens before the sysctl infrastructure gets set up - you get a very dead
> system, even early_printk doesn't do any good...  I ended up adding a call in
> post_mountroot(), which was meant for that sort of thing...

I'd recommend just using an ordinary initcall.  Note that the SELinux
module has several such ordinary initcall functions that handle similar
issues, e.g. registering Netfilter hooks, registering the selinuxfs
pseudo filesystem, registering a netdevice notifier for the netif table,
and creating the netlink selinux socket.  I'd expect post_mountroot to
die eventually; think early userspace.  Note that the SELinux initial
policy load has been moved into userspace; we don't use post_mountroot
anymore.

> 2) It stacks just fine with SELinux, except there's hooks that selinux/hooks.c
> either doesn't hook, or it doesn't call secondary_ops() in its hook.

As I mentioned in a previous reply to Joshua Brindle (for his attempt to
stack SELinux with digsig), we didn't want to encourage blindly stacking
modules with SELinux, so we only provided secondary ops as required. 
You will naturally encounter difficulties if your other security module
wants to use the security fields.

> Question:  In some places, hooks.c calls secondary_ops->foo() before doing
> its own checking, and some places, it does it afterwards.  I'm failing to
> understand the rhyme and reason...

We typically want to call the secondary module first, so that ordinary
Linux capability checks are applied first and the code never reaches
SELinux if they would deny access.  capget and capset are unusual in
that they get or set state; they don't just mediate access.  Hence, the
capset_set secondary hook must be called after the SELinux check.  The
capget secondary hook could be called first (since an error in the
subsequent SELinux check will still prevent copying to userspace by the
caller), but it doesn't matter much since capget doesn't perform any
checking of its own.  The capset_check hook should likely be called
first, to avoid a spurious SELinux check if the base logic would deny
anyway.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
