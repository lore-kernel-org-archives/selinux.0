Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m57DGRuu006389
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2008 09:16:27 -0400
Received: from ppsw-5.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m57DGQdK015474
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2008 13:16:27 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:59830)
	by ppsw-5.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.135]:25)
	with esmtp id 1K4yHP-00085A-HG (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Sat, 07 Jun 2008 14:16:23 +0100
Message-ID: <484A8A15.9000507@martinorr.name>
Date: Sat, 07 Jun 2008 14:16:05 +0100
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_caligula-5436-1212844582-0001-2"
To: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [refpolicy] /usr/lib32 type
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-5436-1212844582-0001-2
Content-Type: multipart/mixed;
 boundary="------------010708020209090906010002"

This is a multi-part message in MIME format.
--------------010708020209090906010002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On a 64-bit Debian system, /usr/lib32 is a symlink to
/emul/ia32-linux/usr/lib.  It should be labelled as lib_t.

I don't know if the distro_debian is necessary - take it out if you want.=


--=20
Martin Orr

--------------010708020209090906010002
Content-Type: text/plain;
 name="116_usr_lib32"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="116_usr_lib32"

Written by: Martin Orr

Mark /usr/lib32 as type lib_t

Index: policy/modules/system/libraries.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/system/libraries.fc.orig
+++ policy/modules/system/libraries.fc
@@ -110,6 +110,9 @@
=20
 /usr/(.*/)?lib(/.*)?				gen_context(system_u:object_r:lib_t,s0)
 /usr/(.*/)?lib64(/.*)?				gen_context(system_u:object_r:lib_t,s0)
+ifdef(`distro_debian',`
+	/usr/(.*/)?lib32(/.*)?		-l	gen_context(system_u:object_r:lib_t,s0)
+')
=20
 /usr/(.*/)?lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:ob=
ject_r:ld_so_t,s0)
=20

--------------010708020209090906010002--

--=_caligula-5436-1212844582-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkhKiiMACgkQZ6a/BjxtAMDmXgCgrNJqINgRIQPlbGCT0soNfp7n
kVwAni3TPRwVOl+QrNYmOcZT4K295AvP
=Af+C
-----END PGP SIGNATURE-----

--=_caligula-5436-1212844582-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
