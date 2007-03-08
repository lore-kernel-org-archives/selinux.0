Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FZH0o007494
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:35:17 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FZHY3014292
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:35:17 GMT
Message-ID: <45F02D32.2040508@redhat.com>
Date: Thu, 08 Mar 2007 10:35:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: ipsec tools domtrans patch
Content-Type: multipart/mixed;
 boundary="------------090006020901050600010800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090006020901050600010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090006020901050600010800
Content-Type: text/x-patch;
 name="ipsec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipsec.patch"

--- nsaserefpolicy/policy/modules/system/ipsec.if	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/ipsec.if	2007-03-08 10:31:24.000000000 -0500
@@ -111,3 +111,103 @@
 	files_search_pids($1)
 	manage_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
 ')
+
+########################################
+## <summary>
+##	Allow an IPsec SA to be used by an IPsec Policy.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_labeled',`
+	gen_require(`
+		type ipsec_spd_t;
+	')
+
+	allow $1 ipsec_spd_t:association polmatch;
+	domain_ipsec_labels($1)
+')
+
+
+########################################
+## <summary>
+##	Execute racoon in the racoon domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_domtrans_racoon',`
+	gen_require(`
+		type racoon_t, racoon_exec_t;
+	')
+
+	domain_auto_trans($1,racoon_exec_t,racoon_t)
+
+	allow $1 racoon_t:fd use;
+	allow racoon_t $1:fd use;
+	allow racoon_t $1:fifo_file rw_file_perms;
+	allow racoon_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute setkey in the setkey domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_domtrans_setkey',`
+	gen_require(`
+		type setkey_t, setkey_exec_t;
+	')
+	domain_auto_trans($1,setkey_exec_t,setkey_t)
+
+	allow $1 setkey_t:fd use;
+	allow setkey_t $1:fd use;
+	allow setkey_t $1:fifo_file rw_file_perms;
+	allow setkey_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute ipsec-tools in the setkey and racoon domains
+##	and allow the specified role the domains.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the racoon and setkey domains.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the racoon and setkey domains to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`ipsec_run_tools',`
+	gen_require(`
+		type racoon_t, setkey_t;
+	')
+	ipsec_domtrans_racoon($1)
+	role $2 types racoon_t;
+	allow racoon_t $3:chr_file rw_term_perms;
+	
+	ipsec_domtrans_setkey($1)
+	role $2 types setkey_t;
+	allow setkey_t $3:chr_file rw_term_perms;
+')
--- nsaserefpolicy/policy/modules/kernel/domain.if	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/domain.if	2007-03-08 08:42:36.000000000 -0500
@@ -1254,3 +1254,21 @@
 	typeattribute $1 can_change_object_identity;
 	typeattribute $1 set_curr_context;
 ')
+
+########################################
+## <summary>
+##	Allow specified type to associate ipsec packets from any domain
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type of subject to be allowed this.
+##	</summary>
+## </param>
+#
+interface(`domain_ipsec_labels',`
+	gen_require(`
+		attribute domain;
+ 	')
+ 
+	allow $1 domain:association { sendto recvfrom };
+')
--- nsaserefpolicy/policy/modules/system/userdomain.if	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/userdomain.if	2007-03-08 10:30:10.000000000 -0500
@@ -1313,6 +1318,8 @@
 
 	init_exec($1)
 
+	ipsec_run_tools($1,$2,$3)
+
 	logging_send_syslog_msg($1)
 	logging_read_audit_log($1)
 	logging_read_generic_logs($1)

--------------090006020901050600010800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
