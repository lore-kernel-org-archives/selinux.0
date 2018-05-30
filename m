From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>, Doug
 Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 16:11:03 +0200
Message-ID: <20180530141104.28569-5-peter.enderborg@sony.com>
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH V3 4/5 selinux-next] selinux: seqno separation
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch separtate the locks for read and write, and
to be sure that they are using the same structure the
seqno is used. If the seqno is changed from the read to
write section the function reportes an eagain error.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 143 ++++++++++++++++++++++++++++-------------
 1 file changed, 98 insertions(+), 45 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2be471d72c85..954ebe490516 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2104,6 +2104,9 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	u32 seqno;
 	int rc = 0;
 	struct selinux_ruleset *next_set, *old_set;
+	size_t size;
+	void *storage;
+	struct policydb *pdc;
 	struct policy_file file = { data, len }, *fp = &file;
 
 	next_set = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
@@ -2111,14 +2114,15 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		rc = -ENOMEM;
 		goto out;
 	}
+
 	next_set->sidtab = kzalloc(sizeof(struct sidtab), GFP_KERNEL);
 	if (!next_set->sidtab) {
 		rc = -ENOMEM;
-		kfree(next_set);
-		goto out;
+		goto nexterr;
 	}
 
 	if (!state->initialized) {
+		/* sidtab exist before inititalisation */
 		old_set = state->ss->active_set;
 		rc = policydb_read(&next_set->policydb, fp);
 		if (rc)
@@ -2152,57 +2156,80 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		kfree(old_set);
 		goto out;
 	}
+
+	pdc = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
+	if (!pdc)
+		goto allocerr;
+
+	rc = policydb_flattened_alloc(&state->ss->active_set->policydb,
+				      &storage, &size);
+	if (rc)
+		goto pdcerr;
+
+	read_lock(&state->ss->policy_rwlock);
 	old_set = state->ss->active_set;
+	rc = policydb_copy(&old_set->policydb, pdc, &storage, size);
+
+	/* save seq */
+	seqno = state->ss->latest_granting;
+
+	read_unlock(&state->ss->policy_rwlock);
+
+	policydb_flattened_free(storage);
+
+	if (rc)
+		goto cpyerr;
+
 #if 0
 	sidtab_hash_eval(sidtab, "sids");
 #endif
-
 	rc = policydb_read(&next_set->policydb, fp);
 	if (rc)
-		goto out;
+		goto cpyerr;
 
 	next_set->policydb.len = len;
 
 	/* If switching between different policy types, log MLS status */
-	if (old_set->policydb.mls_enabled && !next_set->policydb.mls_enabled)
+	if (pdc->mls_enabled && !next_set->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!old_set->policydb.mls_enabled
+	else if (!pdc->mls_enabled
 		 && next_set->policydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
+
 	rc = policydb_load_isids(&next_set->policydb, next_set->sidtab);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(&next_set->policydb);
-		goto out;
+		goto cpyerr;
 	}
 
 	rc = selinux_set_mapping(&next_set->policydb, secclass_map, &newmap);
 	if (rc)
-		goto err;
+		goto loaderr;
 
 	rc = security_preserve_bools(state, &next_set->policydb);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
-		goto err;
+		goto maperr;
 	}
 
 	rc = sidtab_clone(old_set->sidtab, next_set->sidtab);
 	if (rc)
-		goto err;
+		goto maperr;
 
 	/*
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
 	 */
 	args.state = state;
-	args.oldp = &old_set->policydb;
+	args.oldp = pdc;
 	args.newp = &next_set->policydb;
+
 	rc = sidtab_map(next_set->sidtab, convert_context, &args);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
 			" table\n");
-		goto err;
+		goto maperr;
 	}
 
 	next_set->map.mapping = newmap.mapping;
