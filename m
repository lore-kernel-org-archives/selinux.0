Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDFC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3D82063A
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYEpS/1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHSPyL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHSPyI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 11:54:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA7C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:54:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so11463572qvk.6
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOmJoizU3ZDFTfki3X/lawRPn/XBh63Rh2IeYhAuxv0=;
        b=XYEpS/1e2eSPCkpzUArSUskUdNpk85PdshME9d9EoRgdQM9JEDWhxVTyO8K213gd4a
         qCq8YNwhVVoaWNHjwStIis0lkWMdhegtmGHHIN96wkli+7MOLrt2ucc1kbroU0QF2biz
         DceZXcHDeXz1Gb5bJjq6diFB9tBtTWgq46DXOPaUdUd/v0ltL8O/AES7MGWGNguS4A1y
         MO5w+8buPEXGQxjsXlc9RF6afXYLZ/q32exdwq4WE/q+EcRzYSOPUXKPF+ordchKlz/b
         TtxJS73WcIqcrwhajscJPtIgg/hpuDCDeZUHJP3KzqycioE1OeDmyIuyMrhdUrSB5hZI
         1Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOmJoizU3ZDFTfki3X/lawRPn/XBh63Rh2IeYhAuxv0=;
        b=paUYtMsgv08LGGaAS+kopBMYWFD290OWfcx+E7MyQI9cmyXD0TMKn73NWkPEgVoC21
         OpUyBpJWlBD0INW98uhSUHgnOs8JQKhc+iDFTsX9bUaDkV8W4agr7nlSmith4WVEl+sJ
         SXZE6B50Kz1TZfxLf4Enr1Ht8asxx5u8Ukn6nGAj44kYVbePcXQXnvu9bYSDP459wry9
         SzY8fz1Ktp7tRGW927+aQy5OC8tIBT6NsnHgdia3DZ6Rs5MXsIfhywPmTchUfT79pTMr
         NFfvGxfPZhz62XUjCCk3hkjyJvdCsCwKUHWX0V9/r2NH8CZ0z5nQMYONgFUHlQ0lsi/t
         G4NQ==
X-Gm-Message-State: AOAM530SvYQLpE+WIhWVhqYA27o/6JKCeCz/HBkBVjEl2EsEpyd1yr9J
        969VPmqugd02xF/fcCOvpck=
X-Google-Smtp-Source: ABdhPJz4jPDpaR1aIfr0XHowR8BYDclO8TPgu2kt8R90zPMLJRaqh5swUOGw2nRLPuj80v9oBPF67A==
X-Received: by 2002:a0c:fb11:: with SMTP id c17mr23538445qvp.113.1597852447210;
        Wed, 19 Aug 2020 08:54:07 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id a6sm25207614qka.5.2020.08.19.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:54:06 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com, paulmck@kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v3] selinux: convert policy read-write lock to RCU
Date:   Wed, 19 Aug 2020 11:53:55 -0400
Message-Id: <20200819155355.45740-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the policy read-write lock to RCU.  This is significantly
simplified by the earlier work to encapsulate the policy data
structures and refactor the policy load and boolean setting logic.
Move the latest_granting sequence number into the selinux_policy
structure so that it can be updated atomically with the policy.
Since removing the policy rwlock and moving latest_granting reduces
the selinux_ss structure to nothing more than a wrapper around the
selinux_policy pointer, get rid of the extra layer of indirection.

At present this change merely passes a hardcoded 1 to
rcu_dereference_check() in the cases where we know we do not need to
take rcu_read_lock(), with the preceding comment explaining why.
Alternatively we could pass fsi->mutex down from selinuxfs and
apply a lockdep check on it instead.

Based in part on earlier attempts to convert the policy rwlock
to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].

