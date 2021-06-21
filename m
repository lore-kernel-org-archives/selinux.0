Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E510DC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D1B61245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUVBT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFUVBS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:01:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E8C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:59:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u11so21366267oiv.1
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pao5HC4+8/Pf0gevkmYjLBnCbNN583+ZXcqqk7CurZs=;
        b=NG5Cp29Yhg8e/ymWmqunSH8+EE9EFf7bdeAaFCNaPv5059A9hlaQ2lz5j75qFkmsKN
         hZDORHab88iyQsW4fmVsG8rUUiHYKb1WFW9xwTLbD3N1OMclzooqcei63pejNTzuEio/
         il2LN1lI4x0XtE786C+iVZjD3ji1mT5b3LjbUOd2eFsu6Cli0AaTgnIoKIIr/l29b3UR
         ZZGGzTVdPIp0MLr5iO1sHhU7qhobLkSf10aGIfNywlNt2QFq08rmbfpFpqGHxQ2qbM/Q
         F+DxE2Kc/6GDe/5UdeycAUqnSaMeP8SKBogZPYcBVuKdiNciBNmsfI0pDH1p9dZ1M2gY
         kO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pao5HC4+8/Pf0gevkmYjLBnCbNN583+ZXcqqk7CurZs=;
        b=Y00rcIAHSQDvrECGL+qe44RdSAmlUfoX4NPm4Tv70FDLbZGNqN+Hciv3abLKpuFC2P
         mdItJLH4PiQPdwyi5s35JSras53TvXp2HLzdDzaNRR//n13CRKzvLlbzcDOrCa2f06UQ
         dJ/IFoj0lcWD1FrLabaSmXQo4BOc8tScLYUpXIhvlLPz1oQaymBvQkNqItzRyeCMxggS
         /wxlll4Qk585ldFMl5klgTuzB4k5M+MpH7j3+ZCcRGWOPis6+Ok6xrlnJTSkX7XXs2Hi
         wKHDS9ules1ij8DE4IfRKWpa9vAByE6PUpN2Pil8MgfUhQiEGXF//olpTVcrpvK7Atgj
         6vEw==
X-Gm-Message-State: AOAM532yY5EEjb1dBuISJrU3LfQgrKuU664T9ZP4mSlkGK7hti6Jrhye
        6pkkOCSkRfGT1xMUSuSqpDSJwRcqwx+wQxG4T3M=
X-Google-Smtp-Source: ABdhPJwX6jD9km7kFeKOAe5jkiUHIkLaDv6QUoXk/Q39Ex95DI5l7qVhd1mPKryLOcITWZ7PUHmklb5kOds6B30jVkQ=
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr291291oig.138.1624309142698;
 Mon, 21 Jun 2021 13:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-12-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-12-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:58:52 -0400
Message-ID: <CAP+JOzSXVzP-W08vh64ygEtP2jcoxKefU7DzjcjeN98c=du=mg@mail.gmail.com>
Subject: Re: [PATCH 11/23] libsepol: mark read-only parameters of type_set_
 interfaces const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Make it more obvious which parameters are read-only and not being
> modified and allow callers to pass const pointers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/policydb.h | 4 ++--
>  libsepol/src/policydb.c                    | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index c29339dc..78699fb4 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -667,8 +667,8 @@ extern int scope_destroy(hashtab_key_t key, hashtab_d=
atum_t datum, void *p);
>  extern void class_perm_node_init(class_perm_node_t * x);
>  extern void type_set_init(type_set_t * x);
>  extern void type_set_destroy(type_set_t * x);
> -extern int type_set_cpy(type_set_t * dst, type_set_t * src);
> -extern int type_set_or_eq(type_set_t * dst, type_set_t * other);
> +extern int type_set_cpy(type_set_t * dst, const type_set_t * src);
> +extern int type_set_or_eq(type_set_t * dst, const type_set_t * other);
>  extern void role_set_init(role_set_t * x);
>  extern void role_set_destroy(role_set_t * x);
>  extern void avrule_init(avrule_t * x);
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 3389a943..7739b0fb 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1753,7 +1753,7 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
>         return retval;
>  }
>
> -static int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
> +static int type_set_or(type_set_t * dst, const type_set_t * a, const typ=
e_set_t * b)
>  {
>         type_set_init(dst);
>
> @@ -1770,7 +1770,7 @@ static int type_set_or(type_set_t * dst, type_set_t=
 * a, type_set_t * b)
>         return 0;
>  }
>
> -int type_set_cpy(type_set_t * dst, type_set_t * src)
> +int type_set_cpy(type_set_t * dst, const type_set_t * src)
>  {
>         type_set_init(dst);
>
> @@ -1783,7 +1783,7 @@ int type_set_cpy(type_set_t * dst, type_set_t * src=
)
>         return 0;
>  }
>
> -int type_set_or_eq(type_set_t * dst, type_set_t * other)
> +int type_set_or_eq(type_set_t * dst, const type_set_t * other)
>  {
>         int ret;
>         type_set_t tmp;
> --
> 2.32.0
>
