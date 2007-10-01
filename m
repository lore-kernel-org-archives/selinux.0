Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91JFeJ1012333
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 15:15:40 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l91JFdEn024920
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 19:15:39 GMT
Subject: RE: [PATCH] ustr cleanups (policyrep branch)
From: James Antill <jantill@redhat.com>
To: Todd Miller <Tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010FFCDC@exchange.columbia.tresys.com>
References: <1191221196.29631.44.camel@code.and.org>
	 <6FE441CD9F0C0C479F2D88F959B01588010FFCDC@exchange.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FYqY+Keq+kxPWSYXs+gd"
Date: Mon, 01 Oct 2007 14:40:12 -0400
Message-Id: <1191264012.29631.60.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FYqY+Keq+kxPWSYXs+gd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-10-01 at 13:35 -0400, Todd Miller wrote:

> That looks sane to me.  Is there a reason you based this off of
> policyrep instead of trunk?

 Just me not having used SVN much, I did a search for ustr in the
branches directory and went from there ... didn't even notice the top
level trunk directory.
 The patch seems to apply without conflicts with -p3 from inside the
trunk dir.

--=20
James Antill <jantill@redhat.com>

--=-FYqY+Keq+kxPWSYXs+gd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHAT8M11eXTEMrxtQRAij/AJsEjYL95Nzr6X6RLFz4hZ+rHDFXWACbBuN+
N2JeknPnsl7/AHl9kSuaAXU=
=ZDgD
-----END PGP SIGNATURE-----

--=-FYqY+Keq+kxPWSYXs+gd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
