Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h55AuHI4027014
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2003 06:56:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h55Au5tV022398
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2003 10:56:05 GMT
Received: from a.mx.rapturesecurity.com ([66.113.84.53])
        by jazzband.ncsc.mil  with ESMTP id h55Au4al022395 for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2003 10:56:05 GMT
Subject: Re: executing /dev/zero
From: Jack <jack@rapturesecurity.com>
Reply-To: jack@rapturesecurity.com
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306050000.58024.russell@coker.com.au>
References: <200306050000.58024.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WwTv+1Pg3JkbDPEPXiSF"
Message-Id: <1054810345.4056.7.camel@bubbles.eatflamingdeath.org>
Mime-Version: 1.0
Date: 05 Jun 2003 03:52:26 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WwTv+1Pg3JkbDPEPXiSF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

allow local_user_t zero_device_t:chr_file { execute };

I had to do the same thing for something i cant recall on my
slackware X workstation, I tracked it down to the exact same
thing, but its not mplayer ;) Ill see if i can backtrace and
see what it was that needed this. It could very well be quake3
or some opengl application, but ill check this. On a side note
the Owl TCB implementation for pam is working great with selinux,
we have at least 3 workstations running this daily now.

On Wed, 2003-06-04 at 07:00, Russell Coker wrote:
> avc:  denied  { execute } for  pid=3D3927 exe=3D/usr/bin/mplayer path=3D/=
zero=20
> dev=3D00:06 ino=3D12 scontext=3Dfaye:staff_r:staff_t=20
> tcontext=3Dsystem_u:object_r:zero_device_t tclass=3Dchr_file
>=20
> It seems that mplayer is requesting execute access to /dev/zero for some=20
> reason.  I guess it's mmaping it to allocate memory and then executing co=
de=20
> in that memory region.
>=20
> It works OK without the access, but is there any reason for allowing it? =
 I'm=20
> not sure whether I should give it an allow or dontaudit rule...
--=20
Jack <jack@rapturesecurity.com>
RaptureSecurity

--=-WwTv+1Pg3JkbDPEPXiSF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+3yDpCNDQVeieV0YRAhJGAKCGOdcB3xphqy8wUQ17a+K6k+bj2ACgrNNz
bgUHkZGMofFlurjJk7mn3V0=
=h6G1
-----END PGP SIGNATURE-----

--=-WwTv+1Pg3JkbDPEPXiSF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
