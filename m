Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BDWqrT024555
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 09:32:53 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BDVw9R021035
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 13:31:58 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 11 Sep 2004 15:32:48 +0200
Date: Sat, 11 Sep 2004 15:33:24 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: policy patch: some misc additions
Message-Id: <20040911133324.GA2557@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--O5XBE6gyVG5Rl6Rj
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch against latest CVS adds some misc policy:

logrotate.te: the suse version doesn't work without this
modutil.te: I see no reason why user_r should ever touch insmod_t
iptables.te: added tc (traffic control) to the iptables domain
rpm.te: gpg doesn't want to verify signatures otherwise
xdm.te: needed with XFree86 4.3, kdm 3.3 and nvidia
types.fc: added file contexts for some kde and gnome libraries
          (filenames are like /opt/kde3/lib/kde3/kcalc.so)
          the nVidia libs need some extra file context, too
gpg_agent_macros.te: permission was needed because of wrongly labeled
                     files (see above)
ssh_agent_macros.te: make sure user_home_t and nfs_t behave the same;
                     also add my name (I'm the original author of this
                     policy)
ssh-agent.te: ssh wants to create ~/.ssh if it doesn't exist

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-selinux.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/logrotate.te mod/domains/program/logrotate.te
--- orig/domains/program/logrotate.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/logrotate.te	2004-09-11 14:47:06.000000000 +0200
@@ -42,7 +42,11 @@
=20
 # it should not require this
 allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr searc=
