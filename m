Subject: avc: denied null
From: Dominick Grift <domg472@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2N3iuw4w9Xy2ugXmNMHo"
Date: Mon, 18 May 2009 12:19:54 +0200
Message-Id: <1242641994.470.5.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2N3iuw4w9Xy2ugXmNMHo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have enabled XACE on my systems and sometimes i get weird avc denials:

avc:  denied  null for request=3DGLX:MakeCurrent comm=3Dglxinfo
resid=3D2600001 restype=3D<unknown>
scontext=3Ddgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
tcontext=3Ddgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023 tclass=3Dx_resource

avc:  denied  null for request=3DX11:GetInputFocus comm=3D/usr/bin/ggl-qt
xdevice=3D"Virtual core keyboard"
scontext=3Ddgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
tcontext=3Dsystem_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=3Dx_device

avc:  denied  null for request=3DX11:UnmapWindow comm=3D/usr/bin/ggl-qt
xdevice=3D"Virtual core keyboard"
scontext=3Ddgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
tcontext=3Dsystem_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=3Dx_device

I was wondering if this is a bug or of this is expected behaviour.

I do not notice any loss in functionality.

Thanks

--=-2N3iuw4w9Xy2ugXmNMHo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoRNkAACgkQMlxVo39jgT/G6QCgnQw+sGrkBqoqo3aLcBMR+OoL
U8kAnRZiktPPw6oEzrap496ejLf3TFgL
=Kaa9
-----END PGP SIGNATURE-----

--=-2N3iuw4w9Xy2ugXmNMHo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
