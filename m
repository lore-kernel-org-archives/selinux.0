Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DH9KRb022210
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:09:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3DH7FUZ021759
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 17:07:16 GMT
Received: from gorn.pebenito.dhs.org (c-24-15-25-98.client.comcast.net [24.15.25.98])
	by jazzswing.ncsc.mil  with ESMTP id i3DH7FmT021752
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 17:07:15 GMT
Subject: Re: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <407BF24E.90901@redhat.com>
References: <407BF24E.90901@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZaZcmCYrOgmyEz3Z/URu"
Message-Id: <1081876156.7060.28.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 12:09:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZaZcmCYrOgmyEz3Z/URu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-13 at 08:59, Daniel J Walsh wrote:
> Ideas?
>=20
> Dan

I've been thinking about this for a while.  It seems like a good idea
eventually, but the problem is with the policy v15 kernels floating
around still.  The bools get dropped, so you lose the tuning.  If
checkpolicy is modified to include the bool if the condition is met,
based on the initial setting, for v15 policy, then it could be ok.  For
example:

bool foo true;
bool bar false;
if( foo ) {
allow a_t b_t:file getattr;
}
if( bar ) {
allow c_t b_t:file getattr;
}

So, the first allow would be included, but not the second in a v15
policy.  I think I remember Russell talking about this, or something
similar.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-ZaZcmCYrOgmyEz3Z/URu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfB66vI7kLeavkkMRAtOUAKCh+qnguRuw0gcGnt364xa+uriLmwCdEdTJ
/sVqpW9Xrz8diVCNSIqKY/Q=
=tOjT
-----END PGP SIGNATURE-----

--=-ZaZcmCYrOgmyEz3Z/URu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
