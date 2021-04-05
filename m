Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4BC433ED
	for <selinux@archiver.kernel.org>; Mon,  5 Apr 2021 22:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428EE613D2
	for <selinux@archiver.kernel.org>; Mon,  5 Apr 2021 22:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhDEWLM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhDEWLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Apr 2021 18:11:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F9C061756
        for <selinux@vger.kernel.org>; Mon,  5 Apr 2021 15:11:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qo10so8426334ejb.6
        for <selinux@vger.kernel.org>; Mon, 05 Apr 2021 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzQcpqaGe55ZnP/2qzPyOBv1Umfh2VRssqhxzIa9GYg=;
        b=r7fAXRYSP5bRq7oBp6n7/C3brHSGB6P9NQDlvooUcDmF1+R9TNb0aTMDQgLVilnu1T
         UwPDpH0pvjOGR6PesNZrHGABIMZkMd2a6+k9xc8mCVRnBINlp1jbMzSxGfJKbF3MjXKo
         W1Nu6fVZtwUbF/dpYQxvHaZTkrV/604k7UUlJoDTAs0khJEo5eSfPHTJsrfhxX6y/yj+
         J1kIgi7xHveRiBbi0MxJZo/2r3mu07sQ6RUywzg6AN/LLFGH65IS/JMaC7YBajtJwABS
         Vx3Bk5tFsTfvkx18fm5R8/FiveCqUiLxXbYRHnKJx/e1X3t6ImFXlYZ7Tr3GsgPPZkaw
         jH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzQcpqaGe55ZnP/2qzPyOBv1Umfh2VRssqhxzIa9GYg=;
        b=cDVjNrLHAoVBQkLTMfsg9PQO4rSGaylETsDtMq38rIHmWhX/ncvEKbjKvZ6XBncQd2
         Gw7hHOurDalopCeA3ykgBtZeTuF4JwV0pX21fdqg1QHGwUxfhzIjS/s0JmlDYMh+zV3l
         zyho1jgDaUUEPFxO5+wnDjcVckWxTRAUNdyMj/QmxCGh86m+h2PGc63fIlUklpOTqvBQ
         UHTGmack1WSPnwXcFo7XdGShy7SXIBQvlzuANGPW6hJbfElhrWojmK5DVSd+7ctAjjeb
         g6CQLfYbzTppoKbg49War1XkAS8xsMez3YpD5NY0hhCvEJhMmlDwrMaqZ460FRCbXXqV
         DXww==
X-Gm-Message-State: AOAM531ysYxfBEBRlPU9fd7V1s53392nLhif+9behlgciBF84V0rDcIG
        bIrEYwz6RmkrJ7pd54r7bY90dHytsfDx344inlVFBvUyMg==
X-Google-Smtp-Source: ABdhPJzQ7x/o9+8of7jvFHhBm0XexuljbmIaiPyyB5BZ8aqVmbmrZ04UzuUoMTOwj902L3Hq4YUgkvhCyD31iBi3WqA=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr29945126ejb.91.1617660663112;
 Mon, 05 Apr 2021 15:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210405091052.2296792-1-omosnace@redhat.com>
