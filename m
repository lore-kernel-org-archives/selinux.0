Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJFC1Ii020998
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 10:12:01 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJFAW3F008085
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 15:10:33 GMT
Message-ID: <419E0D54.3000409@gentoo.org>
Date: Fri, 19 Nov 2004 17:12:20 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: gentoo diff for ntpd, gpm
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF67F1F4BF3D47F76EDB82270"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF67F1F4BF3D47F76EDB82270
Content-Type: multipart/mixed;
 boundary="------------080302050201060809030509"

This is a multi-part message in MIME format.
--------------080302050201060809030509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


gpm:
gpm_conf_t label for /etc/gpm(/.*)?

ntpd:
logrotate_exec_t has been added in a ifdef('logrotate some time ago
2 file contexts tweaked to support gentoo file locations

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------080302050201060809030509
Content-Type: text/plain;
 name="selinux-gpm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-gpm.diff"

--- /root/public_html/policy/nsa/file_contexts/program/gpm.fc	2004-06-25 23:02:43.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/gpm/gpm.fc	2004-10-31 09:32:47.000000000 +0200
@@ -2,3 +2,4 @@
 /dev/gpmctl		-s	system_u:object_r:gpmctl_t
 /dev/gpmdata		-p	system_u:object_r:gpmctl_t
 /usr/sbin/gpm		--	system_u:object_r:gpm_exec_t
+/etc/gpm(/.*)?			system_u:object_r:gpm_conf_t
--- /root/public_html/policy/nsa/domains/program/unused/gpm.te	2004-09-23 05:08:20.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/gpm/gpm.te	2004-11-09 20:43:57.000000000 +0200
@@ -15,10 +15,14 @@
 #
 daemon_domain(gpm)
 
 type gpmctl_t, file_type, sysadmfile, dev_fs;
 
 tmp_domain(gpm)
 
+#Allow to read the /etc/gpm/ conf files
+type gpm_conf_t, file_type, sysadmfile;
+r_dir_file(gpm_t, gpm_conf_t)
+
 # Use capabilities.
 allow gpm_t self:capability { setuid dac_override sys_admin sys_tty_config };
 
@@ -28,6 +32,8 @@
 allow gpm_t self:unix_dgram_socket create_socket_perms;
 allow gpm_t self:unix_stream_socket create_stream_socket_perms;
 
+allow gpm_t mouse_device_t:chr_file rw_file_perms;
+
 # Read and write ttys.
 allow gpm_t tty_device_t:chr_file rw_file_perms;
 

--------------080302050201060809030509
Content-Type: text/plain;
 name="selinux-ntp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-ntp.diff"

--- /root/public_html/policy/nsa/file_contexts/program/ntpd.fc	2004-11-19 10:48:11.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ntp/ntpd.fc	2004-11-19 10:00:22.000000000 +0200
@@ -1,11 +1,11 @@
 /var/lib/ntp(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp/data(/.*)?			system_u:object_r:ntp_drift_t
-/etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
+/etc/ntp(d)?\.conf(.sv)?	--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
 /usr/sbin/ntpdate		--	system_u:object_r:ntpdate_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
-/var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
+/var/log/ntp.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
 /var/run/ntpd\.pid		--	system_u:object_r:ntpd_var_run_t
 /etc/cron\.(daily|weekly)/ntp-simple -- system_u:object_r:ntpd_exec_t
--- /root/public_html/policy/nsa/domains/program/unused/ntpd.te	2004-11-18 10:04:33.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ntp/ntpd.te	2004-11-19 10:01:18.000000000 +0200
@@ -53,7 +53,7 @@
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;

--------------080302050201060809030509--

--------------enigF67F1F4BF3D47F76EDB82270
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBng1ZGSBEIeh4AEYRAj24AJ9QSF0/rXxlRJFoWH6n5rxAY9k6OACggvvi
r7j4bkiwYlDhu/vsvnEsQ1c=
=l2jt
-----END PGP SIGNATURE-----

--------------enigF67F1F4BF3D47F76EDB82270--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
