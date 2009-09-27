Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8RDDEvq012223
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 09:13:14 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8RDCSDa017505
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 13:12:28 GMT
Received: by ewy7 with SMTP id 7so3896286ewy.41
        for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 06:13:11 -0700 (PDT)
Date: Sun, 27 Sep 2009 15:13:08 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: pam_namespace context inside of name.inst
Message-ID: <20090927131307.GA4502@notebook2.grift.internal>
References: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2009 at 11:12:20PM -0700, Justin Mattock wrote:
> I'm going crazy over here trying to figure
> out how one system created a context inside
> name.inst one way and another for the other system:
>=20
> the first system has inside of
> name.inst:
> system_u:object_r:file_t_name

This is wrong because the fs wasnt labelled properly
>=20
> and on the other system I have:
>=20
> name:object_r:user_home_dir_t_name

This is right

> the only difference with the machines is one machine
> had not been labeled yet, before turning on namespace.
>=20
> what should be the right context directory inside of
> name.inst?

Depends, i think theres 3 different possibilities (not sure)

first theres only name (no selinux) which create a dir with the user name
second is context which create a dir with the context of the usre home dir =
(user_home_dir_t and appends the user name
third is level , which creates a dir with the context of the user home dir =
and appends the username and also appends the level of the dir.

> --=20
> Justin P. Mattock
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq/ZOMACgkQMlxVo39jgT8/uACgzq5HXEDPRYIi+J8hEFEXYbyV
T/sAnA47td9+1T+jdNvo74CZVA000wIN
=oCuH
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
