Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5388C2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DD62087E
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 13:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok718O1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgDQNVA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729760AbgDQNVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 09:21:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8FC061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 06:21:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h25so1981157lja.10
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6N6WaB7VTRTnbalqTAVrOKZCSZFQIevSupk4fqRym4=;
        b=Ok718O1Cl9aOFDlq9QQF/NVzLXm/TQzHrA6YbKasOdKeNNwmwMYfuXFbnvKfwgjsDY
         ewEpjv4lyoEXvCh8NSA8D8ujlPanjcsJI7RKPOSga5gnIluzU6JKTg1Ak/goKRxzuMwB
         E6yUua5HtuTUmzqEA3+WK3riCCeSG592yemDlIbIkze8n3ldiTI7UwSo4wVdH+B6oabl
         +QRP/ZF1F3OPWWvdKZUnwtvAAt5a3iPtnpWm+u0PCmUrSwQCOSh9WpuyohG6cSXUh6nJ
         aptYqdUsn4MMDts/5iaHawD3tozqzDp1SYM4N0dAS7y/tbbLK5fNsKvy/p9vu/Mw6Fgj
         yK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6N6WaB7VTRTnbalqTAVrOKZCSZFQIevSupk4fqRym4=;
        b=cNZpy2pK19vPdqKmICi25b4K8JBMTxb18qN/F/mI0vK0S8bjbLM5Z/m97O5hx8nYN2
         MSdrHz4yGZ7YbIz8kT8r6ZNgjqfRZAr38L60RgNSnvvAdRyUmNvpIRdiA0G9HAqdRnFr
         oL5KcWHIRDKC/aMj6or+eDEeEGqdFt1eSyRXXkjrGWi2xCtiW3rnj0+f37ol2IkNH7b8
         sQ1GdpAbs9KWft00OMccjsAriZE5rS6QSZlDaLDRVXJoJ64TWGR7wqJXWc0g0XLeHgjF
         zJSNycvPBIdbhFdnrO6yFBrpEXXL2xRDQ751c3/VZdBRF8WFYdg2V5qXfpszmaGAMVky
         IIzg==
X-Gm-Message-State: AGi0PuZu8cXfaEavLHHEYJSVdBzXk8HgPb5tavRP1jOGelE+hJjNjcix
        Jtwk7qZpmvDXXUqMHuZvrSH/uyMsY4dkuzhPooXjbnpbXts=
X-Google-Smtp-Source: APiQypJUQF/PomrHHjZS5wirle6EzjQB+zkNv9wYBW3lq/pGxFSenMu7wtQAqAHzl6PoQ4OFvKyaZOfJxCVGivE1MII=
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr2083426ljn.173.1587129658150;
 Fri, 17 Apr 2020 06:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200417081157.606789-1-omosnace@redhat.com> <20200417081157.606789-2-omosnace@redhat.com>
In-Reply-To: <20200417081157.606789-2-omosnace@redhat.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 17 Apr 2020 15:20:46 +0200
Message-ID: <CABXk95AqpvzScopkmrmuxrV_-FVqMnrm=f7cJe7A49arLyZK_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: hash context structure directly
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 10:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Always hashing the string representation is inefficient. Just hash the
> contents of the structure directly (using jhash). If the context is
> invalid (str & len are set), then hash the string as before, otherwise
> hash the structured data.
>
> Since the context hashing function is now faster (about 10 times), this
> patch decreases the overhead of security_transition_sid(), which is
> called from many hooks.
>
> The jhash function seemed as a good choice, since it is used as the
> default hashing algorithm in rhashtable.

Testing this on Android (Pixel 3) confirms this as well.

Before:
blueline:/ # cat /sys/fs/selinux/ss/sidtab_hash_stats
entries: 1900
buckets used: 454/512
longest chain: 10

After:
blueline:/ # cat /sys/fs/selinux/ss/sidtab_hash_stats
entries: 1971
buckets used: 458/512
longest chain: 10

