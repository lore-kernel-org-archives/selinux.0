Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KOobw023837
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:24:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KOnM1004898
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:24:49 GMT
Date: Thu, 2 Aug 2007 16:24:43 -0400
Message-Id: <200708022024.l72KOhMT032040@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_miscfiles changes new fonts dir
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/miscfiles.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/miscfiles.fc	2007-08-02 11:02:02.000000000 -0400
@@ -66,6 +66,7 @@
 /var/lib/texmf(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)
 
 /var/cache/fonts(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)
+/var/cache/fontconfig(/.*)?	gen_context(system_u:object_r:fonts_t,s0)
 /var/cache/man(/.*)?		gen_context(system_u:object_r:man_t,s0)
 
 /var/spool/texmf(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
