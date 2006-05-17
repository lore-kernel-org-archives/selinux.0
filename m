Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4HGMkVW017206
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 12:22:46 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4HGMjpH019814
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 16:22:45 GMT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by mail.and.org with esmtp (Exim 4.61)
	(envelope-from <jantill@redhat.com>)
	id 1FgOnN-0003OP-1p
	for selinux@tycho.nsa.gov; Wed, 17 May 2006 12:22:45 -0400
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
From: James Antill <jantill@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446AFED3.9010800@redhat.com>
References: <446AFED3.9010800@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ghWdtIsdXzFTX70xWwSk"
Date: Wed, 17 May 2006 12:22:44 -0400
Message-Id: <1147882964.3469.143.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ghWdtIsdXzFTX70xWwSk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 06:45 -0400, Daniel J Walsh wrote:
> Basically check if the previous lookup was the same context, if yes=20
> return the same translation.   Otherwise do the lookup.

 Are we sure one is enough, lsof -Z does both s0 and s0-s0:c0.c255 and
they are basically mixed (I appreciate it is much easier to code a cache
of 1 than >1 though).

 Also:

+       } else {
+               free(prev_t2r_trans);
+               free(prev_t2r_raw);
+               if (trans_to_raw_context(trans, rawp))
+                       *rawp =3D strdup(trans);
+               prev_t2r_trans=3Dstrdup(trans);
+               prev_t2r_raw=3Dstrdup(*rawp);

...this is bad when trans_to_raw_context, the first strdup() fails or
the last strdup() fails.

> Also included Russells patch for avcstat.

-                       printf("%10u %10u %10u %10u %10u %10u\n",
+                       printf("%10Lu %10Lu %10Lu %10Lu %10Lu %10Lu\n",

 It's somewhat minor, but that should be %llu %Lu is a somewhat common
extension. From man printf:

       ll     (ell-ell).  A following integer conversion corresponds to a l=
ong
              long int or unsigned long long int argument, or  a  following=
  n
              conversion corresponds to a pointer to a long long int argume=
nt.

       L      A following a, A, e, E, f, F, g, or G conversion corresponds =
 to
              a long double argument.  (C99 allows %LF, but SUSv2 does not.=
)

--=20
James Antill
<james.antill@redhat.com>


--=-ghWdtIsdXzFTX70xWwSk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEa03U11eXTEMrxtQRAroSAJ9bSonbMod+v1zNp1DQ+2m1Qd6ZEgCggW8R
veatORx8RDNUy6JtxKnthKY=
=FKRP
-----END PGP SIGNATURE-----

--=-ghWdtIsdXzFTX70xWwSk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
