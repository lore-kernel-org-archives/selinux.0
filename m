Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HkVIi014271
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:46:31 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HirPS009635
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:44:53 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 18:46:33 +0100
Date: Thu, 9 Dec 2004 18:46:33 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: add policy for gpg helpers
Message-Id: <20041209174633.GA8179@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4bRzO86E/ozDv8r1
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds support for gpg-helpers. These can be used to
automatically fetch gpg keys over the network. Properly configured,
$1_gpg_t doesn't need network access anymore. Unfortunately, eg Debian
doesn't yet include all the necessary helpers, so I left the
can_network() for $1_gpg_t in for now.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gpg_helper.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/unused/gpg.te mod/domains/program/unused/gpg=
=2Ete
--- orig/domains/program/unused/gpg.te	2003-08-14 14:37:36.000000000 +0200
+++ mod/domains/program/unused/gpg.te	2004-12-09 18:38:03.000000000 +0100
@@ -6,6 +6,7 @@
=20
 # Type for gpg or pgp executables.
 type gpg_exec_t, file_type, sysadmfile, exec_type;
+type gpg_helper_exec_t, file_type, sysadmfile, exec_type;
=20
 allow sysadm_gpg_t { home_root_t user_home_dir_t }:dir search;
 allow sysadm_gpg_t ptyfile:chr_file rw_file_perms;
diff -urN orig/file_contexts/program/gpg.fc mod/file_contexts/program/gpg.fc
--- orig/file_contexts/program/gpg.fc	2004-03-09 16:31:36.000000000 +0100
+++ mod/file_contexts/program/gpg.fc	2004-12-09 18:38:03.000000000 +0100
@@ -1,3 +1,4 @@
 # gpg
 HOME_DIR/\.gnupg(/.+)?	system_u:object_r:ROLE_gpg_secret_t
 /usr/bin/gpg		--	system_u:object_r:gpg_exec_t
+/usr/lib/gnupg/gpgkeys.*	--	system_u:object_r:gpg_helper_exec_t
diff -urN orig/macros/program/gpg_macros.te mod/macros/program/gpg_macros.te
--- orig/macros/program/gpg_macros.te	2004-11-30 16:19:26.000000000 +0100
+++ mod/macros/program/gpg_macros.te	2004-12-09 18:38:54.000000000 +0100
@@ -19,7 +19,7 @@
 define(`gpg_domain', `
 # Derived domain based on the calling user domain and the program.
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, $1_file_type, sysadmfile, $1_file_type;
+type $1_gpg_secret_t, file_type, $1_file_type, sysadmfile;
=20
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
@@ -94,4 +94,38 @@
=20
 ifdef(`gpg-agent.te', `gpg_agent_domain($1)')
=20
+# for helper programs (which automatically fetch keys)
+# Note: this is only tested with the hkp interface. If you use eg the=20
+# mail interface you will likely need additional permissions.
+type $1_gpg_helper_t, domain;
+role $1_r types $1_gpg_helper_t;
+
+domain_auto_trans($1_gpg_t, gpg_helper_exec_t, $1_gpg_helper_t)
+uses_shlib($1_gpg_helper_t)
+
+# allow gpg to fork so it can call the helpers
+allow $1_gpg_t self:process { fork sigchld };
+allow $1_gpg_t self:fifo_file { getattr read write };
+
+dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
+if (use_nfs_home_dirs) {
+dontaudit $1_gpg_helper_t nfs_t:file { read write };
+}
+
+# communicate with the user=20
+allow $1_gpg_helper_t $1_t:fd use;
+allow $1_gpg_helper_t $1_t:fifo_file write;
+# get keys from the network
+can_network_client($1_gpg_helper_t)
+allow $1_gpg_helper_t etc_t:file { getattr read };
+allow $1_gpg_helper_t urandom_device_t:chr_file read;
+allow $1_gpg_helper_t self:unix_stream_socket create_stream_socket_perms;
+# for nscd
+dontaudit $1_gpg_helper_t var_t:dir search;
+
+ifdef(`xdm.te', `
+dontaudit $1_gpg_t xdm_t:fd use;
+dontaudit $1_gpg_t xdm_t:fifo_file read;
+')
+
 ')dnl end gpg_domain definition

--C7zPtVaVf+AK4Oqc--

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuI95xWIrrrL0q+cRAp1RAJ9d0TKuptLa8+9qvvgpjqN4hwWNhQCZAbGv
/FDj1JsYihgPeKhsSEqNWkw=
=2xJu
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
