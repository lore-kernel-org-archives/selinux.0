Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKU011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so18706705pfe.0
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:23 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/12] semanage: py3 support for print function and map/filter
Date: Fri,  5 Aug 2016 02:33:54 +0800
Message-Id: <1470335645-24224-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

map and filter were turned into list comprehensions.
This was done using python's 2to3 utility.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/semanage/seobject.py      | 94 +++++++++++++++----------------
 policycoreutils/semanage/test-semanage.py |  2 +-
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 3b0b108..863d4a5 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -336,7 +336,7 @@ class moduleRecords(semanageRecords):
         all = self.get_all()
         if len(all) == 0:
             return
-        return map(lambda x: "-d %s" % x[0], filter(lambda t: t[1] == 0, all))
+        return ["-d %s" % x[0] for x in [t for t in all if t[1] == 0]]
 
     def list(self, heading=1, locallist=0):
         all = self.get_all()
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
@@ -402,7 +402,7 @@ class moduleRecords(semanageRecords):
         self.commit()
 
     def deleteall(self):
-        l = map(lambda x: x[0], filter(lambda t: t[1] == 0, self.get_all()))
+        l = [x[0] for x in [t for t in self.get_all() if t[1] == 0]]
         for m in l:
             self.set_enabled(m, True)
 
@@ -439,24 +439,24 @@ class permissiveRecords(semanageRecords):
         return l
 
     def list(self, heading=1, locallist=0):
-        all = map(lambda y: y["name"], filter(lambda x: x["permissive"], sepolicy.info(sepolicy.TYPE)))
+        all = [y["name"] for y in [x for x in sepolicy.info(sepolicy.TYPE) if x["permissive"]]]
         if len(all) == 0:
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
 
@@ -1003,15 +1003,15 @@ class seluserRecords(semanageRecords):
 
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
@@ -1268,13 +1268,13 @@ class portRecords(semanageRecords):
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
@@ -1502,16 +1502,16 @@ class nodeRecords(semanageRecords):
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
@@ -1693,13 +1693,13 @@ class interfaceRecords(semanageRecords):
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
@@ -2048,28 +2048,28 @@ class fcontextRecords(semanageRecords):
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
@@ -2237,7 +2237,7 @@ class booleanRecords(semanageRecords):
             keys = ddict.keys()
             for k in keys:
                 if ddict[k]:
-                    print "%s=%s" % (k, ddict[k][2])
+                    print("%s=%s" % (k, ddict[k][2]))
             return
         ddict = self.get_all(locallist)
         keys = ddict.keys()
@@ -2245,7 +2245,7 @@ class booleanRecords(semanageRecords):
             return
 
         if heading:
-            print "%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description"))
+            print("%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description")))
         for k in keys:
             if ddict[k]:
-                print "%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k))
+                print("%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k)))
diff --git a/policycoreutils/semanage/test-semanage.py b/policycoreutils/semanage/test-semanage.py
index 293e1fd..10c4d8f 100644
--- a/policycoreutils/semanage/test-semanage.py
+++ b/policycoreutils/semanage/test-semanage.py
@@ -278,7 +278,7 @@ def gen_semanage_test_args(parser):
 
 if __name__ == "__main__":
     import selinux
-    semanage_test_list = filter(lambda x: x.startswith("test_"), dir(SemanageTests))
+    semanage_test_list = [x for x in dir(SemanageTests) if x.startswith("test_")]
     if selinux.security_getenforce() == 1:
         parser = argparse.ArgumentParser(description='Semanage unit test script')
         gen_semanage_test_args(parser)
-- 
2.7.3
