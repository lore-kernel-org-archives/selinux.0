Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IIVHRb004253
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:31:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IIVDAR013232
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:31:13 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
        by jazzband.ncsc.mil  with ESMTP id i4IIVCHn013224 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:31:13 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 18 May 2004 20:31:10 +0200
Date: Tue, 18 May 2004 01:13:18 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: [PATCH] some file_contexts for SuSE, binfmt_misc, small cleanup (was: Re: Suse)
Message-Id: <20040517231318.GA2127@jmh.mhn.de>
References: <1084540729.17741.61.camel@moss-spartans.epoch.ncsc.mil> <20040514224053.9377E3A404F@abyss.simplyaquatics.com> <20040515232756.GB2095@jmh.mhn.de> <200405171027.47689.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
In-Reply-To: <200405171027.47689.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--U+BazGySraz5kW0T
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-05-17 04:17]:
> On Sun, 16 May 2004 09:27, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > Another thing is policy: The included policy contains some SuSE-specific
> > cleanup but otherwise is very old (v1.4). I have been working on a prop=
er
> > policy for SuSE for some time now in the background. It still has some
> > rough edges which I want to smooth before I submit the policy for
> > inclusion. If you or anyone else wants an intermediate copy, just drop
> > me a note!
>=20
> It's probably best to discuss policy issues on this list as they arise.  =
If=20
> you make a posting to the list about 100 different policy issues then som=
e of=20
> them will get less attention than they deserve.  Also minor stuff can=20
> probably be merged immediately without any issues.

This is a very good point.
I just went through my tree and collected the patches (not all
SuSE-specific) which I think can be applied immediately.
The patches are:
* binfmt_misc.patch - add support for mounting the binfmt_misc fs
* file_contexts.patch - add a bunch of file contexts
* cleanup.patch - some very small cleanup and policy additions
The patches should apply cleanly against current CVS.

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binfmt_misc.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/initrc.te mod/domains/program/initrc.te
--- orig/domains/program/initrc.te	2004-03-23 21:58:08.000000000 +0100
+++ mod/domains/program/initrc.te	2004-05-18 00:56:47.000000000 +0200
@@ -288,6 +288,8 @@
 allow initrc_t sysfs_t:lnk_file { getattr read };
 allow initrc_t udev_runtime_t:file rw_file_perms;
 allow initrc_t device_type:chr_file { setattr };
