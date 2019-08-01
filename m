Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DBEC433FF
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61820449
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f8SkXyTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfHAAJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:09:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34816 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfHAAJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 20:09:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so67535292ljh.2
        for <selinux@vger.kernel.org>; Wed, 31 Jul 2019 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMzUyIZtzTtWoivtKustfpWxxwobrs5AKcMEq5wXZkU=;
        b=f8SkXyTBoCWESGW7TUcQYtrS3a5/Yx/tQVnSC8n271vGFCgNLf+Mmjb6/ENTbC7HYV
         Q9p3kmWCH+oTmJ9F+3l73tZSl+pba6NHnoMwG+7Oq1rxaskWof0URiTpw+bdi9YwmUvm
         A5FHZIu0ydBH9zzSNC06t/7pev5rIc90O3ulw5jh6ecNRQ0jwTn5Mw5ireZa1nihjZ3Y
         RDt4pmUea+PgAaukI1rlTXke2vkKkPwmRjik6t8Y92yu5tKsemm2zTpjcNYx8wr5mCx1
         B0czdRKMYpeXEszWU3VVuN0YorWuj+bP30jVFwxuP3RKjRoqiHBnfKJlcN+3fTaZGg0l
         31wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMzUyIZtzTtWoivtKustfpWxxwobrs5AKcMEq5wXZkU=;
        b=n2N7issrIn1XjD1ZfwydFRGVW5v5xIf1T2OyIMnyFGgf4VVlLjvMAYQtvzPGVTdzdV
         kG8uzTc384AdYvAl7ZZRxDtgvm0qanvmi7yIv0kByZWlpoe3ORTF5vPs/XUeGdqAKsy3
         4bl+Qq9Jn4RlUmBTLyDl2VN3V7/lumHdr6rOHtC6XjTjK6Vuv/akHl8czY0VhgI7Xtdn
         rg+2txPy/WcWxh2oNyko2SM7E29q6k3GF5D6/YCtj+Tomf+N23+BEj+84H7g0MMRUraM
         lGknTjNzpx9mbzApz4d+9tcZSS0FTyUykkYznclVCkFYw9bO2bPm19B66aFvBPzwnG87
         Ws6Q==
X-Gm-Message-State: APjAAAX7Vom9kFtz8wwZ31YGZvJBqNvS3takj7BX+tiLmiAxs3tMifXJ
        JXhY17Oskw3Amio4lxsF7VsBca+UEaJOL0B65w==
X-Google-Smtp-Source: APXvYqwXeCHQ2BCbpuCczmJZX2/XdSthljcwv1ayFMXVw2Ji2aoLz1njSz6pDqdPrRIlZFTuqyv3RCdzNpkVy6tMklc=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr41978886ljj.91.1564618162210;
 Wed, 31 Jul 2019 17:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190725135933.30046-1-omosnace@redhat.com>
