Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6NhsIi025196
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 18:43:55 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6NhuoX027937
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 23:43:57 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 7 Dec 2004 00:43:56 +0100
Date: Tue, 7 Dec 2004 00:43:58 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: general cleanup
Message-Id: <20041206234358.GG3678@jmh.mhn.de>
References: <20041206233528.GD3678@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
In-Reply-To: <20041206233528.GD3678@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--9aCKuHbn5v2q3RVc
Content-Type: multipart/mixed; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2004-12-07 00:35]:
> Remove some duplicated permissions and attributes.
>=20
> Adds a few permissions:
> * initrc can setattr xconsole_device_t
> * mount can read device_t:lnk_file and read xdm_t:fifo_file

Oops, forgot to attach patch.
Here it is.

Thomas
--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/domains/program/unused/anaconda.te
+++ mod/domains/program/unused/anaconda.te
@@ -12,7 +12,7 @@
 #
 type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain=
, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted;
 role system_r types anaconda_t;
-unconfined_domain(anaconda_t);
+unconfined_domain(anaconda_t)
=20
 role system_r types ldconfig_t;
 domain_auto_trans(anaconda_t, ldconfig_exec_t, ldconfig_t)
--- orig/assert.te
+++ mod/assert.te
@@ -157,6 +158,4 @@
 neverallow * domain:dir ~r_dir_perms;
 neverallow * domain:file_class_set ~rw_file_perms;
 neverallow { domain unlabeled_t } file_type:process *;
-
-neverallow { domain unlabeled_t } file_type:process *;
 neverallow ~{ domain unlabeled_t } *:process *;
--- orig/macros/base_user_macros.te
+++ mod/macros/base_user_macros.te
@@ -31,7 +31,7 @@
 allow $1_t v4l_device_t:chr_file rw_file_perms;
=20
 # Grant permissions within the domain.
-general_domain_access($1_t);
+general_domain_access($1_t)
=20
 # Allow loading DSOs that require executable stack.
 allow $1_t self:process execmem;
@@ -237,7 +238,7 @@
 dontaudit $1_t net_conf_t:file ioctl;
=20
 # Communicate within the domain.
-can_udp_send($1_t, $1_t)
+can_udp_send($1_t, self)
=20
 # Connect to inetd.
 ifdef(`inetd.te', `
@@ -360,7 +361,7 @@
 dontaudit $1_t default_context_t:dir search;
=20
 ifdef(`rpcd.te', `
-create_dir_file($1_t,nfsd_rw_t);
+create_dir_file($1_t, nfsd_rw_t)
 ')
=20
 ')dnl end base_user_domain macro
--- orig/domains/program/initrc.te
+++ mod/domains/program/initrc.te
@@ -186,13 +194,13 @@
 allow initrc_t fixed_disk_device_t:blk_file getattr;
=20
 # Set device ownerships/modes.
-allow initrc_t framebuf_device_t:lnk_file read;
-allow initrc_t framebuf_device_t:devfile_class_set setattr;
+allow initrc_t framebuf_device_t:chr_file setattr;
 allow initrc_t misc_device_t:devfile_class_set setattr;
 allow initrc_t device_t:devfile_class_set setattr;
 allow initrc_t fixed_disk_device_t:devfile_class_set setattr;
 allow initrc_t removable_device_t:devfile_class_set setattr;
 allow initrc_t device_t:lnk_file read;
+allow initrc_t xconsole_device_t:fifo_file setattr;
=20
 # Stat any file.
 allow initrc_t file_type:notdevfile_class_set getattr;
--- orig/domains/program/unused/kudzu.te
+++ mod/domains/program/unused/kudzu.te
@@ -16,7 +16,6 @@
=20
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
-allow kudzu_t etc_t:file { getattr read };
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin=
 sys_tty_config mknod };
 allow kudzu_t modules_conf_t:file { getattr read };
 allow kudzu_t modules_object_t:dir r_dir_perms;
--- orig/domains/program/login.te
+++ mod/domains/program/login.te
@@ -151,11 +154,10 @@
 dontaudit local_login_t fixed_disk_device_t:blk_file { getattr setattr };
 dontaudit local_login_t removable_device_t:blk_file { getattr setattr };
 dontaudit local_login_t device_t:{ chr_file blk_file lnk_file } { getattr =
setattr };
-dontaudit local_login_t misc_device_t:{ chr_file blk_file lnk_file } { get=
attr setattr };
-dontaudit local_login_t framebuf_device_t:{ chr_file blk_file lnk_file } {=
 getattr setattr read };
+dontaudit local_login_t misc_device_t:{ chr_file blk_file } { getattr seta=
ttr };
+dontaudit local_login_t framebuf_device_t:chr_file { getattr setattr read =
};
 dontaudit local_login_t apm_bios_t:chr_file { getattr setattr };
-dontaudit local_login_t v4l_device_t:{ chr_file blk_file lnk_file } { geta=
ttr setattr read };
-dontaudit local_login_t v4l_device_t:dir { read search getattr };
+dontaudit local_login_t v4l_device_t:chr_file { getattr setattr read };
 dontaudit local_login_t removable_device_t:chr_file { getattr setattr };
 dontaudit local_login_t scanner_device_t:chr_file { getattr setattr };
=20
--- orig/macros/program/sudo_macros.te
+++ mod/macros/program/sudo_macros.te
@@ -31,7 +31,6 @@
 rw_dir_create_file($1_sudo_t, $1_tmp_t)
 rw_dir_create_file($1_sudo_t, $1_home_t)
 domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
-r_dir_file($1_sudo_t, selinux_config_t)
 ')
=20
 # arch-tag: 67418b54-b56c-44d7-841c-5c895e795cd8
--- orig/macros/user_macros.te
+++ mod/macros/user_macros.te
@@ -221,22 +222,22 @@
 #  Allow users to mount file systems like floppies and cdrom
 #
 mount_domain($1, $1_mount, `, fs_domain')
-role $1_r types $1_mount_t;
 r_dir_file($1_t, mnt_t)
+allow $1_mount_t device_t:lnk_file read;
 allow $1_mount_t removable_device_t:blk_file read;
 allow $1_mount_t iso9660_t:filesystem relabelfrom;
 allow $1_mount_t removable_t:filesystem { mount relabelto };
 allow $1_mount_t removable_t:dir mounton;
 ifdef(`xdm.te', `
 allow $1_mount_t xdm_t:fd use;
-allow $1_mount_t xdm_t:fifo_file write;
+allow $1_mount_t xdm_t:fifo_file { read write };
 ')
 ')
=20
 #
 # Rules used to associate a homedir as a mountpoint
 #
-allow $1_home_t $1_home_t:filesystem associate;
+allow $1_home_t self:filesystem associate;
 allow $1_file_type $1_home_t:filesystem associate;
 ')
=20
--- orig/macros/program/vmware_macros.te
+++ mod/macros/program/vmware_macros.te
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
=20
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, $1_file_type, file_type, sysadmfile, $1_file_type;
+type $1_vmware_file_t, $1_file_type, file_type, sysadmfile;
=20
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile, $1_file_type;
+type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile;
=20
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;

--CD/aTaZybdUisKIc--

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtO6+xWIrrrL0q+cRAiYeAJ9A023l96P61VlPalPkQgkOR+1PpACgsKkP
zdmGccZ8XdJwCrGDBYU3yM0=
=wqUA
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
