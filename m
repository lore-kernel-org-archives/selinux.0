Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3JSZWt002153
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 14:28:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3JSDC7009370
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 19:28:13 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id hA3JSCuw009363
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 19:28:13 GMT
Subject: Re: default policy package
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311040348.39876.russell@coker.com.au>
References: <20031103114353.GC13273@vnl.com>
	 <20031103152920.GD29928@vnl.com>
	 <1067876334.21113.75.camel@moss-spartans.epoch.ncsc.mil>
	 <200311040348.39876.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6szy2ZlTgZW2F9ARY4SC"
Message-Id: <1067887630.24100.8.camel@metropolis.verbum.private>
Mime-Version: 1.0
Date: Mon, 03 Nov 2003 14:27:10 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6szy2ZlTgZW2F9ARY4SC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-11-03 at 11:48, Russell Coker wrote:

> Thanks for that reference, I have run check-all and fixed bugs in my poli=
cy=20
> tree related to updfstab, kudzu, and netsaint.  Colin, I have found what=20
> appears to be a minor bug in check-all, I get the following error related=
 to=20
> mount:
>=20
> Testing authbind.te...
> Testing authbind.te...success.
> make[1]: *** No rule to make target `presymlink/mount.te', needed by=20
> `presymlink/automount.te'.  Stop.

This is due to the fact that automount.te has a Depends: mount.te, but
this is unnecessary since mount.te is included in the core
(non-optional) policy.  Deleting that Depends: line should make it work.
I'll try to come up with a patch soonish to make Depends: on core policy
work though.


--=-6szy2ZlTgZW2F9ARY4SC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/pqwNOIkJWWp2WGURAqcaAJ430HpeMnem17ryNcvPWvbcQ6X1VACdGlr5
2dROnuS39A/HuVH+JarpxqQ=
=KuvO
-----END PGP SIGNATURE-----

--=-6szy2ZlTgZW2F9ARY4SC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
