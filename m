Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JE9KN7022878
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 10:09:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JE9IUG011311
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:09:18 GMT
Message-ID: <46277806.3050307@redhat.com>
Date: Thu, 19 Apr 2007 10:09:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Remove admin templates from userdom_admin_user_template
Content-Type: multipart/mixed;
 boundary="------------020805010807000501040604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020805010807000501040604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020805010807000501040604
Content-Type: text/x-patch;
 name="userdomain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="userdomain.patch"

--- nsaserefpolicy/policy/modules/system/userdomain.if	2007-03-26 16:24:13.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/userdomain.if	2007-04-19 09:43:55.000000000 -0400
@@ -1225,22 +1230,6 @@
 	')
 
 	optional_policy(`
-		cron_admin_template($1,$1_t,$1_r)
-	')
-
-	optional_policy(`
-		ethereal_admin_template($1,$1_t,$1_r)
-	')
-
-	optional_policy(`
-		lpr_admin_template($1,$1_t,$1_r)
-	')
-
-	optional_policy(`
-		mta_admin_template($1,$1_t,$1_r)
-	')
-
-	optional_policy(`
 		userhelper_exec($1_t)
 	')
 ')
--- nsaserefpolicy/policy/modules/system/userdomain.te	2007-03-26 16:24:13.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/userdomain.te	2007-04-19 09:48:39.000000000 -0400
@@ -101,10 +102,27 @@
 # Local policy
 #
 
+userdom_unpriv_user_template(user)
 ifdef(`strict_policy',`
 	userdom_admin_user_template(sysadm)
+
+	optional_policy(`
+		cron_admin_template(sysadm,sysadm_t,sysadm_r)
+	')
+
+	optional_policy(`
+		ethereal_admin_template(sysadm,sysadm_t,sysadm_r)
+	')
+
+	optional_policy(`
+		lpr_admin_template(sysadm,sysadm_t,sysadm_r)
+	')
+
+	optional_policy(`
+		mta_admin_template(sysadm,sysadm_t,sysadm_r)
+	')
+
 	userdom_unpriv_user_template(staff)
-	userdom_unpriv_user_template(user)
 
 	# user role change rules:
 	# sysadm_r can change to user roles

--------------020805010807000501040604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
