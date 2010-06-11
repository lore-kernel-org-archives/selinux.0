Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5BFfIrh031635
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 11:41:18 -0400
Received: from tamriel.snowman.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5BFeUEp017321
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 15:40:30 GMT
Date: Fri, 11 Jun 2010 11:41:17 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Greg Smith <greg@2ndquadrant.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SELinux <selinux@tycho.nsa.gov>,
        Robert Haas <robertmhaas@gmail.com>
Subject: Re: Report of PGcon2010
Message-ID: <20100611154117.GS21875@tamriel.snowman.net>
References: <4C11CE43.7000509@ak.jp.nec.com> <4C125496.1060107@2ndquadrant.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mOpj7K1kSb4bRckO"
In-Reply-To: <4C125496.1060107@2ndquadrant.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mOpj7K1kSb4bRckO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg, all,

* Greg Smith (greg@2ndquadrant.com) wrote:
> This pushes off the problem of how to keep labels consistent in the face
> of things like table changes to being a database superuser only task,
> not one you can delegate to other users.

As an additional side-note that might be relevant to this community,
I've been talking to some of the other PG developers (Tom Lane, Robert
Haas, etc) about adding more granularity to the PG role options to
eliminate the need to have an actual PG "super-user".  There are still
some specific tasks which require super-user (in particular, the
"replication" user must be a super-user, the user which can issue
pg_start_backup/pg_stop_backup commands, etc), but if we make those into
separately tracked options, we could provide a system with no user
having the actual "super-user" bit set which would still be very usable.

I'm hoping to target that for 9.1, but I certainly can't make any
promises.  One thing to note in all of this, as has likely been said
here already, right now this is just about all spare-time work by the PG
individuals and companies who are interested in it.  Organizations
interested in this speaking up that they'd like to use it, or even
better sponsor work on it, in whatever way they can, would certainly
increase the availability of PG community resources for this project and
things like RLS being added to PG.

	Thanks!

		Stephen

--mOpj7K1kSb4bRckO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwSWR0ACgkQrzgMPqB3kigJ7wCfcPofOMQYgr+9AGf+AskPZWWz
ipUAnRcZqQ8NZjYLvpmrFbSDN9FHqQOC
=C/J2
-----END PGP SIGNATURE-----

--mOpj7K1kSb4bRckO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
