Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID5Rb021437
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KID2AR019980
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:02 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i4KID2Hn019977 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:02 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID0WG026069
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:00 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KID0Co026067
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:13:00 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4K5geRb016415
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 01:42:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4K5eDB2006317
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 05:40:14 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4K5eAwi006308
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 05:40:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2F6E861C9C
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:41:12 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14452-09 for <selinux@tycho.nsa.gov>;
	Thu, 20 May 2004 15:41:10 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 348A761C62
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:41:09 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3D278B586F
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:41:23 +1000 (EST)
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file_contexts changes
Date: Thu, 20 May 2004 15:41:22 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CUErAbTiGSy6UlM"
Message-Id: <200405201541.22586.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_CUErAbTiGSy6UlM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is the diff between the 1.12 policy release and my tree for 
file_contexts.

This reverses some excessive s/lib/lib(64)?/ changes and also fixes samba and 
pppd .fc files along with a few minor changes that were already discussed on 
this list.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_CUErAbTiGSy6UlM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fc.diff"

diff -ru policy-1.12/file_contexts/program/amanda.fc selinux-policy-default-1.12/file_contexts/program/amanda.fc
--- policy-1.12/file_contexts/program/amanda.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/amanda.fc	2004-05-20 14:54:25.000000000 +1000
@@ -62,10 +62,10 @@
 /usr/sbin/amtape		--	system_u:object_r:amanda_user_exec_t
 /usr/sbin/amtoc			--	system_u:object_r:amanda_user_exec_t
 /usr/sbin/amverify		--	system_u:object_r:amanda_user_exec_t
-/var/lib(64)?/amanda			-d	system_u:object_r:amanda_var_lib_t
-/var/lib(64)?/amanda/\.amandahosts	--	system_u:object_r:amanda_config_t
-/var/lib(64)?/amanda/\.bashrc	--	system_u:object_r:amanda_shellconfig_t
-/var/lib(64)?/amanda/\.profile	--	system_u:object_r:amanda_shellconfig_t
-/var/lib(64)?/amanda/disklist	--	system_u:object_r:amanda_data_t
-/var/lib(64)?/amanda/gnutar-lists(/.*)?	system_u:object_r:amanda_gnutarlists_t
-/var/lib(64)?/amanda/index			system_u:object_r:amanda_data_t
+/var/lib/amanda			-d	system_u:object_r:amanda_var_lib_t
+/var/lib/amanda/\.amandahosts	--	system_u:object_r:amanda_config_t
+/var/lib/amanda/\.bashrc	--	system_u:object_r:amanda_shellconfig_t
+/var/lib/amanda/\.profile	--	system_u:object_r:amanda_shellconfig_t
+/var/lib/amanda/disklist	--	system_u:object_r:amanda_data_t
+/var/lib/amanda/gnutar-lists(/.*)?	system_u:object_r:amanda_gnutarlists_t
+/var/lib/amanda/index			system_u:object_r:amanda_data_t
diff -ru policy-1.12/file_contexts/program/amavis.fc selinux-policy-default-1.12/file_contexts/program/amavis.fc
--- policy-1.12/file_contexts/program/amavis.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/amavis.fc	2004-05-20 14:54:40.000000000 +1000
@@ -2,5 +2,5 @@
 /usr/sbin/amavisd.*		--	system_u:object_r:amavisd_exec_t
 /etc/amavisd.conf		--	system_u:object_r:amavisd_etc_t
 /var/log/amavisd.log 		--	system_u:object_r:amavisd_log_t
-/var/lib(64)?/amavis(/.*)?	 		system_u:object_r:amavisd_lib_t
+/var/lib/amavis(/.*)?	 		system_u:object_r:amavisd_lib_t
 /var/run/amavis(/.*)?	 		system_u:object_r:amavisd_var_run_t
diff -ru policy-1.12/file_contexts/program/apache.fc selinux-policy-default-1.12/file_contexts/program/apache.fc
--- policy-1.12/file_contexts/program/apache.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/apache.fc	2004-05-20 15:01:32.000000000 +1000
@@ -1,9 +1,10 @@
 # apache
 HOME_DIR/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_ROLE_content_t
-/var/www(/.*)?		system_u:object_r:httpd_sys_content_t
+/var/www(/.*)?			system_u:object_r:httpd_sys_content_t
 /var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
-/usr/lib(64)?/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
+/usr/lib(64)?/cgi-bin(/.*)?	system_u:object_r:httpd_sys_script_exec_t
 /var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
+/var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
 /etc/httpd		-d	system_u:object_r:httpd_config_t
 /etc/httpd/conf.*		system_u:object_r:httpd_config_t
@@ -30,4 +31,4 @@
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
 /var/run/apache-ssl(2)?.pid.* -- system_u:object_r:httpd_var_run_t
-/var/run/gcache_port	--	system_u:object_r:httpd_exec_t
+/var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
Only in selinux-policy-default-1.12/file_contexts/program: audio-entropyd.fc
diff -ru policy-1.12/file_contexts/program/canna.fc selinux-policy-default-1.12/file_contexts/program/canna.fc
--- policy-1.12/file_contexts/program/canna.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/canna.fc	2004-05-18 12:18:18.000000000 +1000
@@ -1,8 +1,12 @@
-# canna
+# canna.fc
 /usr/sbin/cannaserver	--	system_u:object_r:canna_exec_t
+/usr/sbin/jserver	--	system_u:object_r:canna_exec_t
 /usr/bin/cannaping	--	system_u:object_r:canna_exec_t
 /usr/bin/catdic		--	system_u:object_r:canna_exec_t
 /var/log/canna(/.*)?		system_u:object_r:canna_log_t
-/var/lib(64)?/canna/dic(/.*)?        system_u:object_r:canna_var_lib_t
-/tmp/\.iroha_unix	-d	system_u:object_r:canna_tmp_t
-/tmp/\.iroha_unix/.*	-s	<<none>>
+/var/log/wnn(/.*)?		system_u:object_r:canna_log_t
+/var/lib/canna/dic(/.*)?	system_u:object_r:canna_var_lib_t
+/var/lib/wnn/dic(/.*)?	system_u:object_r:canna_var_lib_t
+/var/run/\.iroha_unix	-d	system_u:object_r:canna_var_run_t
+/var/run/\.iroha_unix/.* -s	system_u:object_r:canna_var_run_t
+/var/run/wnn-unix(/.*)		system_u:object_r:canna_var_run_t
diff -ru policy-1.12/file_contexts/program/cardmgr.fc selinux-policy-default-1.12/file_contexts/program/cardmgr.fc
--- policy-1.12/file_contexts/program/cardmgr.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/cardmgr.fc	2004-05-20 14:56:28.000000000 +1000
@@ -4,4 +4,4 @@
 /var/run/stab		--	system_u:object_r:cardmgr_var_run_t
 /var/run/cardmgr.pid	--	system_u:object_r:cardmgr_var_run_t
 /etc/apm/event\.d/pcmcia --	system_u:object_r:cardmgr_exec_t
