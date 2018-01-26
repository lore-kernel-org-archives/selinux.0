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
Date: Fri, 26 Jan 2018 15:32:39 +0100
Message-ID: <20180126143241.23108-4-peter.enderborg@sony.com>
In-Reply-To: <20180126143241.23108-1-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH v2 3/5] selinux: Move sidtab to pointer structure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Peter Enderborg <peter.enderborg@sony.com>

To be able to use rcu locks we need access the sidtab trough
a pointer. This moves the sittab to a dynamic allocated struture.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 140 ++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 66 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 21400bd..2a8486c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -89,7 +89,6 @@ int selinux_policycap_nnp_nosuid_transition;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
-static struct sidtab sidtab;
 int ss_initialized;
 
 /*
@@ -120,6 +119,7 @@ struct shared_current_mapping {
 	struct selinux_mapping *current_mapping;
 	u16 current_mapping_size;
 	struct policydb policydb;
+	struct sidtab sidtab;
 };
 
 static struct shared_current_mapping *crm;
@@ -804,7 +804,7 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 	}
 	tclass_datum = crm->policydb.class_val_to_struct[tclass - 1];
 
-	ocontext = sidtab_search(&sidtab, oldsid);
+	ocontext = sidtab_search(&crm->sidtab, oldsid);
 	if (!ocontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, oldsid);
@@ -812,7 +812,7 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 		goto out;
 	}
 
-	ncontext = sidtab_search(&sidtab, newsid);
+	ncontext = sidtab_search(&crm->sidtab, newsid);
 	if (!ncontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, newsid);
@@ -820,7 +820,7 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 		goto out;
 	}
 
-	tcontext = sidtab_search(&sidtab, tasksid);
+	tcontext = sidtab_search(&crm->sidtab, tasksid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, tasksid);
@@ -882,7 +882,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
-	old_context = sidtab_search(&sidtab, old_sid);
+	old_context = sidtab_search(&crm->sidtab, old_sid);
 	if (!old_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
 		       __func__, old_sid);
@@ -890,7 +890,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	}
 
 	rc = -EINVAL;
-	new_context = sidtab_search(&sidtab, new_sid);
+	new_context = sidtab_search(&crm->sidtab, new_sid);
 	if (!new_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
 		       __func__, new_sid);
@@ -1033,14 +1033,14 @@ void security_compute_xperms_decision(u32 ssid,
 	if (!ss_initialized)
 		goto allow;
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(&crm->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
 
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(&crm->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -1116,7 +1116,7 @@ void security_compute_av(u32 ssid,
 	if (!ss_initialized)
 		goto allow;
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(&crm->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
@@ -1127,7 +1127,7 @@ void security_compute_av(u32 ssid,
 	if (ebitmap_get_bit(&crm->policydb.permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(&crm->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -1162,7 +1162,7 @@ void security_compute_av_user(u32 ssid,
 	if (!ss_initialized)
 		goto allow;
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(&crm->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
@@ -1173,7 +1173,7 @@ void security_compute_av_user(u32 ssid,
 	if (ebitmap_get_bit(&crm->policydb.permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(&crm->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -1295,9 +1295,9 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 	}
 	read_lock(&policy_rwlock);
 	if (force)
-		context = sidtab_search_force(&sidtab, sid);
+		context = sidtab_search_force(&crm->sidtab, sid);
 	else
-		context = sidtab_search(&sidtab, sid);
+		context = sidtab_search(&crm->sidtab, sid);
 	if (!context) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
@@ -1459,7 +1459,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	}
 
 	read_lock(&policy_rwlock);
-	rc = string_to_context_struct(&crm->policydb, &sidtab, scontext2,
+	rc = string_to_context_struct(&crm->policydb, &crm->sidtab, scontext2,
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
@@ -1467,7 +1467,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-	rc = sidtab_context_to_sid(&sidtab, &context, sid);
+	rc = sidtab_context_to_sid(&crm->sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
 	read_unlock(&policy_rwlock);
@@ -1630,14 +1630,14 @@ static int security_compute_sid(u32 ssid,
 		sock = security_is_socket_class(map_class(tclass));
 	}
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(&crm->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(&crm->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -1757,7 +1757,7 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
+	rc = sidtab_context_to_sid(&crm->sidtab, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&policy_rwlock);
 	context_destroy(&newcontext);
@@ -2017,36 +2017,33 @@ static int convert_context(u32 key,
 	goto out;
 }
 
-static void security_load_policycaps(void)
+static void security_load_policycaps(struct policydb *pdb)
 {
 	unsigned int i;
 	struct ebitmap_node *node;
 
-	selinux_policycap_netpeer =
-		ebitmap_get_bit(&crm->policydb.policycaps,
-			  POLICYDB_CAPABILITY_NETPEER);
-	selinux_policycap_openperm =
-		ebitmap_get_bit(&crm->policydb.policycaps,
-				POLICYDB_CAPABILITY_OPENPERM);
-	selinux_policycap_extsockclass =
-		ebitmap_get_bit(&crm->policydb.policycaps,
-				POLICYDB_CAPABILITY_EXTSOCKCLASS);
+	selinux_policycap_netpeer = ebitmap_get_bit(&pdb->policycaps,
+						  POLICYDB_CAPABILITY_NETPEER);
+	selinux_policycap_openperm = ebitmap_get_bit(&pdb->policycaps,
+						  POLICYDB_CAPABILITY_OPENPERM);
+	selinux_policycap_extsockclass = ebitmap_get_bit(&pdb->policycaps,
+					  POLICYDB_CAPABILITY_EXTSOCKCLASS);
 	selinux_policycap_alwaysnetwork =
-		ebitmap_get_bit(&crm->policydb.policycaps,
+		ebitmap_get_bit(&pdb->policycaps,
 				POLICYDB_CAPABILITY_ALWAYSNETWORK);
 	selinux_policycap_cgroupseclabel =
-		ebitmap_get_bit(&crm->policydb.policycaps,
+		ebitmap_get_bit(&pdb->policycaps,
 				POLICYDB_CAPABILITY_CGROUPSECLABEL);
 	selinux_policycap_nnp_nosuid_transition =
-		ebitmap_get_bit(&crm->policydb.policycaps,
+		ebitmap_get_bit(&pdb->policycaps,
 				POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION);
 
 	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
 		pr_info("SELinux:  policy capability %s=%d\n",
 			selinux_policycap_names[i],
-			ebitmap_get_bit(&crm->policydb.policycaps, i));
+			ebitmap_get_bit(&pdb->policycaps, i));
 
-	ebitmap_for_each_positive_bit(&crm->policydb.policycaps, node, i) {
+	ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
 		if (i >= ARRAY_SIZE(selinux_policycap_names))
 			pr_info("SELinux:  unknown policy capability %u\n",
 				i);
@@ -2072,6 +2069,8 @@ int security_load_policy(void *data, size_t len)
 	struct selinux_mapping *oldmap = NULL, *map = NULL;
 	struct convert_context_args args;
 	struct shared_current_mapping *new_mapping;
+	struct shared_current_mapping *next_rcu;
+
 	u32 seqno;
 	u16 map_size;
 	int rc = 0;
@@ -2089,6 +2088,11 @@ int security_load_policy(void *data, size_t len)
 		goto out;
 	}
 	newpolicydb = oldpolicydb + 1;
+	next_rcu = kmalloc(sizeof(struct shared_current_mapping), GFP_KERNEL);
+	if (!next_rcu) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	if (!ss_initialized) {
 		crm = kzalloc(sizeof(struct shared_current_mapping),
@@ -2097,7 +2101,6 @@ int security_load_policy(void *data, size_t len)
 			rc = -ENOMEM;
 			goto out;
 		}
-
 		avtab_cache_init();
 		ebitmap_cache_init();
 		hashtab_cache_init();
@@ -2121,7 +2124,7 @@ int security_load_policy(void *data, size_t len)
 			goto out;
 		}
 
-		rc = policydb_load_isids(&crm->policydb, &sidtab);
+		rc = policydb_load_isids(&crm->policydb, &crm->sidtab);
 		if (rc) {
 			policydb_destroy(&crm->policydb);
 			avtab_cache_destroy();
@@ -2130,7 +2133,7 @@ int security_load_policy(void *data, size_t len)
 			goto out;
 		}
 
-		security_load_policycaps();
+		security_load_policycaps(&crm->policydb);
 		ss_initialized = 1;
 		seqno = ++latest_granting;
 		selinux_complete_init();
@@ -2143,7 +2146,7 @@ int security_load_policy(void *data, size_t len)
 	}
 
 #if 0
-	sidtab_hash_eval(&sidtab, "sids");
+	sidtab_hash_eval(&crm->sidtab, "sids");
 #endif
 
 	rc = policydb_read(newpolicydb, fp);
@@ -2175,9 +2178,9 @@ int security_load_policy(void *data, size_t len)
 	}
 
 	/* Clone the SID table. */
