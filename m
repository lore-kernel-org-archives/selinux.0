Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KDY07C000479
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 09:34:00 -0400 (EDT)
Subject: Cleanup of chkpwd and su macros
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 09:30:15 -0400
Message-Id: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here are the changes I made to chkpwd_domain().  I am not sure "allow
$1_t self:netlink_audit_socket create_netlink_socket_perms;" is needed
for non-system domains. 

Index: macros/program/chkpwd_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/chkpwd_macros.te,v
retrieving revision 1.15
diff -u -r1.15 chkpwd_macros.te
--- macros/program/chkpwd_macros.te	16 Feb 2005 19:40:17 -0000	1.15
+++ macros/program/chkpwd_macros.te	19 Apr 2005 13:42:41 -0000
@@ -17,30 +17,27 @@
 # Derived domain based on the calling user domain and the program.
 type $1_chkpwd_t, domain, privlog, nscd_client_domain, auth;
 
+role $1_r types $1_chkpwd_t;
+
 # is_selinux_enabled
 allow $1_chkpwd_t proc_t:file read;
+
 can_getcon($1_chkpwd_t)
 can_ypbind($1_chkpwd_t)
 can_kerberos($1_chkpwd_t)
 can_ldap($1_chkpwd_t)
 can_resolve($1_chkpwd_t)
-# Transition from the user domain to this domain.
+
 ifelse($1, system, `
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
-role system_r types system_chkpwd_t;
-dontaudit auth_chkpwd shadow_t:file { getattr read };
 allow auth_chkpwd sbin_t:dir search;
-dontaudit $1_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
-can_ypbind(auth_chkpwd)
-can_kerberos(auth_chkpwd)
-can_ldap(auth_chkpwd)
-can_resolve(auth_chkpwd)
+allow auth_chkpwd self:netlink_audit_socket create_netlink_socket_perms;
+dontaudit system_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
+dontaudit auth_chkpwd shadow_t:file { getattr read };
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
-
-# The user role is authorized for this domain.
-role $1_r types $1_chkpwd_t;
+allow $1_t self:netlink_audit_socket create_netlink_socket_perms;
 
 # Write to the user domain tty.
 access_terminal($1_chkpwd_t, $1)


Here are the changes to the su macros.  user_su_t definitely needs the
"allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;"
rule, but now that I look at it again I don't know why I put it in the
ifdef.  The ifdef is not really needed anyway since chkpwd.te is in
domains/program, not domains/program/unused.  I don't know why both the
domain_auto_trans rule (in su_restricted_domain()) and the can_exec rule
(in su_domain() which uses su_restricted_domain()) would be needed.

Index: macros/program/su_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/su_macros.te,v
retrieving revision 1.36
diff -u -r1.36 su_macros.te
--- macros/program/su_macros.te	10 Mar 2005 21:07:51 -0000	1.36
+++ macros/program/su_macros.te	19 Apr 2005 16:29:38 -0000
@@ -32,7 +32,6 @@
 domain_auto_trans($1_t, su_exec_t, $1_su_t)
 
 allow $1_su_t sbin_t:dir search;
-domain_auto_trans($1_su_t, chkpwd_exec_t, $2_chkpwd_t)
 
 uses_shlib($1_su_t)
 allow $1_su_t etc_t:file { getattr read };
@@ -88,6 +87,12 @@
 allow $1_su_t { var_t var_run_t }:dir search;
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
 can_kerberos($1_su_t)
+
+ifdef(`chkpwd.te', `
+domain_auto_trans($1_su_t, chkpwd_exec_t, $2_chkpwd_t)
+allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;
+')
+
 ') dnl end su_restricted_domain
 
 define(`su_mini_domain', `
@@ -109,10 +114,6 @@
 
 define(`su_domain', `
 su_mini_domain($1)
-ifdef(`chkpwd.te', `
-# Run chkpwd.
-can_exec($1_su_t, chkpwd_exec_t)
-')
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_su_t $1_gph_t:fd use;')

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
