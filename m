Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5MNhcrT012659
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 19:43:38 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5MNhQAb012837
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 23:43:26 GMT
Subject: Re: generic pam authentication
From: Colin Walters <walters@verbum.org>
To: Dean Anderson <dean@av8.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.44.0406221926580.13825-100000@cirrus.av8.net>
References: <Pine.LNX.4.44.0406221926580.13825-100000@cirrus.av8.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JQVhal2SCESoKtqKsCdq"
Date: Tue, 22 Jun 2004 19:42:29 -0400
Message-Id: <1087947749.17038.148.camel@optimus-prime.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JQVhal2SCESoKtqKsCdq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-22 at 19:37 -0400, Dean Anderson wrote:
> You would need a macro that provides all the capabilities needed by each=20
> plugin that is (or might be, I guess) in the pam stack.  Each plugin migh=
t=20
> require different capabilities. =20

Yes, that's what I was saying.

> Idealy, what would be nice is to have capabilities for the code that
> belongs to shared libraries---so that as long as that code is executing,
> it has certain privileges and those privileges go away as soon as the
> shared library code returns to the caller.

Not possible in the current SELinux model.


--=-JQVhal2SCESoKtqKsCdq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2MPlOIkJWWp2WGURAjcCAJ9i/zHXdglQCV7Yjl7WosL1BtcSWgCggUV0
jwo9AFESWfAfTAxcZ0AzYSI=
=ty4w
-----END PGP SIGNATURE-----

--=-JQVhal2SCESoKtqKsCdq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
