From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: $1_file_type policy patch
Date: Fri, 26 Nov 2004 00:28:46 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q4dpB++Jsn5SsMc"
Message-Id: <200411260028.48730.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Q4dpB++Jsn5SsMc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch uses the $1_file_type attribute everywhere it's needed and 
modifies the locate policy to use this.  It makes things quite a bit simpler.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Q4dpB++Jsn5SsMc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff.filetype"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff.filetype"

diff -ru /usr/src/se/policy/macros/program/admin_macros.te ./macros/program/admin_macros.te
--- /usr/src/se/policy/macros/admin_macros.te	2004-11-25 20:37:20.000000000 +1100
+++ ./macros/admin_macros.te	2004-11-25 23:56:48.000000000 +1100
@@ -15,9 +15,9 @@
 undefine(`admin_domain')
 define(`admin_domain',`
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
-type $1_home_t, file_type, sysadmfile, home_type;
 attribute $1_file_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
+type $1_home_t, file_type, sysadmfile, home_type, $1_file_type;
 
 # Type and access for pty devices.
 can_create_pty($1)
diff -ru /usr/src/se/policy/macros/program/fingerd_macros.te ./macros/program/fingerd_macros.te
--- /usr/src/se/policy/macros/program/fingerd_macros.te 2003-08-14 22:37:36.000000000 +1000
+++ ./macros/program/fingerd_macros.te  2004-11-17 22:36:34.000000000 +1100
@@ -10,6 +10,6 @@
 # allow fingerd to create a fingerlog file in the user home dir
 #
 define(`fingerd_macro', `
-type $1_home_fingerlog_t, file_type, sysadmfile;
+type $1_home_fingerlog_t, file_type, sysadmfile, $1_file_type;
 file_type_auto_trans(fingerd_t, $1_home_dir_t, $1_home_fingerlog_t)
 ')
diff -ru /usr/src/se/policy/macros/program/gpg_macros.te ./macros/program/gpg_macros.te
--- /usr/src/se/policy/macros/program/gpg_macros.te	2004-11-20 01:18:25.000000000 +1100
+++ ./macros/program/gpg_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -19,7 +19,7 @@
 define(`gpg_domain', `
 # Derived domain based on the calling user domain and the program.
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, $1_file_type, sysadmfile;
+type $1_gpg_secret_t, file_type, $1_file_type, sysadmfile, $1_file_type;
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
diff -ru /usr/src/se/policy/macros/program/rssh_macros.te ./macros/program/rssh_macros.te
--- /usr/src/se/policy/macros/program/rssh_macros.te	2004-09-23 22:31:25.000000000 +1000
+++ ./macros/program/rssh_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -19,8 +19,8 @@
 role rssh_$1_r types rssh_$1_t;
 allow system_r rssh_$1_r;
 
-type rssh_$1_rw_t, file_type, sysadmfile;
-type rssh_$1_ro_t, file_type, sysadmfile;
+type rssh_$1_rw_t, file_type, sysadmfile, $1_file_type;
+type rssh_$1_ro_t, file_type, sysadmfile, $1_file_type;
 
 general_domain_access(rssh_$1_t);
 uses_shlib(rssh_$1_t);
diff -ru /usr/src/se/policy/macros/program/slocate_macros.te ./macros/program/slocate_macros.te
--- /usr/src/se/policy/macros/program/slocate_macros.te	2004-11-13 03:56:11.000000000 +1100
+++ ./macros/program/slocate_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -52,8 +52,8 @@
 allow $1_locate_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_locate_t $1_devpts_t:chr_file rw_file_perms;
 
-allow $1_locate_t { home_root_t $1_home_dir_t $1_home_t }:dir { getattr search };
-allow $1_locate_t $1_home_t:{ file lnk_file } { getattr read };
+allow $1_locate_t { home_root_t $1_home_dir_t $1_file_type }:dir { getattr search };
+allow $1_locate_t $1_file_type:{ file lnk_file } { getattr read };
 
 base_file_read_access($1_locate_t)
 r_dir_file($1_locate_t, { etc_t lib_t var_t })
diff -ru /usr/src/se/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /usr/src/se/policy/macros/program/ssh_macros.te	2004-11-20 01:18:25.000000000 +1100
+++ ./macros/program/ssh_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -111,15 +111,9 @@
 r_dir_file({ sshd_t sshd_extern_t }, $1_home_ssh_t)
 rw_dir_create_file($1_t, $1_home_ssh_t)
 
-ifdef(`slocate.te', `
-allow $1_locate_t $1_home_ssh_t:dir { getattr search };
-allow $1_locate_t $1_home_ssh_t:file { getattr read };
-')
-
 # for /bin/sh used to execute xauth
 dontaudit $1_ssh_t proc_t:dir search;
 dontaudit $1_ssh_t proc_t:{ lnk_file file } { getattr read };
-can_exec($1_ssh_t, shell_exec_t)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
diff -ru /usr/src/se/policy/macros/program/uml_macros.te ./macros/program/uml_macros.te
--- /usr/src/se/policy/macros/program/uml_macros.te	2004-11-13 03:56:12.000000000 +1100
+++ ./macros/program/uml_macros.te	2004-11-22 03:19:08.000000000 +1100
@@ -21,14 +21,9 @@
 
 # Derived domain based on the calling user domain and the program.
 type $1_uml_t, domain;
-type $1_uml_exec_t, file_type, sysadmfile;
-type $1_uml_ro_t, file_type, sysadmfile;
-type $1_uml_rw_t, file_type, sysadmfile;
-
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_uml_exec_t $1_uml_ro_t $1_uml_rw_t }:dir { getattr search };
-allow $1_locate_t { $1_uml_exec_t $1_uml_ro_t $1_uml_rw_t }:file { getattr read };
-')
+type $1_uml_exec_t, file_type, sysadmfile, $1_file_type;
+type $1_uml_ro_t, file_type, sysadmfile, $1_file_type;
+type $1_uml_rw_t, file_type, sysadmfile, $1_file_type;
 
 can_ptrace($1_t, $1_uml_t)
 
diff -ru /usr/src/se/policy/macros/program/vmware_macros.te ./macros/program/vmware_macros.te
--- /usr/src/se/policy/macros/program/vmware_macros.te	2004-11-25 20:37:21.000000000 +1100
+++ ./macros/program/vmware_macros.te	2004-11-25 23:19:16.000000000 +1100
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
 
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, $1_file_type, file_type, sysadmfile;
+type $1_vmware_file_t, $1_file_type, file_type, sysadmfile, $1_file_type;
 
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile;
+type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile, $1_file_type;
 
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;
diff -ru /usr/src/se/policy/macros/program/x_client_macros.te ./macros/program/x_client_macros.te
--- /usr/src/se/policy/macros/program/x_client_macros.te	2004-11-20 01:18:26.000000000 +1100
+++ ./macros/program/x_client_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -82,11 +82,6 @@
 allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
 allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
 
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:dir { getattr search };
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:file { getattr read };
-')
-
 # Allow the user domain to send any signal to the $2 process.
 allow $1_t $1_$2_t:process signal_perms;
 
diff -ru /usr/src/se/policy/macros/program/xauth_macros.te ./macros/program/xauth_macros.te
--- /usr/src/se/policy/macros/program/xauth_macros.te	2004-11-20 01:18:26.000000000 +1100
+++ ./macros/program/xauth_macros.te	2004-11-22 03:19:15.000000000 +1100
@@ -22,10 +22,6 @@
 type $1_xauth_t, domain;
 type $1_home_xauth_t, file_type, $1_file_type, sysadmfile;
 
-ifdef(`slocate.te', `
-allow $1_locate_t $1_home_xauth_t:file { getattr read };
-')
-
 allow $1_xauth_t self:process signal;
 
 allow $1_t $1_home_xauth_t:file { relabelfrom relabelto create_file_perms };
diff -ru /usr/src/se/policy/macros/user_macros.te ./macros/user_macros.te
--- /usr/src/se/policy/macros/user_macros.te	2004-11-20 01:18:25.000000000 +1100
+++ ./macros/user_macros.te	2004-11-22 03:14:43.000000000 +1100
@@ -19,15 +19,15 @@
 
 # Type for home directory.
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
-type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
+type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type;
 
-tmp_domain($1, `, user_tmpfile')
+tmp_domain($1, `, user_tmpfile, $1_file_type')
 
 # Type and access for pty devices.
 can_create_pty($1, `, userpty_type, user_tty_type')
 
 #Type for tty devices.
-type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_fs;
+type $1_tty_device_t, sysadmfile, ttyfile, user_tty_type, dev_fs;
  
 base_user_domain($1)
 

--Boundary-00=_Q4dpB++Jsn5SsMc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
