Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5NFP0rT017311
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 11:25:00 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5NFOmpU013179
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 15:24:49 GMT
Subject: Re: generic pam authentication
From: Colin Walters <walters@verbum.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200406231305.28609.russell@coker.com.au>
References: <1087940480.17038.96.camel@optimus-prime.boston.redhat.com>
	 <200406231305.28609.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h2TDmWdUuwTdwQcYhauJ"
Date: Wed, 23 Jun 2004 11:23:32 -0400
Message-Id: <1088004212.14368.19.camel@optimus-prime.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-h2TDmWdUuwTdwQcYhauJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-23 at 13:05 +1000, Russell Coker wrote:
> On Wed, 23 Jun 2004 07:41, Colin Walters <walters@verbum.org> wrote:
> > What I think might be nice is a generic macro, say uses_pam(passwd)
> > which would grant any privileges necessary to use the libraries in the
> > PAM stack.  This macro would be defined in domains/pam.te, and would be
> > intended for customization by the administrator.  For example, if the
> > administrator decided to use PostgreSQL for holding user data, they
> > could insert the necessary privileges to talk to postgresql_port_t.
>=20
> That sounds like the correct approach.

Are you saying this after having seen my patch which uses the existing
attributes?


--=-h2TDmWdUuwTdwQcYhauJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2aB0OIkJWWp2WGURAhkbAJ4mTaOfc1K0umS26fgwRJ9ddn1dSQCff2bq
hROSMIzWuoLMTYE2PGGLlic=
=yxX5
-----END PGP SIGNATURE-----

--=-h2TDmWdUuwTdwQcYhauJ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
