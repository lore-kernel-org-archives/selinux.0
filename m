Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB9JP7pQ005914
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2013 14:25:11 -0500
Received: by mail-wi0-f182.google.com with SMTP id en1so4248255wid.9
        for <selinux@tycho.nsa.gov>; Mon, 09 Dec 2013 11:25:08 -0800 (PST)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id uc18sm27520721wib.11.2013.12.09.11.25.06
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 11:25:07 -0800 (PST)
Date: Mon, 9 Dec 2013 20:23:48 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Ignore selevel/serange if MLS is disabled
Message-ID: <20131209192348.GA3638@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, the selevel/serange values (which are often set on a default
's0' value) are used for ports, users, contexts and logins. This breaks
non-MLS setups.

This patch will only call the necessary mls functions if mls is actually
enabled.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/semanage/seobject.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 00b085e..f8d2243 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -511,7 +511,7 @@ class loginRecords(semanageRecords):
                 if rc < 0:
                        raise ValueError(_("Could not set name for %s") % name)
 
-                if serange != "":
+                if (is_mls_enabled == 1) and (serange != ""):
                        rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
                        if rc < 0:
                               raise ValueError(_("Could not set MLS range for %s") % name)
@@ -571,7 +571,7 @@ class loginRecords(semanageRecords):
 		
 		self.oldserange = semanage_seuser_get_mlsrange(u)
 		self.oldsename = semanage_seuser_get_sename(u)
-		if serange != "":
+		if (is_mls_enabled == 1) and (serange != ""):
 			semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
 
 		if sename != "":
@@ -838,9 +838,9 @@ class seluserRecords(semanageRecords):
                 if rc >= 0:
                        oldserole = string.join(rlist, ' ');
 
-                if serange != "":
+                if (is_mls_enabled == 1) and (serange != ""):
                        semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
-                if selevel != "":
+                if (is_mls_enabled == 1) and (selevel != ""):
                        semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
 
                 if prefix != "":
@@ -1058,7 +1058,7 @@ class portRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError(_("Could not set type in port context for %s/%s") % (proto, port))
 
-		if serange != "":
+		if (is_mls_enabled == 1) and (serange != ""):
 			rc = semanage_context_set_mls(self.sh, con, serange)
 			if rc < 0:
 				raise ValueError(_("Could not set mls fields in port context for %s/%s") % (proto, port))
@@ -1104,7 +1104,7 @@ class portRecords(semanageRecords):
 
 		con = semanage_port_get_con(p)
 			
-		if serange != "":
+		if (is_mls_enabled == 1) and (serange != ""):
 			semanage_context_set_mls(self.sh, con, untranslate(serange))
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
@@ -1332,7 +1332,7 @@ class nodeRecords(semanageRecords):
                if rc < 0:
                        raise ValueError(_("Could not set type in addr context for %s") % addr)
 
-               if serange != "":
+               if (is_mls_enabled == 1) and (serange != ""):
                        rc = semanage_context_set_mls(self.sh, con, serange)
                        if rc < 0:
                                raise ValueError(_("Could not set mls fields in addr context for %s") % addr)
@@ -1378,7 +1378,7 @@ class nodeRecords(semanageRecords):
                        raise ValueError(_("Could not query addr %s") % addr)
 
                con = semanage_node_get_con(node)
-               if serange != "":
+               if (is_mls_enabled == 1) and (serange != ""):
                        semanage_context_set_mls(self.sh, con, untranslate(serange))
                if setype != "":
                        semanage_context_set_type(self.sh, con, setype)
@@ -1528,7 +1528,7 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError(_("Could not set type in interface context for %s") % interface)
 
-		if serange != "":
+		if (is_mls_enabled == 1) and (serange != ""):
 			rc = semanage_context_set_mls(self.sh, con, serange)
 			if rc < 0:
 				raise ValueError(_("Could not set mls fields in interface context for %s") % interface)
@@ -1574,7 +1574,7 @@ class interfaceRecords(semanageRecords):
 
 		con = semanage_iface_get_ifcon(iface)
 			
-		if serange != "":
+		if (is_mls_enabled == 1) and (serange != ""):
 			semanage_context_set_mls(self.sh, con, untranslate(serange))
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
@@ -1828,7 +1828,7 @@ class fcontextRecords(semanageRecords):
                        if rc < 0:
                               raise ValueError(_("Could not set type in file context for %s") % target)
 
-                       if serange != "":
+                       if (is_mls_enabled == 1) and (serange != ""):
                               rc = semanage_context_set_mls(self.sh, con, serange)
                               if rc < 0:
                                      raise ValueError(_("Could not set mls fields in file context for %s") % target)
@@ -1884,7 +1884,7 @@ class fcontextRecords(semanageRecords):
                        if con == None:
                               con = self.createcon(target)
                               
-                       if serange != "":
+                       if (is_mls_enabled == 1) and (serange != ""):
                               semanage_context_set_mls(self.sh, con, untranslate(serange))
                        if seuser != "":
                               semanage_context_set_user(self.sh, con, seuser)
-- 
1.8.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
