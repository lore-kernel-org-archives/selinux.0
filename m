Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA6F4jLx015425
 for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2017 10:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7395C3F3CE
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:00:48 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Nov 2017 16:00:38 +0100
Message-Id: <20171106150040.25300-2-plautrba@redhat.com>
In-Reply-To: <20171106150040.25300-1-plautrba@redhat.com>
References: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20171106150040.25300-1-plautrba@redhat.com>
Subject: [PATCH 1/3] python/semanage: drop *_ini functions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 74 +++++++++---------------------------------------
 1 file changed, 14 insertions(+), 60 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 313537c5..8acfc855 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -134,67 +134,21 @@ class SetImportFile(argparse.Action):
                 sys.exit(1)
         setattr(namespace, self.dest, values)
 
-# functions for OBJECT initialization
-
-
-def login_ini():
-    OBJECT = seobject.loginRecords(store)
-    return OBJECT
-
-
-def user_ini():
-    OBJECT = seobject.seluserRecords(store)
-    return OBJECT
-
-
-def port_ini():
-    OBJECT = seobject.portRecords(store)
-    return OBJECT
-
-def ibpkey_ini():
-    OBJECT = seobject.ibpkeyRecords(store)
-    return OBJECT
-
-def ibendport_ini():
-    OBJECT = seobject.ibendportRecords(store)
-    return OBJECT
-
-def module_ini():
-    OBJECT = seobject.moduleRecords(store)
-    return OBJECT
-
-
-def interface_ini():
-    OBJECT = seobject.interfaceRecords(store)
-    return OBJECT
-
-
-def node_ini():
-    OBJECT = seobject.nodeRecords(store)
-    return OBJECT
-
-
-def fcontext_ini():
-    OBJECT = seobject.fcontextRecords(store)
-    return OBJECT
-
-
-def boolean_ini():
-    OBJECT = seobject.booleanRecords(store)
-    return OBJECT
-
-
-def permissive_ini():
-    OBJECT = seobject.permissiveRecords(store)
-    return OBJECT
-
-
-def dontaudit_ini():
-    OBJECT = seobject.dontauditClass(store)
-    return OBJECT
-
 # define dictonary for seobject OBEJCTS
-object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini, 'ibendport': ibendport_ini}
+object_dict = {
+    'login': seobject.loginRecords,
+    'user': seobject.seluserRecords,
+    'port': seobject.portRecords,
+    'module': seobject.moduleRecords,
+    'interface': seobject.interfaceRecords,
+    'node': seobject.nodeRecords,
+    'fcontext': seobject.fcontextRecords,
+    'boolean': seobject.booleanRecords,
+    'permissive': seobject.permissiveRecords,
+    'dontaudit': seobject.dontauditClass,
+    'ibpkey': seobject.ibpkeyRecords,
+    'ibendport': seobject.ibendportRecords
+}
 
 def generate_custom_usage(usage_text, usage_dict):
     # generate custom usage from given text and dictonary
-- 
2.14.3
