Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02C43Ii012712
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 07:04:04 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02C29Hg000756
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 12:02:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 37E7D61B6C
	for <selinux@tycho.nsa.gov>; Sun,  2 Jan 2005 23:03:52 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08879-10 for <selinux@tycho.nsa.gov>;
	Sun, 2 Jan 2005 23:03:51 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9AECE61B6A
	for <selinux@tycho.nsa.gov>; Sun,  2 Jan 2005 23:03:51 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 51298A4
	for <selinux@tycho.nsa.gov>; Sun,  2 Jan 2005 23:03:50 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Sun, 2 Jan 2005 23:03:47 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lM+1BydU6+Tcpi/"
Message-Id: <200501022303.49225.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_lM+1BydU6+Tcpi/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

network_macros.diff makes a cosmetic change to the network macros.

quota.diff enables converting quota files from old format to new format and 
adds access to raw disk devices which seems to be needed by the newer 
versions of the quota utilities.

screen.diff allows screen access to proc files so that it can display the 
uptime and other trivial stuff.  Screen can work without this, but it's handy 
to have it and proc_t is hardly restricted anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_lM+1BydU6+Tcpi/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="quota.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="quota.diff"

--- /usr/src/se/policy/file_contexts/program/quota.fc	2004-11-20 01:18:22.000000000 +1100
+++ file_contexts/program/quota.fc	2005-01-02 22:52:18.000000000 +1100
@@ -1,5 +1,10 @@
 # quota system
 /var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)	--	system_u:object_r:quota_exec_t
+ifdef(`distro_redhat', `
+/usr/sbin/convertquota	--	system_u:object_r:quota_exec_t
+', `
+/sbin/convertquota	--	system_u:object_r:quota_exec_t
+')
 HOME_ROOT/a?quota\.(user|group) -- system_u:object_r:quota_db_t
 /var/a?quota\.(user|group) -- system_u:object_r:quota_db_t
--- /usr/src/se/policy/domains/program/unused/quota.te	2004-11-13 03:56:03.000000000 +1100
+++ domains/program/unused/quota.te	2005-01-02 22:53:20.000000000 +1100
@@ -10,7 +10,7 @@
 #
 # needs auth attribute because it has read access to shadow_t because checkquota
 # is buggy
-daemon_base_domain(quota, `, auth')
+daemon_base_domain(quota, `, auth, fs_domain')
 
 # so the administrator can run quotacheck
 domain_auto_trans(sysadm_t, quota_exec_t, quota_t)
@@ -39,6 +39,8 @@
 allow quota_t file_type:lnk_file { read getattr };
 allow quota_t device_type:{ chr_file blk_file } getattr;
 
+allow quota_t fixed_disk_device_t:blk_file { getattr read };
+
 # for /quota.*
 allow quota_t quota_db_t:file { read write };
 dontaudit unpriv_userdomain quota_db_t:file getattr;

--Boundary-00=_lM+1BydU6+Tcpi/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="network_macros.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="network_macros.diff"

--- /usr/src/se/policy/macros/network_macros.te	2004-11-25 06:44:37.000000000 +1100
+++ macros/network_macros.te	2004-12-25 12:26:30.000000000 +1100
@@ -79,11 +79,12 @@
 # Permissions for accessing the network.
 # See types/network.te for the network types.
 # See net_contexts for security contexts for network entities.
+# Combination of can_network_client_tcp() and can_network_server_tcp()
 #
 define(`can_network_tcp',`
 
 can_network_server_tcp($1, `$2')
-can_network_client_tcp($1, `$2')
+allow $1 self:tcp_socket { connect };
 
 ')
 

--Boundary-00=_lM+1BydU6+Tcpi/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="screen.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="screen.diff"

--- /usr/src/se/policy/macros/program/screen_macros.te	2004-12-13 09:55:31.000000000 +1100
+++ macros/program/screen_macros.te	2004-12-31 10:34:39.000000000 +1100
@@ -87,6 +87,7 @@
 
 # get stats
 allow $1_screen_t proc_t:dir search;
+allow $1_screen_t proc_t:file { getattr read };
 allow $1_screen_t proc_t:lnk_file read;
 allow $1_screen_t etc_t:{ file lnk_file } { read getattr };
 allow $1_screen_t self:dir { search read };

--Boundary-00=_lM+1BydU6+Tcpi/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