>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile      |  2 +-
>  security/selinux/ss/context.c  | 32 +++++++++++++++++++++++++++++++
>  security/selinux/ss/context.h  |  6 ++++--
>  security/selinux/ss/ebitmap.c  | 14 ++++++++++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/mls.h      | 11 +++++++++++
>  security/selinux/ss/policydb.c |  7 ++-----
>  security/selinux/ss/services.c | 35 ++++------------------------------
>  security/selinux/ss/services.h |  3 ---
>  9 files changed, 69 insertions(+), 42 deletions(-)
>  create mode 100644 security/selinux/ss/context.c
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 0c77ede1cc11..4d8e0e8adf0b 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
>  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
>              netnode.o netport.o status.o \
>              ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
> -            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
> +            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
>
>  selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>
> diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> new file mode 100644
> index 000000000000..fac6f92b3e99
> --- /dev/null
> +++ b/security/selinux/ss/context.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementations of the security context functions.
> + *
> + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> + * Copyright (C) 2020 Red Hat, Inc.
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
> +       /*
> +        * If a context is invalid, it will always be represented by a
> +        * context struct with only the len & str set (and vice versa)
> +        * under a given policy. Since context structs from different
> +        * policies should never meet, it is safe to hash valid and
> +        * invalid contexts differently. The context_cmp() function
> +        * already opearates under the same assumption.
operates

> +        */
> +       if (c->len)
> +               return full_name_hash(NULL, c->str, c->len);
> +
> +       hash = jhash_3words(c->user, c->role, c->type, hash);
> +       hash = mls_range_hash(&c->range, hash);
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
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 7954b1e60b64..15cacde0ff61 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -22,7 +22,10 @@
>  #ifndef _SS_MLS_H_
>  #define _SS_MLS_H_
>
> +#include <linux/jhash.h>
> +
>  #include "context.h"
> +#include "ebitmap.h"
>  #include "policydb.h"
>
>  int mls_compute_context_len(struct policydb *p, struct context *context);
> @@ -101,5 +104,13 @@ static inline int mls_import_netlbl_cat(struct policydb *p,
>  }
>  #endif
>
> +static inline u32 mls_range_hash(const struct mls_range *r, u32 hash)
> +{
> +       hash = jhash_2words(r->level[0].sens, r->level[1].sens, hash);
> +       hash = ebitmap_hash(&r->level[0].cat, hash);
> +       hash = ebitmap_hash(&r->level[1].cat, hash);
> +       return hash;
> +}
> +
>  #endif /* _SS_MLS_H */
>
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
> index 8ad34fd031d1..e4ee6d5ed825 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1490,38 +1490,13 @@ out:
>         return rc;
>  }
>
> -int context_add_hash(struct policydb *policydb,
> -                    struct context *context)
> -{
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
>  static int context_struct_to_sid(struct selinux_state *state,
>                                  struct context *context, u32 *sid)
>  {
> -       int rc;
>         struct sidtab *sidtab = state->ss->sidtab;
> -       struct policydb *policydb = &state->ss->policydb;
>
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
> @@ -2120,9 +2095,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>                         goto bad;
>         }
>
> -       rc = context_add_hash(args->newp, newc);
> -       if (rc)
> -               goto bad;
> +       context_add_hash(newc);
>
>         return 0;
>  bad:
> @@ -2133,7 +2106,7 @@ bad:
>         context_destroy(newc);
>         newc->str = s;
>         newc->len = len;
> -       newc->hash = context_compute_hash(s);
> +       context_add_hash(newc);
>         pr_info("SELinux:  Context %s became invalid (unmapped).\n",
>                 newc->str);
>         return 0;
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index e9bddf33e53d..a06f3d835216 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -8,7 +8,6 @@
>  #define _SS_SERVICES_H_
>
>  #include "policydb.h"
> -#include "context.h"
>
>  /* Mapping for a single class */
>  struct selinux_mapping {
> @@ -37,6 +36,4 @@ void services_compute_xperms_drivers(struct extended_perms *xperms,
>  void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>                                         struct avtab_node *node);
>
> -int context_add_hash(struct policydb *policydb, struct context *context);
> -
>  #endif /* _SS_SERVICES_H_ */
> --
> 2.25.2
>
Reviewed-by: Jeff Vander Stoep <jeffv@google.com>
Tested-by: Jeff Vander Stoep <jeffv@google.com>
