Message-Id: <200507272047.j6RKlW16006361@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size 
In-Reply-To: Your message of "Wed, 27 Jul 2005 13:01:36 EDT."
             <1122483696.19989.151.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil> <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu> <1122478335.19989.133.camel@moss-spartans.epoch.ncsc.mil> <200507271636.j6RGaCc1004671@turing-police.cc.vt.edu>
            <1122483696.19989.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122497252_4810P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 27 Jul 2005 16:47:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1122497252_4810P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Jul 2005 13:01:36 EDT, Stephen Smalley said:

> Looks like you have CONFIG_DEBUG_SLAB enabled.  With it disabled, the
> objsize (on x86) is 32 bytes before the patch and 16 bytes afterward.

Yep, that's right..

> Note that the second patch set which I'm still developing should
> significantly reduce the number of nodes (by a factor > 10) by not
> expanding attributes, thereby saving even further memory.  This will
> slow down the kernel's access vector computation, but only on a cache
> miss.

I'll be happy to test them when they're ready..

(For the record, the first 2 patches apply and run fine on 2.6.13-rc3-mm2 as
well as against -mm1....)

--==_Exmh_1122497252_4810P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5/LkcC3lWbTT17ARApRUAJ9sf0mf5sA2Trr75Nc+7/Iq9FBRkgCeOViN
ijfFVbumXtLkTCrviqnEayA=
=l0xS
-----END PGP SIGNATURE-----

--==_Exmh_1122497252_4810P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
