Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6L0cfAt011413
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:41 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id C55298F27A
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 00:38:35 +0000 (UTC)
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] policycoreutils/scripts: improve compatibility with
 Python 3
Date: Tue, 21 Jul 2015 02:38:22 +0200
Message-Id: <1437439102-9911-5-git-send-email-msrb@redhat.com>
In-Reply-To: <1437439102-9911-1-git-send-email-msrb@redhat.com>
References: <1437439102-9911-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- __builtin__ module has been renamed to "builtins" in Python 3
- use reserved word `as` in try-except
- replace print statement with print function
- migrate from commands to subprocess
- fix formatting

Signed-off-by: Michal Srb <msrb@redhat.com>
---
 policycoreutils/scripts/chcat | 80 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index 9efcb22..21212be 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -22,15 +22,19 @@
 #                                        02111-1307  USA
 #
 #  
-import commands, sys, os, pwd, string, getopt, selinux
+import subprocess, sys, os, pwd, string, getopt, selinux
 import seobject
 import gettext
 
 try:
     gettext.install('policycoreutils')
 except IOError:
-       import __builtin__
-       __builtin__.__dict__['_'] = unicode
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 def errorExit(error):
     sys.stderr.write("%s: " % sys.argv[0])
@@ -80,9 +84,9 @@ def chcat_user_add(newcat, users):
             cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
             cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = commands.getstatusoutput(cmd)
+        rc = subprocess.getstatusoutput(cmd)
         if rc[0] != 0:
-            print rc[1]
+            print(rc[1])
             errors += 1
 
     return errors
@@ -107,7 +111,7 @@ def chcat_add(orig, newcat, objects,login_ind):
 
         if len(clist) > 1:
             if cat in clist[1:]:
-                print _("%s is already in %s") % (f, orig)
+                print(_("%s is already in %s") % (f, orig))
                 continue
             clist.append(cat)
             cats = clist[1:]
@@ -118,9 +122,9 @@ def chcat_add(orig, newcat, objects,login_ind):
         else:
             cat_string = cat
         cmd = 'chcon -l %s:%s %s' % (sensitivity, cat_string, f)
-        rc = commands.getstatusoutput(cmd)
+        rc = subprocess.getstatusoutput(cmd)
         if rc[0] != 0:
-            print rc[1]
+            print(rc[1])
             errors += 1
     return errors
 
@@ -158,9 +162,9 @@ def chcat_user_remove(newcat, users):
             cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
             cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = commands.getstatusoutput(cmd)
+        rc = subprocess.getstatusoutput(cmd)
         if rc[0] != 0:
-            print rc[1]
+            print(rc[1])
             errors += 1
     return errors
         
@@ -185,7 +189,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
             
         if len(clist) > 1:
             if cat not in clist[1:]:
-                print _("%s is not in %s") % (f, orig)
+                print(_("%s is not in %s") % (f, orig))
                 continue
             clist.remove(cat)
             if len(clist) > 1:
@@ -195,16 +199,16 @@ def chcat_remove(orig, newcat, objects, login_ind):
             else:
                 cat = ""
         else:
-                print _("%s is not in %s") % (f, orig)
+                print(_("%s is not in %s") % (f, orig))
                 continue
         
         if len(cat) == 0: 
             cmd = 'chcon -l %s %s' % (sensitivity, f)
         else:
             cmd = 'chcon -l %s:%s %s' % (sensitivity,cat, f)
-        rc = commands.getstatusoutput(cmd)
+        rc = subprocess.getstatusoutput(cmd)
         if rc[0] != 0:
-            print rc[1]
+            print(rc[1])
             errors += 1
     return errors
 
@@ -229,9 +233,9 @@ def chcat_user_replace(newcat, users):
             cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
             cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = commands.getstatusoutput(cmd)
+        rc = subprocess.getstatusoutput(cmd)
         if rc[0] != 0:
-            print rc[1]
+            print(rc[1])
             errors += 1
     return errors
     
