Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FCC433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 21:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353940AbhLCV7l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353907AbhLCV7l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 16:59:41 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0EEC061751
        for <selinux@vger.kernel.org>; Fri,  3 Dec 2021 13:56:17 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so5096414otl.8
        for <selinux@vger.kernel.org>; Fri, 03 Dec 2021 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hYtCZfldT0hgXhzf6uqSyWu+zYJZpbU0gEFoAS+NSqY=;
        b=kPT/6D6xFnFdthvz5ySfqtp7YU1OyORN1598MWXgkvkVouXCIQ9SK6dwdaj3KrqY9a
         MfbTpOCa9rM2HbWX4jApSxFJeke05wqcnKRRSTgt9a9Q+qkqJwiUFfnMg0mQxxZmMm09
         zawitQ+kug5qZL4V4g/nSkTpzqAsfbyavfP7MTBNkcp02V69yZNF/4jgFE9TXt5hnSt8
         6uc45vMt3Yn+oQ5GpU+Sv2w7JOine4iw3fYfDOjdMNP4W0kfFJD6ncb717QqssN4fOj7
         zFwksLz9RmLKLjuCDOxyG0PwWZ5M9pvt9pFxDs3h6gBxRYEjIMjg+9v+FO+w/B0vH3ad
         qnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hYtCZfldT0hgXhzf6uqSyWu+zYJZpbU0gEFoAS+NSqY=;
        b=lZZ/6cZ9ZDUmyGURTBgjA6ayMnUIxrWc/3Y+rDEAvnZJJOcrKtb2fGWfjrzbLNxZOX
         b18PS+FVKCuT6WXrDbD1aGUdjFe2sh+moFrNXifZIWK6weZL/ObVTHUh0UqqeVPPW3S5
         MYwJqjYFeaySgwc9oD6AwWWGG2+26ru80T1jBjXryt+7CnNycdJxhCIZgz757nuEsh37
         z5gu6SBKao9tCK9wAH7nT/DDdJPTg3L9Wh0QDMmbuf6QQXQLvgtHOp2IIl8jZsoGhKv3
         VlEeQEeADPnorocPzg0t0tMOLeU56OmuH4SyOqi+bytiArdn5+x88eJsTBuRDAuC8X8P
         kOkw==
X-Gm-Message-State: AOAM530MFWXL5/XBNGRksKfQbLw7luAMrxbnxpCKs2eRAWGC3c8mRoSD
        FZ9EOVutPFl+MFGEs4qvN+5BuENzRBxyto9MHoP9eQx2yg8=
X-Google-Smtp-Source: ABdhPJyFYI8IZSpI/+yVgw7ibgsA87Jw3+nP9oImBieQz5rtCuKM0tytDtEWcTgFsxCjjZrYUqTz7yhzJd6IVaWiEt8=
X-Received: by 2002:a9d:70d4:: with SMTP id w20mr18694749otj.154.1638568576624;
 Fri, 03 Dec 2021 13:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com> <20211124190815.12757-3-cgzones@googlemail.com>
In-Reply-To: <20211124190815.12757-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 3 Dec 2021 16:56:05 -0500
Message-ID: <CAP+JOzQ3hJGGDJOjL1i-YifaUhoQ3h+UPD3pO30MizaQ5GuXSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] checkpolicy: add not-self neverallow support
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 25, 2021 at 3:03 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add support for using negated or complemented self in the target type of
> neverallow rules.
>
> Some refpolicy examples:
>
>     neverallow * ~self:{ capability cap_userns capability2 cap2_userns } =
*;
>     # no violations
>
>     neverallow domain domain:file ~{ append read_file_perms write };
>
>     libsepol.report_failure: neverallow on line 565 of policy/modules/ker=
nel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink lin=
k rename };
>     libsepol.report_failure: neverallow on line 565 of policy/modules/ker=
nel/kernel.te (or line 30300 of policy.conf) violated by allow chromium_t c=
hromium_t:file { create };
>     libsepol.report_failure: neverallow on line 564 of policy/modules/ker=
nel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:dir { create };
>
>     neverallow domain { domain -self }:file ~{ append read_file_perms wri=
te };
>
>     libsepol.report_failure: neverallow on line 565 of policy/modules/ker=
nel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink lin=
k rename };
>     libsepol.report_failure: neverallow on line 564 of policy/modules/ker=
nel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:dir { create };
>
> Using negated self in a complement `~{ domain -self }` is not supported.
>

I am thinking about what to do with this patch set. If this is
valuable in checkpolicy, then I would like it in CIL as well. But CIL
obviously cannot support the above syntax.

What would be lost if we used "notself"?

