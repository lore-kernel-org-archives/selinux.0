Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2LWgXZ010117
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 16:32:42 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2LWeLn015094
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 21:32:41 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 2 Nov 2004 22:32:37 +0100
Date: Tue, 2 Nov 2004 22:32:21 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: typealias cleanup
Message-Id: <20041102213220.GA3804@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tjCHc7DPkfUGtrlw
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch replaces all occurences of aliases with their real
counterparts. It would be nice if this could be merged now so some
aliases can be removed after the next release.

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="typealias-cleanup.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/domains/program/unused/calamaris.te
+++ mod/domains/program/unused/calamaris.te
@@ -18,8 +18,8 @@
 ')
=20
 allow calamaris_t { var_t var_run_t }:dir { getattr search };
-allow calamaris_t var_log_squid_t:dir search;
-allow calamaris_t var_log_squid_t:file { getattr read };
+allow calamaris_t squid_log_t:dir search;
+allow calamaris_t squid_log_t:file { getattr read };
 allow calamaris_t { usr_t lib_t }:file { getattr read };
 allow calamaris_t usr_t:lnk_file { getattr read };
 dontaudit calamaris_t usr_t:file ioctl;


--- orig/domains/program/unused/dbusd.te
+++ mod/domains/program/unused/dbusd.te
@@ -4,7 +4,7 @@
=20
 dbusd_domain(system)
=20
-allow system_dbusd_t dbusd_var_run_t:sock_file create_file_perms;
+allow system_dbusd_t system_dbusd_var_run_t:sock_file create_file_perms;
=20
 ifdef(`pamconsole.te', `
 r_dir_file(system_dbusd_t, pam_var_console_t)


--- orig/domains/program/unused/distcc.te
+++ mod/domains/program/unused/distcc.te
@@ -23,7 +23,7 @@
 can_exec(distccd_t,lib_t)
=20
 # comm stuff
-allow distccd_t resolv_conf_t:file r_file_perms;
+allow distccd_t net_conf_t:file r_file_perms;
 allow distccd_t self:{ unix_stream_socket unix_dgram_socket } { create con=
nect read write };
 allow distccd_t self:fifo_file { read write getattr };
=20


--- orig/domains/program/unused/dpkg.te
+++ mod/domains/program/unused/dpkg.te
@@ -85,7 +85,7 @@
 domain_auto_trans(dpkg_t, httpd_exec_t, httpd_t)
 ')
 ifdef(`named.te', `
-file_type_auto_trans(dpkg_t, named_zone_t, rndc_conf_t, file)
+file_type_auto_trans(dpkg_t, named_zone_t, named_conf_t, file)
 ')
 ifdef(`nsd.te', `
 allow nsd_crond_t initrc_t:fd use;


--- orig/file_contexts/program/dbusd.fc
+++ mod/file_contexts/program/dbusd.fc
@@ -1,3 +1,3 @@
-/usr/bin/dbus-daemon-1	--	system_u:object_r:dbusd_exec_t
+/usr/bin/dbus-daemon-1	--	system_u:object_r:system_dbusd_exec_t
 /etc/dbus-1(/.*)?		system_u:object_r:etc_dbusd_t
-/var/run/dbus(/.*)?		system_u:object_r:dbusd_var_run_t
+/var/run/dbus(/.*)?		system_u:object_r:system_dbusd_var_run_t


--- orig/file_contexts/program/gatekeeper.fc
+++ mod/file_contexts/program/gatekeeper.fc
@@ -4,4 +4,4 @@
 /usr/sbin/gnugk		--	system_u:object_r:gatekeeper_exec_t
 /var/run/gk\.pid	--	system_u:object_r:gatekeeper_var_run_t
 /var/run/gnugk(/.*)?		system_u:object_r:gatekeeper_var_run_t
-/var/log/gnugk(/.*)?		system_u:object_r:var_log_gatekeeper_t
+/var/log/gnugk(/.*)?		system_u:object_r:gatekeeper_var_log_t


--- orig/macros/program/dbusd_macros.te
+++ mod/macros/program/dbusd_macros.te
@@ -21,7 +21,7 @@
 ', `
 type $1_dbusd_t, domain, privlog, userspace_objmgr;
 role $1_r types $1_dbusd_t;
-domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
+domain_auto_trans($1_t, system_dbusd_exec_t, $1_dbusd_t)
 read_locale($1_dbusd_t)
 allow $1_t $1_dbusd_t:process { sigkill signal };
 dontaudit $1_dbusd_t var_t:dir { getattr search };




--YiEDa0DAkWCtVeE4--

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBh/zkxWIrrrL0q+cRAkSpAJ4rK2lWGquWqS/G9JlC9MiSCcYbxQCfd96B
cdG4V3vCW+AEG4xyyrCGy/8=
=dQ2R
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
