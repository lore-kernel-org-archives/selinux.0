Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i62DnSrT013568
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 09:49:28 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i62DnAks027352
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 13:49:11 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 2 Jul 2004 15:49:24 +0200
Date: Fri, 2 Jul 2004 15:48:46 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: [patch] policy for gpg-agent
Message-Id: <20040702134845.GA1652@obadja.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch adds some policy for gpg-agent.
gpg-agent is a program to store gpg keys securely so users have to type
their passphrase only once. When gpg-agent is asked to do an encryption
or signature for the first time it calls pinentry-{qt,gtk} to get the
passphrase from the user.
I do not know of other users of pinentry besides gpg-agent, so for now I
have included the policy for pinentry in the gpg-agent policy.
If other program use it too, it should probably be split into a macro.

This policy has been working fine on a few computers here for a week
now; I have however only tested with pinentry-qt, so pinentry-gtk might
need additional permissions.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gpg-agent.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/unused/gpg-agent.te mod/domains/program/unus=
ed/gpg-agent.te
--- orig/domains/program/unused/gpg-agent.te	1970-01-01 01:00:00.000000000 =
+0100
+++ mod/domains/program/unused/gpg-agent.te	2004-07-02 11:40:29.000000000 +=
0200
@@ -0,0 +1,13 @@
+#DESC gpg-agent - agent to securely store gpg-keys
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+
+# Type for the gpg-agent executable.
+type gpg_agent_exec_t, file_type, exec_type, sysadmfile;
+
+# type for the pinentry executable
+type pinentry_exec_t, file_type, exec_type, sysadmfile;
+
+# Everything else is in the gpg_agent_domain macro in
+# macros/program/gpg_agent_macros.te.
diff -urN orig/file_contexts/program/gpg-agent.fc mod/file_contexts/program=
/gpg-agent.fc
--- orig/file_contexts/program/gpg-agent.fc	1970-01-01 01:00:00.000000000 +=
0100
+++ mod/file_contexts/program/gpg-agent.fc	2004-07-02 11:44:12.000000000 +0=
200
@@ -0,0 +1,3 @@
+# gpg-agent
+/usr/bin/gpg-agent	--	system_u:object_r:gpg_agent_exec_t
+/usr/bin/pinentry.*	--	system_u:object_r:pinentry_exec_t
diff -urN orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_ag=
ent_macros.te
--- orig/macros/program/gpg_agent_macros.te	1970-01-01 01:00:00.000000000 +=
0100
+++ mod/macros/program/gpg_agent_macros.te	2004-07-02 11:42:29.000000000 +0=
200
@@ -0,0 +1,125 @@
+#
+# Macros for gpg agent
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+#=20
+# gpg_agent_domain(domain_prefix)
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/gpg-agent.te.=20
+#
+define(`gpg_agent_domain',`
+# Define a derived domain for the gpg-agent program when executed
+# by a user domain.
+# Derived domain based on the calling user domain and the program.
+type $1_gpg_agent_t, domain;
+
+# Transition from the user domain to the derived domain.
+domain_auto_trans($1_t, gpg_agent_exec_t, $1_gpg_agent_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_gpg_agent_t;
+
+allow $1_gpg_agent_t privfd:fd use;
+allow $1_gpg_agent_t xdm_t:fd use;
+
+# Write to the user domain tty.
+allow $1_gpg_agent_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_gpg_agent_t $1_devpts_t:chr_file rw_file_perms;
+allow $1_gpg_agent_t devtty_t:chr_file { read write };
+
+# Allow the user shell to signal the gpg-agent program.
+allow $1_t $1_gpg_agent_t:process { signal sigkill };
+# allow ps to show gpg-agent
+can_ps($1_t, $1_gpg_agent_t)
+
+uses_shlib($1_gpg_agent_t)
+read_locale($1_gpg_agent_t)
+
+# rlimit: gpg-agent wants to prevent coredumps
+allow $1_gpg_agent_t self:process { setrlimit fork sigchld };
+
+allow $1_gpg_agent_t { self proc_t }:dir search;
+allow $1_gpg_agent_t { self proc_t }:lnk_file read;
+
+allow $1_gpg_agent_t device_t:dir { getattr read };
+
+# read ~/.gnupg
+allow $1_gpg_agent_t { home_root_t $1_home_dir_t }:dir search;
+r_dir_file($1_gpg_agent_t, $1_gpg_secret_t)
+ifdef(`nfs_home_dirs', `
+r_dir_file($1_gpg_agent_t, nfs_t)
+# write ~/.xsession-errors
+allow $1_gpg_agent_t nfs_t:file write;
+')
+
+allow $1_gpg_agent_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_gpg_agent_t self:fifo_file { getattr read write };
+
+# create /tmp files
+tmp_domain($1_gpg_agent)
+
+# gpg connect
+allow $1_gpg_t $1_gpg_agent_tmp_t:dir { search };
+allow $1_gpg_t $1_gpg_agent_tmp_t:sock_file { write };
+can_unix_connect($1_gpg_t, $1_gpg_agent_t)
+
+# policy for pinentry
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# we need to allow gpg-agent to call pinentry so it can get the passphrase=
=20
+# from the user.
+# Please note that I didnt use the x_client_domain-macro as it gives too=
=20
+# much permissions
+type $1_gpg_pinentry_t, domain;
+role $1_r types $1_gpg_pinentry_t;
+
+allow $1_gpg_agent_t bin_t:dir search;
+domain_auto_trans($1_gpg_agent_t, pinentry_exec_t, $1_gpg_pinentry_t)
+
+uses_shlib($1_gpg_pinentry_t)
+read_locale($1_gpg_pinentry_t)
+
+allow $1_gpg_pinentry_t self:unix_stream_socket { connect create getattr r=
ead shutdown write };
+allow $1_gpg_pinentry_t self:fifo_file { getattr read write };
+
+ifdef(`xdm.te', `
+allow $1_gpg_pinentry_t xdm_xserver_tmp_t:dir search;
+allow $1_gpg_pinentry_t xdm_xserver_tmp_t:sock_file { read write };
+can_unix_connect($1_gpg_pinentry_t, xdm_xserver_t)
+allow $1_gpg_pinentry_t xdm_t:fd use;
+')dnl end ig xdm.te
+
+r_dir_file($1_gpg_pinentry_t, fonts_t)
+# read kde font cache
+allow $1_gpg_pinentry_t usr_t:file { getattr read };
+
+# pinentry-qt needs this (executes a KDE style library)
+allow $1_gpg_pinentry_t lib_t:file { execute };
+
+allow $1_gpg_pinentry_t { proc_t self }:dir { search };
+allow $1_gpg_pinentry_t { proc_t self }:lnk_file { read };
+# read /proc/meminfo
+allow $1_gpg_pinentry_t proc_t:file read;
+
+allow $1_gpg_pinentry_t { tmp_t home_root_t }:dir { getattr search };
+
+# for .Xauthority
+allow $1_gpg_pinentry_t $1_home_dir_t:dir { getattr search };
+allow $1_gpg_pinentry_t $1_home_t:file { getattr read };
+# wants to put some lock files into the user home dir, seems to work fine =
without
+dontaudit $1_gpg_pinentry_t $1_home_t:dir { read write };
+dontaudit $1_gpg_pinentry_t $1_home_t:file write;
+ifdef(`nfs_home_dirs', `
+allow $1_gpg_pinentry_t nfs_t:dir { getattr search };
+allow $1_gpg_pinentry_t nfs_t:file { getattr read };
+dontaudit $1_gpg_pinentry_t nfs_t:dir { read write };
+dontaudit $1_gpg_pinentry_t nfs_t:file write;
+')dnl end if nfs_home_dirs
+
+# read /etc/X11/qtrc
+allow $1_gpg_pinentry_t etc_t:file { getattr read };
+
+dontaudit $1_gpg_pinentry_t { sysctl_t sysctl_kernel_t bin_t }:dir { getat=
tr search };
+
+')dnl end if gpg_agent
diff -urN orig/macros/program/gpg_macros.te mod/macros/program/gpg_macros.te
--- orig/macros/program/gpg_macros.te	2004-05-04 21:35:54.000000000 +0200
+++ mod/macros/program/gpg_macros.te	2004-07-02 11:43:39.000000000 +0200
@@ -94,4 +94,7 @@
 allow $1_t $1_gpg_secret_t:dir rw_dir_perms;
=20
 dontaudit $1_gpg_t var_t:dir search;
+
+ifdef(`gpg-agent.te', `gpg_agent_domain($1)')
+
 ')dnl end gpg_domain definition

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5We9xWIrrrL0q+cRAv7IAKCIGNFShoqInL1J8TTFvqKBFIJXvgCgmEMq
WJi8lsmEllFZwvjgk1lyiBA=
=0Mqh
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
