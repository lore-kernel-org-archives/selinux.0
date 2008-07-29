Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TDtnkL027487
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 09:55:49 -0400
Received: from QMTA05.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TDtmXf016040
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 13:55:49 GMT
Subject: Re: unconfined_t and user_home_dir_type
From: Chris PeBenito <pebenito@gentoo.org>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200807292220.17592.russell@coker.com.au>
References: <200807291850.30191.russell@coker.com.au>
	 <1217331219.20373.139.camel@moss-spartans.epoch.ncsc.mil>
	 <200807292220.17592.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jil0OnVZV6zyFn8e28JU"
Date: Tue, 29 Jul 2008 09:55:31 -0400
Message-Id: <1217339731.4934.26.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Jil0OnVZV6zyFn8e28JU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-29 at 22:20 +1000, Russell Coker wrote:
> On Tuesday 29 July 2008 21:33, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Tue, 2008-07-29 at 18:50 +1000, Russell Coker wrote:
> > > Currently we have the attributes user_home_dir_type and user_home_typ=
e
> > > applied to the main types for the home directory of regular users in =
a
> > > strict policy configuration (this means user_t etc).
> > >
> > > While it is possible to have unconfined_t and user_t on the same syst=
em,
> > > I don't expect this to be a common configuration.  In fact I expect t=
hat
> > > in practice they will be mutually exclusive.
> >
> > Actually, it is a common situation in modern Fedora - they can map user=
s
> > they wish to confine to user_u (and thus to user_t) while leaving e.g.
> > root as unconfined_u and thus unconfined_t.
>=20
> So what do they do for the "targeted" case where all users are unconfined=
_t=20
> and they want to have POP/IMAP servers retrieve mail from the users' home=
=20
> directories?

Dan has no MAC-based home directory separations.  All home dirs are
user_home_dir_t in the Fedora policy.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Jil0OnVZV6zyFn8e28JU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiPIVMACgkQvI7kLeavkkMNBwCfSTKXnJ7nsemZhVg2+/kfI3Xa
n/cAnRunhSYk2Ynk0zrX7TeCqsjyXQYT
=v05H
-----END PGP SIGNATURE-----

--=-Jil0OnVZV6zyFn8e28JU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
