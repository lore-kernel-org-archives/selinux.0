Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12888
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 10:34:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA26498
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:33:43 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA26494
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:33:42 GMT
Date: Thu, 11 Jan 2001 10:34:31 -0500
From: Bennett Todd <bet@rahul.net>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
Subject: IPSEC integration (was Re: SELinux and covert channels)
Message-ID: <20010111103431.C21255@rahul.net>
References: <20010111005355.A20214@bunuel.tii.matav.hu> <Pine.SOL.3.95.1010111084456.23465H-100000@clipper.gw.tislabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BOr3uFpVABmJfvZe"
In-Reply-To: <Pine.SOL.3.95.1010111084456.23465H-100000@clipper.gw.tislabs.com>; from sds@tislabs.com on Thu, Jan 11, 2001 at 09:01:41AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--BOr3uFpVABmJfvZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2001-01-11-09:01:41 Stephen Smalley:
> Additionally, although mandatory access controls have been
> implemented for sockets, the controls are currently limited
> because support for communicating packet labels across the network
> has not yet been implemented.  As discussed in the documentation,
> the intent is to use IPSEC security associations to implicitly
> label packets once IPSEC is integrated.

This I thought was the most exciting single bit of the whole
announcement.

While any MAC implementation is certainly interesting, and the more
expressive ones are especially appealing for their potential for
sandboxing, the real hard problems we're fighting with now, and
expecting to be battling in the near future, center on defining
really tight security perimeters around distributed apps. The
ability to have a coherent enforcement of a centrally-specified
policy over all the data throughout a distribute app is very, very
exciting indeed.

Especially to me, since I've been telling people that it's the next
big step for some time now:-).

-Bennett

--BOr3uFpVABmJfvZe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XdKHHZWg9mCTffwRAuImAKCtuSKguIMtEWmCvd5ZWXEleV/E9ACfcYTn
F3AxRKWWkEjEUKfxp3kvKD4=
=wBLz
-----END PGP SIGNATURE-----

--BOr3uFpVABmJfvZe--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
