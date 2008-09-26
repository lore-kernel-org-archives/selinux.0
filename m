Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QAfxgA000790
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 06:41:59 -0400
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8QAf0rt012174
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 10:41:00 GMT
Received: by nf-out-0910.google.com with SMTP id b21so345435nfd.4
        for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 03:41:56 -0700 (PDT)
Subject: Re: How to find SELinux policy type?
From: Dominick Grift <domg472@gmail.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Valdis.Kletnieks@vt.edu,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <48DCB88E.3080503@kaigai.gr.jp>
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>
	 <48DC5C16.9040607@ak.jp.nec.com>
	 <1222421896.24783.7.camel@sulphur.notebook.internal>
	 <48DCB88E.3080503@kaigai.gr.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Kv3/p+uMwGQ4coRcO5sF"
Date: Fri, 26 Sep 2008 12:41:54 +0200
Message-Id: <1222425714.24783.13.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Kv3/p+uMwGQ4coRcO5sF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-09-26 at 19:25 +0900, KaiGai Kohei wrote:

>=20
> Was the sepostgresql related policy backported to F9 selinux-policy?

Not sure about that. I know that i have selinux-policy installed plus
sepostgresql for f9.

sepostgresql-8.3.3-2.869.fc9.x86_64
sepostgresql 2.869
selinux-policy-3.3.1-94.fc9.noarch.rpm

Thanks
--=20
Dominick Grift <domg472@gmail.com>

--=-Kv3/p+uMwGQ4coRcO5sF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjcvG8ACgkQL00QnzrVtlwfQwCgvnBJ0J3rgnP1yqWTyf9wMTYU
cqYAn1jnFhhe8xo9Vow9HsxmD7X1zfXJ
=qdS6
-----END PGP SIGNATURE-----

--=-Kv3/p+uMwGQ4coRcO5sF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
