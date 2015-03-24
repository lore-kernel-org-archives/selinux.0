From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] selinux: Use a better hash function for avtab
Date: Tue, 24 Mar 2015 16:54:17 -0400
Message-Id: <1427230458-23667-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
References: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: John Brooks <john.brooks@jolla.com>

This function, based on murmurhash3, has much better distribution than
the original. Using the current default of 2048 buckets, there are many
fewer collisions:

Before:
101421 entries and 2048/2048 buckets used, longest chain length 374
After:
101421 entries and 2048/2048 buckets used, longest chain length 81

The difference becomes much more significant when buckets are increased.
A naive attempt to expand the current function to larger outputs doesn't
yield any significant improvement; so this function is a prerequisite
for increasing the bucket size.

sds:  Adapted from the original patches for libsepol to the kernel.

Signed-off-by: John Brooks <john.brooks@jolla.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/avtab.c | 41 +++++++++++++++++++++++++++++++++++++----
 security/selinux/ss/avtab.h |  2 +-
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 3ea0198..b64f277 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -25,10 +25,43 @@
 
 static struct kmem_cache *avtab_node_cachep;
 
-static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
+/* Based on MurmurHash3, written by Austin Appleby and placed in the
+ * public domain.
+ */
+static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
 {
-	return ((keyp->target_class + (keyp->target_type << 2) +
-		 (keyp->source_type << 9)) & mask);
+	static const u32 c1 = 0xcc9e2d51;
+	static const u32 c2 = 0x1b873593;
+	static const u32 r1 = 15;
+	static const u32 r2 = 13;
+	static const u32 m  = 5;
+	static const u32 n  = 0xe6546b64;
+
+	u32 hash = 0;
+
+#define mix(input) { \
+	u32 v = input; \
+	v *= c1; \
+	v = (v << r1) | (v >> (32 - r1)); \
+	v *= c2; \
+	hash ^= v; \
+	hash = (hash << r2) | (hash >> (32 - r2)); \
+	hash = hash * m + n; \
+}
+
+	mix(keyp->target_class);
+	mix(keyp->target_type);
+	mix(keyp->source_type);
+
+#undef mix
+
+	hash ^= hash >> 16;
+	hash *= 0x85ebca6b;
+	hash ^= hash >> 13;
+	hash *= 0xc2b2ae35;
+	hash ^= hash >> 16;
+
+	return hash & mask;
 }
 
 static struct avtab_node*
@@ -256,7 +289,7 @@ int avtab_init(struct avtab *h)
 
 int avtab_alloc(struct avtab *h, u32 nrules)
 {
-	u16 mask = 0;
+	u32 mask = 0;
 	u32 shift = 0;
 	u32 work = nrules;
 	u32 nslot = 0;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 9318b2b..6d794a2 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -56,7 +56,7 @@ struct avtab {
 	struct flex_array *htable;
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
-	u16 mask;       /* mask to compute hash func */
+	u32 mask;       /* mask to compute hash func */
 
 };
 
-- 
1.9.3
