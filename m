Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O8f7rT024444
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 04:41:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O8f3CV026303
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:41:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 707DE61AFA
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:41:04 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10382-09 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 18:41:04 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DFB5F61AFC
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:41:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C29DDB5889
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:40:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: named policy
Date: Tue, 24 Aug 2004 18:40:58 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a8vKB4RLSne7O/h"
Message-Id: <200408241840.58207.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_a8vKB4RLSne7O/h
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch adjusts some comments in the named policy to match what's 
being done, fixes up a lot of the type labelling (including some ifdef's for 
distro specific stuff), removes rndc_conf_t references from the policy (the 
typealias statement is only there for files that are already labelled on the 
file system), and removes some access that should not be needed.

If ndc_t really needs to write to type named_zone_t then we probably have a 
mis-labelling issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_a8vKB4RLSne7O/h
Content-Type: text/x-diff;
  charset="us-ascii";
  name="named.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.diff"

--- /usr/src/se/policy/domains/program/unused/named.te	2004-08-20 22:58:57.000000000 +1000
+++ domains/program/unused/named.te	2004-08-24 18:24:36.000000000 +1000
@@ -32,10 +32,10 @@
 type named_conf_t, file_type, sysadmfile;
 typealias named_conf_t alias rndc_conf_t;
 
-# for zone files
+# for primary zone files
 type named_zone_t, file_type, sysadmfile;
 
-# named.ca files
+# for secondary zone files
 type named_cache_t, file_type, sysadmfile;
 
 # Use capabilities. Surplus capabilities may be allowed.
@@ -65,10 +65,12 @@
 #create and modify zone files
 create_dir_file(named_t, named_zone_t)
 }
+
 #read zone files
 r_dir_file(named_t, named_zone_t)
 
-r_dir_file(named_t, named_cache_t)
+#write cache for secondary zones
+rw_dir_create_file(named_t, named_cache_t)
 
 allow named_t self:unix_stream_socket create_stream_socket_perms;
 allow named_t self:unix_dgram_socket create_socket_perms;
@@ -100,7 +102,9 @@
 can_ypbind(ndc_t)
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
-allow { named_t ndc_t initrc_t } rndc_conf_t:file { getattr read };
+
+# for /etc/rndc.key
+allow { ndc_t initrc_t } named_conf_t:file { getattr read };
 
 allow ndc_t etc_t:dir r_dir_perms;
 allow ndc_t etc_t:file r_file_perms;
@@ -138,8 +142,6 @@
 allow ndc_t named_var_run_t:file getattr;
 allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
-create_dir_file(ndc_t, named_zone_t)
 dontaudit ndc_t sysadm_home_t:dir { getattr search read };
 ')
 allow ndc_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
-dontaudit named_t devpts_t:chr_file { read write };
--- /usr/src/se/policy/file_contexts/program/named.fc	2004-08-17 10:12:08.000000000 +1000
+++ file_contexts/program/named.fc	2004-08-24 18:28:51.000000000 +1000
@@ -1,28 +1,27 @@
 # named
 /var/named(/.*)?      		system_u:object_r:named_zone_t
-/var/named/named.ca     --	system_u:object_r:named_cache_t
+/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
 /etc/named\.conf	--	system_u:object_r:named_conf_t
-/etc/named\.custom	--	system_u:object_r:named_conf_t
-/etc/rndc.*		--	system_u:object_r:rndc_conf_t
+ifdef(`distro_debian', `
+/etc/bind(/.*)?			system_u:object_r:named_zone_t
+/etc/bind/named\.conf	--	system_u:object_r:named_conf_t
+/etc/bind/rndc\.key	--	system_u:object_r:named_conf_t
+/var/cache/bind(/.*)?		system_u:object_r:named_cache_t
+')
+/etc/rndc.*		--	system_u:object_r:named_conf_t
 /usr/sbin/named.*      	--	system_u:object_r:named_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
+/var/run/bind(/.*)?		system_u:object_r:named_var_run_t
 /var/run/named.*		system_u:object_r:named_var_run_t
 /usr/sbin/lwresd	--	system_u:object_r:named_exec_t
-/var/named/chroot	-d    	system_u:object_r:root_t
-/var/named/chroot/dev(/.*)?    	system_u:object_r:device_t
+ifdef(`distro_redhat', `
+/var/named/chroot(/.*)?		system_u:object_r:named_conf_t
 /var/named/chroot/dev/null   -c	system_u:object_r:null_device_t
-/var/named/chroot/dev/zero   -c	system_u:object_r:zero_device_t
 /var/named/chroot/dev/random -c	system_u:object_r:random_device_t
-/var/named/chroot/etc(/.*)?    	system_u:object_r:etc_t
 /var/named/chroot/etc/named\.conf -- system_u:object_r:named_conf_t
-/var/named/chroot/etc/named\.custom -- system_u:object_r:named_conf_t
-/var/named/chroot/etc/rndc.* -- system_u:object_r:rndc_conf_t
-/var/named/chroot/var(/.*)?	system_u:object_r:var_t
-/var/named/chroot/var/named(/.*)?   		system_u:object_r:named_zone_t
-/var/named/chroot/var/named/named.ca    system_u:object_r:named_cache_t
-/var/named/chroot/var/run(/.*)?	system_u:object_r:var_run_t
+/var/named/chroot/etc/rndc.* -- system_u:object_r:named_conf_t
 /var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
-/var/named/chroot/var/tmp	-d system_u:object_r:tmp_t
-
-
+/var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
+/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
+')

--Boundary-00=_a8vKB4RLSne7O/h--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
