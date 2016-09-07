Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8793JMi028642
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 05:03:19 -0400
Subject: Re: SELinux MLS Policies
To: Paul Bolton <paul.a.bolton@m0noc.net>, ileyd <ileyd@icloud.com>,
 selinux@tycho.nsa.gov
References: <"01e601d202e0$7aaf62d0$700e2870$@a.bolton"@m0noc.net>
 <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
 <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
 <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
 <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <64786c70-3f89-4bc1-fdc8-fa0897784e58@redhat.com>
Date: Wed, 7 Sep 2016 11:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4GTatIxLUOBf2im1OhAFtQISkogU4dcvd"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4GTatIxLUOBf2im1OhAFtQISkogU4dcvd
Content-Type: multipart/mixed; boundary="1OJNb84Bjoov5vcTwJU0BnT9kRMfaFPS2"
From: Petr Lautrbach <plautrba@redhat.com>
To: Paul Bolton <paul.a.bolton@m0noc.net>, ileyd <ileyd@icloud.com>,
 selinux@tycho.nsa.gov
Message-ID: <64786c70-3f89-4bc1-fdc8-fa0897784e58@redhat.com>
Subject: Re: SELinux MLS Policies
References: <"01e601d202e0$7aaf62d0$700e2870$@a.bolton"@m0noc.net>
 <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
 <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
 <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
 <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>
In-Reply-To: <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>

--1OJNb84Bjoov5vcTwJU0BnT9kRMfaFPS2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/31/2016 09:53 AM, Paul Bolton wrote:
>=20
>=20
> On 31/08/16 07:37, ileyd wrote:
>>
>> Have you managed to correct the incorrect labelling of /etc?  When I'v=
e tried to use the MLS policy on RHEL/CentOS 7-7.2, that has stopped logi=
ns from working when running in enforcing mode.
>>
>=20
> So if I turn off the dontaudit rules that issue shows up with
> unix_chkpwd and mls_constrain AVCs. Admittedly I did notice it was at
> s15 but thought that was intentional. Though, as most of the files in
> /etc are at s0 that doesn't sound right.
>=20
> Anyway, changing /etc to s0 allows logins to work; and looks more like
> what I would expect an out-of-the-box MLS system to look like.
>=20
> Thanks for the advice.
>=20
>=20

This is a bug in initscripts.

/usr/lib/systemd/rhel-import-state copies files from initrd to a
filesystem during boot but doesn't reset level on the copied files.
Since dracut is running as ks15, copied files  inherits s15 level. The
fix is quite easy:

--- /usr/lib/systemd/rhel-import-state.bug      2016-09-07
04:44:45.413231227 -0400
+++ /usr/lib/systemd/rhel-import-state  2016-09-07 04:44:51.645274588 -04=
00
@@ -7,5 +7,5 @@

 # run restorecon on the copied files
 if [ -e /sys/fs/selinux/enforce -a -x /usr/sbin/restorecon ]; then
-    find . -mindepth 1 -print0 | { cd / && xargs --null restorecon -i; }=

+    find . -mindepth 1 -print0 | { cd / && xargs --null restorecon -i -F=
; }
 fi


Petr
--=20
Petr Lautrbach



--1OJNb84Bjoov5vcTwJU0BnT9kRMfaFPS2--

--4GTatIxLUOBf2im1OhAFtQISkogU4dcvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz9fQAAoJEGOorUuYLENz+fgQAIRoPlXuCuvD8vtLP2muiBWW
K+Dmg8vC3Ddx6qE4VPuzoYB/1onmozbQLIAKNIV3/K5XrCf59IgA6FxI/0dwupIt
9eXQvn4+5K+gRp4UrNw7Sxp4SRcEtAMFv/88p/qUvv0u0jX5Ji8DRjRBZEbk8hsD
osNtA9iR5Tn/TflP12IVND0dz5K0T9YJ9C93pJJ86/0RpwJDM86NaHLto4mZDiJx
RX8DMbfBCLlC3U8nF5+gdWeb6x3KN3b3oOJzihwWj0E9ifk76wPBiiX1ftkXs9HY
0Q8vJHt2eTf+IYyXpWeVNwHMEWVqzanYm5PpdxGnL79TcZ9hvIQshgcUZxmtgGHh
Pa9lk/crLdyuDGfZQH9FeSMOESbE/gc4YHoqExt3Di4Ag2I4uZqaq6VRLYIPc3ub
Yjz6b+UIGdv3lloluJ+OEgYfe8sqkUCPeW9ezHonfsqb5tKao6nIoGnzfWyunfiz
Vr67/TXuzaJbdUBCQaSJ09U9cWA455XSRi36WrVZmrQe3uekhfY0pvG1BNOZQheb
k5jM30m9Kz3dszQLZ+5ZZp5JS7QLHchQLMaYUQRp9gX9L+wv686DtTLFltMjsMFj
6EzpMW0KKshHZN6SH0Dii1VHXX4/NIy+Wxo+FOqQyZyaxi6O8vGZPyihm6x6Hrko
eiGz60/imPLvrdKQVTBT
=ZWT+
-----END PGP SIGNATURE-----

--4GTatIxLUOBf2im1OhAFtQISkogU4dcvd--
