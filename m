Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16088
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:36:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA23811
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:34:52 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA23807
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:34:52 GMT
Date: Thu, 11 Jan 2001 15:35:59 -0500
From: Bennett Todd <bet@rahul.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Subject: Re: IPSEC integration (was Re: SELinux and covert channels)
Message-ID: <20010111153559.H7355@rahul.net>
References: <200101111917.NAA33477@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
In-Reply-To: <200101111917.NAA33477@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jan 11, 2001 at 01:17:57PM -0600
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2001-01-11-14:17:57 Jesse Pollard:
> Personally, I wouldn't be happy having to trust a routing protocol
> for distributing security information.

You misunderstand what I'm thinking, which of course means I failed
to express myself well, I'm sorry. What comes of making it up as I
go along:-).

The routing protocol enters into things not to distribute any
security information, but rather (once the ipsec associations have
been established reflecting the policies specified in the central
database) to deduce the reachability consequences, and to learn how
to make use of the provided connectivity to actually reach desired
destinations. A routing protocol should enable learning about, and
using, transitive security associations.

> I think it would be too easy to leak the security info to
> intermediate routers that have no business examining the data.

The security info feeds a mechanism (as yet unspecified, presumably
it'll have to be done as part of the selinux+IPSec integration)
which establishes IPSec security associations. They provide a
virtual network, encrypted and authenticated, layered atop the
physical network that the real routers manipulate. It's this virtual
network that I'm concerned about routing; its routing traffic is no
more nor less security sensitive than the rest of the traffic
passing through the IPSec tunnels, and it'd lie in their security
domain, and be carried entirely within those tunnels. That's why I
keep considering BGP4 despite it's relatively dissatisfying features
match with the problem at hand, at least the BGP peering connections
should have no trouble nattering through IPSec tunnels.

> Even though routers should get trusted routing updates, I don't
> think they should be responsible for forwarding other security
> data on (less potential exposure that way).

I see a complete separation between the underlying network media,
which remains much as it is now, with routers, switches, wires,
routing protocols, etc., and a new virtual network, entirely
encrypted and strongly authenticated, riding atop that. The routing
protocol I'm pondering here is the one that would lie within, and
discover the connectivity nature of, this new layered virtual
network.

-Bennett

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XhkvHZWg9mCTffwRArPkAJoD8mnvne/UyftqWA7Nr2l2h6fFjQCgxnkK
ZzC+opHlPokfXZSbkw5Np7c=
=XovU
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
