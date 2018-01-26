From: <peter.enderborg@sony.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 <alsa-devel@alsa-project.org>, "Serge E . Hallyn" <serge@hallyn.com>
CC: Peter Enderborg <peter.enderborg@sony.com>
Date: Fri, 26 Jan 2018 15:32:40 +0100
Message-ID: <20180126143241.23108-5-peter.enderborg@sony.com>
In-Reply-To: <20180126143241.23108-1-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH v2 4/5] selinux: Use pointer to switch policydb and
 sidtab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Peter Enderborg <peter.enderborg@sony.com>

This i preparation for switching to RCU locks. To be able to use
RCU we need atomic switched pointer. This adds the dynamic
memory copying to be a single pointer. It copy all the
data structures in to new ones. This is an overhead
for writing rules but the benifit is RCU.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 139 +++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 61 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2a8486c..81c5717 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2064,76 +2064,67 @@ static int security_preserve_bools(struct policydb *p);
  */
 int security_load_policy(void *data, size_t len)
 {
-	struct policydb *oldpolicydb, *newpolicydb;
+	struct policydb *oldpolicydb;
 	struct sidtab oldsidtab, newsidtab;
 	struct selinux_mapping *oldmap = NULL, *map = NULL;
 	struct convert_context_args args;
-	struct shared_current_mapping *new_mapping;
 	struct shared_current_mapping *next_rcu;
-
+	struct shared_current_mapping *old_rcu;
 	u32 seqno;
 	u16 map_size;
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	oldpolicydb = kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
-	if (!oldpolicydb) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	new_mapping = kzalloc(sizeof(struct shared_current_mapping),
-			      GFP_KERNEL);
-	if (!new_mapping) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	newpolicydb = oldpolicydb + 1;
-	next_rcu = kmalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
-	if (!next_rcu) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	if (!ss_initialized) {
-		crm = kzalloc(sizeof(struct shared_current_mapping),
-			      GFP_KERNEL);
-		if (!crm) {
+		struct shared_current_mapping *first_mapping;
+
+		first_mapping = kzalloc(sizeof(struct shared_current_mapping),
+					GFP_KERNEL);
+		if (!first_mapping) {
 			rc = -ENOMEM;
 			goto out;
 		}
 		avtab_cache_init();
 		ebitmap_cache_init();
 		hashtab_cache_init();
-		rc = policydb_read(&crm->policydb, fp);
+		rc = policydb_read(&first_mapping->policydb, fp);
 		if (rc) {
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
 			hashtab_cache_destroy();
+			kfree(first_mapping);
 			goto out;
 		}
 
-		crm->policydb.len = len;
-		rc = selinux_set_mapping(&crm->policydb, secclass_map,
-					 &crm->current_mapping,
-					 &crm->current_mapping_size);
+		first_mapping->policydb.len = len;
+		rc = selinux_set_mapping(&first_mapping->policydb, secclass_map,
+					 &first_mapping->current_mapping,
+					 &first_mapping->current_mapping_size);
 		if (rc) {
-			policydb_destroy(&crm->policydb);
+			policydb_destroy(&first_mapping->policydb);
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
 			hashtab_cache_destroy();
+			kfree(first_mapping);
 			goto out;
 		}
 
-		rc = policydb_load_isids(&crm->policydb, &crm->sidtab);
+		rc = policydb_load_isids(&first_mapping->policydb,
+					 &first_mapping->sidtab);
 		if (rc) {
-			policydb_destroy(&crm->policydb);
+			policydb_destroy(&first_mapping->policydb);
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
 			hashtab_cache_destroy();
+			kfree(first_mapping);
 			goto out;
 		}
 
-		security_load_policycaps(&crm->policydb);
+		security_load_policycaps(&first_mapping->policydb);
+		crm = first_mapping;
+
+		smp_mb(); /* make sure that crm exist before we */
+			  /* switch ss_initialized */
 		ss_initialized = 1;
 		seqno = ++latest_granting;
 		selinux_complete_init();
@@ -2148,30 +2139,44 @@ int security_load_policy(void *data, size_t len)
 #if 0
 	sidtab_hash_eval(&crm->sidtab, "sids");
 #endif
+	oldpolicydb = kzalloc(sizeof(*oldpolicydb), GFP_KERNEL);
+	if (!oldpolicydb) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	next_rcu = kzalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
+	if (!next_rcu) {
+		kfree(oldpolicydb);
+		rc = -ENOMEM;
+		goto out;
+	}
 
-	rc = policydb_read(newpolicydb, fp);
+	rc = policydb_read(&next_rcu->policydb, fp);
 	if (rc)
 		goto out;
 
-	newpolicydb->len = len;
+	next_rcu->policydb.len = len;
+	read_lock(&policy_rwlock);
 	/* If switching between different policy types, log MLS status */
-	if (crm->policydb.mls_enabled && !newpolicydb->mls_enabled)
+	if (crm->policydb.mls_enabled && !next_rcu->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!crm->policydb.mls_enabled && newpolicydb->mls_enabled)
+	else if (!crm->policydb.mls_enabled && next_rcu->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
 
-	rc = policydb_load_isids(newpolicydb, &newsidtab);
+	rc = policydb_load_isids(&next_rcu->policydb, &newsidtab);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(newpolicydb);
+		policydb_destroy(&next_rcu->policydb);
 		goto out;
 	}
 
-	rc = selinux_set_mapping(newpolicydb, secclass_map, &map, &map_size);
+	rc = selinux_set_mapping(&next_rcu->policydb, secclass_map,
+				 &map, &map_size);
 	if (rc)
 		goto err;
 
-	rc = security_preserve_bools(newpolicydb);
+	rc = security_preserve_bools(&next_rcu->policydb);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
 		goto err;
@@ -2189,7 +2194,7 @@ int security_load_policy(void *data, size_t len)
 	 * in the new SID table.
 	 */
 	args.oldp = &crm->policydb;
-	args.newp = newpolicydb;
+	args.newp = &next_rcu->policydb;
 	rc = sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to convert the internal"
@@ -2204,8 +2209,9 @@ int security_load_policy(void *data, size_t len)
 
 	/* Install the new policydb and SID table. */
 	/* next */
+	security_load_policycaps(&next_rcu->policydb);
+	read_unlock(&policy_rwlock);
 	write_lock_irq(&policy_rwlock);
-	memcpy(&next_rcu->policydb, newpolicydb, sizeof(struct policydb));
 	sidtab_set(&next_rcu->sidtab, &newsidtab);
 	security_load_policycaps(&next_rcu->policydb);
 	oldmap = crm->current_mapping;
@@ -2213,8 +2219,9 @@ int security_load_policy(void *data, size_t len)
 	next_rcu->current_mapping_size = map_size;
 
 	seqno = ++latest_granting;
-	write_unlock_irq(&policy_rwlock);
+	old_rcu = crm;
 	crm = next_rcu;
+	write_unlock_irq(&policy_rwlock);
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(oldpolicydb);
@@ -2226,17 +2233,16 @@ int security_load_policy(void *data, size_t len)
 	selinux_status_update_policyload(seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
+	kfree(oldpolicydb);
+	kfree(old_rcu);
 
 	rc = 0;
 	goto out;
-
 err:
 	kfree(map);
 	sidtab_destroy(&newsidtab);
-	policydb_destroy(newpolicydb);
-
+	policydb_destroy(&next_rcu->policydb);
 out:
-	kfree(oldpolicydb);
 	return rc;
 }
 
@@ -2795,54 +2801,65 @@ int security_get_bools(int *len, char ***names, int **values)
 	goto out;
 }
 
-
 int security_set_bools(int len, int *values)
 {
+	struct shared_current_mapping *next_rcu, *old_rcu;
 	int i, rc;
 	int lenp, seqno = 0;
 	struct cond_node *cur;
 
-	write_lock_irq(&policy_rwlock);
-
+	next_rcu = kzalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
+	read_lock(&policy_rwlock);
+	old_rcu = crm;
+	memcpy(&next_rcu->policydb, &old_rcu->policydb,
+	       sizeof(struct policydb));
 	rc = -EFAULT;
-	lenp = crm->policydb.p_bools.nprim;
+	lenp = next_rcu->policydb.p_bools.nprim;
+
 	if (len != lenp)
 		goto out;
 
 	for (i = 0; i < len; i++) {
 		if (!!values[i] !=
-		    crm->policydb.bool_val_to_struct[i]->state) {
+		    next_rcu->policydb.bool_val_to_struct[i]->state) {
 			audit_log(current->audit_context, GFP_ATOMIC,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
-				sym_name(&crm->policydb, SYM_BOOLS, i),
+				sym_name(&next_rcu->policydb, SYM_BOOLS, i),
 				!!values[i],
-				crm->policydb.bool_val_to_struct[i]->state,
+				next_rcu->policydb.bool_val_to_struct[i]->state,
 				from_kuid(&init_user_ns, audit_get_loginuid(current)),
 				audit_get_sessionid(current));
 		}
 		if (values[i])
-			crm->policydb.bool_val_to_struct[i]->state = 1;
+			next_rcu->policydb.bool_val_to_struct[i]->state = 1;
 		else
-			crm->policydb.bool_val_to_struct[i]->state = 0;
+			next_rcu->policydb.bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = crm->policydb.cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(&crm->policydb, cur);
+	for (cur = next_rcu->policydb.cond_list; cur; cur = cur->next) {
+		rc = evaluate_cond_node(&next_rcu->policydb, cur);
 		if (rc)
 			goto out;
 	}
+	read_unlock(&policy_rwlock);
+	rc = 0;
 
+	write_lock_irq(&policy_rwlock);
 	seqno = ++latest_granting;
-	rc = 0;
-out:
+	crm = next_rcu;
 	write_unlock_irq(&policy_rwlock);
+out:
 	if (!rc) {
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
 		selinux_status_update_policyload(seqno);
 		selinux_xfrm_notify_policyload();
+	} else {
+		kfree(next_rcu);
 	}
+	kfree(old_rcu);
+
 	return rc;
 }
 
-- 
2.7.4
