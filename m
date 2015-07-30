Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6U7PL7m018129
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 03:25:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 498C8B8BCA
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 07:25:21 +0000 (UTC)
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/semanage: improve compatibility with Python 3
 in seobject.py
Date: Thu, 30 Jul 2015 09:25:15 +0200
Message-Id: <1438241115-9039-2-git-send-email-msrb@redhat.com>
In-Reply-To: <1438241115-9039-1-git-send-email-msrb@redhat.com>
References: <1438241115-9039-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- replace print statement with print function
- use reserved word `as` in try-except
- work with dict.keys() in a way compatible with both Python 2 and 3

Signed-off-by: Michal Srb <msrb@redhat.com>
---
 policycoreutils/semanage/seobject.py | 118 +++++++++++++++++------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index d29dba5..edd4c83 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -344,7 +344,7 @@ class moduleRecords(semanageRecords):
             return
 
         if heading:
-            print "\n%-25s %-9s %s\n" % (_("Module Name"), _("Priority"), _("Language"))
+            print("\n%-25s %-9s %s\n" % (_("Module Name"), _("Priority"), _("Language")))
         for t in all:
             if t[1] == 0:
                 disabled = _("Disabled")
@@ -352,7 +352,7 @@ class moduleRecords(semanageRecords):
                 if locallist:
                     continue
                 disabled = ""
-            print "%-25s %-9s %-5s %s" % (t[0], t[2], t[3], disabled)
+            print("%-25s %-9s %-5s %s" % (t[0], t[2], t[3], disabled))
 
     def add(self, file, priority):
         if not os.path.exists(file):
@@ -444,19 +444,19 @@ class permissiveRecords(semanageRecords):
             return
 
         if heading:
-            print "\n%-25s\n" % (_("Builtin Permissive Types"))
+            print("\n%-25s\n" % (_("Builtin Permissive Types")))
         customized = self.get_all()
         for t in all:
             if t not in customized:
-                print t
+                print(t)
 
         if len(customized) == 0:
             return
 
         if heading:
-            print "\n%-25s\n" % (_("Customized Permissive Types"))
+            print("\n%-25s\n" % (_("Customized Permissive Types")))
         for t in customized:
-            print t
+            print(t)
 
     def add(self, type):
         import glob
@@ -564,7 +564,7 @@ class loginRecords(semanageRecords):
             self.begin()
             self.__add(name, sename, serange)
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -624,7 +624,7 @@ class loginRecords(semanageRecords):
             self.begin()
             self.__modify(name, sename, serange)
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -666,7 +666,7 @@ class loginRecords(semanageRecords):
             self.__delete(name)
             self.commit()
 
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -680,7 +680,7 @@ class loginRecords(semanageRecords):
             for u in ulist:
                 self.__delete(semanage_seuser_get_name(u))
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -716,7 +716,7 @@ class loginRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
@@ -725,8 +725,8 @@ class loginRecords(semanageRecords):
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
         ldict = self.get_all_logins()
-        lkeys = ldict.keys()
-        keys = ddict.keys()
+        lkeys = list(ldict.keys())
+        keys = list(ddict.keys())
         if len(keys) == 0 and len(lkeys) == 0:
             return
         keys.sort()
@@ -734,21 +734,21 @@ class loginRecords(semanageRecords):
 
         if is_mls_enabled == 1:
             if heading:
-                print "\n%-20s %-20s %-20s %s\n" % (_("Login Name"), _("SELinux User"), _("MLS/MCS Range"), _("Service"))
+                print("\n%-20s %-20s %-20s %s\n" % (_("Login Name"), _("SELinux User"), _("MLS/MCS Range"), _("Service")))
             for k in keys:
                 u = ddict[k]
-                print "%-20s %-20s %-20s %s" % (k, u[0], translate(u[1]), u[2])
+                print("%-20s %-20s %-20s %s" % (k, u[0], translate(u[1]), u[2]))
             if len(lkeys):
-                print "\nLocal customization in %s" % self.logins_path
+                print("\nLocal customization in %s" % self.logins_path)
 
             for k in lkeys:
                 u = ldict[k]
-                print "%-20s %-20s %-20s %s" % (k, u[0], translate(u[1]), u[2])
+                print("%-20s %-20s %-20s %s" % (k, u[0], translate(u[1]), u[2]))
         else:
             if heading:
