Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HMnRrT006213
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 18:49:27 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HMmQNM019673
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 22:48:30 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 18 Sep 2004 00:49:22 +0200
Date: Sat, 18 Sep 2004 00:49:56 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: clean up vmware
Message-Id: <20040917224956.GA2517@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After reading through the messy vmware policy I decided to clean it up a
little. Result is below.

I tried to change as little functionality as possible. I replaced a few
permissions by macros and created a vmware_domain() macro. With the old
policy, vmware created tmpfiles with type tmp_t =3D=3D> changed to
tmp_domain().
I also took the liberty to rename vmware_user_t to user_vmware_t.=20
Typealiases for compatibility are included.

I do not have VMWare here so it would be nice if someone could test
these changes to make sure nothing breaks.

Comments welcome,
Thomas

PS: Another note: there seems to be no benefit to having both
user_vmware_conf_t and user_vmware_file_t as vmware has
create_file_perms for both. So these can probably be coalesced into one
type.

 domains/program/unused/vmware.te       |  114 ---------------------------
 file_contexts/program/vmware.fc        |    6 -
 macros/base_user_macros.te             |    1=20
 macros/macros/program/vmware_macros.te |  135 ++++++++++++++++++++++++++++=
+++++
 4 files changed, 142 insertions(+), 114 deletions(-)

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmware.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/unused/vmware.te mod/domains/program/unused/=
vmware.te
--- orig/domains/program/unused/vmware.te	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/domains/program/unused/vmware.te	2004-09-18 00:29:07.000000000 +0200
@@ -8,6 +8,9 @@
 #
 # Domain is for the VMWare admin programs and daemons.
 # X-Debian-Packages:
+#
+# NOTE: The user vmware domain is provided separately in=20
+# macros/program/vmware_macros.te
 #=20
 # Next two domains are create by the daemon_domain() macro.
 # The vmware_t domain is for running VMWare daemons
@@ -16,11 +19,6 @@
 # quick hack making it privhome, should have a domain for each user in a m=
