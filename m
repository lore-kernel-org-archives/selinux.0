Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4DLsBRb007468
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 17:54:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4DLpmRA009672
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 21:51:49 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
	by jazzswing.ncsc.mil  with ESMTP id i4DLpkjP009664
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 21:51:48 GMT
Message-Id: <200405132154.i4DLs2V3001577@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <jbrindle@snu.edu>, selinux@tycho.nsa.gov
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules 
In-Reply-To: Your message of "Thu, 13 May 2004 13:55:20 EDT."
             <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
            <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-163798766P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 13 May 2004 17:54:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-163798766P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 May 2004 13:55:20 EDT, Stephen Smalley said:

> overlap:  inode_permission and file_mmap.  In the case of
> inode_permission, you both inserted the secondary hook call after the
> null mask test (existence test).  Are you sure that you will never want
> to see such calls in a secondary module?

Hmm... I remember thinking about that issue, and deciding that for the set of
things that I was trying to address, that if there was an issue with
information leakage on file existence checks that it would be handled by the
SElinux code in the subsequent policy check..

Of course, now that you mention it, I was obviously not thinking clearly, as
we'll never call inode_has_perm either... ;)

> 2) Neither the post_mountroot nor pivotroot hooks are likely to survive
> long term IMHO, so I don't plan on adding them to the SELinux module.

It turned out that my need for post_mountroot hooks was spurious - I needed a
callback later than the security_initcalls, and it turns out a regular initcall
was sufficient.

The only thing I'm doing in the pivotroot check is protecting against a buggy
daemon that runs chroot'ed but still has a file descriptor open on a directory
outside the chroot (as can happen if it doesn't chdir() itself into the
chroot() directory, to prohibit a pivot_root out of the chroot environment
(basically, fchdir(open dir) and then pivot_root("../../..") yourself back to
the real root).

However, it occurs to me that I can live without that specific check, because
pivot_root will end up calling __user_file_walk, which will call
inode_permission on the components - and I'll be able to notice at that point
that ".." isn't under the chroot and toss an -EPERM back.  

So I'd not be heartbroken if those two callback didn't happen... :)


--==_Exmh_-163798766P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAo+56cC3lWbTT17ARAnGRAJ9IwtZpYmv89BCZAWKDNgzl4+q0VwCaA2VN
AWuJnNQvCCdXLdV13iDgzzc=
=ySHI
-----END PGP SIGNATURE-----

--==_Exmh_-163798766P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