In-Reply-To: <20210405091052.2296792-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Apr 2021 18:10:52 -0400
Message-ID: <CAHC9VhSCSNvRE1JCjmYimifd4ip0Ar6mipouVqj2_zEGXij0Rg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race between old and new sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 5, 2021 at 5:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since commit 1b8b31a2e612 ("selinux: convert policy read-write lock to
> RCU"), there is a small window during policy load where the new policy
> pointer has already been installed, but some threads may still be
> holding the old policy pointer in their read-side RCU critical sections.
> This means that there may be conflicting attempts to add a new SID entry
> to both tables via sidtab_context_to_sid().
>
> See also (and the rest of the thread):
> https://lore.kernel.org/selinux/CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com/
>
> Fix this by installing the new policy pointer under the old sidtab's
> spinlock along with marking the old sidtab as "frozen". Then, if an
> attempt to add new entry to a "frozen" sidtab is detected, make
> sidtab_context_to_sid() return -ESTALE to indicate that a new policy
> has been installed and that the caller will have to abort the policy
> transaction and try again after re-taking the policy pointer (which is
> guaranteed to be a newer policy). This requires adding a retry-on-ESTALE
> logic to all callers of sidtab_context_to_sid(), but fortunately these
> are easy to determine and aren't that many.
>
> This seems to be the simplest solution for this problem, even if it
> looks somewhat ugly. Note that other places in the kernel (e.g.
> do_mknodat() in fs/namei.c) use similar stale-retry patterns, so I think
> it's reasonable.
>
> Fixes: 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 145 ++++++++++++++++++++++++++-------
>  security/selinux/ss/sidtab.c   |  21 +++++
>  security/selinux/ss/sidtab.h   |   4 +
>  3 files changed, 139 insertions(+), 31 deletions(-)

I'm glad to see the retry approach here, that looks like a good
solution to me.  I did have a few comments below.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 08ac1d01c743..50abcfcdf242 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1736,6 +1746,7 @@ static int security_compute_sid(struct selinux_state *state,
>                 goto out;
>         }
>
> +retry:
>         context_init(&newcontext);
>
>         rcu_read_lock();
> @@ -1880,6 +1891,11 @@ static int security_compute_sid(struct selinux_state *state,
>         }
>         /* Obtain the sid for the context. */
>         rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> +       if (rc == -ESTALE) {
> +               rcu_read_unlock();
> +               context_destroy(&newcontext);

Do we also need to reset 'cladatum' to NULL here as well?

> +               goto retry;
> +       }
>  out_unlock:
>         rcu_read_unlock();
>         context_destroy(&newcontext);

...

> @@ -2510,7 +2551,7 @@ int security_netif_sid(struct selinux_state *state,
>         struct selinux_policy *policy;
>         struct policydb *policydb;
>         struct sidtab *sidtab;
> -       int rc = 0;
> +       int rc;
>         struct ocontext *c;
>
>         if (!selinux_initialized(state)) {
> @@ -2518,6 +2559,8 @@ int security_netif_sid(struct selinux_state *state,
>                 return 0;
>         }
>
> +retry:
> +       rc = 0;
>         rcu_read_lock();
>         policy = rcu_dereference(state->policy);
>         policydb = &policy->policydb;
> @@ -2534,10 +2577,18 @@ int security_netif_sid(struct selinux_state *state,
>                 if (!c->sid[0] || !c->sid[1]) {
>                         rc = sidtab_context_to_sid(sidtab, &c->context[0],
>                                                    &c->sid[0]);
> +                       if (rc == -ESTALE) {
> +                               rcu_read_unlock();
> +                               goto retry;
> +                       }
>                         if (rc)
>                                 goto out;
>                         rc = sidtab_context_to_sid(sidtab, &c->context[1],
>                                                    &c->sid[1]);
> +                       if (rc == -ESTALE) {
> +                               rcu_read_unlock();
> +                               goto retry;
> +                       }

If the first sidtab_context_to_sid() ran successfully we are not going
to see -ESTALE here, correct?  Assuming yes, perhaps we can drop this
-ESTALE check with a comment about how a frozen sidtab will be caught
by the call above.

>                         if (rc)
>                                 goto out;
>                 }

...

> @@ -2676,18 +2732,20 @@ int security_get_user_sids(struct selinux_state *state,
>         struct sidtab *sidtab;
>         struct context *fromcon, usercon;
>         u32 *mysids = NULL, *mysids2, sid;
> -       u32 mynel = 0, maxnel = SIDS_NEL;
> +       u32 i, j, mynel, maxnel = SIDS_NEL;
>         struct user_datum *user;
>         struct role_datum *role;
>         struct ebitmap_node *rnode, *tnode;
> -       int rc = 0, i, j;
> +       int rc;
>
>         *sids = NULL;
>         *nel = 0;
>
>         if (!selinux_initialized(state))
> -               goto out;
> +               return 0;
>
> +retry:
> +       mynel = 0;
>         rcu_read_lock();
>         policy = rcu_dereference(state->policy);
>         policydb = &policy->policydb;
> @@ -2723,6 +2781,10 @@ int security_get_user_sids(struct selinux_state *state,
>                                 continue;
>
>                         rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
> +                       if (rc == -ESTALE) {
> +                               rcu_read_unlock();

Don't we need to free and reset 'mysids' here?  'mynel' and 'maxnel'
are probably less critical since the -ESTALE condition should happen
before they are ever modified, but a constant assignment is pretty
cheap so it may make sense to reset those as well.

> +                               goto retry;
> +                       }
>                         if (rc)
>                                 goto out_unlock;
>                         if (mynel < maxnel) {
> @@ -2745,14 +2807,14 @@ out_unlock:
>         rcu_read_unlock();
>         if (rc || !mynel) {
>                 kfree(mysids);
> -               goto out;
> +               return rc;
>         }
>
>         rc = -ENOMEM;
>         mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
>         if (!mysids2) {
>                 kfree(mysids);
> -               goto out;
> +               return rc;
>         }
>         for (i = 0, j = 0; i < mynel; i++) {
>                 struct av_decision dummy_avd;
> @@ -2765,12 +2827,10 @@ out_unlock:
>                         mysids2[j++] = mysids[i];
>                 cond_resched();
>         }
> -       rc = 0;
>         kfree(mysids);
>         *sids = mysids2;
>         *nel = j;
> -out:
> -       return rc;
> +       return 0;
>  }
>
>  /**

--
paul moore
www.paul-moore.com
