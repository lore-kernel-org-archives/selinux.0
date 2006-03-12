Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2CLJBjC028092
	for <selinux@tycho.nsa.gov>; Sun, 12 Mar 2006 16:19:11 -0500
Received: from node19.avira.ro (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2CLHZTR028260
	for <selinux@tycho.nsa.gov>; Sun, 12 Mar 2006 21:17:36 GMT
Date: Sun, 12 Mar 2006 23:19:07 +0200
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: policy support for SSP
Message-ID: <20060312211907.GA6359@peter.sunspire.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6sX45UoQRIJXqkqR
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

the Hardened Gentoo [1] and FC5? [2] projects use stack smash protection [3=
] in their systems.
this means that every binary compiled with a hardened toolchain will need a=
ccess to /dev/urandom.

here is a small patch that has a tunable for allowing any domain access to =
urandom_device_t.
since now this was a gentoo-only tunable, but since others might need it, a=
 distro_gentoo should not be wrapped around it.

[1] http://www.gentoo.org/proj/en/hardened/pax-quickstart.xml
[2] http://fedora.redhat.com/docs/release-notes/fc5/test2-latest-en/sn-pack=
age-notes.html
[3] http://www.trl.ibm.com/projects/security/ssp/

bye,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="allow_ssp.patch"
Content-Transfer-Encoding: quoted-printable

Index: policy/global_tunables
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/global_tunables,v
retrieving revision 1.31
diff -u -B -r1.31 global_tunables
--- policy/global_tunables	9 Mar 2006 21:01:50 -0000	1.31
+++ policy/global_tunables	12 Mar 2006 20:57:45 -0000
@@ -51,6 +51,14 @@
=20
 ## <desc>
 ## <p>
+## Allow binaries compiled with stack-smashing protection
+## to read from urandom
+## </p>
+## </desc>
+gen_tunable(allow_ssp,false)
+
+## <desc>
+## <p>
 ## Allow ftp servers to modify public files
 ## used for public file transfer services.
 ## </p>
Index: policy/modules/kernel/devices.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/kernel/devices.te,v
retrieving revision 1.17
diff -u -B -r1.17 devices.te
--- policy/modules/kernel/devices.te	7 Mar 2006 15:31:09 -0000	1.17
+++ policy/modules/kernel/devices.te	12 Mar 2006 20:57:46 -0000
@@ -150,6 +150,12 @@
 type urandom_device_t;
 dev_node(urandom_device_t)
=20
+# if all binaries are compiled with stack-smashing protection
+# then all domains need to read from /dev/urandom
+tunable_policy(`allow_ssp',`
+	dev_read_urand(domain)
+')
+
 #
 # usbfs_t is the type for the /proc/bus/usb pseudofs
 #

--lrZ03NoBR/3+SXJZ--

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQFEFJBKGSBEIeh4AEYRAnJdAJ92p2nuBuoV6oTfoQ6W+ARa2TRaOwCfdJxo
ObGds57vd2HepzJbA0qdqag=
=NfGe
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
