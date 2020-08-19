Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E96C433E3
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ACE205CB
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHSMHs convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:07:48 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14980 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728255AbgHSMGl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:06:41 -0400
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
From:   peter enderborg <peter.enderborg@sony.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        <paul@paul-moore.com>, "Paul E. McKenney" <paulmck@kernel.org>
CC:     <omosnace@redhat.com>, <selinux@vger.kernel.org>
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
Message-ID: <fd75f375-3824-890d-5a32-5c67c397c427@sony.com>
Date:   Wed, 19 Aug 2020 14:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=5Pgu1cAVTJPJiwQehVoA:9 a=A1cHujcS6gITEIwJ:21 a=Uxebp9bEPrWG7vk3:21 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will might even compile! :-)

From f2d5b2a33c97fef896758becfe62e79aed96352d Mon Sep 17 00:00:00 2001
From: Peter Enderborg <peter.enderborg@sony.com>
Date: Wed, 19 Aug 2020 10:20:28 +0200
Subject: [PATCH] selinux: Use call_rcu for policydb and booleans

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
index ba9347517e5b..61e8296908df 100644
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
+       struct deprecated_policy *dep = container_of(rp, struct deprecated_policy, rcu);
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


