Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3Q7W5I4017639
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 03:32:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3Q7VvVf024666
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 07:31:58 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3Q7VK4D024657
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 07:31:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: policy patches
Date: Sat, 26 Apr 2003 17:30:51 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rWjq+zc4tzKKGja"
Message-Id: <200304261730.51031.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_rWjq+zc4tzKKGja
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

makefile.diff is a Makefile patch for jfs and jffs2.  jffs2 is probably 
redundant, but does no harm (and it's good to demonstrate that a large number 
of file systems are supported).

global.diff is a patch to global_macros.te.  This contains some things that 
are relied on by later patches.  It allows can_exec_any() to read symlinks in 
/etc because in Debian /usr/bin has many symlinks to symlinks in /etc for the 
case where several packages can provide the same program.  Also it removes 
every_domain(), which will break some other policy.  I've got patches for all 
the other domains, I'll post them here shortly.

passwd.diff makes two separate domains for changing password, one for the user 
that's just for "spasswd", and the other for the administrator that allows 
everything that's needed for svipw etc.  Also it merges useradd.te and 
groupadd.te into the same file with macros and removes every_domain() from 
chkpwd_macros.te .

simple.diff contains a bunch of small changes that aren't particularly 
noteworthy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_rWjq+zc4tzKKGja
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="makefile.diff"

