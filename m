Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F8j85I019368
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 04:45:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E9DD3B716
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 08:45:02 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] semanage: use socket.getprotobyname for protocol
Date: Mon, 15 Aug 2016 10:44:57 +0200
Message-Id: <1471250698-16573-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch removes proto_to_audit dictionary and uses
standard socket.getprotobyname(protocol) to resolve
protocol number from given protocol name.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 8d3088c..538ff0a 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -28,6 +28,7 @@ import os
 import re
 import sys
 import stat
+import socket
 from semanage import *
 PROGNAME = "policycoreutils"
 import sepolicy
@@ -88,11 +89,6 @@ file_type_str_to_option = {"all files": "a",
                            "symbolic link": "l",
                            "named pipe": "p"}
 
-proto_to_audit = {"tcp": 6,
-                  "udp": 17,
-                  "ipv4": 4,
-                  "ipv6": 41}
-
 ftype_to_audit = {"": "any",
                   "b": "block",
                   "c": "char",
@@ -1134,7 +1130,7 @@ class portRecords(semanageRecords):
         semanage_port_key_free(k)
         semanage_port_free(p)
 
-        self.mylog.log_change("resrc=port op=add lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u", "object_r", type, serange))
+        self.mylog.log_change("resrc=port op=add lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, socket.getprotobyname(proto), "system_u", "object_r", type, serange))
 
     def add(self, port, proto, serange, type):
         self.begin()
@@ -1177,7 +1173,7 @@ class portRecords(semanageRecords):
         semanage_port_key_free(k)
         semanage_port_free(p)
 
-        self.mylog.log_change("resrc=port op=modify lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u", "object_r", setype, serange))
+        self.mylog.log_change("resrc=port op=modify lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, socket.getprotobyname(proto), "system_u", "object_r", setype, serange))
 
     def modify(self, port, proto, serange, setype):
         self.begin()
@@ -1210,7 +1206,7 @@ class portRecords(semanageRecords):
             if low == high:
                 port_str = low
 
-            self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port_str, proto_to_audit[proto_str]))
+            self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port_str, socket.getprotobyname(proto_str)))
 
         self.commit()
 
@@ -1234,7 +1230,7 @@ class portRecords(semanageRecords):
 
         semanage_port_key_free(k)
 
-        self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port, proto_to_audit[proto]))
+        self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port, socket.getprotobyname(proto)))
 
     def delete(self, port, proto):
         self.begin()
@@ -1414,7 +1410,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, proto_to_audit[self.protocol[proto]], "system_u", "object_r", ctype, serange))
+        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", ctype, serange))
 
     def add(self, addr, mask, proto, serange, ctype):
         self.begin()
@@ -1457,7 +1453,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, proto_to_audit[self.protocol[proto]], "system_u", "object_r", setype, serange))
+        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", setype, serange))
 
     def modify(self, addr, mask, proto, serange, setype):
         self.begin()
@@ -1490,7 +1486,7 @@ class nodeRecords(semanageRecords):
 
         semanage_node_key_free(k)
 
-        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, proto_to_audit[self.protocol[proto]]))
+        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, socket.getprotobyname(self.protocol[proto])))
 
     def delete(self, addr, mask, proto):
         self.begin()
-- 
1.8.3.1