[1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
[2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 passes the selinux_policy pointer down to lower level functions
after the initial rcu_dereference() so that we never dereference it
twice on the same code path.  It also corrects a missing rcu_deference()
and gets rid of some unnecessary cases of rcu_read_lock()/unlock().
Remaining open questions include whether I should change selinuxfs
to pass down fsi->mutex so that we can use it in a lockdep check
for rcu_dereference_check() and whether the sidtab live convert is
safe after this change.

 security/selinux/hooks.c            |   1 -
 security/selinux/include/security.h |   5 +-
 security/selinux/ss/services.c      | 490 ++++++++++++++++------------
 security/selinux/ss/services.h      |   5 -
 4 files changed, 283 insertions(+), 218 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ca901025802a..102292f96b0f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7232,7 +7232,6 @@ static __init int selinux_init(void)
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
-	selinux_ss_init(&selinux_state.ss);
 	selinux_avc_init(&selinux_state.avc);
 	mutex_init(&selinux_state.status_lock);
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c68ed2beadff..1b6a67a66a7e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -13,6 +13,7 @@
 #include <linux/dcache.h>
 #include <linux/magic.h>
 #include <linux/types.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include "flask.h"
@@ -84,7 +85,6 @@ extern int selinux_enabled_boot;
 #define POLICYDB_BOUNDS_MAXDEPTH	4
 
 struct selinux_avc;
-struct selinux_ss;
 struct selinux_policy;
 
 struct selinux_state {
@@ -102,10 +102,9 @@ struct selinux_state {
 	struct mutex status_lock;
 
 	struct selinux_avc *avc;
-	struct selinux_ss *ss;
+	struct selinux_policy *policy __rcu;
 } __randomize_layout;
 
-void selinux_ss_init(struct selinux_ss **ss);
 void selinux_avc_init(struct selinux_avc **avc);
 
 extern struct selinux_state selinux_state;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a48fc1b337ba..35a8b7a3da39 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -66,14 +66,6 @@
 #include "audit.h"
 #include "policycap_names.h"
 
-static struct selinux_ss selinux_ss;
-
-void selinux_ss_init(struct selinux_ss **ss)
-{
-	rwlock_init(&selinux_ss.policy_rwlock);
-	*ss = &selinux_ss;
-}
-
 /* Forward declaration. */
 static int context_struct_to_string(struct policydb *policydb,
 				    struct context *context,
@@ -239,13 +231,15 @@ static void map_decision(struct selinux_map *map,
 int security_mls_enabled(struct selinux_state *state)
 {
 	int mls_enabled;
+	struct selinux_policy *policy;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	mls_enabled = state->ss->policy->policydb.mls_enabled;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	mls_enabled = policy->policydb.mls_enabled;
+	rcu_read_unlock();
 	return mls_enabled;
 }
 
@@ -717,13 +711,14 @@ static void context_struct_compute_av(struct policydb *policydb,
 }
 
 static int security_validtrans_handle_fail(struct selinux_state *state,
-					   struct sidtab_entry *oentry,
-					   struct sidtab_entry *nentry,
-					   struct sidtab_entry *tentry,
-					   u16 tclass)
+					struct selinux_policy *policy,
+					struct sidtab_entry *oentry,
+					struct sidtab_entry *nentry,
+					struct sidtab_entry *tentry,
+					u16 tclass)
 {
-	struct policydb *p = &state->ss->policy->policydb;
-	struct sidtab *sidtab = state->ss->policy->sidtab;
+	struct policydb *p = &policy->policydb;
+	struct sidtab *sidtab = policy->sidtab;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -751,6 +746,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 					  u32 oldsid, u32 newsid, u32 tasksid,
 					  u16 orig_tclass, bool user)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *oentry;
@@ -765,13 +761,14 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (!user)
-		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+		tclass = unmap_class(&policy->map, orig_tclass);
 	else
 		tclass = orig_tclass;
 
@@ -814,17 +811,18 @@ static int security_compute_validatetrans(struct selinux_state *state,
 				rc = -EPERM;
 			else
 				rc = security_validtrans_handle_fail(state,
-								     oentry,
-								     nentry,
-								     tentry,
-								     tclass);
+								policy,
+								oentry,
+								nentry,
+								tentry,
+								tclass);
 			goto out;
 		}
 		constraint = constraint->next;
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -856,6 +854,7 @@ int security_validate_transition(struct selinux_state *state,
 int security_bounded_transition(struct selinux_state *state,
 				u32 old_sid, u32 new_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
@@ -866,10 +865,10 @@ int security_bounded_transition(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	rc = -EINVAL;
 	old_entry = sidtab_search_entry(sidtab, old_sid);
@@ -930,17 +929,20 @@ int security_bounded_transition(struct selinux_state *state,
 		kfree(old_name);
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
 
-static void avd_init(struct selinux_state *state, struct av_decision *avd)
+static void avd_init(struct selinux_policy *policy, struct av_decision *avd)
 {
 	avd->allowed = 0;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
-	avd->seqno = state->ss->latest_granting;
+	if (policy)
+		avd->seqno = policy->latest_granting;
+	else
+		avd->seqno = 0;
 	avd->flags = 0;
 }
 
@@ -1005,6 +1007,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 				      u8 driver,
 				      struct extended_perms_decision *xpermd)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	u16 tclass;
@@ -1021,12 +1024,13 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
 	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1042,7 +1046,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+	tclass = unmap_class(&policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1074,7 +1078,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		}
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
@@ -1099,19 +1103,21 @@ void security_compute_av(struct selinux_state *state,
 			 struct av_decision *avd,
 			 struct extended_perms *xperms)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	u16 tclass;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
-	avd_init(state, avd);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	avd_init(policy, avd);
 	xperms->len = 0;
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1131,7 +1137,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+	tclass = unmap_class(&policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1139,10 +1145,10 @@ void security_compute_av(struct selinux_state *state,
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  xperms);
-	map_decision(&state->ss->policy->map, orig_tclass, avd,
+	map_decision(&policy->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1155,17 +1161,19 @@ void security_compute_av_user(struct selinux_state *state,
 			      u16 tclass,
 			      struct av_decision *avd)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
-	avd_init(state, avd);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	avd_init(policy, avd);
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1194,7 +1202,7 @@ void security_compute_av_user(struct selinux_state *state,
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  NULL);
  out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1279,6 +1287,7 @@ static int sidtab_entry_to_string(struct policydb *p,
 
 int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 {
+	struct selinux_policy *policy;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -1287,9 +1296,10 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 		return -EINVAL;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = sidtab_hash_stats(state->ss->policy->sidtab, page);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	rc = sidtab_hash_stats(policy->sidtab, page);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -1306,6 +1316,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 					u32 *scontext_len, int force,
 					int only_invalid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *entry;
@@ -1335,9 +1346,10 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		       "load_policy on unknown SID %d\n", __func__, sid);
 		return -EINVAL;
 	}
-	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (force)
 		entry = sidtab_search_entry_force(sidtab, sid);
@@ -1356,7 +1368,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 				    scontext_len);
 
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 
 }
@@ -1491,6 +1503,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
 					int force)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	char *scontext2, *str = NULL;
@@ -1529,9 +1542,10 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		if (!str)
 			goto out;
 	}
-	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1543,7 +1557,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 out:
 	kfree(scontext2);
 	kfree(str);
@@ -1613,13 +1627,14 @@ int security_context_to_sid_force(struct selinux_state *state,
 
 static int compute_sid_handle_invalid_context(
 	struct selinux_state *state,
+	struct selinux_policy *policy,
 	struct sidtab_entry *sentry,
 	struct sidtab_entry *tentry,
 	u16 tclass,
 	struct context *newcontext)
 {
-	struct policydb *policydb = &state->ss->policy->policydb;
-	struct sidtab *sidtab = state->ss->policy->sidtab;
+	struct policydb *policydb = &policy->policydb;
+	struct sidtab *sidtab = policy->sidtab;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 	struct audit_buffer *ab;
@@ -1686,6 +1701,7 @@ static int security_compute_sid(struct selinux_state *state,
 				u32 *out_sid,
 				bool kern)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct class_datum *cladatum = NULL;
@@ -1712,19 +1728,21 @@ static int security_compute_sid(struct selinux_state *state,
 
 	context_init(&newcontext);
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+
+	policy = rcu_dereference(state->policy);
 
 	if (kern) {
-		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+		tclass = unmap_class(&policy->map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
 	} else {
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(&state->ss->policy->map,
+		sock = security_is_socket_class(map_class(&policy->map,
 							  tclass));
 	}
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	sentry = sidtab_search_entry(sidtab, ssid);
 	if (!sentry) {
@@ -1844,15 +1862,16 @@ static int security_compute_sid(struct selinux_state *state,
 
 	/* Check the validity of the context. */
 	if (!policydb_context_isvalid(policydb, &newcontext)) {
-		rc = compute_sid_handle_invalid_context(state, sentry, tentry,
-							tclass, &newcontext);
+		rc = compute_sid_handle_invalid_context(state, policy, sentry,
+							tentry, tclass,
+							&newcontext);
 		if (rc)
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcontext);
 out:
 	return rc;
@@ -1939,9 +1958,9 @@ int security_change_sid(struct selinux_state *state,
 
 static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
+	struct policydb *policydb,
 	struct context *context)
 {
-	struct policydb *policydb = &state->ss->policy->policydb;
 	char *s;
 	u32 len;
 
@@ -2073,7 +2092,9 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, newc)) {
-		rc = convert_context_handle_invalid_context(args->state, oldc);
+		rc = convert_context_handle_invalid_context(args->state,
+							args->oldp,
+							oldc);
 		if (rc)
 			goto bad;
 	}
@@ -2092,15 +2113,14 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	return 0;
 }
 
-static void security_load_policycaps(struct selinux_state *state)
+static void security_load_policycaps(struct selinux_state *state,
+				struct selinux_policy *policy)
 {
 	struct policydb *p;
 	unsigned int i;
 	struct ebitmap_node *node;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	p = &state->ss->policy->policydb;
+	p = &policy->policydb;
 
 	for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
 		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
@@ -2115,12 +2135,10 @@ static void security_load_policycaps(struct selinux_state *state)
 			pr_info("SELinux:  unknown policy capability %u\n",
 				i);
 	}
-
-	read_unlock(&state->ss->policy_rwlock);
 }
 
-static int security_preserve_bools(struct selinux_state *state,
-				   struct policydb *newpolicydb);
+static int security_preserve_bools(struct selinux_policy *oldpolicy,
+				struct selinux_policy *newpolicy);
 
 static void selinux_policy_free(struct selinux_policy *policy)
 {
@@ -2134,10 +2152,26 @@ static void selinux_policy_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
+static void selinux_policy_cond_free(struct selinux_policy *policy)
+{
+	cond_policydb_destroy_dup(&policy->policydb);
+	kfree(policy);
+}
+
 void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy)
 {
-	sidtab_cancel_convert(state->ss->policy->sidtab);
+	struct selinux_policy *oldpolicy;
+
+	/*
+	 * NOTE: We do not need to take the rcu read lock
+	 * around the code below because other policy-modifying
+	 * operations are already excluded by selinuxfs via
+	 * fsi->mutex.
+	 */
+	oldpolicy = rcu_dereference_check(state->policy, 1);
+
+	sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(policy);
 }
 
@@ -2159,14 +2193,14 @@ void selinux_policy_commit(struct selinux_state *state,
 	u32 seqno;
 
 	/*
-	 * NOTE: We do not need to take the policy read-lock
+	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
+	oldpolicy = rcu_dereference_check(state->policy, 1);
 
 	/* If switching between different policy types, log MLS status */
-	oldpolicy = state->ss->policy;
 	if (oldpolicy) {
 		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
 			pr_info("SELinux: Disabling MLS support...\n");
@@ -2174,14 +2208,19 @@ void selinux_policy_commit(struct selinux_state *state,
 			pr_info("SELinux: Enabling MLS support...\n");
 	}
 
+
+	/* Set latest granting seqno for new policy. */
+	if (oldpolicy)
+		newpolicy->latest_granting = oldpolicy->latest_granting + 1;
+	else
+		newpolicy->latest_granting = 1;
+	seqno = newpolicy->latest_granting;
+
 	/* Install the new policy. */
-	write_lock_irq(&state->ss->policy_rwlock);
-	state->ss->policy = newpolicy;
-	seqno = ++state->ss->latest_granting;
-	write_unlock_irq(&state->ss->policy_rwlock);
+	rcu_assign_pointer(state->policy, newpolicy);
 
 	/* Load the policycaps from the new policy */
-	security_load_policycaps(state);
+	security_load_policycaps(state, newpolicy);
 
 	if (!selinux_initialized(state)) {
 		/*
@@ -2194,6 +2233,7 @@ void selinux_policy_commit(struct selinux_state *state,
 	}
 
 	/* Free the old policy */
+	synchronize_rcu();
 	selinux_policy_free(oldpolicy);
 
 	/* Notify others of the policy change */
@@ -2213,7 +2253,7 @@ void selinux_policy_commit(struct selinux_state *state,
 int security_load_policy(struct selinux_state *state, void *data, size_t len,
 			struct selinux_policy **newpolicyp)
 {
-	struct selinux_policy *newpolicy;
+	struct selinux_policy *newpolicy, *oldpolicy;
 	struct sidtab_convert_params convert_params;
 	struct convert_context_args args;
 	int rc = 0;
@@ -2250,8 +2290,16 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		return 0;
 	}
 
+	/*
+	 * NOTE: We do not need to take the rcu read lock
+	 * around the code below because other policy-modifying
+	 * operations are already excluded by selinuxfs via
+	 * fsi->mutex.
+	 */
+	oldpolicy = rcu_dereference_check(state->policy, 1);
+
 	/* Preserve active boolean values from the old policy */
-	rc = security_preserve_bools(state, &newpolicy->policydb);
+	rc = security_preserve_bools(oldpolicy, newpolicy);
 	if (rc) {
 		pr_err("SELinux:  unable to preserve booleans\n");
 		goto err;
@@ -2260,21 +2308,18 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	/*
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
-	 *
-	 * NOTE: We do not need to take the policy read-lock
-	 * around the code below because other policy-modifying
-	 * operations are already excluded by selinuxfs via
-	 * fsi->mutex.
 	 */
+
+
 	args.state = state;
-	args.oldp = &state->ss->policy->policydb;
+	args.oldp = &oldpolicy->policydb;
 	args.newp = &newpolicy->policydb;
 
 	convert_params.func = convert_context;
 	convert_params.args = &args;
 	convert_params.target = newpolicy->sidtab;
 
-	rc = sidtab_convert(state->ss->policy->sidtab, &convert_params);
+	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2291,14 +2336,16 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 
 size_t security_policydb_len(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	size_t len;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	len = state->ss->policy->policydb.len;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	len = policy->policydb.len;
+	rcu_read_unlock();
 
 	return len;
 }
@@ -2312,6 +2359,7 @@ size_t security_policydb_len(struct selinux_state *state)
 int security_port_sid(struct selinux_state *state,
 		      u8 protocol, u16 port, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
@@ -2322,10 +2370,10 @@ int security_port_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2349,7 +2397,7 @@ int security_port_sid(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2362,6 +2410,7 @@ int security_port_sid(struct selinux_state *state,
 int security_ib_pkey_sid(struct selinux_state *state,
 			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
@@ -2372,10 +2421,10 @@ int security_ib_pkey_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2400,7 +2449,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2413,6 +2462,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 int security_ib_endport_sid(struct selinux_state *state,
 			    const char *dev_name, u8 port_num, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
@@ -2423,10 +2473,10 @@ int security_ib_endport_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2451,7 +2501,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2463,6 +2513,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 int security_netif_sid(struct selinux_state *state,
 		       char *name, u32 *if_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
@@ -2473,10 +2524,10 @@ int security_netif_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2501,7 +2552,7 @@ int security_netif_sid(struct selinux_state *state,
 		*if_sid = SECINITSID_NETIF;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2531,6 +2582,7 @@ int security_node_sid(struct selinux_state *state,
 		      u32 addrlen,
 		      u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
@@ -2541,10 +2593,10 @@ int security_node_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2599,7 +2651,7 @@ int security_node_sid(struct selinux_state *state,
 
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2625,6 +2677,7 @@ int security_get_user_sids(struct selinux_state *state,
 			   u32 **sids,
 			   u32 *nel)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *fromcon, usercon;
@@ -2641,10 +2694,10 @@ int security_get_user_sids(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto out;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	context_init(&usercon);
 
@@ -2695,7 +2748,7 @@ int security_get_user_sids(struct selinux_state *state,
 	}
 	rc = 0;
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	if (rc || !mynel) {
 		kfree(mysids);
 		goto out;
@@ -2806,6 +2859,7 @@ int security_genfs_sid(struct selinux_state *state,
 		       u16 orig_sclass,
 		       u32 *sid)
 {
+	struct selinux_policy *policy;
 	int retval;
 
 	if (!selinux_initialized(state)) {
@@ -2813,10 +2867,11 @@ int security_genfs_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-	retval = __security_genfs_sid(state->ss->policy,
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	retval = __security_genfs_sid(policy,
 				fstype, path, orig_sclass, sid);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return retval;
 }
 
@@ -2836,6 +2891,7 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
  */
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
@@ -2849,10 +2905,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2871,7 +2927,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		}
 		sbsec->sid = c->sid[0];
 	} else {
-		rc = __security_genfs_sid(state->ss->policy, fstype, "/",
+		rc = __security_genfs_sid(policy, fstype, "/",
 					SECCLASS_DIR, &sbsec->sid);
 		if (rc) {
 			sbsec->behavior = SECURITY_FS_USE_NONE;
@@ -2882,7 +2938,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2949,23 +3005,22 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 		return -EINVAL;
 
 	/*
-	 * NOTE: We do not need to take the policy read-lock
+	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
 
+	oldpolicy = rcu_dereference_check(state->policy, 1);
+
 	/* Consistency check on number of booleans, should never fail */
-	if (WARN_ON(len != state->ss->policy->policydb.p_bools.nprim))
+	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
 		return -EINVAL;
 
-	newpolicy = kmemdup(state->ss->policy, sizeof(*newpolicy),
-			GFP_KERNEL);
+	newpolicy = kmemdup(oldpolicy, sizeof(*newpolicy), GFP_KERNEL);
 	if (!newpolicy)
 		return -ENOMEM;
 
-	oldpolicy = state->ss->policy;
-
 	/*
 	 * Deep copy only the parts of the policydb that might be
 	 * modified as a result of changing booleans.
@@ -2997,20 +3052,20 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	/* Re-evaluate the conditional rules in the copy */
 	evaluate_cond_nodes(&newpolicy->policydb);
 
+	/* Set latest granting seqno for new policy */
+	newpolicy->latest_granting = oldpolicy->latest_granting + 1;
+	seqno = newpolicy->latest_granting;
+
 	/* Install the new policy */
-	write_lock_irq(&state->ss->policy_rwlock);
-	state->ss->policy = newpolicy;
-	seqno = ++state->ss->latest_granting;
-	write_unlock_irq(&state->ss->policy_rwlock);
+	rcu_assign_pointer(state->policy, newpolicy);
 
 	/*
 	 * Free the conditional portions of the old policydb
-	 * that were copied for the new policy.
+	 * that were copied for the new policy, and the oldpolicy
+	 * structure itself but not what it references.
 	 */
-	cond_policydb_destroy_dup(&oldpolicy->policydb);
-
-	/* Free the old policy structure but not what it references. */
-	kfree(oldpolicy);
+	synchronize_rcu();
+	selinux_policy_cond_free(oldpolicy);
 
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
@@ -3020,6 +3075,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 int security_get_bool_value(struct selinux_state *state,
 			    u32 index)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	int rc;
 	u32 len;
@@ -3027,9 +3083,9 @@ int security_get_bool_value(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
 
 	rc = -EFAULT;
 	len = policydb->p_bools.nprim;
@@ -3038,29 +3094,28 @@ int security_get_bool_value(struct selinux_state *state,
 
 	rc = policydb->bool_val_to_struct[index]->state;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
-static int security_preserve_bools(struct selinux_state *state,
-				   struct policydb *policydb)
+static int security_preserve_bools(struct selinux_policy *oldpolicy,
+				struct selinux_policy *newpolicy)
 {
 	int rc, *bvalues = NULL;
 	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
 	u32 i, nbools = 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = security_get_bools(state->ss->policy, &nbools, &bnames, &bvalues);
-	read_unlock(&state->ss->policy_rwlock);
+	rc = security_get_bools(oldpolicy, &nbools, &bnames, &bvalues);
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
-		booldatum = symtab_search(&policydb->p_bools, bnames[i]);
+		booldatum = symtab_search(&newpolicy->policydb.p_bools,
+					bnames[i]);
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
-	evaluate_cond_nodes(policydb);
+	evaluate_cond_nodes(&newpolicy->policydb);
 
 out:
 	if (bnames) {
@@ -3079,6 +3134,7 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *context1;
@@ -3096,10 +3152,10 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	context_init(&newcon);
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (!policydb->mls_enabled) {
 		*new_sid = sid;
@@ -3131,7 +3187,8 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(policydb, &newcon)) {
-		rc = convert_context_handle_invalid_context(state, &newcon);
+		rc = convert_context_handle_invalid_context(state, policydb,
+							&newcon);
 		if (rc) {
 			if (!context_struct_to_string(policydb, &newcon, &s,
 						      &len)) {
@@ -3152,7 +3209,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	}
 	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcon);
 out:
 	return rc;
@@ -3183,6 +3240,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
@@ -3209,10 +3267,10 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	/*
 	 * We don't need to check initialized here since the only way both
@@ -3249,7 +3307,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	 * expressive */
 	*peer_sid = xfrm_sid;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3353,27 +3411,31 @@ int security_get_permissions(struct selinux_policy *policy,
 
 int security_get_reject_unknown(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	int value;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	value = state->ss->policy->policydb.reject_unknown;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	value = policy->policydb.reject_unknown;
+	rcu_read_unlock();
 	return value;
 }
 
 int security_get_allow_unknown(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	int value;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	value = state->ss->policy->policydb.allow_unknown;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	value = policy->policydb.allow_unknown;
+	rcu_read_unlock();
 	return value;
 }
 
@@ -3390,14 +3452,16 @@ int security_get_allow_unknown(struct selinux_state *state)
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap)
 {
+	struct selinux_policy *policy;
 	int rc;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = ebitmap_get_bit(&state->ss->policy->policydb.policycaps, req_cap);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	rc = ebitmap_get_bit(&policy->policydb.policycaps, req_cap);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -3420,6 +3484,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct selinux_state *state = &selinux_state;
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
@@ -3463,11 +3528,11 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	context_init(&tmprule->au_ctxt);
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
 
-	tmprule->au_seqno = state->ss->latest_granting;
+	tmprule->au_seqno = policy->latest_granting;
 
 	switch (field) {
 	case AUDIT_SUBJ_USER:
@@ -3506,7 +3571,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	}
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc) {
 		selinux_audit_rule_free(tmprule);
@@ -3546,6 +3611,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
+	struct selinux_policy *policy;
 	struct context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
@@ -3559,14 +3625,16 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+
+	policy = rcu_dereference(state->policy);
 
-	if (rule->au_seqno < state->ss->latest_granting) {
+	if (rule->au_seqno < policy->latest_granting) {
 		match = -ESTALE;
 		goto out;
 	}
 
-	ctxt = sidtab_search(state->ss->policy->sidtab, sid);
+	ctxt = sidtab_search(policy->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3650,7 +3718,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return match;
 }
 
@@ -3728,6 +3796,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
@@ -3739,10 +3808,10 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
@@ -3778,12 +3847,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	} else
 		*sid = SECSID_NULL;
 
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return 0;
 out_free:
 	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3800,6 +3869,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 int security_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	int rc;
 	struct context *ctx;
@@ -3807,12 +3877,12 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	policydb = &policy->policydb;
 
 	rc = -ENOENT;
-	ctx = sidtab_search(state->ss->policy->sidtab, sid);
+	ctx = sidtab_search(policy->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
@@ -3827,7 +3897,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
@@ -3841,6 +3911,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
+	struct selinux_policy *policy;
 	int rc;
 	struct policy_file fp;
 
@@ -3856,9 +3927,10 @@ int security_read_policy(struct selinux_state *state,
 	fp.data = *data;
 	fp.len = *len;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = policydb_write(&state->ss->policy->policydb, &fp);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	rc = policydb_write(&policy->policydb, &fp);
+	rcu_read_unlock();
 
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 06931e34cb24..9555ad074303 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -26,12 +26,7 @@ struct selinux_policy {
 	struct sidtab *sidtab;
 	struct policydb policydb;
 	struct selinux_map map;
-};
-
-struct selinux_ss {
-	rwlock_t policy_rwlock;
 	u32 latest_granting;
-	struct selinux_policy *policy;
 } __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
-- 
2.25.1

