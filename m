Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i215coRb025233
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 00:38:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i215bClK028046
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 05:37:12 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id i215bBOX028043
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 05:37:12 GMT
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <20040229160106.GH24151@vnl.com>
References: <20040228181418.GO11147@vnl.com>
	 <200402291344.28017.russell@coker.com.au> <20040229042610.GA11147@vnl.com>
	 <200402291545.38528.russell@coker.com.au>  <20040229160106.GH24151@vnl.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dnrsnyv3qngnqEo8JdQ7"
Message-Id: <1078117604.397.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 00:06:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dnrsnyv3qngnqEo8JdQ7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-29 at 11:01, Dale Amon wrote:

> After Colin's install script removes klogd.te, the policy build fails:

Are you using my very old selinux-policy-default package?  You must be,
since Russell hasn't yet merged the smarter installation script into his
packages.  Anyways at this point, I strongly suggest using Russell's
policy packages.  Hopefully soon we'll get that script merged in.


--=-dnrsnyv3qngnqEo8JdQ7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAQsTkOIkJWWp2WGURAuacAJsF4Aj27D+u8Gengriz47ZKJpuINACdE86h
nNNPVJpanMsoahAzlGYDSDQ=
=J8xi
-----END PGP SIGNATURE-----

--=-dnrsnyv3qngnqEo8JdQ7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
