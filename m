Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD331C43141
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 00:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8F20729
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 00:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ig+BTSnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKOAmx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:42:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42801 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOAmx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 19:42:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id z12so6584200lfj.9
        for <selinux@vger.kernel.org>; Thu, 14 Nov 2019 16:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyR7fypCkkegbwStfgl2DxgnpXUNbWLUv50ymf5NmxA=;
        b=Ig+BTSnrc8BajX5YihJ9/G48ac7IiGvS3UKkugVNNKTdWiNDNr1vphXlD12LVIZ/cj
         yR5Oo375PrZ+bMknvAsxAPWhie40J4Pm5eNR3moYFoZq/CM4z+fTVLBK8sIqGyC2uThw
         8MzLZKeMZ0mNsoOiz1lqtWbzCIoGMpBm8d7LpLWJWmgCvbMz0I0gx5+G8/ch79HibnaY
         41wUR7BESDEaQk+ZBh3LIguGW2lcXR8LXJhh1RrZMKQii40g+Q8rlwWyjn3BSsqSfX2+
         9qRRic/mAhoUzps0Lr9uuQjwpE8/ubvU/AKFeAKL6+fBFtnyipt9qhurfNuWcU1t4eDc
         OWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyR7fypCkkegbwStfgl2DxgnpXUNbWLUv50ymf5NmxA=;
        b=ilM/c2Pl56Edvsqu+xIlq0OaGQ3UVK5qVTvU/VXDmwYsWp9iF00Uu7K5SV2bzIkyar
         j4UpSF66nEIvqzFHL/OQZcavQB/ppK+M5MlgpRkvAcG4hl4ypteDuNEZ95PPYIr90SEw
         jR+5bxWWe65QgwgGDPo54OecowYFinlc3zb7XMe3O9a/Js4z3OIaTtPgRf3MK5VR48yU
         72jS7QPzdkvFhi+Na9GiftQvgsS+z/G05AD+svPBXHWgMm6exWsHWO+DeFR4mjmzCnzZ
         xw2/I4rQnjuFIa2BcoUw91IQIuNLtdu/yAmPNpnx8DIRAqlqj0uYwbv/1C+R+yGlvy85
         tlvg==
X-Gm-Message-State: APjAAAWblvk341wJ8HecRxH0ppf1sxvIIOpYGXgUh5THYhppIei9Obx3
        so6KqBIrLBNoDYt4x9fHzqu4cKn+iMY+xyZ0gzCA
X-Google-Smtp-Source: APXvYqxwfJn0N7PXuUev5TMm7qVLGppmmmmNhsAeb/Pd2eN1KlhXROWYAbtyHJ2O9vOsDJYdDPJ0l/i8/BbqR3RAGe8=
X-Received: by 2002:a19:8582:: with SMTP id h124mr9198738lfd.64.1573778569888;
 Thu, 14 Nov 2019 16:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20191111154004.1790-1-omosnace@redhat.com>