We could define the behavior of "neverallow SRC notself . . ." so that
if SRC was a type, the rule would be expanded so that the target types
would be all types except SRC, and if SRC was an attribute the rules
would be expanded into multiple rules with all combinations of the
types in SRC used for the source and target except for the cases where
the source and target type would be the same.
That would make your examples work.
"neverallow * notself . . ." would expand like "neverallow * ~self . . ."
"neverallow domain notself . . ." would expand like "neverallow domain
{ domain -self } . . ."
"neverallow domain notself . . ." and "neverallow domain ~domain . .
." together would expand like "neverallow domain ~self . . ." (I
think)

What would be missing would be the ability to express "neverallow
domain { subdomain -self } . . ."

A few minor comments below.

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    - fix neverallowxperm usage
> ---
>  checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
>  checkpolicy/test/dismod.c   |  6 ++++-
>  2 files changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index d3eb6111..f27a6f33 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2067,12 +2067,17 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (strcmp(id, "self") =3D=3D 0) {
>                         free(id);
> -                       if (add =3D=3D 0) {
> -                               yyerror("-self is not supported");
> +                       if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NEVE=
RALLOW) {
> +                               yyerror("-self is only supported in never=
allowxperm rules");

"-self is only supported in neverallow and neverallowxperm rules"

> +                               ret =3D -1;
> +                               goto out;
> +                       }
> +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTSEL=
F);
> +                       if ((avrule->flags & RULE_SELF) && (avrule->flags=
 & RULE_NOTSELF)) {
> +                               yyerror("self and -self is not supported"=
);
>                                 ret =3D -1;
>                                 goto out;
>                         }
> -                       avrule->flags |=3D RULE_SELF;
>                         continue;
>                 }
>                 if (set_types
> @@ -2083,6 +2088,18 @@ static int define_te_avtab_xperms_helper(int which=
, avrule_t ** rule)
>                 }
>         }
>
> +       if ((avrule->ttypes.flags & TYPE_COMP)) {
> +               if (avrule->flags & RULE_NOTSELF) {
> +                       yyerror("-self is not supported in complements");
> +                       ret =3D -1;
> +                       goto out;
> +               }
> +               if (avrule->flags & RULE_SELF) {
> +                       avrule->flags &=3D ~RULE_SELF;
> +                       avrule->flags |=3D RULE_NOTSELF;
> +               }
> +       }
> +
>         ebitmap_init(&tclasses);
>         ret =3D read_classes(&tclasses);
>         if (ret)
> @@ -2528,12 +2545,17 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (strcmp(id, "self") =3D=3D 0) {
>                         free(id);
> -                       if (add =3D=3D 0) {
> -                               yyerror("-self is not supported");
> +                       if (add =3D=3D 0 && which !=3D AVRULE_NEVERALLOW)=
 {
> +                               yyerror("-self is only supported in never=
allow rules");

"-self is only supported in neverallow and neverallowxperm rules"

Thanks,
Jim


> +                               ret =3D -1;
> +                               goto out;
> +                       }
> +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTSEL=
F);
> +                       if ((avrule->flags & RULE_SELF) && (avrule->flags=
 & RULE_NOTSELF)) {
> +                               yyerror("self and -self is not supported"=
);
>                                 ret =3D -1;
>                                 goto out;
>                         }
> -                       avrule->flags |=3D RULE_SELF;
>                         continue;
>                 }
>                 if (set_types
> @@ -2544,6 +2566,18 @@ static int define_te_avtab_helper(int which, avrul=
e_t ** rule)
>                 }
>         }
>
> +       if ((avrule->ttypes.flags & TYPE_COMP)) {
> +               if (avrule->flags & RULE_NOTSELF) {
> +                       yyerror("-self is not supported in complements");
> +                       ret =3D -1;
> +                       goto out;
> +               }
> +               if (avrule->flags & RULE_SELF) {
> +                       avrule->flags &=3D ~RULE_SELF;
> +                       avrule->flags |=3D RULE_NOTSELF;
> +               }
> +       }
> +
>         ebitmap_init(&tclasses);
>         ret =3D read_classes(&tclasses);
>         if (ret)
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index ec2a3e9a..a2d74d42 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -124,7 +124,7 @@ static int display_type_set(type_set_t * set, uint32_=
t flags, policydb_t * polic
>         }
>
>         num_types =3D 0;
> -       if (flags & RULE_SELF) {
> +       if (flags & (RULE_SELF | RULE_NOTSELF)) {
>                 num_types++;
>         }
>
> @@ -169,6 +169,10 @@ static int display_type_set(type_set_t * set, uint32=
_t flags, policydb_t * polic
>                 fprintf(fp, " self");
>         }
>
> +       if (flags & RULE_NOTSELF) {
> +               fprintf(fp, " -self");
> +       }
> +
>         if (num_types > 1)
>                 fprintf(fp, " }");
>
> --
> 2.34.0
>