-	sidtab_shutdown(&sidtab);
+	sidtab_shutdown(&crm->sidtab);
 
-	rc = sidtab_map(&sidtab, clone_sid, &newsidtab);
+	rc = sidtab_map(&crm->sidtab, clone_sid, &newsidtab);
 	if (rc)
 		goto err;
 
@@ -2197,19 +2200,21 @@ int security_load_policy(void *data, size_t len)
 
 	/* Save the old policydb and SID table to free later. */
 	memcpy(oldpolicydb, &crm->policydb, sizeof(struct policydb));
-	sidtab_set(&oldsidtab, &sidtab);
+	sidtab_set(&oldsidtab, &crm->sidtab);
 
 	/* Install the new policydb and SID table. */
+	/* next */
 	write_lock_irq(&policy_rwlock);
-	memcpy(&crm->policydb, newpolicydb, sizeof(struct policydb));
-
-	sidtab_set(&sidtab, &newsidtab);
-	security_load_policycaps();
+	memcpy(&next_rcu->policydb, newpolicydb, sizeof(struct policydb));
+	sidtab_set(&next_rcu->sidtab, &newsidtab);
+	security_load_policycaps(&next_rcu->policydb);
 	oldmap = crm->current_mapping;
-	crm->current_mapping = map;
-	crm->current_mapping_size = map_size;
+	next_rcu->current_mapping = map;
+	next_rcu->current_mapping_size = map_size;
+
 	seqno = ++latest_granting;
 	write_unlock_irq(&policy_rwlock);
