Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7KKXDoR022459
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 16:33:14 -0400
Received: from tex.courtesan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7KKXB63010572
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 20:33:12 GMT
Received: from tex.courtesan.com (smmsp@localhost [127.0.0.1])
	by tex.courtesan.com (8.14.1/8.13.8) with ESMTP id l7KKWX22000993
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 16:32:33 -0400 (EDT)
Date: Mon, 20 Aug 2007 16:32:32 -0400 (EDT)
Message-Id: <200708202032.l7KKWWCY009001@tex.courtesan.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
From: "Todd C. Miller" <tmiller@tresys.com>
Subject: [PATCH] genhomedircon: fix find() return value usage
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug in the genhomedircon python script that would
ignore valid entries such as:

/tmp/\.exchange-USER(/.*)?  system_u:object_r:ROLE_evolution_exchange_tmp_t:s0

With this fix the python genhomedircon and the C replacement produce
equivalent output.

Signed-Off-By: Todd Miller <tmiller@tresys.com>

Index: policycoreutils/scripts/genhomedircon
===================================================================
--- policycoreutils/scripts/genhomedircon	(revision 2519)
+++ policycoreutils/scripts/genhomedircon	(working copy)
@@ -272,7 +272,7 @@
 		ret = ""
 		fd = open(self.getHomeDirTemplate(), 'r')
 		for i in  fd.readlines():
-			if i.find("USER") == 1:
+			if i.find("USER") >= 0:
 				i = i.replace("USER", user)
 				i = i.replace("ROLE", prefix)
 				i = i.replace("system_u", sel_user)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
