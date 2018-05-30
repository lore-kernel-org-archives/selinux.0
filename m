From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>, Doug
 Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 16:11:01 +0200
Message-ID: <20180530141104.28569-3-peter.enderborg@sony.com>
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset struct
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a preparation for moving locking to rcu type.
We move policydb, sidtab and map to this structure which
is dynamic allocated. To help out the handlig a policydb_copy
are added. It is intended to be used in atomic context within
a rcu lock, so there are help functions that do vmalloc
allocation that are intended to be on the outside of the lock.

hastab_insert had a cond_sched call that is removed. When switched
to rcu lock the lock can be preempted.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/hashtab.c  |   1 -
 security/selinux/ss/policydb.c |  48 +++++++
 security/selinux/ss/policydb.h |   6 +-
 security/selinux/ss/services.c | 292 +++++++++++++++++++++++------------------
 security/selinux/ss/services.h |  12 +-
 5 files changed, 226 insertions(+), 133 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 0944b1f8060e..967b6e3d25c6 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -44,7 +44,6 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	u32 hvalue;
 	struct hashtab_node *prev, *cur, *newnode;
 
-	cond_resched();
 
 	if (!h || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2a0e21d8c275..93d134d057a7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3535,3 +3535,51 @@ int policydb_write(struct policydb *p, void *fp)
 
 	return 0;
 }
+
+int policydb_flattened_alloc(struct policydb *db, void **tmpbuf, size_t *size)
+{
+	int rc = 0;
+
+	*size = db->len;
+	*tmpbuf = vmalloc(*size);
+
+	if (!*tmpbuf) {
+		rc = -ENOMEM;
+		printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
+	}
+	return rc;
+}
+
+int policydb_flattened_free(void *tmpbuf)
+{
+	vfree(tmpbuf);
+	return 0;
+}
+
+int policydb_copy(struct policydb *olddb, struct policydb *newdb,
+		  void **tmpstorage, size_t size)
+{
+	struct policy_file fp;
+	void *data = *tmpstorage;
+	int rc;
+
+	if (size != olddb->len) {
+		rc = -EAGAIN;
+		goto out;
+	}
+	fp.data = data;
+	fp.len = size;
+	rc = policydb_write(olddb, &fp);
+	if (rc)
+		goto out;
+
+	fp.len = size;
+	fp.data = data;
+	rc = policydb_read(newdb, &fp);
+	if (rc)
+		goto out;
+
+	newdb->len = size;
+out:
+	return rc;
+}
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 215f8f30ac5a..3e2f86b5b674 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -320,7 +320,11 @@ extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
-
+extern int policydb_copy(struct policydb *olddb, struct policydb *newdb,
+			 void **tmpstorage, size_t size);
+extern int policydb_flattened_alloc(struct policydb *db,
+				    void **tmpbuf, size_t *size);
+extern int policydb_flattened_free(void *tmpbuf);
 #define PERM_SYMTAB_SIZE 32
 
 #define POLICYDB_CONFIG_MLS    1
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8057e19dc15f..4f3ce389084c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -86,6 +86,10 @@ void selinux_ss_init(struct selinux_ss **ss)
 {
 	rwlock_init(&selinux_ss.policy_rwlock);
 	mutex_init(&selinux_ss.status_lock);
+	selinux_ss.active_set = kzalloc(sizeof(struct selinux_ruleset),
+					GFP_KERNEL);
+	selinux_ss.active_set->sidtab = kzalloc(sizeof(struct sidtab),
+						GFP_KERNEL);
 	*ss = &selinux_ss;
 }
 
@@ -249,7 +253,7 @@ static void map_decision(struct selinux_map *map,
 
 int security_mls_enabled(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->active_set->policydb;
 
 	return p->mls_enabled;
 }
@@ -733,7 +737,7 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 					   struct context *tcontext,
 					   u16 tclass)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->active_set->policydb;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -777,11 +781,11 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	if (!user)
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->active_set->map, orig_tclass);
 	else
 		tclass = orig_tclass;
 
