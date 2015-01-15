Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0F0Oeib004925
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 19:24:45 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 2/3] Use a better hash function for libsepol's avtab
Date: Wed, 14 Jan 2015 17:24:02 -0700
Message-Id: <1421281443-4905-3-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This function, based on murmurhash3, has much better distribution than
the original. Using the current default of 4096 buckets, there are many
fewer collisions:

Before:
2893000 entries and 4096/4096 buckets used, longest chain length 1649
After:
2732000 entries and 4096/4096 buckets used, longest chain length 764

The difference becomes much more significant when buckets are increased.
A naive attempt to expand the current function to larger outputs doesn't
yield any significant improvement; so this function is a prerequisite
for increasing the bucket size.

Signed-off-by: John Brooks <john.brooks@jolla.com>
---
 libsepol/src/avtab.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index ea947cb..86e782c 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -49,10 +49,43 @@
 #include "debug.h"
 #include "private.h"
 
-static inline int avtab_hash(struct avtab_key *keyp, uint16_t mask)
+/* Based on MurmurHash3, written by Austin Appleby and placed in the
+ * public domain.
+ */
+static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
 {
-	return ((keyp->target_class + (keyp->target_type << 2) +
-		 (keyp->source_type << 9)) & mask);
+	static const uint32_t c1 = 0xcc9e2d51;
+	static const uint32_t c2 = 0x1b873593;
+	static const uint32_t r1 = 15;
+	static const uint32_t r2 = 13;
+	static const uint32_t m  = 5;
+	static const uint32_t n  = 0xe6546b64;
+
+	uint32_t hash = 0;
+
+#define mix(input) { \
+	uint32_t v = input; \
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
 
 static avtab_ptr_t
-- 
1.9.3
