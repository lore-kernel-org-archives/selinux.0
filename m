Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2F0TRb014828
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:00:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2F0SqY027731
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:00:28 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id hB2F0S0o027725 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:00:28 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 78C1F32A6C0
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 10:00:40 -0500 (EST)
Subject: Re: policy under version control
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <20031202080830.E17580@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com>
	 <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil>
	 <20031201202813.I16359@lemuria.org>
	 <200312021430.51186.russell@coker.com.au>
	 <20031202080830.E17580@lemuria.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yVr5MD7db68F9AC6Fvn6"
Message-Id: <1070377124.16958.13.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 09:58:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yVr5MD7db68F9AC6Fvn6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[We're kind of drifting offtopic here; if anyone has questions about
arch/tla, gnu-arch-users@gnu.org is a better place]

On Tue, 2003-12-02 at 02:08, Tom wrote:

> That's exactly where a more modern replacement of 20-year-old CVS would
> help. From what I read about arch, it would be well possible to define,
> say:

When I was maintaining my own policy tree over the summer, I used arch.=20
(As I do for everything nowadays).  It's in=20

Archive: walters@debian.org--2003-debian=20
Location: http://arch.verbum.org/arch-debian

if you're curious.

> This is Tom's Whatever Policy Repository
> all macros and these and these file_contexts and domain/program files
> are identical to the upstream policy (*)
> these 2 files are different (**)
> these 4 files replace their counterparts upstream
> these 12 files are new
>
> (*) this definition is very much like a network-aware symlink
> (**) very much like a diff, with a built-in pointer to the URL of the
> original

You shouldn't think in terms of changes to individual files with arch.=20
All changesets in arch are atomic modifications to an entire tree. =20
So you don't really explicitly define what files are identical or
whatever; instead, if you don't modify them, they simply aren't included
in your changesets.

Also, instead of thinking of the distributed nature as a "network-aware
symlink", I think the most important thing is that it's a truly global
namespace of changesets (composed mostly of just simple patches), which
have archives which map to URLs.


--=-yVr5MD7db68F9AC6Fvn6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zKikOIkJWWp2WGURAtMiAJ44jchlwb9r5W6dhvWaXB0CtgoLHgCfQWqA
d/4Qvu7AvOqIhEDL6FzFN20=
=bDfL
-----END PGP SIGNATURE-----

--=-yVr5MD7db68F9AC6Fvn6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