@@ -2210,30 +2237,44 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&state->ss->policy_rwlock);
-	security_load_policycaps(state, &next_set->policydb);
-	seqno = ++state->ss->latest_granting;
-	state->ss->active_set = next_set;
-	write_unlock_irq(&state->ss->policy_rwlock);
-
-	avc_ss_reset(state->avc, seqno);
-	selnl_notify_policyload(seqno);
-	selinux_status_update_policyload(state, seqno);
-	selinux_netlbl_cache_invalidate();
-	selinux_xfrm_notify_policyload();
-
-	/* Free the old policydb and SID table. */
-	policydb_destroy(&old_set->policydb);
-	sidtab_destroy(old_set->sidtab);
-	kfree(old_set->sidtab);
-	kfree(old_set->map.mapping);
-	kfree(old_set);
-	rc = 0;
-	goto out;
+	if (seqno == state->ss->latest_granting) {
+		security_load_policycaps(state, &next_set->policydb);
+		seqno = ++state->ss->latest_granting;
+		state->ss->active_set = next_set;
+		write_unlock_irq(&state->ss->policy_rwlock);
 
-err:
+		avc_ss_reset(state->avc, seqno);
+		selnl_notify_policyload(seqno);
+		selinux_status_update_policyload(state, seqno);
+		selinux_netlbl_cache_invalidate();
+		selinux_xfrm_notify_policyload();
+
+		/* Free the old policydb and SID table. */
+		policydb_destroy(pdc);
+		kfree(pdc);
+		sidtab_destroy(old_set->sidtab);
+		policydb_destroy(&old_set->policydb);
+		kfree(old_set->sidtab);
+		kfree(old_set->map.mapping);
+		kfree(old_set);
+		rc = 0;
+		goto out;
+	} else {
+		write_unlock_irq(&state->ss->policy_rwlock);
+		rc = -EAGAIN;
+	}
+maperr:
 	kfree(newmap.mapping);
+loaderr:
 	sidtab_destroy(next_set->sidtab);
+cpyerr:
 	policydb_destroy(&next_set->policydb);
+	policydb_destroy(pdc);
+pdcerr:
+	kfree(pdc);
+allocerr:
+	kfree(next_set->sidtab);
+nexterr:
 	kfree(next_set);
 out:
 	return rc;
@@ -2873,11 +2914,13 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 		goto errout;
 	}
 
-	write_lock_irq(&state->ss->policy_rwlock);
+	read_lock(&state->ss->policy_rwlock);
 	old_set = state->ss->active_set;
+	seqno = state->ss->latest_granting;
 	memcpy(next_set, old_set, sizeof(struct selinux_ruleset));
 	rc = policydb_copy(&old_set->policydb, &next_set->policydb,
 			   &storage, size);
+	read_unlock(&state->ss->policy_rwlock);
 	if (rc)
 		goto out;
 
@@ -2913,19 +2956,29 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 	rc = 0;
 out:
 	if (!rc) {
-		seqno = ++state->ss->latest_granting;
-		state->ss->active_set = next_set;
-		rc = 0;
-		write_unlock_irq(&state->ss->policy_rwlock);
-		avc_ss_reset(state->avc, seqno);
-		selnl_notify_policyload(seqno);
-		selinux_status_update_policyload(state, seqno);
-		selinux_xfrm_notify_policyload();
-		policydb_destroy(&old_set->policydb);
-		kfree(old_set);
+		write_lock_irq(&state->ss->policy_rwlock);
+		if (seqno == state->ss->latest_granting) {
+			seqno = ++state->ss->latest_granting;
+			state->ss->active_set = next_set;
+			rc = 0;
+			write_unlock_irq(&state->ss->policy_rwlock);
+			avc_ss_reset(state->avc, seqno);
+			selnl_notify_policyload(seqno);
+			selinux_status_update_policyload(state, seqno);
+			selinux_xfrm_notify_policyload();
+			policydb_destroy(&old_set->policydb);
+			kfree(old_set);
+		} else {
+			rc = -ENOMEM;
+			write_unlock_irq(&state->ss->policy_rwlock);
+			printk(KERN_ERR "SELinux: %s failed in seqno %d\n",
+			       __func__, rc);
+			policydb_destroy(&next_set->policydb);
+			kfree(next_set);
+		}
 	} else {
 		printk(KERN_ERR "SELinux: %s failed %d\n", __func__, rc);
-		write_unlock_irq(&state->ss->policy_rwlock);
+		policydb_destroy(&next_set->policydb);
 		kfree(next_set);
 	}
 	policydb_flattened_free(storage);
-- 
2.15.1