In-Reply-To: <20191111154004.1790-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Nov 2019 19:42:38 -0500
Message-ID: <CAHC9VhSqmHJqxK3xm9Jo+iu7eJao=L6CLpp4UQEGbUGM8puudw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: cache the SID -> context string translation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 11, 2019 at 10:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Translating a context struct to string can be quite slow, especially if
> the context has a lot of category bits set. This can cause quite
> noticeable performance impact in situations where the translation needs
> to be done repeatedly. A common example is a UNIX datagram socket with
> the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> when receiving log messages via datagram socket. This scenario can be
> reproduced with:
>
>     cat /dev/urandom | base64 | logger &
>     timeout 30s perf record -p $(pidof systemd-journald) -a -g
>     kill %1
>     perf report -g none --pretty raw | grep security_secid_to_secctx
>
> Before the caching introduced by this patch, computing the context
> string (security_secid_to_secctx() function) takes up ~65% of
> systemd-journald's CPU time (assuming a context with 1024 categories
> set and Fedora x86_64 release kernel configs). After this patch
> (assuming near-perfect cache hit ratio) this overhead is reduced to just
> ~2%.
>
> This patch addresses the issue by caching a certain number (compile-time
> configurable) of recently used context strings to speed up repeated
> translations of the same context, while using only a small amount of
> memory.
>
> The cache is integrated into the existing sidtab table by adding a field
> to each entry, which when not NULL contains an RCU-protected pointer to
> a cache entry containing the cached string. The cache entries are kept
> in a linked list sorted according to how recently they were used. On a
> cache miss when the cache is full, the least recently used entry is
> removed to make space for the new entry.
>
> The patch migrates security_sid_to_context_core() to use the cache (also
> a few other functions where it was possible without too much fuss, but
> these mostly use the translation for logging in case of error, which is
> rare).
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> Cc: Michal Sekletar <msekleta@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v4:
>  - use rcu_dereference_protected() instead of rcu_dereference_raw() in
>    sidtab_sid2str_put()
>  - fix typo in comment
>  - remove unnecessary rcu_head_init() call
>
> Changes in v3:
>  - add rcu@vger.kernel.org and Paul McKenney to Cc for review of the RCU
>    logic
>  - add __rcu annotation to the cache entry pointer (sidtab.c now passes
>    sparse checks with C=1)
>
> Changes in v2:
>  - skip sidtab_sid2str_put() when in non-task context to prevent
>    deadlock while avoiding the need to lock the spinlock with
>    irqsave/-restore (which is slower)
>
>  security/selinux/Kconfig       |  11 ++
>  security/selinux/ss/services.c | 138 +++++++++++++++----------
>  security/selinux/ss/sidtab.c   | 179 +++++++++++++++++++++++++++------
>  security/selinux/ss/sidtab.h   |  58 +++++++++--
>  4 files changed, 294 insertions(+), 92 deletions(-)

...

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..6d6ce1c43b49 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
>
>         sidtab_destroy_tree(s->roots[level], level);
>  }
> +
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +
> +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> +                       const char *str, u32 str_len)
> +{
> +       struct sidtab_str_cache *cache, *victim;
> +
> +       /* do not cache invalid contexts */
> +       if (entry->context.len)
> +               return;
> +
> +       /*
> +        * Skip the put operation when in non-task context to avoid the need
> +        * to disable interrupts while holding s->cache_lock.
> +        */
> +       if (!in_task())
> +               return;
> +
> +       spin_lock(&s->cache_lock);
> +
> +       cache = rcu_dereference_protected(entry->cache,
> +                                         lockdep_is_held(&s->cache_lock));
> +       if (cache) {
> +               /* entry in cache - just bump to the head of LRU list */
> +               list_move(&cache->lru_member, &s->cache_lru_list);
> +               goto out_unlock;
> +       }
> +
> +       cache = kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC);
> +       if (!cache)
> +               goto out_unlock;
> +
> +       if (s->cache_free_slots == 0) {
> +               /* pop a cache entry from the tail and free it */
> +               victim = container_of(s->cache_lru_list.prev,
> +                                     struct sidtab_str_cache, lru_member);
> +               list_del(&victim->lru_member);
> +               kfree_rcu(victim, rcu_member);

We could move the kfree_rcu() down to after we drop the spinlock,
right?  It's likely not a big deal, but since the whole point of this
patch is performance improvements it seems like it might be nice. ;)

> +               rcu_assign_pointer(victim->parent->cache, NULL);
> +       } else {
> +               s->cache_free_slots--;
> +       }
> +       cache->parent = entry;
> +       cache->len = str_len;
> +       memcpy(cache->str, str, str_len);
> +       list_add(&cache->lru_member, &s->cache_lru_list);
> +
> +       rcu_assign_pointer(entry->cache, cache);
> +
> +out_unlock:
> +       spin_unlock(&s->cache_lock);
> +}

-- 
paul moore
www.paul-moore.com