h };
+ifdef(`distro_suse', `
+allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { read };
+', `
 dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { read };
+')
=20
 # create lock files
 rw_dir_create_file(logrotate_t, var_lock_t)
diff -ur orig/domains/program/modutil.te mod/domains/program/modutil.te
--- orig/domains/program/modutil.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/modutil.te	2004-09-11 14:47:06.000000000 +0200
@@ -79,7 +79,6 @@
 ')
 can_network(insmod_t)
 can_ypbind(insmod_t)
-in_user_role(insmod_t)
 uses_shlib(insmod_t)
 read_locale(insmod_t)
=20
diff -ur orig/domains/program/sulogin.te mod/domains/program/sulogin.te
--- orig/domains/program/sulogin.te	2004-07-08 08:57:11.000000000 +0200
+++ mod/domains/program/sulogin.te	2004-09-11 14:47:06.000000000 +0200
@@ -15,12 +15,19 @@
 general_domain_access(sulogin_t);
=20
 domain_auto_trans({ initrc_t init_t }, sulogin_exec_t, sulogin_t)
-allow sulogin_t shell_exec_t:file r_file_perms;
+uses_shlib(sulogin_t)
+ifdef(`distro_suse', `
+# suse doesnt use pam with sulogin...
+domain_auto_trans(sulogin_t, shell_exec_t, sysadm_t)
+allow sulogin_t init_t:process getpgid;
+allow sulogin_t self:capability sys_tty_config;
+', `
 domain_trans(sulogin_t, shell_exec_t, sysadm_t)
+allow sulogin_t shell_exec_t:file r_file_perms;
=20
-uses_shlib(sulogin_t);
 can_setexec(sulogin_t)
 can_getsecurity(sulogin_t)
+')
 allow sulogin_t shadow_t:file { getattr read };
=20
 r_dir_file(sulogin_t, etc_t)
diff -ur orig/domains/program/unused/iptables.te mod/domains/program/unused=
/iptables.te
--- orig/domains/program/unused/iptables.te	2004-09-11 14:31:46.000000000 +=
0200
+++ mod/domains/program/unused/iptables.te	2004-09-11 14:49:51.000000000 +0=
200
@@ -12,6 +12,8 @@
 role sysadm_r types iptables_t;
 domain_auto_trans(sysadm_t, iptables_exec_t, iptables_t)
=20
+ifdef(`distro_suse', `domain_auto_trans(initrc_t, iptables_exec_t, iptable=
s_t)')
+
 ifdef(`modutil.te', `
 # for modprobe
 allow iptables_t sbin_t:dir search;
@@ -56,3 +58,7 @@
=20
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file { append };
+
+# for /usr/bin/tc
+allow iptables_t self:netlink_route_socket { create getattr bind nlmsg_rea=
d nlmsg_write read write };
+=20
diff -ur orig/domains/program/unused/rpm.te mod/domains/program/unused/rpm.=
te
--- orig/domains/program/unused/rpm.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/rpm.te	2004-09-11 14:47:06.000000000 +0200
@@ -64,6 +64,11 @@
 domain_auto_trans(rpm_script_t, cupsd_exec_t, cupsd_t)
 ')
=20
+ifdef(`gpg.te', `
+# gpg wants this so it does not dump core on errors
+allow rpm_t self:process { setrlimit };
+')
+
 # for a bug in rm
 dontaudit initrc_t pidfile:file write;
=20
diff -ur orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm.=
te
--- orig/domains/program/unused/xdm.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/xdm.te	2004-09-11 14:47:06.000000000 +0200
@@ -72,6 +72,7 @@
 #allow xdm_t memory_device_t:chr_file { execute read write };
=20
 allow xdm_t { urandom_device_t random_device_t }:chr_file { getattr read i=
octl };
+allow xdm_xserver_t zero_device_t:chr_file { read write execute };
=20
 # Transition to user domains for user sessions.
 domain_trans(xdm_t, xsession_exec_t, unpriv_userdomain)
diff -ur orig/file_contexts/program/apache.fc mod/file_contexts/program/apa=
che.fc
--- orig/file_contexts/program/apache.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/apache.fc	2004-09-11 14:48:31.000000000 +0200
@@ -32,3 +32,7 @@
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
 /var/run/apache-ssl(2)?.pid.* -- system_u:object_r:httpd_var_run_t
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
+ifdef(`distro_suse', `
+# suse puts shell scripts there :-(
+/usr/share/apache2/.*	--	system_u:object_r:bin_t
+')
diff -ur orig/file_contexts/program/chkpwd.fc mod/file_contexts/program/chk=
pwd.fc
--- orig/file_contexts/program/chkpwd.fc	2003-11-26 19:01:07.000000000 +0100
+++ mod/file_contexts/program/chkpwd.fc	2004-09-11 14:47:06.000000000 +0200
@@ -1,3 +1,6 @@
 # chkpwd
 /sbin/unix_chkpwd	--	system_u:object_r:chkpwd_exec_t
 /sbin/unix_verify	--	system_u:object_r:chkpwd_exec_t
+ifdef(`distro_suse', `
+/sbin/unix2_chkpwd	--	system_u:object_r:chkpwd_exec_t
+')
diff -ur orig/file_contexts/program/iptables.fc mod/file_contexts/program/i=
ptables.fc
--- orig/file_contexts/program/iptables.fc	2004-05-24 00:55:03.000000000 +0=
200
+++ mod/file_contexts/program/iptables.fc	2004-09-11 14:47:48.000000000 +02=
00
@@ -5,4 +5,5 @@
 /usr/sbin/ipchains.*	--	system_u:object_r:iptables_exec_t
 /usr/sbin/iptables.* 	--	system_u:object_r:iptables_exec_t
 /usr/sbin/ip6tables.*	--	system_u:object_r:iptables_exec_t
+/usr/sbin/tc		--	system_u:object_r:iptables_exec_t
=20
Nur in mod/file_contexts/program: iptables.fc.orig.
diff -ur orig/file_contexts/program/rpm.fc mod/file_contexts/program/rpm.fc
--- orig/file_contexts/program/rpm.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/rpm.fc	2004-09-11 14:47:06.000000000 +0200
@@ -50,4 +50,5 @@
 /usr/bin/online_update		--	system_u:object_r:rpm_exec_t
 /sbin/yast2			--	system_u:object_r:rpm_exec_t
 /var/lib/YaST2(/.*)?			system_u:object_r:rpm_var_lib_t
+/var/log/YaST2(/.*)?			system_u:object_r:rpm_log_t
 ')
diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/types.fc	2004-09-11 14:47:06.000000000 +0200
@@ -224,6 +224,9 @@
 /u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
 /u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
 /u?dev/tape.*		-c	system_u:object_r:tape_device_t
+ifdef(`distro_suse', `
+/u?dev/usbscanner	-c	system_u:object_r:scanner_device_t
+')
 /u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
@@ -242,6 +245,7 @@
 /opt/[^/]*/lib(/.*)?		system_u:object_r:lib_t
 /opt/[^/]*/lib/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /opt/[^/]*/lib/.*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/.*/lib/.*\.so	--	system_u:object_r:shlib_t
 /opt/[^/]*/man(/.*)?		system_u:object_r:man_t
 /opt/[^/]*/libexec(/.*)?	system_u:object_r:bin_t
=20
@@ -336,11 +340,14 @@
 /usr/lib(64)?/autofs/.*\.so	--	system_u:object_r:shlib_t
 /usr/lib(64)?/perl5/man(/.*)?	system_u:object_r:man_t
 /usr/lib(64)?/perl.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*	--	system_u:object_r:shlib=
_t
+/usr/lib(64)?/tls/NVIDIA/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*	--	system_u:obj=
ect_r:shlib_t
 /usr/lib(64)?/selinux(/.*)?		system_u:object_r:policy_src_t
 /usr/lib(64)?/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib(64)?/.*/bin(/.*)?		system_u:object_r:bin_t
 /usr/lib(64)?/gconv/.*\.so	--	system_u:object_r:shlib_t
 /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
+/usr/lib/[^/]*\.so	--	system_u:object_r:shlib_t
=20
 #
 # /usr/.*glibc.*-linux/lib(64)?
diff -ur orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_age=
nt_macros.te
--- orig/macros/program/gpg_agent_macros.te	2004-07-07 22:46:41.000000000 +=
0200
+++ mod/macros/program/gpg_agent_macros.te	2004-09-11 14:47:06.000000000 +0=
200
@@ -94,9 +94,6 @@
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
=20
-# pinentry-qt needs this (executes a KDE style library)
-allow $1_gpg_pinentry_t lib_t:file { execute };
-
 allow $1_gpg_pinentry_t { proc_t self }:dir { search };
 allow $1_gpg_pinentry_t { proc_t self }:lnk_file { read };
 # read /proc/meminfo
diff -ur orig/macros/program/ssh_agent_macros.te mod/macros/program/ssh_age=
nt_macros.te
--- orig/macros/program/ssh_agent_macros.te	2004-09-11 14:31:47.000000000 +=
0200
+++ mod/macros/program/ssh_agent_macros.te	2004-09-11 15:23:01.000000000 +0=
200
@@ -3,7 +3,8 @@
 #
=20
 #
-# Author:  Russell Coker <russell@coker.com.au>
+# Authors:  Russell Coker <russell@coker.com.au>,
+#           Thomas Bleher <ThomasBleher@gmx.de>
 #
=20
 #=20
@@ -42,7 +43,6 @@
 allow $1_ssh_agent_t autofs_t:dir { search getattr };
 ')
 rw_dir_create_file($1_ssh_agent_t, nfs_t)
-can_exec($1_ssh_agent_t, nfs_t)
 ')dnl end nfs_home_dirs
=20
 uses_shlib($1_ssh_agent_t)
@@ -70,7 +70,7 @@
 can_unix_connect($1_t, $1_ssh_agent_t)
=20
 # transition back to normal privs upon exec
-domain_auto_trans($1_ssh_agent_t, { bin_t shell_exec_t $1_home_t }, $1_t)
+domain_auto_trans($1_ssh_agent_t, { bin_t shell_exec_t $1_home_t ifdef(`nf=
s_home_dirs', `nfs_t')}, $1_t)
 allow $1_ssh_agent_t bin_t:dir search;
=20
 # allow reading of /usr/bin/X11 (is a symlink)
diff -ur orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/ssh_macros.te	2004-09-11 14:47:06.000000000 +0200
@@ -32,7 +32,7 @@
 allow $1_ssh_t autofs_t:dir { search getattr };
 ')
 ifdef(`nfs_home_dirs', `
-rw_dir_create_file($1_ssh_t, nfs_t)
+create_dir_file($1_ssh_t, nfs_t)
 ')dnl end if nfs_home_dirs
=20
 # Transition from the user domain to the derived domain.

--YZ5djTAD1cGYuMQK--

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBQv6jxWIrrrL0q+cRAnS7AJ9uhAGiYE1v882LeyDWN7iqfhc7TACeI0ck
cPowfkHLGX2dFvV49rPmGlo=
=kwG/
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
