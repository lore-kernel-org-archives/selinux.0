Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5O19852016453
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 21:09:08 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5O197pj010478
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 01:09:07 GMT
Subject: Re: [PATCH] libselinux: 2/2 Convert functions to use new get,set
	procattrcon
From: James Antill <jantill@redhat.com>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151094771.21012.94.camel@localhost.localdomain>
References: <1151094771.21012.94.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m5blmWIlRBkQt79qfDI/"
Date: Fri, 23 Jun 2006 21:09:05 -0400
Message-Id: <1151111346.21635.131.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-m5blmWIlRBkQt79qfDI/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 16:32 -0400, Eric Paris wrote:
> The below patch will convert
>=20
> -{get,set}fscreatecon()
> -{get,set}execcon()
> -{get,set}con()
> -getpidcon()
> -getprevcon()
>=20
> to use the new {get,set}procattrcon() generic functions.  The only two
> caveats are
>=20
> both getprevcon_raw() and getcon_raw() had callers elsewhere in
> libselinux.  So the raw version of these functions were left and now
> call directly into the raw version of the generic functions.

 I see you removed a bunch of *_raw() functions, you've changed the ABI
of the library and broken at least secon (in policycoreutils) and
gnome-vfs2. Is that intentional?

 The hidden_def() doesn't make them library local functions, just
creates the hidden version as an alias ... so ignore that part of my
previous email.

--=20
James Antill <jantill@redhat.com>

--=-m5blmWIlRBkQt79qfDI/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnJCx11eXTEMrxtQRAp1pAKDE5EJxkISVcNxiH/REQJ8yfhNgrwCeLese
4yfY1Clrfpq8zqjVbkIYwgA=
=aLg6
-----END PGP SIGNATURE-----

--=-m5blmWIlRBkQt79qfDI/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
