Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0VH9vRb025071
	for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 12:09:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0VH9u1I002855
	for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 17:09:56 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
        by jazzband.ncsc.mil  with ESMTP id i0VH9ubs002852 for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 17:09:56 GMT
Subject: Re: Gentoo SELinux LiveCD
From: Chris PeBenito <pebenito@gentoo.org>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200401311725.51250.carstengrohmann@gmx.de>
References: <1075145644.1235.93.camel@chris.pebenito.net>
	 <200401311725.51250.carstengrohmann@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EKjMUPpPVN3HtGb0IbZX"
Message-Id: <1075568989.6347.122.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 11:09:49 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EKjMUPpPVN3HtGb0IbZX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-31 at 10:25, Carsten Grohmann wrote:
> On Montag, 26. Januar 2004 20:34, Chris PeBenito wrote:
> > Announcing the Gentoo SELinux LiveCD

> The LiveCD is great - I try it yesterday and it runs fine.=20
>=20
> Do you use a small specific policy? Because I can't change the role=20
> of root to user_r.

Well just like the NSA example policy, root is allowed staff_r and
sysadm_r, not user_r.

> What do you think about adding the policy sources and the command=20
> line version of the setools? With this the SELinux newbies could=20
> use your CD to make the first steps on SELinux.

Everything in /etc lives on the initrd so its modifiable.  I'd prefer to
keep the initrd slim, but I'll check into it.

> Could it be, that the unmount of loopback filesystem failed? I get=20
> follow message:
> Unmounting loopback filesystems...
> Failed to unmount filesystems

I'll have to check that too; I fell into the habit of hitting the reset
button on the machine, rather than waiting for the livecd to shut down,
since it doesn't matter :)

> I would show your LiveCD as an part of my SELinux workshop in March=20
> in Chemnitz (a town in saxony), if you don't object.

Certainly!  No objections.  We'll probably have a new revision by then.

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

--=-EKjMUPpPVN3HtGb0IbZX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAG+FdvI7kLeavkkMRAlIvAJ9fwwNQQhsTQhfUhZMWb6CGV6J/EgCfQuMX
csi5/H+MAUHwFzKzH7enFCo=
=2N2F
-----END PGP SIGNATURE-----

--=-EKjMUPpPVN3HtGb0IbZX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
