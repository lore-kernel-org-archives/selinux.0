Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6NdUIi025128
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 18:39:30 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6NbrHW015992
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 23:37:53 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 7 Dec 2004 00:39:31 +0100
Date: Tue, 7 Dec 2004 00:39:33 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: debian stuff
Message-Id: <20041206233933.GE3678@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--2FkSFaIQeDFoAt0B
Content-Type: multipart/mixed; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mostly comment updates.
The permissions in fsadm.te are needed when booting Debian.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="debian.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/domains/program/dmesg.te
+++ mod/domains/program/dmesg.te
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh dwalsh@redhat.com
 #
+# X-Debian-Packages: util-linux
=20
 #################################
 #
--- orig/domains/program/fsadm.te
+++ mod/domains/program/fsadm.te
@@ -106,7 +105,7 @@
 allow fsadm_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
 allow fsadm_t privfd:fd use;
-allow fsadm_t devpts_t:dir getattr;
+allow fsadm_t devpts_t:dir { getattr search };
=20
 read_locale(fsadm_t)
=20
@@ -116,4 +116,4 @@
 # Access to /initrd devices
 allow fsadm_t { file_t unlabeled_t }:dir rw_dir_perms;
 allow fsadm_t { file_t unlabeled_t }:blk_file rw_file_perms;
-allow fsadm_t usbfs_t:dir getattr;
+allow fsadm_t usbfs_t:dir { getattr search };
--- orig/domains/program/unused/loadkeys.te
+++ mod/domains/program/loadkeys.te
@@ -1,6 +1,8 @@
 #DESC loadkeys - for changing to unicode at login time
 #
 # Author:  Russell Coker <russell@coker.com.au>
+#
+# X-Debian-Packages: console-tools
=20
 #
 # loadkeys_exec_t is the type of the wrapper
--- orig/domains/program/unused/rpcd.te
+++ mod/domains/program/rpcd.te
@@ -3,7 +3,7 @@
 # Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser =20
 #           Russell Coker <russell@coker.com.au>
 # Depends: portmap.te
-# X-Debian-Packages:
+# X-Debian-Packages: nfs-common
 #
=20
 #################################
--- orig/domains/program/sulogin.te
+++ mod/domains/program/sulogin.te
@@ -2,6 +2,7 @@
 #
 # Authors:  Dan Walsh <dwalsh@redhat.com>
 #
+# X-Debian-Packages: sysvinit
=20
 #################################
 #=20

--SNIs70sCzqvszXB4--

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtO21xWIrrrL0q+cRAoUBAJsFfEPMcMdBLpjuqt3NKUPeTKbQlwCdECPL
U6qTD/gcQZjZ4hmlFN6Hz7Y=
=LObg
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
