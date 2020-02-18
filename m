Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B22C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A720679
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrbFXY9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBRPWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:22:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgBRPWk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 10:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582039359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ISHjABOj/0x6vYdYg2A+ZvwZIePFe+073aW5PR4yq0=;
        b=ZrbFXY9m1e0CVdOxTliT+OLj7lzg+j44iB8o0/8xn3qEHqL6W/Fgq8Xywywu3s2H6O0C86
        n94zXuFDE7AjqvuPSOIBiZBZ6q3Ba06pDisLQdbhLBYQYxAWSb8geSa4c3jz7a3LGftEUn
        mnkSYLhwu8SHs3mBHXuksmXSrOH6oGs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-SBhrpSzLPkmVEzdheVcAIA-1; Tue, 18 Feb 2020 10:22:35 -0500
X-MC-Unique: SBhrpSzLPkmVEzdheVcAIA-1
Received: by mail-ot1-f69.google.com with SMTP id 39so12539906otb.8
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 07:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ISHjABOj/0x6vYdYg2A+ZvwZIePFe+073aW5PR4yq0=;
        b=tI/fIJsS0gEMPCmmvY4Iuzd7wMzHgNc65wlhzwjlNgELDoO1aao/ePlw1XXM4NJfcd
         AMNLAofcLkrD/M1EviYBYtAkdR8qTeqX8K99DFYl+x+n+5cohoTNUJOfILIovjXZiD0q
         2+qf5g32nKHsk9vOn6sTlMt6N+aRi36Dj2gOXeIBtvrSF55CCBBqNgzNAdsbX8vdjwN0
         M0eQZrr/qKTkLC6P1NzworNPznwHcdz35Ymo1lApDJ5dr/53IpsdzlebJEQPgy6zF6R6
         RnjDfk10IvopWUWSJXkLg4Gt2BHCPUfpvAvaTxW4MhTtu/R1FGI0/bIapArI9u+li2qK
         NyLA==
X-Gm-Message-State: APjAAAUvAXHelIZUwk8T1TZKpMvmRP7D6DhBEbhoGthRxMGgR55TMwQc
        kqpsqu1s1+4X+FkUlz4vcnDmLZbE5Z8chO9GOx7H6lon+rOXzMxLelKvTy5OFlz37CnfnMP1Fh/
        xLJ/vsWxipxbYGYGSgrOuXwGU4DasgSv1xw==
X-Received: by 2002:aca:1108:: with SMTP id 8mr1586173oir.127.1582039354001;
        Tue, 18 Feb 2020 07:22:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1QJCWW7fpu/TjPR42vho3xhTxgSFJp9mlOlimLK7ZtyMIEsCFvq9ub1EwKt+bG5+DCBdK3TkD6ZnKcBFX4XA=
X-Received: by 2002:aca:1108:: with SMTP id 8mr1586147oir.127.1582039353747;
 Tue, 18 Feb 2020 07:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com>
In-Reply-To: <20200213133959.14217-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Feb 2020 16:22:22 +0100
Message-ID: <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> According to profiling of semodule -BN, ebitmap_cardinality() is called
> quite often and contributes a lot to the total runtime. Cache its result
> in the ebitmap struct to reduce this overhead. The cached value is
> invalidated on most modifying operations, but ebitmap_cardinality() is
> usually called once the ebitmap doesn't change any more.
>
> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> decreased from ~14.6s to ~12.4s (2.2s saved).

I have no idea why, but I'm now getting completely different times
(10.9s vs. 8.9s) with the same builds on the same setup... I can no
longer reproduce the slower times anywhere (F31/locally/...) so I have
to assume it was some kind of glitch. Since the numbers show a similar
magnitude of speed-up (and they depend on a bunch of HW/SW factors
anyway), I'm not going to do another respin. The applying person (most
likely Stephen) is free to fix the numbers when applying if they wish
to do so.

>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: corrected time values in commit message
>
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

