From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: cache sidtab_context_to_sid results
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, esandeen@redhat.com
Date: Thu, 02 Dec 2010 16:06:34 -0500
Message-ID: <20101202210634.27460.81333.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

sidtab_context_to_sid takes up a large share of time when creating large
numbers of new inodes (~30-40% in oprofile runs).  This patch implements a
cache of 3 entries which is checked before we do a full context_to_sid lookup.
On one system this showed over a x3 improvement in the number of inodes that
could be created per second and around a 20% improvement on another system.

Any time we look up the same context string sucessivly (imagine ls -lZ) we
should hit this cache hot.  A cache miss should have a relatively minor affect
on performance next to doing the full table search.

All operations on the cache are done COMPLETELY lockless.  We know that all
struct sidtab_node objects created will never be deleted until a new policy is
loaded thus we never have to worry about a pointer being dereferenced.  Since
we also know that pointer assignment is atomic we know that the cache will
always have valid pointers.  Given this information we implement a FIFO cache
in an array of 3 pointers.  Every result (whether a cache hit or table lookup)
will be places in the 0 spot of the cache and the rest of the entries moved
down one spot.  The 3rd entry will be lost.

Races are possible and are even likely to happen.  Lets assume that 4 tasks
are hitting sidtab_context_to_sid.  The first task checks against the first
entry in the cache and it is a miss.  Now lets assume a second task updates
the cache with a new entry.  This will push the first entry back to the second
spot.  Now the first task might check against the second entry (which it
already checked) and will miss again.  Now say some third task updates the
cache and push the second entry to the third spot.  The first task my check
the third entry (for the third time!) and again have a miss.  At which point
it will just do a full table lookup.  No big deal!

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/sidtab.c |   39 +++++++++++++++++++++++++++++++++++++--
 security/selinux/ss/sidtab.h |    2 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e817989..5840a35 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -147,6 +147,17 @@ out:
 	return rc;
 }
 
+static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc)
+{
+	BUG_ON(loc >= SIDTAB_CACHE_LEN);
+
+	while (loc > 0) {
+		s->cache[loc] = s->cache[loc - 1];
+		loc--;
+	}
+	s->cache[0] = n;
+}
+
 static inline u32 sidtab_search_context(struct sidtab *s,
 						  struct context *context)
 {
@@ -156,14 +167,33 @@ static inline u32 sidtab_search_context(struct sidtab *s,
 	for (i = 0; i < SIDTAB_SIZE; i++) {
 		cur = s->htable[i];
 		while (cur) {
-			if (context_cmp(&cur->context, context))
+			if (context_cmp(&cur->context, context)) {
+				sidtab_update_cache(s, cur, SIDTAB_CACHE_LEN - 1);
 				return cur->sid;
+			}
 			cur = cur->next;
 		}
 	}
 	return 0;
 }
 
+static inline u32 sidtab_search_cache(struct sidtab *s, struct context *context)
+{
+	int i;
+	struct sidtab_node *node;
+
+	for (i = 0; i < SIDTAB_CACHE_LEN; i++) {
+		node = s->cache[i];
+		if (unlikely(!node))
+			return 0;
+		if (context_cmp(&node->context, context)) {
+			sidtab_update_cache(s, node, i);
+			return node->sid;
+		}
+	}
+	return 0;
+}
+
 int sidtab_context_to_sid(struct sidtab *s,
 			  struct context *context,
 			  u32 *out_sid)
@@ -174,7 +204,9 @@ int sidtab_context_to_sid(struct sidtab *s,
 
 	*out_sid = SECSID_NULL;
 
-	sid = sidtab_search_context(s, context);
+	sid  = sidtab_search_cache(s, context);
+	if (!sid)
+		sid = sidtab_search_context(s, context);
 	if (!sid) {
 		spin_lock_irqsave(&s->lock, flags);
 		/* Rescan now that we hold the lock. */
@@ -259,12 +291,15 @@ void sidtab_destroy(struct sidtab *s)
 void sidtab_set(struct sidtab *dst, struct sidtab *src)
 {
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&src->lock, flags);
 	dst->htable = src->htable;
 	dst->nel = src->nel;
 	dst->next_sid = src->next_sid;
 	dst->shutdown = 0;
+	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
+		dst->cache[i] = NULL;
 	spin_unlock_irqrestore(&src->lock, flags);
 }
 
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 64ea5b1..84dc154 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -26,6 +26,8 @@ struct sidtab {
 	unsigned int nel;	/* number of elements */
 	unsigned int next_sid;	/* next SID to allocate */
 	unsigned char shutdown;
+#define SIDTAB_CACHE_LEN	3
+	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
 	spinlock_t lock;
 };
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
