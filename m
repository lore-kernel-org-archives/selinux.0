Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAAAOoIi028907
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 05:24:50 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAAAOqah015657
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 10:24:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 10 Nov 2004 11:24:51 +0100
Date: Wed, 10 Nov 2004 11:24:39 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Colin Walters <walters@verbum.org>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: misc policy additions
Message-Id: <20041110102439.GA2541@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de> <1100046550.26388.8.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
In-Reply-To: <1100046550.26388.8.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6sX45UoQRIJXqkqR
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Colin Walters <walters@verbum.org> [2004-11-10 03:37]:
> On Tue, 2004-11-09 at 22:04 +0100, Thomas Bleher wrote:
>=20
> +ifdef(`distro_suse', `
> +# because of libraries in /var/lib/samba/bin
> +allow ldconfig_t { var_lib_t bin_t }:dir search;
> +allow ldconfig_t var_lib_t:lnk_file read;
>=20
> I know this is under distro_suse, but wouldn't it be better to label
> these files as lib_t, and have that be ifdef(`distro_suse') in the
> samba.fc?

You are right, the second line is not needed, all symlinks are labeled
lib_t. I did not move it to samba.te because these are client libs,
samba itself is not installed.

> -# read /proc/meminfo, /proc/self/mounts and /etc/mtab
> -allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };
> +# read /proc/meminfo, /proc/self/mounts, /etc/localtime and /etc/mtab
> +allow nrpe_t { self proc_t etc_runtime_t locale_t }:file { getattr read =
};
>=20
> The convention here seems to be: read_locale(nrpe_t)  That does allow
> one to turn off reading of locale files in a centralized place.

OK, fixed.

Updated patch is attached.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable

diff -urN orig/assert.te mod/assert.te
--- orig/assert.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/assert.te	2004-11-09 21:50:48.000000000 +0100
@@ -36,7 +36,7 @@
 # Verify that executable types, the system dynamic loaders, and the
 # system shared libraries can only be modified by administrators.
 #
-neverallow {domain  ifdef(`nfs_export_all_rw',`-kernel_t') ifdef(`ldconfig=
=2Ete', `-ldconfig_t') -admin} { exec_type ld_so_t shlib_t }:file { write a=
ppend unlink rename };
+neverallow {domain  -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin} =
{ exec_type ld_so_t shlib_t }:file { write append unlink rename };
 neverallow {domain  ifdef(`ldconfig.te', `-ldconfig_t') -change_context -a=
dmin } { exec_type ld_so_t shlib_t }:file relabelto;
=20
 #
@@ -54,8 +54,8 @@
 #
 # Verify that other system software can only be modified by administrators.
 #
-neverallow {domain ifdef(`nfs_export_all_rw',`-kernel_t') ifdef(`ldconfig.=
te', `-ldconfig_t') -admin } { lib_t bin_t sbin_t }:dir { add_name remove_n=
ame rename };
-neverallow { domain ifdef(`nfs_export_all_rw',`-kernel_t') -admin } { lib_=
t bin_t sbin_t }:file { write append unlink rename };
+neverallow {domain -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin } =
{ lib_t bin_t sbin_t }:dir { add_name remove_name rename };
+neverallow { domain -kernel_t -admin } { lib_t bin_t sbin_t }:file { write=
 append unlink rename };
=20
 #
 # Verify that only certain domains have access to the raw disk devices.
diff -urN orig/domains/program/initrc.te mod/domains/program/initrc.te
--- orig/domains/program/initrc.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/initrc.te	2004-11-09 21:50:48.000000000 +0100
@@ -245,7 +245,7 @@
=20
 ifdef(`apmd.te',
 `# Access /dev/apm_bios.
-allow initrc_t apm_bios_t:chr_file { setattr getattr };')
+allow initrc_t apm_bios_t:chr_file { setattr getattr read };')
=20
 ifdef(`lpd.te',
 `# Read printconf files.
@@ -291,7 +291,7 @@
 dontaudit initrc_t mail_spool_t:lnk_file read;
=20
 allow initrc_t sysfs_t:dir { getattr read search };
-allow initrc_t sysfs_t:file { getattr read };
+allow initrc_t sysfs_t:file { getattr read write };
 allow initrc_t sysfs_t:lnk_file { getattr read };
 allow initrc_t udev_runtime_t:file rw_file_perms;
 allow initrc_t device_type:chr_file setattr;
diff -urN orig/domains/program/ldconfig.te mod/domains/program/ldconfig.te
--- orig/domains/program/ldconfig.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/ldconfig.te	2004-11-09 21:51:43.000000000 +0100
@@ -31,3 +31,14 @@
=20
 allow ldconfig_t fs_t:filesystem getattr;
 allow ldconfig_t tmp_t:dir search;
+
+ifdef(`apache.te', `
+# dontaudit access to /usr/lib/apache, normal programs cannot read these l=
ibs anyway
+dontaudit ldconfig_t httpd_modules_t:dir search;
+')
+
+ifdef(`distro_suse', `
+# because of libraries in /var/lib/samba/bin
+allow ldconfig_t { var_lib_t bin_t }:dir search;
+')
+
diff -urN orig/domains/program/logrotate.te mod/domains/program/logrotate.te
--- orig/domains/program/logrotate.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/logrotate.te	2004-11-09 21:50:48.000000000 +0100
@@ -16,8 +16,8 @@
 type logrotate_t, domain, privowner, privmail, priv_system_role, nscd_clie=
nt_domain;
 role system_r types logrotate_t;
 role sysadm_r types logrotate_t;
-uses_shlib(logrotate_t);
-general_domain_access(logrotate_t);
+uses_shlib(logrotate_t)
+general_domain_access(logrotate_t)
 type logrotate_exec_t, file_type, sysadmfile, exec_type;
=20
 system_crond_entry(logrotate_exec_t, logrotate_t)
@@ -54,7 +54,7 @@
 # Run helper programs.
 allow logrotate_t { bin_t sbin_t }:dir r_dir_perms;
 allow logrotate_t { bin_t sbin_t }:lnk_file read;
-can_exec(logrotate_t, { bin_t sbin_t shell_exec_t ls_exec_t });
+can_exec(logrotate_t, { bin_t sbin_t shell_exec_t ls_exec_t })
=20
 # Read PID files.
 allow logrotate_t pidfile:file r_file_perms;
diff -urN orig/domains/program/restorecon.te mod/domains/program/restorecon=
=2Ete
--- orig/domains/program/restorecon.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/restorecon.te	2004-11-09 21:50:48.000000000 +0100
@@ -41,7 +41,7 @@
 allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
 allow restorecon_t unlabeled_t:dir read;
 allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfrom=
 relabelto };
-allow restorecon_t { device_t device_type }:{ chr_file blk_file } { getatt=
r relabelfrom relabelto };
+allow restorecon_t { device_t device_type ttyfile }:{ chr_file blk_file } =
{ getattr relabelfrom relabelto };
 ifdef(`distro_redhat', `
 allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relabelfr=
om relabelto };
 ')
diff -urN orig/domains/program/syslogd.te mod/domains/program/syslogd.te
--- orig/domains/program/syslogd.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/syslogd.te	2004-11-09 21:50:48.000000000 +0100
@@ -43,12 +43,18 @@
=20
 # Create and bind to /dev/log or /var/run/log.
 file_type_auto_trans(syslogd_t, { device_t var_run_t }, devlog_t, sock_fil=
e)
+ifdef(`distro_suse', `
+# suse creates a /dev/log under /var/lib/stunnel for chrooted stunnel
+file_type_auto_trans(syslogd_t, var_lib_t, devlog_t, sock_file)
+')
 allow syslogd_t self:unix_dgram_socket create_socket_perms;
 allow syslogd_t self:unix_dgram_socket sendto;
 allow syslogd_t self:unix_stream_socket create_stream_socket_perms;
 allow syslogd_t self:fifo_file rw_file_perms;
 allow syslogd_t devlog_t:unix_stream_socket name_bind;
 allow syslogd_t devlog_t:unix_dgram_socket name_bind;
+# log to the xconsole
+allow syslogd_t xconsole_device_t:fifo_file { ioctl read write };
=20
 # Domains with the privlog attribute may log to syslogd.
 allow privlog devlog_t:sock_file rw_file_perms;
diff -urN orig/domains/program/unused/apmd.te mod/domains/program/unused/ap=
md.te
--- orig/domains/program/unused/apmd.te	2004-11-09 08:45:51.000000000 +0100
+++ mod/domains/program/unused/apmd.te	2004-11-09 21:50:48.000000000 +0100
@@ -45,6 +45,8 @@
 # acpid also has a logfile
 log_domain(apmd)
=20
+var_lib_domain(apmd)
+
 allow apmd_t self:file { getattr read ioctl };
 allow apmd_t self:process getsession;
=20
diff -urN orig/domains/program/unused/cups.te mod/domains/program/unused/cu=
ps.te
--- orig/domains/program/unused/cups.te	2004-11-09 08:45:51.000000000 +0100
+++ mod/domains/program/unused/cups.te	2004-11-09 21:52:10.000000000 +0100
@@ -225,6 +225,6 @@
=20
 domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
=20
-')
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;
+')
diff -urN orig/domains/program/unused/nrpe.te mod/domains/program/unused/nr=
pe.te
--- orig/domains/program/unused/nrpe.te	2004-06-16 19:38:16.000000000 +0200
+++ mod/domains/program/unused/nrpe.te	2004-11-09 21:50:48.000000000 +0100
@@ -16,6 +16,7 @@
 allow nrpe_t urandom_device_t:chr_file { getattr ioctl read };
=20
 allow nrpe_t self:fifo_file rw_file_perms;
+allow nrpe_t self:unix_dgram_socket create_socket_perms;
 # use sockets inherited from inetd
 allow nrpe_t inetd_t:tcp_socket { ioctl read write };
 allow nrpe_t devtty_t:chr_file { read write };
@@ -24,6 +24,7 @@
 allow nrpe_t self:process setpgid;

 etc_domain(nrpe)
+read_locale(nrpe_t)

 # permissions for the scripts executed by nrpe
 #
diff -urN orig/domains/program/unused/resmgrd.te mod/domains/program/unused=
/resmgrd.te
--- orig/domains/program/unused/resmgrd.te	2004-10-29 20:33:17.000000000 +0=
200
+++ mod/domains/program/unused/resmgrd.te	2004-11-09 21:50:48.000000000 +01=
00
@@ -16,7 +16,7 @@
 allow resmgrd_t device_t:lnk_file { getattr read };
 # not sure if it needs write access, needs to be investigated further...
 allow resmgrd_t removable_device_t:blk_file { getattr ioctl read write };
-allow resmgrd_t scsi_generic_device_t:chr_file { getattr ioctl read };
+allow resmgrd_t scsi_generic_device_t:chr_file { getattr ioctl read write =
};
 allow resmgrd_t scanner_device_t:chr_file { getattr };
 # I think a dontaudit should be enough there
 dontaudit resmgrd_t fixed_disk_device_t:blk_file { getattr ioctl read };
diff -urN orig/domains/program/unused/rpm.te mod/domains/program/unused/rpm=
=2Ete
--- orig/domains/program/unused/rpm.te	2004-11-09 08:45:54.000000000 +0100
+++ mod/domains/program/unused/rpm.te	2004-11-09 21:50:48.000000000 +0100
@@ -66,11 +66,6 @@
 domain_auto_trans(rpm_script_t, cupsd_exec_t, cupsd_t)
 ')
=20
-ifdef(`gpg.te', `
-# gpg wants this so it does not dump core on errors
-allow rpm_t self:process setrlimit;
-')
-
 # for a bug in rm
 dontaudit initrc_t pidfile:file write;
=20
diff -urN orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm=
=2Ete
--- orig/domains/program/unused/xdm.te	2004-11-09 08:45:55.000000000 +0100
+++ mod/domains/program/unused/xdm.te	2004-11-09 21:50:48.000000000 +0100
@@ -43,7 +43,7 @@
 typealias xdm_rw_etc_t alias etc_xdm_t;
=20
 allow xdm_t default_context_t:dir search;
-allow xdm_t default_context_t:file { read getattr };
+allow xdm_t default_context_t:{ file lnk_file } { read getattr };
=20
 can_network(xdm_t)
 can_ypbind(xdm_t)
@@ -62,6 +62,10 @@
=20
 # init script wants to check if it needs to update windowmanagerlist
 allow initrc_t xdm_rw_etc_t:file { getattr read };
+ifdef(`distro_suse', `
+# set permissions on /tmp/.X11-unix
+allow initrc_t xdm_tmp_t:dir setattr;
+')
=20
 #
 # Use capabilities.
@@ -120,6 +124,7 @@
 # Access devices.
 allow xdm_t device_t:dir { read search };
 allow xdm_t console_device_t:chr_file setattr;
+allow xdm_t xconsole_device_t:fifo_file { getattr setattr };
 allow xdm_t framebuf_device_t:chr_file { getattr setattr };
 allow xdm_t mouse_device_t:chr_file { getattr setattr };
 allow xdm_t apm_bios_t:chr_file { setattr getattr read write };
@@ -130,6 +135,7 @@
 allow xdm_t v4l_device_t:chr_file { setattr getattr };
 allow xdm_t scanner_device_t:chr_file { setattr getattr };
 allow xdm_t tty_device_t:chr_file { ioctl read write setattr getattr };
+allow xdm_t device_t:lnk_file read;
 can_resmgrd_connect(xdm_t)
=20
 # Access xdm log files.
diff -urN orig/file_contexts/program/apmd.fc mod/file_contexts/program/apmd=
=2Efc
--- orig/file_contexts/program/apmd.fc	2004-02-13 19:53:37.000000000 +0100
+++ mod/file_contexts/program/apmd.fc	2004-11-09 21:50:48.000000000 +0100
@@ -5,3 +5,4 @@
 /var/run/apmd\.pid	--	system_u:object_r:apmd_var_run_t
 /var/run/.?acpid.socket	-s	system_u:object_r:apmd_var_run_t
 /var/log/acpid		--	system_u:object_r:apmd_log_t
+/var/lib/acpi(/.*)?		system_u:object_r:apmd_var_lib_t
diff -urN orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-11-09 08:45:55.000000000 +0100
+++ mod/file_contexts/types.fc	2004-11-09 21:50:48.000000000 +0100
@@ -125,6 +125,7 @@
 /u?dev/full		-c	system_u:object_r:null_device_t
 /u?dev/zero		-c	system_u:object_r:zero_device_t
 /u?dev/console		-c	system_u:object_r:console_device_t
+/u?dev/xconsole		-p	system_u:object_r:xconsole_device_t
 /u?dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
 /u?dev/nvram		-c	system_u:object_r:memory_device_t
 /u?dev/random		-c	system_u:object_r:random_device_t
diff -urN orig/macros/global_macros.te mod/macros/global_macros.te
--- orig/macros/global_macros.te	2004-11-09 08:45:55.000000000 +0100
+++ mod/macros/global_macros.te	2004-11-09 21:50:48.000000000 +0100
@@ -379,6 +379,7 @@
 ', `
 file_type_auto_trans($1_t, var_run_t, $1_var_run_t, $2)
 ')
+allow $1_t var_t:dir search;
 allow $1_t $1_var_run_t:dir rw_dir_perms;
 ')
=20
diff -urN orig/macros/program/apache_macros.te mod/macros/program/apache_ma=
cros.te
--- orig/macros/program/apache_macros.te	2004-11-09 08:45:55.000000000 +0100
+++ mod/macros/program/apache_macros.te	2004-11-09 21:50:48.000000000 +0100
@@ -110,7 +110,7 @@
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
=20
-if (httpd_enable_cgi) && (httpd_unified) {
+if (httpd_enable_cgi && httpd_unified) {
 ifelse($1, sys, `
 domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
 domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
diff -urN orig/macros/program/cdrecord_macros.te mod/macros/program/cdrecor=
d_macros.te
--- orig/macros/program/cdrecord_macros.te	2004-11-07 18:33:13.000000000 +0=
100
+++ mod/macros/program/cdrecord_macros.te	2004-11-09 21:50:48.000000000 +01=
00
@@ -28,7 +28,7 @@
=20
 can_resmgrd_connect($1_cdrecord_t)
=20
-allow $1_cdrecord_t home_root_t:dir { search };
+allow $1_cdrecord_t { tmp_t home_root_t }:dir search;
=20
 # allow cdrecord to read user files
 r_dir_file($1_cdrecord_t, { $1_home_t $1_tmp_t })
@@ -45,7 +45,7 @@
 allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write io=
ctl };
=20
 allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
-allow $1_cdrecord_t self:process { getsched setsched fork };
+allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill =
};
=20
 ')
=20
diff -urN orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_ag=
ent_macros.te
--- orig/macros/program/gpg_agent_macros.te	2004-11-09 08:45:56.000000000 +=
0100
+++ mod/macros/program/gpg_agent_macros.te	2004-11-09 21:50:48.000000000 +0=
100
@@ -45,13 +45,11 @@
=20
 allow $1_gpg_agent_t device_t:dir { getattr read };
=20
-# read ~/.gnupg
+# read and write ~/.gnupg (gpg-agent stores secret keys in ~/.gnupg/privat=
e-keys-v1.d )
 allow $1_gpg_agent_t { home_root_t $1_home_dir_t }:dir search;
-r_dir_file($1_gpg_agent_t, $1_gpg_secret_t)
+create_dir_file($1_gpg_agent_t, $1_gpg_secret_t)
 if (use_nfs_home_dirs) {
-r_dir_file($1_gpg_agent_t, nfs_t)
-# write ~/.xsession-errors
-allow $1_gpg_agent_t nfs_t:file write;
+create_dir_file($1_gpg_agent_t, nfs_t)
 }
=20
 allow $1_gpg_agent_t self:unix_stream_socket create_stream_socket_perms;
diff -urN orig/types/device.te mod/types/device.te
--- orig/types/device.te	2004-11-09 08:45:56.000000000 +0100
+++ mod/types/device.te	2004-11-09 21:50:48.000000000 +0100
@@ -28,6 +28,10 @@
 type console_device_t, device_type, dev_fs;
=20
 #
+# xconsole_device_t is the type of /dev/xconsole
+type xconsole_device_t, file_type, dev_fs;
+
+#
 # memory_device_t is the type of /dev/kmem,
 # /dev/mem, and /dev/port.
 #

--lrZ03NoBR/3+SXJZ--

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkexnxWIrrrL0q+cRAqrOAJ95b1sngCsHy5npsNXFt3h8cZ+owwCfSmus
mbpSdhxm0HHM4Pc8GPnCNpc=
=Eaqd
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
