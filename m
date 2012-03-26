Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QIhO6g020292
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:43:24 -0400
Received: by yhjj72 with SMTP id j72so4402063yhj.12
        for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:43:23 -0700 (PDT)
Message-ID: <1332787395.8994.8.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: Debian patches to userspace components
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Date: Mon, 26 Mar 2012 11:43:15 -0700
In-Reply-To: <20120326141242.59afdd34@eldamar.bigon.be>
References: <20120326141242.59afdd34@eldamar.bigon.be>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RPXM9CMaDCXAZwhLdyKs"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RPXM9CMaDCXAZwhLdyKs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me know if I can help, Laurent.  Are we working with sid or wheezy?
I don't currently have a sid build system, but I've got quite a few
wheezy ones I could make use of.

On Mon, 2012-03-26 at 14:12 +0200, Laurent Bigonville wrote:
> Hi,
>=20
> I'm currently helping Russel with the SELinux packages in Debian.
>=20
> The Debian packages are carrying some (a lot?) of patches that I would
> like to see merged upstream. The rational of some of them has
> unfortunately been lost and not all of these patches are suitable for
> being merged upstream.
>=20
> The patches that are currently applied to the debian packages can be
> found at:
>=20
> http://patch-tracker.debian.org/package/libselinux/
> http://patch-tracker.debian.org/package/libsepol/
> http://patch-tracker.debian.org/package/libsemanage/
> http://patch-tracker.debian.org/package/sepolgen/
> http://patch-tracker.debian.org/package/policycoreutils/
> http://patch-tracker.debian.org/package/checkpolicy/
> http://patch-tracker.debian.org/package/setools/
>=20
> Are you interested in them? If so, I'll forward the ones that I think
> are not Debian specific to the mailing-list.
>=20
> Cheers
>=20
> Laurent Bigonville
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.


--=-RPXM9CMaDCXAZwhLdyKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPcLjEAAoJEEyimPmPQm23Wc0H/iIlD16t1AHzrx52CkndqUd8
cpeDfUGJvzoOh9eSa5zYMxkajEtOd+lat7uVhBeI7Vz6NUdNMkmWj7b8noGy7uyy
WwdkaIc+5aBPkp3y+yG8/ZrlpcBXiE2nMlyScj2RkW/oEgmpr4nt1GH6x1KW4gKY
cpmY0xWk49UcESnXcoBrr2W584Vx3bjTHO38OEIf3/C39Vo+Nz62XMJTdqttgKmk
zeRmVhvtScN2CcT8LOZuUY+k7NC9YbqhNS5zAsndQDANShXGOivkxmzR8Q9m8Ch/
GRJhZUuzBuxX9nVvUtWi/zZqKKqdkJiPGtkjiRdca+yn0SsVO7KldpFocM/Du1A=
=buE6
-----END PGP SIGNATURE-----

--=-RPXM9CMaDCXAZwhLdyKs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
