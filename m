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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C9C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC9C61245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFUU7x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhFUU7x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:59:53 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE6C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:38 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id z14-20020a4a984e0000b029024a8c622149so4824071ooi.10
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q9vGXCe68qwqLfgX0TNs8Zdb6YGfNWHXp27/yW8Z4UM=;
        b=K4lbgnYX9D59wGYGT2ZMTw/YYSuRLwJvthw0dON+c6DFhu7kMAz3KxBzhB2sMZA5xy
         LuvulMb9HGRK7dpdPQwsT/g9sK5spy9Z8HSf9ztR4bSBFFHwL0lfFw5fquanf0S0vDBi
         NaBrQCRJiEZfh0N2Zsz0NsTot2E8gb9JegdkLfvk74IElAKGU46+7WWayCz/450CGHHO
         TM8rrXwJFuFbaQuJSWtlpK3ab2uI7y9seR/caThUUEv4l6MTz00voJ4BpDeYDjvIg4hQ
         vP/sMRGINXsJKtuYQYhWLviGh2SOXRZMsCR58Ub3DsYNXEm5iwrA53eo5hsZgmKHDRKe
         Cl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q9vGXCe68qwqLfgX0TNs8Zdb6YGfNWHXp27/yW8Z4UM=;
        b=LkE8FJ3E+WDOXx1Dce0tDqsTQPh4H7bKt7JydrGfhcnlgSNfRS0PHuFamhNFUbK1sU
         ftri/UnsSf6AiBvtu6g0vJwVr7iIULaeE8QgH1dmjROGtGlOz18p1YeRMAUIiyS/1/Kz
         95xl9eWtyRSqPKq771U4uVSOLh2ATWOrJoa4w5S9l9bmyjRxGNqOYoW0EF4UjpWyPRiK
         OiiGydKN7cUvnsHGZRoUE3yDEjF2HrkXOAaHMDJKSXyrzhtF0aTNUDt3PUxFAJt9ZDaO
         p+vge8bMTEAJvgl+epbl1f9CGp0jG2DLQ+sdzWNsTnpVf2na4H3UqYjIIkq+qDynrFHT
         3ZXw==
X-Gm-Message-State: AOAM533O0oZJHO3tGL8CZOcEumlH7JESzajUaMd3x21NSVyCDMZUWGvY
        ZjjS5wYH2ik9UBttUZ5n3LSNh3SopWXtyqL1TAw=
X-Google-Smtp-Source: ABdhPJyNSNIhv7R52qohWfki2oDp3acmG2qQR7YEhDHSPAr8sYoBbqh0bQ06dyKEIbDAeHhlgrtK43SgeRMSfZ7Wwnc=
X-Received: by 2002:a4a:3011:: with SMTP id q17mr49627oof.35.1624309058084;
 Mon, 21 Jun 2021 13:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-17-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-17-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:57:27 -0400
Message-ID: <CAP+JOzR+dHn_5UVKzNB25MiRJOhpTmkJeukjxwt2tV1gH-ZVow@mail.gmail.com>
Subject: Re: [PATCH 16/23] libsepol/cil: drop extra semicolon
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
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 9a9bc598..da298311 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4153,7 +4153,7 @@ void cil_destroy_context(struct cil_context *contex=
t)
>                 return;
>         }
>
> -       cil_symtab_datum_destroy(&context->datum);;
> +       cil_symtab_datum_destroy(&context->datum);
>
>         if (context->range_str =3D=3D NULL && context->range !=3D NULL) {
>                 cil_destroy_levelrange(context->range);
> --
> 2.32.0
>
