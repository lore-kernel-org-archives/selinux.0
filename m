Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5LiTsZ002863
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 16:44:29 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5LiSZr017903
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 21:44:28 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel6.hp.com (Postfix) with ESMTP id 3469434CA4
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 16:44:28 -0500 (EST)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 8/8] SELinux: allow NetLabel to directly cache SIDs
To: selinux@tycho.nsa.gov
Date: Mon, 05 Nov 2007 16:44:21 -0500
Message-ID: <20071105214421.9361.284.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net>
References: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that the SELinux NetLabel "base SID" is always the netmsg initial SID we
can do a big optimization - caching the SID and not just the MLS attributes.
This not only saves a lot of per-packet memory allocations and copies but it
has a nice side effect of removing a chunk of code.
---

 security/selinux/hooks.c            |    5 -
 security/selinux/include/netlabel.h |    6 --
 security/selinux/include/security.h |    2 -
 security/selinux/netlabel.c         |   55 ++++++++++------
 security/selinux/ss/services.c      |  124 ++++++-----------------------------
 5 files changed, 56 insertions(+), 136 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 510ef49..8667084 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3238,10 +3238,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	u32 nlbl_sid;
 
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
-	selinux_netlbl_skbuff_getsid(skb,
-				     family,
-				     SECINITSID_NETMSG,
-				     &nlbl_sid);
+	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_sid);
 
 	if (security_net_peersid_resolve(nlbl_sid, xfrm_sid, sid) != 0)
 		return -EACCES;
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 272769a..82b619d 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -46,10 +46,7 @@ void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
 void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 				      struct sk_security_struct *newssec);
 
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
-				 u16 family,
-				 u32 base_sid,
-				 u32 *sid);
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family, u32 *sid);
 
 void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock);
 int selinux_netlbl_socket_post_create(struct socket *sock);
@@ -88,7 +85,6 @@ static inline void selinux_netlbl_sk_security_clone(
 
 static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 					       u16 family,
-					       u32 base_sid,
 					       u32 *sid)
 {
 	*sid = SECSID_NULL;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index eaf0dda..d952ff7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -123,7 +123,6 @@ int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 
 #ifdef CONFIG_NETLABEL
 int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
-				   u32 base_sid,
 				   u32 *sid);
 
 int security_netlbl_sid_to_secattr(u32 sid,
@@ -131,7 +130,6 @@ int security_netlbl_sid_to_secattr(u32 sid,
 #else
 static inline int security_netlbl_secattr_to_sid(
 					    struct netlbl_lsm_secattr *secattr,
-					    u32 base_sid,
 					    u32 *sid)
 {
 	return -EIDRM;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 4073d5a..1ae65c3 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -36,6 +36,33 @@
 #include "security.h"
 
 /**
+ * selinux_netlbl_sidlookup_cached - Cache a SID lookup
+ * @skb: the packet
+ * @secattr: the NetLabel security attributes
+ * @sid: the SID
+ *
+ * Description:
+ * Query the SELinux security server to lookup the correct SID for the given
+ * security attributes.  If the query is successful, cache the result to speed
+ * up future lookups.  Returns zero on success, negative values on failure.
+ *
+ */
+static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
+					   struct netlbl_lsm_secattr *secattr,
+					   u32 *sid)
+{
+	int rc;
+
+	rc = security_netlbl_secattr_to_sid(secattr, sid);
+	if (rc == 0 &&
+	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
+	    (secattr->flags & NETLBL_SECATTR_CACHE))
+		netlbl_cache_add(skb, secattr);
+
+	return rc;
+}
+
+/**
  * selinux_netlbl_sock_setsid - Label a socket using the NetLabel mechanism
  * @sk: the socket to label
  * @sid: the SID to use
@@ -142,7 +169,6 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
  * selinux_netlbl_skbuff_getsid - Get the sid of a packet using NetLabel
  * @skb: the packet
  * @family: protocol family
- * @base_sid: the SELinux SID to use as a context for MLS only attributes
  * @sid: the SID
  *
  * Description:
@@ -153,7 +179,6 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
  */
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
-				 u32 base_sid,
 				 u32 *sid)
 {
 	int rc;
@@ -166,13 +191,9 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
-	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
-		rc = security_netlbl_secattr_to_sid(&secattr, base_sid, sid);
-		if (rc == 0 &&
-		    (secattr.flags & NETLBL_SECATTR_CACHEABLE) &&
-		    (secattr.flags & NETLBL_SECATTR_CACHE))
-			netlbl_cache_add(skb, &secattr);
-	} else
+	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+		rc = selinux_netlbl_sidlookup_cached(skb, &secattr, sid);
+	else
 		*sid = SECSID_NULL;
 	netlbl_secattr_destroy(&secattr);
 
@@ -208,9 +229,7 @@ void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock)
 	netlbl_secattr_init(&secattr);
 	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
 	    secattr.flags != NETLBL_SECATTR_NONE &&
