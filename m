Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QEA3sr027069
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 10:10:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89BCC7F7A6
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 14:09:59 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix recently introduced TabError's
Date: Fri, 26 May 2017 16:09:51 +0200
Message-Id: <20170526140951.5112-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commits a3d2c7a 6a7a5aa introduced inconsistent use of tabs and spaces
in indentation what makes python3.6 unhappy.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/utils/semanage_migrate_store | 4 ++--
 python/semanage/seobject.py              | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 9a9fac22..2e6cb278 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -254,8 +254,8 @@ if __name__ == "__main__":
 		"policy.kern",
 		"file_contexts",
 		"homedir_template",
-                "pkeys.local",
-                "ibendports.local"]
+		"pkeys.local",
+		"ibendports.local"]
 
 
 	create_dir(newroot_path(), 0o755)
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 61be6198..c97a9f0c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1321,10 +1321,10 @@ class ibpkeyRecords(semanageRecords):
         semanageRecords.__init__(self, store)
 
     def __genkey(self, pkey, subnet_prefix):
-	if subnet_prefix == "":
+        if subnet_prefix == "":
             raise ValueError(_("Subnet Prefix is required"))
 
-	pkeys = pkey.split("-")
+        pkeys = pkey.split("-")
         if len(pkeys) == 1:
             high = low = int(pkeys[0], 0)
         else:
@@ -1576,7 +1576,7 @@ class ibendportRecords(semanageRecords):
         semanageRecords.__init__(self, store)
 
     def __genkey(self, ibendport, ibdev_name):
-	if ibdev_name == "":
+        if ibdev_name == "":
             raise ValueError(_("IB device name is required"))
 
         port = int(ibendport)
-- 
2.13.0
