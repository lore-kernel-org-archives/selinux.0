From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>, Doug
 Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 16:11:02 +0200
Message-ID: <20180530141104.28569-4-peter.enderborg@sony.com>
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to
 use rwlock.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We need a copy of sidtabs, so change the generic sidtab_clone
as from a function pointer and let it use a read rwlock while
do the clone.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 20 +-------------------
 security/selinux/ss/sidtab.c   | 39 ++++++++++++++++++++++++++++++++-------
 security/selinux/ss/sidtab.h   |  3 ++-
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4f3ce389084c..2be471d72c85 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1891,19 +1891,6 @@ int security_change_sid(struct selinux_state *state,
 				    out_sid, false);
 }
 
-/* Clone the SID into the new SID table. */
-static int clone_sid(u32 sid,
-		     struct context *context,
-		     void *arg)
-{
-	struct sidtab *s = arg;
-
-	if (sid > SECINITSID_NUM)
-		return sidtab_insert(s, sid, context);
-	else
-		return 0;
-}
-
 static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
@@ -2199,10 +2186,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto err;
 	}
 
-	/* Clone the SID table. */
-	sidtab_shutdown(old_set->sidtab);
-
-	rc = sidtab_map(old_set->sidtab, clone_sid, next_set->sidtab);
+	rc = sidtab_clone(old_set->sidtab, next_set->sidtab);
 	if (rc)
 		goto err;
 
@@ -2926,8 +2910,6 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 			goto out;
 	}
 
-	seqno = ++state->ss->latest_granting;
-	state->ss->active_set = next_set;
 	rc = 0;
 out:
 	if (!rc) {
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 5be31b7af225..811503cd7c2b 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -27,7 +27,7 @@ int sidtab_init(struct sidtab *s)
 	s->nel = 0;
 	s->next_sid = 1;
 	s->shutdown = 0;
-	spin_lock_init(&s->lock);
+	rwlock_init(&s->lock);
 	return 0;
 }
 
@@ -116,6 +116,31 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
+int sidtab_clone(struct sidtab *s, struct sidtab *d)
+{
+	int i, rc = 0;
+	struct sidtab_node *cur;
+
+	if (!s || !d)
+		goto errout;
+
+	read_lock(&s->lock);
+	for (i = 0; i < SIDTAB_SIZE; i++) {
+		cur = s->htable[i];
+		while (cur) {
+			if (cur->sid > SECINITSID_NUM)
+				rc =  sidtab_insert(d, cur->sid, &cur->context);
+			if (rc)
+				goto out;
+			cur = cur->next;
+		}
+	}
+out:
+	read_unlock(&s->lock);
+errout:
+	return rc;
+}
+
 int sidtab_map(struct sidtab *s,
 	       int (*apply) (u32 sid,
 			     struct context *context,
@@ -202,7 +227,7 @@ int sidtab_context_to_sid(struct sidtab *s,
 	if (!sid)
 		sid = sidtab_search_context(s, context);
 	if (!sid) {
-		spin_lock_irqsave(&s->lock, flags);
+		write_lock_irqsave(&s->lock, flags);
 		/* Rescan now that we hold the lock. */
 		sid = sidtab_search_context(s, context);
 		if (sid)
@@ -221,7 +246,7 @@ int sidtab_context_to_sid(struct sidtab *s,
 		if (ret)
 			s->next_sid--;
 unlock_out:
-		spin_unlock_irqrestore(&s->lock, flags);
+		write_unlock_irqrestore(&s->lock, flags);
 	}
 
 	if (ret)
@@ -287,21 +312,21 @@ void sidtab_set(struct sidtab *dst, struct sidtab *src)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&src->lock, flags);
+	write_lock_irqsave(&src->lock, flags);
 	dst->htable = src->htable;
 	dst->nel = src->nel;
 	dst->next_sid = src->next_sid;
 	dst->shutdown = 0;
 	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
 		dst->cache[i] = NULL;
-	spin_unlock_irqrestore(&src->lock, flags);
+	write_unlock_irqrestore(&src->lock, flags);
 }
 
 void sidtab_shutdown(struct sidtab *s)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&s->lock, flags);
+	write_lock_irqsave(&s->lock, flags);
 	s->shutdown = 1;
-	spin_unlock_irqrestore(&s->lock, flags);
+	write_unlock_irqrestore(&s->lock, flags);
 }
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index a1a1d2617b6f..6751f8bcbd66 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -29,7 +29,7 @@ struct sidtab {
 	unsigned char shutdown;
 #define SIDTAB_CACHE_LEN	3
 	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
-	spinlock_t lock;
+	rwlock_t lock;
 };
 
 int sidtab_init(struct sidtab *s);
@@ -51,6 +51,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag);
 void sidtab_destroy(struct sidtab *s);
 void sidtab_set(struct sidtab *dst, struct sidtab *src);
 void sidtab_shutdown(struct sidtab *s);
+int sidtab_clone(struct sidtab *s, struct sidtab *d);
 
 #endif	/* _SS_SIDTAB_H_ */
 
-- 
2.15.1
