Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACkBh5015971
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:11 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 14/16] policycoreutils: Fix semange alternative logging code
Date: Fri, 10 May 2013 14:45:22 +0200
Message-Id: <1368189924-8501-15-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Fix semanage logging code when python-audit is not installed
---
 policycoreutils/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 85bc37f..236a182 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -89,7 +89,7 @@ except:
 			self.log_list=[]
 
 		def log(self, msg, name = "", sename = "", serole = "", serange = "", oldsename = "", oldserole = "", oldserange = ""):
-			message += " %s name=%s" % (msg, name)
+			message = " %s name=%s" % (msg, name)
 			if sename != "":
 				message += " sename=" + sename
 			if oldsename != "":
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
