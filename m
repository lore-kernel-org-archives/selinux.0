Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38H4pRb019014
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:04:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i38H4on0022929
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:04:51 GMT
Message-Id: <200404081704.i38H4ncM017181@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy backward compatibility 
In-Reply-To: Your message of "Thu, 08 Apr 2004 09:21:35 EDT."
             <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1842369464P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 08 Apr 2004 13:04:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1842369464P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Apr 2004 09:21:35 EDT, Stephen Smalley said:

> seems inconsistent with typical kernel practice.  James has proposed
> dropping the backward compatibility support, and requiring that every
> installed kernel have a suitable binary policy installed, possibly
> encoding the associated kernel release (e.g. output of uname -r) in the
> binary policy pathname (and possibly doing likewise for the checkpolicy
> program?).  
> 
> Thoughts?

What would be the upgrade path when installing a new kernel?  Would there be an
option for the policy tools similar to the current mkinitrd, that allows you to
specify the kernel version to use (so you can build an initrd for the kernel
you're about to try to boot)?  The other option is having to boot into some
sort of single-user mode and then do the make reload/relabel before continuing
to multiuser.

What would the scheme be if you had to for some reason boot an older kernel
(for instance, having to drop back to 2.6.5-mm1 because -mm2 is b0rked for
something)?


--==_Exmh_1842369464P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdYYxcC3lWbTT17ARAmL1AJ9GUHSNBKi40zW1EKvsAsV4LSDT6wCgw90/
l8gxMQ+0DQ1kxbgiEmpxRdA=
=pN3d
-----END PGP SIGNATURE-----

--==_Exmh_1842369464P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