-	    security_netlbl_secattr_to_sid(&secattr,
-					   SECINITSID_NETMSG,
-					   &nlbl_peer_sid) == 0)
+	    security_netlbl_secattr_to_sid(&secattr, &nlbl_peer_sid) == 0)
 		sksec->peer_sid = nlbl_peer_sid;
 	netlbl_secattr_destroy(&secattr);
 
@@ -317,15 +336,9 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
-	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
-		rc = security_netlbl_secattr_to_sid(&secattr,
-						    SECINITSID_NETMSG,
-						    &nlbl_sid);
-		if (rc == 0 &&
-		    (secattr.flags & NETLBL_SECATTR_CACHEABLE) &&
-		    (secattr.flags & NETLBL_SECATTR_CACHE))
-			netlbl_cache_add(skb, &secattr);
-	} else
+	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+		rc = selinux_netlbl_sidlookup_cached(skb, &secattr, &nlbl_sid);
+	else
 		nlbl_sid = SECINITSID_UNLABELED;
 	netlbl_secattr_destroy(&secattr);
 	if (rc != 0)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 80e3e4f..c812b87 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2544,50 +2544,10 @@ void selinux_audit_set_callback(int (*callback)(void))
 }
 
 #ifdef CONFIG_NETLABEL
-/*
- * NetLabel cache structure
- */
-#define NETLBL_CACHE(x)           ((struct selinux_netlbl_cache *)(x))
-#define NETLBL_CACHE_T_NONE       0
-#define NETLBL_CACHE_T_SID        1
-#define NETLBL_CACHE_T_MLS        2
-struct selinux_netlbl_cache {
-	u32 type;
-	union {
-		u32 sid;
-		struct mls_range mls_label;
-	} data;
-};
-
-/**
- * security_netlbl_cache_free - Free the NetLabel cached data
- * @data: the data to free
- *
- * Description:
- * This function is intended to be used as the free() callback inside the
- * netlbl_lsm_cache structure.
- *
- */
-static void security_netlbl_cache_free(const void *data)
-{
-	struct selinux_netlbl_cache *cache;
-
-	if (data == NULL)
-		return;
-
-	cache = NETLBL_CACHE(data);
-	switch (cache->type) {
-	case NETLBL_CACHE_T_MLS:
-		ebitmap_destroy(&cache->data.mls_label.level[0].cat);
-		break;
-	}
-	kfree(data);
-}
-
 /**
  * security_netlbl_cache_add - Add an entry to the NetLabel cache
  * @secattr: the NetLabel packet security attributes
- * @ctx: the SELinux context
+ * @sid: the SELinux SID
  *
  * Description:
  * Attempt to cache the context in @ctx, which was derived from the packet in
@@ -2596,60 +2556,46 @@ static void security_netlbl_cache_free(const void *data)
  *
  */
 static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
