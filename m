Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D15C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2FF2070A
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPlKkXi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCFKMv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:12:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40971 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbgCFKMu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 05:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583489569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXZJy/qSUivnU9fWLXigaGYunu+7qJG3exiOufawwRs=;
        b=iPlKkXi4581JMmGnpX6Aig1eZ3n7lmR/1/wP1Docs7Dy8ZrgB8lRLEeISEo4r1+aszgrGh
        5p7lRng4ivLFeM/3COFcqDcY30sP5uQ5pdSR863kZRGZ0Xd1esLrtgBN5tTK3dI/7HIBdU
        +t4iUw7e2zjrY7PFUK8+jdRGXJ7EFt4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-jXR2zbyRP4uf3ASd2bmx-A-1; Fri, 06 Mar 2020 05:12:48 -0500
X-MC-Unique: jXR2zbyRP4uf3ASd2bmx-A-1
Received: by mail-ot1-f70.google.com with SMTP id e16so1197900otp.8
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 02:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXZJy/qSUivnU9fWLXigaGYunu+7qJG3exiOufawwRs=;
        b=d8U/MK3rMKT1OYBcPJPnw37ItYuebCR50sT25szKKWojYOUN+NVpAGF0I4KFETd2g9
         tE3mQqhAko7Zn8+vUL2yjXodYi6dcqeYeUZMuWGzSBtTUBrOQSo1kcEr2mf2a7N6ChEI
         nlWqcO+gSSBqg9+3cErwRny+PgoyHu5oARxaC+j/yYpzhJ/zMVE9oOscMfSFcD9Ad1ay
         hr+ITjFqZga2hrINR/7g8LOSGDs3FMipdvgqdPwhOi+lzJTvCUF3DfMbW4rpU7B/t13G
         7wHUlQrrCfAn3gjOo8CAxT9YodP6ywXCtNYL4dhWIJDmnOQ5wdOdE2ao+JWISog4LGLg
         l80w==
X-Gm-Message-State: ANhLgQ25Nbc3QLRCFlihec+moT1sFXTc8wM4MiHaCzH1r6UaE6hhYu9F
        i/J6e5y1pKP5hS6u1UouhWBZxLAeopCDNLThU6vmjo9g4VbOagg/9ahm2f6ZjnYEeCAkrlxz4jD
        g1tl0txSRWBrQKz6+gReFlsM+BP5j0e8YyQ==
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr1866490oto.197.1583489567289;
        Fri, 06 Mar 2020 02:12:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsZWFoNZ6ZqOog2xOX5g+KxvCqPbRouKGAYrDqA4zGl2sfuGazw2P9a8KLkBDnp3ekkM0l5IrHL6aiRWDQTsWI=
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr1866467oto.197.1583489566917;
 Fri, 06 Mar 2020 02:12:46 -0800 (PST)
MIME-Version: 1.0
References: <158343867316.158870.5386750405980710812.stgit@chester>
In-Reply-To: <158343867316.158870.5386750405980710812.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 6 Mar 2020 11:12:37 +0100
Message-ID: <CAFqZXNuy8VjV8v8O5-zr3N7zq+Tntu6WBvaTFQ-+VUUyUqOHeQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avtab_init() and cond_policydb_init() return void
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 5, 2020 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> The avtab_init() and cond_policydb_init() functions always return
> zero so mark them as returning void and update the callers not to
> check for a return value.
>
> Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>

This was originally suggested by Stephen - you should credit him, not
me :) I only expressed my preference to still keep the functions,
since Stephen was considering removing them completely.

Other than that,

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/avtab.c       |    3 +--
>  security/selinux/ss/avtab.h       |    2 +-
>  security/selinux/ss/conditional.c |   10 ++--------
>  security/selinux/ss/conditional.h |    2 +-
>  security/selinux/ss/policydb.c    |   11 ++---------
>  5 files changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 8c5800750fa8..01b300a4a882 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -299,12 +299,11 @@ void avtab_destroy(struct avtab *h)
>         h->mask = 0;
>  }
>
> -int avtab_init(struct avtab *h)
> +void avtab_init(struct avtab *h)
>  {
>         kvfree(h->htable);
>         h->htable = NULL;
>         h->nel = 0;
> -       return 0;
>  }
>
>  int avtab_alloc(struct avtab *h, u32 nrules)
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 837e938798ef..5fdcb6696bcc 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -87,7 +87,7 @@ struct avtab {
>         u32 mask;       /* mask to compute hash func */
>  };
>
> -int avtab_init(struct avtab *);
> +void avtab_init(struct avtab *h);
>  int avtab_alloc(struct avtab *, u32);
>  struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
>  void avtab_destroy(struct avtab *h);
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index cce4a75fb3e7..939a74fd8fb4 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -125,19 +125,13 @@ void evaluate_cond_nodes(struct policydb *p)
>                 evaluate_cond_node(p, &p->cond_list[i]);
>  }
>
> -int cond_policydb_init(struct policydb *p)
> +void cond_policydb_init(struct policydb *p)
>  {
> -       int rc;
> -
>         p->bool_val_to_struct = NULL;
>         p->cond_list = NULL;
>         p->cond_list_len = 0;
>
> -       rc = avtab_init(&p->te_cond_avtab);
> -       if (rc)
> -               return rc;
> -
> -       return 0;
> +       avtab_init(&p->te_cond_avtab);
>  }
>
>  static void cond_node_destroy(struct cond_node *node)
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index b9eb888ffa76..90c9c964f5f5 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -61,7 +61,7 @@ struct cond_node {
>         struct cond_av_list false_list;
>  };
>
> -int cond_policydb_init(struct policydb *p);
> +void cond_policydb_init(struct policydb *p);
>  void cond_policydb_destroy(struct policydb *p);
>
>  int cond_init_bool_indexes(struct policydb *p);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 00edcd216aaa..932b2b9bcdb2 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -463,17 +463,10 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>   */
>  static int policydb_init(struct policydb *p)
>  {
> -       int rc;
> -
>         memset(p, 0, sizeof(*p));
>
> -       rc = avtab_init(&p->te_avtab);
> -       if (rc)
> -               return rc;
> -
> -       rc = cond_policydb_init(p);
> -       if (rc)
> -               return rc;
> +       avtab_init(&p->te_avtab);
> +       cond_policydb_init(p);
>
>         p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
>                                            (1 << 11));
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

