Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16407
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 15:08:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA24321
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 19:07:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA24315
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 19:07:38 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA05393
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 15:08:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA10801
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 18:59:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA08446
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 22:57:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA08442 for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 22:57:43 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A04199247A
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 08:59:23 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8AABB7A03
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 00:59:15 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Tue, 10 Sep 2002 00:59:15 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_R617SS8LUJ9I0NUXB1CF"
Message-Id: <200209100059.15066.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_R617SS8LUJ9I0NUXB1CF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

initrd.diff is part of the policy needed to get an initrd working properly, it 
doesn't have everything because it's difficult to separate it all.  But it's 
a good improvement and it has most of what you need.

misc.diff is many things that are patches for things that are in my area (IE 
dpkg.te), trivial, or patches for things that are not fully working anyway 
(postgresql and fcron) so which can't be broken.  Also it includes part of 
the policy for the chroot setup as described in my paper for Linux Kongress 
(again it's something that's not easy to split so I'll include the rest in 
another patch).

amanda.diff is a patch for amanda to properly support the types for home dirs 
with multiple user roles.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_R617SS8LUJ9I0NUXB1CF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="amanda.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="amanda.diff"

--- /tmp/policy/domains/program/amanda.te	2002-09-09 19:54:10.000000000 +0200
+++ domains/program/amanda.te	2002-09-10 00:37:39.000000000 +0200
@@ -195,8 +195,8 @@
 ########################
 
 # access to user_home_t
-allow amanda_t { user_home_dir_t user_home_t }:dir { search getattr read };
-allow amanda_t user_home_t:file { getattr read };
+allow amanda_t { user_home_dir_type user_home_type }:dir { search getattr read };
+allow amanda_t user_home_type:file { getattr read };
 
 # access to file_t ( /floppy, /cdrom )
 allow amanda_t file_t:dir { getattr };
@@ -204,7 +204,6 @@
 ###########
 # Dontaudit
 ###########
-
 dontaudit amanda_t file_labels_t:dir { getattr read search };
 dontaudit amanda_t file_labels_t:file { getattr read };
 dontaudit amanda_t lost_found_t:dir { getattr read };

--------------Boundary-00=_R617SS8LUJ9I0NUXB1CF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="initrd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="initrd.diff"

diff -ruN /tmp/policy/Makefile policy/Makefile
--- /tmp/policy/Makefile	2002-09-10 00:01:30.000000000 +0200
+++ policy/Makefile	2002-08-31 17:33:36.000000000 +0200
@@ -23,7 +23,6 @@
 POLICYVER := policy.$(shell $(CHECKPOLICY) -V)
 INSTALLDIR = /etc/security/selinux
 LOADPATH = $(INSTALLDIR)/$(POLICYVER)
-INITRDLOADPATH = $(INSTALLDIR)/initrd-$(POLICYVER)
 SRCINSTALLDIR = $(INSTALLDIR)/src
 POLICYCONF = $(SRCINSTALLDIR)/policy.conf
 
@@ -35,71 +34,68 @@
 POLICYFILES += rbac users constraints
 POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
 
-INITRDPOLICYFILES = $(subst all.te,initrd_all.te,$(POLICYFILES))
+INITRDPOLICYFILES = $(subst users, initrd-domains/users,$(subst all.te,initrd_all.te,$(POLICYFILES)))
 
 FC = file_contexts/file_contexts
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
 
-
-policy: $(POLICYVER)
-
-$(POLICYVER):  tmp policy.conf $(CHECKPOLICY)
-	$(CHECKPOLICY) -o $@ policy.conf
-
-tmp:
-	mkdir tmp
-
-initrd-$(POLICYVER):  tmp initrd-policy.conf $(CHECKPOLICY)
-	$(CHECKPOLICY) -o tmp/$@ initrd-policy.conf
-	gzip -c tmp/$@ > $@
-
-initrd-policy: initrd-$(POLICYVER)
-
 install: $(LOADPATH)
 
-install-initrd: $(INITRDLOADPATH)
+install-initrd: $(LOADPATH).initrd
 
 $(LOADPATH):  $(POLICYCONF) $(CHECKPOLICY)
 	mkdir -p $(INSTALLDIR)
-	$(CHECKPOLICY) -o $@ $(POLICYCONF)
+	$(CHECKPOLICY) -o tmp/pol $(POLICYCONF)
+	gzip -9 < tmp/pol > $@
+	rm tmp/pol
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
 
-$(INITRDLOADPATH): initrd-$(POLICYVER)
+$(LOADPATH).initrd:  $(POLICYCONF).initrd $(CHECKPOLICY)
 	mkdir -p $(INSTALLDIR)
-	install -m 644 -o root -g root initrd-$(POLICYVER) $(INITRDLOADPATH)
+	$(CHECKPOLICY) -o tmp/pol.initrd $(POLICYCONF).initrd
+	gzip -9 < tmp/pol.initrd > $@
+	rm tmp/pol.initrd
+# Note: Can't use install, so not sure how to deal with mode, user, and group
+#	other than by default.
 
 $(POLICYCONF): policy.conf 
 	mkdir -p $(SRCINSTALLDIR)
 	install -m 644 -o root -g root policy.conf $@
 
+$(POLICYCONF).initrd: policy.conf.initrd
+	mkdir -p $(SRCINSTALLDIR)
+	install -m 644 -o root -g root policy.conf.initrd $@
+
 reload tmp/load: $(LOADPATH)
 	$(BINDIR)/load_policy $(LOADPATH)
 	touch tmp/load
 
 load: tmp/load
 
-policy.conf: tmp $(POLICYFILES) 
+policy.conf: $(POLICYFILES) 
+	mkdir -p tmp
 	m4 -Imacros -s $(POLICYFILES) > policy.conf
 
 install-src: 
 	mkdir -p $(SRCINSTALLDIR)/policy
 	cp -R . $(SRCINSTALLDIR)/policy
 
-initrd-policy.conf: $(INITRDPOLICYFILES) 
-	m4 -Imacros -s $(INITRDPOLICYFILES) > initrd-policy.conf
+policy.conf.initrd: $(INITRDPOLICYFILES) 
+	m4 -Imacros -s $(INITRDPOLICYFILES) > $@
 
 ALLTEFILES := attrib.te tmp/program_used_flags.te tmp/all_macros.te tmp/all_types.te tmp/all_domains.te assert.te 
 
 tmp/all.te: $(ALLTEFILES)
 	cat $^ > $@
 
-INITRDALLTEFILES = $(subst all_domains.te,all_initrd_domains.te,$(subst program_used_flags.te,initrd_program_used_flags.te,$(POLICYFILES)))
+INITRD_ALLTEFILES := attrib.te tmp/initrd_program_used_flags.te tmp/all_macros.te tmp/all_types.te tmp/all_initrd_domains.te assert.te 
 
