Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MExONs023651
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 10:59:24 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MEu7K1024993
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 14:56:08 GMT
Subject: Re: run_init: Fork:: No such file or directory
From: Chris PeBenito <pebenito@gentoo.org>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>, wsalamon@tislabs.com, dwalsh@redhat.com
In-Reply-To: <1129985971.31615.31.camel@localhost.localdomain>
References: <1129985971.31615.31.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5O1r7uxueKb4U26qHBqj"
Date: Sat, 22 Oct 2005 10:55:47 -0400
Message-Id: <1129992947.26999.10.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5O1r7uxueKb4U26qHBqj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-22 at 13:59 +0100, Antoine Martin wrote:
> I've been running a system with SELinux enforcing mode for some time
> (Gentoo x86), but since yesterday I can't seem to use run_init to start
> daemons, it fails with:
> Fork:: No such file or directory

This problem should be fixed.  As far as I know, the pty/idr_remove
problem was only being caused in modules in selinux-base-policy, so make
sure you're at least on selinux-base-policy-20050821.

More details:

http://marc.theaimsgroup.com/?l=3Dselinux&m=3D112419712132326&w=3D2

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-5O1r7uxueKb4U26qHBqj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDWlLyvI7kLeavkkMRAgswAKCiI4w6LQjffqGFyk5CSfw1q+7XoACeJ8H7
arVKAEx+JmS8wJBjnQFLqbs=
=2s86
-----END PGP SIGNATURE-----

--=-5O1r7uxueKb4U26qHBqj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
