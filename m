Date: Mon, 26 Jan 2009 20:24:36 -0500
From: Stephen Frost <sfrost@snowman.net>
To: SELinux@tycho.nsa.gov
Subject: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG 8.4
	security features]
Message-ID: <20090127012436.GD8123@tamriel.snowman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

  Hope the below hasn't already been sent here, if so, sorry, didn't
see it in the archives though.  This is very important for PostgreSQL
upstream addition of SE-Postgres.  I'm hopeful that there are some on
this list who can help the PostgreSQL core members be comfortable that
the patch does what is intended and properly implements the security it
claims.

The top of the current thread on -hackers can be found here:
http://archives.postgresql.org/pgsql-hackers/2009-01/msg01840.php
in particular:
http://archives.postgresql.org/pgsql-hackers/2009-01/msg01962.php
and others around that timeframe help frame this discussion.

In particular, we're looking for security experts who are familiar
with implementing SELinux (or similar..) in an RDBMS such as
PostgreSQL to review the patch, documentation, etc.

Please see below, and thanks.

	Stephen

----- Forwarded message from Bruce Momjian <bruce@momjian.us> -----

Date: Sat, 24 Jan 2009 10:36:22 -0500 (EST)
=46rom: Bruce Momjian <bruce@momjian.us>
To: PostgreSQL-announce <pgsql-announce@postgresql.org>
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
X-Spam-Status: No, score=3D-2.5 required=3D5.0 tests=3DAWL,BAYES_00 autolea=
rn=3Dham
	version=3D3.2.5
Subject: [ANNOUNCE] Need help on possible PG 8.4 security features

The PostgreSQL community is considering including security enhancements
in Postgres 8.4, e.g. row-level permissions and SE-Linux security.=20
However, to evaluate the patch and its usefulness, we need security
experts who want to use this capability or have used it in other
databases.

The most recent version of the patch is mentioned here:

	http://archives.postgresql.org/pgsql-hackers/2009-01/msg01680.php

Particularly interesting is the documentation patch:

	http://sepgsql.googlecode.com/files/sepostgresql-docs-8.4devel-3-r1460.pat=
ch

If you know someone who is interested in these features or can help in
discussing them, please have them subscribe to pgsql-hackers here:

	http://www.postgresql.org/community/lists/subscribe

Email discussion about this topic will start on Wednesday, January 28,
at 12:00 GMT, and will include the subject text "SE-PostgreSQL".

--=20
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + If your life is a hard drive, Christ can be your backup. +

---------------------------(end of broadcast)---------------------------
-To unsubscribe from this list, send an email to:

               pgsql-announce-unsubscribe@postgresql.org

----- End forwarded message -----

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl+YlQACgkQrzgMPqB3kij8zACbBOD8ohiR9KCFdJPuz8OJwCGB
cacAn0yGJRnEwWLpHMdOBlF4d2Q4NWT5
=R/10
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
