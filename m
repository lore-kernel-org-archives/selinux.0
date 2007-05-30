Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaqZS013761
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHao2p008209
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:40:46 -0400
Message-Id: <200705301540.l4UFekZN011834@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_uml changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove TODO

--- nsaserefpolicy/policy/modules/apps/uml.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/uml.if	2007-05-30 09:25:53.000000000 -0400
@@ -193,33 +193,6 @@
 		nis_use_ypbind($1_uml_t)
 	')
 
-	ifdef(`TODO',`
-		# for X
-		optional_policy(`
-			ifelse($1, sysadm,`
-			',`
-				optional_policy(`
-					allow $1_uml_t xdm_xserver_tmp_t:dir search;
-				')
-				allow $1_uml_t $1_xserver_tmp_t:sock_file write;
-				allow $1_uml_t $1_xserver_t:unix_stream_socket connectto;
-			')
-		')
-
-		optional_policy(`
-			# for uml_net
-			domain_auto_trans($1_uml_t, uml_net_exec_t, uml_net_t)
-			allow uml_net_t $1_uml_t:unix_stream_socket { read write };
-			allow uml_net_t $1_uml_t:unix_dgram_socket { read write };
-			dontaudit uml_net_t privfd:fd use;
-			can_access_pty(uml_net_t, $1_uml)
-			dontaudit uml_net_t $1_uml_rw_t:dir { getattr search };
-		')
-		#TODO
-		optional_policy(`
-			allow $1_uml_t $1_xauth_home_t:file { getattr read };
-		')
-	')
 ')
 
 ########################################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
