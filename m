Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9J6xIi015024
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 14:06:59 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9J5KPS016120
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 19:05:21 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 20:07:00 +0100
Date: Thu, 9 Dec 2004 20:07:02 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <rcoker@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
Message-Id: <20041209190701.GF8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B8826D.30105@redhat.com> <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil> <1102614445.4509.25.camel@aeon> <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
In-Reply-To: <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Smalley <sds@epoch.ncsc.mil> [2004-12-09 19:50]:
> On Thu, 2004-12-09 at 12:47, Russell Coker wrote:
> > However there still are issues because sysadm_t can read symlinks of
> > type user_tmp_t, so a user can attempt a symlink race condition attack
> > on the administrator.
>=20
> Yes, that should be removed IMHO.  Currently only occurs due to allow
> rule on sysadmfile:lnk_file.  =20

A while ago we had this discussion on the lsm-list. Colin suggested
using the following patch to prevent symlinks attacks:

--- orig/constraints
+++ mod/constraints
@@ -67,3 +67,7 @@
 constrain socket_class_set { create relabelto relabelfrom }=20
 	( u1 =3D=3D u2 or t1 =3D=3D privowner );
=20
+# read symlinks under /tmp only if owners match
+constrain lnk_file read
+	( t2 !=3D tmpfile or u1 =3D=3D u2 );
+=20

I have used this patch for a few weeks on our systems (university, ~150
computers, ~4000 users, all with separate SELinux identity), no
complaints or problems so far (except the tetex_data_t change I posted
today) So I'd like this patch included in cvs policy.
Of course, this is only really useful if you have separate user
identities for your users.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuKJVxWIrrrL0q+cRAngrAKCpLgO/aFv9JE6dCMqgtPRxIWpzqwCfSKe6
DK8azvESSJoNeA6rmlryQkQ=
=z2/Q
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