+allow initrc_t binfmt_misc_fs_t:dir { getattr search };
+allow initrc_t binfmt_misc_fs_t:file { getattr ioctl write };
 ifdef(`pam.te', `
 allow initrc_t pam_var_run_t:dir rw_dir_perms;
 allow initrc_t pam_var_run_t:file { getattr read unlink };
diff -urN orig/domains/program/mount.te mod/domains/program/mount.te
--- orig/domains/program/mount.te	2004-05-12 14:56:49.000000000 +0200
+++ mod/domains/program/mount.te	2004-05-18 00:56:47.000000000 +0200
@@ -56,6 +56,9 @@
 # On some RedHat systems, /boot is a mount point
 allow mount_t boot_t:dir mounton;
 allow mount_t device_t:dir mounton;
+# mount binfmt_misc on /proc/sys/fs/binfmt_misc
+allow mount_t sysctl_t:dir { mounton search };
+
 ifdef(`devfsd.te', `
 allow mount_t device_t:filesystem { mount unmount };
 ')
diff -urN orig/genfs_contexts mod/genfs_contexts
--- orig/genfs_contexts	2004-05-11 19:55:37.000000000 +0200
+++ mod/genfs_contexts	2004-05-18 00:56:47.000000000 +0200
@@ -96,4 +96,5 @@
 genfscon usbfs / system_u:object_r:usbfs_t
 genfscon nfsd / system_u:object_r:nfsd_fs_t
 genfscon rpc_pipefs / system_u:object_r:rpc_pipefs_t
+genfscon binfmt_misc / system_u:object_r:binfmt_misc_fs_t
=20
diff -urN orig/types/file.te mod/types/file.te
--- orig/types/file.te	2004-05-12 14:56:52.000000000 +0200
+++ mod/types/file.te	2004-05-18 00:56:47.000000000 +0200
@@ -26,6 +26,7 @@
 type usbfs_t, fs_type;
 type nfsd_fs_t, fs_type;
 type rpc_pipefs_t, fs_type;
+type binfmt_misc_fs_t, fs_type;
=20
 #
 # file_t is the default type of a file that has not yet been

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="file_contexts.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/file_contexts/program/ipsec.fc mod/file_contexts/program/ipse=
c.fc
--- orig/file_contexts/program/ipsec.fc	2004-03-03 21:53:52.000000000 +0100
+++ mod/file_contexts/program/ipsec.fc	2004-05-18 00:39:56.000000000 +0200
@@ -17,3 +17,7 @@
 /usr/local/sbin/ipsec	--	system_u:object_r:ipsec_mgmt_exec_t
 /var/run/ipsec\.info		system_u:object_r:ipsec_var_run_t
 /var/run/pluto\.ctl		system_u:object_r:ipsec_var_run_t
+
+# Kame
+/usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
+/usr/sbin/setkey	--	system_u:object_r:ipsec_exec_t
diff -ur orig/file_contexts/program/iptables.fc mod/file_contexts/program/i=
ptables.fc
--- orig/file_contexts/program/iptables.fc	2004-02-02 16:17:23.000000000 +0=
100
+++ mod/file_contexts/program/iptables.fc	2004-05-18 00:39:56.000000000 +02=
00
@@ -2,3 +2,7 @@
 /sbin/ipchains.*	--	system_u:object_r:iptables_exec_t
 /sbin/iptables.* 	--	system_u:object_r:iptables_exec_t
 /sbin/ip6tables.*	--	system_u:object_r:iptables_exec_t
+/usr/sbin/ipchains.*	--	system_u:object_r:iptables_exec_t
+/usr/sbin/iptables.* 	--	system_u:object_r:iptables_exec_t
+/usr/sbin/ip6tables.*	--	system_u:object_r:iptables_exec_t
+
diff -ur orig/file_contexts/program/logrotate.fc mod/file_contexts/program/=
logrotate.fc
--- orig/file_contexts/program/logrotate.fc	2004-03-03 21:53:52.000000000 +=
0100
+++ mod/file_contexts/program/logrotate.fc	2004-05-18 00:39:56.000000000 +0=
200
@@ -1,6 +1,7 @@
 # logrotate
 /usr/sbin/logrotate	--	system_u:object_r:logrotate_exec_t
 /usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
+/usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
 /var/lib(64)?/logrotate.status --	system_u:object_r:logrotate_var_lib_t
 /var/lib(64)?/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
diff -ur orig/file_contexts/program/lpd.fc mod/file_contexts/program/lpd.fc
--- orig/file_contexts/program/lpd.fc	2004-04-07 19:14:04.000000000 +0200
+++ mod/file_contexts/program/lpd.fc	2004-05-18 00:39:56.000000000 +0200
@@ -3,6 +3,7 @@
 /dev/lp.*		-c	system_u:object_r:printer_device_t
 /dev/par.*		-c	system_u:object_r:printer_device_t
 /dev/usb/lp.*		-c	system_u:object_r:printer_device_t
+/dev/usblp.*		-c	system_u:object_r:printer_device_t
 /usr/sbin/lpd		--	system_u:object_r:lpd_exec_t
 /usr/sbin/checkpc	--	system_u:object_r:checkpc_exec_t
 /var/spool/lpd(/.*)?		system_u:object_r:print_spool_t
diff -ur orig/file_contexts/program/restorecon.fc mod/file_contexts/program=
/restorecon.fc
--- orig/file_contexts/program/restorecon.fc	2004-03-08 21:45:32.000000000 =
+0100
+++ mod/file_contexts/program/restorecon.fc	2004-05-18 00:39:56.000000000 +=
0200
@@ -1,2 +1,3 @@
 # restorecon
 /usr/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
+/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
diff -ur orig/file_contexts/program/rpm.fc mod/file_contexts/program/rpm.fc
--- orig/file_contexts/program/rpm.fc	2004-05-05 09:36:29.000000000 +0200
+++ mod/file_contexts/program/rpm.fc	2004-05-18 00:39:56.000000000 +0200
@@ -52,3 +52,8 @@
 /usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
 /usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+# SuSE
+/usr/bin/online_update		--	system_u:object_r:rpm_exec_t
+/sbin/yast2			--	system_u:object_r:rpm_exec_t
+/var/lib/YaST2(/.*)?			system_u:object_r:rpm_var_lib_t
+
diff -ur orig/file_contexts/program/screen.fc mod/file_contexts/program/scr=
een.fc
--- orig/file_contexts/program/screen.fc	2004-03-09 16:31:36.000000000 +0100
+++ mod/file_contexts/program/screen.fc	2004-05-18 00:39:56.000000000 +0200
@@ -3,3 +3,7 @@
 HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_home_screen_t
 /var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
 /var/run/screen/S-[^/]+/.*	<<none>>
+# SuSE puts this under /tmp ...
+/tmp/uscreens		-d	system_u:object_r:var_run_t
+/tmp/uscreens/S-[^/]+	-d	system_u:object_r:screen_dir_t
+/tmp/uscreens/S-[^/]+/.*	<<none>>
diff -ur orig/file_contexts/program/xdm.fc mod/file_contexts/program/xdm.fc
--- orig/file_contexts/program/xdm.fc	2004-03-17 19:26:06.000000000 +0100
+++ mod/file_contexts/program/xdm.fc	2004-05-18 00:39:56.000000000 +0200
@@ -1,6 +1,7 @@
 # X Display Manager
 /usr/bin/[xgkw]dm	--	system_u:object_r:xdm_exec_t
 /usr/X11R6/bin/[xgkw]dm	--	system_u:object_r:xdm_exec_t
+/opt/kde3/bin/kdm	--	system_u:object_r:xdm_exec_t
 /usr/bin/gpe-dm		--	system_u:object_r:xdm_exec_t
 /var/[xgk]dm(/.*)?		system_u:object_r:xserver_log_t
 /usr/var/[xgkw]dm(/.*)?		system_u:object_r:xserver_log_t
@@ -11,9 +12,8 @@
 /etc/X11/wdm(/.*)?		system_u:object_r:xdm_rw_etc_t
 /etc/X11/wdm/Xsetup.*	--	system_u:object_r:xsession_exec_t
 /etc/X11/wdm/Xstartup.*	--	system_u:object_r:xsession_exec_t
-/etc/X11/wdm/Xreset.*	--	system_u:object_r:xsession_exec_t
-/etc/X11/wdm/Xsession	--	system_u:object_r:xsession_exec_t
-/etc/X11/xdm/Xsession	--	system_u:object_r:xsession_exec_t
+/etc/X11/[wx]dm/Xreset.*	--	system_u:object_r:xsession_exec_t
+/etc/X11/[wx]dm/Xsession	--	system_u:object_r:xsession_exec_t
 /etc/kde/kdm/Xsession	--	system_u:object_r:xsession_exec_t
 /var/run/xdmctl(/.*)?		system_u:object_r:xdm_var_run_t
 /var/run/console.*		system_u:object_r:xdm_var_run_t
@@ -30,7 +30,8 @@
 #
 # Rules for kde login
 #
-/etc/kde/kdm/Xstartup   --		system_u:object_r:bin_t
-/etc/kde/kdm/Xreset     --		system_u:object_r:bin_t
-/etc/kde/kdm/backgroundrc	system_u:object_r:xdm_var_run_t
+/etc/kde3?/kdm/Xstartup   --		system_u:object_r:xsession_exec_t
+/etc/kde3?/kdm/Xreset     --		system_u:object_r:xsession_exec_t
+/etc/kde3?/kdm/Xsession		--	system_u:object_r:xsession_exec_t
+/etc/kde3?/kdm/backgroundrc	system_u:object_r:xdm_var_run_t
 /usr/lib(64)?/qt-3.2/etc/settings(/.*)?	system_u:object_r:xdm_var_run_t
diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-05-05 09:36:29.000000000 +0200
+++ mod/file_contexts/types.fc	2004-05-18 00:39:56.000000000 +0200
@@ -58,6 +58,7 @@
 #
 # A common mount point
 /mnt(/.*)?		-d	system_u:object_r:mnt_t
+/media(/.*)?		-d	system_u:object_r:mnt_t
=20
 #
 # /var
@@ -214,6 +215,9 @@
 /sys(/.*)?			<<none>>
 /selinux(/.*)?			<<none>>
 /opt(/.*)?			system_u:object_r:usr_t
+/opt/[^/]*/bin(/.*)?		system_u:object_r:bin_t
+/opt/[^/]*/lib(/.*)?		system_u:object_r:lib_t
+/opt/[^/]*/man(/.*)?		system_u:object_r:man_t
=20
 #
 # /etc
@@ -277,6 +281,7 @@
 /usr/man(/.*)?			system_u:object_r:man_t
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
+/usr/share/texmf/teTeX/bin(/.*)?	system_u:object_r:bin_t
=20
 #
 # /usr/bin
@@ -373,6 +378,7 @@
 #
 /usr/X11R6/lib(64)?/X11/fonts(/.*)?		system_u:object_r:fonts_t
 /usr/share/fonts(/.*)?			system_u:object_r:fonts_t
+/usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
=20
 #
 # /var/run

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/domains/program/unused/dbusd.te
+++ mod/domains/program/unused/dbusd.te
@@ -11,7 +11,8 @@
 allow dbusd_t self:unix_stream_socket create_stream_socket_perms;
=20
 allow dbusd_t etc_t:file { getattr read };
-allow dbusd_t self:capability { setgid setuid };
+# dac_override: /var/run/dbus is owned by messagebus on Debian
+allow dbusd_t self:capability { setgid setuid dac_override };
=20
 # I expect we need more than this
 allow { dbus_client_domain userdomain } dbusd_var_run_t:dir search;
--- orig/macros/global_macros.te
+++ mod/macros/global_macros.te
@@ -43,8 +43,10 @@
 ##################################
 # read_sysctl(domain)
 #
-# Permissions for reading the locale data,
-# /etc/localtime and the files that it links to
+# Permissions for reading sysctl variables.
+# If the second parameter is 'full', allow
+# reading of any sysctl variables, else only
+# sysctl_kernel_t.
 #
 define(`read_sysctl', `
 # Read system variables in /sys.
=20
--- orig/domains/program/unused/inetd.te
+++ mod/domains/program/inetd.te
@@ -118,7 +119,9 @@
 dontaudit inetd_child_t krb5_conf_t:file write;
 allow inetd_child_t urandom_device_t:chr_file { getattr read };
=20
+ifdef(`unconfined.te', `
 domain_auto_trans(inetd_t, unconfined_exec_t, unconfined_t)
+')
=20
 ifdef(`unlimitedServices', `
 unconfined_domain(inetd_t)=20
--- orig/domains/program/unused/rpm.te
+++ mod/domains/program/rpm.te
@@ -208,7 +208,7 @@
 can_exec(rpm_script_t, usr_t)
=20
 allow rpm_t mount_t:tcp_socket { write };
-rw_dir_file(rpm_t, nfs_t)
+create_dir_file(rpm_t, nfs_t)
 allow rpm_t nfs_t:filesystem getattr;
=20
 allow rpm_script_t userdomain:fd use;

--/9DWx/yDrRhgMJTb--

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqUcOxWIrrrL0q+cRAvRtAKC6yzZwQzCpAt/F7vqH/BKBUtO8zgCgpfgO
TkxK8Kt0RHT2DJH/HegmSWs=
=oOnR
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
