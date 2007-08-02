Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Ki5BF026004
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:44:05 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Ki1Tm007464
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:44:02 GMT
Date: Thu, 2 Aug 2007 16:43:37 -0400
Message-Id: <200708022043.l72KhbOk032675@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_pyzor changes - Fix interface
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/pyzor.if	2007-06-11 16:05:30.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/pyzor.if	2007-08-02 11:02:02.000000000 -0400
@@ -25,16 +25,16 @@
 #
 template(`pyzor_per_role_template',`
 	gen_require(`
-		type pyzord_t;
+		type pyzor_t;
 	')
 
 	type $1_pyzor_home_t;
 	userdom_user_home_content($1,$1_pyzor_home_t)
 
-	manage_dirs_pattern(pyzord_t,$1_pyzor_home_t,$1_pyzor_home_t)
-	manage_files_pattern(pyzord_t,$1_pyzor_home_t,$1_pyzor_home_t)
-	manage_lnk_files_pattern(pyzord_t,$1_pyzor_home_t,$1_pyzor_home_t)
-	userdom_user_home_dir_filetrans($1,pyzord_t,$1_pyzor_home_t,{ dir file lnk_file })
+	manage_dirs_pattern(pyzor_t,$1_pyzor_home_t,$1_pyzor_home_t)
+	manage_files_pattern(pyzor_t,$1_pyzor_home_t,$1_pyzor_home_t)
+	manage_lnk_files_pattern(pyzor_t,$1_pyzor_home_t,$1_pyzor_home_t)
+	userdom_user_home_dir_filetrans($1,pyzor_t,$1_pyzor_home_t,{ dir file lnk_file })
 ')
 
 ########################################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