@@ -251,9 +255,9 @@ def chcat_replace(newcat, objects, login_ind):
     for f in objects:
         cmd = "%s %s" % (cmd, f)
 
-    rc = commands.getstatusoutput(cmd)
+    rc = subprocess.getstatusoutput(cmd)
     if rc[0] != 0:
-        print rc[1]
+        print(rc[1])
         errors += 1
 
     return errors
@@ -322,18 +326,18 @@ def translate(cats):
     return newcat
     
 def usage():
-	print _("Usage %s CATEGORY File ...") % sys.argv[0]
-	print _("Usage %s -l CATEGORY user ...") % sys.argv[0]
-	print _("Usage %s [[+|-]CATEGORY],...]q File ...") % sys.argv[0]
-	print _("Usage %s -l [[+|-]CATEGORY],...]q user ...") % sys.argv[0]
-	print _("Usage %s -d File ...") % sys.argv[0]
-	print _("Usage %s -l -d user ...") % sys.argv[0]
-	print _("Usage %s -L") % sys.argv[0]
-	print _("Usage %s -L -l user") % sys.argv[0]
-        print _("Use -- to end option list.  For example")
-        print _("chcat -- -CompanyConfidential /docs/businessplan.odt")
-        print _("chcat -l +CompanyConfidential juser")
-	sys.exit(1)
+    print(_("Usage %s CATEGORY File ...") % sys.argv[0])
+    print(_("Usage %s -l CATEGORY user ...") % sys.argv[0])
+    print(_("Usage %s [[+|-]CATEGORY],...]q File ...") % sys.argv[0])
+    print(_("Usage %s -l [[+|-]CATEGORY],...]q user ...") % sys.argv[0])
+    print(_("Usage %s -d File ...") % sys.argv[0])
+    print(_("Usage %s -l -d user ...") % sys.argv[0])
+    print(_("Usage %s -L") % sys.argv[0])
+    print(_("Usage %s -L -l user") % sys.argv[0])
+    print(_("Use -- to end option list.  For example"))
+    print(_("chcat -- -CompanyConfidential /docs/businessplan.odt"))
+    print(_("chcat -l +CompanyConfidential juser"))
+    sys.exit(1)
 
 def listcats():
     fd = open(selinux.selinux_translations_path())
@@ -342,7 +346,7 @@ def listcats():
             continue
         if l.find("=") != -1:
             rec = l.split("=")
-            print "%-30s %s" % tuple(rec)
+            print("%-30s %s" % tuple(rec))
     fd.close()
     return 0
     
@@ -356,12 +360,12 @@ def listusercats(users):
         cats = seobject.translate(selinux.getseuserbyname(u)[2])
         cats = cats.split("-")
         if len(cats) > 1 and cats[1] != "s0":
-            print "%s: %s" % (u, cats[1])
+            print("%s: %s" % (u, cats[1]))
         else:
-            print "%s: %s" % (u, cats[0])
+            print("%s: %s" % (u, cats[0]))
             
 def error(msg):
-    print "%s: %s" % (sys.argv[0], msg)
+    print("%s: %s" % (sys.argv[0], msg))
     sys.exit(1)
     
 if __name__ == '__main__':
@@ -395,10 +399,10 @@ if __name__ == '__main__':
         if list_ind == 0 and len(cmds) < 1:
             usage()
 
-    except getopt.error, error:
+    except getopt.error as error:
         errorExit(_("Options Error %s ") % error.msg)
 
-    except ValueError, e:
+    except ValueError as e:
         usage()
 
     if delete_ind:
@@ -433,9 +437,9 @@ if __name__ == '__main__':
                 if len(c) > 0 and c[0] == "-":
                     errors += chcat_remove(c[1:],translate(l), objects, login_ind)
                     continue
-    except ValueError, e:
+    except ValueError as e:
         error(e)
-    except OSError, e:
+    except OSError as e:
         error(e)
     
     sys.exit(errors)
-- 
2.4.3
