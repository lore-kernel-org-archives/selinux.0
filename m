Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21GhgIo007841
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:43:42 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21Gj4tV023640
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 16:45:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l21GimYX001573
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:44:48 -0500
Subject: [PATCH] sepolgen: correctly extract params from interface calls
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 11:44:13 -0500
Message-Id: <1172767453.30103.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes the interface parameter extraction code extract
parameters from interface calls. This didn't matter much before because
interfaces normally contained allow rules, but the new policy patterns
make it likely that an interface will have only interface calls. Also
included is a small bug fix in the code that handles conflicting
parameter types.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 62550235fedc sepolgen/src/sepolgen/interfaces.py
--- a/sepolgen/src/sepolgen/interfaces.py	Thu Mar 01 11:14:39 2007 -0500
+++ b/sepolgen/src/sepolgen/interfaces.py	Thu Mar 01 11:33:49 2007 -0500
@@ -71,7 +71,11 @@ def __param_insert(name, type, av, param
             # If the object is not implicitly typed, tell the
             # caller there is a likely conflict.
             ret = 1
-            for obj in itertools.chain(p.obj_classes, [av.obj_class]):
+            if av:
+                avobjs = [av.obj_class]
+            else:
+                avobjs = []
+            for obj in itertools.chain(p.obj_classes, avobjs):
                 if obj in objectmodel.implicitly_typed_objects:
                     ret = 0
                     break
@@ -181,6 +185,17 @@ def type_rule_extract_params(rule, param
         if __param_insert(rule.dest_type, refpolicy.DEST_TYPE, None, params):
             ret = 1
             
+    return ret
+
+def ifcall_extract_params(ifcall, params):
+    ret = 0
+    for arg in ifcall.args:
+        if access.is_idparam(arg):
+            # Assume interface arguments are source types. Fairly safe
+            # assumption for most interfaces
+            if __param_insert(arg, refpolicy.SRC_TYPE, None, params):
+                ret = 1
+
     return ret
             
 
@@ -229,6 +244,13 @@ class InterfaceVector:
                 pass
                 #print "found conflicting params in rule %s in interface %s" % \
                 #      (str(rule), interface.name)
+
+        for ifcall in interface.interface_calls():
+            if ifcall_extract_params(ifcall, self.params):
+                pass
+                #print "found conflicting params in ifcall %s in interface %s" % \
+                #      (str(ifcall), interface.name)
+            
 
     def add_av(self, av):
         if av_extract_params(av, self.params) == 1:



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
