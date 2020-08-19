Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F5C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E91A206FA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHSI6m convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:58:42 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:9934 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgHSI6g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 04:58:36 -0400
Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        <paul@paul-moore.com>, "Paul E. McKenney" <paulmck@kernel.org>
CC:     <omosnace@redhat.com>, <selinux@vger.kernel.org>
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
Date:   Wed, 19 Aug 2020 10:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=RpNjiQI2AAAA:8 a=pGLkceISAAAA:8 a=c5mL6sUh8Ydjx7kqqyIA:9 a=jpIH26JlB8aEU1M81S3jpgcb7nU=:19 a=sT9HO2F_TqqIS-l-:21 a=tdzvYGQUfG5Hw_iW:21 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
From: Peter Enderborg <peter.enderborg@sony.com>
Date: Wed, 19 Aug 2020 10:20:28 +0200
Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans

This patch adds call_rcu that moves sycronize out
out call path. In the callback we can no call
cond_resched so they have to be remvoed.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/policydb.c |  6 -----
 security/selinux/ss/services.c | 43 ++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9fccf417006b..bcf49da4d7b2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -341,7 +341,6 @@ static int filenametr_destroy(void *key, void *datum, void *p)
                kfree(d);
                d = next;
        } while (unlikely(d));
-       cond_resched();
        return 0;
 }
 
@@ -353,7 +352,6 @@ static int range_tr_destroy(void *key, void *datum, void *p)
        ebitmap_destroy(&rt->level[0].cat);
        ebitmap_destroy(&rt->level[1].cat);
        kfree(datum);
-       cond_resched();
        return 0;
 }
 
@@ -791,7 +789,6 @@ void policydb_destroy(struct policydb *p)
        struct role_allow *ra, *lra = NULL;
 
        for (i = 0; i < SYM_NUM; i++) {
-               cond_resched();
                hashtab_map(&p->symtab[i].table, destroy_f[i], NULL);
                hashtab_destroy(&p->symtab[i].table);
        }
