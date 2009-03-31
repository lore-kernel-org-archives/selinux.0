Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VJg2sT006271
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 15:42:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n2VJg1TQ017176
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 19:42:02 GMT
Subject: sepolgen typo fix
From: Marshall Miller <mmiller@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 31 Mar 2009 15:42:00 -0400
Message-Id: <1238528520.18182.338.camel@hostmachine.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Commit b3b3f8186ed6d56c48c4e0f997d6e6b3fd90be37 attempted to fix a bug,
but didn't.  The following patch should do it.


Marshall Miller

---
diff --git a/sepolgen/src/sepolgen/access.py
b/sepolgen/src/sepolgen/access.py
index 6de919a..71121d7 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -313,7 +313,7 @@ class RoleTypeSet:
 
     def __len__(self):
         """Return the unique number of role allow statements."""
-        return len(self.role_type.keys())
+        return len(self.role_types.keys())
 
     def add(self, role, type):
         if self.role_types.has_key(role):


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