-/var/lib(64)?/pcmcia(/.*)?		system_u:object_r:cardmgr_var_run_t
+/var/lib/pcmcia(/.*)?		system_u:object_r:cardmgr_var_run_t
diff -ru policy-1.12/file_contexts/program/checkpolicy.fc selinux-policy-default-1.12/file_contexts/program/checkpolicy.fc
--- policy-1.12/file_contexts/program/checkpolicy.fc	2004-03-18 05:22:58.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/checkpolicy.fc	2004-05-20 15:02:25.000000000 +1000
@@ -1,3 +1,3 @@
 # checkpolicy
 /usr/bin/checkpolicy		--	system_u:object_r:checkpolicy_exec_t
-/etc/security/selinux/src/policy/policy.15	-- system_u:object_r:policy_config_t	
+/etc/security/selinux/src/policy/policy.* -- system_u:object_r:policy_config_t	
diff -ru policy-1.12/file_contexts/program/clamav.fc selinux-policy-default-1.12/file_contexts/program/clamav.fc
--- policy-1.12/file_contexts/program/clamav.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/clamav.fc	2004-05-20 14:57:04.000000000 +1000
@@ -3,7 +3,7 @@
 /usr/bin/freshclam	--	system_u:object_r:freshclam_exec_t
 /usr/sbin/clamav-freshclam-handledaemon	-- system_u:object_r:freshclam_exec_t
 /usr/sbin/clamd		--	system_u:object_r:clamd_exec_t
-/var/lib(64)?/clamav(/.*)?		system_u:object_r:clamav_var_lib_t
+/var/lib/clamav(/.*)?		system_u:object_r:clamav_var_lib_t
 /var/log/clam-update.log --	system_u:object_r:freshclam_log_t
 /var/log/clamav-freshclam.log.* -- system_u:object_r:freshclam_log_t
 /var/run/clamd.ctl	-s	system_u:object_r:clamd_var_run_t
diff -ru policy-1.12/file_contexts/program/cups.fc selinux-policy-default-1.12/file_contexts/program/cups.fc
--- policy-1.12/file_contexts/program/cups.fc	2004-05-12 03:06:40.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/cups.fc	2004-05-20 15:05:30.000000000 +1000
@@ -1,9 +1,11 @@
 # cups printing
 /etc/cups(/.*)?			system_u:object_r:cupsd_etc_t
+/usr/share/cups(/.*)?		system_u:object_r:cupsd_etc_t
 /etc/alchemist/namespace/printconf/local.adl system_u:object_r:cupsd_rw_etc_t
 /var/cache/alchemist/printconf.* system_u:object_r:cupsd_rw_etc_t
 /etc/cups/client\.conf	--	system_u:object_r:etc_t
 /etc/cups/cupsd.conf.* --	system_u:object_r:cupsd_rw_etc_t
+/etc/cups/lpoptions	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/printers.conf.* --	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/ppd/.*	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/certs		-d	system_u:object_r:cupsd_rw_etc_t
diff -ru policy-1.12/file_contexts/program/cyrus.fc selinux-policy-default-1.12/file_contexts/program/cyrus.fc
--- policy-1.12/file_contexts/program/cyrus.fc	2004-04-06 03:13:55.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/cyrus.fc	2004-05-20 14:57:13.000000000 +1000
@@ -1,4 +1,4 @@
 # cyrus
-/var/lib(64)?/imap(/.*)?				system_u:object_r:cyrus_var_lib_t
+/var/lib/imap(/.*)?				system_u:object_r:cyrus_var_lib_t
 /usr/lib(64)?/cyrus-imapd/(.*)?		 	--	system_u:object_r:bin_t
 /usr/lib(64)?/cyrus-imapd/cyrus-master 		--	system_u:object_r:cyrus_exec_t	
diff -ru policy-1.12/file_contexts/program/ddt-client.fc selinux-policy-default-1.12/file_contexts/program/ddt-client.fc
--- policy-1.12/file_contexts/program/ddt-client.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/ddt-client.fc	2004-05-20 14:57:23.000000000 +1000
@@ -2,5 +2,5 @@
 /usr/sbin/ddtcd		--	system_u:object_r:ddt_client_exec_t
 /var/run/ddtcd\.pid	--	system_u:object_r:ddt_client_var_run_t
 /etc/ddtcd\.conf	--	system_u:object_r:ddt_client_etc_t
-/var/lib(64)?/ddt-client(/.*)?	system_u:object_r:var_lib_ddt_client_t
+/var/lib/ddt-client(/.*)?	system_u:object_r:var_lib_ddt_client_t
 /var/log/ddtcd\.log.*	--	system_u:object_r:var_log_ddt_client_t
diff -ru policy-1.12/file_contexts/program/dhcpc.fc selinux-policy-default-1.12/file_contexts/program/dhcpc.fc
--- policy-1.12/file_contexts/program/dhcpc.fc	2004-04-08 03:28:05.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/dhcpc.fc	2004-05-20 14:57:29.000000000 +1000
@@ -4,11 +4,11 @@
 /etc/dhclient-script	--	system_u:object_r:dhcp_etc_t
 /sbin/dhcpcd		--	system_u:object_r:dhcpc_exec_t
 /sbin/dhclient.*	--	system_u:object_r:dhcpc_exec_t