-                print "\n%-25s %-25s\n" % (_("Login Name"), _("SELinux User"))
+                print("\n%-25s %-25s\n" % (_("Login Name"), _("SELinux User")))
             for k in keys:
-                print "%-25s %-25s" % (k, ddict[k][0])
+                print("%-25s %-25s" % (k, ddict[k][0]))
 
 
 class seluserRecords(semanageRecords):
@@ -839,7 +839,7 @@ class seluserRecords(semanageRecords):
             self.begin()
             self.__add(name, roles, selevel, serange, prefix)
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -904,7 +904,7 @@ class seluserRecords(semanageRecords):
             self.begin()
             self.__modify(name, roles, selevel, serange, prefix)
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -947,7 +947,7 @@ class seluserRecords(semanageRecords):
             self.__delete(name)
             self.commit()
 
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -961,7 +961,7 @@ class seluserRecords(semanageRecords):
             for u in ulist:
                 self.__delete(semanage_user_get_name(u))
             self.commit()
-        except ValueError, error:
+        except ValueError as error:
             self.mylog.commit(0)
             raise error
 
@@ -988,7 +988,7 @@ class seluserRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
@@ -996,22 +996,22 @@ class seluserRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         if len(keys) == 0:
             return
         keys.sort()
 
         if is_mls_enabled == 1:
             if heading:
-                print "\n%-15s %-10s %-10s %-30s" % ("", _("Labeling"), _("MLS/"), _("MLS/"))
-                print "%-15s %-10s %-10s %-30s %s\n" % (_("SELinux User"), _("Prefix"), _("MCS Level"), _("MCS Range"), _("SELinux Roles"))
+                print("\n%-15s %-10s %-10s %-30s" % ("", _("Labeling"), _("MLS/"), _("MLS/")))
+                print("%-15s %-10s %-10s %-30s %s\n" % (_("SELinux User"), _("Prefix"), _("MCS Level"), _("MCS Range"), _("SELinux Roles")))
             for k in keys:
-                print "%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3])
+                print("%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3]))
         else:
             if heading:
-                print "%-15s %s\n" % (_("SELinux User"), _("SELinux Roles"))
+                print("%-15s %s\n" % (_("SELinux User"), _("SELinux Roles")))
             for k in keys:
-                print "%-15s %s" % (k, ddict[k][3])
+                print("%-15s %s" % (k, ddict[k][3]))
 
 
 class portRecords(semanageRecords):
@@ -1255,7 +1255,7 @@ class portRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             if k[0] == k[1]:
@@ -1266,19 +1266,19 @@ class portRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all_by_type(locallist)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         if len(keys) == 0:
             return
         keys.sort()
 
         if heading:
-            print "%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number"))
+            print("%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number")))
         for i in keys:
             rec = "%-30s %-8s " % i
             rec += "%s" % ddict[i][0]
             for p in ddict[i][1:]:
                 rec += ", %s" % p
-            print rec
+            print(rec)
 
 
 class nodeRecords(semanageRecords):
@@ -1492,7 +1492,7 @@ class nodeRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
@@ -1500,22 +1500,22 @@ class nodeRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         if len(keys) == 0:
             return
         keys.sort()
 
         if heading:
-            print "%-18s %-18s %-5s %-5s\n" % ("IP Address", "Netmask", "Protocol", "Context")
+            print("%-18s %-18s %-5s %-5s\n" % ("IP Address", "Netmask", "Protocol", "Context"))
         if is_mls_enabled:
             for k in keys:
                 val = ''
                 for fields in k:
                     val = val + '\t' + str(fields)
-                print "%-18s %-18s %-5s %s:%s:%s:%s " % (k[0], k[1], k[2], ddict[k][0], ddict[k][1], ddict[k][2], translate(ddict[k][3], False))
+                print("%-18s %-18s %-5s %s:%s:%s:%s " % (k[0], k[1], k[2], ddict[k][0], ddict[k][1], ddict[k][2], translate(ddict[k][3], False)))
         else:
             for k in keys:
-                print "%-18s %-18s %-5s %s:%s:%s " % (k[0], k[1], k[2], ddict[k][0], ddict[k][1], ddict[k][2])
+                print("%-18s %-18s %-5s %s:%s:%s " % (k[0], k[1], k[2], ddict[k][0], ddict[k][1], ddict[k][2]))
 
 
 class interfaceRecords(semanageRecords):
