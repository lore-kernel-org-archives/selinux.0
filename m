Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o57LePwI026896
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2010 17:40:25 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o57LfrJk020561
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2010 21:41:53 GMT
From: Steve Lawrence <slawrence@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Add chcon method to libselinux python bindings
Date: Mon,  7 Jun 2010 17:40:05 -0400
Message-Id: <1275946805-9194-1-git-send-email-slawrence@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds a chcon method to the libselinux python bindings to change the
context of a file/directory tree.
---
 libselinux/src/selinuxswig_python.i |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 8b34c99..dea0e80 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -21,6 +21,14 @@ def restorecon(path, recursive=False):
                              map(restorecon, [os.path.join(dirname, fname)
                                               for fname in fnames]), None)
 
+def chcon(path, context, recursive=False):
+    """ Set the SELinux context on a given path """
+    lsetfilecon(path, context)
+    if recursive:
+        for root, dirs, files in os.walk(path):
+            for name in files + dirs:
+               lsetfilecon(os.path.join(root,name), context)
+
 def copytree(src, dest):
     """ An SELinux-friendly shutil.copytree method """
     shutil.copytree(src, dest)
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
