Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F90C38A29
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE92137B
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="x7Mepxa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405920AbgDPA4x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbgDPA4W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 20:56:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87BC061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 17:56:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s29so7365508edc.1
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 17:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9IPNxZsLfilQ2GSNX8Lpar3nTDGhAn72qMI09Q+ees=;
        b=x7Mepxa537ib0k6D9A60PlEoy5K4lfSlOsGKc1/tRSoi4SO/ZyBidSz4CcCQVOZthm
         uPbTk/8n2MjMgZu7xSJ97QmEIVylyhYE19qwtaWPIvE4RGRUpVQn0A5ViwjffH4x5ue9
         kAkcWDT/6bHYUA15v8LSbhf1MzToVIl4SOEIUrwvEZB9EI/mqx4+n/9FenDdyY+/cj72
         cbg4yZiLSvfFKgtohfiJpfTvehvO+nG931wsTiypLpxfwhiL+IYCNQYyyKRjCu8b+1VO
         Ev7l4+vyjcwqWQmEQnliGVyATuWGoNAxdLeJzuIKeG1Oe033iHF9v0yB0sjt+By2t1yV
         EmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9IPNxZsLfilQ2GSNX8Lpar3nTDGhAn72qMI09Q+ees=;
        b=PwKSLQjEL4FFuvvYASXKn5uwDysz2zK/Dt2H+s33D/Wqc3ynd4e/+PbB3yfjQofF/p
         zjMA7vXLto+seygiQsijV+b/oOQR+VBgFJW798w6aIU6KPA7KmXiStG2nYPG4Li6a9ju
         vrn2ivF4vgPvKf05AE4L1l+yKbeyED44WVxuorDK7pu+l7ntHpFtU2aXNGZS665fIwCd
         Elun0RAu7/N90Mww4Ih1lBXo8zM4X/HUH84NzZOVhLASDRo91wug8u9WX7T4qlTzjYFG
         cwg/BqLT/0JS7FNZru/WLCXw6T1prGpD/ZlW5hfkAnGNZpluj1wKMULD/2dCOeLKriAK
         8pVw==
X-Gm-Message-State: AGi0PuY5KSbYayWJGQPfqtGltj/h2ROeUmUv9IHhkg4Z3VNRYv60uXdH
        K0+3OV3IZdbdtbSeSu6fj4tncG1bQBBv5eMDR3Dc
X-Google-Smtp-Source: APiQypI0c0g35QsgIj3YQoVEv8GbMxBWf4fgUbPCYrLLIewpuCpZ8OS+qtvYGkjenCXQpi5Bv5zoSoI3LPurH0R9XLs=
X-Received: by 2002:aa7:c352:: with SMTP id j18mr9654957edr.196.1586998579693;
 Wed, 15 Apr 2020 17:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200409081248.1273383-1-omosnace@redhat.com> <20200409081248.1273383-2-omosnace@redhat.com>
In-Reply-To: <20200409081248.1273383-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 20:56:08 -0400
Message-ID: <CAHC9VhTGJ7kxjzaL5eiJ7g42qjgDeLPUowTrzvpkUJupNWkNpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: hash context structure directly
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 9, 2020 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Always hashing the string representation is inefficient. Just hash the
> contents of the structure directly (using jhash). If the context is
> invalid (str & len are set), then hash the string as before, otherwise
> hash the structured data. Any context that is valid under the given
> policy should always be structured, and also any context that is invalid
> should be never structured, so the hashes should always match for the
> same context. The fact that context_cmp() also follows this logic
> further reinforces this assumption.
>
> Since the context hashing function is now faster (about 10 times), this
> patch decreases the overhead of security_transition_sid(), which is
> called from many hooks.
>
> The jhash function seemed as a good choice, since it is used as the
> default hashing algorithm in rhashtable.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile      |  2 +-
>  security/selinux/ss/context.c  | 28 ++++++++++++
>  security/selinux/ss/context.h  |  6 ++-
>  security/selinux/ss/ebitmap.c  | 14 ++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/policydb.c |  7 +--
>  security/selinux/ss/services.c | 80 ++++++++++++++--------------------
>  security/selinux/ss/services.h |  3 --
>  8 files changed, 82 insertions(+), 59 deletions(-)
>  create mode 100644 security/selinux/ss/context.c

...

> diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> new file mode 100644
> index 000000000000..7ca32683056d
> --- /dev/null
> +++ b/security/selinux/ss/context.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementations of the security context functions.
> + *
> + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> + * Copyright (C) 2018 Red Hat, Inc.

I think your clock is a bit off ... ;)

Joking aside, copyright dates are important so please fix this (also
because it is a copyright related issue, it isn't something I want to
fix during the merge).

