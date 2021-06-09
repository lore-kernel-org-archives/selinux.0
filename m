Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E25BC48BCD
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB5613BD
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 17:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFIRoG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:44:06 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34398 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhFIRoF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 13:44:05 -0400
Received: by mail-oi1-f179.google.com with SMTP id u11so25889712oiv.1
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wDRBDBNW+7uBVnUSjHutf6vRqPZjx1tDlsIANLvQQC8=;
        b=TQrkbC6kS0UFzb9SUn4kLPsGg3v4w/wjmeDn8HEb1kvWSpnO1ZPOAH7SdPB/EijorY
         8XLT0DUbXWbRwjGihIaKOnhiPMtu8gCU5AzZAHXuaS1eo1V0PnUREEPd5Mi8vFPIm3kY
         AAGu9pkvGRCAqgVKmnhSGGCiQAKU2rTnZn3XBAR84ftZpH/n8Qx0ETvE1JUYNunQXYx1
         QbgdAglw3RM8ce0ZAckpJfEa403q4c9Whu3UOTf0xmFl/OH/MHgrXFpPoL6VrmMnLmMn
         SMCfonJZm4KcVoiqOkILWprmvqrB4XmCETDq6MzRzUErcp/B7/zNtSYGShEdHyCzy+IW
         BwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wDRBDBNW+7uBVnUSjHutf6vRqPZjx1tDlsIANLvQQC8=;
        b=RXOyobfnYetaRFzKCmONV4NXt10rs0ho6J0EdS9WgMVDdkg0G5kpk0/WeZ4MWDuf1a
         Yvi3527oYQ42ptqKV6bfBhgRTX77C5dStysehfHvgDxhqEHkULgihkUad6nWW+3w/fi4
         2oMa093alQjK2DIEUw9x8RiSKvLW8t+F0rkhmJCWFdY2TME6Bbx6V6w8GIkEmYRizDIY
         Ef/7WofHfo8eiBAY2TcbAGRZvVK1qedg0OMqm9gUQwmb74+J1rwnRsx80EMIqYkHqCFl
         vFCGdVONVDkbgHE0uA/IFPUYzn2Pmml2oB2MvGw+5MLADcbLUh46+pgQKukTOx3KmJu7
         dlZQ==
X-Gm-Message-State: AOAM532wp7OtLm+QCeujdrqTfQ/gX+z50nAAt7LaTfLlwm4vFMQMXRJ3
        xXzo2QO1Kezpam2hKvxhB6HniC33r+BCEwR7rco=
X-Google-Smtp-Source: ABdhPJxMp7FKz+r2AJyqETkMY6V+Gth+N3W3eVaINalzuhYCT6g/wfkKLMzyA0RGFV5VXvtJR1td9LXyHbyZSMaqZdw=
X-Received: by 2002:aca:5f83:: with SMTP id t125mr2066477oib.138.1623260459266;
 Wed, 09 Jun 2021 10:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210608193902.55060-1-cgzones@googlemail.com>
In-Reply-To: <20210608193902.55060-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Jun 2021 13:40:48 -0400
Message-ID: <CAP+JOzQY9VPK=wZYU=9n-MB9H7bMMsC1iV3BvAbWTQteH=BDCQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: quote paths in CIL conversion
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 3:46 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> When generating CIL policy from kernel or module policy quote paths,
> which are allowed to contain spaces, in the statements `genfscon` and
> `devicetreecon`.
>
> Reported by LuK1337 while building policy for Android via IRC.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c | 4 ++--
>  libsepol/src/module_to_cil.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 989aacde..30a27bf5 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2654,7 +2654,7 @@ static int write_genfscon_rules_to_cil(FILE *out, s=
truct policydb *pdb)
>                                 goto exit;
>                         }
>
> -                       rc =3D strs_create_and_add(strs, "(genfscon %s %s=
 %s)", 3,
> +                       rc =3D strs_create_and_add(strs, "(genfscon %s \"=
%s\" %s)", 3,
>                                                  fstype, name, ctx);
>                         free(ctx);
>                         if (rc !=3D 0) {
> @@ -3115,7 +3115,7 @@ static int write_xen_devicetree_rules_to_cil(FILE *=
out, struct policydb *pdb)
>                         goto exit;
>                 }
>
> -               sepol_printf(out, "(devicetreecon %s %s)\n", name, ctx);
> +               sepol_printf(out, "(devicetreecon \"%s\" %s)\n", name, ct=
x);
>
>                 free(ctx);
>         }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 496693f4..19c7c65c 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2963,7 +2963,7 @@ static int genfscon_to_cil(struct policydb *pdb)
>
>         for (genfs =3D pdb->genfs; genfs !=3D NULL; genfs =3D genfs->next=
) {
>                 for (ocon =3D genfs->head; ocon !=3D NULL; ocon =3D ocon-=
>next) {
> -                       cil_printf("(genfscon %s %s ", genfs->fstype, oco=
n->u.name);
> +                       cil_printf("(genfscon %s \"%s\" ", genfs->fstype,=
 ocon->u.name);
>                         context_to_cil(pdb, &ocon->context[0]);
>                         cil_printf(")\n");
>                 }
> --
> 2.32.0
>
