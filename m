Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A787C4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 19:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjKBT3m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT3l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 15:29:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8338E7
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 12:29:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50939d39d0fso1669336e87.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698953377; x=1699558177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA0ZWW+n7uONzvdqNoqJSxMwIkgU7VWImHAaw2NsujA=;
        b=RawuzNVrkWjsKbadeP4GlFqVA6jxbN+Plhef38fpmjIDIDHTi/eKkNNeRRlvZufGRz
         YRfxSdV43/Yk5ug6/T/Q2p+mu80Fiqlm1dykdvVLE4EtqkbP8nUhqPAbPTRQoz382Tg9
         rOjUieQvWoKPlDlPH2iT3cGIcubTLbsMurfal+yW2lyTsdO1jiyvWhF0IXwPs8hC6CPz
         1fWZzsa8cC5i1CKNx0DidbI2Z8wrselaUYXAwcDtX5oLG9uzJAiXiXuIwWhjB9WhhmK5
         vMu3hs80OE6Y0kW1z+pb/q5yYATx6NCGpHt5kC4PTKdgQanCtxleln6B2bKRfSKRT1nA
         JuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953377; x=1699558177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA0ZWW+n7uONzvdqNoqJSxMwIkgU7VWImHAaw2NsujA=;
        b=BPeIpclOtB9QOnaUjCfHvJB0qk7itmkOP3bxJzt7KLrQOxzuBHQS3iEo4yLmefkin7
         JqEEGVYUozgo8qdtVUafoiMhQ/d6Z7+BldsgUHQw3832IQYUN+lNgfVLEXW06DKb67hz
         fTy7JD/BTcl441rNU4h2pPgU0iOeIWbHrQELyXHHHEOXoZWbHrg0b6POCgVnAUsYmFre
         bIvv38QJspXUJZegGKeBCVm9lbcbmWes8F3BObEEeGGP9eA38/mkhNgAcMFnNANdbdPO
         ZqcLku1cc1XVvFfRIC7DbUBYBkV5H9ubwEkr+LmWu1KupLyg9o1ARslDGC3fWHvNZ5B5
         Xdbw==
X-Gm-Message-State: AOJu0YzCL81k3NF7fVqqTMQLvOnYbzwuZjQ1oI6ZOhq5o4NAUonoqv6g
        +Y03velO4OOhnRwcChdr75slMhaYuZi/WijdQ9UBkTp5eOc=
X-Google-Smtp-Source: AGHT+IHG9+UtWPy4hgXnIURbo9405BigtxPY2ofBLmkAWFZrgefOFsqi4BcSUcOWqoVlvClMv/x/MGEVNRjl6E1HHA0=
X-Received: by 2002:a05:6512:3da0:b0:503:3680:6726 with SMTP id
 k32-20020a0565123da000b0050336806726mr17249614lfv.6.1698953376892; Thu, 02
 Nov 2023 12:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163830.177769-1-cgzones@googlemail.com> <20231101163830.177769-3-cgzones@googlemail.com>
In-Reply-To: <20231101163830.177769-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 15:29:25 -0400
Message-ID: <CAP+JOzRCE2DyxBCO7pnQbz2BToeiqHa61LxZ3=10YxLLupqrFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: more strict validation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure the ibendport port is not 0 (similar to the kernel).
>
> More general depth test for boolean expressions.
>
> Ensure the boolean id is not set for logic operators.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index c6a66fb3..0e4805ef 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1002,13 +1002,15 @@ static int validate_cond_expr(sepol_handle_t *han=
dle, const struct cond_expr *ex
>                 case COND_BOOL:
>                         if (validate_value(expr->boolean, boolean))
>                                 goto bad;
> -                       if (depth =3D=3D (COND_EXPR_MAXDEPTH - 1))
> +                       if (depth >=3D (COND_EXPR_MAXDEPTH - 1))
>                                 goto bad;
>                         depth++;
>                         break;
>                 case COND_NOT:
>                         if (depth < 0)
>                                 goto bad;
> +                       if (expr->boolean !=3D 0)
> +                               goto bad;
>                         break;
>                 case COND_OR:
>                 case COND_AND:
> @@ -1017,6 +1019,8 @@ static int validate_cond_expr(sepol_handle_t *handl=
e, const struct cond_expr *ex
>                 case COND_NEQ:
>                         if (depth < 1)
>                                 goto bad;
> +                       if (expr->boolean !=3D 0)
> +                               goto bad;
>                         depth--;
>                         break;
>                 default:
> @@ -1199,6 +1203,8 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p, valid
>                                                 goto bad;
>                                         break;
>                                 case OCON_IBENDPORT:
> +                                       if (octx->u.ibendport.port =3D=3D=
 0)
> +                                               goto bad;
>                                         if (!octx->u.ibendport.dev_name)
>                                                 goto bad;
>                                         break;
> --
> 2.42.0
>
