Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1CFDQL9023745
	for <selinux@tycho.nsa.gov>; Sat, 12 Feb 2005 10:13:27 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1CFCiKI018795
	for <selinux@tycho.nsa.gov>; Sat, 12 Feb 2005 15:12:49 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 12 Feb 2005 16:12:44 +0100
Date: Sat, 12 Feb 2005 16:12:52 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Patch: Policy for NX server
Message-Id: <20050212151251.GA5151@jmh.mhn.de>
Reply-To: rbg@informatik.uni-muenchen.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--TakKZr9L6Hm6aLOc
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds policy for the NX server.
The server works like this: a new user nx is added; the users connect to
the host via ssh with username nx; the nxserver is started by ssh and
connects to the real user via ssh on localhost.
To start nxserver in the correct context I had to add a new role.
Only the server is currently protected, not the client or the nxagent. I
also haven't tested the more advanced features like remote printing.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/nx_server.te mod/domains/program/nx_server.te
--- orig/domains/program/nx_server.te	1970-01-01 01:00:00.000000000 +0100
+++ mod/domains/program/nx_server.te	2005-02-12 15:40:54.000000000 +0100
@@ -0,0 +1,62 @@
+# DESC NX - NX Server
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+# Depends: sshd.te
+#
+
+# Type for the nxserver executable, called from ssh
+type nx_server_exec_t, file_type, sysadmfile, exec_type;
+
+# type of the nxserver; userdomain is needed so sshd can transition
+type nx_server_t, domain, userdomain;
+
+# we need an extra role because nxserver is called from sshd
+role nx_server_r types nx_server_t;
+allow system_r nx_server_r;
+domain_trans(sshd_t, nx_server_exec_t, nx_server_t)
+
+# not really sure if the additional attributes are needed, copied from use=
rdomains
+can_create_pty(nx_server, `, userpty_type, user_tty_type')
+type_change nx_server_t server_pty:chr_file nx_server_devpts_t;
+
+uses_shlib(nx_server_t)
+read_locale(nx_server_t)
+
+tmp_domain(nx_server)
+var_run_domain(nx_server)
+
+# nxserver is a shell script --> call other programs
+can_exec(nx_server_t, { bin_t shell_exec_t })
+allow nx_server_t self:process { fork sigchld };
+allow nx_server_t self:fifo_file { getattr ioctl read write };
+allow nx_server_t bin_t:dir { getattr read search };
+allow nx_server_t bin_t:lnk_file read;
+
+r_dir_file(nx_server_t, proc_t)
+allow nx_server_t { etc_t etc_runtime_t }:file { getattr read };
+
+# we do not actually need this attribute or the types defined here,=20
+# but otherwise we cannot call the ssh_domain-macro
+attribute nx_server_file_type;
+type nx_server_home_dir_t alias nx_server_home_t;
+type nx_server_tty_device_t;
+ssh_domain(nx_server)
+
+can_network_client(nx_server_t)
+
+allow nx_server_t devtty_t:chr_file { read write };
+allow nx_server_t sysctl_kernel_t:dir search;
+allow nx_server_t sysctl_kernel_t:file read;
+allow nx_server_t urandom_device_t:chr_file read;
+# for reading the config files; maybe a separate type,=20
+# but users need to be able to also read the config
+allow nx_server_t usr_t:file { getattr read };
+
+dontaudit nx_server_t selinux_config_t:dir search;
+
+# clients already have create permissions; the nxclient wants to also have=
 unlink rights
+allow userdomain xdm_tmp_t:sock_file unlink;
+# for a lockfile created by the client process
+allow nx_server_t user_tmpfile:file getattr;
+
diff -urN orig/file_contexts/program/nx_server.fc mod/file_contexts/program=
/nx_server.fc
--- orig/file_contexts/program/nx_server.fc	1970-01-01 01:00:00.000000000 +=
0100
+++ mod/file_contexts/program/nx_server.fc	2005-02-12 15:40:54.000000000 +0=
100
@@ -0,0 +1,5 @@
+# nx
+/opt/NX/bin/nxserver		--	system_u:object_r:nx_server_exec_t
+/opt/NX/var(/.*)?			system_u:object_r:nx_server_var_run_t
+/opt/NX/home/nx/\.ssh(/.*)?		system_u:object_r:nx_server_home_ssh_t
+
diff -urN orig/serviceusers mod/serviceusers
--- orig/serviceusers	2004-09-11 14:31:46.000000000 +0200
+++ mod/serviceusers	2005-02-12 15:40:54.000000000 +0100
@@ -4,3 +4,6 @@
 ifdef(`mailman.te', `
 #user mailman roles mailman_r;
 ')
+ifdef(`nx_server.te', `
+user nx roles nx_server_r;
+')

--d6Gm4EdcadzBjdND--

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCDhzzD9qpeVMU938RAoptAJsH4Dok7FcksiE79cIGLpgJobSzhACglJd9
FchHU4JO8w/g/te37o0l4hQ=
=PRtO
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
