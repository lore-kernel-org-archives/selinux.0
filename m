From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: alan.christopher.jenkins@gmail.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: disable filespec hash table stats on non-debug
 builds
Date: Tue, 24 Jan 2017 14:46:30 -0500
Message-Id: <1485287190-476-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Disable generating filespec hash table stats on non-debug builds,
as they are not useful information for users and cause fixfiles
check to produce noisy output.

Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/selinux_restorecon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 7020669..38acbd2 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -487,6 +487,7 @@ oom:
 /*
  * Evaluate the association hash table distribution.
  */
+#ifdef DEBUG
 static void filespec_eval(void)
 {
 	file_spec_t *fl;
@@ -513,6 +514,11 @@ static void filespec_eval(void)
 		     "filespec hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
 		     nel, used, HASH_BUCKETS, longest);
 }
+#else
+static void filespec_eval(void)
+{
+}
+#endif
 
 /*
  * Destroy the association hash table.
-- 
2.7.4
