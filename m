Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1B01AXf017137
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 19:01:10 -0500 (EST)
Received: from e36.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1ANxnsR003427
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 23:59:50 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1B018HB030235
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 19:01:08 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1ANx0IC155244
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 16:59:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k1B018Ji008217
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 17:01:08 -0700
Received: from sergelap.hallyn.com (sig-9-65-72-10.mts.ibm.com [9.65.72.10])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k1B01714008202
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 17:01:07 -0700
Date: Fri, 10 Feb 2006 18:01:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: seref: patch: postfix and roles
Message-ID: <20060211000106.GA32469@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Been trying to send mail as a local user, but user_r was not permitted
to associate with postfix_postdrop_t.

Additionally I needed the TODO section uncommented on my system...

thanks,
-serge

Index: refpolicy/policy/modules/services/postfix.if
===================================================================
--- refpolicy.orig/policy/modules/services/postfix.if
+++ refpolicy/policy/modules/services/postfix.if
@@ -393,3 +393,11 @@ interface(`postfix_domtrans_user_mail_ha
 
 	typeattribute $1 postfix_user_domtrans;
 ')
+
+interface(`postfix_role_associate',`
+	gen_require(`
+		role $1;
+	')
+	role $1 types { postfix_postdrop_t };
+	# role $1 types { postfix_postdrop_t postfix_postqueue_t };
+')
Index: refpolicy/policy/modules/services/mta.if
===================================================================
--- refpolicy.orig/policy/modules/services/mta.if
+++ refpolicy/policy/modules/services/mta.if
@@ -224,13 +224,13 @@ template(`mta_per_userdomain_template',`
 		allow $1_mail_t self:capability dac_override;
 		postfix_read_config($1_mail_t)
 		postfix_list_spool($1_mail_t)
+		postfix_role_associate($1_r)
 	')
 
-	ifdef(`TODO',`
 	# Read user temporary files.
 	allow $1_mail_t $1_tmp_t:file r_file_perms;
 	dontaudit $1_mail_t $1_tmp_t:file append;
-	ifdef(`postfix.te',`
+	optional_policy(`postfix',`
 		# postfix seems to need write access if the file handle is opened read/write
 		allow $1_mail_t $1_tmp_t:file write;
 	')
@@ -240,7 +240,6 @@ template(`mta_per_userdomain_template',`
 	# if you do not want to allow dead.letter then use the following instead
 	#allow $1_mail_t { $1_home_dir_t $1_home_t }:dir r_dir_perms;
 	#allow $1_mail_t $1_home_t:file r_file_perms;
-	') dnl end TODO
 ')
 
 ########################################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