@@ -877,8 +881,8 @@ int security_bounded_transition(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	rc = -EINVAL;
 	old_context = sidtab_search(sidtab, old_sid);
@@ -1035,8 +1039,8 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	if (!state->initialized)
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1052,7 +1056,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->active_set->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1124,8 +1128,8 @@ void security_compute_av(struct selinux_state *state,
 	if (!state->initialized)
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1145,7 +1149,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->active_set->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1153,7 +1157,7 @@ void security_compute_av(struct selinux_state *state,
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  xperms);
-	map_decision(&state->ss->map, orig_tclass, avd,
+	map_decision(&state->ss->active_set->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1178,8 +1182,8 @@ void security_compute_av_user(struct selinux_state *state,
 	if (!state->initialized)
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1316,8 +1320,8 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		goto out;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 	if (force)
 		context = sidtab_search_force(sidtab, sid);
 	else
@@ -1488,8 +1492,8 @@ static int security_context_to_sid_core(struct selinux_state *state,
 			goto out;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1576,7 +1580,7 @@ static int compute_sid_handle_invalid_context(
 	u16 tclass,
 	struct context *newcontext)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 
@@ -1665,16 +1669,17 @@ static int security_compute_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	if (kern) {
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->active_set->map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
 	} else {
+		struct selinux_map *amap = &state->ss->active_set->map;
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(&state->ss->map,
+		sock = security_is_socket_class(map_class(amap,
 							  tclass));
 	}
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1903,7 +1908,7 @@ static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	char *s;
 	u32 len;
 
@@ -2071,9 +2076,9 @@ static int convert_context(u32 key,
 	goto out;
 }
 
-static void security_load_policycaps(struct selinux_state *state)
+static void security_load_policycaps(struct selinux_state *state,
+				     struct policydb *p)
 {
-	struct policydb *p = &state->ss->policydb;
 	unsigned int i;
 	struct ebitmap_node *node;
 
@@ -2107,47 +2112,47 @@ static int security_preserve_bools(struct selinux_state *state,
  */
 int security_load_policy(struct selinux_state *state, void *data, size_t len)
 {
-	struct policydb *policydb;
-	struct sidtab *sidtab;
-	struct policydb *oldpolicydb, *newpolicydb;
-	struct sidtab oldsidtab, newsidtab;
-	struct selinux_mapping *oldmapping;
 	struct selinux_map newmap;
 	struct convert_context_args args;
 	u32 seqno;
 	int rc = 0;
+	struct selinux_ruleset *next_set, *old_set;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	oldpolicydb = kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
-	if (!oldpolicydb) {
+	next_set = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
+	if (!next_set) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	newpolicydb = oldpolicydb + 1;
-
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	next_set->sidtab = kzalloc(sizeof(struct sidtab), GFP_KERNEL);
+	if (!next_set->sidtab) {
+		rc = -ENOMEM;
+		kfree(next_set);
+		goto out;
+	}
 
 	if (!state->initialized) {
-		rc = policydb_read(policydb, fp);
+		old_set = state->ss->active_set;
+		rc = policydb_read(&next_set->policydb, fp);
 		if (rc)
 			goto out;
 
-		policydb->len = len;
-		rc = selinux_set_mapping(policydb, secclass_map,
-					 &state->ss->map);
+		next_set->policydb.len = len;
+		rc = selinux_set_mapping(&next_set->policydb, secclass_map,
+					 &next_set->map);
 		if (rc) {
-			policydb_destroy(policydb);
+			policydb_destroy(&next_set->policydb);
 			goto out;
 		}
 
-		rc = policydb_load_isids(policydb, sidtab);
+		rc = policydb_load_isids(&next_set->policydb, next_set->sidtab);
 		if (rc) {
-			policydb_destroy(policydb);
+			policydb_destroy(&next_set->policydb);
 			goto out;
 		}
 
-		security_load_policycaps(state);
+		security_load_policycaps(state, &next_set->policydb);
+		state->ss->active_set = next_set;
 		state->initialized = 1;
 		seqno = ++state->ss->latest_granting;
 		selinux_complete_init();
@@ -2156,45 +2161,48 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		selinux_status_update_policyload(state, seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
+		kfree(old_set->sidtab);
+		kfree(old_set);
 		goto out;
 	}
-
+	old_set = state->ss->active_set;
 #if 0
 	sidtab_hash_eval(sidtab, "sids");
 #endif
 
-	rc = policydb_read(newpolicydb, fp);
+	rc = policydb_read(&next_set->policydb, fp);
 	if (rc)
 		goto out;
 
-	newpolicydb->len = len;
+	next_set->policydb.len = len;
+
 	/* If switching between different policy types, log MLS status */
-	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
+	if (old_set->policydb.mls_enabled && !next_set->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
+	else if (!old_set->policydb.mls_enabled
+		 && next_set->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
-
-	rc = policydb_load_isids(newpolicydb, &newsidtab);
+	rc = policydb_load_isids(&next_set->policydb, next_set->sidtab);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(newpolicydb);
+		policydb_destroy(&next_set->policydb);
 		goto out;
 	}
 
-	rc = selinux_set_mapping(newpolicydb, secclass_map, &newmap);
+	rc = selinux_set_mapping(&next_set->policydb, secclass_map, &newmap);
 	if (rc)
 		goto err;
 
-	rc = security_preserve_bools(state, newpolicydb);
+	rc = security_preserve_bools(state, &next_set->policydb);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
 		goto err;
 	}
 
 	/* Clone the SID table. */
-	sidtab_shutdown(sidtab);
+	sidtab_shutdown(old_set->sidtab);
 
-	rc = sidtab_map(sidtab, clone_sid, &newsidtab);
+	rc = sidtab_map(old_set->sidtab, clone_sid, next_set->sidtab);
 	if (rc)
 		goto err;
 
@@ -2203,9 +2211,9 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	 * in the new SID table.
 	 */
 	args.state = state;
-	args.oldp = policydb;
-	args.newp = newpolicydb;
-	rc = sidtab_map(&newsidtab, convert_context, &args);
+	args.oldp = &old_set->policydb;
+	args.newp = &next_set->policydb;
+	rc = sidtab_map(next_set->sidtab, convert_context, &args);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2213,48 +2221,43 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto err;
 	}
 
-	/* Save the old policydb and SID table to free later. */
-	memcpy(oldpolicydb, policydb, sizeof(*policydb));
-	sidtab_set(&oldsidtab, sidtab);
+	next_set->map.mapping = newmap.mapping;
+	next_set->map.size = newmap.size;
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&state->ss->policy_rwlock);
-	memcpy(policydb, newpolicydb, sizeof(*policydb));
-	sidtab_set(sidtab, &newsidtab);
-	security_load_policycaps(state);
-	oldmapping = state->ss->map.mapping;
-	state->ss->map.mapping = newmap.mapping;
-	state->ss->map.size = newmap.size;
+	security_load_policycaps(state, &next_set->policydb);
 	seqno = ++state->ss->latest_granting;
+	state->ss->active_set = next_set;
 	write_unlock_irq(&state->ss->policy_rwlock);
 
-	/* Free the old policydb and SID table. */
-	policydb_destroy(oldpolicydb);
-	sidtab_destroy(&oldsidtab);
-	kfree(oldmapping);
-
 	avc_ss_reset(state->avc, seqno);
 	selnl_notify_policyload(seqno);
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
 
+	/* Free the old policydb and SID table. */
+	policydb_destroy(&old_set->policydb);
+	sidtab_destroy(old_set->sidtab);
+	kfree(old_set->sidtab);
+	kfree(old_set->map.mapping);
+	kfree(old_set);
 	rc = 0;
 	goto out;
 
 err:
 	kfree(newmap.mapping);
-	sidtab_destroy(&newsidtab);
-	policydb_destroy(newpolicydb);
-
+	sidtab_destroy(next_set->sidtab);
+	policydb_destroy(&next_set->policydb);
+	kfree(next_set);
 out:
-	kfree(oldpolicydb);
 	return rc;
 }
 
 size_t security_policydb_len(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->active_set->policydb;
 	size_t len;
 
 	read_lock(&state->ss->policy_rwlock);
@@ -2280,8 +2283,8 @@ int security_port_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2326,8 +2329,8 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2372,8 +2375,8 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2418,8 +2421,8 @@ int security_netif_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2483,8 +2486,8 @@ int security_node_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2583,8 +2586,8 @@ int security_get_user_sids(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	context_init(&usercon);
 
@@ -2685,8 +2688,8 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u16 orig_sclass,
 				       u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct policydb *policydb = &state->ss->active_set->policydb;
+	struct sidtab *sidtab = state->ss->active_set->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2696,7 +2699,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 	while (path[0] == '/' && path[1] == '/')
 		path++;
 
-	sclass = unmap_class(&state->ss->map, orig_sclass);
+	sclass = unmap_class(&state->ss->active_set->map, orig_sclass);
 	*sid = SECINITSID_UNLABELED;
 
 	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
@@ -2771,8 +2774,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	policydb = &state->ss->active_set->policydb;
+	sidtab = state->ss->active_set->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2821,7 +2824,7 @@ int security_get_bools(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->active_set->policydb;
 
 	*names = NULL;
 	*values = NULL;
@@ -2866,53 +2869,86 @@ int security_get_bools(struct selinux_state *state,
 
 int security_set_bools(struct selinux_state *state, int len, int *values)
 {
-	struct policydb *policydb;
 	int i, rc;
 	int lenp, seqno = 0;
 	struct cond_node *cur;
+	struct selinux_ruleset *next_set, *old_set = NULL;
+	void *storage;
+	size_t size;
 
-	write_lock_irq(&state->ss->policy_rwlock);
+	next_set = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
+	if (!next_set) {
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	rc = policydb_flattened_alloc(&state->ss->active_set->policydb,
+				      &storage, &size);
+	if (rc) {
+		kfree(next_set);
+		goto errout;
+	}
 
-	policydb = &state->ss->policydb;
+	write_lock_irq(&state->ss->policy_rwlock);
+	old_set = state->ss->active_set;
+	memcpy(next_set, old_set, sizeof(struct selinux_ruleset));
+	rc = policydb_copy(&old_set->policydb, &next_set->policydb,
+			   &storage, size);
+	if (rc)
+		goto out;
 
 	rc = -EFAULT;
-	lenp = policydb->p_bools.nprim;
+	lenp = next_set->policydb.p_bools.nprim;
 	if (len != lenp)
 		goto out;
 
 	for (i = 0; i < len; i++) {
-		if (!!values[i] != policydb->bool_val_to_struct[i]->state) {
+		if (!!values[i] !=
+			next_set->policydb.bool_val_to_struct[i]->state) {
 			audit_log(current->audit_context, GFP_ATOMIC,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
-				sym_name(policydb, SYM_BOOLS, i),
+				sym_name(&next_set->policydb, SYM_BOOLS, i),
 				!!values[i],
-				policydb->bool_val_to_struct[i]->state,
+				next_set->policydb.bool_val_to_struct[i]->state,
 				from_kuid(&init_user_ns, audit_get_loginuid(current)),
 				audit_get_sessionid(current));
 		}
 		if (values[i])
-			policydb->bool_val_to_struct[i]->state = 1;
+			next_set->policydb.bool_val_to_struct[i]->state = 1;
 		else
-			policydb->bool_val_to_struct[i]->state = 0;
+			next_set->policydb.bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = policydb->cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(policydb, cur);
+	for (cur = next_set->policydb.cond_list; cur; cur = cur->next) {
+		rc = evaluate_cond_node(&next_set->policydb, cur);
 		if (rc)
 			goto out;
 	}
 
 	seqno = ++state->ss->latest_granting;
+	state->ss->active_set = next_set;
 	rc = 0;
 out:
-	write_unlock_irq(&state->ss->policy_rwlock);
 	if (!rc) {
+		seqno = ++state->ss->latest_granting;
+		state->ss->active_set = next_set;
+		rc = 0;
+		write_unlock_irq(&state->ss->policy_rwlock);
 		avc_ss_reset(state->avc, seqno);
 		selnl_notify_policyload(seqno);
 		selinux_status_update_policyload(state, seqno);
 		selinux_xfrm_notify_policyload();
+		policydb_destroy(&old_set->policydb);
+		kfree(old_set);
+	} else {
+		printk(KERN_ERR "SELinux: %s failed %d\n", __func__, rc);
+		write_unlock_irq(&state->ss->policy_rwlock);
+		kfree(next_set);
 	}
+	policydb_flattened_free(storage);
+
+ errout:
 	return rc;
 }
 
@@ -2925,7 +2961,7 @@ int security_get_bool_value(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->active_set->policydb;
 
 	rc = -EFAULT;
 	len = policydb->p_bools.nprim;
@@ -2977,8 +3013,8 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct policydb *policydb = &state->ss->active_set->policydb;
+	struct sidtab *sidtab = state->ss->active_set->sidtab;
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
@@ -3068,8 +3104,8 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct policydb *policydb = &state->ss->active_set->policydb;
+	struct sidtab *sidtab = state->ss->active_set->sidtab;
 	int rc;
 	struct context *nlbl_ctx;
 	struct context *xfrm_ctx;
@@ -3146,7 +3182,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 int security_get_classes(struct selinux_state *state,
 			 char ***classes, int *nclasses)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc;
 
 	if (!state->initialized) {
@@ -3193,7 +3229,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 int security_get_permissions(struct selinux_state *state,
 			     char *class, char ***perms, int *nperms)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc, i;
 	struct class_datum *match;
 
@@ -3239,12 +3275,12 @@ int security_get_permissions(struct selinux_state *state,
 
 int security_get_reject_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.reject_unknown;
+	return state->ss->active_set->policydb.reject_unknown;
 }
 
 int security_get_allow_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.allow_unknown;
+	return state->ss->active_set->policydb.allow_unknown;
 }
 
 /**
@@ -3260,7 +3296,7 @@ int security_get_allow_unknown(struct selinux_state *state)
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc;
 
 	read_lock(&state->ss->policy_rwlock);
@@ -3288,7 +3324,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct selinux_state *state = &selinux_state;
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
 	struct type_datum *typedatum;
@@ -3430,7 +3466,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		goto out;
 	}
 
-	ctxt = sidtab_search(&state->ss->sidtab, sid);
+	ctxt = sidtab_search(state->ss->active_set->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3592,8 +3628,8 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct policydb *policydb = &state->ss->active_set->policydb;
+	struct sidtab *sidtab = state->ss->active_set->sidtab;
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
@@ -3661,7 +3697,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 int security_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc;
 	struct context *ctx;
 
@@ -3671,7 +3707,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -ENOENT;
-	ctx = sidtab_search(&state->ss->sidtab, sid);
+	ctx = sidtab_search(state->ss->active_set->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
@@ -3700,7 +3736,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc;
 	struct policy_file fp;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 24c7bdcc8075..9219649c70ed 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -23,12 +23,18 @@ struct selinux_map {
 	u16 size; /* array size of mapping */
 };
 
-struct selinux_ss {
-	struct sidtab sidtab;
+/* sidtab is stored as a pointer. We can then choice to
+ * use the old pointer or create a new sittab.
+ */
+struct selinux_ruleset {
+	struct sidtab *sidtab;
 	struct policydb policydb;
+	struct selinux_map map;
+};
+struct selinux_ss {
+	struct selinux_ruleset *active_set; /* rcu pointer */
 	rwlock_t policy_rwlock;
 	u32 latest_granting;
-	struct selinux_map map;
 	struct page *status_page;
 	struct mutex status_lock;
 };
-- 
2.15.1
