Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB55C2BA83
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604E218AC
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7Cr6O0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgBMMVd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:21:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727059AbgBMMVd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 07:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581596492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FfnO2CI5hCFmNlgh85nqUF8/duj2fCI7Y7eO7Ytkhs=;
        b=M7Cr6O0r9z9TQL7xYcMGtnyBI8snNF4bkH3pMGuGWbBNb+9lVXeyDE3icyq3B3Ffcz7TNf
        L5zy8tYfmI1NbzY+HOeSy4O3oDR/KKsrFpoRuT1VTTUum3LwecbWN7fx+mbPCwXn6HkRZT
        scMbBUjwicyVoAJaNLNZmKfHxyvjc8w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-uO8WYWXdP3yZqfoNcLznVw-1; Thu, 13 Feb 2020 07:21:30 -0500
X-MC-Unique: uO8WYWXdP3yZqfoNcLznVw-1
Received: by mail-oi1-f198.google.com with SMTP id d9so2670404oij.4
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 04:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5FfnO2CI5hCFmNlgh85nqUF8/duj2fCI7Y7eO7Ytkhs=;
        b=PrBSlgObjuN/MAZP6wnoT/kC9IAjfzEaiXlun2EcYBljPOi4VJ5vgcoWQZqF9exOkD
         ggAPlAU1OE8uk2ShodGt2gCRgiKjhwg/OcE3VXvOx0FC2FuyparY/Jku/JejdqKdLMo5
         aA6UarlE7WbLzQSv3vDASiSaw4E1fzauqiWJ4wj7OuzbO3k3V6miNrAJqqy+DdGyKyhF
         /KFqTYwsM4tEw4IF5g32HcprziIgWDbLWbvVQgBjWrVLgakayf7hILKNFHxbZVVfWfDc
         +zK/kejI13sF4+0v0YhU6pnXaF+A8MXCffNtt+KyWhDXb2cggmtncOd+0zIBv6hqc99b
         LIzw==
X-Gm-Message-State: APjAAAWT7LNryuj3f0FJkfB+LHquvhQRqgqgZf0ZqkKhVW/lPT0/QGo9
        Qfic4LmhyI0s3SjCsu37iuMXZqDDIPgkkvHX4hG9GabDRNXAWHVoE/XZf/j0JJv9TWM4JgglBZi
        q3n9cOBTGd2MK8mMXObqVowCG7bA9RRAabg==
X-Received: by 2002:a9d:6283:: with SMTP id x3mr12690453otk.367.1581596489318;
        Thu, 13 Feb 2020 04:21:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMZE48+fQzp3Zlm6B9YirhBTdJW8X523iE0gk6hEArtEqpiuf9cPoeLYvLzOwtRIlPHc6Va15mxXlwU5F10B4=
X-Received: by 2002:a9d:6283:: with SMTP id x3mr12690439otk.367.1581596489070;
 Thu, 13 Feb 2020 04:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20200212115140.107017-1-omosnace@redhat.com>
In-Reply-To: <20200212115140.107017-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 13 Feb 2020 13:21:18 +0100
Message-ID: <CAFqZXNvaD7x3-PmdnCPCX6EAfZ9fm9uNeSKe5J2YB8_XLUh2bA@mail.gmail.com>
Subject: Re: [PATCH userspace] libsepol: cache ebitmap cardinality value
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 12:51 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> According to profiling of semodule -BN, ebitmap_cardinality() is called
> quite often and contributes a lot to the total runtime. Cache its result
> in the ebitmap struct to reduce this overhead. The cached value is
> invalidated on most modifying operations, but ebitmap_cardinality() is
> usually called once the ebitmap doesn't change any more.
>
> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> decreased from ~21.4s to ~18.6s (2.8s saved).

Please don't ack/merge this yet, I need to re-evaluate these numbers...

>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/include/sepol/policydb/ebitmap.h |  1 +
>  libsepol/src/ebitmap.c                    | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
> index e62df01c..53fafdaa 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -37,6 +37,7 @@ typedef struct ebitmap_node {
>  typedef struct ebitmap {
>         ebitmap_node_t *node;   /* first node in the bitmap */
>         uint32_t highbit;       /* highest position in the total bitmap */
> +       unsigned int cardinality;       /* cached value of cardinality */
>  } ebitmap_t;
>
>  #define ebitmap_length(e) ((e)->highbit)
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 6c9951b7..d23444ce 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -67,6 +67,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
>         ebitmap_destroy(dst);
>         dst->node = tmp.node;
>         dst->highbit = tmp.highbit;
> +       dst->cardinality = 0;
>
>         return 0;
>  }
> @@ -128,9 +129,14 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
>  unsigned int ebitmap_cardinality(ebitmap_t *e1)
>  {
>         unsigned int i, count = 0;
> +
> +       if (e1->cardinality || e1->highbit == 0)
> +               return e1->cardinality;
> +
>         for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
>                 if (ebitmap_get_bit(e1, i))
>                         count++;
> +       e1->cardinality = count;
>         return count;
>  }
>
> @@ -194,6 +200,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
>         }
>
>         dst->highbit = src->highbit;
> +       dst->cardinality = src->cardinality;
>         return 0;
>  }
>
> @@ -309,6 +316,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
>                                         free(n);
>                                 }
>                         }
> +                       e->cardinality = 0; /* invalidate cached cardinality */
>                         return 0;
>                 }
>                 prev = n;
> @@ -339,6 +347,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
>                 e->node = new;
>         }
>
> +       e->cardinality = 0; /* invalidate cached cardinality */
>         return 0;
>  }
>
> @@ -358,6 +367,7 @@ void ebitmap_destroy(ebitmap_t * e)
>
>         e->highbit = 0;
>         e->node = 0;
> +       e->cardinality = 0;
>         return;
>  }
>
> --
> 2.24.1
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

