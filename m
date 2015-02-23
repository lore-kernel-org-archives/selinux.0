From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux:  getcon.3:  Fix setcon description.
Date: Mon, 23 Feb 2015 10:57:57 -0500
Message-Id: <1424707077-3266-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The man page description for setcon() was never updated for the
introduction of bounded transitions in Linux 2.6.28.  Update it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/man/man3/getcon.3 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index fd0e02b..644ee47 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -90,10 +90,18 @@ A multi-threaded application can perform a
 .BR setcon ()
 prior to creating
 any child threads, in which case all of the child threads will inherit
-the new context.  However,
+the new context.  However, prior to Linux 2.6.28,
 .BR setcon ()
-will fail if there are any other
-threads running in the same process.
+would fail if there are any other
+threads running in the same process since this would yield
+an inconsistency among the security contexts of threads sharing
+the same memory space.  Since Linux 2.6.28,
+.BR setcon()
+is permitted for threads within a multi-threaded process if the
+new security context is bounded by the old security context, where
+the bounded relation is defined through typebounds statements in the
+policy and guarantees that the new security context has a subset of
+the permissions of the old security context.
 
 If the process was being ptraced at the time of the
 .BR setcon ()
-- 
1.9.3
