Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JvYsW021217
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:57:34 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JvWOD028492
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:57:32 GMT
Date: Thu, 2 Aug 2007 15:56:28 -0400
Message-Id: <200708021956.l72JuSF2029434@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_usernetctl changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No one uses this boolean
--- nsaserefpolicy/policy/modules/apps/usernetctl.te	2007-07-25 10:37:37.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/usernetctl.te	2007-08-02 11:02:02.000000000 -0400
@@ -6,14 +6,6 @@
 # Declarations
 #
 
-## <desc>
-## <p>
-## Allow users to control network interfaces
-## (also needs USERCTL=true)
-## </p>
-## </desc>
-gen_tunable(user_net_control,false)
-
 type usernetctl_t;
 type usernetctl_exec_t;
 application_domain(usernetctl_t,usernetctl_exec_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
