Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6EH86qJ012938
 for <selinux@tycho.nsa.gov>; Tue, 14 Jul 2015 13:08:08 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 6E28C1A1D8
 for <selinux@tycho.nsa.gov>; Tue, 14 Jul 2015 19:08:01 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rflqEX9yiOxq for <selinux@tycho.nsa.gov>;
 Tue, 14 Jul 2015 19:07:58 +0200 (CEST)
Received: from soldur.bigon.be (unknown [193.53.238.195])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 353FD1A1D5
 for <selinux@tycho.nsa.gov>; Tue, 14 Jul 2015 19:07:58 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Set self.sename to sename after calling
 semanage_seuser_set_sename()
Date: Tue, 14 Jul 2015 19:07:56 +0200
Message-Id: <1436893676-21412-1-git-send-email-bigon@debian.org>
Cc: 734806@bugs.debian.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

This fixes audit information that are being logged and a crash when the
python-audit binding is not installed.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=734806
---
 policycoreutils/semanage/seobject.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 568ebfd..2edb050 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -575,6 +575,7 @@ class loginRecords(semanageRecords):
 
 		if sename != "":
 			semanage_seuser_set_sename(self.sh, u, sename)
+                        self.sename = sename
 		else:
 			self.sename = self.oldsename
 			
-- 
2.1.4