In-Reply-To: <20190725135933.30046-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Jul 2019 20:09:10 -0400
Message-ID: <CAHC9VhSApdqtMfrBgkYzMCtFr62NsDCKpfd6jYZVHmQrAOo3fQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid atomic_t usage in sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Jann Horn <jannh@google.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 25, 2019 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> As noted in Documentation/atomic_t.txt, if we don't need the RMW atomic
> operations, we should only use READ_ONCE()/WRITE_ONCE() +
> smp_rmb()/smp_wmb() where necessary (or the combined variants
> smp_load_acquire()/smp_store_release()).
>
> This patch converts the sidtab code to use regular u32 for the counter
> and reverse lookup cache and use the appropriate operations instead of
> atomic_get()/atomic_set(). Note that when reading/updating the reverse
> lookup cache we don't need memory barriers as it doesn't need to be
> consistent or accurate. We can now also replace some atomic ops with
> regular loads (when under spinlock) and stores (for conversion target
> fields that are always accessed under the master table's spinlock).
>
> We can now also bump SIDTAB_MAX to U32_MAX as we can use the full u32
> range again.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/sidtab.c | 48 ++++++++++++++++--------------------
>  security/selinux/ss/sidtab.h |  8 +++---
>  2 files changed, 25 insertions(+), 31 deletions(-)

One of the things that is nice about atomic_t is that the type itself
helps indicate that this isn't a normal integer and you should look at
the stuff in atomic.h for fetching/setting the value.  While I
understand there is overhead involved, and this patch should help in
this regard, I think we lose on code readability and increase the
chance of someone manipulating these values incorrectly in the future.
I believe this is a lot of what Kees was getting at with the counter_t
idea.

At the very least I would like to see a comment in sidtab.h for the
sidtab struct explaining how users should access the count and rcache
fields.  However, what I would really like to see is some simple
macros/functions that handle the read/write accesses similar to the
way we do it with atomic_t (once again, I think this is what Kees was
getting at earlier).

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..dc6c078b6432 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -12,7 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
> -#include <linux/atomic.h>
> +#include <asm/barrier.h>
>  #include "flask.h"
>  #include "security.h"
>  #include "sidtab.h"
> @@ -23,14 +23,14 @@ int sidtab_init(struct sidtab *s)
>
>         memset(s->roots, 0, sizeof(s->roots));
>
> +       /* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
>         for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
> -               atomic_set(&s->rcache[i], -1);
> +               s->rcache[i] = SIDTAB_MAX;
>
>         for (i = 0; i < SECINITSID_NUM; i++)
>                 s->isids[i].set = 0;
>
> -       atomic_set(&s->count, 0);
> -
> +       s->count = 0;
>         s->convert = NULL;
>
>         spin_lock_init(&s->lock);
> @@ -130,14 +130,12 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
>
>  static struct context *sidtab_lookup(struct sidtab *s, u32 index)
>  {
> -       u32 count = (u32)atomic_read(&s->count);
> +       /* read entries only after reading count */
> +       u32 count = smp_load_acquire(&s->count);
>
>         if (index >= count)
>                 return NULL;
>
> -       /* read entries after reading count */
> -       smp_rmb();
> -
>         return sidtab_do_lookup(s, index, 0);
>  }
>
> @@ -210,10 +208,10 @@ static int sidtab_find_context(union sidtab_entry_inner entry,
>  static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
>  {
>         while (pos > 0) {
> -               atomic_set(&s->rcache[pos], atomic_read(&s->rcache[pos - 1]));
> +               WRITE_ONCE(s->rcache[pos], READ_ONCE(s->rcache[pos - 1]));
>                 --pos;
>         }
> -       atomic_set(&s->rcache[0], (int)index);
> +       WRITE_ONCE(s->rcache[0], index);
>  }
>
>  static void sidtab_rcache_push(struct sidtab *s, u32 index)
> @@ -227,14 +225,14 @@ static int sidtab_rcache_search(struct sidtab *s, struct context *context,
>         u32 i;
>
>         for (i = 0; i < SIDTAB_RCACHE_SIZE; i++) {
> -               int v = atomic_read(&s->rcache[i]);
> +               u32 v = READ_ONCE(s->rcache[i]);
>
> -               if (v < 0)
> +               if (v >= SIDTAB_MAX)
>                         continue;
>
> -               if (context_cmp(sidtab_do_lookup(s, (u32)v, 0), context)) {
> -                       sidtab_rcache_update(s, (u32)v, i);
> -                       *index = (u32)v;
> +               if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
> +                       sidtab_rcache_update(s, v, i);
> +                       *index = v;
>                         return 0;
>                 }
>         }
> @@ -245,8 +243,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                                  u32 *index)
>  {
>         unsigned long flags;
> -       u32 count = (u32)atomic_read(&s->count);
> -       u32 count_locked, level, pos;
> +       u32 count, count_locked, level, pos;
>         struct sidtab_convert_params *convert;
>         struct context *dst, *dst_convert;
>         int rc;
> @@ -255,11 +252,10 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>         if (rc == 0)
>                 return 0;
>
> +       /* read entries only after reading count */
> +       count = smp_load_acquire(&s->count);
>         level = sidtab_level_from_count(count);
>
> -       /* read entries after reading count */
> -       smp_rmb();
> -
>         pos = 0;
>         rc = sidtab_find_context(s->roots[level], &pos, count, level,
>                                  context, index);
> @@ -272,7 +268,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>         spin_lock_irqsave(&s->lock, flags);
>
>         convert = s->convert;
> -       count_locked = (u32)atomic_read(&s->count);
> +       count_locked = s->count;
>         level = sidtab_level_from_count(count_locked);
>
>         /* if count has changed before we acquired the lock, then catch up */
> @@ -315,7 +311,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                 }
>
>                 /* at this point we know the insert won't fail */
> -               atomic_set(&convert->target->count, count + 1);
> +               convert->target->count = count + 1;
>         }
>
>         if (context->len)
> @@ -326,9 +322,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>         *index = count;
>
>         /* write entries before writing new count */
> -       smp_wmb();
> -
> -       atomic_set(&s->count, count + 1);
> +       smp_store_release(&s->count, count + 1);
>
>         rc = 0;
>  out_unlock:
> @@ -418,7 +412,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>                 return -EBUSY;
>         }
>
> -       count = (u32)atomic_read(&s->count);
> +       count = s->count;
>         level = sidtab_level_from_count(count);
>
>         /* allocate last leaf in the new sidtab (to avoid race with
> @@ -431,7 +425,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>         }
>
>         /* set count in case no new entries are added during conversion */
> -       atomic_set(&params->target->count, count);
> +       params->target->count = count;
>
>         /* enable live convert of new entries */
>         s->convert = params;
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index bbd5c0d1f3bd..b4561c5ec893 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -40,8 +40,8 @@ union sidtab_entry_inner {
>  #define SIDTAB_LEAF_ENTRIES \
>         (SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
>
> -#define SIDTAB_MAX_BITS 31 /* limited to INT_MAX due to atomic_t range */
> -#define SIDTAB_MAX (((u32)1 << SIDTAB_MAX_BITS) - 1)
> +#define SIDTAB_MAX_BITS 32
> +#define SIDTAB_MAX U32_MAX
>  /* ensure enough tree levels for SIDTAB_MAX entries */
>  #define SIDTAB_MAX_LEVEL \
>         DIV_ROUND_UP(SIDTAB_MAX_BITS - size_to_shift(SIDTAB_LEAF_ENTRIES), \
> @@ -70,12 +70,12 @@ struct sidtab_convert_params {
>
>  struct sidtab {
>         union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
> -       atomic_t count;
> +       u32 count;
>         struct sidtab_convert_params *convert;
>         spinlock_t lock;
>
>         /* reverse lookup cache */
> -       atomic_t rcache[SIDTAB_RCACHE_SIZE];
> +       u32 rcache[SIDTAB_RCACHE_SIZE];
>
>         /* index == SID - 1 (no entry for SECSID_NULL) */
>         struct sidtab_isid_entry isids[SECINITSID_NUM];
> --
> 2.21.0
>


-- 
paul moore
www.paul-moore.com
