Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0R3kM4e027024
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2009 22:46:22 -0500
Received: from tamriel.snowman.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0R3kLRs024056
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 03:46:21 GMT
Date: Mon, 26 Jan 2009 22:46:18 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Sanjai Narain <narain@research.telcordia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Mitigating SQL injection attacks with access-control
Message-ID: <20090127034618.GI8123@tamriel.snowman.net>
References: <497E7458.90404@research.telcordia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
In-Reply-To: <497E7458.90404@research.telcordia.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sanjai,

* Sanjai Narain (narain@research.telcordia.com) wrote:
> A lot has been written about validating inputs to avoid SQL injection =20
> attacks. Have there been attempts to mitigate such attacks with =20
> access-control policies, perhaps combining those for SELinux and MySQL? =
=20
> Thanks for any answers. Best regards. -- Sanjai

I'm not sure how appropriate this if for this list, but, I don't believe
SELinux and/or MySQL will solve SQL injection issues.  They may help to
mitigate the results, but the best approach, by far, is to use proper
database prepared queries.  By using prepared queries and passing in any
user-supplied data seperately, you completely remove the SQL injection
problem.  By using VIEWs and stored procedures you can even simplify the
queries that are done by the application and provide a kind of API
between the application and the database that allows both to change
without requiring a change of the other.

This is a much better solution to any kind of input validation when it
comes to avoiding SQL injection.  Of course, proper foreign keys in your
database, proper types, and CHECK constraints, will minimize the
possibility of garbage/invalid data ending up in your database.  Having
these database-level checks is really important to maintaining the
integrity of your data.  Even if you have such checks in your
application, it often happens that people access the database without
using the application or while bypassing the application checks.

Regarding SQLinux and MySQL specifically- I don't believe MySQL has
SELinux hooks built in or available as a patch (if anyone is aware of
one, I'd be very curious to see it..).  The PostgreSQL community is
currently evaluating an SELinux patch (SE-Postgres) to add row-level
security, etc, to the core PostgreSQL distribution.  If you're
interested in an open source RDBMS with row-level security and SELinux
hooks, you might start a discussion on the pgsql-general list at
http://www.postgresql.org/community/lists/.

	Thanks,

		Stephen

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl+g4oACgkQrzgMPqB3kihnEQCeKGH6LUCb/Sgm3p2D6LiOwMY3
/u8An0MVtAEwBPsD1O3BNiNQkh4b4dvQ
=NhPM
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