-/var/lib(64)?/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
+/var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
 /var/run/dhclient.*\.pid --	system_u:object_r:dhcpc_var_run_t
 # pump
 /sbin/pump		--	system_u:object_r:dhcpc_exec_t
 ifdef(`dhcp_defined', `', `
-/var/lib(64)?/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
+/var/lib/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
 define(`dhcp_defined')
 ')
diff -ru policy-1.12/file_contexts/program/dhcpd.fc selinux-policy-default-1.12/file_contexts/program/dhcpd.fc
--- policy-1.12/file_contexts/program/dhcpd.fc	2004-04-08 03:28:05.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/dhcpd.fc	2004-05-20 14:57:35.000000000 +1000
@@ -2,9 +2,9 @@
 /etc/dhcpd.conf		--	system_u:object_r:dhcp_etc_t
 /etc/dhcp3(/.*)?		system_u:object_r:dhcp_etc_t
 /usr/sbin/dhcpd.*	--	system_u:object_r:dhcpd_exec_t
-/var/lib(64)?/dhcp(3)?/dhcpd\.leases.* -- system_u:object_r:dhcpd_state_t
+/var/lib/dhcp(3)?/dhcpd\.leases.* -- system_u:object_r:dhcpd_state_t
 /var/run/dhcpd\.pid	-d	system_u:object_r:dhcpd_var_run_t
 ifdef(`dhcp_defined', `', `
-/var/lib(64)?/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
+/var/lib/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
 define(`dhcp_defined')
 ')
diff -ru policy-1.12/file_contexts/program/dictd.fc selinux-policy-default-1.12/file_contexts/program/dictd.fc
--- policy-1.12/file_contexts/program/dictd.fc	2004-03-04 07:55:53.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/dictd.fc	2004-05-20 14:57:38.000000000 +1000
@@ -1,4 +1,4 @@
 # dictd
 /etc/dictd.conf		--	system_u:object_r:dictd_etc_t
 /usr/sbin/dictd		--	system_u:object_r:dictd_exec_t
-/var/lib(64)?/dictd(/.*)?		system_u:object_r:var_lib_dictd_t
+/var/lib/dictd(/.*)?		system_u:object_r:var_lib_dictd_t
diff -ru policy-1.12/file_contexts/program/dpkg.fc selinux-policy-default-1.12/file_contexts/program/dpkg.fc
--- policy-1.12/file_contexts/program/dpkg.fc	2004-03-06 05:49:37.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/dpkg.fc	2004-05-20 14:57:53.000000000 +1000
@@ -23,11 +23,11 @@
 /usr/share/bug/[^/]+	--	system_u:object_r:bin_t
 /var/cache/apt(/.*)?		system_u:object_r:var_cache_apt_t
 /var/cache/apt-listbugs(/.*)?	system_u:object_r:var_cache_apt_t
-/var/lib(64)?/apt(/.*)?		system_u:object_r:apt_var_lib_t
+/var/lib/apt(/.*)?		system_u:object_r:apt_var_lib_t
 /var/state/apt(/.*)?		system_u:object_r:apt_var_lib_t
-/var/lib(64)?/dpkg(/.*)?		system_u:object_r:dpkg_var_lib_t
-/var/lib(64)?/dpkg/(meth)?lock --	system_u:object_r:dpkg_lock_t
-/var/lib(64)?/kde(/.*)?		system_u:object_r:debian_menu_t
+/var/lib/dpkg(/.*)?		system_u:object_r:dpkg_var_lib_t
+/var/lib/dpkg/(meth)?lock --	system_u:object_r:dpkg_lock_t
+/var/lib/kde(/.*)?		system_u:object_r:debian_menu_t
 /var/spool/kdeapplnk(/.*)?	system_u:object_r:debian_menu_t
 /var/cache/debconf(/.*)?	system_u:object_r:debconf_cache_t
 /etc/dpkg/.+		--	system_u:object_r:dpkg_etc_t
@@ -39,7 +39,7 @@
 /usr/share/dlint/digparse --	system_u:object_r:bin_t
 /usr/share/gimp/1.2/user_install -- system_u:object_r:bin_t
 /usr/share/openoffice.org-debian-files/install-hook -- system_u:object_r:bin_t
-/var/lib(64)?/defoma(/.*)?		system_u:object_r:readable_t
+/var/lib/defoma(/.*)?		system_u:object_r:readable_t
 /usr/lib(64)?/doc-rfc/register-doc-rfc-docs -- system_u:object_r:bin_t
 /usr/share/intltool-debian/.* -- system_u:object_r:bin_t
 /usr/share/po-debconf/intltool-merge -- system_u:object_r:bin_t
diff -ru policy-1.12/file_contexts/program/games.fc selinux-policy-default-1.12/file_contexts/program/games.fc
--- policy-1.12/file_contexts/program/games.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/games.fc	2004-05-20 14:58:04.000000000 +1000
@@ -2,7 +2,7 @@
 /usr/lib(64)?/games/.* 	--	system_u:object_r:games_exec_t
 /var/games(/.*)?		system_u:object_r:games_data_t
 /usr/games(/.*)?		system_u:object_r:games_data_t
-/var/lib(64)?/games(/.*)? 	system_u:object_r:games_data_t
+/var/lib/games(/.*)? 		system_u:object_r:games_data_t
 /usr/bin/micq		--	system_u:object_r:games_exec_t
 /usr/bin/blackjack	--	system_u:object_r:games_exec_t
 /usr/bin/gataxx		--	system_u:object_r:games_exec_t
Only in selinux-policy-default-1.12/file_contexts/program: i18n_input.fc
diff -ru policy-1.12/file_contexts/program/innd.fc selinux-policy-default-1.12/file_contexts/program/innd.fc
--- policy-1.12/file_contexts/program/innd.fc	2004-04-06 03:13:55.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/innd.fc	2004-05-20 15:08:22.000000000 +1000
@@ -5,11 +5,9 @@
 /etc/news/boot		--	system_u:object_r:innd_exec_t
 /var/spool/news(/.*)?		system_u:object_r:news_spool_t
 /var/log/news(/.*)?		system_u:object_r:innd_log_t
-/var/lib(64)?/news(/.*)?		system_u:object_r:innd_var_lib_t
+/var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
 /var/run/news(/.*)?	 	system_u:object_r:innd_var_run_t
 /usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/.*	--	system_u:object_r:innd_exec_t
 /usr/bin/inews		--	system_u:object_r:innd_exec_t
 /usr/bin/rnews		--	system_u:object_r:innd_exec_t
-/usr/lib(64)?/news/bin/innd 	--	system_u:object_r:innd_exec_t
-
diff -ru policy-1.12/file_contexts/program/ipsec.fc selinux-policy-default-1.12/file_contexts/program/ipsec.fc
--- policy-1.12/file_contexts/program/ipsec.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/ipsec.fc	2004-05-19 06:15:16.000000000 +1000
@@ -17,3 +17,7 @@
 /usr/local/sbin/ipsec	--	system_u:object_r:ipsec_mgmt_exec_t
 /var/run/ipsec\.info		system_u:object_r:ipsec_var_run_t
 /var/run/pluto\.ctl		system_u:object_r:ipsec_var_run_t
+
+# Kame
+/usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
+/usr/sbin/setkey	--	system_u:object_r:ipsec_exec_t
diff -ru policy-1.12/file_contexts/program/iptables.fc selinux-policy-default-1.12/file_contexts/program/iptables.fc
--- policy-1.12/file_contexts/program/iptables.fc	2004-01-31 08:28:25.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/iptables.fc	2004-05-19 06:15:16.000000000 +1000
@@ -2,3 +2,7 @@
 /sbin/ipchains.*	--	system_u:object_r:iptables_exec_t
 /sbin/iptables.* 	--	system_u:object_r:iptables_exec_t
 /sbin/ip6tables.*	--	system_u:object_r:iptables_exec_t
+/usr/sbin/ipchains.*	--	system_u:object_r:iptables_exec_t
+/usr/sbin/iptables.* 	--	system_u:object_r:iptables_exec_t
+/usr/sbin/ip6tables.*	--	system_u:object_r:iptables_exec_t
+
diff -ru policy-1.12/file_contexts/program/ircd.fc selinux-policy-default-1.12/file_contexts/program/ircd.fc
--- policy-1.12/file_contexts/program/ircd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/ircd.fc	2004-05-20 14:58:17.000000000 +1000
@@ -2,5 +2,5 @@
 /usr/sbin/(dancer-)?ircd --	system_u:object_r:ircd_exec_t
 /etc/(dancer-)?ircd(/.*)?	system_u:object_r:ircd_etc_t
 /var/log/(dancer-)?ircd(/.*)?	system_u:object_r:ircd_log_t
-/var/lib(64)?/dancer-ircd(/.*)?	system_u:object_r:ircd_var_lib_t
+/var/lib/dancer-ircd(/.*)?	system_u:object_r:ircd_var_lib_t
 /var/run/dancer-ircd(/.*)?	system_u:object_r:ircd_var_run_t
diff -ru policy-1.12/file_contexts/program/jabberd.fc selinux-policy-default-1.12/file_contexts/program/jabberd.fc
--- policy-1.12/file_contexts/program/jabberd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/jabberd.fc	2004-05-20 14:58:39.000000000 +1000
@@ -1,3 +1,3 @@
 # jabberd
 /usr/sbin/jabberd		system_u:object_r:jabberd_exec_t
-/var/lib(64)?/jabber			system_u:object_r:jabberd_var_lib_t
+/var/lib/jabber(/.*)?		system_u:object_r:jabberd_var_lib_t
diff -ru policy-1.12/file_contexts/program/logrotate.fc selinux-policy-default-1.12/file_contexts/program/logrotate.fc
--- policy-1.12/file_contexts/program/logrotate.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/logrotate.fc	2004-05-20 14:58:49.000000000 +1000
@@ -1,8 +1,9 @@
 # logrotate
 /usr/sbin/logrotate	--	system_u:object_r:logrotate_exec_t
 /usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
+/usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
-/var/lib(64)?/logrotate.status --	system_u:object_r:logrotate_var_lib_t
-/var/lib(64)?/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
+/var/lib/logrotate.status --	system_u:object_r:logrotate_var_lib_t
+/var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
 # using a hard-coded name under /var/tmp is a bug - new version fixes it
 /var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t
diff -ru policy-1.12/file_contexts/program/lpd.fc selinux-policy-default-1.12/file_contexts/program/lpd.fc
--- policy-1.12/file_contexts/program/lpd.fc	2004-04-08 03:28:05.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/lpd.fc	2004-05-19 06:15:16.000000000 +1000
@@ -3,6 +3,7 @@
 /dev/lp.*		-c	system_u:object_r:printer_device_t
 /dev/par.*		-c	system_u:object_r:printer_device_t
 /dev/usb/lp.*		-c	system_u:object_r:printer_device_t
+/dev/usblp.*		-c	system_u:object_r:printer_device_t
 /usr/sbin/lpd		--	system_u:object_r:lpd_exec_t
 /usr/sbin/checkpc	--	system_u:object_r:checkpc_exec_t
 /var/spool/lpd(/.*)?		system_u:object_r:print_spool_t
diff -ru policy-1.12/file_contexts/program/lrrd.fc selinux-policy-default-1.12/file_contexts/program/lrrd.fc
--- policy-1.12/file_contexts/program/lrrd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/lrrd.fc	2004-05-20 14:58:55.000000000 +1000
@@ -5,6 +5,6 @@
 /usr/share/lrrd/plugins/.*	--	system_u:object_r:lrrd_exec_t
 /var/run/lrrd(/.*)?			system_u:object_r:lrrd_var_run_t
 /var/log/lrrd.*			--	system_u:object_r:lrrd_log_t
-/var/lib(64)?/lrrd(/.*)?			system_u:object_r:lrrd_var_lib_t
+/var/lib/lrrd(/.*)?			system_u:object_r:lrrd_var_lib_t
 /var/www/lrrd(.*)?			system_u:object_r:lrrd_var_lib_t
 /etc/lrrd(/.*)?				system_u:object_r:lrrd_etc_t
diff -ru policy-1.12/file_contexts/program/mailman.fc selinux-policy-default-1.12/file_contexts/program/mailman.fc
--- policy-1.12/file_contexts/program/mailman.fc	2004-03-06 05:49:37.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/mailman.fc	2004-05-20 15:10:10.000000000 +1000
@@ -1,11 +1,11 @@
 # mailman list server
-/usr/lib(64)?/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
+/usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
 /var/log/mailman(/.*)?		   system_u:object_r:mailman_log_t
-/usr/lib(64)?/mailman/cron/qrunner -- system_u:object_r:mailman_queue_exec_t
-/var/lib(64)?/mailman(/.*)?	   system_u:object_r:mailman_data_t
-/var/lib(64)?/mailman/cron	-- system_u:object_r:bin_t
-/usr/lib(64)?/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
-/var/lib(64)?/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
+/usr/lib/mailman/cron/qrunner -- system_u:object_r:mailman_queue_exec_t
+/var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
+/var/lib/mailman/cron	-- system_u:object_r:bin_t
+/usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
+/var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
 /etc/cron\.daily/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /etc/cron\.monthly/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
diff -ru policy-1.12/file_contexts/program/mrtg.fc selinux-policy-default-1.12/file_contexts/program/mrtg.fc
--- policy-1.12/file_contexts/program/mrtg.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/mrtg.fc	2004-05-20 14:59:08.000000000 +1000
@@ -1,6 +1,6 @@
 # mrtg - traffic grapher
 /usr/bin/mrtg		--	system_u:object_r:mrtg_exec_t
-/var/lib(64)?/mrtg(/.*)?		system_u:object_r:var_lib_mrtg_t
+/var/lib/mrtg(/.*)?		system_u:object_r:var_lib_mrtg_t
 /var/lock/mrtg(/.*)?		system_u:object_r:mrtg_lock_t
 /etc/mrtg.*			system_u:object_r:mrtg_etc_t
 /etc/mrtg/mrtg.ok	--	system_u:object_r:mrtg_lock_t
diff -ru policy-1.12/file_contexts/program/mysqld.fc selinux-policy-default-1.12/file_contexts/program/mysqld.fc
--- policy-1.12/file_contexts/program/mysqld.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/mysqld.fc	2004-05-20 14:59:12.000000000 +1000
@@ -2,6 +2,6 @@
 /usr/sbin/mysqld	--	system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
-/var/lib(64)?/mysql(/.*)?		system_u:object_r:mysqld_db_t
+/var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
 /etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
 /etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t
diff -ru policy-1.12/file_contexts/program/nessusd.fc selinux-policy-default-1.12/file_contexts/program/nessusd.fc
--- policy-1.12/file_contexts/program/nessusd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/nessusd.fc	2004-05-20 14:59:17.000000000 +1000
@@ -1,6 +1,6 @@
 # nessusd - network scanning server
 /usr/sbin/nessusd	--	system_u:object_r:nessusd_exec_t
 /usr/lib(64)?/nessus/plugins/.* --	system_u:object_r:nessusd_exec_t
-/var/lib(64)?/nessus(/.*)?	 	system_u:object_r:nessusd_db_t
+/var/lib/nessus(/.*)?	 	system_u:object_r:nessusd_db_t
 /var/log/nessus(/.*)?		system_u:object_r:nessusd_log_t
 /etc/nessus/nessusd\.conf --	system_u:object_r:nessusd_etc_t
diff -ru policy-1.12/file_contexts/program/nsd.fc selinux-policy-default-1.12/file_contexts/program/nsd.fc
--- policy-1.12/file_contexts/program/nsd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/nsd.fc	2004-05-20 14:59:23.000000000 +1000
@@ -3,7 +3,7 @@
 /etc/nsd/primary(/.*)?		system_u:object_r:nsd_zone_t
 /etc/nsd/secondary(/.*)?	system_u:object_r:nsd_zone_t
 /etc/nsd/nsd.db		--	system_u:object_r:nsd_zone_t
-/var/lib(64)?/nsd(/.*)?		system_u:object_r:nsd_zone_t
+/var/lib/nsd(/.*)?		system_u:object_r:nsd_zone_t
 /usr/sbin/nsd      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsdc      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsd-notify	--	system_u:object_r:nsd_exec_t
diff -ru policy-1.12/file_contexts/program/ntpd.fc selinux-policy-default-1.12/file_contexts/program/ntpd.fc
--- policy-1.12/file_contexts/program/ntpd.fc	2004-03-18 05:22:58.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/ntpd.fc	2004-05-20 15:11:05.000000000 +1000
@@ -1,4 +1,4 @@
-/var/lib(64)?/ntp(/.*)?			system_u:object_r:ntp_drift_t
+/var/lib/ntp(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp/data(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp\.conf			--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
@@ -9,3 +9,4 @@
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
 /var/run/ntpd.pid		--	system_u:object_r:ntpd_var_run_t
 /etc/cron\.(daily|weekly)/ntp-simple -- system_u:object_r:ntpd_exec_t
+/etc/cron\.(daily|weekly)/ntp-server -- system_u:object_r:ntpd_exec_t
diff -ru policy-1.12/file_contexts/program/oav-update.fc selinux-policy-default-1.12/file_contexts/program/oav-update.fc
--- policy-1.12/file_contexts/program/oav-update.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/oav-update.fc	2004-05-20 14:59:36.000000000 +1000
@@ -1,4 +1,4 @@
-/var/lib(64)?/oav-virussignatures -- system_u:object_r:oav_update_var_lib_t
-/var/lib(64)?/oav-update(/.*)?	system_u:object_r:oav_update_var_lib_t
+/var/lib/oav-virussignatures -- system_u:object_r:oav_update_var_lib_t
+/var/lib/oav-update(/.*)?	system_u:object_r:oav_update_var_lib_t
 /usr/sbin/oav-update	--	system_u:object_r:oav_update_exec_t
 /etc/oav-update(/.*)?		system_u:object_r:oav_update_etc_t
diff -ru policy-1.12/file_contexts/program/openca-ca.fc selinux-policy-default-1.12/file_contexts/program/openca-ca.fc
--- policy-1.12/file_contexts/program/openca-ca.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/openca-ca.fc	2004-05-20 14:59:41.000000000 +1000
@@ -1,8 +1,8 @@
 /etc/openca(/.*)?		system_u:object_r:openca_etc_t
 /etc/openca/rbac(/.*)?		system_u:object_r:openca_etc_writeable_t
 /etc/openca/*.\.in(/.*)?	system_u:object_r:openca_etc_in_t
-/var/lib(64)?/openca(/.*)?		system_u:object_r:openca_var_lib_t
-/var/lib(64)?/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
+/var/lib/openca(/.*)?		system_u:object_r:openca_var_lib_t
+/var/lib/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
 /usr/share/openca(/.*)?		system_u:object_r:openca_usr_share_t
 /usr/share/openca/htdocs(/.*)?	system_u:object_r:httpd_sys_content_t
 /usr/share/openca/cgi-bin/ca(/.*)?	system_u:object_r:openca_ca_exec_t
diff -ru policy-1.12/file_contexts/program/openca-common.fc selinux-policy-default-1.12/file_contexts/program/openca-common.fc
--- policy-1.12/file_contexts/program/openca-common.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/openca-common.fc	2004-05-20 14:59:52.000000000 +1000
@@ -1,7 +1,7 @@
 /etc/openca(/.*)?			system_u:object_r:openca_etc_t
 /etc/openca/rbac(/.*)?			system_u:object_r:openca_etc_writeable_t
 /etc/openca/*.\.in(/.*)?		system_u:object_r:openca_etc_in_t
-/var/lib(64)?/openca(/.*)?			system_u:object_r:openca_var_lib_t
-/var/lib(64)?/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
+/var/lib/openca(/.*)?			system_u:object_r:openca_var_lib_t
+/var/lib/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
 /usr/share/openca(/.*)?			system_u:object_r:openca_usr_share_t
 /usr/share/openca/htdocs(/.*)?		system_u:object_r:httpd_sys_content_t
diff -ru policy-1.12/file_contexts/program/postgresql.fc selinux-policy-default-1.12/file_contexts/program/postgresql.fc
--- policy-1.12/file_contexts/program/postgresql.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/postgresql.fc	2004-05-20 14:59:59.000000000 +1000
@@ -1,6 +1,6 @@
 # postgresql - ldap server
 /usr/lib(64)?/postgresql/bin/.* --	system_u:object_r:postgresql_exec_t
-/var/lib(64)?/postgres(/.*)?		system_u:object_r:postgresql_db_t
+/var/lib/postgres(/.*)?		system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t
 /etc/postgresql(/.*)?		system_u:object_r:postgresql_etc_t
 /var/log/postgres\.log.* --	system_u:object_r:postgresql_log_t
diff -ru policy-1.12/file_contexts/program/pppd.fc selinux-policy-default-1.12/file_contexts/program/pppd.fc
--- policy-1.12/file_contexts/program/pppd.fc	2004-05-12 03:06:41.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/pppd.fc	2004-05-20 15:13:52.000000000 +1000
@@ -5,7 +5,8 @@
 /dev/pppox.*		-c	system_u:object_r:ppp_device_t
 /dev/ippp.*		-c	system_u:object_r:ppp_device_t
 /var/run/pppd\.tdb	--	system_u:object_r:pppd_var_run_t
-/etc/ppp(/.*)?			system_u:object_r:pppd_etc_t
+/etc/ppp		-d	system_u:object_r:pppd_etc_t
+/etc/ppp/.*		--	system_u:object_r:pppd_etc_rw_t
 /etc/ppp/.*secrets	--	system_u:object_r:pppd_secret_t
 /var/run/(i)?ppp.*pid	--	system_u:object_r:pppd_var_run_t
 /var/log/ppp-connect-errors.* -- system_u:object_r:pppd_log_t
diff -ru policy-1.12/file_contexts/program/quota.fc selinux-policy-default-1.12/file_contexts/program/quota.fc
--- policy-1.12/file_contexts/program/quota.fc	2004-03-10 02:19:51.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/quota.fc	2004-05-20 15:00:03.000000000 +1000
@@ -1,5 +1,5 @@
 # quota system
-/var/lib(64)?/quota(/.*)?		system_u:object_r:quota_flag_t
+/var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)	--	system_u:object_r:quota_exec_t
 HOME_ROOT/a?quota.(user|group) -- system_u:object_r:quota_db_t
 /var/a?quota.(user|group) -- system_u:object_r:quota_db_t
diff -ru policy-1.12/file_contexts/program/restorecon.fc selinux-policy-default-1.12/file_contexts/program/restorecon.fc
--- policy-1.12/file_contexts/program/restorecon.fc	2004-03-09 07:40:15.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/restorecon.fc	2004-05-19 06:15:16.000000000 +1000
@@ -1,2 +1,3 @@
 # restorecon
 /usr/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
+/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
diff -ru policy-1.12/file_contexts/program/rpm.fc selinux-policy-default-1.12/file_contexts/program/rpm.fc
--- policy-1.12/file_contexts/program/rpm.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/rpm.fc	2004-05-20 15:00:10.000000000 +1000
@@ -1,6 +1,6 @@
 # rpm
-/var/lib(64)?/rpm(/.*)?		system_u:object_r:rpm_var_lib_t
-/var/lib(64)?/alternatives(/.*)?	system_u:object_r:rpm_var_lib_t
+/var/lib/rpm(/.*)?		system_u:object_r:rpm_var_lib_t
+/var/lib/alternatives(/.*)?	system_u:object_r:rpm_var_lib_t
 /bin/rpm 		--	system_u:object_r:rpm_exec_t
 /usr/bin/yum 		--	system_u:object_r:rpm_exec_t
 /usr/sbin/up2date	--	system_u:object_r:rpm_exec_t
@@ -52,3 +52,8 @@
 /usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
 /usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+# SuSE
+/usr/bin/online_update		--	system_u:object_r:rpm_exec_t
+/sbin/yast2			--	system_u:object_r:rpm_exec_t
+/var/lib/YaST2(/.*)?			system_u:object_r:rpm_var_lib_t
+
diff -ru policy-1.12/file_contexts/program/samba.fc selinux-policy-default-1.12/file_contexts/program/samba.fc
--- policy-1.12/file_contexts/program/samba.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/samba.fc	2004-05-20 15:16:56.000000000 +1000
@@ -4,7 +4,7 @@
 /etc/samba(/.*)?		system_u:object_r:samba_etc_t
 /var/log/samba(/.*)?		system_u:object_r:samba_log_t
 /var/cache/samba(/.*)?		system_u:object_r:samba_var_t
-/var/lib(64)?/samba(/.*)?		system_u:object_r:samba_var_t
+/var/lib/samba(/.*)?		system_u:object_r:samba_var_t
 /etc/samba/secrets\.tdb	--	system_u:object_r:samba_secrets_t
 /etc/samba/MACHINE\.SID	--	system_u:object_r:samba_secrets_t
 # samba really wants write access to smbpasswd
@@ -18,4 +18,4 @@
 /var/run/samba/unexpected\.tdb -- system_u:object_r:nmbd_var_run_t
 /var/run/samba/smbd\.pid --	system_u:object_r:smbd_var_run_t
 /var/run/samba/nmbd\.pid --	system_u:object_r:nmbd_var_run_t
-/var/spool/samba(/.*)?  --	system_u:object_r:samba_spool_t
+/var/spool/samba(/.*)?		system_u:object_r:samba_var_t
diff -ru policy-1.12/file_contexts/program/slapd.fc selinux-policy-default-1.12/file_contexts/program/slapd.fc
--- policy-1.12/file_contexts/program/slapd.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/slapd.fc	2004-05-20 15:00:19.000000000 +1000
@@ -1,7 +1,7 @@
 # slapd - ldap server
 /usr/sbin/slapd		--	system_u:object_r:slapd_exec_t
-/var/lib(64)?/ldap(/.*)?		system_u:object_r:slapd_db_t
-/var/lib(64)?/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
+/var/lib/ldap(/.*)?		system_u:object_r:slapd_db_t
+/var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd\.args	--	system_u:object_r:slapd_var_run_t
 /etc/ldap/slapd\.conf	--	system_u:object_r:slapd_etc_t
 /usr/lib(64)?/ldap/back.*so.* --	system_u:object_r:shlib_t
diff -ru policy-1.12/file_contexts/program/slocate.fc selinux-policy-default-1.12/file_contexts/program/slocate.fc
--- policy-1.12/file_contexts/program/slocate.fc	2004-03-04 07:55:54.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/slocate.fc	2004-05-20 15:00:22.000000000 +1000
@@ -1,4 +1,4 @@
 # locate - file locater
 /usr/bin/slocate		--	system_u:object_r:locate_exec_t
-/var/lib(64)?/slocate(/.*)?			system_u:object_r:var_lib_locate_t
+/var/lib/slocate(/.*)?			system_u:object_r:var_lib_locate_t
 /etc/updatedb.conf		--	system_u:object_r:locate_etc_t
diff -ru policy-1.12/file_contexts/program/snmpd.fc selinux-policy-default-1.12/file_contexts/program/snmpd.fc
--- policy-1.12/file_contexts/program/snmpd.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/snmpd.fc	2004-05-20 15:00:24.000000000 +1000
@@ -1,6 +1,6 @@
 # snmpd
 /usr/sbin/snmp(trap)?d	--	system_u:object_r:snmpd_exec_t
-/var/lib(64)?/snmp(/.*)?		system_u:object_r:snmpd_var_lib_t
+/var/lib/snmp(/.*)?		system_u:object_r:snmpd_var_lib_t
 /etc/snmp/snmp(trap)?d\.conf -- system_u:object_r:snmpd_etc_t
 /usr/share/snmp/mibs/\.index -- system_u:object_r:snmpd_var_lib_t
 /var/run/snmpd\.pid	--	system_u:object_r:snmpd_var_run_t
diff -ru policy-1.12/file_contexts/program/sudo.fc selinux-policy-default-1.12/file_contexts/program/sudo.fc
--- policy-1.12/file_contexts/program/sudo.fc	2004-03-24 08:06:39.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/sudo.fc	2004-05-20 15:20:06.000000000 +1000
@@ -1,3 +1,2 @@
 # sudo
 /usr/bin/sudo		--	system_u:object_r:sudo_exec_t
-/usr/sbin/sesh		--	system_u:object_r:shell_exec_t
diff -ru policy-1.12/file_contexts/program/tinydns.fc selinux-policy-default-1.12/file_contexts/program/tinydns.fc
--- policy-1.12/file_contexts/program/tinydns.fc	2004-04-06 03:13:55.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/tinydns.fc	2004-05-20 15:00:33.000000000 +1000
@@ -3,4 +3,4 @@
 /etc/tinydns/root/data* --      system_u:object_r:tinydns_zone_t
 /usr/bin/tinydns*	--	system_u:object_r:tinydns_exec_t
 /var/log/dns/tinydns(/.*)	system_u:object_r:tinydns_log_t
-#/var/lib(64)?/svscan(/.*)		system_u:object_r:tinydns_svscan_t
+#/var/lib/svscan(/.*)		system_u:object_r:tinydns_svscan_t
diff -ru policy-1.12/file_contexts/program/xdm.fc selinux-policy-default-1.12/file_contexts/program/xdm.fc
--- policy-1.12/file_contexts/program/xdm.fc	2004-03-18 05:22:58.000000000 +1100
+++ selinux-policy-default-1.12/file_contexts/program/xdm.fc	2004-05-20 00:12:54.000000000 +1000
@@ -1,6 +1,7 @@
 # X Display Manager
 /usr/bin/[xgkw]dm	--	system_u:object_r:xdm_exec_t
 /usr/X11R6/bin/[xgkw]dm	--	system_u:object_r:xdm_exec_t
+/opt/kde3/bin/kdm	--	system_u:object_r:xdm_exec_t
 /usr/bin/gpe-dm		--	system_u:object_r:xdm_exec_t
 /var/[xgk]dm(/.*)?		system_u:object_r:xserver_log_t
 /usr/var/[xgkw]dm(/.*)?		system_u:object_r:xserver_log_t
@@ -11,14 +12,13 @@
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
-/var/lib(64)?/kdm(/.*)?		system_u:object_r:xdm_var_lib_t
-/usr/lib(64)?/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t
+/var/lib/[kw]dm(/.*)?		system_u:object_r:xdm_var_lib_t
+/usr/lib/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t
 
 #
 # Additional Xsession scripts
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
diff -ru policy-1.12/file_contexts/program/xserver.fc selinux-policy-default-1.12/file_contexts/program/xserver.fc
--- policy-1.12/file_contexts/program/xserver.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/program/xserver.fc	2004-05-20 15:00:57.000000000 +1000
@@ -6,9 +6,9 @@
 /usr/X11R6/bin/XFree86	--	system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/Xorg	--	system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/Xipaq	--	system_u:object_r:xserver_exec_t
-/var/lib(64)?/xkb(/.*)?		system_u:object_r:var_lib_xkb_t
-/usr/X11R6/lib(64)?/X11/xkb	-d	system_u:object_r:var_lib_xkb_t
-/usr/X11R6/lib(64)?/X11/xkb/.* --	system_u:object_r:var_lib_xkb_t
+/var/lib/xkb(/.*)?		system_u:object_r:var_lib_xkb_t
+/usr/X11R6/lib/X11/xkb	-d	system_u:object_r:var_lib_xkb_t
+/usr/X11R6/lib/X11/xkb/.* --	system_u:object_r:var_lib_xkb_t
 /usr/X11R6/lib(64)?/X11/xkb/xkbcomp -- system_u:object_r:bin_t
 /var/log/XFree86.*	--	system_u:object_r:xserver_log_t
 /var/log/Xorg.*		--	system_u:object_r:xserver_log_t
diff -ru policy-1.12/file_contexts/types.fc selinux-policy-default-1.12/file_contexts/types.fc
--- policy-1.12/file_contexts/types.fc	2004-05-05 05:07:48.000000000 +1000
+++ selinux-policy-default-1.12/file_contexts/types.fc	2004-05-20 15:34:34.000000000 +1000
@@ -58,6 +58,7 @@
 #
 # A common mount point
 /mnt(/.*)?		-d	system_u:object_r:mnt_t
+/media(/.*)?		-d	system_u:object_r:mnt_t
 
 #
 # /var
@@ -66,15 +67,15 @@
 /var/catman(/.*)?		system_u:object_r:catman_t
 /var/cache/man(/.*)?		system_u:object_r:catman_t
 /var/yp(/.*)?			system_u:object_r:var_yp_t
-/var/lib(64)?(/.*)?			system_u:object_r:var_lib_t
-/var/lib(64)?/nfs(/.*)?		system_u:object_r:var_lib_nfs_t
-/var/lib(64)?/texmf(/.*)?		system_u:object_r:tetex_data_t
+/var/lib(/.*)?			system_u:object_r:var_lib_t
+/var/lib/nfs(/.*)?		system_u:object_r:var_lib_nfs_t
+/var/lib/texmf(/.*)?		system_u:object_r:tetex_data_t
 /var/cache/fonts(/.*)?		system_u:object_r:tetex_data_t
 /var/lock(/.*)?			system_u:object_r:var_lock_t
 /var/tmp		-d	system_u:object_r:tmp_t
 /var/tmp/.*			<<none>>
 /var/tmp/vi\.recover	-d	system_u:object_r:tmp_t
-/var/lib(64)?/nfs/rpc_pipes(/*)?	<<none>>
+/var/lib/nfs/rpc_pipes(/*)?	<<none>>
 /var/mailman/bin(/.*)?		system_u:object_r:bin_t
 /var/mailman/pythonlib(/.*)?/.*\.so(\..*)?	-- system_u:object_r:shlib_t
 
@@ -98,6 +99,7 @@
 /bin/sash		--	system_u:object_r:shell_exec_t
 /bin/d?ash		--	system_u:object_r:shell_exec_t
 /bin/zsh.*		--	system_u:object_r:shell_exec_t
+/usr/sbin/sesh		--	system_u:object_r:shell_exec_t
 /bin/ls			--	system_u:object_r:ls_exec_t
 
 #
@@ -108,10 +110,10 @@
 /boot/kernel\.h.*	--	system_u:object_r:boot_runtime_t
 
 #
-# /u?dev
+# /dev
 #
 /u?dev(/.*)?			system_u:object_r:device_t
-/u?dev/pts(/.*)?			<<none>>
+/u?dev/pts(/.*)?		<<none>>
 /u?dev/cpu/.*		-c	system_u:object_r:cpu_device_t
 /u?dev/MAKEDEV		--	system_u:object_r:sbin_t
 /u?dev/null		-c	system_u:object_r:null_device_t
@@ -122,7 +124,7 @@
 /u?dev/nvram		-c	system_u:object_r:memory_device_t
 /u?dev/random		-c	system_u:object_r:random_device_t
 /u?dev/urandom		-c	system_u:object_r:urandom_device_t
-/u?dev/.*tty[^/]*		-c	system_u:object_r:tty_device_t
+/u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
 /u?dev/cu.*		-c	system_u:object_r:tty_device_t
 /u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
 /u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
@@ -133,11 +135,11 @@
 /u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/ida/[^/]*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/dasd[^/]*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/flash[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/ataraid/.*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
@@ -146,11 +148,11 @@
 /u?dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
 /u?dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
-/u?dev/usb/rio500		-c	system_u:object_r:removable_device_t
+/u?dev/usb/rio500	-c	system_u:object_r:removable_device_t
 /u?dev/fd[^/]+		-b	system_u:object_r:removable_device_t
 # I think a parallel port disk is a removable device...
 /u?dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
-/u?dev/p[fg][0-3]		-b	system_u:object_r:removable_device_t
+/u?dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
 /u?dev/aztcd		-b	system_u:object_r:removable_device_t
 /u?dev/bpcd		-b	system_u:object_r:removable_device_t
 /u?dev/gscd		-b	system_u:object_r:removable_device_t
@@ -169,18 +171,18 @@
 /u?dev/psaux		-c	system_u:object_r:mouse_device_t
 /u?dev/atibm		-c	system_u:object_r:mouse_device_t
 /u?dev/logibm		-c	system_u:object_r:mouse_device_t
-/u?dev/.*mouse.*		-c	system_u:object_r:mouse_device_t
+/u?dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
 /u?dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
 /u?dev/input/event.*	-c	system_u:object_r:event_device_t
-/u?dev/input/mice		-c	system_u:object_r:mouse_device_t
-/u?dev/input/js.*		-c	system_u:object_r:mouse_device_t
+/u?dev/input/mice	-c	system_u:object_r:mouse_device_t
+/u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
 /u?dev/ptmx		-c	system_u:object_r:ptmx_t
-/u?dev/sequencer			system_u:object_r:misc_device_t
+/u?dev/sequencer	-c	system_u:object_r:misc_device_t
 /u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
 /u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
 /u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
 /u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
-/u?dev/winradio.		-c	system_u:object_r:v4l_device_t
+/u?dev/winradio.	-c	system_u:object_r:v4l_device_t
 /u?dev/vttuner		-c	system_u:object_r:v4l_device_t
 /u?dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
 /u?dev/mixer.*		-c	system_u:object_r:sound_device_t
@@ -190,30 +192,34 @@
 /u?dev/smpte.*		-c	system_u:object_r:sound_device_t
 /u?dev/sndstat		-c	system_u:object_r:sound_device_t
 /u?dev/beep		-c	system_u:object_r:sound_device_t
-/u?dev/patmgr[01]		-c	system_u:object_r:sound_device_t
+/u?dev/patmgr[01]	-c	system_u:object_r:sound_device_t
 /u?dev/mpu401.*		-c	system_u:object_r:sound_device_t
-/u?dev/srnd[0-7]		-c	system_u:object_r:sound_device_t
+/u?dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
 /u?dev/aload.*		-c	system_u:object_r:sound_device_t
 /u?dev/amidi.*		-c	system_u:object_r:sound_device_t
 /u?dev/amixer.*		-c	system_u:object_r:sound_device_t
-/u?dev/snd(/.*)?		-c	system_u:object_r:sound_device_t
+/u?dev/snd/.*		-c	system_u:object_r:sound_device_t
 /u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
 /u?dev/(n?raw)?qft[0-3]	-c	system_u:object_r:tape_device_t
 /u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
 /u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
 /u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
 /u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
-/u?dev/n?pt[0-9]+		-c	system_u:object_r:tape_device_t
+/u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
 /u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
-/u?dev/mmetfgrab		-c	system_u:object_r:scanner_device_t
+/u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
+/u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
 
 /proc(/.*)?			<<none>>
 /sys(/.*)?			<<none>>
 /selinux(/.*)?			<<none>>
 /opt(/.*)?			system_u:object_r:usr_t
+/opt/[^/]*/bin(/.*)?		system_u:object_r:bin_t
+/opt/[^/]*/lib(/.*)?		system_u:object_r:lib_t
+/opt/[^/]*/man(/.*)?		system_u:object_r:man_t
 
 #
 # /etc
@@ -231,6 +237,8 @@
 /etc/issue		--	system_u:object_r:etc_runtime_t
 /etc/issue\.net		--	system_u:object_r:etc_runtime_t
 /etc/sysconfig/hwconf	--	system_u:object_r:etc_runtime_t
+/etc/sysconfig/iptables.save -- system_u:object_r:etc_runtime_t
+/etc/sysconfig/firstboot --	system_u:object_r:etc_runtime_t
 /etc/asound\.state	--	system_u:object_r:etc_runtime_t
 /etc/ptal/ptal-printd-like -- 	system_u:object_r:etc_runtime_t
 /etc/ld\.so\.cache	--	system_u:object_r:ld_so_cache_t
@@ -277,6 +285,7 @@
 /usr/man(/.*)?			system_u:object_r:man_t
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
+/usr/share/texmf/teTeX/bin(/.*)?	system_u:object_r:bin_t
 
 #
 # /usr/bin
@@ -371,8 +380,9 @@
 #
 # Fonts dir
 #
-/usr/X11R6/lib(64)?/X11/fonts(/.*)?		system_u:object_r:fonts_t
+/usr/X11R6/lib/X11/fonts(/.*)?		system_u:object_r:fonts_t
 /usr/share/fonts(/.*)?			system_u:object_r:fonts_t
+/usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
 
 #
 # /var/run
@@ -426,7 +436,7 @@
 #
 /usr/share/zoneinfo(/.*)?	system_u:object_r:locale_t
 /usr/share/locale(/.*)?		system_u:object_r:locale_t
-/usr/lib(64)?/locale(/.*)?	system_u:object_r:locale_t
+/usr/lib/locale(/.*)?		system_u:object_r:locale_t
 /etc/localtime		--	system_u:object_r:locale_t
 /etc/localtime		-l	system_u:object_r:etc_t
 

--Boundary-00=_CUErAbTiGSy6UlM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