+	crm = next_rcu;
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(oldpolicydb);
@@ -2270,7 +2275,7 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2311,7 +2316,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2352,7 +2357,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2388,12 +2393,12 @@ int security_netif_sid(char *name, u32 *if_sid)
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						  &c->context[0],
 						  &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						   &c->context[1],
 						   &c->sid[1]);
 			if (rc)
@@ -2478,7 +2483,7 @@ int security_node_sid(u16 domain,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(&crm->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2535,7 +2540,7 @@ int security_get_user_sids(u32 fromsid,
 	context_init(&usercon);
 
 	rc = -EINVAL;
-	fromcon = sidtab_search(&sidtab, fromsid);
+	fromcon = sidtab_search(&crm->sidtab, fromsid);
 	if (!fromcon)
 		goto out_unlock;
 
@@ -2561,7 +2566,8 @@ int security_get_user_sids(u32 fromsid,
 						 user, &usercon))
 				continue;
 
-			rc = sidtab_context_to_sid(&sidtab, &usercon, &sid);
+			rc = sidtab_context_to_sid(&crm->sidtab, &usercon,
+						   &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2663,7 +2669,8 @@ static inline int __security_genfs_sid(const char *fstype,
 		goto out;
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(&sidtab, &c->context[0], &c->sid[0]);
+		rc = sidtab_context_to_sid(&crm->sidtab, &c->context[0],
+					   &c->sid[0]);
 		if (rc)
 			goto out;
 	}
@@ -2720,7 +2727,8 @@ int security_fs_use(struct super_block *sb)
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab, &c->context[0],
+			rc = sidtab_context_to_sid(&crm->sidtab,
+						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2911,7 +2919,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
-	context1 = sidtab_search(&sidtab, sid);
+	context1 = sidtab_search(&crm->sidtab, sid);
 	if (!context1) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
@@ -2919,7 +2927,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	}
 
 	rc = -EINVAL;
-	context2 = sidtab_search(&sidtab, mls_sid);
+	context2 = sidtab_search(&crm->sidtab, mls_sid);
 	if (!context2) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, mls_sid);
@@ -2948,7 +2956,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 		}
 	}
 
-	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
+	rc = sidtab_context_to_sid(&crm->sidtab, &newcon, new_sid);
 out_unlock:
 	read_unlock(&policy_rwlock);
 	context_destroy(&newcon);
@@ -3010,14 +3018,14 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
-	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
+	nlbl_ctx = sidtab_search(&crm->sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, nlbl_sid);
 		goto out;
 	}
 	rc = -EINVAL;
-	xfrm_ctx = sidtab_search(&sidtab, xfrm_sid);
+	xfrm_ctx = sidtab_search(&crm->sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, xfrm_sid);
@@ -3326,7 +3334,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		goto out;
 	}
 
-	ctxt = sidtab_search(&sidtab, sid);
+	ctxt = sidtab_search(&crm->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3504,7 +3512,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		*sid = secattr->attr.secid;
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
-		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
+		ctx = sidtab_search(&crm->sidtab, SECINITSID_NETMSG);
 		if (ctx == NULL)
 			goto out;
 
@@ -3523,7 +3531,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		if (!mls_context_isvalid(&crm->policydb, &ctx_new))
 			goto out_free;
 
-		rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
+		rc = sidtab_context_to_sid(&crm->sidtab, &ctx_new, sid);
 		if (rc)
 			goto out_free;
 
@@ -3563,7 +3571,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	read_lock(&policy_rwlock);
 
 	rc = -ENOENT;
-	ctx = sidtab_search(&sidtab, sid);
+	ctx = sidtab_search(&crm->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
-- 
2.7.4
