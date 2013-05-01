Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41KQkWZ021644
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 16:26:46 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so1858192wie.12
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 13:26:43 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id fp2sm34350990wib.7.2013.05.01.13.26.41
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 13:26:42 -0700 (PDT)
Date: Wed, 1 May 2013 22:25:58 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Fix referenced before assignment error
Message-ID: <20130501202558.GA22742@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Python warns with

  UnboundLocalError: local variable 'message' referenced before assignment

Assigning the first value to message, and append later.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
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
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
