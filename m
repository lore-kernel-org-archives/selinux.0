Message-ID: <423253FB.6090602@redhat.com>
Date: Fri, 11 Mar 2005 21:29:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest patches
Content-Type: multipart/mixed;
 boundary="------------090201090709070609030205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090201090709070609030205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed to Makefile to better handle local.users

Ivan's Gift policy

Fixes to expand targeted policy.  (Adding dhcpc, ifconfig, hostname, 
consoletype)

Fixes to fs_daemon

Added a bunch of dontaudit of net_admin for many policies.


-- 



--------------090201090709070609030205
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.23.1/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.1/domains/program/ifconfig.te	2005-03-11 21:18:59.923282416 -0500
@@ -65,3 +65,4 @@
 
 rhgb_domain(ifconfig_t)
 allow ifconfig_t userdomain:fd use;
+dontaudit ifconfig_t root_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.1/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.1/domains/program/initrc.te	2005-03-11 21:18:59.923282416 -0500
@@ -244,6 +244,7 @@
 #
 ifdef(`targeted_policy', `
 type run_init_exec_t, file_type, sysadmfile, exec_type;
+type run_init_t, domain;
 domain_auto_trans(unconfined_t, initrc_exec_t, initrc_t)
 allow unconfined_t initrc_t:dbus { acquire_svc send_msg };
 allow initrc_t unconfined_t:dbus { acquire_svc send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.23.1/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.1/domains/program/login.te	2005-03-11 21:18:59.924282264 -0500
@@ -187,6 +187,7 @@
 
 # Allow setting of attributes on power management devices.
 allow local_login_t power_device_t:chr_file { getattr setattr };
+dontaudit local_login_t init_t:fd use;
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.1/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.1/domains/program/unused/apache.te	2005-03-11 21:18:59.925282112 -0500
@@ -157,6 +157,7 @@
 # Allow the httpd_t the capability to bind to a port and various other stuff
 ############################################################################
 allow httpd_t self:capability { chown dac_override kill setgid setuid net_bind_service sys_tty_config };
+dontaudit httpd_t self:capability net_admin;
 
 #################################################
 # Allow the httpd_t to read the web servers config files
@@ -206,7 +207,7 @@
 # need ioctl for php
 ###############################################
 allow httpd_t etc_t:file { read getattr ioctl };
-allow httpd_t etc_t:lnk_file read;
+allow httpd_t etc_t:lnk_file { getattr read };
 
 # Run SSI execs in system CGI script domain.
 if (httpd_ssi_exec) {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.23.1/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.1/domains/program/unused/consoletype.te	2005-03-11 21:18:59.925282112 -0500
@@ -8,7 +8,7 @@
 #
 # Rules for the consoletype_t domain.
 #
-# consoletype_t is the domain for the ifconfig program.
+# consoletype_t is the domain for the consoletype program.
 # consoletype_exec_t is the type of the corresponding program.
 #
 type consoletype_t, domain;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fs_daemon.te policy-1.23.1/domains/program/unused/fs_daemon.te
--- nsapolicy/domains/program/unused/fs_daemon.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.1/domains/program/unused/fs_daemon.te	2005-03-11 21:18:59.925282112 -0500
@@ -3,13 +3,24 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: smartmontools
 
-daemon_domain(fsdaemon, `, fs_domain')
+daemon_domain(fsdaemon, `, fs_domain, privmail')
 allow fsdaemon_t self:unix_dgram_socket create_socket_perms;
+allow fsdaemon_t self:unix_stream_socket create_stream_socket_perms;
 
 # for config
 allow fsdaemon_t etc_t:file { getattr read };
 
 allow fsdaemon_t device_t:dir read;
 allow fsdaemon_t fixed_disk_device_t:blk_file rw_file_perms;
-allow fsdaemon_t self:capability { sys_rawio sys_admin };
+allow fsdaemon_t self:capability { setgid sys_rawio sys_admin };
 allow fsdaemon_t etc_runtime_t:file { getattr read };
+
+can_exec_any(fsdaemon_t)
+allow fsdaemon_t self:fifo_file rw_file_perms;
+can_network_udp(fsdaemon_t)
+tmp_domain(fsdaemon)
+allow system_mail_t fsdaemon_tmp_t:file { getattr ioctl read };
+
+dontaudit fsdaemon_t devpts_t:dir search;
+allow fsdaemon_t proc_t:file { getattr read };
+dontaudit system_mail_t fixed_disk_device_t:blk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gift.te policy-1.23.1/domains/program/unused/gift.te
--- nsapolicy/domains/program/unused/gift.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.1/domains/program/unused/gift.te	2005-03-11 21:18:59.926281960 -0500
@@ -0,0 +1,9 @@
+# DESC - giFT file sharing tool
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+type gift_exec_t, file_type, exec_type, sysadmfile;
+type giftd_exec_t, file_type, exec_type, sysadmfile;
+
+# Everything else is in macros/gift_macros.te
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pam.te policy-1.23.1/domains/program/unused/pam.te
--- nsapolicy/domains/program/unused/pam.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.1/domains/program/unused/pam.te	2005-03-11 21:18:59.926281960 -0500
@@ -37,3 +37,4 @@
 
 allow initrc_t pam_var_run_t:dir rw_dir_perms;
 allow initrc_t pam_var_run_t:file { getattr read unlink };
+dontaudit pam_t initrc_var_run_t:file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.23.1/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.1/domains/program/unused/rpcd.te	2005-03-11 21:18:59.926281960 -0500
@@ -17,6 +17,7 @@
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
 allow $1_t self:capability net_bind_service;
+dontaudit $1_t self:capability net_admin;
 
 allow $1_t var_t:dir { getattr search };
 allow $1_t var_lib_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.23.1/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.1/domains/program/unused/ypbind.te	2005-03-11 21:18:59.927281808 -0500
@@ -16,6 +16,7 @@
 
 # Use capabilities.
 allow ypbind_t self:capability { net_bind_service };
+dontaudit ypbind_t self:capability net_admin;
 
 # Use the network.
 can_network(ypbind_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dbusd.fc policy-1.23.1/file_contexts/program/dbusd.fc
--- nsapolicy/file_contexts/program/dbusd.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.1/file_contexts/program/dbusd.fc	2005-03-11 21:18:59.927281808 -0500
@@ -1,3 +1,3 @@
-/usr/bin/dbus-daemon-1	--	system_u:object_r:system_dbusd_exec_t
+/usr/bin/dbus-daemon(-1)?	--	system_u:object_r:system_dbusd_exec_t
 /etc/dbus-1(/.*)?		system_u:object_r:etc_dbusd_t
 /var/run/dbus(/.*)?		system_u:object_r:system_dbusd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/gift.fc policy-1.23.1/file_contexts/program/gift.fc
--- nsapolicy/file_contexts/program/gift.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.1/file_contexts/program/gift.fc	2005-03-11 21:18:59.927281808 -0500
@@ -0,0 +1,5 @@
+/usr/(local/)?bin/giftd	--	system_u:object_r:giftd_exec_t
+/usr/(local/)?bin/giftui	-- 	system_u:object_r:gift_exec_t
+/usr/(local/)?bin/giFToxic	--	system_u:object_r:gift_exec_t
+/usr/(local/)?bin/apollon	-- 	system_u:object_r:gift_exec_t
+HOME_DIR/\.giFT(/.*)?		system_u:object_r:ROLE_gift_home_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.1/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.1/macros/program/gift_macros.te	2005-03-11 21:18:59.928281656 -0500
@@ -0,0 +1,113 @@
+#
+# Macros for giFT
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# gift_domains(domain_prefix)
+# declares a domain for giftui and giftd
+
+#########################
+#  gift_domain(user)    #
+#########################
+
+define(`gift_domain', `
+
+# Connect to X
+x_client_domain($1, gift, `')	
+
+# Transition
+domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
+can_exec($1_gift_t, gift_exec_t)
+role $1_r types $1_gift_t;
+
+# Self permissions
+allow $1_gift_t self:process getsched;
+
+# Home files
+home_domain($1, gift)
+
+# Fonts, icons
+r_dir_file($1_gift_t, usr_t)
+r_dir_file($1_gift_t, fonts_t)
+
+# Launch gift daemon
+allow $1_gift_t self:process fork;
+domain_auto_trans($1_gift_t, giftd_exec_t, $1_giftd_t)
+
+# Connect to gift daemon
+can_network($1_gift_t)
+
+# Read /proc/meminfo
+allow $1_gift_t proc_t:dir search;
+allow $1_gift_t proc_t:file { getattr read };
+
+# Tmp/ORBit
+tmp_domain($1_gift)
+file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
+can_unix_connect($1_t, $1_gift_t)
+can_unix_connect($1_gift_t, $1_t)
+allow $1_t $1_gift_tmp_t:sock_file write;
+allow $1_gift_t $1_tmp_t:file { getattr read write lock };
+allow $1_gift_t $1_tmp_t:sock_file { read write };
+dontaudit $1_gift_t $1_tmp_t:dir setattr;
+
+# Access random device
+allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
+
+# giftui looks in .icons, .themes, .fonts-cache.
+dontaudit $1_gift_t $1_home_t:dir { getattr read search };
+dontaudit $1_gift_t $1_home_t:file { getattr read };
+
+') dnl gift_domain
+
+##########################
+#  giftd_domain(user)    #
+##########################
+
+define(`giftd_domain', `
+
+type $1_giftd_t, domain;
+
+# Transition from user type
+domain_auto_trans($1_t, giftd_exec_t, $1_giftd_t)
+role $1_r types $1_giftd_t;
+
+# Self permissions, allow fork
+allow $1_giftd_t self:process { fork signal sigchld setsched };
+allow $1_giftd_t self:unix_stream_socket create_socket_perms;
+
+read_sysctl($1_giftd_t)
+read_locale($1_giftd_t)
+uses_shlib($1_giftd_t)
+
+# Access home domain
+home_domain_access($1_giftd_t, $1, gift)
+	
+# Allow networking
+allow $1_giftd_t port_t:tcp_socket name_bind;
+allow $1_giftd_t port_t:udp_socket name_bind;
+can_network_server($1_giftd_t)
+can_network_client($1_giftd_t)
+
+# FIXME: ???
+dontaudit $1_giftd_t self:udp_socket listen;
+
+# Plugins
+r_dir_file($1_giftd_t, usr_t)
+
+# Connect to xdm
+ifdef(`xdm.te', `
+allow $1_giftd_t xdm_t:fd use;
+allow $1_giftd_t xdm_t:fifo_file write;
+') 
+
+') dnl giftd_domain
+
+##########################
+#  gift_domains(user)    #
+##########################
+
+define(`gift_domains', `
+gift_domain($1)
+giftd_domain($1)
+') dnl gift_domains
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.23.1/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.1/macros/program/mplayer_macros.te	2005-03-11 21:18:59.928281656 -0500
@@ -85,6 +85,11 @@
 # Read home directory content
 r_dir_file($1_mplayer_t, $1_home_t);
 
+# Legacy domain issues
+if (allow_mplayer_execstack) {
+allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
+}
+
 ') dnl end mplayer_domain
 
 ############################
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.23.1/Makefile
--- nsapolicy/Makefile	2005-03-11 15:31:05.000000000 -0500
+++ policy-1.23.1/Makefile	2005-03-11 21:22:06.839866776 -0500
@@ -77,12 +77,12 @@
 
 all:  policy
 
-tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
+tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) 
 	@echo "Validating file_contexts ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
 	@touch tmp/valid_fc
 
-install: tmp/valid_fc
+install: tmp/valid_fc $(USERPATH)/local.users
 
 $(USERPATH)/system.users: $(ALL_TUNABLES) $(USER_FILES) policy.conf
 	@mkdir -p $(USERPATH)
@@ -96,7 +96,7 @@
 
 $(USERPATH)/local.users: local.users
 	@mkdir -p $(USERPATH)
-	install -m 644 $< $@
+	install -C -b -m 644 $< $@
 
 $(CONTEXTPATH)/files/media: appconfig/media
 	mkdir -p $(CONTEXTPATH)/files/
@@ -207,7 +207,8 @@
 file_contexts/misc:
 	mkdir -p file_contexts/misc
 
-$(FCPATH): $(FC) 
+
+$(FCPATH): $(FC) $(USERPATH)/system.users 
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
 	install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/xdm.te policy-1.23.1/targeted/domains/program/xdm.te
--- nsapolicy/targeted/domains/program/xdm.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.1/targeted/domains/program/xdm.te	2005-03-11 21:18:59.929281504 -0500
@@ -18,4 +18,5 @@
 type xdm_rw_etc_t, file_type, sysadmfile;
 type xdm_var_run_t, file_type, sysadmfile;
 type xdm_var_lib_t, file_type, sysadmfile;
+type xdm_tmp_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.1/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.1/tunables/distro.tun	2005-03-11 21:18:59.929281504 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.1/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.1/tunables/tunable.tun	2005-03-11 21:18:59.930281352 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------090201090709070609030205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