acro
 daemon_domain(vmware, `, privhome')
=20
-# Domain for the user applications to run in.
-type vmware_user_t, domain, privmem;
-in_user_role(vmware_user_t)
-role sysadm_r types vmware_user_t;
-
 #
 # The vmware_user_exec_t type is for the user programs.
 #
@@ -29,18 +27,9 @@
 # Type for vmware devices.
 type vmware_device_t, file_type, device_type, dev_fs;
=20
-# Type for files in /var/run when a user starts VMWare
-type vmware_user_var_run_t, file_type, pidfile;
-
 # The sys configuration used for the /etc/vmware configuration files
 type vmware_sys_conf_t, file_type, sysadmfile;
=20
-# The user file type is for files created when the user is running VMWare
-type vmware_user_file_t, homedirfile, file_type;
-
-# The user file type for the VMWare configuration files
-type vmware_user_conf_t, homedirfile, file_type;
-
 #########################################################################
 # Additional rules to start/stop VMWare
 #
@@ -73,7 +62,6 @@
 allow vmware_t self:capability { net_raw setuid };
=20
 # Access to ttys
-allow vmware_t user_tty_device_t:chr_file rw_file_perms;
 allow vmware_t console_device_t:chr_file rw_file_perms;
 allow vmware_t sysadm_devpts_t:chr_file rw_file_perms;
=20
@@ -94,99 +82,3 @@
 # Rules needed to shutdown VMWare
 allow vmware_t self:process { signal };
=20
-#############################################################
-# User rules for running VMWare
-#
-# Transition to VMWare user domain
-domain_auto_trans(user_t, vmware_user_exec_t, vmware_user_t)
-can_exec(vmware_user_t, vmware_user_exec_t)
-uses_shlib(vmware_user_t)
-file_type_auto_trans(vmware_user_t, var_run_t, vmware_user_var_run_t, file)
-
-general_domain_access(vmware_user_t);
-
-# Capabilities needed by VMWare for the user execution. This seems a=20
-# bit too much, so be careful.
-allow vmware_user_t self:capability { dac_override setgid sys_nice sys_res=
ource setuid sys_admin sys_rawio };
-
-# Access to ttys
-allow vmware_user_t vmware_device_t:chr_file rw_file_perms;
-allow vmware_user_t tty_device_t:chr_file rw_file_perms;
-allow vmware_user_t user_tty_device_t:chr_file rw_file_perms;
-allow vmware_user_t local_login_t:fd use;
-
-# Access /proc
-r_dir_file(vmware_user_t, proc_t)
-
-# Access to some files in the user home directory
-r_dir_file(vmware_user_t, user_home_t)
-
-# Access to runtime files for user
-allow vmware_user_t vmware_user_file_t:dir rw_dir_perms;
-allow vmware_user_t vmware_user_file_t:file create_file_perms;
-allow vmware_user_t vmware_user_conf_t:file create_file_perms;
-
-# Allow read access to /etc/vmware and /usr/lib/vmware configuration files
-r_dir_file(vmware_user_t, vmware_sys_conf_t)
-
-# Allow vmware_user_t to read/write files in the tmp dir
-allow vmware_user_t tmp_t:dir create_dir_perms;
-allow vmware_user_t tmp_t:file create_file_perms;
-allow vmware_user_t tmp_t:file { execute };
-
-# Allow read access to several paths
-r_dir_file(vmware_user_t, etc_t)
-allow vmware_user_t etc_runtime_t:file r_file_perms;
-allow vmware_user_t device_t:dir r_dir_perms;
-allow vmware_user_t var_t:dir r_dir_perms;
-allow vmware_user_t tmpfs_t:file rw_file_perms;
-
-# Allow vmware to write to ~/.vmware
-allow vmware_user_t vmware_user_file_t:dir rw_dir_perms;
-allow vmware_user_t vmware_user_file_t:file create_file_perms;
-
-#
-# This is bad; VMWare needs execute permission to the .cfg file for the
-# configuration to run.
-#
-allow vmware_user_t vmware_user_conf_t:file execute;
-
-# Access X11 config files
-allow vmware_user_t lib_t:file r_file_perms;
-
-# Access components of VMWare in /usr/lib/vmware/bin by default
-allow vmware_user_t bin_t:dir r_dir_perms;
-
-# Allow access to lp port (Need to create an lp device domain )
-allow vmware_user_t device_t:chr_file r_file_perms;
-
-# Allow access to /dev/mem
-allow vmware_user_t memory_device_t:chr_file { read write };
-
-# Allow access to mouse
-allow vmware_user_t mouse_device_t:chr_file r_file_perms;
-
-# Allow access the sound device=20
-allow vmware_user_t sound_device_t:chr_file { ioctl write };
-
-# Allow removable media and devices
-allow vmware_user_t removable_device_t:blk_file r_file_perms;
-allow vmware_user_t removable_device_t:lnk_file { read };
-
-# Allow access to the real time clock device
-allow vmware_user_t clock_device_t:chr_file { read };
-
-# Allow to attach to Xserver, and Xserver to attach back
-ifdef(`gnome-pty-helper.te', `
-allow vmware_user_t user_gph_t:fd use;
-')
-ifdef(`startx.te', `
-allow vmware_user_t user_xserver_tmp_t:sock_file { unlink write };
-allow vmware_user_t user_xserver_tmp_t:dir { search };
-allow vmware_user_t user_xserver_t:unix_stream_socket { connectto };
-allow user_xserver_t vmware_user_t:shm r_shm_perms;
-allow user_xserver_t vmware_user_t:fd use;
-')
-
-# Allow filesystem read access
-allow vmware_user_t fs_t:filesystem { getattr };
diff -urN orig/file_contexts/program/vmware.fc mod/file_contexts/program/vm=
ware.fc
--- orig/file_contexts/program/vmware.fc	2004-07-01 10:18:14.000000000 +0200
+++ mod/file_contexts/program/vmware.fc	2004-09-18 00:30:51.000000000 +0200
@@ -37,6 +37,6 @@
 # The rules below assume that the user VMWare virtual disks are in the
 # ~/vmware, and the preferences and license files are in ~/.vmware.
 #
-HOME_DIR/\.vmware(/.*)?	system_u:object_r:vmware_ROLE_file_t
-HOME_DIR/\vmware(/.*)?	system_u:object_r:vmware_ROLE_file_t
-HOME_DIR/\vmware[^/]*/.*\.cfg	--	system_u:object_r:vmware_ROLE_conf_t
+HOME_DIR/\.vmware(/.*)?	system_u:object_r:ROLE_vmware_file_t
+HOME_DIR/\vmware(/.*)?	system_u:object_r:ROLE_vmware_file_t
+HOME_DIR/\vmware[^/]*/.*\.cfg	--	system_u:object_r:ROLE_vmware_conf_t
diff -urN orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/base_user_macros.te	2004-09-18 00:26:08.000000000 +0200
@@ -158,6 +158,7 @@
 ifdef(`irc.te', `irc_domain($1)')
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
+ifdef(`vmware.te', `vmware_domain($1)')
=20
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -urN orig/macros/macros/program/vmware_macros.te mod/macros/macros/pro=
gram/vmware_macros.te
--- orig/macros/macros/program/vmware_macros.te	1970-01-01 01:00:00.0000000=
00 +0100
+++ mod/macros/macros/program/vmware_macros.te	2004-09-18 00:26:08.00000000=
0 +0200
@@ -0,0 +1,135 @@
+# Macro for vmware
+#
+# Based on work contributed by Mark Westerman (mark.westerman@westcam.com)=
,=20
+# modifications by NAI Labs.
+#
+# Turned into a macro by Thomas Bleher <ThomasBleher@gmx.de>
+#
+# vmware_domain(domain_prefix)
+#
+# Define a derived domain for the vmware program when executed by
+# a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/vmware.te. This file also
+# implements a separate domain vmware_t.
+#
+=20
+define(`vmware_domain', `
+
+# Domain for the user applications to run in.
+type $1_vmware_t, domain, privmem;
+
+role $1_r types $1_vmware_t;
+
+# The user file type is for files created when the user is running VMWare
+type $1_vmware_file_t, homedirfile, file_type;
+
+# The user file type for the VMWare configuration files
+type $1_vmware_conf_t, homedirfile, file_type;
+
+# for compatibility with older policy versions
+typealias $1_vmware_t alias vmware_$1_t;
+typealias $1_vmware_file_t alias vmware_$1_file_t;
+typealias $1_vmware_conf_t alias vmware_$1_conf_t;
+
+# vmware wants to access the users tty
+allow vmware_t $1_tty_device_t:chr_file rw_file_perms;
+
+#############################################################
+# User rules for running VMWare
+#
+# Transition to VMWare user domain
+domain_auto_trans($1_t, vmware_user_exec_t, $1_vmware_t)
+can_exec($1_vmware_t, vmware_user_exec_t)
+uses_shlib($1_vmware_t)
+var_run_domain($1_vmware)
+
+general_domain_access($1_vmware_t);
+
+# Capabilities needed by VMWare for the user execution. This seems a=20
+# bit too much, so be careful.
+allow $1_vmware_t self:capability { dac_override setgid sys_nice sys_resou=
rce setuid sys_admin sys_rawio };
+
+# Access to ttys
+allow $1_vmware_t vmware_device_t:chr_file rw_file_perms;
+allow $1_vmware_t tty_device_t:chr_file rw_file_perms;
+allow $1_vmware_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_vmware_t local_login_t:fd use;
+
+# Access /proc
+r_dir_file($1_vmware_t, proc_t)
+
+# Access to some files in the user home directory
+r_dir_file($1_vmware_t, $1_home_t)
+
+# Access to runtime files for user
+allow $1_vmware_t $1_vmware_file_t:dir rw_dir_perms;
+allow $1_vmware_t $1_vmware_file_t:file create_file_perms;
+allow $1_vmware_t $1_vmware_conf_t:file create_file_perms;
+
+# Allow read access to /etc/vmware and /usr/lib/vmware configuration files
+r_dir_file($1_vmware_t, vmware_sys_conf_t)
+
+# Allow $1_vmware_t to read/write files in the tmp dir
+tmp_domain($1_vmware)
+allow $1_vmware_t $1_vmware_tmp_t:file execute;
+
+# Allow read access to several paths
+r_dir_file($1_vmware_t, etc_t)
+allow $1_vmware_t etc_runtime_t:file r_file_perms;
+allow $1_vmware_t device_t:dir r_dir_perms;
+allow $1_vmware_t var_t:dir r_dir_perms;
+allow $1_vmware_t tmpfs_t:file rw_file_perms;
+
+# Allow vmware to write to ~/.vmware
+rw_dir_create_file($1_vmware_t, $1_vmware_file_t)
+
+#
+# This is bad; VMWare needs execute permission to the .cfg file for the
+# configuration to run.
+#
+allow $1_vmware_t $1_vmware_conf_t:file execute;
+
+# Access X11 config files
+allow $1_vmware_t lib_t:file r_file_perms;
+
+# Access components of VMWare in /usr/lib/vmware/bin by default
+allow $1_vmware_t bin_t:dir r_dir_perms;
+
+# Allow access to lp port (Need to create an lp device domain )
+allow $1_vmware_t device_t:chr_file r_file_perms;
+
+# Allow access to /dev/mem
+allow $1_vmware_t memory_device_t:chr_file { read write };
+
+# Allow access to mouse
+allow $1_vmware_t mouse_device_t:chr_file r_file_perms;
+
+# Allow access the sound device=20
+allow $1_vmware_t sound_device_t:chr_file { ioctl write };
+
+# Allow removable media and devices
+allow $1_vmware_t removable_device_t:blk_file r_file_perms;
+allow $1_vmware_t device_t:lnk_file { read };
+
+# Allow access to the real time clock device
+allow $1_vmware_t clock_device_t:chr_file { read };
+
+# Allow to attach to Xserver, and Xserver to attach back
+ifdef(`gnome-pty-helper.te', `
+allow $1_vmware_t $1_gph_t:fd use;
+')
+ifdef(`startx.te', `
+allow $1_vmware_t $1_xserver_tmp_t:sock_file { unlink write };
+allow $1_vmware_t $1_xserver_tmp_t:dir { search };
+allow $1_vmware_t $1_xserver_t:unix_stream_socket { connectto };
+allow $1_xserver_t $1_vmware_t:shm r_shm_perms;
+allow $1_xserver_t $1_vmware_t:fd use;
+')
+
+# Allow filesystem read access
+allow $1_vmware_t fs_t:filesystem { getattr };
+
+')
+

--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBS2oUxWIrrrL0q+cRAngFAKCCMo2pQvxXrDbU6mVicPI3YUyNwgCcCe20
zwQL2I2Y9AujTcHpy8skmn8=
=JzO7
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
