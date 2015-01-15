Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0F0Oeic004925
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 19:24:47 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 3/3] Tweak avtab hash table parameters for better
 performance
Date: Wed, 14 Jan 2015 17:24:03 -0700
Message-Id: <1421281443-4905-4-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Using the Fedora 20 targeted policy, running check_assertions requires
an avtab with around 22 million elements. With the default limit of 4096
buckets, performance is abysmal: it takes more than an hour to populate
the hash. Profiling shows most of that time under avtab_search_node.

This patch increases the hash from 13 to 20 bits and to a maximum of
1048576 buckets. The time for check_assertions on that policy is reduced
to about 3 minutes, which is enough to re-enable those checks as part of
the build process.

A full size table will allocate 4-8 MB of memory, up from 16-32 KB. In a
cursory review, these tables are usually short-lived and only 1-3 are
allocated together. Compared to the cost of entries in this table (up to
1 GB using the same policy), this isn't a significant increase.

Signed-off-by: John Brooks <john.brooks@jolla.com>
---
 libsepol/include/sepol/policydb/avtab.h | 7 ++++---
 libsepol/src/avtab.c                    | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 6955ecf..bb6e79f 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -81,7 +81,7 @@ typedef struct avtab {
 	avtab_ptr_t *htable;
 	uint32_t nel;		/* number of elements */
 	uint32_t nslot;         /* number of hash slots */
-	uint16_t mask;          /* mask to compute hash func */
+	uint32_t mask;          /* mask to compute hash func */
 } avtab_t;
 
 extern int avtab_init(avtab_t *);
@@ -117,10 +117,11 @@ extern avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key);
 
 extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 
-#define MAX_AVTAB_HASH_BITS 13
+#define MAX_AVTAB_HASH_BITS 20
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
-#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
+/* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximum buckets */
+#define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
 
 #endif				/* _AVTAB_H_ */
 
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 86e782c..d6041d4 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -333,7 +333,7 @@ int avtab_init(avtab_t * h)
 
 int avtab_alloc(avtab_t *h, uint32_t nrules)
 {
-	uint16_t mask = 0;
+	uint32_t mask = 0;
 	uint32_t shift = 0;
 	uint32_t work = nrules;
 	uint32_t nslot = 0;
@@ -348,8 +348,8 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
 	if (shift > 2)
 		shift = shift - 2;
 	nslot = 1 << shift;
-	if (nslot > MAX_AVTAB_SIZE)
-		nslot = MAX_AVTAB_SIZE;
+	if (nslot > MAX_AVTAB_HASH_BUCKETS)
+		nslot = MAX_AVTAB_HASH_BUCKETS;
 	mask = nslot - 1;
 
 	h->htable = calloc(nslot, sizeof(avtab_ptr_t));
-- 
1.9.3