> + */
> +
> +#include <linux/jhash.h>
> +
> +#include "context.h"
> +#include "mls.h"
> +
> +u32 context_compute_hash(const struct context *c)
> +{
> +       u32 hash = 0;
> +
> +       if (c->len)
> +               return full_name_hash(NULL, c->str, c->len);
> +
> +       hash = jhash_3words(c->user, c->role, c->type, hash);
> +       hash = jhash_2words(c->range.level[0].sens,
> +                           c->range.level[1].sens, hash);
> +       hash = ebitmap_hash(&c->range.level[0].cat, hash);
> +       hash = ebitmap_hash(&c->range.level[1].cat, hash);

Most other places we try to abstract away the mls_range details by
having an associated mls_XXX(...) function, it seems like that would
be a good idea here too.  How about adding a mls_context_hash(), or
similarly named function and calling it here.

> +       return hash;
> +}
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 3ba044fe02ed..e7ae7e21449b 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -196,9 +196,11 @@ static inline int context_cmp(struct context *c1, struct context *c2)
>                 mls_context_cmp(c1, c2));
>  }
>
> -static inline unsigned int context_compute_hash(const char *s)
> +u32 context_compute_hash(const struct context *c);
> +
> +static inline void context_add_hash(struct context *context)
>  {
> -       return full_name_hash(NULL, s, strlen(s));
> +       context->hash = context_compute_hash(context);
>  }
>
>  #endif /* _SS_CONTEXT_H_ */
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index c8c3663111e2..14bedc95c6dc 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> +#include <linux/jhash.h>
>  #include <net/netlabel.h>
>  #include "ebitmap.h"
>  #include "policydb.h"
> @@ -542,6 +543,19 @@ int ebitmap_write(struct ebitmap *e, void *fp)
>         return 0;
>  }
>
> +u32 ebitmap_hash(const struct ebitmap *e, u32 hash)
> +{
> +       struct ebitmap_node *node;
> +
> +       /* need to change hash even if ebitmap is empty */
> +       hash = jhash_1word(e->highbit, hash);
> +       for (node = e->node; node; node = node->next) {
> +               hash = jhash_1word(node->startbit, hash);
> +               hash = jhash(node->maps, sizeof(node->maps), hash);
> +       }
> +       return hash;
> +}
> +
>  void __init ebitmap_cache_init(void)
>  {
>         ebitmap_node_cachep = kmem_cache_create("ebitmap_node",
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index 9a23b81b8832..9eb2d0af2805 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -131,6 +131,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
>  void ebitmap_destroy(struct ebitmap *e);
>  int ebitmap_read(struct ebitmap *e, void *fp);
>  int ebitmap_write(struct ebitmap *e, void *fp);
> +u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
>
>  #ifdef CONFIG_NETLABEL
>  int ebitmap_netlbl_export(struct ebitmap *ebmap,
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 70ecdc78efbd..ac6c0a214fc5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -836,11 +836,8 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>                 if (!name)
>                         continue;
>
> -               rc = context_add_hash(p, &c->context[0]);
> -               if (rc) {
> -                       sidtab_destroy(s);
> -                       goto out;
> -               }
> +               context_add_hash(&c->context[0]);
> +
>                 rc = sidtab_set_initial(s, sid, &c->context[0]);
>                 if (rc) {
>                         pr_err("SELinux:  unable to load initial SID %s.\n",
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8ad34fd031d1..2099355e9a7d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1490,38 +1490,11 @@ out:
>         return rc;
>  }
>
> -int context_add_hash(struct policydb *policydb,
> -                    struct context *context)
> +static int context_struct_to_sid(struct sidtab *sidtab, struct context *context,
> +                                u32 *sid)

Since you need to respin this patchset anyway, and patch 2/2 deals
with the move to sidtab, I think it might be better to keep the
context_struct_to_sid() arguments the same and not swap the first
argument for the sidtab.  If you keep the first argument as the state
it makes this patch much more focused on the change at hand and leaves
patch 2/2 dedicated to just the sidtab move.

>  {
> -       int rc;
> -       char *str;
> -       int len;
> -
> -       if (context->str) {
> -               context->hash = context_compute_hash(context->str);
> -       } else {
> -               rc = context_struct_to_string(policydb, context,
> -                                             &str, &len);
> -               if (rc)
> -                       return rc;
> -               context->hash = context_compute_hash(str);
> -               kfree(str);
> -       }
> -       return 0;
> -}
> -
> -static int context_struct_to_sid(struct selinux_state *state,
> -                                struct context *context, u32 *sid)
> -{
> -       int rc;
> -       struct sidtab *sidtab = state->ss->sidtab;
> -       struct policydb *policydb = &state->ss->policydb;
> -
> -       if (!context->hash) {
> -               rc = context_add_hash(policydb, context);
> -               if (rc)
> -                       return rc;
> -       }
> +       if (!context->hash)
> +               context_add_hash(context);
>
>         return sidtab_context_to_sid(sidtab, context, sid);
>  }

-- 
paul moore
www.paul-moore.com
