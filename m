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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7ADC48BC2
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B14561245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUVAx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFUVAw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:00:52 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B114C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:58:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so12523672ote.11
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yI2bOpKa5ORvt8RXuoiwIjS8lfxmrAd+qbztmKeWczE=;
        b=MUJZtIHm2MoajHnvsamggTuGd8lXQASwPzq6LMcBCCp3Yz93GloL4JYBZHpKJsyI3P
         dtTy9wvWlaQ0NB2cLF8RgBZagRibGWLmeiisSXfh8s/4wfVc0cw77DRSfbbS70/vIaB7
         UXkhQN1gQxy+XJLpa2C2ET/2GL4np6F3nf+4njanE1KwmiLWByp1fr0HkiHymVzH+P7f
         oQwwKcNkwZQpj4ZNoSjFaDtRfHW1XX3ZaiT8OoHwfK4QRxWFrJLyR5X78IUe7oYOjCwd
         3NBd9hySV8mwPbSSBj9bo48/6IA3CccuY6vVy8Yx2LIkR+wDugXjRTcne0238k3nL8qu
         7aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yI2bOpKa5ORvt8RXuoiwIjS8lfxmrAd+qbztmKeWczE=;
        b=UkAzvabZNc/Qkt7lPYmel4gx0wip8dA/xH+akONxbySmzKNaZRRfq92vMHu3qJdLSN
         t32olWd3zSEUht1kBHOKu/Jzl83rXcGfL6faD2GoVFA4LjeCor+tGYhx+u7ZSfaNrAby
         gj4//bRIIPdrnH0aaIA+OWY6RNb7Z2Qgf/M5TlUdDSf2/ZU5tR2zZHbKQyYRh7eu2yVd
         a8kcVyadKU3VmpdO4BwR+a/UA6qxGCt3e0Nm3coI//V+xaoQqHXuqh0DhD1Ko6Lsf6sz
         nMXFtsyBm3JbN2dxnG79pq2+bURl3l3J5vakj9KIpScbrEfXuZMYUHI5W1TUc9U9wuFY
         WMTg==
X-Gm-Message-State: AOAM531vm9xFeyw43gWYE1rqFoSzWuExQVke3xxDdgJifg91PLentMx4
        fXfnMjRfBWWRebiXySnvmNJ08YZjdIkTPpXMoSk=
X-Google-Smtp-Source: ABdhPJxYC+qaixxVzKS9FTvLoLLOUjp0q3TD3uOsp8jkkKOb4/P6xSJG1QNA05Y723b1ld613EzlGrjvt9YhMgUOWyQ=
X-Received: by 2002:a9d:618f:: with SMTP id g15mr19828otk.196.1624309117623;
 Mon, 21 Jun 2021 13:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-16-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-16-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:58:26 -0400
Message-ID: <CAP+JOzSo7cmqgmL1gwwSQ9ZSSR_8REaX7jNYH0onwT57MeDuvA@mail.gmail.com>
Subject: Re: [PATCH 15/23] libsepol/cil: silence cast warning
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
> ../cil/src/cil_write_ast.c:86:32: error: cast to smaller integer type 'en=
um cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>                         enum cil_flavor op_flavor =3D (enum cil_flavor)cu=
rr->data;
>                                                     ^~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> ../cil/src/cil_write_ast.c:130:37: error: cast to smaller integer type 'e=
num cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>                         enum cil_flavor operand_flavor =3D (enum cil_flav=
or)curr->data;
>                                                          ^~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>
> Silence this warning by casting the pointer to an integer the cast to
> enum cil_flavor.
>
> See 32f8ed3d6b0b ("libsepol/cil: introduce intermediate cast to silence -=
Wvoid-pointer-to-enum-cast")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_write_ast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index 4871f704..186070c1 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -83,7 +83,7 @@ static void write_expr(FILE *out, struct cil_list *expr=
)
>                         break;
>                 case CIL_OP: {
>                         const char *op_str;
> -                       enum cil_flavor op_flavor =3D (enum cil_flavor)cu=
rr->data;
> +                       enum cil_flavor op_flavor =3D (enum cil_flavor)(u=
intptr_t)curr->data;
>                         switch (op_flavor) {
>                         case CIL_AND:
>                                 op_str =3D CIL_KEY_AND;
> @@ -127,7 +127,7 @@ static void write_expr(FILE *out, struct cil_list *ex=
pr)
>                 }
>                 case CIL_CONS_OPERAND: {
>                         const char *operand_str;
> -                       enum cil_flavor operand_flavor =3D (enum cil_flav=
or)curr->data;
> +                       enum cil_flavor operand_flavor =3D (enum cil_flav=
or)(uintptr_t)curr->data;
>                         switch (operand_flavor) {
>                         case CIL_CONS_U1:
>                                 operand_str =3D CIL_KEY_CONS_U1;
> --
> 2.32.0
>
