Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kASKMXwl019565
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 15:22:33 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kASKKont021787
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 20:20:51 GMT
Message-ID: <456C9A9E.3090608@redhat.com>
Date: Tue, 28 Nov 2006 15:22:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Missing gen_requires for building additional user types in modules
Content-Type: multipart/mixed;
 boundary="------------030803040307050408010707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030803040307050408010707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030803040307050408010707
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- ./apps/mozilla.if~	2006-11-27 17:27:46.000000000 -0500
+++ ./apps/mozilla.if	2006-11-28 14:45:07.000000000 -0500
@@ -33,7 +33,11 @@
 ## </param>
 #
 template(`mozilla_per_role_template',`
-	
+	gen_require(`
+		type mozilla_exec_t;
+		type mozilla_conf_t;
+	')
+
 	########################################
 	#
 	# Declarations
--- ./apps/loadkeys.if~	2006-11-27 17:27:46.000000000 -0500
+++ ./apps/loadkeys.if	2006-11-28 15:10:28.000000000 -0500
@@ -50,18 +50,13 @@
 ## <rolecap/>
 #
 interface(`loadkeys_run',`
-	ifdef(`targeted_policy',`
-		# $0(): disabled in targeted policy as there
-		# is no loadkeys domain.
-	',`
-		gen_require(`
-			type loadkeys_t;
-		')
-
-		loadkeys_domtrans($1)
-		role $2 types loadkeys_t;
-		allow loadkeys_t $3:chr_file rw_term_perms;
+	gen_require(`
+		type loadkeys_t;
 	')
+
+	loadkeys_domtrans($1)
+	role $2 types loadkeys_t;
+	allow loadkeys_t $3:chr_file rw_term_perms;
 ')
 
 ########################################
--- ./services/xserver.if~	2006-11-27 17:27:46.000000000 -0500
+++ ./services/xserver.if	2006-11-28 15:19:10.000000000 -0500
@@ -13,6 +13,9 @@
 ## </param>
 #
 template(`xserver_common_domain_template',`
+	gen_require(`
+		type xserver_exec_t, xkb_var_lib_t, xserver_log_t;
+	')
 
 	##############################
 	#
@@ -222,6 +225,11 @@
 #
 template(`xserver_per_role_template',`
 
+	gen_require(`
+		type iceauth_exec_t, xauth_exec_t;
+		attribute fonts_type, fonts_cache_type, fonts_config_type;
+	')
+
 	##############################
 	#
 	# Declarations
--- ./system/userdomain.if~	2006-11-27 17:27:46.000000000 -0500
+++ ./system/userdomain.if	2006-11-28 15:10:48.000000000 -0500
@@ -654,6 +654,9 @@
 ## </param>
 #
 template(`userdom_common_user_template',`
+	gen_require(`
+		attribute unpriv_userdomain;
+	')
 
 	userdom_base_user_template($1)
 
@@ -916,6 +919,11 @@
 ## </param>
 #
 template(`userdom_unpriv_user_template', `
+
+	gen_require(`
+		attribute user_ptynode, user_home_dir_type, user_home_type, user_tmpfile, user_ttynode, privhome;
+	')
+
 	##############################
 	#
 	# Declarations
@@ -1051,7 +1059,7 @@
 template(`userdom_admin_user_template',`
 	gen_require(`
 		class passwd { passwd chfn chsh rootok crontab };
-		attribute admin_terminal;
+		attribute admin_terminal, privhome;
 	')
 
 	##############################

--------------030803040307050408010707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
