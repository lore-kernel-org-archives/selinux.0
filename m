Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02F23Ii013154
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 10:02:04 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02F0AHg002602
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 15:00:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5DC0B61B6D
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 02:02:04 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13542-08 for <selinux@tycho.nsa.gov>;
	Mon, 3 Jan 2005 02:02:03 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 92EC361B6A
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 02:02:03 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id F15E3A4
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 02:02:01 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policy
Date: Mon, 3 Jan 2005 02:01:59 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pzA2BW+0vXZfF1Z"
Message-Id: <200501030202.01321.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_pzA2BW+0vXZfF1Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

udev.diff just combines a couple of lines into a single line.

diff changes the Makefile to have it not run setfiles -q needlessly (good for 
when a script runs "make install" a few hundred times).

Adds a couple of lines to assert.te.

Adds hide_broken_symptoms to ldconfig.te (there is no good cause for 
ldconfig_t to access a TCP socket).

Changes ftpd.te to allow access to home_root_t for the case of NFS root.  This 
means that if you have home directories individually mounted on /home/user 
then things will still work (and there's no harm in granting such access).

Added some extra access that seems to be needed by the latest version of howl.

Removed the memory_device_t commend from xdm.te - we should not need to 
re-enable that.

Removed redundant entries from types.fc relating to the old locations 
before /etc/selinux was used.

Add support for the Debian locations for pmap_dump and pmap_set.  I wonder 
whether those files will have to change locations in other distributions for 
the case of /usr on NFS...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_pzA2BW+0vXZfF1Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- udev.te	2004-12-03 19:49:24.000000000 +1100
+++ udev.te.new	2005-01-02 23:23:30.000000000 +1100
@@ -44,7 +44,7 @@
 # for arping used for static IP addresses on PCMCIA ethernet
 domain_auto_trans(udev_t, netutils_exec_t, netutils_t)
 ')
-allow udev_t etc_t:file { getattr read };
+allow udev_t etc_t:file { getattr read ioctl };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
 allow udev_t bin_t:lnk_file read;
@@ -80,7 +80,6 @@
 ')
 allow udev_t devpts_t:dir { getattr search };
 allow udev_t etc_runtime_t:file { getattr read };
-allow udev_t etc_t:file ioctl;
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')

--Boundary-00=_pzA2BW+0vXZfF1Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/Makefile	2004-12-23 19:14:12.000000000 +1100
+++ Makefile.new	2005-01-02 23:05:18.000000000 +1100
@@ -72,10 +72,12 @@
 
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
-install: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
+tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
 	@echo "Validating file_contexts ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
 
+install: tmp/valid_fc
+
 $(CONTEXTPATH)/files/media: appconfig/media
 	mkdir -p $(CONTEXTPATH)/files/
 	install -m 644 $< $@
--- /usr/src/se/policy/assert.te	2004-12-13 09:55:20.000000000 +1100
+++ assert.te	2004-12-25 04:35:51.000000000 +1100
@@ -124,6 +124,8 @@
 ifdef(`ypbind.te', `assert_execute(ypbind)')
 ifdef(`xfs.te', `assert_execute(xfs)')
 ifdef(`gpm.te', `assert_execute(gpm)')
+ifdef(`ifconfig.te', `assert_execute(ifconfig)')
+ifdef(`iptables.te', `assert_execute(iptables)')
 
 ifdef(`login.te', `
 neverallow { local_login_t remote_login_t } ~{ login_exec_t ifdef(`pam.te', `pam_exec_t') }:file entrypoint;
--- /usr/src/se/policy/domains/program/ldconfig.te	2004-12-13 09:55:21.000000000 +1100
+++ domains/program/ldconfig.te	2004-12-23 19:24:00.000000000 +1100
@@ -44,6 +44,8 @@
 ')
 
 allow ldconfig_t proc_t:file read;
+ifdef(`hide_broken_symptoms', `
 ifdef(`unconfined.te',`
 dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
-');
+')
+')dnl end hide_broken_symptoms
--- /usr/src/se/policy/domains/program/unused/ftpd.te	2004-11-21 21:51:13.000000000 +1100
+++ ./domains/program/unused/ftpd.te	2004-12-01 14:35:19.000000000 +1100
@@ -96,16 +99,14 @@
 # Allow ftp to read/write files in the user home directories.
 bool ftp_home_dir false;
 
+if (ftp_home_dir) {
+# allow access to /home
+allow ftpd_t home_root_t:dir { getattr search };
+}
+
 if (ftp_home_dir && use_nfs_home_dirs) {
 allow ftpd_t nfs_t:dir r_dir_perms;
 allow ftpd_t nfs_t:file r_file_perms;
-# dont allow access to /home
-dontaudit ftpd_t home_root_t:dir { getattr search };
-} 
-else 
-{
-# allow access to /home
-allow ftpd_t home_root_t:dir { getattr search };
 }
 dontaudit ftpd_t selinux_config_t:dir search;
 #
--- /usr/src/se/policy/domains/program/unused/howl.te	2004-12-03 19:49:23.000000000 +1100
+++ ./domains/program/unused/howl.te	2004-12-25 04:01:00.000000000 +1100
@@ -4,8 +4,8 @@
 #
 
 daemon_domain(howl)
-allow howl_t proc_net_t:dir search;
-allow howl_t proc_net_t:file {getattr read };
+allow howl_t proc_net_t:dir r_dir_perms;
+allow howl_t proc_net_t:file { getattr read };
 can_network_server(howl_t)
 can_ypbind(howl_t)
 allow howl_t self:capability { kill net_admin };
@@ -15,6 +15,8 @@
 type howl_port_t, port_type;
 allow howl_t howl_port_t:{ udp_socket tcp_socket } name_bind;
 
+allow howl_t self:unix_dgram_socket create_socket_perms;
+
 allow howl_t etc_t:file { getattr read };
 allow howl_t initrc_var_run_t:file rw_file_perms;
 
--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-11-21 21:51:14.000000000 +1100
+++ ./domains/program/unused/rpm.te	2004-11-22 03:14:43.000000000 +1100
@@ -66,6 +66,11 @@
 domain_auto_trans(rpm_script_t, cupsd_exec_t, cupsd_t)
 ')
 
+ifdef(`gpg.te', `
+# gpg wants this so it does not dump core on errors
+allow rpm_t self:process { setrlimit };
+')
+
 # for a bug in rm
 dontaudit initrc_t pidfile:file write;
 
--- /usr/src/se/policy/domains/program/unused/xdm.te	2004-12-13 09:55:25.000000000 +1100
+++ domains/program/unused/xdm.te	2005-01-02 23:29:29.000000000 +1100
@@ -70,10 +70,6 @@
 # Use capabilities.
 allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner };
 
-# Use /dev/mem.
-# Commented out by default.
-#allow xdm_t memory_device_t:chr_file { execute read write };
-
 allow xdm_t { urandom_device_t random_device_t }:chr_file { getattr read ioctl };
 
 # Transition to user domains for user sessions.
--- /usr/src/se/policy/file_contexts/types.fc	2004-12-13 09:55:26.000000000 +1100
+++ file_contexts/types.fc	2005-01-02 23:38:16.000000000 +1100
@@ -302,11 +299,6 @@
 /etc/resolv\.conf.*	--	system_u:object_r:net_conf_t
 
 /etc/selinux(/.*)?		system_u:object_r:selinux_config_t
-/etc/security/selinux(/.*)?	system_u:object_r:policy_config_t	
-/etc/security/selinux/src(/.*)?	system_u:object_r:policy_src_t
-/etc/security/default_contexts.*	system_u:object_r:default_context_t
-/etc/services		--	system_u:object_r:etc_t
-
 /etc/selinux/[^/]*/policy(/.*)?	system_u:object_r:policy_config_t
 /etc/selinux/[^/]*/src(/.*)?	system_u:object_r:policy_src_t
 /etc/selinux/[^/]*/contexts(/.*)?	system_u:object_r:default_context_t
--- /usr/src/se/policy/file_contexts/program/portmap.fc	2004-12-13 09:55:29.000000000 +1100
+++ file_contexts/program/portmap.fc	2005-01-02 23:46:07.000000000 +1100
@@ -1,4 +1,9 @@
 # portmap
 /sbin/portmap		--	system_u:object_r:portmap_exec_t
+ifdef(`distro_debian', `
+/sbin/pmap_dump		--	system_u:object_r:portmap_helper_exec_t
+/sbin/pmap_set		--	system_u:object_r:portmap_helper_exec_t
+', `
 /usr/sbin/pmap_dump	--	system_u:object_r:portmap_helper_exec_t
 /usr/sbin/pmap_set	--	system_u:object_r:portmap_helper_exec_t
+')

--Boundary-00=_pzA2BW+0vXZfF1Z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
