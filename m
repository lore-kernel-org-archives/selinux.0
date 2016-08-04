Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKV011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:27 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so17903635pab.3
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:25 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/12] seobject: use sorted() instead of .sort()
Date: Fri,  5 Aug 2016 02:33:55 +0800
Message-Id: <1470335645-24224-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2to3 wanted to wrap all the .keys() calls in list() but doing sorted()
directly is better.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/semanage/seobject.py | 68 ++++++++++++------------------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 863d4a5..66ff00e 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -716,21 +716,17 @@ class loginRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
         return l
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
         ldict = self.get_all_logins()
-        lkeys = ldict.keys()
-        keys = ddict.keys()
+        lkeys = sorted(ldict.keys())
+        keys = sorted(ddict.keys())
         if len(keys) == 0 and len(lkeys) == 0:
             return
-        keys.sort()
-        lkeys.sort()
 
         if is_mls_enabled == 1:
             if heading:
@@ -988,18 +984,15 @@ class seluserRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
         return l
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
-        if len(keys) == 0:
+        if len(ddict) == 0:
             return
-        keys.sort()
+        keys = sorted(ddict.keys())
 
         if is_mls_enabled == 1:
             if heading:
@@ -1251,9 +1244,7 @@ class portRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             if k[0] == k[1]:
                 l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], k[0]))
             else:
@@ -1262,10 +1253,9 @@ class portRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all_by_type(locallist)
-        keys = ddict.keys()
-        if len(keys) == 0:
+        if len(ddict) == 0:
             return
-        keys.sort()
+        keys = sorted(ddict.keys())
 
         if heading:
             print("%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number")))
@@ -1488,18 +1478,15 @@ class nodeRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
-        if len(keys) == 0:
+        if len(ddict) == 0:
             return
-        keys.sort()
+        keys = sorted(ddict.keys())
 
         if heading:
             print("%-18s %-18s %-5s %-5s\n" % ("IP Address", "Netmask", "Protocol", "Context"))
@@ -1679,18 +1666,15 @@ class interfaceRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             l.append("-a -t %s %s" % (ddict[k][2], k))
         return l
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
-        if len(keys) == 0:
+        if len(ddict) == 0:
             return
-        keys.sort()
+        keys = sorted(ddict.keys())
 
         if heading:
             print("%-30s %s\n" % (_("SELinux Interface"), _("Context")))
@@ -2031,9 +2015,7 @@ class fcontextRecords(semanageRecords):
     def customized(self):
         l = []
         fcon_dict = self.get_all(True)
-        keys = fcon_dict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(fcon_dict.keys()):
             if fcon_dict[k]:
                 l.append("-a -f %s -t %s '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], k[0]))
 
@@ -2044,12 +2026,10 @@ class fcontextRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         fcon_dict = self.get_all(locallist)
-        keys = fcon_dict.keys()
-        if len(keys) != 0:
-            keys.sort()
+        if len(fcon_dict) != 0:
             if heading:
                 print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context")))
-            for k in keys:
+            for k in sorted(fcon_dict.keys()):
                 if fcon_dict[k]:
                     if is_mls_enabled:
                         print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False)))
@@ -2223,9 +2203,7 @@ class booleanRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(ddict.keys()):
             if ddict[k]:
                 l.append("-m -%s %s" % (ddict[k][2], k))
         return l
@@ -2234,18 +2212,16 @@ class booleanRecords(semanageRecords):
         on_off = (_("off"), _("on"))
         if use_file:
             ddict = self.get_all(locallist)
-            keys = ddict.keys()
-            for k in keys:
+            for k in sorted(ddict.keys()):
                 if ddict[k]:
                     print("%s=%s" % (k, ddict[k][2]))
             return
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
-        if len(keys) == 0:
+        if len(ddict) == 0:
             return
 
         if heading:
             print("%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description")))
-        for k in keys:
+        for k in sorted(ddict.keys()):
             if ddict[k]:
                 print("%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k)))
-- 
2.7.3
