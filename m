Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC4C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81966214D9
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITmfJuB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfIPMjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727964AbfIPMjH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 08:39:07 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 08:39:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568637545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlvsPXh3ZMjZ14j6Z43UXKVSG+kB/9PhyCvNbquq4uk=;
        b=ITmfJuB1k1RWbgmpMZ+z/HFBcPzlupiPVclfZmb6Qnjs9TtGEoOhZcfLK1DbgTSbcIFmtr
        YuLW5ULOyeIWsgEdWnGFi2Civig04zqqT/b3ZdSgLOyGdMpSPJ/HO7URNBNl4sMP+lgtkm
        1rXT4DyUvKzQmGrHpbTRuusvzZQ5YbA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-MsHQWGjzOZ2b81Rv_EtmIQ-1; Mon, 16 Sep 2019 08:32:39 -0400
Received: by mail-ot1-f70.google.com with SMTP id o4so3623936otp.16
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2019 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RASCLWwhP8Wa23RGS7Auv9BMoa3hFRhcZE4OsJPev4=;
        b=ZC/hYOReUKhmzuQ24U57ehNj1OOOdUr+JNYI6/P6TWVlCbHE7il/QpRev/HLsCaknD
         A+CoHZ+lsGFmPAk3wOvcZTzJRPixbunnOegyzUea/09/Fnfp7acAtH6Pb2hcRQu1DYbi
         CBvltR7oj24RTcYuOYVjeLcgMwxQgilUkC0Je7sfclKzPgwcygdgKVf5sVFyzPltlf0a
         E45ZNjDJjD5AI5ZM/jb4pGXdMrFL2/J9MAjm3tjVWHvgxSdsog95XEfKwud4nh7CeR6o
         W2cBlkPVQamIBYlUOurVIfjiptA3xuoQxmBBP+ukqGcCR1cm6B9x0H5aRU9wSj8HtbUV
         ZtMQ==
X-Gm-Message-State: APjAAAXEvjS4HG0BO2mJsPL/++lj0Je599uFVxinrFrnGjdOWOKiHA0G
        Z0zkq6PneeCLbguu2Nbi0+Q2eO4tiKJOMJEmTOmRyFxr+umSrnay1N1rvfKotPlyUbZLk0+sJW6
        oueBsDMm/dRCKhQOXjVZr0v7N6OD9XXpdXQ==
X-Received: by 2002:a05:6830:210b:: with SMTP id i11mr10363122otc.367.1568637158228;
        Mon, 16 Sep 2019 05:32:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzBMsti/Z4VbvBPgNn10ndp5VIHIUKBw6HywFnJQ2ipGQDBuucOm/D7oLKSF+9e0boDjRegt97KGeNY4eZqYQ=
X-Received: by 2002:a05:6830:210b:: with SMTP id i11mr10363102otc.367.1568637157950;
 Mon, 16 Sep 2019 05:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190915191039.107622-1-nicolas.iooss@m4x.org>
In-Reply-To: <20190915191039.107622-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 16 Sep 2019 14:32:26 +0200
Message-ID: <CAFqZXNvZnTToFGBYXpk1X=4-N986ALTVUXvSJmvYyxNhvigLGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libsepol: do not dereference a failed allocated pointer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: MsHQWGjzOZ2b81Rv_EtmIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Sep 15, 2019 at 9:11 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> When strs_stack_init(&stack) fails to allocate memory and stack is still
> NULL, it should not be dereferenced with strs_stack_pop(stack).
>
> This issue has been found using Infer static analyzer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/kernel_to_cil.c  | 16 ++++++++++------
>  libsepol/src/kernel_to_conf.c | 16 ++++++++++------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 01f5bc5bba75..ca2e4a9b265b 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -108,10 +108,12 @@ static char *cond_expr_to_str(struct policydb *pdb,=
 struct cond_expr *expr)
>         return str;
>
>  exit:
> -       while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> -               free(new_val);
> +       if (stack) {
> +               while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> +                       free(new_val);
> +               }
> +               strs_stack_destroy(&stack);
>         }
> -       strs_stack_destroy(&stack);
>
>         return NULL;

Why not just replace the 'goto exit;' in the 'rc !=3D 0' branch just
after strs_stack_init() with a plain 'return NULL;'?  From my quick
look into the code it seems this would be enough to fix the issue, but
maybe I'm missing something.

>  }
> @@ -251,10 +253,12 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>         return str;
>
>  exit:
> -       while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> -               free(new_val);
> +       if (stack) {
> +               while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> +                       free(new_val);
> +               }
> +               strs_stack_destroy(&stack);
>         }
> -       strs_stack_destroy(&stack);
>
>         return NULL;
>  }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index a44ba30a0a44..b49661625e03 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb,=
 struct cond_expr *expr)
>         return str;
>
>  exit:
> -       while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> -               free(new_val);
> +       if (stack) {
> +               while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> +                       free(new_val);
> +               }
> +               strs_stack_destroy(&stack);
>         }
> -       strs_stack_destroy(&stack);
>
>         return NULL;
>  }
> @@ -247,10 +249,12 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>         return str;
>
>  exit:
> -       while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> -               free(new_val);
> +       if (stack) {
> +               while ((new_val =3D strs_stack_pop(stack)) !=3D NULL) {
> +                       free(new_val);
> +               }
> +               strs_stack_destroy(&stack);
>         }
> -       strs_stack_destroy(&stack);
>
>         return NULL;
>  }
> --
> 2.22.0
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

