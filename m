From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Date: Wed, 27 Oct 2004 00:36:14 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de>
In-Reply-To: <20041025213122.GA2535@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eDmfBRtpqtg3p8W"
Message-Id: <200410270036.14935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_eDmfBRtpqtg3p8W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 26 Oct 2004 07:31, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> OK, what do you guys think about the following patch:
> It adds an attribute $1_domain_file_type, so all file types from derived
> user domains can be grouped together. It also adds a restorecon_domain()
> macro, so users can call restorecon to reset the labels on their files.

I've attached a patch named "tom.diff" which applies after your patch to tweak 
a few things.  The new attribute allows a better way of dealing with the 
locate policy so I changed it appropriately.  I added some use of 
sysadm_domain_file_type.  Some of the types you had given the attribute 
$1_domain_file_type seemed inappropriate, this includes the print spool type, 
some temporary files, and files under /var/run.

Whether we have the user_restorecon_t domain etc is something that needs more 
consideration.  The attached patch named "diff" has the user_domain_file_type 
stuff from your patch with my amendments but none of the restorecon changes.  
I think that "diff" is worthy of being included in CVS regardless of what we 
do with restorecon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_eDmfBRtpqtg3p8W
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tom.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tom.diff"

diff -ru policy.tom/macros/program/apache_macros.te policy.new/macros/program/apache_macros.te
--- policy.tom/macros/program/apache_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/apache_macros.te	2004-10-26 23:19:27.000000000 +1000
@@ -21,7 +21,7 @@
 ifelse($1, sys, `
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
+type httpd_$1_content_t, file_type, homedirfile, sysadmfile, sysadm_domain_file_type;
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 
 # This type is used for .htaccess files
@@ -79,9 +79,9 @@
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
-type httpd_$1_script_ro_t, file_type, sysadmfile;
-type httpd_$1_script_rw_t, file_type, sysadmfile;
-type httpd_$1_script_ra_t, file_type, sysadmfile;
+type httpd_$1_script_ro_t, file_type, sysadmfile, sysadm_domain_file_type;
+type httpd_$1_script_rw_t, file_type, sysadmfile, sysadm_domain_file_type;
+type httpd_$1_script_ra_t, file_type, sysadmfile, sysadm_domain_file_type;
 ', `
 type httpd_$1_script_ro_t, file_type, sysadmfile, $1_domain_file_type;
 type httpd_$1_script_rw_t, file_type, sysadmfile, $1_domain_file_type;
@@ -89,13 +89,6 @@
 ')
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
 
-ifdef(`slocate.te', `
-ifelse($1, `sys', `', `
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:dir { getattr search };
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:file { getattr read };
-')dnl end ifelse
-')dnl end slocate.te
-
 #########################################################
 # Permissions for running child processes and scripts
 ##########################################################
diff -ru policy.tom/macros/program/crond_macros.te policy.new/macros/program/crond_macros.te
--- policy.tom/macros/program/crond_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/crond_macros.te	2004-10-27 00:18:59.000000000 +1000
@@ -36,7 +36,7 @@
 r_dir_file($1_crond_t, selinux_config_t)
 
 # Type of user crontabs once moved to cron spool.
-type $1_cron_spool_t, file_type, sysadmfile ifelse($1, `system', `', `, $1_domain_file_type');
+type $1_cron_spool_t, file_type, sysadmfile;
 
 ifdef(`fcron.te', `
 allow crond_t $1_cron_spool_t:file create_file_perms;
diff -ru policy.tom/macros/program/irc_macros.te policy.new/macros/program/irc_macros.te
--- policy.tom/macros/program/irc_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/irc_macros.te	2004-10-26 23:46:34.000000000 +1000
@@ -27,11 +27,6 @@
 type $1_home_irc_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 type $1_irc_exec_t, file_type, sysadmfile, $1_domain_file_type;
 
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:dir { getattr search };
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:file { getattr read };
-')
-
 allow $1_t { $1_home_irc_t $1_irc_exec_t }:file { relabelfrom relabelto create_file_perms };
 
 # Transition from the user domain to this domain.
diff -ru policy.tom/macros/program/lpr_macros.te policy.new/macros/program/lpr_macros.te
--- policy.tom/macros/program/lpr_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/lpr_macros.te	2004-10-26 23:21:33.000000000 +1000
@@ -54,11 +54,11 @@
 r_dir_file($1_lpr_t, printconf_t)
 ')
 
-tmp_domain($1_lpr, `, $1_domain_file_type')
+tmp_domain($1_lpr)
 r_dir_file($1_lpr_t, $1_tmp_t)
 
 # Type for spool files.
-type $1_print_spool_t, file_type, sysadmfile, $1_domain_file_type;
+type $1_print_spool_t, file_type, sysadmfile;
 # Use this type when creating files in /var/spool/lpd and /var/spool/cups.
 file_type_auto_trans($1_lpr_t, print_spool_t, $1_print_spool_t, file)
 allow $1_lpr_t var_spool_t:dir { search };
diff -ru policy.tom/macros/program/screen_macros.te policy.new/macros/program/screen_macros.te
--- policy.tom/macros/program/screen_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/screen_macros.te	2004-10-26 23:22:33.000000000 +1000
@@ -31,7 +31,7 @@
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
 
-tmp_domain($1_screen, `, $1_domain_file_type')
+tmp_domain($1_screen)
 base_file_read_access($1_screen_t)
 # The user role is authorized for this domain.
 role $1_r types $1_screen_t;
@@ -72,7 +72,7 @@
 # Create fifo
 allow $1_screen_t var_t:dir search;
 file_type_auto_trans($1_screen_t, var_run_t, screen_dir_t, dir)
-type $1_screen_var_run_t, file_type, sysadmfile, pidfile, $1_domain_file_type;
+type $1_screen_var_run_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans($1_screen_t, screen_dir_t, $1_screen_var_run_t, fifo_file)
 
 allow $1_screen_t self:process { fork signal_perms };
diff -ru policy.tom/macros/program/slocate_macros.te policy.new/macros/program/slocate_macros.te
--- policy.tom/macros/program/slocate_macros.te	2004-09-03 14:10:35.000000000 +1000
+++ policy.new/macros/program/slocate_macros.te	2004-10-26 23:33:57.000000000 +1000
@@ -52,8 +52,8 @@
 allow $1_locate_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_locate_t $1_devpts_t:chr_file rw_file_perms;
 
-allow $1_locate_t { home_root_t $1_home_dir_t $1_home_t }:dir { getattr search };
-allow $1_locate_t $1_home_t:{ file lnk_file } { getattr read };
+allow $1_locate_t $1_domain_file_type:dir { getattr search };
+allow $1_locate_t $1_domain_file_type:{ file lnk_file sock_file fifo_file } { getattr read };
 
 base_file_read_access($1_locate_t)
 r_dir_file($1_locate_t, { etc_t lib_t var_t })
diff -ru policy.tom/macros/program/ssh_macros.te policy.new/macros/program/ssh_macros.te
--- policy.tom/macros/program/ssh_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/ssh_macros.te	2004-10-26 23:46:14.000000000 +1000
@@ -115,11 +115,6 @@
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
diff -ru policy.tom/macros/program/uml_macros.te policy.new/macros/program/uml_macros.te
--- policy.tom/macros/program/uml_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/uml_macros.te	2004-10-26 23:46:42.000000000 +1000
@@ -29,11 +29,6 @@
 type $1_uml_ro_t, file_type, sysadmfile, $1_domain_file_type;
 type $1_uml_rw_t, file_type, sysadmfile, $1_domain_file_type;
 
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_uml_exec_t $1_uml_ro_t $1_uml_rw_t }:dir { getattr search };
-allow $1_locate_t { $1_uml_exec_t $1_uml_ro_t $1_uml_rw_t }:file { getattr read };
-')
-
 can_ptrace($1_t, $1_uml_t)
 
 # for X
diff -ru policy.tom/macros/program/x_client_macros.te policy.new/macros/program/x_client_macros.te
--- policy.tom/macros/program/x_client_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/x_client_macros.te	2004-10-26 23:46:20.000000000 +1000
@@ -81,11 +81,6 @@
 allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
 allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
 
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:dir { getattr search };
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:file { getattr read };
-')
-
 # Allow the user domain to send any signal to the $2 process.
 allow $1_t $1_$2_t:process signal_perms;
 
diff -ru policy.tom/macros/program/xauth_macros.te policy.new/macros/program/xauth_macros.te
--- policy.tom/macros/program/xauth_macros.te	2004-10-26 23:20:42.000000000 +1000
+++ policy.new/macros/program/xauth_macros.te	2004-10-26 23:46:26.000000000 +1000
@@ -26,10 +26,6 @@
 type $1_xauth_t, domain;
 type $1_home_xauth_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 
-ifdef(`slocate.te', `
-allow $1_locate_t $1_home_xauth_t:file { getattr read };
-')
-
 allow $1_xauth_t self:process signal;
 
 allow $1_t $1_home_xauth_t:file { relabelfrom relabelto create_file_perms };
@@ -84,7 +80,7 @@
 allow $1_xauth_t home_root_t:dir search;
 file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_home_xauth_t, file)
 
-tmp_domain($1_xauth, `, $1_domain_file_type')
+tmp_domain($1_xauth)
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
 
 ifdef(`nfs_home_dirs', `

--Boundary-00=_eDmfBRtpqtg3p8W
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy/macros/admin_macros.te policy.new/macros/admin_macros.te
--- policy/macros/admin_macros.te	2004-10-02 03:36:13.000000000 +1000
+++ policy.new/macros/admin_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -14,9 +14,12 @@
 #
 undefine(`admin_domain')
 define(`admin_domain',`
+# define an attribute for all files created by this role
+attribute $1_domain_file_type;
+
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
-type $1_home_t, file_type, sysadmfile, home_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, $1_domain_file_type;
+type $1_home_t, file_type, sysadmfile, home_type, $1_domain_file_type;
 
 # Type and access for pty devices.
 can_create_pty($1)
diff -ru policy/macros/program/apache_macros.te policy.new/macros/program/apache_macros.te
--- policy/macros/program/apache_macros.te	2004-10-15 14:57:20.000000000 +1000
+++ policy.new/macros/program/apache_macros.te	2004-10-26 23:19:27.000000000 +1000
@@ -18,18 +18,23 @@
 file_type_auto_trans(httpd_$1_script_t, tmp_t, $1_tmp_t)
 ', `
 
+ifelse($1, sys, `
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
-ifelse($1, sys, `
+type httpd_$1_content_t, file_type, homedirfile, sysadmfile, sysadm_domain_file_type;
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
-')
 
 # This type is used for .htaccess files
 #
 type httpd_$1_htaccess_t, file_type, sysadmfile;
 
 type httpd_$1_script_exec_t, file_type, sysadmfile;
+', `
+# same as above, add $1_domain_file_type attribute
+type httpd_$1_content_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
+type httpd_$1_htaccess_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_exec_t, file_type, sysadmfile, $1_domain_file_type;
+')
 
 # Type that CGI scripts run as
 type httpd_$1_script_t, domain, privmail;
@@ -69,20 +74,20 @@
 uncond_can_ypbind(httpd_$1_script_t)
 }
 ')
+
+ifelse($1, `sys', `
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
-type httpd_$1_script_ro_t, file_type, sysadmfile;
-type httpd_$1_script_rw_t, file_type, sysadmfile;
+type httpd_$1_script_ro_t, file_type, sysadmfile, sysadm_domain_file_type;
+type httpd_$1_script_rw_t, file_type, sysadmfile, sysadm_domain_file_type;
+type httpd_$1_script_ra_t, file_type, sysadmfile, sysadm_domain_file_type;
+', `
+type httpd_$1_script_ro_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_rw_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_ra_t, file_type, sysadmfile, $1_domain_file_type;
+')
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
-type httpd_$1_script_ra_t, file_type, sysadmfile;
-
-ifdef(`slocate.te', `
-ifelse($1, `sys', `', `
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:dir { getattr search };
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:file { getattr read };
-')dnl end ifelse
-')dnl end slocate.te
 
 #########################################################
 # Permissions for running child processes and scripts
diff -ru policy/macros/program/fingerd_macros.te policy.new/macros/program/fingerd_macros.te
--- policy/macros/program/fingerd_macros.te	2003-08-14 22:37:36.000000000 +1000
+++ policy.new/macros/program/fingerd_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -10,6 +10,6 @@
 # allow fingerd to create a fingerlog file in the user home dir
 #
 define(`fingerd_macro', `
-type $1_home_fingerlog_t, file_type, sysadmfile;
+type $1_home_fingerlog_t, file_type, sysadmfile, $1_domain_file_type;
 file_type_auto_trans(fingerd_t, $1_home_dir_t, $1_home_fingerlog_t)
 ')
diff -ru policy/macros/program/gpg_agent_macros.te policy.new/macros/program/gpg_agent_macros.te
--- policy/macros/program/gpg_agent_macros.te	2004-09-21 14:39:17.000000000 +1000
+++ policy.new/macros/program/gpg_agent_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -58,7 +58,7 @@
 allow $1_gpg_agent_t self:fifo_file { getattr read write };
 
 # create /tmp files
-tmp_domain($1_gpg_agent)
+tmp_domain($1_gpg_agent, `, $1_domain_file_type')
 
 # gpg connect
 allow $1_gpg_t $1_gpg_agent_tmp_t:dir { search };
diff -ru policy/macros/program/gpg_macros.te policy.new/macros/program/gpg_macros.te
--- policy/macros/program/gpg_macros.te	2004-08-28 12:05:12.000000000 +1000
+++ policy.new/macros/program/gpg_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -25,7 +25,7 @@
 allow $1_t self:capability { setuid };
 ', `
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, homedirfile, sysadmfile;
+type $1_gpg_secret_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 ')dnl end ifdef single_userdomain
 
 # Transition from the user domain to the derived domain.
diff -ru policy/macros/program/irc_macros.te policy.new/macros/program/irc_macros.te
--- policy/macros/program/irc_macros.te	2004-03-27 00:46:45.000000000 +1100
+++ policy.new/macros/program/irc_macros.te	2004-10-26 23:46:34.000000000 +1000
@@ -24,13 +24,8 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, homedirfile, sysadmfile;
-type $1_irc_exec_t, file_type, sysadmfile;
-
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:dir { getattr search };
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:file { getattr read };
-')
+type $1_home_irc_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
+type $1_irc_exec_t, file_type, sysadmfile, $1_domain_file_type;
 
 allow $1_t { $1_home_irc_t $1_irc_exec_t }:file { relabelfrom relabelto create_file_perms };
 
diff -ru policy/macros/program/rssh_macros.te policy.new/macros/program/rssh_macros.te
--- policy/macros/program/rssh_macros.te	2004-09-23 22:31:25.000000000 +1000
+++ policy.new/macros/program/rssh_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -19,8 +19,8 @@
 role rssh_$1_r types rssh_$1_t;
 allow system_r rssh_$1_r;
 
-type rssh_$1_rw_t, file_type, sysadmfile;
-type rssh_$1_ro_t, file_type, sysadmfile;
+type rssh_$1_rw_t, file_type, sysadmfile, $1_domain_file_type;
+type rssh_$1_ro_t, file_type, sysadmfile, $1_domain_file_type;
 
 general_domain_access(rssh_$1_t);
 uses_shlib(rssh_$1_t);
diff -ru policy/macros/program/screen_macros.te policy.new/macros/program/screen_macros.te
--- policy/macros/program/screen_macros.te	2004-10-02 03:36:13.000000000 +1000
+++ policy.new/macros/program/screen_macros.te	2004-10-26 23:22:33.000000000 +1000
@@ -26,7 +26,7 @@
 typealias $1_home_t alias $1_home_screen_t;
 ', `
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, homedirfile, sysadmfile;
+type $1_home_screen_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
diff -ru policy/macros/program/slocate_macros.te policy.new/macros/program/slocate_macros.te
--- policy/macros/program/slocate_macros.te	2004-09-03 14:10:35.000000000 +1000
+++ policy.new/macros/program/slocate_macros.te	2004-10-26 23:33:57.000000000 +1000
@@ -52,8 +52,8 @@
 allow $1_locate_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_locate_t $1_devpts_t:chr_file rw_file_perms;
 
-allow $1_locate_t { home_root_t $1_home_dir_t $1_home_t }:dir { getattr search };
-allow $1_locate_t $1_home_t:{ file lnk_file } { getattr read };
+allow $1_locate_t $1_domain_file_type:dir { getattr search };
+allow $1_locate_t $1_domain_file_type:{ file lnk_file sock_file fifo_file } { getattr read };
 
 base_file_read_access($1_locate_t)
 r_dir_file($1_locate_t, { etc_t lib_t var_t })
diff -ru policy/macros/program/spamassassin_macros.te policy.new/macros/program/spamassassin_macros.te
--- policy/macros/program/spamassassin_macros.te	2004-10-14 10:10:03.000000000 +1000
+++ policy.new/macros/program/spamassassin_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -80,7 +80,7 @@
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
 # The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile;
+type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 create_dir_file($1_t, $1_home_spamassassin_t)
 allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
 allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
diff -ru policy/macros/program/ssh_macros.te policy.new/macros/program/ssh_macros.te
--- policy/macros/program/ssh_macros.te	2004-10-15 14:57:20.000000000 +1000
+++ policy.new/macros/program/ssh_macros.te	2004-10-26 23:46:14.000000000 +1000
@@ -26,7 +26,7 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_ssh_t, domain, privlog;
-type $1_home_ssh_t, file_type, homedirfile, sysadmfile;
+type $1_home_ssh_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 
 ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
@@ -115,11 +115,6 @@
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
diff -ru policy/macros/program/tvtime_macros.te policy.new/macros/program/tvtime_macros.te
--- policy/macros/program/tvtime_macros.te	2004-10-06 04:52:36.000000000 +1000
+++ policy.new/macros/program/tvtime_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -19,7 +19,7 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, homedirfile, sysadmfile;
+type $1_home_tvtime_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 
 x_client_domain($1, tvtime)
 
diff -ru policy/macros/program/uml_macros.te policy.new/macros/program/uml_macros.te
--- policy/macros/program/uml_macros.te	2004-07-13 09:08:07.000000000 +1000
+++ policy.new/macros/program/uml_macros.te	2004-10-26 23:46:42.000000000 +1000
@@ -25,14 +25,9 @@
 ', `
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
+type $1_uml_exec_t, file_type, sysadmfile, $1_domain_file_type;
+type $1_uml_ro_t, file_type, sysadmfile, $1_domain_file_type;
+type $1_uml_rw_t, file_type, sysadmfile, $1_domain_file_type;
 
 can_ptrace($1_t, $1_uml_t)
 
diff -ru policy/macros/program/vmware_macros.te policy.new/macros/program/vmware_macros.te
--- policy/macros/program/vmware_macros.te	2004-09-25 01:42:14.000000000 +1000
+++ policy.new/macros/program/vmware_macros.te	2004-10-26 23:15:16.000000000 +1000
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
 
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_file_t, homedirfile, file_type, sysadmfile, $1_domain_file_type;
 
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_conf_t, homedirfile, file_type, sysadmfile, $1_domain_file_type;
 
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;
diff -ru policy/macros/program/x_client_macros.te policy.new/macros/program/x_client_macros.te
--- policy/macros/program/x_client_macros.te	2004-09-11 16:21:48.000000000 +1000
+++ policy.new/macros/program/x_client_macros.te	2004-10-26 23:46:20.000000000 +1000
@@ -30,9 +30,9 @@
 ', `
 type $1_$2_t, domain $3;
 # Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, homedirfile, sysadmfile, tmpfile;
+type $1_$2_rw_t, file_type, homedirfile, sysadmfile, tmpfile, $1_domain_file_type;
 # Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, homedirfile, sysadmfile;
+type $1_$2_ro_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 ')
 
 # Transition from the user domain to the derived domain.
@@ -81,11 +81,6 @@
 allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
 allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
 
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:dir { getattr search };
-allow $1_locate_t { $1_$2_ro_t $1_$2_rw_t }:file { getattr read };
-')
-
 # Allow the user domain to send any signal to the $2 process.
 allow $1_t $1_$2_t:process signal_perms;
 
diff -ru policy/macros/program/xauth_macros.te policy.new/macros/program/xauth_macros.te
--- policy/macros/program/xauth_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ policy.new/macros/program/xauth_macros.te	2004-10-26 23:46:26.000000000 +1000
@@ -24,11 +24,7 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, homedirfile, sysadmfile;
-
-ifdef(`slocate.te', `
-allow $1_locate_t $1_home_xauth_t:file { getattr read };
-')
+type $1_home_xauth_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 
 allow $1_xauth_t self:process signal;
 
diff -ru policy/macros/user_macros.te policy.new/macros/user_macros.te
--- policy/macros/user_macros.te	2004-10-20 09:31:18.000000000 +1000
+++ policy.new/macros/user_macros.te	2004-10-27 00:20:47.000000000 +1000
@@ -23,16 +23,16 @@
 ')dnl end single_userdomain
 
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
-type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type, $1_domain_file_type;
+type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_domain_file_type;
 
-tmp_domain($1, `, user_tmpfile')
+tmp_domain($1, `, user_tmpfile, $1_domain_file_type')
 
 # Type and access for pty devices.
-can_create_pty($1, `, userpty_type, user_tty_type')
+can_create_pty($1, `, userpty_type, user_tty_type, $1_domain_file_type')
 
 #Type for tty devices.
-type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_fs;
+type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_fs, $1_domain_file_type;
  
 base_user_domain($1)
 
@@ -135,6 +135,9 @@
 # user_t/$1_t is an unprivileged users domain.
 type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, nscd_client_domain, privfd;
 
+# define an attribute for all files created by this role
+attribute $1_domain_file_type;
+
 # Grant read/search permissions to some of /proc.
 allow $1_t proc_t:dir r_dir_perms;
 allow $1_t proc_t:{ file lnk_file } r_file_perms;

--Boundary-00=_eDmfBRtpqtg3p8W--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
