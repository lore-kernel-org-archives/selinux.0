Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59JbxrT022332
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 15:37:59 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i59JbtP2019919
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 15:37:55 -0400 (EDT)
Message-Id: <200406091937.i59Jbpmq025810@turing-police.cc.vt.edu>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: too many sysadmfile? 
In-Reply-To: Your message of "Wed, 09 Jun 2004 11:58:03 CDT."
             <1086800282.19414.26.camel@gorn.pebenito.net>
From: Valdis.Kletnieks@vt.edu
References: <1086800282.19414.26.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_840008494P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 09 Jun 2004 15:37:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_840008494P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Jun 2004 11:58:03 CDT, Chris PeBenito <pebenito@gentoo.org>  said:
> Its true that since sysadm_t can already relabel almost everything, it
> makes this change moot from a security perspective, since it can relabel
> a file to something it can modify.  However, by limiting normal access,
> it affords some protection against accidental overwrites and deletions,
> and from malicious programs a sysadmin might accidentally run.  In my
> opinion, the packagers (rpm_t, etc) should be the only ones with access
> all file_types.

Well... yes... True in theory, but... ;)

The other side of the coin is system manageability - let's say that rpm_t is
able to write all file types, but the admin can't.

Now, assume you do this:   "rpm -Fvh prog1.rpm prog2.rpm". and that the two
RPMs have pre-req chains  so you have to do both, and that create .rpmold (or
worse, .rpmnew) files when they install with diferent foo_t labels.

How many times do you need to 'newrole' to deal with all the .rpmnew files?

In the real world, the additional security it buys is limited, because the
admin *can* manage to newrole to each foo_t (unless you run with very strict
compartmentalization and can afford enough admins so you can give each one only
a few foo_t).  Those sites are probably the sort of military/spook systems
where newrole has been modified(*) to require a counter-password from the SSO or
similar on each newrole.. ;)

In any other environment, all it does is annoy the sysadmin and potentially
make them not bother installing a patch because the resulting afternoon of
newrole hell convinces them not to do it...

(*) IBM's AIX documents how to create a two-password logon sequence, where for
user A to get on, they have to enter A's password, and then B has to enter B's
password - amybody willing to admit to a pam module or similar hook for login/
su/newrole?


--==_Exmh_840008494P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAx2cOcC3lWbTT17ARArg2AKCFAgWjyTFocJ8E7A6rV2UmxvvTZgCgqAeG
rL82IMZLfwHWrUrOywBP4vU=
=qIlg
-----END PGP SIGNATURE-----

--==_Exmh_840008494P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
