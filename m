Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB6G0XRb010787
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 11:00:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB6FxplU022994
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 15:59:51 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id hB6FxoSX022982
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 15:59:50 GMT
Subject: Re: policy under version control
From: Colin Walters <walters@verbum.org>
To: Brian May <bam@snoopy.apana.org.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20031202095915.GA28563@snoopy.apana.org.au>
References: <20031129132619.GE26960@lukas.schuldei.com>
	 <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil>
	 <20031201202813.I16359@lemuria.org>
	 <200312021430.51186.russell@coker.com.au>
	 <20031202080830.E17580@lemuria.org>
	 <20031202095915.GA28563@snoopy.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QXDmz0zttet81EgQPahF"
Message-Id: <1070726271.24394.31.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Sat, 06 Dec 2003 10:57:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QXDmz0zttet81EgQPahF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-02 at 04:59, Brian May wrote:

> arch is obsolete now, and replaced with tla.

"arch" refers to the protocol.  "larch" refers to the old shell-script
implementation that I think you're thinking of.

larch, tla, ArX and others are all implementations of the arch protocol.

> tla is the only revision system that I know of (besides Bitkeeper)
> that supports distributed repositories, which I think could be rather
> important for selinux policy.

Right; I think the primary reason it would be good is because changes
tend to bounce between several people as well as the NSA.  So there is
no clear "upstream".

> The only question mark I have with tla, is that I have never seen a
> conflict, and I don't know how easy it is to resolve conflicts.

You get fewer spurious conflicts, and the conflicts that do occur are
often easier to resolve because changesets are individually structured
and easy to manipulate.

--=-QXDmz0zttet81EgQPahF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0fx/OIkJWWp2WGURApHpAJ9sbTfAWM1NZnXQcNKf0Sw32WDjZQCePyJZ
ioHWSrwZDEP/gQO8A/94Ymc=
=x5ou
-----END PGP SIGNATURE-----

--=-QXDmz0zttet81EgQPahF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
