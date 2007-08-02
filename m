Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Jd5nn019785
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:39:05 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Jd4OD024908
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:39:04 GMT
Date: Thu, 2 Aug 2007 15:38:52 -0400
Message-Id: <200708021938.l72Jcqqx028906@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: admin_vbetool changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/admin/vbetool.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/vbetool.te	2007-08-02 11:02:02.000000000 -0400
@@ -32,4 +32,5 @@
 
 optional_policy(`
 	hal_rw_pid_files(vbetool_t)
+	hal_write_log(vbetool_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