@@ -1683,7 +1683,7 @@ class interfaceRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             l.append("-a -t %s %s" % (ddict[k][2], k))
@@ -1691,19 +1691,19 @@ class interfaceRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         ddict = self.get_all(locallist)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         if len(keys) == 0:
             return
         keys.sort()
 
         if heading:
-            print "%-30s %s\n" % (_("SELinux Interface"), _("Context"))
+            print("%-30s %s\n" % (_("SELinux Interface"), _("Context")))
         if is_mls_enabled:
             for k in keys:
-                print "%-30s %s:%s:%s:%s " % (k, ddict[k][0], ddict[k][1], ddict[k][2], translate(ddict[k][3], False))
+                print("%-30s %s:%s:%s:%s " % (k, ddict[k][0], ddict[k][1], ddict[k][2], translate(ddict[k][3], False)))
         else:
             for k in keys:
-                print "%-30s %s:%s:%s " % (k, ddict[k][0], ddict[k][1], ddict[k][2])
+                print("%-30s %s:%s:%s " % (k, ddict[k][0], ddict[k][1], ddict[k][2]))
 
 
 class fcontextRecords(semanageRecords):
@@ -1751,7 +1751,7 @@ class fcontextRecords(semanageRecords):
             subs_file = selinux.selinux_file_context_subs_path()
             tmpfile = "%s.tmp" % subs_file
             fd = open(tmpfile, "w")
-            for target in self.equiv.keys():
+            for target in list(self.equiv.keys()):
                 fd.write("%s %s\n" % (target, self.equiv[target]))
             fd.close()
             try:
@@ -2035,7 +2035,7 @@ class fcontextRecords(semanageRecords):
     def customized(self):
         l = []
         fcon_dict = self.get_all(True)
-        keys = fcon_dict.keys()
+        keys = list(fcon_dict.keys())
         keys.sort()
         for k in keys:
             if fcon_dict[k]:
@@ -2048,32 +2048,32 @@ class fcontextRecords(semanageRecords):
 
     def list(self, heading=1, locallist=0):
         fcon_dict = self.get_all(locallist)
-        keys = fcon_dict.keys()
+        keys = list(fcon_dict.keys())
         if len(keys) != 0:
             keys.sort()
             if heading:
-                print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
+                print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context")))
             for k in keys:
                 if fcon_dict[k]:
                     if is_mls_enabled:
-                        print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False))
+                        print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False)))
                     else:
-                        print "%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2])
+                        print("%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2]))
                 else:
-                    print "%-50s %-18s <<None>>" % (k[0], k[1])
+                    print("%-50s %-18s <<None>>" % (k[0], k[1]))
 
         if len(self.equiv_dist):
             if not locallist:
                 if heading:
-                    print _("\nSELinux Distribution fcontext Equivalence \n")
+                    print(_("\nSELinux Distribution fcontext Equivalence \n"))
                 for target in self.equiv_dist.keys():
-                    print "%s = %s" % (target, self.equiv_dist[target])
+                    print("%s = %s" % (target, self.equiv_dist[target]))
         if len(self.equiv):
             if heading:
-                print _("\nSELinux Local fcontext Equivalence \n")
+                print(_("\nSELinux Local fcontext Equivalence \n"))
 
             for target in self.equiv.keys():
-                print "%s = %s" % (target, self.equiv[target])
+                print("%s = %s" % (target, self.equiv[target]))
 
 
 class booleanRecords(semanageRecords):
@@ -2227,7 +2227,7 @@ class booleanRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
+        keys = list(ddict.keys())
         keys.sort()
         for k in keys:
             if ddict[k]:
@@ -2241,7 +2241,7 @@ class booleanRecords(semanageRecords):
             keys = ddict.keys()
             for k in keys:
                 if ddict[k]:
-                    print "%s=%s" % (k, ddict[k][2])
+                    print("%s=%s" % (k, ddict[k][2]))
             return
         ddict = self.get_all(locallist)
         keys = ddict.keys()
@@ -2249,7 +2249,7 @@ class booleanRecords(semanageRecords):
             return
 
         if heading:
-            print "%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description"))
+            print("%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description")))
         for k in keys:
             if ddict[k]:
-                print "%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k))
+                print("%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k)))
-- 
2.4.3
