Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q92FAXlo026546
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2012 11:10:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 9EE541AAD9
	for <selinux@tycho.nsa.gov>; Tue,  2 Oct 2012 17:10:24 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-RMKbp3mfmb for <selinux@tycho.nsa.gov>;
	Tue,  2 Oct 2012 17:10:19 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B3FB21A095
	for <selinux@tycho.nsa.gov>; Tue,  2 Oct 2012 17:10:18 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: Fix semange alternative logging code
Date: Tue,  2 Oct 2012 17:10:15 +0200
Message-Id: <1349190615-15198-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Fix semanage logging code when python-audit is not installed
---
 policycoreutils/semanage/seobject.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index ad7dc8c..42d246f 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -87,7 +87,7 @@ except:
 			self.log_list=[]
 
 		def log(self, msg, name = "", sename = "", serole = "", serange = "", oldsename = "", oldserole = "", oldserange = ""):
-			message += " %s name=%s" % (msg, name)
+			message = " %s name=%s" % (msg, name)
 			if sename != "":
 				message += " sename=" + sename
 			if oldsename != "":
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
