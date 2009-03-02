Subject: [PATCH] libselinux: cache avc_compute_create results in the avc
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov, ajax@redhat.com,
        method@manicmethod.com, joe@nall.com, txtoth@gmail.com
Content-Type: text/plain
Date: Mon, 02 Mar 2009 16:24:46 -0500
Message-Id: <1236029086.5466.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In one benchmark the X server was found to be extremely slow creating
windows with selinux running.  Part of the reason for this was because
libselinux called into the kernel /selinux/create interface for every
object.  This patch caches the results of /selinux/create in the
userspace avc to significantly increase the speed of these types of
operations.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff -up libselinux-2.0.77/include/selinux/avc.h.pre.create.cache libselinux-2.0.77/include/selinux/avc.h
--- libselinux-2.0.77/include/selinux/avc.h.pre.create.cache	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/include/selinux/avc.h	2009-03-02 14:52:40.859167987 -0500
@@ -353,6 +353,7 @@ int avc_compute_member(security_id_t ssi
 #define AVC_CALLBACK_AUDITALLOW_DISABLE	32
 #define AVC_CALLBACK_AUDITDENY_ENABLE	64
 #define AVC_CALLBACK_AUDITDENY_DISABLE	128
+#define AVC_CALLBACK_ADD_CREATE		256
 
 /**
  * avc_add_callback - Register a callback for security events.
diff -up libselinux-2.0.77/src/avc.c.pre.create.cache libselinux-2.0.77/src/avc.c
--- libselinux-2.0.77/src/avc.c.pre.create.cache	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/src/avc.c	2009-03-02 15:57:54.764288907 -0500
@@ -20,6 +20,8 @@ struct avc_entry {
 	security_id_t tsid;
 	security_class_t tclass;
 	struct av_decision avd;
+	security_id_t	create_sid;
+	unsigned	create_decided	:1;
 	int used;		/* used recently */
 };
 
@@ -58,6 +60,11 @@ static struct avc_cache_stats cache_stat
 static struct avc_callback_node *avc_callbacks = NULL;
 static struct sidtab avc_sidtab;
 
+/* forward declaration */
+static int avc_update_cache(uint32_t event, security_id_t ssid,
+			    security_id_t tsid, security_class_t tclass,
+			    access_vector_t perms, security_id_t create_sid);
+
 static inline int avc_hash(security_id_t ssid,
 			   security_id_t tsid, security_class_t tclass)
 {
@@ -340,6 +347,16 @@ static inline struct avc_node *avc_recla
 	return cur;
 }
 
+static inline void avc_clear_avc_entry(struct avc_entry *ae)
+{
+	ae->ssid = ae->tsid = ae->create_sid = NULL;
+	ae->tclass = 0;
+	ae->create_decided = 0;
+	ae->avd.allowed = ae->avd.decided = 0;
+	ae->avd.auditallow = ae->avd.auditdeny = 0;
+	ae->used = 0;
+}
+
 static inline struct avc_node *avc_claim_node(security_id_t ssid,
 					      security_id_t tsid,
 					      security_class_t tclass)
@@ -361,6 +378,7 @@ static inline struct avc_node *avc_claim
 	}
 
 	hvalue = avc_hash(ssid, tsid, tclass);
+	avc_clear_avc_entry(&new->ae);
 	new->ae.used = 1;
 	new->ae.ssid = ssid;
 	new->ae.tsid = tsid;
