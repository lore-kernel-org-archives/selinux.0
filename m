Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13962
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:10:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA13480
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:08:46 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA13476
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:08:45 GMT
Date: Thu, 11 Jan 2001 12:10:00 -0500
From: Bennett Todd <bet@rahul.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Subject: Re: IPSEC integration (was Re: SELinux and covert channels)
Message-ID: <20010111120959.I21255@rahul.net>
References: <200101111634.KAA82194@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CDSQlumANh/CoDwR"
In-Reply-To: <200101111634.KAA82194@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jan 11, 2001 at 10:34:50AM -0600
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--CDSQlumANh/CoDwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sounds like you're thinking along the same lines I am.

Seems to me like there are a few very, very hard parts to this
problem.

One is designing a database capable of flexibly representing the
sort of permission and delegation relationships that show up in real
organizations. That's a currently open problem, and I know lots of
people are working on it. I kinda suspect by the time it gets
solved, the other bits will be all lined up.

Another piece to the puzzle is providing facilities for a
centralized policy specification database to be consistently
enforced with a single mechanism; it seems like it's within the
bounds of possibility that selinux, with some suitable integration
with ipsec, may possibly provide the needed mechanism.

I could believe that a PK database of some sort may provide the glue
required to associate identities as specified in the above policy
database with real entities. I'd be happier if it didn't look so
likely that the PK database will end up being based on the
ugliest-of-all-possible-worlds design X.509, but I suppose that can
be lived with.

Another component I've been thinking about is more a piece of
plumbing that'll be needed to make things work as they should,
rather than a fundamentally separate security component. The fantasy
of a fine-grained integration of ipsec security associations with
fine-grained, user/app level security policy specification, implies
that ipsec security associations are going to be coming up and going
down in a very fluid fashion. It seems to me that making working
distributed apps is going to end up requiring dynamic routing
through these transient tunnels. I'm still pondering that one,
though. On the one hand it seems like OSPF's dynamically
self-configuring, multicast flooding nature would be the responsive
and maintainable approach to desire; on the other hand it seems like
BGP4's simplicity of running through straight TCP connections is
more likely to actually _work_ over ipsec. I'm hoping that this new
evolution won't require actually inventing another working dynamic
routing protocol, but I've not yet gotten a really happy feeling
about that question.

-Bennett

--CDSQlumANh/CoDwR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XejnHZWg9mCTffwRAgBTAJ9i0jCgrv9gaSABnnGXXu5GfTr/zwCfTK/K
KjfPhkTU9PqHY0DYcmlIC6M=
=VdaA
-----END PGP SIGNATURE-----

--CDSQlumANh/CoDwR--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
