Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r08H3jp4032451
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2013 12:03:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id F40721A1F2
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2013 18:03:12 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lL5VplGH9ZGS for <selinux@tycho.nsa.gov>;
	Tue,  8 Jan 2013 18:03:07 +0100 (CET)
Received: from soldur.bigon.be (unknown [188.188.93.194])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 8E2781A1BF
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2013 18:03:05 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sepolgen: Use refpolicy_makefile() instead of hardcoding Makefile path
Date: Tue,  8 Jan 2013 18:03:00 +0100
Message-Id: <1357664580-17489-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 sepolgen/src/sepolgen/module.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sepolgen/src/sepolgen/module.py b/sepolgen/src/sepolgen/module.py
index 5818cec..7fc9443 100644
--- a/sepolgen/src/sepolgen/module.py
+++ b/sepolgen/src/sepolgen/module.py
@@ -120,7 +120,7 @@ class ModuleCompiler:
         self.semodule_package = "/usr/bin/semodule_package"
         self.output = output
         self.last_output = ""
-        self.refpol_makefile = "/usr/share/selinux/devel/Makefile"
+        self.refpol_makefile = defaults.refpolicy_makefile()
         self.make = "/usr/bin/make"
 
     def o(self, str):
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
