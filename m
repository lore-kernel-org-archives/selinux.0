Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E44C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEBA2075E
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFaHU2Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgHSMYW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHSMYV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:24:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86263C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:24:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x7so11114107qvi.5
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3UR0z9eOxNgL8UxQtsxkNqhJeMqu7+6eq9/BNN59u44=;
        b=PFaHU2Hxe7hLXIrPAYvosJTsQo39Qg4kH1nAL1jMBBg3KSHPpxfXK0LNvrtoLveiRn
         cU/A+LTfvVFMBgZFXIwZrmQXrN8E2vWQ+LhuJc3y3L+vjWozMltafAO26H5xRhu0SN7+
         WSZ30DVn9I9LPBFNGEGgb4TaLbjeiAKUvrGMTytGGmbzz3PxlZiiRz8zRxps2dfRSIzR
         AMEnHu+Rh9QESsRYGt2+FhMMhdwrOHFthD/FUVhPqUtEGzcB8BbIflsfiI+iv7gOnD2k
         eyqmqrcH8vb+H7PqthLQgOJAaIB6EnJ6TMjWrpb5KRaT0McFG99nGJ5RRvjnt6tPN6f+
         oYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3UR0z9eOxNgL8UxQtsxkNqhJeMqu7+6eq9/BNN59u44=;
        b=gJS19rlJ6o5WvvaK4VRI4+JQmOTSNpRJ/8oh8MHT99JZEeEbGNvo/8PF53pJs5JaFL
         Smtg+isAwjSAUV0y8OIFcsG1nT/oHS+m8z8fp2ytVyLFoLlcvtObtBoDrNVBETPTws/q
         OiRsCpqRX6CmUBbx4FOJFokw/rTSpCv+JcHzKHXeg679fKdnkyUWPxDMY7DaDVrF6ef4
         Yxqp7Kbc98sRgH3SZ5UnrDEQpnbv+M7chnquonSmhoVqW/fUiduSrQrHy5Lty58kaau7
         xTMJykA3YpewP3gABBm7yPIi4umeizlq8yHNZJtIy67F8Cq/+w4Y6mjT6YsVoGWQEchU
         41KA==
X-Gm-Message-State: AOAM533fGbMB2JRaP4g4kGcVtHNVWRgDvb4p3CuX3DLQA0rQSZZh/tlO
        eTfZUF9HqpwQdFwUG++CsFzA4qCDSiU=
X-Google-Smtp-Source: ABdhPJxjmHr7A6CHNhRAoKm2HWITASUX7tISpA3xLLcuKuOZutibhtt8lwB2SzGhY+7r3VKk0o5o4w==
X-Received: by 2002:a05:6214:1503:: with SMTP id e3mr24044097qvy.104.1597839859538;
        Wed, 19 Aug 2020 05:24:19 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id x24sm28063009qtj.8.2020.08.19.05.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:24:19 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     peter enderborg <peter.enderborg@sony.com>, paul@paul-moore.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
 <fd75f375-3824-890d-5a32-5c67c397c427@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <0eca193c-1006-911c-6777-d261056835a9@gmail.com>
Date:   Wed, 19 Aug 2020 08:24:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd75f375-3824-890d-5a32-5c67c397c427@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 8:06 AM, peter enderborg wrote:

> This will might even compile! :-)
>
>  From f2d5b2a33c97fef896758becfe62e79aed96352d Mon Sep 17 00:00:00 2001
> From: Peter Enderborg <peter.enderborg@sony.com>
> Date: Wed, 19 Aug 2020 10:20:28 +0200
> Subject: [PATCH] selinux: Use call_rcu for policydb and booleans
>
> This patch adds call_rcu that moves sycronize out
>
> out call path. In the callback we can no call
> cond_resched so they have to be remvoed.
I don't see why this is necessary.  My v1 patch used call_rcu() without 
needing these changes, but I didn't think using call_rcu() was justified 
and switched to synchronize_rcu().  What is lacking in my v2 patch that 
you are trying to fix?  If it is a performance concern around calling 
synchronize_rcu() during security_load_policy() and security_set_bool(), 
I don't think that is significant - those are infrequent operations.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>   security/selinux/ss/policydb.c |  6 -----
>   security/selinux/ss/services.c | 43 ++++++++++++++++++++++++++++++----
>   2 files changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 9fccf417006b..bcf49da4d7b2 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -341,7 +341,6 @@ static int filenametr_destroy(void *key, void *datum, void *p)
>                  kfree(d);
>                  d = next;
>          } while (unlikely(d));
> -       cond_resched();
>          return 0;
>   }
>   
> @@ -353,7 +352,6 @@ static int range_tr_destroy(void *key, void *datum, void *p)
>          ebitmap_destroy(&rt->level[0].cat);
>          ebitmap_destroy(&rt->level[1].cat);
>          kfree(datum);
> -       cond_resched();
>          return 0;
>   }
>   
> @@ -791,7 +789,6 @@ void policydb_destroy(struct policydb *p)
>          struct role_allow *ra, *lra = NULL;
>   
>          for (i = 0; i < SYM_NUM; i++) {
> -               cond_resched();
>                  hashtab_map(&p->symtab[i].table, destroy_f[i], NULL);
>                  hashtab_destroy(&p->symtab[i].table);
>          }
> @@ -807,7 +804,6 @@ void policydb_destroy(struct policydb *p)
>          avtab_destroy(&p->te_avtab);
>   
>          for (i = 0; i < OCON_NUM; i++) {
> -               cond_resched();
>                  c = p->ocontexts[i];
>                  while (c) {
>                          ctmp = c;
> @@ -819,7 +815,6 @@ void policydb_destroy(struct policydb *p)
>   
>          g = p->genfs;
>          while (g) {
> -               cond_resched();
>                  kfree(g->fstype);
>                  c = g->head;
>                  while (c) {
> @@ -839,7 +834,6 @@ void policydb_destroy(struct policydb *p)
>          hashtab_destroy(&p->role_tr);
>   
>          for (ra = p->role_allow; ra; ra = ra->next) {
> -               cond_resched();
>                  kfree(lra);
>                  lra = ra;
>          }
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ba9347517e5b..61e8296908df 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2184,11 +2184,29 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>          selinux_xfrm_notify_policyload();
>   }
>   
> +struct deprecated_policy {
> +       struct selinux_policy *policy;
> +       int partial;
> +       struct rcu_head rcu;
> +};
> +
> +void policy_reclaim(struct rcu_head *rp)
> +{
> +       struct deprecated_policy *dep = container_of(rp, struct deprecated_policy, rcu);
> +
> +       if (dep->partial)
> +               selinux_policy_cond_free(dep->policy);
> +       else
> +               selinux_policy_free(dep->policy);
> +       kfree(dep);
> +}
> +
>   void selinux_policy_commit(struct selinux_state *state,
>                          struct selinux_policy *newpolicy)
>   {
>          struct selinux_policy *oldpolicy;
>          u32 seqno;
> +       struct deprecated_policy *dep;
>   
>          /*
>           * NOTE: We do not need to take the rcu read lock
> @@ -2231,8 +2249,16 @@ void selinux_policy_commit(struct selinux_state *state,
>          }
>   
>          /* Free the old policy */
> -       synchronize_rcu();
> -       selinux_policy_free(oldpolicy);
> +       /* if cant alloc we need to it the slow way */
> +       dep  = kzalloc(sizeof(struct deprecated_policy), GFP_KERNEL);
> +       if (dep) {
> +               dep->policy = oldpolicy;
> +               dep->partial = 0;
> +               call_rcu(&dep->rcu, policy_reclaim);
> +       } else {
> +               synchronize_rcu();
> +               selinux_policy_free(oldpolicy);
> +       }
>   
>          /* Notify others of the policy change */
>          selinux_notify_policy_change(state, seqno);
> @@ -2956,6 +2982,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>          struct selinux_policy *newpolicy, *oldpolicy;
>          int rc;
>          u32 i, seqno = 0;
> +       struct deprecated_policy *dep;
>   
>          if (!selinux_initialized(state))
>                  return -EINVAL;
> @@ -3020,8 +3047,16 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>           * that were copied for the new policy, and the oldpolicy
>           * structure itself but not what it references.
>           */
> -       synchronize_rcu();
> -       selinux_policy_cond_free(oldpolicy);
> +       /* if we can not alloc do it the slow way */
> +       dep  = kzalloc(sizeof(struct deprecated_policy), GFP_KERNEL);
> +       if (dep) {
> +               dep->policy = oldpolicy;
> +               dep->partial = 1;
> +               call_rcu(&dep->rcu, policy_reclaim);
> +       } else {
> +               synchronize_rcu();
> +               selinux_policy_cond_free(oldpolicy);
> +       }
>   
>          /* Notify others of the policy change */
>          selinux_notify_policy_change(state, seqno);