-				      struct context *ctx)
+				      u32 sid)
 {
-	struct selinux_netlbl_cache *cache = NULL;
+	u32 *sid_cache;
 
-	secattr->cache = netlbl_secattr_cache_alloc(GFP_ATOMIC);
-	if (secattr->cache == NULL)
-		return;
-
-	cache = kzalloc(sizeof(*cache),	GFP_ATOMIC);
-	if (cache == NULL)
+	sid_cache = kmalloc(sizeof(*sid_cache), GFP_ATOMIC);
+	if (sid_cache == NULL)
 		return;
-
-	cache->type = NETLBL_CACHE_T_MLS;
-	if (ebitmap_cpy(&cache->data.mls_label.level[0].cat,
-			&ctx->range.level[0].cat) != 0) {
-		kfree(cache);
+	secattr->cache = netlbl_secattr_cache_alloc(GFP_ATOMIC);
+	if (secattr->cache == NULL) {
+		kfree(sid_cache);
 		return;
 	}
-	cache->data.mls_label.level[1].cat.highbit =
-		cache->data.mls_label.level[0].cat.highbit;
-	cache->data.mls_label.level[1].cat.node =
-		cache->data.mls_label.level[0].cat.node;
-	cache->data.mls_label.level[0].sens = ctx->range.level[0].sens;
-	cache->data.mls_label.level[1].sens = ctx->range.level[0].sens;
 
-	secattr->cache->free = security_netlbl_cache_free;
-	secattr->cache->data = (void *)cache;
+	*sid_cache = sid;
+	secattr->cache->free = kfree;
+	secattr->cache->data = (void *)sid_cache;
 	secattr->flags |= NETLBL_SECATTR_CACHE;
 }
 
 /**
  * security_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
  * @secattr: the NetLabel packet security attributes
- * @base_sid: the SELinux SID to use as a context for MLS only attributes
  * @sid: the SELinux SID
  *
  * Description:
  * Convert the given NetLabel security attributes in @secattr into a
  * SELinux SID.  If the @secattr field does not contain a full SELinux
- * SID/context then use the context in @base_sid as the foundation.  If
- * possibile the 'cache' field of @secattr is set and the CACHE flag is set;
- * this is to allow the @secattr to be used by NetLabel to cache the secattr to
- * SID conversion for future lookups.  Returns zero on success, negative
- * values on failure.
+ * SID/context then use SECINITSID_NETMSG as the foundation.  If possibile the
+ * 'cache' field of @secattr is set and the CACHE flag is set; this is to
+ * allow the @secattr to be used by NetLabel to cache the secattr to SID
+ * conversion for future lookups.  Returns zero on success, negative values on
+ * failure.
  *
  */
 int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
-				   u32 base_sid,
 				   u32 *sid)
 {
 	int rc = -EIDRM;
 	struct context *ctx;
 	struct context ctx_new;
-	struct selinux_netlbl_cache *cache;
 
 	if (!ss_initialized) {
 		*sid = SECSID_NULL;
@@ -2659,43 +2605,13 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 	POLICY_RDLOCK;
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE) {
-		cache = NETLBL_CACHE(secattr->cache->data);
-		switch (cache->type) {
-		case NETLBL_CACHE_T_SID:
-			*sid = cache->data.sid;
-			rc = 0;
-			break;
-		case NETLBL_CACHE_T_MLS:
-			ctx = sidtab_search(&sidtab, base_sid);
-			if (ctx == NULL)
-				goto netlbl_secattr_to_sid_return;
-
-			ctx_new.user = ctx->user;
-			ctx_new.role = ctx->role;
-			ctx_new.type = ctx->type;
-			ctx_new.range.level[0].sens =
-				cache->data.mls_label.level[0].sens;
-			ctx_new.range.level[0].cat.highbit =
-				cache->data.mls_label.level[0].cat.highbit;
-			ctx_new.range.level[0].cat.node =
-				cache->data.mls_label.level[0].cat.node;
-			ctx_new.range.level[1].sens =
-				cache->data.mls_label.level[1].sens;
-			ctx_new.range.level[1].cat.highbit =
-				cache->data.mls_label.level[1].cat.highbit;
-			ctx_new.range.level[1].cat.node =
-				cache->data.mls_label.level[1].cat.node;
-
-			rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
-			break;
-		default:
-			goto netlbl_secattr_to_sid_return;
-		}
+		*sid = *(u32 *)secattr->cache->data;
+		rc = 0;
 	} else if (secattr->flags & NETLBL_SECATTR_SECID) {
 		*sid = secattr->attr.secid;
 		rc = 0;
 	} else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
-		ctx = sidtab_search(&sidtab, base_sid);
+		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
 		if (ctx == NULL)
 			goto netlbl_secattr_to_sid_return;
 
@@ -2722,7 +2638,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		if (rc != 0)
 			goto netlbl_secattr_to_sid_return_cleanup;
 
-		security_netlbl_cache_add(secattr, &ctx_new);
+		security_netlbl_cache_add(secattr, *sid);
 
 		ebitmap_destroy(&ctx_new.range.level[0].cat);
 	} else {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