diff -ru /tmp/policy/Makefile ./Makefile
--- /tmp/policy/Makefile	2003-04-26 16:11:43.000000000 +1000
+++ ./Makefile	2003-03-28 12:39:33.000000000 +1100
@@ -103,10 +104,10 @@
 	cat domains/*.te domains/misc/*.te domains/program/*.te > $@
 
 relabel:  $(FC) $(SETFILES)
-	$(SETFILES) $(FC) `mount | awk '/(ext[23]|reiserfs)/{print $$3}'`
+	$(SETFILES) $(FC) `mount | awk '/(ext[23]|reiserfs|jfs|jffs2)/{print $$3}'`
 
 reset:  $(FC) $(SETFILES)
-	$(SETFILES) -R $(FC) `mount | awk '/(ext[23]|reiserfs)/{print $$3}'`
+	$(SETFILES) -R $(FC) `mount | awk '/(ext[23]|reiserfs|jfs|jffs2)/{print $$3}'`
 
 $(FC): $(FCFILES) file_contexts/program 
 	cat $(FCFILES) > $@

--Boundary-00=_rWjq+zc4tzKKGja
Content-Type: text/x-diff;
  charset="us-ascii";
  name="global.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="global.diff"

diff -ru /tmp/policy/macros/global_macros.te ./macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-04-26 16:11:45.000000000 +1000
+++ ./macros/global_macros.te	2003-04-25 13:28:16.000000000 +1000
@@ -319,7 +321,7 @@
 #
 define(`can_exec_any',`
 allow $1 { bin_t sbin_t lib_t etc_t }:dir r_dir_perms;
-allow $1 { bin_t sbin_t }:lnk_file read;
+allow $1 { bin_t sbin_t etc_t }:lnk_file { getattr read };
 uses_shlib($1)
 can_exec($1, etc_t)
 can_exec($1, lib_t)
@@ -350,8 +352,12 @@
 allow $1 $3:notdevfile_class_set create_file_perms;
 allow $1 $3:dir create_dir_perms;
 ', `
+ifelse(`$4', `dir', `
+allow $1 $3:$4 create_dir_perms;
+', `
 allow $1 $3:$4 create_file_perms;
-')
+')dnl end if dir
+')dnl end if param 4 specified
 
 ')
 
@@ -525,30 +531,41 @@
 
 ##################################
 #
+# base_pty_perms(domain_prefix)
+#
+# Base permissions used for can_create_pty() and can_create_other_pty()
+#
+define(`base_pty_perms', `
+# Access the pty master multiplexer.
+allow $1_t ptmx_t:chr_file rw_file_perms;
+
+ifdef(`devfsd.te', `
+allow $1_t device_t:filesystem getattr;
+')
+allow $1_t devpts_t:filesystem getattr;
+
+# allow searching /dev/pts
+allow $1_t devpts_t:dir { getattr search };
+')
+
+##################################
+#
 # can_create_pty(domain_prefix, attributes)
 #
 # Permissions for creating ptys.
 #
 define(`can_create_pty',`
-
+base_pty_perms($1)
 type $1_devpts_t, file_type, sysadmfile, ptyfile $2;
 
 # Allow the pty to be associated with the file system.
 allow $1_devpts_t devpts_t:filesystem associate;
 
-# Access the pty master multiplexer.
-allow $1_t ptmx_t:chr_file rw_file_perms;
-
 # Label pty files with a derived type.
 type_transition $1_t devpts_t:chr_file $1_devpts_t;
 
 # Read and write my pty files.
 allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
-
-ifdef(`devfsd.te', `
-allow $1_t device_t:filesystem getattr;
-')
-
 ')
 
 
@@ -559,20 +576,12 @@
 # Permissions for creating ptys for another domain.
 #
 define(`can_create_other_pty',`
-
-# Access the pty master multiplexer.
-allow $1_t ptmx_t:chr_file rw_file_perms;
-
+base_pty_perms($1)
 # Label pty files with a derived type.
 type_transition $1_t devpts_t:chr_file $2_devpts_t;
 
 # Read and write pty files.
 allow $1_t $2_devpts_t:chr_file { setattr rw_file_perms };
-
-ifdef(`devfsd.te', `
-allow $1_t device_t:filesystem getattr;
-')
-
 ')
 
 
@@ -590,7 +599,9 @@
 # Grant permissions within the domain.
 # This includes permissions to processes, /proc/PID files,
 # file descriptors, pipes, Unix sockets, and System V IPC objects
-# labeled with the domain.
+# labeled with the domain.  It also includes permissions to
+# send SIGCHLD to init and to use descriptors created by certain
+# domains.
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
@@ -617,6 +628,11 @@
 allow $1 self:msgq rw_msgq_perms;
 allow $1 self:shm  rw_shm_perms;
 
+# Use descriptors created by login, sshd, or newrole.
+allow $1 privfd:fd use;
+
+# Use descriptors created by mount (e.g. NFS).
+allow $1 mount_t:fd use;
 ')
 
 #
@@ -815,27 +829,10 @@
 allow $1 usbdevfs_t:dir r_dir_perms;
 allow $1 usbdevfs_t:{ file lnk_file } r_file_perms;
 allow $1 usbdevfs_device_t:file getattr;
-')
 
-#
-# general_file_write_access(domain)
-#
-# Grant write permissions to a small set of system file types, e.g. 
-# /dev/tty, /dev/null, etc.
-#
-# For shared directories like /tmp, each domain should have its own derived
-# type (with a file_type_auto_trans rule) for files created in the shared
-# directory.
-#
-define(`general_file_write_access',`
-errprint(`m4: '__file__:__line__: `Warning:  general_file_write_access is deprecated.
-')
-# Read and write /dev/tty and /dev/null.
-allow $1 devtty_t:chr_file rw_file_perms;
-allow $1 { null_device_t zero_device_t }:chr_file rw_file_perms;
-
-# Do not audit write denials to /etc/ld.so.cache.
-dontaudit $1 ld_so_cache_t:file write;
+# Read PID files in /var/run.  pidfile is a type attribute for 
+# all types used for such files.
+allow $1 pidfile:file r_file_perms;
 ')
 
 #
@@ -875,33 +872,6 @@
 
 ')
 
-################################
-#
-# every_domain(domain)
-#
-# Grant permissions common to most domains.
-#
-# This macro replaces the rules formerly located in domains/every.te.
-# An every_domain macro has been inserted into each domain .te file
-# for each domain defined within that file.  If you want a new domain
-# to inherit these rules, then you can likewise use this macro in
-# your new domain .te file.  However, for least privilege purposes, you 
-# may want to consider using macros or individual rules that only include 
-# a subset of these permissions for your new domain.  This macro has already 
-# been partitioned into a few subsets, with corresponding macros defined 
-# above and used in defining this macro.  
-#
-define(`every_domain',`
-errprint(`m4: '__file__:__line__: `Warning:  every_domain is deprecated.
-')
-# Grant the permissions common to the test domains.
-every_test_domain($1)
-
-# Grant permissions needed to create TCP and UDP sockets and 
-# to access the network.
-can_network($1)
-')
-
 #######################
 # daemon_base_domain(domain_prefix, attribs)
 #
@@ -937,12 +907,16 @@
 allow $1_t initrc_devpts_t:chr_file rw_file_perms;
 ')dnl
 
+define(`var_run_domain', `
+type $1_var_run_t alias var_run_$1_t, file_type, sysadmfile, pidfile;
+file_type_auto_trans($1_t, var_run_t, $1_var_run_t, file)
+')
+
 define(`daemon_domain', `
 daemon_base_domain($1, `$2')
 # Create pid file.
 allow $1_t var_t:dir { getattr search };
-type var_run_$1_t, file_type, sysadmfile, pidfile;
-file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
+var_run_domain($1)
 
 allow $1_t devtty_t:chr_file rw_file_perms;
 
@@ -951,6 +925,8 @@
 
 # for df
 allow $1_t fs_type:filesystem getattr;
+
+r_dir_file($1_t, locale_t)
 ')dnl
 
 define(`uses_authbind',
@@ -984,8 +960,7 @@
 allow $2_t { self proc_t }:dir r_dir_perms;
 allow $2_t { self proc_t }:lnk_file read;
 
-allow $2_t device_t:dir { getattr search };
-allow $2_t null_device_t:chr_file rw_file_perms;
+allow $2_t device_t:dir getattr;
 ')
 
 
@@ -995,8 +970,8 @@
 ')
 
 define(`var_lib_domain', `
-type var_lib_$1_t, file_type, sysadmfile;
-file_type_auto_trans($1_t, var_lib_t, var_lib_$1_t)
+type $1_var_lib_t, file_type, sysadmfile;
+file_type_auto_trans($1_t, var_lib_t, $1_var_lib_t)
 ')
 
 define(`log_domain', `

--Boundary-00=_rWjq+zc4tzKKGja
Content-Type: text/x-diff;
  charset="us-ascii";
  name="passwd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="passwd.diff"

diff -ru /tmp/policy/assert.te ./assert.te
--- /tmp/policy/assert.te	2003-03-29 08:38:54.000000000 +1100
+++ ./assert.te	2003-04-23 19:52:12.000000000 +1000
@@ -111,9 +111,11 @@
 # entrypoint type and can only execute the dynamic loader
 # and the ordinary passwd program without a transition to another domain.
 #
-ifdef(`passwd.te',
-`neverallow passwd_t ~{ admin_passwd_exec_t passwd_exec_t }:file entrypoint;
-neverallow passwd_t ~{ bin_t sbin_t shell_exec_t ld_so_t passwd_real_exec_t }:file execute_no_trans;')
+ifdef(`passwd.te', `
+neverallow passwd_t ~{ passwd_exec_t }:file entrypoint;
+neverallow sysadm_passwd_t ~{ admin_passwd_exec_t }:file entrypoint;
+neverallow { passwd_t sysadm_passwd_t } ~{ bin_t sbin_t shell_exec_t ld_so_t passwd_real_exec_t }:file execute_no_trans;
+')
 
 #
 # Verify that only the admin domains and initrc_t have avc_toggle.
diff -ru /tmp/policy/domains/program/groupadd.te ./domains/program/groupadd.te
--- /tmp/policy/domains/program/groupadd.te	2003-04-08 06:25:34.000000000 +1000
+++ ./domains/program/groupadd.te	2003-04-22 19:42:08.000000000 +1000
@@ -1,60 +0,0 @@
-#DESC Groupadd - Manage system groups
-#
-# Authors:  David Caplan, dac@tresys.com
-#	    (Based on useradd.te by Chris Vance <cvance@tislabs.com>)
-#
-
-#################################
-#
-# Rules for the groupadd_t domain.
-#
-# groupadd_t is the domain of the groupadd/mod/del programs when
-# executed through the sgroupadd/mod/del wrapper.
-type groupadd_t, domain, privlog, auth, privowner;
-role sysadm_r types groupadd_t;
-
-general_domain_access(groupadd_t)
-uses_shlib(groupadd_t)
-
-type groupadd_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(sysadm_t, groupadd_exec_t, groupadd_t )
-
-# Use capabilities.
-# need more if users can run gpasswd
-allow groupadd_t groupadd_t:capability { dac_override };
-
-# Allow access to context for shadow file
-allow groupadd_t security_t:security { context_to_sid };
-
-# Inherit and use descriptors from login.
-allow groupadd_t privfd:fd use;
-
-# Execute /usr/sbin/{groupadd,groupdel,groupmod}, /usr/bin/gpasswd.
-allow groupadd_t { bin_t sbin_t }:dir r_dir_perms;
-can_exec(groupadd_t, { sbin_t bin_t })
-
-# Update /etc/shadow and /etc/passwd
-file_type_auto_trans(groupadd_t, etc_t, shadow_t)
-allow groupadd_t etc_t:file create_file_perms;
-
-allow groupadd_t { etc_t shadow_t }:file { relabelfrom relabelto };
-
-# some apps ask for these accesses, but seems to work regardless
-dontaudit groupadd_t initrc_var_run_t:file { write };
-dontaudit groupadd_t { var_run_t device_t var_t }:dir { search };
-
-# Access terminals.
-allow groupadd_t ttyfile:chr_file rw_file_perms;
-allow groupadd_t ptyfile:chr_file rw_file_perms;
-ifdef(`gnome-pty-helper.te', `allow groupadd_t gphdomain:fd use;')
-
-
-
-
-
-
-
-
-
-
-
diff -ru /tmp/policy/domains/program/passwd.te ./domains/program/passwd.te
--- /tmp/policy/domains/program/passwd.te	2003-03-27 23:57:57.000000000 +1100
+++ ./domains/program/passwd.te	2003-04-23 19:50:59.000000000 +1000
@@ -13,68 +13,85 @@
 # This domain and type is also used for wrappers for
 # chfn and chsh.
 #
-type passwd_t, domain, privlog, auth, privowner;
-in_user_role(passwd_t)
-role sysadm_r types passwd_t;
-
-type passwd_exec_t, file_type, sysadmfile, exec_type;
-type passwd_real_exec_t, file_type, sysadmfile;
-type admin_passwd_exec_t, file_type, sysadmfile;
-
-general_domain_access(passwd_t);
-
-uses_shlib(passwd_t);
-
-domain_auto_trans(userdomain, passwd_exec_t, passwd_t)
-domain_auto_trans(sysadm_t, admin_passwd_exec_t, passwd_t)
+define(`passwd_domain', `
+type $1_t, domain, privlog, auth, privowner;
 
-# for vipw - vi looks in the root home directory for config
-dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };
-
-# Use capabilities.
-allow passwd_t passwd_t:capability { chown dac_override fsetid setuid sys_resource };
+general_domain_access($1_t);
+uses_shlib($1_t);
 
 # Inherit and use descriptors from login.
-allow passwd_t privfd:fd use;
+allow $1_t privfd:fd use;
+ifdef(`gnome-pty-helper.te', `allow $1_t gphdomain:fd use;')
 
 # Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
-allow passwd_t { bin_t sbin_t }:dir r_dir_perms;
-can_exec(passwd_t, { bin_t sbin_t shell_exec_t passwd_real_exec_t })
+allow $1_t { bin_t sbin_t }:dir r_dir_perms;
+can_exec($1_t, { bin_t sbin_t shell_exec_t passwd_real_exec_t })
+allow $1_t bin_t:lnk_file read;
+r_dir_file($1_t, locale_t)
+
+allow $1_t fs_t:filesystem getattr;
 
 # allow checking if a shell is executable
-allow passwd_t shell_exec_t:file execute;
+allow $1_t shell_exec_t:file execute;
 
 # Obtain contexts
-allow passwd_t security_t:security { sid_to_context context_to_sid };
+allow $1_t security_t:security { sid_to_context context_to_sid };
 
 # Update /etc/shadow and /etc/passwd
-file_type_auto_trans(passwd_t, etc_t, shadow_t)
-allow passwd_t etc_t:file create_file_perms;
-allow passwd_t { etc_t shadow_t }:file { relabelfrom relabelto };
+file_type_auto_trans($1_t, etc_t, shadow_t)
+allow $1_t etc_t:file create_file_perms;
+allow $1_t { etc_t shadow_t }:file { relabelfrom relabelto };
 
-# allow vipw to create temporary files under /var/tmp/vi.recover
-tmp_domain(passwd)
+# Use capabilities.
+allow $1_t self:capability { chown dac_override fsetid setuid sys_resource };
 
 # Access terminals.
-allow passwd_t ttyfile:chr_file rw_file_perms;
-allow passwd_t ptyfile:chr_file rw_file_perms;
-ifdef(`gnome-pty-helper.te', `allow passwd_t gphdomain:fd use;')
+allow $1_t { ttyfile ptyfile }:chr_file rw_file_perms;
+allow $1_t devtty_t:chr_file rw_file_perms;
 
-# for vipw - vi looks in the root home directory for config
-dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };
+dontaudit $1_t devpts_t:dir getattr;
 
 # /usr/bin/passwd asks for w access to utmp, but it will operate
 # correctly without it.  Do not audit write denials to utmp.
-dontaudit passwd_t initrc_var_run_t:file { read write };
+dontaudit $1_t initrc_var_run_t:file { read write };
 
 # user generally runs this from their home directory, so do not audit a search
 # on user home dir
-dontaudit passwd_t { user_home_dir_type user_home_type }:dir search;
+dontaudit $1_t { user_home_dir_type user_home_type }:dir search;
 
 # When the wrong current passwd is entered, passwd, for some reason, 
-# attempts to access /proc and /dev, but fails appropriately. So don't
+# attempts to access /proc and /dev, but fails appropriately. So dont
 # audit those denials.
-# Access denials to /var aren't audited either.
-dontaudit passwd_t { proc_t device_t var_t }:dir { search read };
+dontaudit $1_t { proc_t device_t }:dir { search read };
+
+allow $1_t device_t:dir getattr;
+')
+
+passwd_domain(passwd)
+passwd_domain(sysadm_passwd)
+
+in_user_role(passwd_t)
+role sysadm_r types sysadm_passwd_t;
+
+type admin_passwd_exec_t, file_type, sysadmfile, exec_type;
+type passwd_exec_t, file_type, sysadmfile, exec_type;
+type passwd_real_exec_t, file_type, sysadmfile;
+
+domain_auto_trans(userdomain, passwd_exec_t, passwd_t)
+domain_auto_trans(sysadm_t, admin_passwd_exec_t, sysadm_passwd_t)
+
+# for vipw - vi looks in the root home directory for config
+dontaudit sysadm_passwd_t sysadm_home_dir_t:dir { getattr search };
+
+dontaudit passwd_t var_t:dir search;
+
+# allow vipw to create temporary files under /var/tmp/vi.recover
+allow sysadm_passwd_t var_t:dir search;
+tmp_domain(sysadm_passwd)
+
+# for vipw - vi looks in the root home directory for config
+dontaudit sysadm_passwd_t sysadm_home_dir_t:dir { getattr search };
+
+# for /etc/alternatives/vi
+allow sysadm_passwd_t etc_t:lnk_file read;
 
-allow passwd_t device_t:dir getattr;
diff -ru /tmp/policy/file_contexts/program/groupadd.fc ./file_contexts/program/groupadd.fc
--- /tmp/policy/file_contexts/program/groupadd.fc	2003-04-08 06:25:35.000000000 +1000
+++ ./file_contexts/program/groupadd.fc	2003-04-22 19:42:25.000000000 +1000
@@ -1,10 +0,0 @@
-# groupadd
-/usr/local/selinux/bin/sgroupadd	system_u:object_r:groupadd_exec_t
-/usr/local/selinux/bin/sgroupdel	system_u:object_r:groupadd_exec_t
-/usr/local/selinux/bin/sgroupmod	system_u:object_r:groupadd_exec_t
-/usr/local/selinux/bin/sgpasswd		system_u:object_r:groupadd_exec_t
-/usr/bin/sgroupmod		system_u:object_r:groupadd_exec_t
-/usr/bin/sgroupadd               system_u:object_r:groupadd_exec_t
-/usr/bin/sgroupdel               system_u:object_r:groupadd_exec_t
-/usr/bin/sgpasswd               system_u:object_r:groupadd_exec_t
-
diff -ru /tmp/policy/file_contexts/program/passwd.fc ./file_contexts/program/passwd.fc
--- /tmp/policy/file_contexts/program/passwd.fc	2003-03-27 23:58:03.000000000 +1100
+++ ./file_contexts/program/passwd.fc	2003-04-02 18:08:36.000000000 +1000
@@ -3,10 +3,12 @@
 /usr/local/selinux/bin/schsh	system_u:object_r:passwd_exec_t
 /usr/local/selinux/bin/schfn	system_u:object_r:passwd_exec_t
 /usr/local/selinux/bin/svipw    system_u:object_r:admin_passwd_exec_t
+/usr/local/selinux/bin/svigr	system_u:object_r:admin_passwd_exec_t
 /usr/local/selinux/bin/sadminpasswd system_u:object_r:admin_passwd_exec_t
 /usr/bin/spasswd		system_u:object_r:passwd_exec_t
 /usr/bin/passwd			system_u:object_r:passwd_real_exec_t
 /usr/bin/schsh			system_u:object_r:passwd_exec_t
 /usr/bin/schfn			system_u:object_r:passwd_exec_t
 /usr/bin/svipw                 system_u:object_r:admin_passwd_exec_t
+/usr/bin/svigr			system_u:object_r:admin_passwd_exec_t
 /usr/bin/sadminpasswd          system_u:object_r:admin_passwd_exec_t
diff -ru /tmp/policy/file_contexts/program/useradd.fc ./file_contexts/program/useradd.fc
--- /tmp/policy/file_contexts/program/useradd.fc	2003-04-11 19:46:03.000000000 +1000
+++ ./file_contexts/program/useradd.fc	2003-03-30 17:07:35.000000000 +1000
@@ -5,3 +5,13 @@
 /usr/bin/susermod		system_u:object_r:useradd_exec_t
 /usr/bin/suseradd               system_u:object_r:useradd_exec_t
 /usr/bin/suserdel               system_u:object_r:useradd_exec_t
+# groupadd
+/usr/local/selinux/bin/sgroupadd	system_u:object_r:groupadd_exec_t
+/usr/local/selinux/bin/sgroupdel	system_u:object_r:groupadd_exec_t
+/usr/local/selinux/bin/sgroupmod	system_u:object_r:groupadd_exec_t
+/usr/local/selinux/bin/sgpasswd		system_u:object_r:groupadd_exec_t
+/usr/bin/sgroupmod		system_u:object_r:groupadd_exec_t
+/usr/bin/sgroupadd               system_u:object_r:groupadd_exec_t
+/usr/bin/sgroupdel               system_u:object_r:groupadd_exec_t
+/usr/bin/sgpasswd               system_u:object_r:groupadd_exec_t
+
diff -ru /tmp/policy/macros/program/chkpwd_macros.te ./macros/program/chkpwd_macros.te
--- /tmp/policy/macros/program/chkpwd_macros.te	2002-10-02 03:28:52.000000000 +1000
+++ ./macros/program/chkpwd_macros.te	2003-04-21 17:47:26.000000000 +1000
@@ -23,8 +23,9 @@
 # The user role is authorized for this domain.
 role $1_r types $1_chkpwd_t;
 
-# This domain is granted permissions common to most domains (includes can_net)
-every_domain($1_chkpwd_t)
+uses_shlib($1_chkpwd_t)
+allow $1_chkpwd_t self:unix_dgram_socket create_socket_perms;
+r_dir_file($1_chkpwd_t, locale_t)
 
 # Use capabilities.
 allow $1_chkpwd_t self:capability setuid;

--Boundary-00=_rWjq+zc4tzKKGja
Content-Type: text/x-diff;
  charset="us-ascii";
  name="simple.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="simple.diff"

diff -ru /tmp/policy/domains/program/klogd.te ./domains/program/klogd.te
--- /tmp/policy/domains/program/klogd.te	2003-04-02 18:06:26.000000000 +1000
+++ ./domains/program/klogd.te	2003-04-25 03:52:17.000000000 +1000
@@ -7,47 +7,35 @@
 #
 # Rules for the klogd_t domain.
 #
-type klogd_t, domain, privlog, privmem;
-role system_r types klogd_t;
-uses_shlib(klogd_t)
-type klogd_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(initrc_t, klogd_exec_t, klogd_t)
-allow klogd_t self:process { fork signal };
-
-type klogd_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(klogd_t, tmp_t, klogd_tmp_t)
-allow klogd_t var_t:dir r_dir_perms;
-type klogd_var_run_t, file_type, sysadmfile, pidfile;
-file_type_auto_trans(klogd_t, var_run_t, klogd_var_run_t)
+daemon_domain(klogd, `, privmem')
+
+tmp_domain(klogd)
 allow klogd_t proc_t:dir r_dir_perms;
 allow klogd_t proc_t:lnk_file r_file_perms;
+allow klogd_t proc_t:file { getattr read };
 allow klogd_t self:dir r_dir_perms;
 allow klogd_t self:lnk_file r_file_perms;
 
 # read /etc/nsswitch.conf
+allow klogd_t etc_t:lnk_file read;
 allow klogd_t etc_t:file r_file_perms;
 
 # read localization information
 allow klogd_t locale_t:dir r_dir_perms;
 allow klogd_t locale_t:{file lnk_file} r_file_perms;
 
+allow klogd_t etc_runtime_t:file { getattr read };
+
 # Create unix sockets
 allow klogd_t self:unix_dgram_socket create_socket_perms;
 
 # Use the sys_admin and sys_rawio capabilities.
 allow klogd_t klogd_t:capability { sys_admin sys_rawio };
 
-# Inherit and use descriptors from init.
-allow klogd_t init_t:fd use;
-
 # Read /proc/kmsg and /dev/mem.
-allow klogd_t device_t:dir r_dir_perms;
 allow klogd_t proc_kmsg_t:file r_file_perms;
 allow klogd_t memory_device_t:chr_file r_file_perms;
 
-# Write to the console.
-allow klogd_t { initrc_devpts_t console_device_t }:chr_file rw_file_perms;
-
 # Control syslog and console logging
 allow klogd_t kernel_t:system { syslog_mod syslog_console };
 
diff -ru /tmp/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /tmp/policy/domains/program/syslogd.te	2003-04-02 18:06:29.000000000 +1000
+++ ./domains/program/syslogd.te	2003-04-25 03:54:06.000000000 +1000
@@ -12,31 +12,22 @@
 # devlog_t is the type of the Unix domain socket created 
 # by syslogd.
 #
-type syslogd_t, domain;
-role system_r types syslogd_t;
-uses_shlib(syslogd_t)
-type syslogd_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(initrc_t, syslogd_exec_t, syslogd_t)
+daemon_domain(syslogd)
+
+# can_network is for the UDP socket
+can_network(syslogd_t)
+
 type devlog_t, file_type, sysadmfile;
-allow syslogd_t self:process { fork signal };
 
 # if something can log to syslog they should be able to log to the console
 allow privlog console_device_t:chr_file { ioctl read write getattr };
 
-type syslogd_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(syslogd_t, tmp_t, syslogd_tmp_t)
-type syslogd_var_run_t, file_type, sysadmfile, pidfile;
-file_type_auto_trans(syslogd_t, var_run_t, syslogd_var_run_t, file)
-allow syslogd_t var_t:dir r_dir_perms;
+tmp_domain(syslogd)
 
 # read files in /etc
 allow syslogd_t etc_t:file r_file_perms;
 allow syslogd_t resolv_conf_t:{ file lnk_file } r_file_perms;
 
-# read localization information
-allow syslogd_t locale_t:dir r_dir_perms;
-allow syslogd_t locale_t:{file lnk_file} r_file_perms;
-
 # Use capabilities.
 allow syslogd_t syslogd_t:capability { net_bind_service dac_override };
 
@@ -65,3 +56,7 @@
 
 # Write to the cron log.
 allow syslogd_t cron_log_t:file rw_file_perms;
+
+ifdef(`logrotate.te', `
+allow logrotate_t syslogd_exec_t:file r_file_perms;
+')
diff -ru /tmp/policy/file_contexts/program/fsadm.fc ./file_contexts/program/fsadm.fc
--- /tmp/policy/file_contexts/program/fsadm.fc	2003-02-12 23:36:12.000000000 +1100
+++ ./file_contexts/program/fsadm.fc	2003-04-08 09:06:20.000000000 +1000
@@ -6,6 +6,7 @@
 /sbin/mkreiserfs		system_u:object_r:fsadm_exec_t
 /sbin/resize.*fs		system_u:object_r:fsadm_exec_t
 /sbin/e2label			system_u:object_r:fsadm_exec_t
+/sbin/findfs			system_u:object_r:fsadm_exec_t
 /sbin/mkfs			system_u:object_r:fsadm_exec_t
 /sbin/mke2fs			system_u:object_r:fsadm_exec_t
 /sbin/mkswap			system_u:object_r:fsadm_exec_t
@@ -22,6 +23,7 @@
 /sbin/mkraid			system_u:object_r:fsadm_exec_t
 /sbin/blockdev			system_u:object_r:fsadm_exec_t
 /sbin/losetup			system_u:object_r:fsadm_exec_t
+/sbin/jfs_.*			system_u:object_r:fsadm_exec_t
 /usr/sbin/updfstab		system_u:object_r:fsadm_exec_t
 /usr/sbin/smart(d|ctl)		system_u:object_r:fsadm_exec_t
 /sbin/lvmiopversion		system_u:object_r:fsadm_exec_t
diff -ru /tmp/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2003-03-27 23:58:04.000000000 +1100
+++ ./file_contexts/program/postfix.fc	2003-04-24 12:51:18.000000000 +1000
@@ -24,7 +24,7 @@
 /usr/sbin/postmap		system_u:object_r:postfix_master_exec_t
 /usr/sbin/postqueue		system_u:object_r:postfix_postqueue_exec_t
 /usr/sbin/postsuper		system_u:object_r:postfix_master_exec_t
-/usr/sbin/rmail			system_u:object_r:postfix_master_exec_t
+/usr/sbin/rmail			system_u:object_r:sendmail_exec_t
 /var/spool/postfix(/[^/]+)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/active(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/hold(/.*)?	system_u:object_r:postfix_spool_t
diff -ru /tmp/policy/file_contexts/program/syslogd.fc ./file_contexts/program/syslogd.fc
--- /tmp/policy/file_contexts/program/syslogd.fc	2003-03-16 22:33:46.000000000 +1100
+++ ./file_contexts/program/syslogd.fc	2003-04-25 03:54:53.000000000 +1000
@@ -5,5 +5,4 @@
 /sbin/syslog-ng			system_u:object_r:syslogd_exec_t
 /dev/log			system_u:object_r:devlog_t
 /var/run/log			system_u:object_r:devlog_t
-/var/run/klogd\.pid		system_u:object_r:klogd_var_run_t
 /var/run/syslogd\.pid		system_u:object_r:syslogd_var_run_t
diff -ru /tmp/policy/macros/program/crontab_macros.te ./macros/program/crontab_macros.te
--- /tmp/policy/macros/program/crontab_macros.te	2003-03-14 02:14:55.000000000 +1100
+++ ./macros/program/crontab_macros.te	2003-04-20 18:20:48.000000000 +1000
@@ -27,8 +27,11 @@
 # The user role is authorized for this domain.
 role $1_r types $1_crontab_t;
 
-# This domain is granted permissions common to most domains (including can_net)
-every_domain($1_crontab_t)
+uses_shlib($1_crontab_t)
+allow $1_crontab_t etc_t:file { getattr read };
+allow $1_crontab_t self:unix_stream_socket create_socket_perms;
+allow $1_crontab_t self:unix_dgram_socket create_socket_perms;
+r_dir_file($1_crontab_t, locale_t)
 
 # Use capabilities
 allow $1_crontab_t $1_crontab_t:capability { setuid setgid chown };
@@ -40,7 +43,9 @@
 type $1_cron_spool_t, file_type, sysadmfile;
 # Use the type when creating files in /var/spool/cron.
 allow sysadm_crontab_t $1_cron_spool_t:file { getattr read };
+allow $1_crontab_t var_spool_t:dir search;
 file_type_auto_trans($1_crontab_t, cron_spool_t, $1_cron_spool_t)
+allow $1_crontab_t self:process { fork signal_perms };
 ifdef(`fcron.te', `
 allow crond_t $1_cron_spool_t:file create_file_perms;
 # fcron wants an instant update of a crontab change for the administrator
@@ -57,7 +62,9 @@
 allow crond_t $1_cron_spool_t:file r_file_perms;
 
 # Run helper programs as $1_t
-domain_auto_trans($1_crontab_t, { bin_t sbin_t exec_type }, $1_t)
+allow $1_crontab_t { bin_t sbin_t }:dir search;
+allow $1_crontab_t bin_t:lnk_file read;
+domain_auto_trans_read($1_crontab_t, { bin_t sbin_t shell_exec_t }, $1_t)
 
 # Read user crontabs 
 allow $1_crontab_t { $1_home_t $1_home_dir_t }:dir r_dir_perms;  
@@ -69,10 +76,11 @@
 allow $1_crontab_t cron_log_t:file { append };
 
 # Access terminals.
+allow $1_crontab_t device_t:dir search;
 allow $1_crontab_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_crontab_t $1_devpts_t:chr_file rw_file_perms;
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_crontab_t $1_gph_t:fd use;')
-
+allow $1_crontab_t privfd:fd use;
 ')
diff -ru /tmp/policy/macros/program/gpg_macros.te ./macros/program/gpg_macros.te
--- /tmp/policy/macros/program/gpg_macros.te	2003-03-27 23:58:06.000000000 +1100
+++ ./macros/program/gpg_macros.te	2003-04-05 14:18:06.000000000 +1000
@@ -80,6 +80,6 @@
 allow $1_gpg_t { etc_t usr_t }:dir r_dir_perms;
 allow $1_gpg_t fs_t:filesystem getattr;
 allow $1_gpg_t usr_t:file r_file_perms;
-allow $1_gpg_t etc_t:lnk_file r_file_perms;
+r_dir_file($1_gpg_t, locale_t)
 allow $1_t $1_gpg_secret_t:dir rw_dir_perms;
 ')
diff -ru /tmp/policy/macros/program/gph_macros.te ./macros/program/gph_macros.te
--- /tmp/policy/macros/program/gph_macros.te	2003-01-20 11:04:03.000000000 +1100
+++ ./macros/program/gph_macros.te	2003-04-17 08:43:31.000000000 +1000
@@ -34,7 +34,7 @@
 role $1_r types $1_gph_t;
 
 # This domain is granted permissions common to most domains.
-every_domain($1_gph_t)
+uses_shlib($1_gph_t)
 
 # Use capabilities.
 allow $1_gph_t $1_gph_t:capability { setuid setgid fsetid };
diff -ru /tmp/policy/macros/program/irc_macros.te ./macros/program/irc_macros.te
--- /tmp/policy/macros/program/irc_macros.te	2003-03-14 02:14:55.000000000 +1100
+++ ./macros/program/irc_macros.te	2003-04-12 10:02:10.000000000 +1000
@@ -36,9 +36,7 @@
 role $1_r types $1_irc_t;
 
 # Inherit and use descriptors from gnome-pty-helper.
-ifdef(`gnome-pty-helper.te',
-`allow $1_irc_t $1_gph_t:fd use;
-allow $1_t $1_gph_t:fd use;')
+ifdef(`gnome-pty-helper.te', `allow $1_irc_t $1_gph_t:fd use;')
 
 # Inherit and use descriptors from newrole.
 ifdef(`newrole.te', `allow $1_irc_t newrole_t:fd use;')
@@ -53,7 +51,7 @@
 
 uses_shlib($1_irc_t)
 allow $1_irc_t { etc_t resolv_conf_t }:file { read getattr };
-allow $1_irc_t etc_t:lnk_file read;
+r_dir_file($1_irc_t, locale_t)
 allow $1_irc_t fs_t:filesystem getattr;
 allow $1_irc_t var_t:dir search;
 allow $1_irc_t devpts_t:dir { getattr read search };
diff -ru /tmp/policy/macros/program/run_program_macros.te ./macros/program/run_program_macros.te
--- /tmp/policy/macros/program/run_program_macros.te	2002-11-04 23:28:01.000000000 +1100
+++ ./macros/program/run_program_macros.te	2003-04-20 22:13:21.000000000 +1000
@@ -29,6 +29,9 @@
 allow run_$3_t initrc_var_run_t:file rw_file_perms;
 allow run_$3_t admin_tty_type:chr_file rw_file_perms;
 
+dontaudit run_$3_t devpts_t:dir { getattr read };
+dontaudit run_$3_t device_t:dir read;
+
 # often the administrator runs such programs from a directory that is owned
 # by a different user or has restrictive SE permissions, do not want to audit
 # the failed access to the current directory
@@ -39,6 +42,14 @@
 
 domain_trans(run_$3_t, $4, $5)
 
-# hmm, do we REALLY need this?
-every_domain(run_$3_t)
+allow run_$3_t privfd:fd use;
+uses_shlib(run_$3_t)
+allow run_$3_t security_t:security { sid_to_context context_to_sid };
+allow run_$3_t self:unix_stream_socket create_socket_perms;
+allow run_$3_t self:unix_dgram_socket create_socket_perms;
+allow run_$3_t etc_t:file { getattr read };
+r_dir_file(run_$3_t, locale_t)
+allow run_$3_t fs_t:filesystem getattr;
+allow run_$3_t { bin_t sbin_t }:dir search;
+dontaudit run_$3_t { proc_t device_t }:dir { getattr search };
 ')
diff -ru /tmp/policy/macros/program/sendmail_macros.te ./macros/program/sendmail_macros.te
--- /tmp/policy/macros/program/sendmail_macros.te	2003-01-20 11:04:03.000000000 +1100
+++ ./macros/program/sendmail_macros.te	2003-03-23 10:08:30.000000000 +1100
@@ -25,9 +25,6 @@
 # Use this type when creating files in /tmp.
 file_type_auto_trans($1_mail_t, tmp_t, $1_mail_tmp_t)
 
-# Update /etc/mail/statistics.
-allow $1_mail_t etc_mail_t:file rw_file_perms;
-
 # Write to /var/spool/mail and /var/spool/mqueue.
 allow $1_mail_t mail_spool_t:dir rw_dir_perms;
 allow $1_mail_t mail_spool_t:file create_file_perms;
diff -ru /tmp/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2003-04-02 18:06:41.000000000 +1000
+++ ./macros/program/ssh_macros.te	2003-04-08 09:07:20.000000000 +1000
@@ -111,6 +111,9 @@
 r_dir_file(sshd_t, $1_home_ssh_t)
 rw_dir_create_file($1_t, $1_home_ssh_t)
 
+# for /bin/sh used to execute xauth
+dontaudit $1_ssh_t proc_t:dir search;
+
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
diff -ru /tmp/policy/macros/program/xserver_macros.te ./macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2003-03-28 06:10:03.000000000 +1100
+++ ./macros/program/xserver_macros.te	2003-04-05 14:18:23.000000000 +1000
@@ -128,6 +128,8 @@
 allow $1_t $1_xserver_tmpfs_t:file rw_file_perms;
 ')
 
+r_dir_file($1_xserver_t, locale_t)
+
 # David Wheeler says he needs the following permission
 # for his X server.  Something is wrong here - the shared
 # memory pseudo file should be labeled $1_tmpfs_t and handled

--Boundary-00=_rWjq+zc4tzKKGja--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
