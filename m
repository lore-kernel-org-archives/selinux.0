Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AJO4Rb017406
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 15:24:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4AJLi5d029092
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 19:21:44 GMT
Message-Id: <200405101924.i4AJO0X0009629@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules 
In-Reply-To: Your message of "Mon, 10 May 2004 14:38:39 EDT."
             <1084214318.23757.285.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
            <1084214318.23757.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_169909664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 10 May 2004 15:24:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_169909664P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 14:38:39 EDT, Stephen Smalley said:

> I'd recommend just using an ordinary initcall.  Note that the SELinux
> module has several such ordinary initcall functions that handle similar
> issues, e.g. registering Netfilter hooks, registering the selinuxfs
> pseudo filesystem, registering a netdevice notifier for the netif table,
> and creating the netlink selinux socket.  I'd expect post_mountroot to
> die eventually; think early userspace.  Note that the SELinux initial
> policy load has been moved into userspace; we don't use post_mountroot
> anymore.

D'Oh! ;)

OK, I can do that... cancel the request for post_mountroot() then. ;)

> > 2) It stacks just fine with SELinux, except there's hooks that selinux/hooks.c
> > either doesn't hook, or it doesn't call secondary_ops() in its hook.
> 
> As I mentioned in a previous reply to Joshua Brindle (for his attempt to
> stack SELinux with digsig), we didn't want to encourage blindly stacking
> modules with SELinux, so we only provided secondary ops as required. 
> You will naturally encounter difficulties if your other security module
> wants to use the security fields.

I'm being very careful to *not* use the security fields, for exactly that
reason. All the info I'm examining is either somewhere in a dentry/inode or
passed in as an LSM API parameter.

Also, I'm intentionally restricting the scope of what I check for to a set of
things that are relatively easy to express in C code, but difficult to write
SELinux policy for - the two big predicates I'm testing are "if the process is
chroot'ed..." and "if the process is working with a file in a world-writeable
+t directory...".

I'm intentionally *not* doing any of the grsecurity patch's ACL stuff,
precisely because having 2 ACL systems active is guaranteed to be b0rked..

> We typically want to call the secondary module first, so that ordinary
> Linux capability checks are applied first and the code never reaches
> SELinux if they would deny access.  capget and capset are unusual in
> that they get or set state; they don't just mediate access.

Ahh.. That was the part I was missing... ;)



--==_Exmh_169909664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAn9bQcC3lWbTT17ARAmVLAJ4gNukZWha2cufJYDHIT0iM83cJlwCfe+V3
IzonSjbMRv92D0PqRDMk6gI=
=VDUS
-----END PGP SIGNATURE-----

--==_Exmh_169909664P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