@@ -498,8 +516,8 @@ static int avc_insert(security_id_t ssid
  * avc_remove - Remove AVC and sidtab entries for SID.
  * @sid: security identifier to be removed
  *
- * Remove all AVC entries containing @sid as source
- * or target, and remove @sid from the SID table.
+ * Remove all AVC entries containing @sid as source, target, or
+ * create_sid, and remove @sid from the SID table.
  * Free the memory allocated for the structure corresponding
  * to @sid.  After this function has been called, @sid must
  * not be used until another call to avc_context_to_sid() has
@@ -514,19 +532,15 @@ static void avc_remove(security_id_t sid
 		cur = avc_cache.slots[i];
 		prev = NULL;
 		while (cur) {
-			if (sid == cur->ae.ssid || sid == cur->ae.tsid) {
+			if (sid == cur->ae.ssid || sid == cur->ae.tsid ||
+			    (cur->ae.create_decided && sid == cur->ae.create_sid)) {
 				if (prev)
 					prev->next = cur->next;
 				else
 					avc_cache.slots[i] = cur->next;
 				tmp = cur;
 				cur = cur->next;
-				tmp->ae.ssid = tmp->ae.tsid = NULL;
-				tmp->ae.tclass = 0;
-				tmp->ae.avd.allowed = tmp->ae.avd.decided = 0;
-				tmp->ae.avd.auditallow = tmp->ae.avd.auditdeny =
-				    0;
-				tmp->ae.used = 0;
+				avc_clear_avc_entry(&tmp->ae);
 				tmp->next = avc_node_freelist;
 				avc_node_freelist = tmp;
 				avc_cache.active_nodes--;
@@ -570,11 +584,7 @@ int avc_reset(void)
 		while (node) {
 			tmp = node;
 			node = node->next;
-			tmp->ae.ssid = tmp->ae.tsid = NULL;
-			tmp->ae.tclass = 0;
-			tmp->ae.avd.allowed = tmp->ae.avd.decided = 0;
-			tmp->ae.avd.auditallow = tmp->ae.avd.auditdeny = 0;
-			tmp->ae.used = 0;
+			avc_clear_avc_entry(&tmp->ae);
 			tmp->next = avc_node_freelist;
 			avc_node_freelist = tmp;
 			avc_cache.active_nodes--;
@@ -896,24 +906,52 @@ int avc_compute_create(security_id_t ssi
 		       security_class_t tclass, security_id_t *newsid)
 {
 	int rc;
+	struct avc_entry_ref aeref;
+	security_context_t ctx = NULL;
+
 	*newsid = NULL;
+
+	avc_entry_ref_init(&aeref);
+retry:
 	avc_get_lock(avc_lock);
-	if (ssid->refcnt > 0 && tsid->refcnt > 0) {
-		security_context_t ctx = NULL;
-		rc = security_compute_create_raw(ssid->ctx, tsid->ctx, tclass,
-						 &ctx);
-		if (rc)
-			goto out;
-		rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
-		if (!rc)
-			(*newsid)->refcnt++;
-		freecon(ctx);
-	} else {
+	if (ssid->refcnt <= 0 || tsid->refcnt <= 0) {
 		errno = EINVAL;	/* bad reference count */
 		rc = -1;
+		goto out;
+	}
+
+	rc = avc_lookup(ssid, tsid, tclass, 0, &aeref);
+	if (!rc) {
+		/* we found something in the avc */
+		if (aeref.ae->create_decided) {
+			*newsid = aeref.ae->create_sid;
+			goto out;
+		} else {
+			goto compute;
+		}
 	}
+	/* there is nothing in the avd for this tuple, so, lets get something */
+	avc_release_lock(avc_lock);
+	avc_has_perm_noaudit(ssid, tsid, tclass, 0, &aeref, NULL);
+	goto retry;
+
+compute:
+	rc = security_compute_create_raw(ssid->ctx, tsid->ctx, tclass,
+					 &ctx);
+	if (rc)
+		goto out;
+	rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
+	if (rc)
+		goto out;
+
+	avc_update_cache(AVC_CALLBACK_ADD_CREATE, ssid, tsid, tclass, 0,
+			 *newsid);
+
 out:
+	if (*newsid)
+		(*newsid)->refcnt++;
 	avc_release_lock(avc_lock);
+	freecon(ctx);
 	return rc;
 }
 
@@ -978,7 +1016,8 @@ static inline int avc_sidcmp(security_id
 }
 
 static inline void avc_update_node(uint32_t event, struct avc_node *node,
-				   access_vector_t perms)
+				   access_vector_t perms,
+				   security_id_t create_sid)
 {
 	switch (event) {
 	case AVC_CALLBACK_GRANT:
@@ -1000,12 +1039,16 @@ static inline void avc_update_node(uint3
 	case AVC_CALLBACK_AUDITDENY_DISABLE:
 		node->ae.avd.auditdeny &= ~perms;
 		break;
+	case AVC_CALLBACK_ADD_CREATE:
+		node->ae.create_sid = create_sid;
+		node->ae.create_decided = 1;
+		break;
 	}
 }
 
 static int avc_update_cache(uint32_t event, security_id_t ssid,
 			    security_id_t tsid, security_class_t tclass,
-			    access_vector_t perms)
+			    access_vector_t perms, security_id_t create_sid)
 {
 	struct avc_node *node;
 	int i;
@@ -1019,7 +1062,7 @@ static int avc_update_cache(uint32_t eve
 				if (avc_sidcmp(ssid, node->ae.ssid) &&
 				    avc_sidcmp(tsid, node->ae.tsid) &&
 				    tclass == node->ae.tclass) {
-					avc_update_node(event, node, perms);
+					avc_update_node(event, node, perms, create_sid);
 				}
 			}
 		}
@@ -1027,7 +1070,7 @@ static int avc_update_cache(uint32_t eve
 		/* apply to one node */
 		node = avc_search_node(ssid, tsid, tclass, 0);
 		if (node) {
-			avc_update_node(event, node, perms);
+			avc_update_node(event, node, perms, create_sid);
 		}
 	}
 
@@ -1058,7 +1101,7 @@ static int avc_control(uint32_t event, s
 	 * been invoked to update the cache state.
 	 */
 	if (event != AVC_CALLBACK_TRY_REVOKE)
-		avc_update_cache(event, ssid, tsid, tclass, perms);
+		avc_update_cache(event, ssid, tsid, tclass, perms, NULL);
 
 	for (c = avc_callbacks; c; c = c->next) {
 		if ((c->events & event) &&
@@ -1080,7 +1123,7 @@ static int avc_control(uint32_t event, s
 	if (event == AVC_CALLBACK_TRY_REVOKE) {
 		/* revoke any unretained permissions */
 		perms &= ~tretained;
-		avc_update_cache(event, ssid, tsid, tclass, perms);
+		avc_update_cache(event, ssid, tsid, tclass, perms, NULL);
 		*out_retained = tretained;
 	}
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
