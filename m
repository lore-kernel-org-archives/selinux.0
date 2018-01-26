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
Date: Fri, 26 Jan 2018 15:32:41 +0100
Message-ID: <20180126143241.23108-6-peter.enderborg@sony.com>
In-Reply-To: <20180126143241.23108-1-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH v2 5/5] selinux: Switch locking to RCU.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Peter Enderborg <peter.enderborg@sony.com>

This patch switch to using RCU locks instead of rwlocks. This has
the big advantage that it does not has preempt disable.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Reported-by: Björn Davidsson <bjorn.davidsson@sony.com>
---
 security/selinux/ss/services.c | 162 +++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 80 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 81c5717..f142ef8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -87,7 +87,7 @@ int selinux_policycap_alwaysnetwork;
 int selinux_policycap_cgroupseclabel;
 int selinux_policycap_nnp_nosuid_transition;
 
-static DEFINE_RWLOCK(policy_rwlock);
+static DEFINE_SPINLOCK(policy_w_lock);
 
 int ss_initialized;
 
@@ -115,14 +115,14 @@ struct selinux_mapping {
 	u32 perms[sizeof(u32) * 8];
 };
 
-struct shared_current_mapping {
+struct shared_rcu_mapping {
 	struct selinux_mapping *current_mapping;
 	u16 current_mapping_size;
 	struct policydb policydb;
 	struct sidtab sidtab;
 };
 
-static struct shared_current_mapping *crm;
+static struct shared_rcu_mapping *crm;
 
 static int selinux_set_mapping(struct policydb *pol,
 			       struct security_class_mapping *map,
@@ -791,7 +791,7 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 	if (!ss_initialized)
 		return 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	if (!user)
 		tclass = unmap_class(orig_tclass);
@@ -845,7 +845,7 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 	}
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -879,7 +879,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	int index;
 	int rc;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	old_context = sidtab_search(&crm->sidtab, old_sid);
@@ -941,7 +941,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 		kfree(old_name);
 	}
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -1029,7 +1029,7 @@ void security_compute_xperms_decision(u32 ssid,
 	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
 	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	if (!ss_initialized)
 		goto allow;
 
@@ -1083,7 +1083,7 @@ void security_compute_xperms_decision(u32 ssid,
 		}
 	}
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
@@ -1110,7 +1110,7 @@ void security_compute_av(u32 ssid,
 	u16 tclass;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	avd_init(avd);
 	xperms->len = 0;
 	if (!ss_initialized)
@@ -1143,7 +1143,7 @@ void security_compute_av(u32 ssid,
 	context_struct_compute_av(scontext, tcontext, tclass, avd, xperms);
 	map_decision(orig_tclass, avd, crm->policydb.allow_unknown);
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1157,7 +1157,7 @@ void security_compute_av_user(u32 ssid,
 {
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	avd_init(avd);
 	if (!ss_initialized)
 		goto allow;
@@ -1188,7 +1188,7 @@ void security_compute_av_user(u32 ssid,
 
 	context_struct_compute_av(scontext, tcontext, tclass, avd, NULL);
  out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1293,7 +1293,7 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 		rc = -EINVAL;
 		goto out;
 	}
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	if (force)
 		context = sidtab_search_force(&crm->sidtab, sid);
 	else
@@ -1306,7 +1306,7 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 	}
 	rc = context_struct_to_string(context, scontext, scontext_len);
 out_unlock:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 out:
 	return rc;
 
@@ -1458,7 +1458,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 			goto out;
 	}
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	rc = string_to_context_struct(&crm->policydb, &crm->sidtab, scontext2,
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1470,7 +1470,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	rc = sidtab_context_to_sid(&crm->sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 out:
 	kfree(scontext2);
 	kfree(str);
@@ -1620,7 +1620,7 @@ static int security_compute_sid(u32 ssid,
 
 	context_init(&newcontext);
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	if (kern) {
 		tclass = unmap_class(orig_tclass);
@@ -1759,7 +1759,7 @@ static int security_compute_sid(u32 ssid,
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(&crm->sidtab, &newcontext, out_sid);
 out_unlock:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcontext);
 out:
 	return rc;
@@ -2051,7 +2051,6 @@ static void security_load_policycaps(struct policydb *pdb)
 }
 
 static int security_preserve_bools(struct policydb *p);
-
 /**
  * security_load_policy - Load a security policy configuration.
  * @data: binary policy data
@@ -2068,17 +2067,17 @@ int security_load_policy(void *data, size_t len)
 	struct sidtab oldsidtab, newsidtab;
 	struct selinux_mapping *oldmap = NULL, *map = NULL;
 	struct convert_context_args args;
-	struct shared_current_mapping *next_rcu;
-	struct shared_current_mapping *old_rcu;
+	struct shared_rcu_mapping *next_rcu;
+	struct shared_rcu_mapping *old_rcu;
 	u32 seqno;
 	u16 map_size;
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
 	if (!ss_initialized) {
-		struct shared_current_mapping *first_mapping;
+		struct shared_rcu_mapping *first_mapping;
 
-		first_mapping = kzalloc(sizeof(struct shared_current_mapping),
+		first_mapping = kzalloc(sizeof(struct shared_rcu_mapping),
 					GFP_KERNEL);
 		if (!first_mapping) {
 			rc = -ENOMEM;
@@ -2145,7 +2144,7 @@ int security_load_policy(void *data, size_t len)
 		goto out;
 	}
 
-	next_rcu = kzalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
+	next_rcu = kzalloc(sizeof(struct shared_rcu_mapping), GFP_KERNEL);
 	if (!next_rcu) {
 		kfree(oldpolicydb);
 		rc = -ENOMEM;
@@ -2157,7 +2156,7 @@ int security_load_policy(void *data, size_t len)
 		goto out;
 
 	next_rcu->policydb.len = len;
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	/* If switching between different policy types, log MLS status */
 	if (crm->policydb.mls_enabled && !next_rcu->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
@@ -2210,19 +2209,19 @@ int security_load_policy(void *data, size_t len)
 	/* Install the new policydb and SID table. */
 	/* next */
 	security_load_policycaps(&next_rcu->policydb);
-	read_unlock(&policy_rwlock);
-	write_lock_irq(&policy_rwlock);
 	sidtab_set(&next_rcu->sidtab, &newsidtab);
 	security_load_policycaps(&next_rcu->policydb);
 	oldmap = crm->current_mapping;
+	rcu_read_unlock();
 	next_rcu->current_mapping = map;
 	next_rcu->current_mapping_size = map_size;
 
+	spin_lock(&policy_w_lock);
 	seqno = ++latest_granting;
 	old_rcu = crm;
 	crm = next_rcu;
-	write_unlock_irq(&policy_rwlock);
-
+	spin_unlock(&policy_w_lock);
+	synchronize_rcu();
 	/* Free the old policydb and SID table. */
 	policydb_destroy(oldpolicydb);
 	sidtab_destroy(&oldsidtab);
@@ -2250,9 +2249,9 @@ size_t security_policydb_len(void)
 {
 	size_t len;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	len = crm->policydb.len;
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 
 	return len;
 }
@@ -2268,7 +2267,7 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	c = crm->policydb.ocontexts[OCON_PORT];
 	while (c) {
@@ -2293,7 +2292,7 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 	}
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2308,7 +2307,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	c = crm->policydb.ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2333,7 +2332,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2348,7 +2347,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	c = crm->policydb.ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2374,7 +2373,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2388,7 +2387,7 @@ int security_netif_sid(char *name, u32 *if_sid)
 	int rc = 0;
 	struct ocontext *c;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	c = crm->policydb.ocontexts[OCON_NETIF];
 	while (c) {
@@ -2415,7 +2414,7 @@ int security_netif_sid(char *name, u32 *if_sid)
 		*if_sid = SECINITSID_NETIF;
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2447,7 +2446,7 @@ int security_node_sid(u16 domain,
 	int rc;
 	struct ocontext *c;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	switch (domain) {
 	case AF_INET: {
@@ -2502,7 +2501,7 @@ int security_node_sid(u16 domain,
 
 	rc = 0;
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2541,7 +2540,7 @@ int security_get_user_sids(u32 fromsid,
 	if (!ss_initialized)
 		goto out;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	context_init(&usercon);
 
@@ -2593,7 +2592,7 @@ int security_get_user_sids(u32 fromsid,
 	}
 	rc = 0;
 out_unlock:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	if (rc || !mynel) {
 		kfree(mysids);
 		goto out;
@@ -2704,9 +2703,9 @@ int security_genfs_sid(const char *fstype,
 {
 	int retval;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	retval = __security_genfs_sid(fstype, path, orig_sclass, sid);
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return retval;
 }
 
@@ -2721,7 +2720,7 @@ int security_fs_use(struct super_block *sb)
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	c = crm->policydb.ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2752,7 +2751,7 @@ int security_fs_use(struct super_block *sb)
 	}
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2760,7 +2759,7 @@ int security_get_bools(int *len, char ***names, int **values)
 {
 	int i, rc;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	*names = NULL;
 	*values = NULL;
 
@@ -2790,7 +2789,7 @@ int security_get_bools(int *len, char ***names, int **values)
 	}
 	rc = 0;
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 err:
 	if (*names) {
@@ -2803,13 +2802,14 @@ int security_get_bools(int *len, char ***names, int **values)
 
 int security_set_bools(int len, int *values)
 {
-	struct shared_current_mapping *next_rcu, *old_rcu;
+
+	struct shared_rcu_mapping *next_rcu, *old_rcu;
 	int i, rc;
 	int lenp, seqno = 0;
 	struct cond_node *cur;
 
-	next_rcu = kzalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
-	read_lock(&policy_rwlock);
+	next_rcu = kzalloc(sizeof(struct shared_rcu_mapping), GFP_KERNEL);
+	rcu_read_lock();
 	old_rcu = crm;
 	memcpy(&next_rcu->policydb, &old_rcu->policydb,
 	       sizeof(struct policydb));
@@ -2842,13 +2842,15 @@ int security_set_bools(int len, int *values)
 		if (rc)
 			goto out;
 	}
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
+
 	rc = 0;
 
-	write_lock_irq(&policy_rwlock);
+	spin_lock(&policy_w_lock);
 	seqno = ++latest_granting;
 	crm = next_rcu;
-	write_unlock_irq(&policy_rwlock);
+	spin_unlock(&policy_w_lock);
+	synchronize_rcu();
 out:
 	if (!rc) {
 		avc_ss_reset(seqno);
@@ -2868,7 +2870,7 @@ int security_get_bool_value(int index)
 	int rc;
 	int len;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EFAULT;
 	len = crm->policydb.p_bools.nprim;
@@ -2877,7 +2879,7 @@ int security_get_bool_value(int index)
 
 	rc = crm->policydb.bool_val_to_struct[index]->state;
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2933,7 +2935,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 
 	context_init(&newcon);
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	context1 = sidtab_search(&crm->sidtab, sid);
@@ -2975,7 +2977,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 
 	rc = sidtab_context_to_sid(&crm->sidtab, &newcon, new_sid);
 out_unlock:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcon);
 out:
 	return rc;
@@ -3032,7 +3034,7 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	if (!crm->policydb.mls_enabled)
 		return 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(&crm->sidtab, nlbl_sid);
@@ -3059,7 +3061,7 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	 * expressive */
 	*peer_sid = xfrm_sid;
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3080,7 +3082,7 @@ int security_get_classes(char ***classes, int *nclasses)
 {
 	int rc;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -ENOMEM;
 	*nclasses = crm->policydb.p_classes.nprim;
@@ -3098,7 +3100,7 @@ int security_get_classes(char ***classes, int *nclasses)
 	}
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3120,7 +3122,7 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 	int rc, i;
 	struct class_datum *match;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	match = hashtab_search(crm->policydb.p_classes.table, class);
@@ -3149,11 +3151,11 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 		goto err;
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 
 err:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	for (i = 0; i < *nperms; i++)
 		kfree((*perms)[i]);
 	kfree(*perms);
@@ -3184,9 +3186,9 @@ int security_policycap_supported(unsigned int req_cap)
 {
 	int rc;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	rc = ebitmap_get_bit(&crm->policydb.policycaps, req_cap);
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -3250,7 +3252,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	context_init(&tmprule->au_ctxt);
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	tmprule->au_seqno = latest_granting;
 
@@ -3294,7 +3296,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	}
 	rc = 0;
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc) {
 		selinux_audit_rule_free(tmprule);
@@ -3344,7 +3346,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		return -ENOENT;
 	}
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	if (rule->au_seqno < latest_granting) {
 		match = -ESTALE;
@@ -3435,7 +3437,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 	}
 
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return match;
 }
 
@@ -3521,7 +3523,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		return 0;
 	}
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
@@ -3558,12 +3560,12 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 	} else
 		*sid = SECSID_NULL;
 
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return 0;
 out_free:
 	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3585,7 +3587,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	if (!ss_initialized)
 		return 0;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 
 	rc = -ENOENT;
 	ctx = sidtab_search(&crm->sidtab, sid);
@@ -3604,7 +3606,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	mls_export_netlbl_lvl(&crm->policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(&crm->policydb, ctx, secattr);
 out:
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
@@ -3632,9 +3634,9 @@ int security_read_policy(void **data, size_t *len)
 	fp.data = *data;
 	fp.len = *len;
 
-	read_lock(&policy_rwlock);
+	rcu_read_lock();
 	rc = policydb_write(&crm->policydb, &fp);
-	read_unlock(&policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc)
 		return rc;
-- 
2.7.4
