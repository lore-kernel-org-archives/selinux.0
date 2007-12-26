Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBQNgEGT029388
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 18:42:14 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBQNgEai009103
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 23:42:14 GMT
Subject: Re: cant SSH/Console Login and no deny/error messages
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30712261459q178f2755g2427f57e1b791aa@mail.gmail.com>
References: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
	 <dd18b0c30712261459q178f2755g2427f57e1b791aa@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t6ZY5IHHvyllT2wXIgOU"
Date: Wed, 26 Dec 2007 17:42:12 -0600
Message-Id: <1198712532.4073.871.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-t6ZY5IHHvyllT2wXIgOU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Although that did produce a number of additional deny messages, even
allowing all of them, still does not allow me to login from the console
or ssh. doesn't matter if I'm root a standard user or a selinux user.


Does any one know of a simple way to get RHEL4 targeted to recognize se
users? I can't quite figure out where they are setting the default
domain transition. Like I said before, I just need to keep root away
from a few programs and a data file. I've set up a type and a user,
relabled the fs with the new types etc etc. added my user to users, it
matches the name in /etc/passwd exactly.


I think I generally understand whats going on, I think I'm just
suffering from use of an out of date tool chain.=20


On Wed, 2007-12-26 at 14:59 -0800, Justin Mattock wrote:
> Hello I think you need to; make enableaudit in the policy. with
> selinux-policy-default the location would be /etc/selinux/src with
> refpolicy-strict I'm not too sure.=20
> regards;
>              --Justin P. Mattock
> On Dec 26, 2007 1:35 PM, Jeremiah Jahn <jeremiah@goodinassociates.com>
> wrote:
>         I've trying to get SELinux strict up and running on a RHEL4-U4
>         box and
>         not having much luck. I have one account and 3 programs that I
>         need to
>         protect from root. I was unable to get targeted to login under
>         the user=20
>         that I created, something about the policy always defaulting
>         to user_u.
>         So Fine, I tried to install the strict/ref policy from the
>         tresys and
>         cips. Dues to this being an x86_64 system, that didn't go well
>         either.=20
>         Trying plan C  I went with the FC3 strict policy. Obviously
>         some
>         improvemtns have been made since then, but this was the first
>         strict
>         policy I was able to install without completely hosing my
>         system. sshd
>         and login seem to really like having libselinux(64) around.=20
>        =20
>        =20
>         So my question here has to possible answers:
>        =20
>         1) where the heck can I find some rpms for RHEl4 -x86_64 and
>         the most
>         recent ref policy.
>        =20
>         --OR--
>        =20
>         2) what could possibly be causing no [avc denied] messages to
>         be logged.=20
>         Most of the messages I have used with audit2allow to to try
>         and get
>         everything to work. Finally I go to the point of having no
>         more messages
>         even when rebooting the machine. If I put things into passive
>         mode
>         still no more messages, this is with constant reloading of the
>         policy to
>         clear the avc cache.
>        =20
>         help please.
>        =20
>        =20
>        =20
>        =20
>        =20
>        =20
>        =20
>        =20
>         "A fractal is by definition a set for which the Hausdorff
>         Besicovitch=20
>         dimension strictly exceeds the topological dimension." --
>         Mandelbrot,
>         "The Fractal Geometry of Nature"
>=20
A fool-proof method for sculpting an elephant: first, get a huge block
of marble; then you chip away everything that doesn't look like an
elephant.

--=-t6ZY5IHHvyllT2wXIgOU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHcubU6caZY8jbHDkRAqhXAJ0XxOTr0TfRnQMWWFQg6BN2fv2qPQCgkgVN
soEK3mbWAg0/S4Gpxu77uRY=
=xZ2U
-----END PGP SIGNATURE-----

--=-t6ZY5IHHvyllT2wXIgOU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
