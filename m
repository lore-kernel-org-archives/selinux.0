From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] python/semanage: fix export of fcontext socket entries
Date: Wed, 15 Mar 2017 13:14:12 -0400
Message-Id: <20170315171412.24265-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes https://github.com/SELinuxProject/selinux/issues/49 (#49).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 94bd368..7a54373 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -84,7 +84,7 @@ file_type_str_to_option = {"all files": "a",
                            "directory": "d",
                            "character device": "c",
                            "block device": "b",
-                           "socket file": "s",
+                           "socket": "s",
                            "symbolic link": "l",
                            "named pipe": "p"}
 
-- 
2.9.3