-tmp/initrd_all.te: $(INITRDALLTEFILES)
+tmp/initrd_all.te: $(INITRD_ALLTEFILES)
 	cat $^ > $@
 
 tmp/program_used_flags.te: $(wildcard domains/program/*.te) domains/program
+	mkdir -p tmp
 	( cd domains/program/ ; for n in *.te ; do echo "define(\`$$n')"; done ) > $@
 
 tmp/initrd_program_used_flags.te: $(wildcard initrd-domains/*.te) initrd-domains
@@ -130,8 +126,7 @@
 	cat $(FCFILES) > $@
 
 clean:
-	rm -f $(POLICYVER) policy.conf 
-	rm -f initrd-$(POLICYVER) initrd-policy.conf 
+	rm -f policy.conf policy.conf.initrd
 	rm -f tmp/*
 	rm -f $(FC)
  
diff -ruN /tmp/policy/assert.te policy/assert.te
--- /tmp/policy/assert.te	2002-08-23 21:04:27.000000000 +0200
+++ policy/assert.te	2002-08-29 00:32:49.000000000 +0200
@@ -70,7 +70,7 @@
 #
 neverallow ~{ initrc_t admin kernel_t insmod_t } sysctl_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
-neverallow ~{ initrc_t admin kernel_t kmod_t insmod_t } sysctl_kernel_t:file { write append };
+neverallow ~{ init_t initrc_t admin kernel_t kmod_t insmod_t } sysctl_kernel_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_net_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_net_unix_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_vm_t:file { write append };
@@ -89,8 +89,8 @@
            ``neverallow $1_t ~$1_exec_t:file entrypoint; neverallow $1_t ~{ $1_exec_t ld_so_t }:file execute_no_trans;'',
            `assert_execute($1) assert_execute(shift($@))')')
 
-assert_execute(getty, klogd)
-
+ifdef(`getty.te', `assert_execute(getty)')
+assert_execute(klogd)
 ifdef(`atd.te', `assert_execute(atd)')
 ifdef(`tcpd.te', `assert_execute(tcpd)')
 ifdef(`portmap.te', `assert_execute(portmap)')
@@ -101,8 +101,10 @@
 ifdef(`xfs.te', `assert_execute(xfs)')
 ifdef(`gpm.te', `assert_execute(gpm)')
 
+ifdef(`login.te', `
 neverallow { local_login_t remote_login_t } ~login_exec_t:file entrypoint;
 neverallow { local_login_t remote_login_t } ~ld_so_t:file execute_no_trans;
+')
 
 #
 # Verify that the passwd domain can only be entered by its
diff -ruN /tmp/policy/domains/program/init.te policy/domains/program/init.te
--- /tmp/policy/domains/program/init.te	2002-09-09 19:54:11.000000000 +0200
+++ policy/domains/program/init.te	2002-09-10 00:10:38.000000000 +0200
@@ -36,6 +36,11 @@
 # Run init.
 can_exec(init_t, init_exec_t)
 
+# Run chroot from initrd scripts.
+ifdef(`chroot.te', `
+can_exec(init_t, chroot_exec_t)
+')
+
 # Create /dev/initctl.
 file_type_auto_trans(init_t, device_t, initctl_t)
 
@@ -88,3 +93,6 @@
 # reparented to init, so we need these type transition rules.
 # 
 # These rules have been moved to the individual target domain .te files.
+
+# for initrd pivot_root seems to access this
+dontaudit init_t file_labels_t:dir { search };
diff -ruN /tmp/policy/genfs_contexts policy/genfs_contexts
--- /tmp/policy/genfs_contexts	2002-09-09 19:54:04.000000000 +0200
+++ policy/genfs_contexts	2002-08-29 00:35:11.000000000 +0200
@@ -88,7 +88,9 @@
 genfscon devfs /ppp			system_u:object_r:ppp_device_t
 genfscon devfs /fb	-c		system_u:object_r:framebuf_device_t
 genfscon devfs /initctl		system_u:object_r:initctl_t
+ifdef(`syslog.te', `
 genfscon devfs /log			system_u:object_r:devlog_t
+')
 genfscon devfs /misc/psaux		system_u:object_r:mouse_device_t
 genfscon devfs /misc/nvram		system_u:object_r:memory_device_t
 genfscon devfs /input/mouse		system_u:object_r:mouse_device_t
@@ -111,4 +113,24 @@
 genfscon autofs /			system_u:object_r:autofs_t
 ')
 
-# FLASK
+# romfs
+genfscon romfs /			system_u:object_r:root_t
+genfscon romfs /bin			system_u:object_r:bin_t
+genfscon romfs /bin/mount		system_u:object_r:mount_exec_t
+genfscon romfs /bin/umount		system_u:object_r:mount_exec_t
+genfscon romfs /bin/ash			system_u:object_r:shell_exec_t
+genfscon romfs /etc			system_u:object_r:etc_t
+genfscon romfs /lib			system_u:object_r:lib_t
+genfscon romfs /lib/ld-linux.so.2	system_u:object_r:ld_so_t
+genfscon romfs /lib/libc.so.6		system_u:object_r:shlib_t
+genfscon romfs /lib/modules		system_u:object_r:modules_object_t
+genfscon romfs /linuxrc			system_u:object_r:init_exec_t
+genfscon romfs /linuxrc.conf		system_u:object_r:etc_t
+genfscon romfs /loadmodules		system_u:object_r:shell_exec_t
+genfscon romfs /sbin			system_u:object_r:sbin_t
+genfscon romfs /sbin/init		system_u:object_r:init_exec_t
+genfscon romfs /sbin/insmod		system_u:object_r:insmod_exec_t
+genfscon romfs /sbin/modprobe		system_u:object_r:insmod_exec_t
+genfscon romfs /scripts			system_u:object_r:sbin_t
+genfscon romfs /tmp			system_u:object_r:tmp_t
+genfscon romfs /usr			system_u:object_r:sbin_t

--------------Boundary-00=_R617SS8LUJ9I0NUXB1CF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="misc.diff"

diff -ruN /tmp/policy/domains/admin.te policy/domains/admin.te
--- /tmp/policy/domains/admin.te	2002-09-09 19:54:07.000000000 +0200
+++ policy/domains/admin.te	2002-09-08 10:31:05.000000000 +0200
@@ -22,5 +22,6 @@
 auditallow admin kernel_t:system avc_toggle;
 
 
+define(`admin_tty_type', `{ sysadm_tty_device_t sysadm_devpts_t }')
 
 
diff -ruN /tmp/policy/domains/program/backup.te policy/domains/program/backup.te
--- /tmp/policy/domains/program/backup.te	2002-08-23 20:44:18.000000000 +0200
+++ policy/domains/program/backup.te	2002-08-31 15:38:47.000000000 +0200
@@ -16,10 +16,11 @@
 
 domain_auto_trans(sysadm_t, backup_exec_t, backup_t)
 allow backup_t privfd:fd use;
-ifdef(`crond.te',
-`domain_auto_trans(system_crond_t, backup_exec_t, backup_t)
+ifdef(`crond.te', `
+domain_auto_trans(system_crond_t, backup_exec_t, backup_t)
 rw_dir_create_file(system_crond_t, backup_store_t)
-allow backup_t crond_t:fifo_file { read write ioctl };')
+allow backup_t crond_t:fifo_file { read write ioctl };
+')
 
 can_network(backup_t)
 uses_shlib(backup_t)
@@ -37,11 +38,11 @@
 allow backup_t sysctl_kernel_t:file read;
 
 allow backup_t self:fifo_file rw_file_perms;
-allow backup_t self:process { sigchld fork };
+allow backup_t self:process { signal sigchld fork };
 allow backup_t self:capability { dac_override };
 
 rw_dir_file(backup_t, backup_store_t)
-allow backup_t backup_store_t:file create;
+allow backup_t backup_store_t:file { create setattr };
 
 allow backup_t fs_t:filesystem getattr;
 
diff -ruN /tmp/policy/domains/program/courier.te policy/domains/program/courier.te
--- /tmp/policy/domains/program/courier.te	2002-09-09 19:54:10.000000000 +0200
+++ policy/domains/program/courier.te	2002-09-03 02:23:42.000000000 +0200
@@ -113,7 +113,10 @@
 
 # for webmail
 courier_domain(sqwebmail)
-ifdef(`crond.te',
-`domain_auto_trans(system_crond_t, sqwebmail_cron_exec_t, courier_sqwebmail_t)
+ifdef(`crond.te', `
+domain_auto_trans(system_crond_t, sqwebmail_cron_exec_t, courier_sqwebmail_t)
 allow courier_sqwebmail_t crond_t:fd use;
-allow courier_sqwebmail_t crond_t:fifo_file rw_file_perms;')
+allow courier_sqwebmail_t crond_t:fifo_file rw_file_perms;
+')
+allow courier_sqwebmail_t { sysctl_t sysctl_kernel_t }:dir search;
+allow courier_sqwebmail_t sysctl_kernel_t:file { getattr read };
diff -ruN /tmp/policy/domains/program/crack.te policy/domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-08-23 20:44:18.000000000 +0200
+++ policy/domains/program/crack.te	2002-08-29 09:46:02.000000000 +0200
@@ -12,41 +12,26 @@
 domain_auto_trans(system_crond_t, crack_exec_t, crack_t)
 
 type crack_db_t, file_type, sysadmfile;
-
 rw_dir_create_file(crack_t, crack_db_t)
 
 allow crack_t crond_t:fd use;
 allow crack_t crond_t:fifo_file r_file_perms;
+allow crack_t device_t:dir search;
 allow crack_t devtty_t:chr_file rw_file_perms;
-# Use the network.
-#can_network(crack_t)
 allow crack_t self:fifo_file { read write getattr };
-#allow crack_t self:unix_stream_socket create_socket_perms;
-#allow crack_t self:unix_dgram_socket create_socket_perms;
 
 tmp_domain(crack)
 
 can_exec(crack_t, bin_t)
 allow crack_t { bin_t sbin_t }:dir search;
 
-# Use capabilities
-#allow crack_t self:capability { net_raw net_bind_service };
-
 allow crack_t self:process { fork signal_perms };
 
 allow crack_t proc_t:dir { read search };
 allow crack_t proc_t:file { read getattr };
 
-# Allow access to the crack databases
-#allow crack_t crack_db_t:file create_file_perms;
-#allow crack_t crack_db_t:dir create_dir_perms;
-#allow crack_t var_lib_t:dir r_dir_perms;
-
 # read config files
 allow crack_t { etc_t etc_runtime_t }:file { getattr read };
 allow crack_t etc_t:dir r_dir_perms;
 
-#allow crack_t sysctl_kernel_t:dir search;
-#allow crack_t sysctl_kernel_t:file read;
-
 dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
diff -ruN /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2002-08-26 18:50:43.000000000 +0200
+++ policy/domains/program/crond.te	2002-09-03 02:24:32.000000000 +0200
@@ -144,6 +144,9 @@
 # permission check for this purpose.
 #
 allow system_crond_t system_crond_script_t:file entrypoint;
+ifdef(`fcron.te', `
+allow system_crond_t sysadm_cron_spool_t:file entrypoint;
+')
 
 # Run helper programs in the system_crond_t domain.
 can_exec_any(system_crond_t)
diff -ruN /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-09 19:54:11.000000000 +0200
+++ policy/domains/program/dpkg.te	2002-09-09 11:15:07.000000000 +0200
@@ -113,6 +113,7 @@
 
 r_dir_file(install_menu_t, var_lib_dpkg_t)
 allow { install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
+can_exec(sysadm_t, etc_dpkg_t)
 
 # Inherit and use descriptors from any domain.
 allow { apt_t dpkg_t } privfd:fd use;
@@ -216,7 +217,7 @@
 allow install_menu_t self:process signal;
 allow install_menu_t proc_t:dir search;
 allow install_menu_t proc_t:file r_file_perms;
-can_exec(install_menu_t, { bin_t shell_exec_t install_menu_exec_t dpkg_exec_t install_menu_t })
+can_exec(install_menu_t, { bin_t sbin_t shell_exec_t install_menu_exec_t dpkg_exec_t install_menu_t })
 allow install_menu_t { bin_t sbin_t }:dir search;
 allow install_menu_t bin_t:lnk_file read;
 
@@ -242,11 +243,7 @@
 ifdef(`crond.te', `
 allow system_crond_t shadow_t:file { read getattr };
 create_dir_file(system_crond_t, tetex_data_t)
-')
-
-ifdef(`fcron.te', `
-domain_auto_trans(dpkg_t, crontab_exec_t, sysadm_crontab_t)
-role system_r types sysadm_crontab_t;
+can_exec(dpkg_t, tetex_data_t)
 ')
 
 role system_r types { dpkg_t apt_t install_menu_t };
diff -ruN /tmp/policy/domains/program/fcron.te policy/domains/program/fcron.te
--- /tmp/policy/domains/program/fcron.te	2002-08-23 20:44:18.000000000 +0200
+++ policy/domains/program/fcron.te	2002-09-09 11:15:31.000000000 +0200
@@ -6,7 +6,8 @@
 #
 # Author: Russell Coker <russell@coker.com.au>
 
-daemon_domain(fcron, `, privuser, privrole, privmail')
+# ideally we would not give it privowner!
+daemon_domain(fcron, `, privuser, privrole, privmail, privfd, privowner')
 
 general_domain_access(fcron_t)
 
@@ -17,10 +18,12 @@
 file_type_auto_trans(fcron_t, var_log_t, cron_log_t)
 
 ifdef(`mta.te', `
-allow system_mail_t fcron_spool_t:file read;
-dontaudit system_mail_t fcron_spool_t:file write;
+# not sure why we need write access, but Postfix does not work without it
+allow { system_mail_t mta_user_agent } fcron_spool_t:file { read write getattr };
 ')
 
+allow { user_crond_domain system_crond_t sysadm_crond_t } fcron_spool_t:dir getattr;
+
 # Use capabilities.
 allow fcron_t self:capability { dac_override dac_read_search setgid setuid net_bind_service };
 
@@ -33,13 +36,13 @@
 rw_dir_create_file(fcron_t, fcron_spool_t)
 
 # Read system crontabs
-r_dir_file(fcron_t, system_crond_script_t)
+allow fcron_t system_crond_script_t:file create_file_perms;
 
 # Read /etc/security/cron_context
 allow fcron_t cron_context_t:file r_file_perms;
 
 allow fcron_t etc_t:lnk_file read;
-allow fcron_t etc_t:file r_file_perms;
+allow fcron_t { etc_t resolv_conf_t }:file { read getattr };
 
 allow fcron_t { sysadm_home_dir_t user_home_dir_type }:dir search;
 
@@ -50,6 +53,12 @@
 domain_trans(fcron_t, shell_exec_t, system_crond_t)
 allow fcron_t shell_exec_t:file read;
 
+ifdef(`dpkg.te', `
+can_exec(dpkg_t, crontab_exec_t)
+file_type_auto_trans(dpkg_t, fcron_spool_t, sysadm_cron_spool_t)
+')
+allow sysadm_crontab_t system_crond_script_t:file { setattr rw_file_perms };
+
 # Modutils are now combined, so we can no longer distinguish them.
 # Let crond run the insmod executable in the insmod_t domain.
 ifdef(`modutil.te', `
diff -ruN /tmp/policy/domains/program/fingerd.te policy/domains/program/fingerd.te
--- /tmp/policy/domains/program/fingerd.te	2002-08-23 20:44:18.000000000 +0200
+++ policy/domains/program/fingerd.te	2002-09-07 23:03:06.000000000 +0200
@@ -38,6 +38,8 @@
 can_exec(fingerd_t, { shell_exec_t bin_t sbin_t })
 allow fingerd_t devtty_t:chr_file { read write };
 
+allow fingerd_t { ttyfile ptyfile }:chr_file getattr;
+
 # Use the network.
 can_network(fingerd_t)
 
diff -ruN /tmp/policy/domains/program/hotplug.te policy/domains/program/hotplug.te
--- /tmp/policy/domains/program/hotplug.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/hotplug.te	2002-09-08 11:06:35.000000000 +0200
@@ -32,6 +32,7 @@
 can_exec(hotplug_t, { bin_t sbin_t ls_exec_t shell_exec_t etc_hotplug_t etc_t })
 
 r_dir_file(hotplug_t, usbdevfs_t)
+allow hotplug_t usbdevfs_device_t:file getattr;
 
 allow hotplug_t fs_t:filesystem getattr;
 
diff -ruN /tmp/policy/domains/program/ircd.te policy/domains/program/ircd.te
--- /tmp/policy/domains/program/ircd.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/ircd.te	2002-08-29 00:33:54.000000000 +0200
@@ -18,6 +18,11 @@
 
 log_domain(ircd)
 
+type var_lib_ircd_t, sysadmfile, file_type;
+file_type_auto_trans(ircd_t, var_lib_t, var_lib_ircd_t)
+
+allow ircd_t sysadm_devpts_t:chr_file rw_file_perms;
+
 # Use the network.
 can_network(ircd_t)
 #allow ircd_t self:fifo_file { read write };
@@ -30,8 +35,6 @@
 
 allow ircd_t sbin_t:dir search;
 
-r_dir_file(ircd_t, var_lib_t)
-
 allow ircd_t proc_t:file { getattr read };
 
 # read config files
diff -ruN /tmp/policy/domains/program/kcheckpass.te policy/domains/program/kcheckpass.te
--- /tmp/policy/domains/program/kcheckpass.te	2002-08-26 18:50:43.000000000 +0200
+++ policy/domains/program/kcheckpass.te	2002-09-03 02:28:34.000000000 +0200
@@ -24,6 +24,8 @@
 
 allow kcheckpass_t self:process { fork sigchld };
 
+allow kcheckpass_t devtty_t:chr_file rw_file_perms;
+
 # read config files
 allow kcheckpass_t { etc_t resolv_conf_t }:file { read getattr };
 allow kcheckpass_t etc_t:lnk_file read;
diff -ruN /tmp/policy/domains/program/logrotate.te policy/domains/program/logrotate.te
--- /tmp/policy/domains/program/logrotate.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/logrotate.te	2002-08-31 17:58:11.000000000 +0200
@@ -39,6 +39,7 @@
 
 # Modify /var/log and other log dirs.
 allow logrotate_t logfile:dir rw_dir_perms;
+allow logrotate_t logfile:lnk_file read;
 
 # Create, rename, and truncate log files.
 allow logrotate_t logfile:file create_file_perms;
diff -ruN /tmp/policy/domains/program/mount.te policy/domains/program/mount.te
--- /tmp/policy/domains/program/mount.te	2002-09-09 19:54:12.000000000 +0200
+++ policy/domains/program/mount.te	2002-08-29 00:33:54.000000000 +0200
@@ -37,5 +37,6 @@
 ifdef(`devfsd.te', `
 allow mount_t device_t:filesystem unmount;
 ')
+allow mount_t root_t:filesystem unmount;
 
 
diff -ruN /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-09-09 19:54:12.000000000 +0200
+++ policy/domains/program/mrtg.te	2002-08-28 17:20:05.000000000 +0200
@@ -59,4 +59,5 @@
 dontaudit mrtg_t initrc_var_run_t:file { write lock };
 allow mrtg_t etc_runtime_t:file { getattr read };
 
-dontaudit mrtg_t sysadm_home_dir_t:dir { search read };
+# should not need this!
+allow mrtg_t sysadm_home_dir_t:dir { search read getattr };
diff -ruN /tmp/policy/domains/program/mta.te policy/domains/program/mta.te
--- /tmp/policy/domains/program/mta.te	2002-09-09 19:54:12.000000000 +0200
+++ policy/domains/program/mta.te	2002-08-24 21:36:08.000000000 +0200
@@ -37,5 +37,3 @@
 
 allow system_mail_t privmail:fd use;
 allow system_mail_t privmail:fifo_file rw_file_perms;
-allow system_mail_t mqueue_spool_t:dir rw_dir_perms;
-allow system_mail_t mqueue_spool_t:{ file lnk_file } create_file_perms;
diff -ruN /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/named.te	2002-09-08 10:30:40.000000000 +0200
@@ -16,6 +16,9 @@
 type ndc_t, domain, privlog;
 role sysadm_r types ndc_t;
 
+# named will not start without this!
+allow named_t admin_tty_type:chr_file { read write };
+
 can_exec(named_t, named_exec_t)
 allow named_t sbin_t:dir search;
 
diff -ruN /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-08-26 18:50:43.000000000 +0200
+++ policy/domains/program/postfix.te	2002-09-09 11:15:55.000000000 +0200
@@ -48,6 +48,8 @@
 allow postfix_$1_t resolv_conf_t:file { read getattr };
 allow postfix_$1_t var_t:dir { search getattr };
 
+allow postfix_$1_t tmp_t:dir getattr;
+
 file_type_auto_trans(postfix_$1_t, var_run_t, postfix_var_run_t)
 
 ')dnl
@@ -86,6 +88,7 @@
 allow postfix_master_t privfd:fd use;
 allow postfix_master_t etc_aliases_t:file r_file_perms;
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
+allow postfix_master_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
@@ -122,7 +125,6 @@
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:sock_file rw_file_perms;
 allow postfix_smtpd_t postfix_master_t:unix_stream_socket connectto;
 can_network(postfix_smtpd_t)
-allow postfix_smtpd_t tmp_t:dir getattr;
 
 allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms;
 
@@ -137,7 +139,6 @@
 allow postfix_local_t postfix_spool_t:dir r_dir_perms;
 allow postfix_local_t postfix_spool_t:file rw_file_perms;
 # for .forward - maybe we need a new type for it?
-allow postfix_local_t tmp_t:dir getattr;
 allow postfix_local_t postfix_private_t:dir search;
 allow postfix_local_t postfix_private_t:sock_file rw_file_perms;
 allow postfix_local_t postfix_master_t:unix_stream_socket connectto;
@@ -155,7 +156,6 @@
 allow postfix_cleanup_t postfix_public_t:fifo_file rw_file_perms;
 allow postfix_cleanup_t postfix_private_t:dir search;
 allow postfix_cleanup_t postfix_private_t:sock_file rw_file_perms;
-allow postfix_cleanup_t tmp_t:dir getattr;
 allow postfix_cleanup_t postfix_master_t:unix_stream_socket connectto;
 can_network(postfix_cleanup_t)
 allow postfix_cleanup_t { postfix_spool_bounce_t }:dir r_dir_perms;
@@ -165,7 +165,7 @@
 allow user_mail_domain self:capability dac_override;
 
 define(`postfix_user_domain', `
-postfix_domain($1)
+postfix_domain($1, `$2')
 domain_auto_trans(user_mail_domain, postfix_$1_exec_t, postfix_$1_t)
 in_user_role(postfix_$1_t)
 role sysadm_r types postfix_$1_t;
@@ -202,7 +202,7 @@
 allow postfix_showq_t self:tcp_socket create_socket_perms;
 allow postfix_showq_t ptyfile:chr_file { read write };
 
-postfix_user_domain(postdrop)
+postfix_user_domain(postdrop, `, mta_user_agent')
 allow postfix_postdrop_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_postdrop_t postfix_spool_maildrop_t:file create_file_perms;
 allow postfix_postdrop_t user_mail_domain:unix_stream_socket rw_socket_perms;
diff -ruN /tmp/policy/domains/program/postgresql.te policy/domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-09-09 19:54:14.000000000 +0200
+++ policy/domains/program/postgresql.te	2002-08-28 18:21:05.000000000 +0200
@@ -15,6 +15,8 @@
 # gross hack
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
 ')
+# a grosser hack
+allow postgresql_t etc_t:file setattr;
 
 dontaudit postgresql_t { sysadm_home_dir_t var_spool_t }:dir search;
 
@@ -22,7 +24,7 @@
 
 type etc_postgresql_t, file_type, sysadmfile;
 type postgresql_db_t, file_type, sysadmfile;
-type postgresql_log_t, file_type, sysadmfile;
+type postgresql_log_t, file_type, sysadmfile, logfile;
 
 file_type_auto_trans(postgresql_t, var_log_t, postgresql_log_t)
 
@@ -52,7 +54,7 @@
 
 # read config files
 allow postgresql_t { etc_t etc_runtime_t }:{ file lnk_file } { read getattr };
-r_dir_file(postgresql_t, etc_postgresql_t)
+r_dir_file({ initrc_t postgresql_t }, etc_postgresql_t)
 
 allow postgresql_t etc_t:dir rw_dir_perms;
 allow postgresql_t etc_t:lnk_file create;
@@ -68,7 +70,7 @@
 allow postgresql_t bin_t:lnk_file read;
 allow postgresql_t postgresql_exec_t:lnk_file read;
 
-allow postgresql_t initrc_var_run_t:file { read };
+allow postgresql_t initrc_var_run_t:file { read write lock };
 
 allow postgresql_t self:sem rw_sem_perms;
 
diff -ruN /tmp/policy/domains/program/pppd.te policy/domains/program/pppd.te
--- /tmp/policy/domains/program/pppd.te	2002-09-09 19:54:14.000000000 +0200
+++ policy/domains/program/pppd.te	2002-09-09 22:31:18.000000000 +0200
@@ -41,7 +41,7 @@
 allow postfix_postqueue_t pppd_t:process sigchld;')
 
 # allow running ip-up and ip-down scripts and running chat.
-can_exec(pppd_t, { shell_exec_t bin_t sbin_t etc_t })
+can_exec(pppd_t, { shell_exec_t bin_t sbin_t etc_t ifconfig_exec_t })
 allow pppd_t { bin_t sbin_t }:dir search;
 allow pppd_t bin_t:lnk_file read;
 
diff -ruN /tmp/policy/domains/program/snmpd.te policy/domains/program/snmpd.te
--- /tmp/policy/domains/program/snmpd.te	2002-08-26 18:50:43.000000000 +0200
+++ policy/domains/program/snmpd.te	2002-08-29 00:33:54.000000000 +0200
@@ -24,7 +24,7 @@
 allow snmpd_t etc_snmpd_t:file { getattr read };
 
 type var_lib_snmpd_t, file_type, sysadmfile;
-file_type_auto_trans(snmpd_t, var_lib_t, var_lib_snmpd_t)
+file_type_auto_trans(snmpd_t, { var_lib_t usr_t }, var_lib_snmpd_t)
 
 can_udp_send(sysadm_t, snmpd_t)
 can_udp_send(snmpd_t, sysadm_t)
@@ -40,5 +40,3 @@
 allow snmpd_t proc_t:file r_file_perms;
 allow snmpd_t fs_t:filesystem getattr;
 allow snmpd_t self:file { getattr read };
-
-allow snmpd_t var_lib_t:dir r_dir_perms;
diff -ruN /tmp/policy/domains/program/sxid.te policy/domains/program/sxid.te
--- /tmp/policy/domains/program/sxid.te	2002-08-23 20:44:20.000000000 +0200
+++ policy/domains/program/sxid.te	2002-09-08 11:03:31.000000000 +0200
@@ -38,6 +38,9 @@
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
 allow sxid_t { proc_t self }:file { read getattr };
+ifdef(`mta.te', `
+allow system_mail_t sxid_t:file { read getattr };
+')
 allow sxid_t { sysctl_kernel_t sysctl_t }:dir search;
 allow sxid_t sysctl_kernel_t:file read;
 allow sxid_t devtty_t:chr_file rw_file_perms;
diff -ruN /tmp/policy/domains/program/sysstat.te policy/domains/program/sysstat.te
--- /tmp/policy/domains/program/sysstat.te	2002-09-09 19:54:15.000000000 +0200
+++ policy/domains/program/sysstat.te	2002-09-08 11:31:17.000000000 +0200
@@ -24,7 +24,9 @@
 
 allow sysstat_t devtty_t:chr_file rw_file_perms;
 # for mtab
-allow sysstat_t etc_runtime_t:file r_file_perms;
+allow sysstat_t etc_runtime_t:file { read getattr };
+# for fstab
+allow sysstat_t etc_t:file { read getattr };
 
 dontaudit sysstat_t sysadm_home_dir_t:dir r_dir_perms;
 
@@ -36,11 +38,9 @@
 allow sysstat_t var_log_t:dir r_dir_perms;
 allow sysstat_t var_log_sysstat_t:dir rw_dir_perms;
 allow sysstat_t var_log_sysstat_t:file create_file_perms;
-#allow domain var_log_sysstat_t:dir r_dir_perms;
-#allow domain var_log_sysstat_t:file r_file_perms;
 
 allow sysstat_t etc_t:dir r_dir_perms;
-allow sysstat_t etc_t:lnk_file r_file_perms;
+allow sysstat_t etc_t:lnk_file read;
 
 # Inherit and use descriptors from cron.
 allow sysstat_t crond_t:fd use;
@@ -50,16 +50,12 @@
 
 # get info from /proc
 allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t }:dir r_dir_perms;
-allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t }:file r_file_perms;
-
-# read config files
-#allow sysstat_t { etc_t etc_sysstat_t }:{ file lnk_file } r_file_perms;
+allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t }:file { read getattr };
 
 domain_auto_trans({ system_crond_t initrc_t }, sysstat_exec_t, sysstat_t)
 allow sysstat_t init_t:fd use;
 allow sysstat_t console_device_t:chr_file { read write };
 
-#allow sysstat_t { root_t etc_t }:dir r_dir_perms;
 uses_shlib(sysstat_t)
 
 allow system_crond_t var_log_sysstat_t:dir { write remove_name };
diff -ruN /tmp/policy/domains/program/tftpd.te policy/domains/program/tftpd.te
--- /tmp/policy/domains/program/tftpd.te	2002-09-09 19:54:16.000000000 +0200
+++ policy/domains/program/tftpd.te	2002-08-29 00:33:54.000000000 +0200
@@ -18,6 +18,9 @@
 # Use the network.
 can_network(tftpd_t)
 allow tftpd_t tftp_port_t:udp_socket name_bind;
+ifdef(`inetd.te', `
+allow inetd_t tftp_port_t:udp_socket name_bind;
+')
 allow tftpd_t self:unix_dgram_socket create_socket_perms;
 allow tftpd_t self:unix_stream_socket create_stream_socket_perms;
 
diff -ruN /tmp/policy/domains/program/vmware.te policy/domains/program/vmware.te
--- /tmp/policy/domains/program/vmware.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/vmware.te	2002-09-04 13:28:48.000000000 +0200
@@ -83,8 +83,10 @@
 # Rules added to kmod_t domain for VMWare to start up
 #
 # VMWare need access to pcmcia devices for network
+ifdef(`cardmgr.te', `
 allow kmod_t cardmgr_var_lib_t:dir { getattr search };
 allow kmod_t cardmgr_var_lib_t:file { getattr ioctl read };
+')
 
 # Vmware create network devices
 allow kmod_t kmod_t:capability { net_admin };
diff -ruN /tmp/policy/domains/program/xdm.te policy/domains/program/xdm.te
--- /tmp/policy/domains/program/xdm.te	2002-09-09 19:54:16.000000000 +0200
+++ policy/domains/program/xdm.te	2002-08-31 17:49:18.000000000 +0200
@@ -131,7 +131,7 @@
 dontaudit xdm_t sysadm_tty_device_t:chr_file { read write };
 
 # Do not audit access to /root
-dontaudit xdm_t sysadm_home_t:dir search;
+dontaudit xdm_t sysadm_home_dir_t:dir search;
 
 # Do not audit user access to the X log files due to file handle inheritance
 dontaudit unpriv_userdomain xserver_var_log_t:file append;
diff -ruN /tmp/policy/file_contexts/program/fcron.fc policy/file_contexts/program/fcron.fc
--- /tmp/policy/file_contexts/program/fcron.fc	2002-08-23 20:44:20.000000000 +0200
+++ policy/file_contexts/program/fcron.fc	2002-09-03 02:28:59.000000000 +0200
@@ -2,4 +2,4 @@
 /usr/sbin/fcron			system_u:object_r:fcron_exec_t
 /var/spool/fcron		system_u:object_r:fcron_spool_t
 /var/spool/fcron/.*		<<none>>
-/var/spool/fcron/root.orig	system_u:object_r:sysadm_cron_spool_t
+/var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
diff -ruN /tmp/policy/file_contexts/program/ipsec.fc policy/file_contexts/program/ipsec.fc
--- /tmp/policy/file_contexts/program/ipsec.fc	2002-08-23 21:04:28.000000000 +0200
+++ policy/file_contexts/program/ipsec.fc	2002-08-27 23:17:32.000000000 +0200
@@ -15,4 +15,4 @@
 /usr/local/lib/ipsec/spi	system_u:object_r:ipsec_exec_t
 /usr/sbin/ipsec			system_u:object_r:ipsec_mgmt_exec_t
 /usr/local/sbin/ipsec		system_u:object_r:ipsec_mgmt_exec_t
-/var/run/ipsec.info            system_u:object_r:ipsec_mgmt_var_run_t
+/var/run/ipsec.info		system_u:object_r:ipsec_var_run_t
diff -ruN /tmp/policy/file_contexts/program/ircd.fc policy/file_contexts/program/ircd.fc
--- /tmp/policy/file_contexts/program/ircd.fc	2002-08-23 20:44:20.000000000 +0200
+++ policy/file_contexts/program/ircd.fc	2002-08-29 00:34:21.000000000 +0200
@@ -2,3 +2,4 @@
 /usr/sbin/(dancer-)?ircd	system_u:object_r:ircd_exec_t
 /etc/(dancer-)?ircd(/.*)?	system_u:object_r:etc_ircd_t
 /var/log/(dancer-)?ircd(/.*)?	system_u:object_r:ircd_log_t
+/var/lib/dancer-ircd(/.*)?	system_u:object_r:var_lib_ircd_t
diff -ruN /tmp/policy/file_contexts/program/pppd.fc policy/file_contexts/program/pppd.fc
--- /tmp/policy/file_contexts/program/pppd.fc	2002-07-03 22:26:22.000000000 +0200
+++ policy/file_contexts/program/pppd.fc	2002-09-08 19:20:23.000000000 +0200
@@ -1,4 +1,8 @@
 # pppd
 /usr/sbin/pppd			system_u:object_r:pppd_exec_t
+/usr/sbin/ipppd			system_u:object_r:pppd_exec_t
 /dev/ppp			system_u:object_r:ppp_device_t
+/dev/ippp.*			system_u:object_r:ppp_device_t
 /var/run/pppd.tdb		system_u:object_r:var_run_pppd_t
+/etc/ppp/.*secrets		system_u:object_r:pppd_secret_t
+/var/run/ipppd.*pid		system_u:object_r:var_run_pppd_t
diff -ruN /tmp/policy/file_contexts/program/snmpd.fc policy/file_contexts/program/snmpd.fc
--- /tmp/policy/file_contexts/program/snmpd.fc	2002-08-26 18:50:44.000000000 +0200
+++ policy/file_contexts/program/snmpd.fc	2002-08-29 00:34:21.000000000 +0200
@@ -2,3 +2,4 @@
 /usr/sbin/snmp(trap)?d		system_u:object_r:snmpd_exec_t
 /var/lib/snmp(/.*)?		system_u:object_r:var_lib_snmpd_t
 /etc/snmp/snmp(trap)?d.conf	system_u:object_r:etc_snmpd_t
+/usr/share/snmp/mibs/.index	system_u:object_r:var_lib_snmpd_t
diff -ruN /tmp/policy/file_contexts/program/vmware.fc policy/file_contexts/program/vmware.fc
--- /tmp/policy/file_contexts/program/vmware.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/vmware.fc	2002-08-24 22:59:34.000000000 +0200
@@ -30,6 +30,7 @@
 /dev/vmnet7                     system_u:object_r:vmware_device_t
 /dev/vmnet8                     system_u:object_r:vmware_device_t
 /dev/vmnet9                     system_u:object_r:vmware_device_t
+/dev/plex86			system_u:object_r:vmware_device_t
 
 /etc/vmware.*(/.*)?             system_u:object_r:vmware_sys_conf_t
 /usr/lib/vmware/config          system_u:object_r:vmware_sys_conf_t
diff -ruN /tmp/policy/macros/admin_macros.te policy/macros/admin_macros.te
--- /tmp/policy/macros/admin_macros.te	2002-09-09 19:54:23.000000000 +0200
+++ policy/macros/admin_macros.te	2002-08-29 00:35:40.000000000 +0200
@@ -17,7 +17,11 @@
 # Inherit rules for ordinary users.
 user_domain($1)
 
+rw_dir_create_file($1_t, policy_config_t)
+
+ifdef(`crond.te', `
 allow $1_crond_t var_log_t:file r_file_perms;
+')
 
 # Allow system log read
 allow $1_t kernel_t:system syslog_read;
diff -ruN /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-09-09 19:54:23.000000000 +0200
+++ policy/macros/global_macros.te	2002-09-10 00:12:18.000000000 +0200
@@ -193,6 +193,11 @@
 allow $1 $2:{ file lnk_file } create_file_perms;
 ')
 
+define(`create_dir_notdevfile', `
+allow $1 $2:dir create_dir_perms;
+allow $1 $2:notdevfile_class_set create_file_perms;
+')
+
 define(`create_append_log_file', `
 allow $1 $2:dir { read getattr access search add_name write };
 allow $1 $2:file { create ioctl getattr access setattr append link };
@@ -736,7 +741,9 @@
 allow $1 boot_t:dir { search getattr };
 allow $1 boot_t:file getattr;
 allow $1 system_map_t:{ file lnk_file } r_file_perms;
+ifdef(`rpm.te', `
 allow $1 boot_runtime_t:{ file lnk_file } r_file_perms;
+')
 allow $1 boot_t:lnk_file read;
 
 # Read /etc.
@@ -1016,3 +1023,4 @@
 uses_shlib($1_t)
 allow $1_t etc_t:dir r_dir_perms;
 ')
+
diff -ruN /tmp/policy/macros/program/chroot_macros.te policy/macros/program/chroot_macros.te
--- /tmp/policy/macros/program/chroot_macros.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/macros/program/chroot_macros.te	2002-09-10 00:11:51.000000000 +0200
@@ -0,0 +1,129 @@
+
+# macro for chroot environments
+# Author Russell Coker
+
+# chroot(initial_domain, basename, role, tty_device_type)
+define(`chroot', `
+
+ifelse(`$1', `initrc', `
+define(`chroot_role', `system_r')
+define(`chroot_tty_device', `{ sysadm_devpts_t sysadm_tty_device_t }')
+define(`chroot_mount_domain', `mount_t')
+', `
+define(`chroot_role', `$1_r')
+define(`chroot_tty_device', `{ $1_devpts_t $1_tty_device_t }')
+
+# allow mounting /proc and /dev
+ifdef(`$1_mount_def', `', `
+mount_domain($1, $1_mount)
+role chroot_role types $1_mount_t;
+')
+define(`chroot_mount_domain', `$1_mount_t')
+ifdef(`ssh.te', `
+can_tcp_connect($1_ssh_t, $2_t)
+')dnl end ssh
+')dnl end ifelse initrc
+
+# types for read-only and read-write files in the chroot
+type $2_ro_t, file_type, sysadmfile, home_type, user_home_type;
+type $2_rw_t, file_type, sysadmfile, home_type, user_home_type;
+# type like $2_ro_t but that triggers a transition from $2_super_t to $2_t
+# when you execute it
+type $2_dropdown_t, file_type, sysadmfile, home_type, user_home_type;
+
+allow chroot_mount_domain { $2_rw_t $2_ro_t }:dir { getattr search mounton };
+allow chroot_mount_domain { $2_rw_t $2_ro_t }:file { getattr mounton };
+
+# entry point for $2_super_t
+type $2_super_entry_t, file_type, sysadmfile, home_type, user_home_type;
+# $2_t is the base domain, has full access to $2_rw_t files
+type $2_t, domain, userdomain, unpriv_userdomain;
+# $2_super_t is the super-chroot domain, can also write to $2_ro_t
+# but still can not access outside the chroot
+type $2_super_t, domain, userdomain, unpriv_userdomain;
+allow $2_super_t chroot_tty_device:chr_file rw_file_perms;
+
+ifdef(`$1_chroot_def', `', `
+dnl can not have this defined twice
+define(`$1_chroot_def')
+
+allow chroot_mount_domain { proc_t device_t fs_t }:filesystem { mount unmount };
+
+# $1_chroot_t is the domain for /usr/sbin/chroot
+type $1_chroot_t, domain;
+
+# allow $1_chroot_t to write to the tty device
+allow $1_chroot_t chroot_tty_device:chr_file rw_file_perms;
+allow $1_chroot_t privfd:fd use;
+allow { $1_chroot_t $2_t $2_super_t } $1_t:fd use;
+
+role chroot_role types $1_chroot_t;
+uses_shlib($1_chroot_t)
+allow $1_chroot_t self:capability sys_chroot;
+allow $1_t $1_chroot_t:dir { search getattr read };
+allow $1_t $1_chroot_t:{ file lnk_file } { read getattr };
+domain_auto_trans($1_t, chroot_exec_t, $1_chroot_t)
+allow $1_chroot_t fs_t:filesystem getattr;
+')dnl End conditional
+
+role chroot_role types { $2_t $2_super_t };
+
+# allow ps to show processes and allow killing them
+allow $1_t { $2_super_t $2_t }:dir { search getattr read };
+allow $1_t { $2_super_t $2_t }:{ file lnk_file } { read getattr };
+allow $1_t { $2_super_t $2_t }:process signal_perms;
+allow $2_super_t $2_t:dir { search getattr read };
+allow $2_super_t $2_t:{ file lnk_file } { read getattr };
+allow { $1_t $2_super_t } $2_t:process { signal_perms ptrace };
+allow $1_t $2_super_t:process { signal_perms ptrace };
+allow sysadm_t { $2_super_t $2_t }:process { signal_perms ptrace };
+
+allow { $2_super_t $2_t } { fs_t device_t }:filesystem getattr;
+allow { $2_super_t $2_t } device_t:dir { search getattr };
+allow { $2_super_t $2_t } devtty_t:chr_file rw_file_perms;
+allow { $2_super_t $2_t } random_device_t:chr_file r_file_perms;
+allow { $2_super_t $2_t } self:capability { fowner chown fsetid setgid setuid net_bind_service sys_tty_config };
+allow $2_super_t self:capability sys_ptrace;
+
+can_tcp_connect($2_super_t, $2_t)
+allow { $2_super_t $2_t } $2_rw_t:sock_file create_file_perms;
+
+allow { $2_super_t $2_t } devpts_t:dir { getattr search read };
+
+# quiet ps and killall
+dontaudit { $2_super_t $2_t } domain:dir { search getattr };
+
+# allow $2_t to write to the owner tty device (should remove this)
+allow $2_t chroot_tty_device:chr_file { read write };
+
+r_dir_file($1_chroot_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
+can_exec($2_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
+can_exec($2_super_t, { $2_ro_t $2_super_entry_t })
+create_dir_notdevfile($2_super_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
+# $2_super_t transitions to $2_t when it executes
+# any file that $2_t can write
+domain_auto_trans($2_super_t, { $2_rw_t $2_dropdown_t }, $2_t)
+allow $1_chroot_t { $2_ro_t $2_rw_t }:lnk_file read;
+r_dir_file($2_t, { $2_ro_t $2_super_entry_t $2_dropdown_t })
+create_dir_notdevfile($2_t, $2_rw_t)
+allow $2_t $2_rw_t:fifo_file create_file_perms;
+allow $2_t $2_ro_t:fifo_file rw_file_perms;
+allow { $1_t $2_super_t } { $2_rw_t $2_ro_t }:fifo_file create_file_perms;
+create_dir_notdevfile($1_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
+can_exec($1_t, { $2_ro_t $2_dropdown_t })
+domain_auto_trans($1_chroot_t, { $2_ro_t $2_rw_t $2_dropdown_t }, $2_t)
+domain_auto_trans_read($1_chroot_t, $2_super_entry_t, $2_super_t)
+allow { $1_t $2_super_t } { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t }:{ dir notdevfile_class_set } { relabelfrom relabelto };
+general_proc_read_access({ $2_t $2_super_t })
+general_domain_access({ $2_t $2_super_t })
+can_create_pty($2)
+can_create_pty($2_super)
+can_network({ $2_t $2_super_t })
+allow { $2_t $2_super_t } null_device_t:chr_file rw_file_perms;
+allow $2_super_t { $2_rw_t $2_ro_t }:{ dir file } mounton;
+allow { $2_t $2_super_t } self:capability { dac_override kill };
+
+undefine(`chroot_role')
+undefine(`chroot_tty_device')
+undefine(`chroot_mount_domain')
+')
diff -ruN /tmp/policy/macros/program/crontab_macros.te policy/macros/program/crontab_macros.te
--- /tmp/policy/macros/program/crontab_macros.te	2002-09-09 19:54:24.000000000 +0200
+++ policy/macros/program/crontab_macros.te	2002-09-09 11:16:26.000000000 +0200
@@ -31,7 +31,7 @@
 every_domain($1_crontab_t)
 
 # Use capabilities
-allow $1_crontab_t $1_crontab_t:capability { setuid chown dac_override net_bind_service };
+allow $1_crontab_t $1_crontab_t:capability { setuid setgid chown dac_override net_bind_service };
 
 # Type for temporary files.
 type $1_crontab_tmp_t, file_type, sysadmfile, tmpfile;
@@ -45,7 +45,14 @@
 ifdef(`fcron.te', `
 file_type_auto_trans($1_crontab_t, fcron_spool_t, $1_cron_spool_t)
 allow fcron_t $1_cron_spool_t:file create_file_perms;
-')
+# fcron wants an instant update of a crontab change for the administrator
+ifelse(`$1', `sysadm', `
+allow $1_crontab_t fcron_t:process signal;
+', `
+dontaudit $1_crontab_t fcron_t:process signal;
+')dnl end ifelse
+')dnl end ifdef fcron
+
 # crontab signals crond by updating the mtime on the spooldir
 allow $1_crontab_t cron_spool_t:dir setattr;
 # Allow crond to read those crontabs in cron spool.
diff -ruN /tmp/policy/macros/program/mount_macros.te policy/macros/program/mount_macros.te
--- /tmp/policy/macros/program/mount_macros.te	2002-08-23 20:44:20.000000000 +0200
+++ policy/macros/program/mount_macros.te	2002-08-29 00:35:52.000000000 +0200
@@ -36,7 +36,7 @@
 file_type_auto_trans($2_t, etc_t, etc_runtime_t)
 
 # Access the terminal.
-allow $2_t $1_tty_device_t:chr_file { getattr read write };
+allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
 allow $2_t $1_devpts_t:chr_file { getattr read write };
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 ')
diff -ruN /tmp/policy/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2002-09-09 19:54:24.000000000 +0200
+++ policy/macros/program/xserver_macros.te	2002-08-31 17:50:44.000000000 +0200
@@ -20,8 +20,8 @@
 # FIXME!  The X server requires far too many privileges.
 #
 undefine(`xserver_domain')
-ifdef(`xserver.te',
-`
+ifdef(`xserver.te', `
+
 define(`xserver_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_xserver_t, domain, privlog, privmem;
@@ -106,8 +106,11 @@
 
 # Communicate via System V shared memory.
 allow $1_xserver_t $1_t:shm rw_shm_perms;
-ifelse($1, xdm, , `
-allow $1_xserver_t $1_tmpfs_t:file rw_file_perms;')
+allow $1_t $1_xserver_t:shm rw_shm_perms;
+ifelse($1, xdm, `', `
+allow $1_xserver_t $1_tmpfs_t:file rw_file_perms;
+allow $1_t $1_xserver_tmpfs_t:file rw_file_perms;
+')
 
 # David Wheeler says he needs the following permission
 # for his X server.  Something is wrong here - the shared
@@ -128,7 +131,7 @@
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
 ', `
 # Access the home directory.
-allow $1_xserver_t $1_home_dir_t:dir { read search };
+allow $1_xserver_t $1_home_dir_t:dir { getattr read search };
 allow $1_xserver_t $1_home_t:dir r_dir_perms;
 allow $1_xserver_t $1_home_t:file r_file_perms;')
 
diff -ruN /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-09-09 19:54:23.000000000 +0200
+++ policy/macros/user_macros.te	2002-08-31 17:51:17.000000000 +0200
@@ -210,9 +210,11 @@
 allow $1_t xdm_xserver_tmp_t:sock_file { read write };
 allow $1_t xdm_xserver_tmp_t:dir search;
 
+ifelse(`$1', sysadm, `', `
 # gross hack - should not need this
 file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_t, file)
-')
+')dnl end ifelse sysadm
+')dnl end ifdef xdm.te
 
 # Access the sound device.
 allow $1_t sound_device_t:chr_file { getattr read write ioctl };

--------------Boundary-00=_R617SS8LUJ9I0NUXB1CF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
