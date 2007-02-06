Date: Tue, 6 Feb 2007 11:23:20 -0500
From: Caleb Case <ccase@tresys.com>
Message-Id: <200702061623.l16GNK3S017381@localhost.localdomain>
To: ccase@tresys.com, sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: policycoreutils/semanage/seobject.py:setransRecords: improper string subst
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A small fix for the wrong number of arguments for python string substitution.
---
 policycoreutils/semanage/seobject.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: selinux-pms-support/policycoreutils/semanage/seobject.py
===================================================================
--- selinux-pms-support.orig/policycoreutils/semanage/seobject.py
+++ selinux-pms-support/policycoreutils/semanage/seobject.py
@@ -139,7 +139,7 @@ class setransRecords:
 			translations = fd.readlines()
 			fd.close()
 		except IOError, e:
-			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines") % (self.filename, e) )			
+			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines") % (self.filename) )
 			
 		self.ddict = {}
 		self.comments = []

-- 
Caleb Case
Tresys Technology
410.290.1411 x144


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
