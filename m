From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 02/13] semanage: move permissive module creation to /tmp
Date: Wed, 23 Dec 2009 18:25:49 -0500
Message-Id: <1261610760-4724-3-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-2-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

semanage currently uses /var/lib/selinux/tmp to create permissive
modules. However, with the move to /var, the same tmp directory is used
for building policy binaries, causing a conflict. This patch creates a
random temporary directory in /tmp and moves permissive module creation
to that directory, avoiding the directory conflict.

This patch also imports shutil for rmtree to easily delete all created
temporary files.
---
 policycoreutils/semanage/seobject.py |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index b7d257b..0aa7759 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -21,7 +21,7 @@
 #
 #  
 
-import pwd, grp, string, selinux, tempfile, os, re, sys, stat
+import pwd, grp, string, selinux, tempfile, os, re, sys, stat, shutil
 from semanage import *;
 PROGNAME = "policycoreutils"
 import sepolgen.module as module
@@ -271,7 +271,8 @@ class permissiveRecords(semanageRecords):
 	def add(self, type):
                import glob
                name = "permissive_%s" % type
-               dirname = "/var/lib/selinux"
+               dirname = tempfile.mkdtemp("-semanage")
+               savedir = os.getcwd()
                os.chdir(dirname)
                filename = "%s.te" % name
                modtxt = """
@@ -296,14 +297,8 @@ permissive %s;
                if rc >= 0:
                       self.commit()
 
-               for root, dirs, files in os.walk("tmp", topdown = False):
-                      for name in files:
-                             os.remove(os.path.join(root, name))
-                      for name in dirs:
-                             os.rmdir(os.path.join(root, name))
-               os.removedirs("tmp")
-               for i in glob.glob("permissive_%s.*" % type):
-                      os.remove(i)
+               os.chdir(savedir)
+               shutil.rmtree(dirname)
                if rc < 0:
 			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
 
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
