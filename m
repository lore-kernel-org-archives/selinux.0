Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B461C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCAOdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCAOdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 09:33:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82032B77A
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 06:33:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ec43so54558434edb.8
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677681184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvxpQCRezBERQpIltawKBfyJ/Qi5L8/niRxQdz90JrA=;
        b=ZNHx15mevenNfzTR6HeAe5nAXEfWN7gm9tekQL9VyzQy7E9JqpSoh5k4EuaSL38EyW
         WYOdFtMG74+TI2i1dxO77xLPMU5bzYwjoIAm6oyRf43e2sZfXp3R2S0QH7zJ8J3vRawz
         w8bSESIaIvICDeV3i0+vEXmScfURWzecOIDIZ6Zs4iKgt+p9Kck3PBH/uD2nirHyI114
         hnlY/1m8D1/24VV1HrOqqIfqjAYFQoaIA4TiLpgq0oZ9ojhScCBpPJTu1g2XWGj8itjo
         N/XcFqO5tB2KSbL1ITllhLiUq4SB4FUsoJKt6kSFVWbR4VjTj/pdbww0GcFq5xj0M/Oa
         MCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvxpQCRezBERQpIltawKBfyJ/Qi5L8/niRxQdz90JrA=;
        b=Ny7iHBzzdr1r8RhJTlZta56GRko8hYYsZxChUobh5sJqk2IAbCv9pzRG7c2W8z7lXd
         hq0PVA2yJ3qRaxrLASe+7X+YZBejqarlMdX8A7ew8YeOIGf5vwYcaNvvuPxUL+VBQIMt
         9W2RJ5N13LmqJXIoWlXCmQjwMwhEVaJl9gNvOtDsIrrZT/FZesmkpBwt4oEkF17zY6vQ
         qM3CDTqo20VBQ9G2vIlWizOZZkmE11LQi1wbpryBhK/nE4dB/NhLekffv7Qv1wwiArJ5
         FzonT8TPg8vXdUx21qf3UjPNrDGIK3x3mc4jRwsKTD8CnRtYWQbKIoDi/2614ZaycrRp
         5LEQ==
X-Gm-Message-State: AO0yUKUQVSMWnwADPduBwmHZVaBOKVBMDqfTdUfsbyLjRhUydDwfbBtu
        /s+UOowItN+4dalgKZ5OfR6NP/Xk3ZurczpVF9TubDvjjq8=
X-Google-Smtp-Source: AK7set/1eKKBfD6LE8J3+eQrgjQRMuaN8W++iyqFC3Z3qJp9ch8CcFaAhvaJPM9odT6yKak20H1necgHMbZ4hgAui6s=
X-Received: by 2002:a17:906:65d4:b0:8b1:78b8:4207 with SMTP id
 z20-20020a17090665d400b008b178b84207mr3392729ejn.3.1677681183969; Wed, 01 Mar
 2023 06:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com> <20221125154952.20910-4-cgzones@googlemail.com>
In-Reply-To: <20221125154952.20910-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Mar 2023 09:32:52 -0500
Message-ID: <CAP+JOzReU_OK=DjJo_-09WK1i6Cgo7uajDQuPXnWoD+LG6FAyA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/6] checkpolicy: add not-self neverallow support
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add support for using negated or complemented self in the target type of
> neverallow rules.
>
> Some Refpolicy examples:
>
>     neverallow * ~self:{ capability cap_userns capability2 cap2_userns } =
*;
>     neverallow domain { domain -self -dockerc_t }:dir create;
>     # no violations
>
>     neverallow domain { domain -dockerc_t }:file ~{ append read_file_perm=
s write };
>
>     libsepol.report_failure: neverallow on line 584 of policy/modules/ker=
nel/kernel.te (or line 31357 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink lin=
k rename };
>     libsepol.report_failure: neverallow on line 584 of policy/modules/ker=
nel/kernel.te (or line 31357 of policy.conf) violated by allow spc_t spc_t:=
file { create };
>     libsepol.report_failure: neverallow on line 584 of policy/modules/ker=
nel/kernel.te (or line 31357 of policy.conf) violated by allow container_t =
container_t:file { create };
>     libsepol.report_failure: neverallow on line 584 of policy/modules/ker=
nel/kernel.te (or line 31357 of policy.conf) violated by allow chromium_t c=
hromium_t:file { create };
>     libsepol.report_failure: neverallow on line 584 of policy/modules/ker=
nel/kernel.te (or line 31357 of policy.conf) violated by allow spc_user_t s=
pc_user_t:file { create };
>     libsepol.report_failure: neverallow on line 582 of policy/modules/ker=
nel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:dir { create };
>
>     neverallow domain { domain -self -dockerc_t }:file ~{ append read_fil=
e_perms write };
>
>     libsepol.report_failure: neverallow on line 583 of policy/modules/ker=
nel/kernel.te (or line 31356 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink lin=
k rename };
>     libsepol.report_failure: neverallow on line 582 of policy/modules/ker=
nel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t htt=
pd_bugzilla_script_t:dir { create };
>
> Using negated self in a complement, `~{ domain -self }`, is not
> supported.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
>  checkpolicy/test/dismod.c   |  6 ++++-
>  2 files changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 41e44631..74f882bb 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2075,12 +2075,17 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (strcmp(id, "self") =3D=3D 0) {
>                         free(id);
> -                       if (add =3D=3D 0) {
> -                               yyerror("-self is not supported");
> +                       if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NEVE=
RALLOW) {
> +                               yyerror("-self is only supported in never=
allow and neverallowxperm rules");
> +                               ret =3D -1;
> +                               goto out;
> +                       }
> +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTSEL=
F);
> +                       if ((avrule->flags & RULE_SELF) && (avrule->flags=
 & RULE_NOTSELF)) {
> +                               yyerror("self and -self are mutual exclus=
ive");
>                                 ret =3D -1;
>                                 goto out;
>                         }
> -                       avrule->flags |=3D RULE_SELF;
>                         continue;
>                 }
>                 if (set_types
> @@ -2091,6 +2096,18 @@ static int define_te_avtab_xperms_helper(int which=
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
> @@ -2537,12 +2554,17 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (strcmp(id, "self") =3D=3D 0) {
>                         free(id);
> -                       if (add =3D=3D 0) {
> -                               yyerror("-self is not supported");
> +                       if (add =3D=3D 0 && which !=3D AVRULE_NEVERALLOW)=
 {
> +                               yyerror("-self is only supported in never=
allow and neverallowxperm rules");
> +                               ret =3D -1;
> +                               goto out;
> +                       }
> +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTSEL=
F);
> +                       if ((avrule->flags & RULE_SELF) && (avrule->flags=
 & RULE_NOTSELF)) {
> +                               yyerror("self and -self are mutual exclus=
ive");
>                                 ret =3D -1;
>                                 goto out;
>                         }
> -                       avrule->flags |=3D RULE_SELF;
>                         continue;
>                 }
>                 if (set_types
> @@ -2553,6 +2575,18 @@ static int define_te_avtab_helper(int which, avrul=
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
> 2.38.1
>
