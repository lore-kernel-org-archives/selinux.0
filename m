Subject: Re: In FC8 I would like to start playing with trusted X.
From: James Antill <jantill@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4649FFA2.9060701@redhat.com>
References: <4649FFA2.9060701@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F2gR9+OutJZxXwhL0vYq"
Date: Wed, 16 May 2007 10:41:23 -0400
Message-Id: <1179326483.16624.21.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-F2gR9+OutJZxXwhL0vYq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-15 at 14:44 -0400, Daniel J Walsh wrote:
> Supposedly The SELinux XExtensions are in FC7 and beyond so time to=20
> start using them.
>=20
> But lets start simple ...
>=20
> Some of you are looking at using Trusted X for MLS, but I want to look=20
> at this from a targeted policy point of view.  What are the security=20
> goals of a normal Fedora user.=20
>=20
> Lets establish two tangible goals.
>=20
> 1. Only the application with focus can get keyboard input.  So if I am=20
> on a web page that is asking me for a password (On Line Banking) Only=20
> Firefox can read the input.  Not Thunderbird.
> Theoretically I could run this with all apps mostly unconfined.
> firefox_t can capture input on firefox_t.  While unconfined_t can not.

 This might go well, I'm not sure, and if it does would be a big plus :)

> 2. No apps except gimp can do a screen capture.  Again I want all apps=20
> mostly unconfined
> My goal is to get  a policy that prevents any app from screen capture=20
> including
> unconfined_t.  Bug gimp_t in the unconfined domain can.

 You will need to include gnome-screenshot as well as gimp here though,
or a lot of people will complain (PrintScreen). With those two, this
might be able to work (None of the gnome-screensaver actions try to take
shots now, IIRC).

--=20
James Antill <jantill@redhat.com>

--=-F2gR9+OutJZxXwhL0vYq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGSxgT11eXTEMrxtQRAg3VAKClVEP73u9XFJCgZj3EFTPFm0yioACcDnYG
9nN04gKMpbltgbWCjd1CS5Q=
=85VU
-----END PGP SIGNATURE-----

--=-F2gR9+OutJZxXwhL0vYq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
