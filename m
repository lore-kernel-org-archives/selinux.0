Subject: Re: sys_admin cap breakup
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <407A001D.3010805@snu.edu>
References: <407A001D.3010805@snu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-609AmrBiOj/WZr4EFDq9"
Message-Id: <1081774708.22078.1.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Mon, 12 Apr 2004 08:58:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-609AmrBiOj/WZr4EFDq9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-04-11 at 22:34, Joshua Brindle wrote:

> So this is a question for the guys that are doing kernel work and=20
> possibly interacting with linus and friends. How plausible would it be=20
> to suggest breaking up caps that give lots of access in the next major=20
> version, 2.7 or 2.8? do you think they'd go for it?

Maybe a better solution is to simply stop using capabilities entirely,
and make the necessary changes to the policy.

--=-609AmrBiOj/WZr4EFDq9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAepJzOIkJWWp2WGURAsFmAJ4ygQuqIchSBQ/W4ZiQVdoJ48RffgCbBf/8
GucqcoTOL1NGbi/jt/yP6iU=
=odtY
-----END PGP SIGNATURE-----

--=-609AmrBiOj/WZr4EFDq9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
