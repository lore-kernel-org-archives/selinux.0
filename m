From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] selinux: increase avtab max buckets
Date: Tue, 24 Mar 2015 16:54:18 -0400
Message-Id: <1427230458-23667-3-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
References: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Now that we can safely increase the avtab max buckets without
triggering high order allocations and have a hash function that
will make better use of the larger number of buckets, increase
the max buckets to 2^16.

Original:
101421 entries and 2048/2048 buckets used, longest chain length 374

With new hash function:
101421 entries and 2048/2048 buckets used, longest chain length 81

With increased max buckets:
101421 entries and 31078/32768 buckets used, longest chain length 12

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/avtab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 6d794a2..adb451c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -86,7 +86,7 @@ struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified
 void avtab_cache_init(void);
 void avtab_cache_destroy(void);
 
-#define MAX_AVTAB_HASH_BITS 11
+#define MAX_AVTAB_HASH_BITS 16
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 
 #endif	/* _SS_AVTAB_H_ */
-- 
1.9.3