@@ -807,7 +804,6 @@ void policydb_destroy(struct policydb *p)
        avtab_destroy(&p->te_avtab);
 
        for (i = 0; i < OCON_NUM; i++) {
-               cond_resched();
                c = p->ocontexts[i];
                while (c) {
                        ctmp = c;
@@ -819,7 +815,6 @@ void policydb_destroy(struct policydb *p)
 
        g = p->genfs;
        while (g) {
-               cond_resched();
                kfree(g->fstype);
                c = g->head;
                while (c) {
@@ -839,7 +834,6 @@ void policydb_destroy(struct policydb *p)
        hashtab_destroy(&p->role_tr);
 
        for (ra = p->role_allow; ra; ra = ra->next) {
-               cond_resched();
                kfree(lra);
                lra = ra;
        }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ba9347517e5b..11eff3a98ef8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2184,11 +2184,29 @@ static void selinux_notify_policy_change(struct selinux_state *state,
        selinux_xfrm_notify_policyload();
 }
 
+struct deprecated_policy {
+       struct selinux_policy *policy;
+       int partial;
+       struct rcu_head rcu;
+};
+
+void policy_reclaim(struct rcu_head *rp)
+{
+       struct deprecated_policy *dep = container_of(rp, struct dep_policy, rcu);
+
+       if (dep->partial)
+               selinux_policy_cond_free(dep->policy);
+       else
+               selinux_policy_free(dep->policy);
+       kfree(dep);
+}
+
 void selinux_policy_commit(struct selinux_state *state,
                        struct selinux_policy *newpolicy)
 {
        struct selinux_policy *oldpolicy;
        u32 seqno;
+       struct deprecated_policy *dep;
 
        /*
         * NOTE: We do not need to take the rcu read lock
@@ -2231,8 +2249,16 @@ void selinux_policy_commit(struct selinux_state *state,
        }
 
        /* Free the old policy */
-       synchronize_rcu();
-       selinux_policy_free(oldpolicy);
+       /* if cant alloc we need to it the slow way */
+       dep  = kzalloc(sizeof(struct deprecated_policy), GFP_KERNEL);
+       if (dep) {
+               dep->policy = oldpolicy;
+               dep->partial = 0;
+               call_rcu(&dep->rcu, policy_reclaim);
+       } else {
+               synchronize_rcu();
+               selinux_policy_free(oldpolicy);
+       }
 
        /* Notify others of the policy change */
        selinux_notify_policy_change(state, seqno);
@@ -2956,6 +2982,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
        struct selinux_policy *newpolicy, *oldpolicy;
        int rc;
        u32 i, seqno = 0;
+       struct deprecated_policy *dep;
 
        if (!selinux_initialized(state))
                return -EINVAL;
@@ -3020,8 +3047,16 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
         * that were copied for the new policy, and the oldpolicy
         * structure itself but not what it references.
         */
-       synchronize_rcu();
-       selinux_policy_cond_free(oldpolicy);
+       /* if we can not alloc do it the slow way */
+       dep  = kzalloc(sizeof(struct deprecated_policy), GFP_KERNEL);
+       if (dep) {
+               dep->policy = oldpolicy;
+               dep->partial = 1;
+               call_rcu(&dep->rcu, policy_reclaim);
+       } else {
+               synchronize_rcu();
+               selinux_policy_cond_free(oldpolicy);
+       }
 
        /* Notify others of the policy change */
        selinux_notify_policy_change(state, seqno);
-- 
2.17.1

23059638@seldlx10744:/mnt/lb/nfs/kernel/moore/selinux$



On 8/19/20 12:17 AM, Stephen Smalley wrote:
> Convert the policy read-write lock to RCU.  This is significantly
> simplified by the earlier work to encapsulate the policy data
> structures and refactor the policy load and boolean setting logic.
> Move the latest_granting sequence number into the selinux_policy
> structure so that it can be updated atomically with the policy.
> Since the removal of the policy rwlock and this move of
> latest_granting reduces the selinux_ss structure to nothing more than
> a wrapper around the selinux_policy pointer, get rid of the extra
> layer of indirection.
>
> At present this change merely passes a hardcoded 1 to
> rcu_dereference_check() in the cases where we know we do not need to
> take rcu_read_lock(), with the preceding comment explaining why.
> Alternatively we could pass fsi->mutex down from selinuxfs and
> apply a lockdep check on it instead.
>
> This change does not specifically do anything special with respect
> to the sidtab live convert; I am unclear as to whether it is safe
> as a result.  Comments welcome.
>
> Based in part on earlier attempts to convert the policy rwlock
> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_selinux_6e2f9128-2De191-2Debb3-2D0e87-2D74bfccb0767f-40tycho.nsa.gov_&d=DwIDAg&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=_kM-X4solVxqaxB8a9pa3-yQIHOpIAWFGk3hl2dC4MM&s=h9lpEA-9HTA9-cthBzr1fCMSAEsPTF0_ZIGMOgnSJOU&e= 
> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_selinux_20180530141104.28569-2D1-2Dpeter.enderborg-40sony.com_&d=DwIDAg&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=_kM-X4solVxqaxB8a9pa3-yQIHOpIAWFGk3hl2dC4MM&s=BUPrJpavIz18sxwineNiV0T57bIXVQlhFTwl2f7CfR8&e= 
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches to synchronize_rcu() and moves latest_granting into selinux_policy,
> removing the need for a separate selinux_ss struct altogether.  Open questions
> remain about what to pass to rcu_dereference_check() and whether sidtab live
> convert is safe after this change.
>
>  security/selinux/hooks.c            |   1 -
>  security/selinux/include/security.h |   5 +-
>  security/selinux/ss/services.c      | 436 ++++++++++++++++------------
>  security/selinux/ss/services.h      |   5 -
>  4 files changed, 256 insertions(+), 191 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ca901025802a..102292f96b0f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7232,7 +7232,6 @@ static __init int selinux_init(void)
>  	memset(&selinux_state, 0, sizeof(selinux_state));
>  	enforcing_set(&selinux_state, selinux_enforcing_boot);
>  	selinux_state.checkreqprot = selinux_checkreqprot_boot;
> -	selinux_ss_init(&selinux_state.ss);
>  	selinux_avc_init(&selinux_state.avc);
>  	mutex_init(&selinux_state.status_lock);
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index c68ed2beadff..1b6a67a66a7e 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -13,6 +13,7 @@
>  #include <linux/dcache.h>
>  #include <linux/magic.h>
>  #include <linux/types.h>
> +#include <linux/rcupdate.h>
>  #include <linux/refcount.h>
>  #include <linux/workqueue.h>
>  #include "flask.h"
> @@ -84,7 +85,6 @@ extern int selinux_enabled_boot;
>  #define POLICYDB_BOUNDS_MAXDEPTH	4
>  
>  struct selinux_avc;
> -struct selinux_ss;
>  struct selinux_policy;
>  
>  struct selinux_state {
> @@ -102,10 +102,9 @@ struct selinux_state {
>  	struct mutex status_lock;
>  
>  	struct selinux_avc *avc;
> -	struct selinux_ss *ss;
> +	struct selinux_policy *policy __rcu;
>  } __randomize_layout;
>  
> -void selinux_ss_init(struct selinux_ss **ss);
>  void selinux_avc_init(struct selinux_avc **avc);
>  
>  extern struct selinux_state selinux_state;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f6f78c65f53f..ba9347517e5b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -66,14 +66,6 @@
>  #include "audit.h"
>  #include "policycap_names.h"
>  
> -static struct selinux_ss selinux_ss;
> -
> -void selinux_ss_init(struct selinux_ss **ss)
> -{
> -	rwlock_init(&selinux_ss.policy_rwlock);
> -	*ss = &selinux_ss;
> -}
> -
>  /* Forward declaration. */
>  static int context_struct_to_string(struct policydb *policydb,
>  				    struct context *context,
> @@ -239,13 +231,15 @@ static void map_decision(struct selinux_map *map,
>  int security_mls_enabled(struct selinux_state *state)
>  {
>  	int mls_enabled;
> +	struct selinux_policy *policy;
>  
>  	if (!selinux_initialized(state))
>  		return 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	mls_enabled = state->ss->policy->policydb.mls_enabled;
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	mls_enabled = policy->policydb.mls_enabled;
> +	rcu_read_unlock();
>  	return mls_enabled;
>  }
>  
> @@ -722,8 +716,9 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
>  					   struct sidtab_entry *tentry,
>  					   u16 tclass)
>  {
> -	struct policydb *p = &state->ss->policy->policydb;
> -	struct sidtab *sidtab = state->ss->policy->sidtab;
> +	struct selinux_policy *policy = rcu_dereference(state->policy);
> +	struct policydb *p = &policy->policydb;
> +	struct sidtab *sidtab = policy->sidtab;
>  	char *o = NULL, *n = NULL, *t = NULL;
>  	u32 olen, nlen, tlen;
>  
> @@ -751,6 +746,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>  					  u32 oldsid, u32 newsid, u32 tasksid,
>  					  u16 orig_tclass, bool user)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct sidtab_entry *oentry;
> @@ -765,13 +761,14 @@ static int security_compute_validatetrans(struct selinux_state *state,
>  	if (!selinux_initialized(state))
>  		return 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
>  
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	if (!user)
> -		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
> +		tclass = unmap_class(&policy->map, orig_tclass);
>  	else
>  		tclass = orig_tclass;
>  
> @@ -824,7 +821,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>  	}
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -856,6 +853,7 @@ int security_validate_transition(struct selinux_state *state,
>  int security_bounded_transition(struct selinux_state *state,
>  				u32 old_sid, u32 new_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct sidtab_entry *old_entry, *new_entry;
> @@ -866,10 +864,10 @@ int security_bounded_transition(struct selinux_state *state,
>  	if (!selinux_initialized(state))
>  		return 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	rc = -EINVAL;
>  	old_entry = sidtab_search_entry(sidtab, old_sid);
> @@ -930,17 +928,20 @@ int security_bounded_transition(struct selinux_state *state,
>  		kfree(old_name);
>  	}
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  
>  	return rc;
>  }
>  
> -static void avd_init(struct selinux_state *state, struct av_decision *avd)
> +static void avd_init(struct selinux_policy *policy, struct av_decision *avd)
>  {
>  	avd->allowed = 0;
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
> -	avd->seqno = state->ss->latest_granting;
> +	if (policy)
> +		avd->seqno = policy->latest_granting;
> +	else
> +		avd->seqno = 0;
>  	avd->flags = 0;
>  }
>  
> @@ -1005,6 +1006,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  				      u8 driver,
>  				      struct extended_perms_decision *xpermd)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	u16 tclass;
> @@ -1021,12 +1023,13 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
>  	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
>  
> -	read_lock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
>  	if (!selinux_initialized(state))
>  		goto allow;
>  
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	scontext = sidtab_search(sidtab, ssid);
>  	if (!scontext) {
> @@ -1042,7 +1045,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  		goto out;
>  	}
>  
> -	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
> +	tclass = unmap_class(&policy->map, orig_tclass);
>  	if (unlikely(orig_tclass && !tclass)) {
>  		if (policydb->allow_unknown)
>  			goto allow;
> @@ -1074,7 +1077,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  		}
>  	}
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return;
>  allow:
>  	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
> @@ -1099,19 +1102,21 @@ void security_compute_av(struct selinux_state *state,
>  			 struct av_decision *avd,
>  			 struct extended_perms *xperms)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	u16 tclass;
>  	struct context *scontext = NULL, *tcontext = NULL;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	avd_init(state, avd);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	avd_init(policy, avd);
>  	xperms->len = 0;
>  	if (!selinux_initialized(state))
>  		goto allow;
>  
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	scontext = sidtab_search(sidtab, ssid);
>  	if (!scontext) {
> @@ -1131,7 +1136,7 @@ void security_compute_av(struct selinux_state *state,
>  		goto out;
>  	}
>  
> -	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
> +	tclass = unmap_class(&policy->map, orig_tclass);
>  	if (unlikely(orig_tclass && !tclass)) {
>  		if (policydb->allow_unknown)
>  			goto allow;
> @@ -1139,10 +1144,10 @@ void security_compute_av(struct selinux_state *state,
>  	}
>  	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
>  				  xperms);
> -	map_decision(&state->ss->policy->map, orig_tclass, avd,
> +	map_decision(&policy->map, orig_tclass, avd,
>  		     policydb->allow_unknown);
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> @@ -1155,17 +1160,19 @@ void security_compute_av_user(struct selinux_state *state,
>  			      u16 tclass,
>  			      struct av_decision *avd)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct context *scontext = NULL, *tcontext = NULL;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	avd_init(state, avd);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	avd_init(policy, avd);
>  	if (!selinux_initialized(state))
>  		goto allow;
>  
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	scontext = sidtab_search(sidtab, ssid);
>  	if (!scontext) {
> @@ -1194,7 +1201,7 @@ void security_compute_av_user(struct selinux_state *state,
>  	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
>  				  NULL);
>   out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> @@ -1279,6 +1286,7 @@ static int sidtab_entry_to_string(struct policydb *p,
>  
>  int security_sidtab_hash_stats(struct selinux_state *state, char *page)
>  {
> +	struct selinux_policy *policy;
>  	int rc;
>  
>  	if (!selinux_initialized(state)) {
> @@ -1287,9 +1295,10 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
>  		return -EINVAL;
>  	}
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	rc = sidtab_hash_stats(state->ss->policy->sidtab, page);
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	rc = sidtab_hash_stats(policy->sidtab, page);
> +	rcu_read_unlock();
>  
>  	return rc;
>  }
> @@ -1306,6 +1315,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>  					u32 *scontext_len, int force,
>  					int only_invalid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct sidtab_entry *entry;
> @@ -1335,9 +1345,10 @@ static int security_sid_to_context_core(struct selinux_state *state,
>  		       "load_policy on unknown SID %d\n", __func__, sid);
>  		return -EINVAL;
>  	}
> -	read_lock(&state->ss->policy_rwlock);
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	if (force)
>  		entry = sidtab_search_entry_force(sidtab, sid);
> @@ -1356,7 +1367,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>  				    scontext_len);
>  
>  out_unlock:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  
>  }
> @@ -1491,6 +1502,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
>  					u32 *sid, u32 def_sid, gfp_t gfp_flags,
>  					int force)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	char *scontext2, *str = NULL;
> @@ -1529,9 +1541,10 @@ static int security_context_to_sid_core(struct selinux_state *state,
>  		if (!str)
>  			goto out;
>  	}
> -	read_lock(&state->ss->policy_rwlock);
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  	rc = string_to_context_struct(policydb, sidtab, scontext2,
>  				      &context, def_sid);
>  	if (rc == -EINVAL && force) {
> @@ -1543,7 +1556,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
>  	rc = sidtab_context_to_sid(sidtab, &context, sid);
>  	context_destroy(&context);
>  out_unlock:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  out:
>  	kfree(scontext2);
>  	kfree(str);
> @@ -1618,8 +1631,9 @@ static int compute_sid_handle_invalid_context(
>  	u16 tclass,
>  	struct context *newcontext)
>  {
> -	struct policydb *policydb = &state->ss->policy->policydb;
> -	struct sidtab *sidtab = state->ss->policy->sidtab;
> +	struct selinux_policy *policy = rcu_dereference(state->policy);
> +	struct policydb *policydb = &policy->policydb;
> +	struct sidtab *sidtab = policy->sidtab;
>  	char *s = NULL, *t = NULL, *n = NULL;
>  	u32 slen, tlen, nlen;
>  	struct audit_buffer *ab;
> @@ -1686,6 +1700,7 @@ static int security_compute_sid(struct selinux_state *state,
>  				u32 *out_sid,
>  				bool kern)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct class_datum *cladatum = NULL;
> @@ -1712,19 +1727,21 @@ static int security_compute_sid(struct selinux_state *state,
>  
>  	context_init(&newcontext);
>  
> -	read_lock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +
> +	policy = rcu_dereference(state->policy);
>  
>  	if (kern) {
> -		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
> +		tclass = unmap_class(&policy->map, orig_tclass);
>  		sock = security_is_socket_class(orig_tclass);
>  	} else {
>  		tclass = orig_tclass;
> -		sock = security_is_socket_class(map_class(&state->ss->policy->map,
> +		sock = security_is_socket_class(map_class(&policy->map,
>  							  tclass));
>  	}
>  
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	sentry = sidtab_search_entry(sidtab, ssid);
>  	if (!sentry) {
> @@ -1852,7 +1869,7 @@ static int security_compute_sid(struct selinux_state *state,
>  	/* Obtain the sid for the context. */
>  	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
>  out_unlock:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	context_destroy(&newcontext);
>  out:
>  	return rc;
> @@ -1941,7 +1958,8 @@ static inline int convert_context_handle_invalid_context(
>  	struct selinux_state *state,
>  	struct context *context)
>  {
> -	struct policydb *policydb = &state->ss->policy->policydb;
> +	struct selinux_policy *policy = rcu_dereference(state->policy);
> +	struct policydb *policydb = &policy->policydb;
>  	char *s;
>  	u32 len;
>  
> @@ -2094,13 +2112,16 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>  
>  static void security_load_policycaps(struct selinux_state *state)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *p;
>  	unsigned int i;
>  	struct ebitmap_node *node;
>  
> -	read_lock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
>  
> -	p = &state->ss->policy->policydb;
> +	policy = rcu_dereference(state->policy);
> +
> +	p = &policy->policydb;
>  
>  	for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
>  		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
> @@ -2116,7 +2137,7 @@ static void security_load_policycaps(struct selinux_state *state)
>  				i);
>  	}
>  
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  }
>  
>  static int security_preserve_bools(struct selinux_state *state,
> @@ -2134,10 +2155,21 @@ static void selinux_policy_free(struct selinux_policy *policy)
>  	kfree(policy);
>  }
>  
> +static void selinux_policy_cond_free(struct selinux_policy *policy)
> +{
> +	cond_policydb_destroy_dup(&policy->policydb);
> +	kfree(policy);
> +}
> +
>  void selinux_policy_cancel(struct selinux_state *state,
>  			struct selinux_policy *policy)
>  {
> -	sidtab_cancel_convert(state->ss->policy->sidtab);
> +	struct selinux_policy *oldpolicy;
> +
> +	rcu_read_lock();
> +	oldpolicy = rcu_dereference(state->policy);
> +	sidtab_cancel_convert(oldpolicy->sidtab);
> +	rcu_read_unlock();
>  	selinux_policy_free(policy);
>  }
>  
> @@ -2159,14 +2191,14 @@ void selinux_policy_commit(struct selinux_state *state,
>  	u32 seqno;
>  
>  	/*
> -	 * NOTE: We do not need to take the policy read-lock
> +	 * NOTE: We do not need to take the rcu read lock
>  	 * around the code below because other policy-modifying
>  	 * operations are already excluded by selinuxfs via
>  	 * fsi->mutex.
>  	 */
> +	oldpolicy = rcu_dereference_check(state->policy, 1);
>  
>  	/* If switching between different policy types, log MLS status */
> -	oldpolicy = state->ss->policy;
>  	if (oldpolicy) {
>  		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
>  			pr_info("SELinux: Disabling MLS support...\n");
> @@ -2174,11 +2206,16 @@ void selinux_policy_commit(struct selinux_state *state,
>  			pr_info("SELinux: Enabling MLS support...\n");
>  	}
>  
> +
> +	/* Set latest granting seqno for new policy. */
> +	if (oldpolicy)
> +		newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> +	else
> +		newpolicy->latest_granting = 1;
> +	seqno = newpolicy->latest_granting;
> +
>  	/* Install the new policy. */
> -	write_lock_irq(&state->ss->policy_rwlock);
> -	state->ss->policy = newpolicy;
> -	seqno = ++state->ss->latest_granting;
> -	write_unlock_irq(&state->ss->policy_rwlock);
> +	rcu_assign_pointer(state->policy, newpolicy);
>  
>  	/* Load the policycaps from the new policy */
>  	security_load_policycaps(state);
> @@ -2194,6 +2231,7 @@ void selinux_policy_commit(struct selinux_state *state,
>  	}
>  
>  	/* Free the old policy */
> +	synchronize_rcu();
>  	selinux_policy_free(oldpolicy);
>  
>  	/* Notify others of the policy change */
> @@ -2213,7 +2251,7 @@ void selinux_policy_commit(struct selinux_state *state,
>  int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  			struct selinux_policy **newpolicyp)
>  {
> -	struct selinux_policy *newpolicy;
> +	struct selinux_policy *newpolicy, *oldpolicy;
>  	struct sidtab_convert_params convert_params;
>  	struct convert_context_args args;
>  	int rc = 0;
> @@ -2261,20 +2299,22 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  	 * Convert the internal representations of contexts
>  	 * in the new SID table.
>  	 *
> -	 * NOTE: We do not need to take the policy read-lock
> +	 * NOTE: We do not need to take the rcu read lock
>  	 * around the code below because other policy-modifying
>  	 * operations are already excluded by selinuxfs via
>  	 * fsi->mutex.
>  	 */
> +	oldpolicy = rcu_dereference_check(state->policy, 1);
> +
>  	args.state = state;
> -	args.oldp = &state->ss->policy->policydb;
> +	args.oldp = &oldpolicy->policydb;
>  	args.newp = &newpolicy->policydb;
>  
>  	convert_params.func = convert_context;
>  	convert_params.args = &args;
>  	convert_params.target = newpolicy->sidtab;
>  
> -	rc = sidtab_convert(state->ss->policy->sidtab, &convert_params);
> +	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
>  	if (rc) {
>  		pr_err("SELinux:  unable to convert the internal"
>  			" representation of contexts in the new SID"
> @@ -2291,11 +2331,13 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  
>  size_t security_policydb_len(struct selinux_state *state)
>  {
> +	struct selinux_policy *policy;
>  	size_t len;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	len = state->ss->policy->policydb.len;
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	len = policy->policydb.len;
> +	rcu_read_unlock();
>  
>  	return len;
>  }
> @@ -2309,15 +2351,16 @@ size_t security_policydb_len(struct selinux_state *state)
>  int security_port_sid(struct selinux_state *state,
>  		      u8 protocol, u16 port, u32 *out_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	c = policydb->ocontexts[OCON_PORT];
>  	while (c) {
> @@ -2341,7 +2384,7 @@ int security_port_sid(struct selinux_state *state,
>  	}
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2354,15 +2397,16 @@ int security_port_sid(struct selinux_state *state,
>  int security_ib_pkey_sid(struct selinux_state *state,
>  			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	c = policydb->ocontexts[OCON_IBPKEY];
>  	while (c) {
> @@ -2387,7 +2431,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
>  		*out_sid = SECINITSID_UNLABELED;
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2400,15 +2444,16 @@ int security_ib_pkey_sid(struct selinux_state *state,
>  int security_ib_endport_sid(struct selinux_state *state,
>  			    const char *dev_name, u8 port_num, u32 *out_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	c = policydb->ocontexts[OCON_IBENDPORT];
>  	while (c) {
> @@ -2433,7 +2478,7 @@ int security_ib_endport_sid(struct selinux_state *state,
>  		*out_sid = SECINITSID_UNLABELED;
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2445,15 +2490,16 @@ int security_ib_endport_sid(struct selinux_state *state,
>  int security_netif_sid(struct selinux_state *state,
>  		       char *name, u32 *if_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	int rc = 0;
>  	struct ocontext *c;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	c = policydb->ocontexts[OCON_NETIF];
>  	while (c) {
> @@ -2478,7 +2524,7 @@ int security_netif_sid(struct selinux_state *state,
>  		*if_sid = SECINITSID_NETIF;
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2508,15 +2554,16 @@ int security_node_sid(struct selinux_state *state,
>  		      u32 addrlen,
>  		      u32 *out_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	int rc;
>  	struct ocontext *c;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	switch (domain) {
>  	case AF_INET: {
> @@ -2571,7 +2618,7 @@ int security_node_sid(struct selinux_state *state,
>  
>  	rc = 0;
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2597,6 +2644,7 @@ int security_get_user_sids(struct selinux_state *state,
>  			   u32 **sids,
>  			   u32 *nel)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct context *fromcon, usercon;
> @@ -2613,10 +2661,10 @@ int security_get_user_sids(struct selinux_state *state,
>  	if (!selinux_initialized(state))
>  		goto out;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	context_init(&usercon);
>  
> @@ -2667,7 +2715,7 @@ int security_get_user_sids(struct selinux_state *state,
>  	}
>  	rc = 0;
>  out_unlock:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	if (rc || !mynel) {
>  		kfree(mysids);
>  		goto out;
> @@ -2778,12 +2826,14 @@ int security_genfs_sid(struct selinux_state *state,
>  		       u16 orig_sclass,
>  		       u32 *sid)
>  {
> +	struct selinux_policy *policy;
>  	int retval;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	retval = __security_genfs_sid(state->ss->policy,
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	retval = __security_genfs_sid(policy,
>  				fstype, path, orig_sclass, sid);
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return retval;
>  }
>  
> @@ -2803,6 +2853,7 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
>   */
>  int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	int rc = 0;
> @@ -2810,10 +2861,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  	struct superblock_security_struct *sbsec = sb->s_security;
>  	const char *fstype = sb->s_type->name;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	c = policydb->ocontexts[OCON_FSUSE];
>  	while (c) {
> @@ -2832,7 +2883,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  		}
>  		sbsec->sid = c->sid[0];
>  	} else {
> -		rc = __security_genfs_sid(state->ss->policy, fstype, "/",
> +		rc = __security_genfs_sid(policy, fstype, "/",
>  					SECCLASS_DIR, &sbsec->sid);
>  		if (rc) {
>  			sbsec->behavior = SECURITY_FS_USE_NONE;
> @@ -2843,7 +2894,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  	}
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -2906,24 +2957,26 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>  	int rc;
>  	u32 i, seqno = 0;
>  
> +	if (!selinux_initialized(state))
> +		return -EINVAL;
> +
>  	/*
> -	 * NOTE: We do not need to take the policy read-lock
> +	 * NOTE: We do not need to take the rcu read lock
>  	 * around the code below because other policy-modifying
>  	 * operations are already excluded by selinuxfs via
>  	 * fsi->mutex.
>  	 */
>  
> +	oldpolicy = rcu_dereference_check(state->policy, 1);
> +
>  	/* Consistency check on number of booleans, should never fail */
> -	if (WARN_ON(len != state->ss->policy->policydb.p_bools.nprim))
> +	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
>  		return -EINVAL;
>  
> -	newpolicy = kmemdup(state->ss->policy, sizeof(*newpolicy),
> -			GFP_KERNEL);
> +	newpolicy = kmemdup(oldpolicy, sizeof(*newpolicy), GFP_KERNEL);
>  	if (!newpolicy)
>  		return -ENOMEM;
>  
> -	oldpolicy = state->ss->policy;
> -
>  	/*
>  	 * Deep copy only the parts of the policydb that might be
>  	 * modified as a result of changing booleans.
> @@ -2955,20 +3008,20 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>  	/* Re-evaluate the conditional rules in the copy */
>  	evaluate_cond_nodes(&newpolicy->policydb);
>  
> +	/* Set latest granting seqno for new policy */
> +	newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> +	seqno = newpolicy->latest_granting;
> +
>  	/* Install the new policy */
> -	write_lock_irq(&state->ss->policy_rwlock);
> -	state->ss->policy = newpolicy;
> -	seqno = ++state->ss->latest_granting;
> -	write_unlock_irq(&state->ss->policy_rwlock);
> +	rcu_assign_pointer(state->policy, newpolicy);
>  
>  	/*
>  	 * Free the conditional portions of the old policydb
> -	 * that were copied for the new policy.
> +	 * that were copied for the new policy, and the oldpolicy
> +	 * structure itself but not what it references.
>  	 */
> -	cond_policydb_destroy_dup(&oldpolicy->policydb);
> -
> -	/* Free the old policy structure but not what it references. */
> -	kfree(oldpolicy);
> +	synchronize_rcu();
> +	selinux_policy_cond_free(oldpolicy);
>  
>  	/* Notify others of the policy change */
>  	selinux_notify_policy_change(state, seqno);
> @@ -2978,13 +3031,14 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>  int security_get_bool_value(struct selinux_state *state,
>  			    u32 index)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	int rc;
>  	u32 len;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	rcu_read_lock();
> +	policy = state->policy;
> +	policydb = &policy->policydb;
>  
>  	rc = -EFAULT;
>  	len = policydb->p_bools.nprim;
> @@ -2993,21 +3047,23 @@ int security_get_bool_value(struct selinux_state *state,
>  
>  	rc = policydb->bool_val_to_struct[index]->state;
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
>  static int security_preserve_bools(struct selinux_state *state,
>  				   struct policydb *policydb)
>  {
> +	struct selinux_policy *policy;
>  	int rc, *bvalues = NULL;
>  	char **bnames = NULL;
>  	struct cond_bool_datum *booldatum;
>  	u32 i, nbools = 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	rc = security_get_bools(state->ss->policy, &nbools, &bnames, &bvalues);
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = state->policy;
> +	rc = security_get_bools(policy, &nbools, &bnames, &bvalues);
> +	rcu_read_unlock();
>  	if (rc)
>  		goto out;
>  	for (i = 0; i < nbools; i++) {
> @@ -3034,6 +3090,7 @@ static int security_preserve_bools(struct selinux_state *state,
>  int security_sid_mls_copy(struct selinux_state *state,
>  			  u32 sid, u32 mls_sid, u32 *new_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	struct context *context1;
> @@ -3051,10 +3108,10 @@ int security_sid_mls_copy(struct selinux_state *state,
>  
>  	context_init(&newcon);
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	if (!policydb->mls_enabled) {
>  		*new_sid = sid;
> @@ -3107,7 +3164,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>  	}
>  	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
>  out_unlock:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	context_destroy(&newcon);
>  out:
>  	return rc;
> @@ -3138,6 +3195,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	int rc;
> @@ -3161,10 +3219,10 @@ int security_net_peersid_resolve(struct selinux_state *state,
>  		return 0;
>  	}
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	/*
>  	 * We don't need to check initialized here since the only way both
> @@ -3201,7 +3259,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
>  	 * expressive */
>  	*peer_sid = xfrm_sid;
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -3305,21 +3363,25 @@ int security_get_permissions(struct selinux_policy *policy,
>  
>  int security_get_reject_unknown(struct selinux_state *state)
>  {
> +	struct selinux_policy *policy;
>  	int value;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	value = state->ss->policy->policydb.reject_unknown;
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	value = policy->policydb.reject_unknown;
> +	rcu_read_unlock();
>  	return value;
>  }
>  
>  int security_get_allow_unknown(struct selinux_state *state)
>  {
> +	struct selinux_policy *policy;
>  	int value;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	value = state->ss->policy->policydb.allow_unknown;
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	value = policy->policydb.allow_unknown;
> +	rcu_read_unlock();
>  	return value;
>  }
>  
> @@ -3336,11 +3398,13 @@ int security_get_allow_unknown(struct selinux_state *state)
>  int security_policycap_supported(struct selinux_state *state,
>  				 unsigned int req_cap)
>  {
> +	struct selinux_policy *policy;
>  	int rc;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	rc = ebitmap_get_bit(&state->ss->policy->policydb.policycaps, req_cap);
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	rc = ebitmap_get_bit(&policy->policydb.policycaps, req_cap);
> +	rcu_read_unlock();
>  
>  	return rc;
>  }
> @@ -3363,6 +3427,7 @@ void selinux_audit_rule_free(void *vrule)
>  int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  {
>  	struct selinux_state *state = &selinux_state;
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct selinux_audit_rule *tmprule;
>  	struct role_datum *roledatum;
> @@ -3406,11 +3471,11 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  
>  	context_init(&tmprule->au_ctxt);
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
>  
> -	tmprule->au_seqno = state->ss->latest_granting;
> +	tmprule->au_seqno = policy->latest_granting;
>  
>  	switch (field) {
>  	case AUDIT_SUBJ_USER:
> @@ -3449,7 +3514,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  	}
>  	rc = 0;
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  
>  	if (rc) {
>  		selinux_audit_rule_free(tmprule);
> @@ -3489,6 +3554,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
>  int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>  {
>  	struct selinux_state *state = &selinux_state;
> +	struct selinux_policy *policy;
>  	struct context *ctxt;
>  	struct mls_level *level;
>  	struct selinux_audit_rule *rule = vrule;
> @@ -3499,14 +3565,16 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>  		return -ENOENT;
>  	}
>  
> -	read_lock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +
> +	policy = rcu_dereference(state->policy);
>  
> -	if (rule->au_seqno < state->ss->latest_granting) {
> +	if (rule->au_seqno < policy->latest_granting) {
>  		match = -ESTALE;
>  		goto out;
>  	}
>  
> -	ctxt = sidtab_search(state->ss->policy->sidtab, sid);
> +	ctxt = sidtab_search(policy->sidtab, sid);
>  	if (unlikely(!ctxt)) {
>  		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
>  			  sid);
> @@ -3590,7 +3658,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>  	}
>  
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return match;
>  }
>  
> @@ -3668,6 +3736,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  				   struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	struct sidtab *sidtab;
>  	int rc;
> @@ -3679,10 +3748,10 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  		return 0;
>  	}
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> -	sidtab = state->ss->policy->sidtab;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
> +	sidtab = policy->sidtab;
>  
>  	if (secattr->flags & NETLBL_SECATTR_CACHE)
>  		*sid = *(u32 *)secattr->cache->data;
> @@ -3718,12 +3787,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  	} else
>  		*sid = SECSID_NULL;
>  
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return 0;
>  out_free:
>  	ebitmap_destroy(&ctx_new.range.level[0].cat);
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  
> @@ -3740,6 +3809,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  				   u32 sid, struct netlbl_lsm_secattr *secattr)
>  {
> +	struct selinux_policy *policy;
>  	struct policydb *policydb;
>  	int rc;
>  	struct context *ctx;
> @@ -3747,12 +3817,12 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  	if (!selinux_initialized(state))
>  		return 0;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	policydb = &policy->policydb;
>  
>  	rc = -ENOENT;
> -	ctx = sidtab_search(state->ss->policy->sidtab, sid);
> +	ctx = sidtab_search(policy->sidtab, sid);
>  	if (ctx == NULL)
>  		goto out;
>  
> @@ -3767,7 +3837,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  	mls_export_netlbl_lvl(policydb, ctx, secattr);
>  	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
>  out:
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_unlock();
>  	return rc;
>  }
>  #endif /* CONFIG_NETLABEL */
> @@ -3781,6 +3851,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  int security_read_policy(struct selinux_state *state,
>  			 void **data, size_t *len)
>  {
> +	struct selinux_policy *policy;
>  	int rc;
>  	struct policy_file fp;
>  
> @@ -3796,9 +3867,10 @@ int security_read_policy(struct selinux_state *state,
>  	fp.data = *data;
>  	fp.len = *len;
>  
> -	read_lock(&state->ss->policy_rwlock);
> -	rc = policydb_write(&state->ss->policy->policydb, &fp);
> -	read_unlock(&state->ss->policy_rwlock);
> +	rcu_read_lock();
> +	policy = rcu_dereference(state->policy);
> +	rc = policydb_write(&policy->policydb, &fp);
> +	rcu_read_unlock();
>  
>  	if (rc)
>  		return rc;
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index 06931e34cb24..9555ad074303 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -26,12 +26,7 @@ struct selinux_policy {
>  	struct sidtab *sidtab;
>  	struct policydb policydb;
>  	struct selinux_map map;
> -};
> -
> -struct selinux_ss {
> -	rwlock_t policy_rwlock;
>  	u32 latest_granting;
> -	struct selinux_policy *policy;
>  } __randomize_layout;
>  
>  void services_compute_xperms_drivers(struct extended_perms *xperms,


