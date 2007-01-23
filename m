Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0NEnVvL032438
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2007 09:49:31 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0NEoTlv002299
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2007 14:50:29 GMT
Message-ID: <45B62073.5040405@redhat.com>
Date: Tue, 23 Jan 2007 09:49:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Simple patch to policy to allow interfaces 
Content-Type: multipart/mixed;
 boundary="------------060002010409010302010304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060002010409010302010304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060002010409010302010304
Content-Type: text/plain;
 name="newdiff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newdiff"

--- nsaserefpolicy/policy/modules/apps/ethereal.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/ethereal.if	2007-01-23 09:18:28.000000000 -0500
@@ -34,6 +34,10 @@
 #
 template(`ethereal_per_role_template',`
 
+	gen_require(`
+		type ethereal_exec_t;
+	')
+
 	##############################
 	#
 	# Declarations
--- nsaserefpolicy/policy/modules/apps/games.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/games.if	2007-01-23 09:19:04.000000000 -0500
@@ -33,6 +33,10 @@
 ## </param>
 #
 template(`games_per_role_template',`
+	gen_require(`
+		type games_exec_t;
+		type games_data_t;
+	')
 
 	########################################
 	#
--- nsaserefpolicy/policy/modules/apps/mplayer.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/mplayer.if	2007-01-23 09:18:45.000000000 -0500
@@ -33,6 +33,10 @@
 ## </param>
 #
 template(`mplayer_per_role_template',`
+	gen_require(`
+		type mencoder_exec_t;
+		type mplayer_exec_t;
+	')
 
 	########################################
 	#
--- nsaserefpolicy/policy/modules/apps/tvtime.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/tvtime.if	2007-01-23 09:18:33.000000000 -0500
@@ -33,6 +33,9 @@
 ## </param>
 #
 template(`tvtime_per_role_template',`
+	gen_require(`
+		type tvtime_exec_t;
+	')
 
 	########################################
 	#
--- nsaserefpolicy/policy/modules/apps/uml.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/uml.if	2007-01-23 09:18:55.000000000 -0500
@@ -34,6 +34,11 @@
 #
 template(`uml_per_role_template',`
 	
+	gen_require(`
+		type uml_ro_t;
+		type uml_exec_t;
+	')
+
 	########################################
 	#
 	# Declarations
--- nsaserefpolicy/policy/modules/apps/vmware.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/apps/vmware.if	2007-01-23 09:19:00.000000000 -0500
@@ -33,6 +33,10 @@
 ## </param>
 #
 template(`vmware_per_role_template',`
+	gen_require(`
+		type vmware_exec_t;
+		type vmware_sys_conf_t;
+	')
 
 	##############################
 	#
--- nsaserefpolicy/policy/modules/services/ftp.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/services/ftp.if	2007-01-23 09:19:24.000000000 -0500
@@ -24,6 +24,10 @@
 ## </param>
 #
 template(`ftp_per_role_template',`
+	gen_require(`
+		type ftpd_t;
+	')
+
 	tunable_policy(`ftpd_is_daemon',`
 		userdom_manage_user_home_content_files($1,ftpd_t)
 		userdom_manage_user_home_content_symlinks($1,ftpd_t)
--- nsaserefpolicy/policy/modules/services/razor.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/services/razor.if	2007-01-23 09:19:30.000000000 -0500
@@ -23,6 +23,12 @@
 ## </param>
 #
 template(`razor_common_domain_template',`
+	gen_require(`
+		type razor_exec_t;
+		type razor_etc_t;
+		type razor_log_t;
+		type razor_var_lib_t;
+	')
 
 	allow $1_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 	allow $1_t self:fd use;
@@ -131,6 +137,9 @@
 ## </param>
 #
 template(`razor_per_role_template',`
+	gen_require(`
+		type razor_exec_t;
+	')
 
 	type $1_razor_t;
 	domain_type($1_razor_t)
--- nsaserefpolicy/policy/modules/services/spamassassin.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.1/policy/modules/services/spamassassin.if	2007-01-23 09:19:34.000000000 -0500
@@ -35,6 +35,12 @@
 # toggled on activation of spamc, and similarly for spamd.
 template(`spamassassin_per_role_template',`
 
+	gen_require(`
+		type spamc_exec_t;
+		type spamassassin_exec_t;
+		type spamd_t, spamd_tmp_t;
+	')
+
 	##############################
 	#
 	# Declarations

--------------060002010409010302010304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
