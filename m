Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A8C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjKFOeA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOd7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 09:33:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65DBB
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 06:33:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-509109104e2so5867979e87.3
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699281235; x=1699886035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA5m4rdqLrag4FBYcJ52bbEBuYH8S6oo+qPcBYMTRq8=;
        b=cvoLH/cK4Oid+etwfzjb16ehXa+2iFIaKb3T/NH68AV9OyD3XWLq4q29Q1Zgp7shn9
         tgf4VaFD+7sWDO4r7zm9Wyx3hUiPO3h1LlBtJcRy/Z2T8OUVQXya0I9kVdMD8Qi5j4pK
         oGj9oYT8FO3xMGcabaMlxD4LnNYHQ4IiQ9u/Fv5SVlaGLn6VvHE8tyu78y4Mks2YfrOW
         /LkodGEGacg4wSbcK80WX8FTPfL7oneJeRXxeNuNuwNb0tFY+qQscq/X4Q9xnLGWzb8r
         RRj93FBxL3Uo0U9U31WhEu05ndo5/azGuW36sCiNqvgYG+pKNu7u/p/OD/snjGjbtU5K
         JeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281235; x=1699886035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA5m4rdqLrag4FBYcJ52bbEBuYH8S6oo+qPcBYMTRq8=;
        b=XSUGAdMNjbPKudgmqi2K4Un+Q/X338Ro42o1MUoLXv0PIGg50mcwMs0Y28uXnfDOQy
         f7FgnDT7ikM+Rl5LzN3X/UypdQnwRgyguluvuascdfVYAi6RWAXZSj/kP1ic/6h7Ynyb
         KuZh65xDHkJoXN007WfIFgE/ldQpVrR+hFvpXlJYr3ks1swhlAG5zLgQB9Dr0lUvEhVW
         Kkeu+TpKR7DdKmnb0QE9vhKRz0e9Vo4xCydjeEg+WH+wxCeI9dB/spq2N7+k+70TNXDP
         IRGgspBM+4sgvYG6GWI/WjdhSOpycl0SL2+hAMOqop1OHlLU285XRXya8Y06J4T3THCH
         ZY9w==
X-Gm-Message-State: AOJu0Yy7wDWTcb44uRSmFtmutUScfxujkSxJithYwxHEmu/mnRIrjVuA
        +Ul6/IAJyC4F9ci8ILWtAWl8E34wora7m7GEYYo=
X-Google-Smtp-Source: AGHT+IE4XtPcrepmPuomnPuf0XN7Od6CH9ick4PxjiPVsjpRtieeMNpRFupSYLxnO7Tq4wOIIxI8lWr8JNX4JcaxVto=
X-Received: by 2002:ac2:44c2:0:b0:509:2b80:f90c with SMTP id
 d2-20020ac244c2000000b005092b80f90cmr15434528lfm.68.1699281234903; Mon, 06
 Nov 2023 06:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20231103182637.85003-1-cgzones@googlemail.com> <20231103182637.85003-3-cgzones@googlemail.com>
In-Reply-To: <20231103182637.85003-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 09:33:43 -0500
Message-ID: <CAP+JOzQbyKBtoWw-tHyASwahbctJKWJL9fRG1GQ1f-So82qApQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: more strict validation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
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
> index b20ed579..d04f6bcd 100644
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
> @@ -1203,6 +1207,8 @@ static int validate_ocontexts(sepol_handle_t *handl=
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
