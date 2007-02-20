Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGUJOo032593
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:30:19 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGVZQc014252
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:31:36 GMT
Message-ID: <45DB2260.30703@redhat.com>
Date: Tue, 20 Feb 2007 11:31:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: policy changes to userdomain.if
Content-Type: multipart/mixed;
 boundary="------------090606050906010400020209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090606050906010400020209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove ifdef strict_policy,  We want to support user roles within 
targeted policy



--------------090606050906010400020209
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_system_userdomain.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_system_userdomain.if"

--- nsaserefpolicy/policy/modules/system/userdomain.if	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/system/userdomain.if	2007-02-19 16:41:57.000000000 -0500
@@ -1368,11 +1373,7 @@
 ## <rolecap/>
 #
 template(`userdom_role_change_generic_user',`
-	ifdef(`strict_policy',`
-		userdom_role_change_template($1,user)
-	',`
-		refpolicywarn(`$0($*) has no effect in targeted policy.')
-	')
+	userdom_role_change_template($1,user)
 ')
 
 ########################################
@@ -1713,13 +1714,11 @@
 ## </param>
 #
 template(`userdom_setattr_user_ptys',`
-	ifdef(`strict_policy',`
-		gen_require(`
-			type $1_devpts_t;
-		')
-
-		allow $2 $1_devpts_t:chr_file setattr;
+	gen_require(`
+		type $1_devpts_t;
 	')
+
+	allow $2 $1_devpts_t:chr_file setattr;
 ')
 
 ########################################
@@ -1748,13 +1747,11 @@
 ## </param>
 #
 template(`userdom_create_user_pty',`
-	ifdef(`strict_policy',`
-		gen_require(`
-			type $1_devpts_t;
-		')
-
-		term_create_pty($2,$1_devpts_t)
+	gen_require(`
+		type $1_devpts_t;
 	')
+
+	term_create_pty($2,$1_devpts_t)
 ')
 
 ########################################
@@ -3639,13 +3636,12 @@
 template(`userdom_setattr_user_ttys',`
 	ifdef(`targeted_policy',`
 		term_setattr_unallocated_ttys($2)
-	',`
-		gen_require(`
-			type $1_tty_device_t;
-		')
-
-		allow $2 $1_tty_device_t:chr_file setattr;
 	')
+	gen_require(`
+		type $1_tty_device_t;
+	')
+
+	allow $2 $1_tty_device_t:chr_file setattr;
 ')
 
 ########################################
@@ -3676,13 +3672,12 @@
 template(`userdom_use_user_ttys',`
 	ifdef(`targeted_policy',`
 		term_use_unallocated_ttys($2)
-	',`
-		gen_require(`
-			type $1_tty_device_t;
-		')
-
-		allow $2 $1_tty_device_t:chr_file rw_term_perms;
 	')
+	gen_require(`
+		type $1_tty_device_t;
+	')
+
+	allow $2 $1_tty_device_t:chr_file rw_term_perms;
 ')
 
 ########################################
@@ -3711,18 +3706,13 @@
 ## </param>
 #
 template(`userdom_use_user_terminals',`
-	ifdef(`targeted_policy',`
-		term_use_unallocated_ttys($2)
-		term_use_generic_ptys($2)
-	',`
-		gen_require(`
-			type $1_tty_device_t, $1_devpts_t;
-		')
-
-		allow $2 $1_tty_device_t:chr_file rw_term_perms;
-		allow $2 $1_devpts_t:chr_file rw_term_perms;
-		term_list_ptys($2)
+	gen_require(`
+		type $1_tty_device_t, $1_devpts_t;
 	')
+
+	allow $2 $1_tty_device_t:chr_file rw_term_perms;
+	allow $2 $1_devpts_t:chr_file rw_term_perms;
+	term_list_ptys($2)
 ')
 
 ########################################
@@ -5386,14 +5376,13 @@
 interface(`userdom_use_unpriv_users_ptys',`
 	ifdef(`targeted_policy',`
 		term_use_generic_ptys($1)
-	',`
-		gen_require(`
-			attribute user_ptynode;
-		')
-
-		term_search_ptys($1)
-		allow $1 user_ptynode:chr_file rw_file_perms;
 	')
+	gen_require(`
+		attribute user_ptynode;
+	')
+
+	term_search_ptys($1)
+	allow $1 user_ptynode:chr_file rw_file_perms;
 ')
 
 ########################################
@@ -5410,13 +5399,13 @@
 interface(`userdom_dontaudit_use_unpriv_users_ptys',`
 	ifdef(`targeted_policy',`
 		term_dontaudit_use_generic_ptys($1)
-	',`
-		gen_require(`
-			attribute user_ptynode;
-		')
+	')
 
-		dontaudit $1 user_ptynode:chr_file rw_file_perms;
+	gen_require(`
+		attribute user_ptynode;
 	')
+
+	dontaudit $1 user_ptynode:chr_file rw_file_perms;
 ')
 
 ########################################
@@ -5469,13 +5458,12 @@
 interface(`userdom_list_unpriv_users_tmp',`
 	ifdef(`targeted_policy',`
 		files_list_tmp($1)
-	',`
-		gen_require(`
-			attribute user_tmpfile;
-		')
-
-		allow $1 user_tmpfile:dir list_dir_perms;
 	')
+	gen_require(`
+		attribute user_tmpfile;
+	')
+
+	allow $1 user_tmpfile:dir list_dir_perms;
 ')
 
 ########################################
@@ -5491,13 +5479,12 @@
 interface(`userdom_read_unpriv_users_tmp_files',`
 	ifdef(`targeted_policy',`
 		files_read_generic_tmp_files($1)
-	',`
-		gen_require(`
-			attribute user_tmpfile;
-		')
-
-		allow $1 user_tmpfile:file { read getattr };
 	')
+	gen_require(`
+		attribute user_tmpfile;
+	')
+
+	allow $1 user_tmpfile:file { read getattr };
 ')
 
 ########################################
@@ -5513,13 +5500,12 @@
 interface(`userdom_read_unpriv_users_tmp_symlinks',`
 	ifdef(`targeted_policy',`
 		files_read_generic_tmp_symlinks($1)
-	',`
-		gen_require(`
-			attribute user_tmpfile;
-		')
-
-		allow $1 user_tmpfile:lnk_file { getattr read };
 	')
+	gen_require(`
+		attribute user_tmpfile;
+	')
+
+	allow $1 user_tmpfile:lnk_file { getattr read };
 ')
 
 ########################################
@@ -5553,13 +5539,12 @@
 interface(`userdom_use_unpriv_users_ttys',`
 	ifdef(`targeted_policy',`
 		term_use_unallocated_ttys($1)
-	',`
-		gen_require(`
-			attribute user_ttynode;
-		')
-
-		allow $1 user_ttynode:chr_file rw_term_perms;
 	')
+	gen_require(`
+		attribute user_ttynode;
+	')
+
+	allow $1 user_ttynode:chr_file rw_term_perms;
 ')
 
 ########################################
@@ -5576,13 +5561,12 @@
 interface(`userdom_dontaudit_use_unpriv_users_ttys',`
 	ifdef(`targeted_policy',`
 		term_dontaudit_use_unallocated_ttys($1)
-	',`
-		gen_require(`
-			attribute user_ttynode;
-		')
-
-		dontaudit $1 user_ttynode:chr_file rw_file_perms;
 	')
+	gen_require(`
+		attribute user_ttynode;
+	')
+
+	dontaudit $1 user_ttynode:chr_file rw_file_perms;
 ')
 
 ########################################

--------------090606050906010400020209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
