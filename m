Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76574C433EF
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 22:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383321AbhLCWJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383318AbhLCWJy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 17:09:54 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3FC061751
        for <selinux@vger.kernel.org>; Fri,  3 Dec 2021 14:06:30 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u74so8405608oie.8
        for <selinux@vger.kernel.org>; Fri, 03 Dec 2021 14:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5/YuPspdrBxo8HGg7DLdhGoLRt38+97LFfFAmJ+Zt3g=;
        b=JUJ65zx3umtyz193UR0Pm4FI31QM9nggH7d7QPCeCr5PlX6R/2kfpXLKKc+UfV10BP
         3e8gb/L33u+WjzZBHgKQNbJ2cFnzYVQsT3npTmuHxr9aMnCW4jelD1LVh9g2Uwg3gwXo
         fzOIlqA8SA1AgULugQovuvOQ3VFOIg4bHbQbzQRAClYx9Yntpjy8j9ETmbMYasPVpwyi
         rU5bu39OrobtveeAE5f9ML+L3eP6Pd+09AHiCO8NSr1ir126vJ7vuYydLpIhC5niM2Hl
         QU6lRGBBAljS02fCeYvRWo8hSIOcSW1P798OI0Vt5GnL8ledGERu+0+RjaXY92lkeW1P
         Z3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5/YuPspdrBxo8HGg7DLdhGoLRt38+97LFfFAmJ+Zt3g=;
        b=cnme+964X541gKcFnNmafQ45ZgkeC8L04VkUCRqwFGOAwXOv5ySJ3xgk4oJoO0vmOQ
         HNc6KOholnEPwPcARLjeBztqGoZhDsrdDKrELwWAOadbbDmMOK2NqvJJftlIsaUYCgql
         YzGbStwbJnkA5XXfL+TAiNNqEivTMShFbu04jnPwtxcQBrVDrpUOwGhDZY8a5VRV1vkP
         IW6Svdm0nV7THLHl8QkaJCpzsHlQYYyesiX1BJx2fnLzDsopyLmvku/Erz+dcJFxH6HY
         c914ceuryBAHCvqsDARsSj5SGHepHWYt4eKKduuncVGntzo5xyCLiQ4CV9phRUFgDQZw
         WZlQ==
X-Gm-Message-State: AOAM532yfpJoJ5cuDcvU9iSKkSDIkBVcUppheP/6U0tF4JKBEA/3C+Vy
        21Dn0ebdxOo5Q9O1DjY43FAgdKi3Rb/L8YTUAk6nK9pDGqQ=
X-Google-Smtp-Source: ABdhPJy0QE+qrPqBYo+DucLBSGVZ3c9MRhODOBL9zfD/wv5a491lYPyZr3z6Oo1O9J+/udJJAAJVX2Iv16VYHDoDtjw=
X-Received: by 2002:a05:6808:120b:: with SMTP id a11mr12392387oil.128.1638569189638;
 Fri, 03 Dec 2021 14:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com> <20211124190815.12757-2-cgzones@googlemail.com>
In-Reply-To: <20211124190815.12757-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 3 Dec 2021 17:06:18 -0500
Message-ID: <CAP+JOzTcWXTu1O8t50XX3vMjabY6Vsmb9WBRiLryKTMapsw8Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] libsepol: add not-self neverallow support
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
> Add support for not-self neverallow rules. These do not trigger on allow
> rules where the source type is exactly equal to the target type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   - do not change the value of RULE_SELF
> ---
>  libsepol/include/sepol/policydb/policydb.h |  3 +-
>  libsepol/src/assertion.c                   | 36 ++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 4bf9f05d..11637fe8 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -285,7 +285,8 @@ typedef struct avrule {
>  #define AVRULE_XPERMS  (AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW=
 | \
>                                 AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_N=
EVERALLOW)
>         uint32_t specified;
> -#define RULE_SELF 1
> +#define RULE_SELF       (1U << 0)
> +#define RULE_NOTSELF    (1U << 1)
>         uint32_t flags;
>         type_set_t stypes;
>         type_set_t ttypes;
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index dd2749a0..efa136c8 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -241,7 +241,7 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>         if (rc)
>                 goto oom;
>
> -       if (avrule->flags =3D=3D RULE_SELF) {
> +       if (avrule->flags & RULE_SELF) {
>                 rc =3D ebitmap_and(&matches, &p->attr_type_map[k->source_=
type - 1], &p->attr_type_map[k->target_type - 1]);
>                 if (rc)
>                         goto oom;
> @@ -268,6 +268,8 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>
>                 ebitmap_for_each_positive_bit(&src_matches, snode, i) {
>                         ebitmap_for_each_positive_bit(&tgt_matches, tnode=
, j) {
> +                               if ((avrule->flags & RULE_NOTSELF) && i =
=3D=3D j)
> +                                       continue;
>                                 if (avrule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
>                                         a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, avrule,
>                                                                          =
               i, j, cp, perms, k, avtab);
> @@ -402,7 +404,7 @@ static int check_assertion_extended_permissions(avrul=
e_t *avrule, avtab_t *avtab
>         if (rc)
>                 goto oom;
>
> -       if (avrule->flags =3D=3D RULE_SELF) {
> +       if (avrule->flags & RULE_SELF) {
>                 rc =3D ebitmap_and(&matches, &p->attr_type_map[k->source_=
type - 1],
>                                 &p->attr_type_map[k->target_type - 1]);
>                 if (rc)
> @@ -418,6 +420,18 @@ static int check_assertion_extended_permissions(avru=
le_t *avrule, avtab_t *avtab
>                 }
>         }
>
> +       if (avrule->flags & RULE_NOTSELF) {
> +               rc =3D ebitmap_and(&matches, &p->attr_type_map[k->source_=
type - 1], &p->attr_type_map[k->target_type - 1]);
> +               if (rc)
> +                       goto oom;
> +               rc =3D ebitmap_and(&self_matches, &avrule->ttypes.types, =
&matches);
> +               if (rc)
> +                       goto oom;
> +               rc =3D ebitmap_subtract(&tgt_matches, &self_matches);
> +               if (rc)
> +                       goto oom;
> +       }
> +
>         if (ebitmap_is_empty(&tgt_matches))
>                 goto exit;
>

Something is not right with how it is working with extended permissions.

I am using these types rules with the following examples.
type TYPE1;
type TYPE2;
type TYPE3;
typeattribute TYPE1 TATTR1, TATTR2;
typeattribute TYPE2 TATTR1, TATTR2;
typeattribute TYPE3 TATTR1;


For normal extended permissions.

These rules give an assertion failure as expected.
allow TATTR1 TATTR1 : CLASS4 ioctl;
neverallowxperm TYPE1 self : CLASS4 ioctl 0x9411;

These rules do not, again, as expected.
allow TATTR1 TATTR1 : CLASS4 ioctl;
allowxperm TATTR1 TATTR1 : CLASS4 ioctl 0x9401;
neverallowxperm TYPE1 self : CLASS4 ioctl 0x9411;

For the not-self extended permissions.

These rules give an assertion failure, but they shouldn't.
allow TATTR1 TATTR1 : CLASS5 ioctl;
allowxperm TATTR1 TATTR1 : CLASS5 ioctl 0x9501;
neverallowxperm TYPE1 ~self : CLASS5 ioctl 0x9511;

libsepol.report_assertion_extended_permissions: neverallowxperm on
line 153 of policy.conf (or line 153 of policy.conf) violated by
allow TYPE1 TYPE2:CLASS5 { ioctl };
libsepol.report_assertion_extended_permissions: neverallowxperm on
line 153 of policy.conf (or line 153 of policy.conf) violated by
allow TYPE1 TYPE3:CLASS5 { ioctl };


Thanks,
Jim


> @@ -463,7 +477,7 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>         if (rc =3D=3D 0)
>                 goto exit;
>
> -       if (avrule->flags =3D=3D RULE_SELF) {
> +       if (avrule->flags & RULE_SELF) {
>                 /* If the neverallow uses SELF, then it is not enough tha=
t the
>                  * neverallow's source matches the src and tgt of the rul=
e being checked.
>                  * It must match the same thing in the src and tgt, so AN=
D the source
> @@ -479,6 +493,22 @@ static int check_assertion_avtab_match(avtab_key_t *=
k, avtab_datum_t *d, void *a
>                 ebitmap_destroy(&match);
>         }
>
> +       if (avrule->flags & RULE_NOTSELF) {
> +               ebitmap_t match;
> +               rc =3D ebitmap_cpy(&match, &p->attr_type_map[k->source_ty=
pe - 1]);
> +               if (rc) {
> +                       ebitmap_destroy(&match);
> +                       goto oom;
> +               }
> +               rc =3D ebitmap_subtract(&match, &p->attr_type_map[k->targ=
et_type - 1]);
> +               if (rc) {
> +                       ebitmap_destroy(&match);
> +                       goto oom;
> +               }
> +               rc2 =3D ebitmap_match_any(&avrule->ttypes.types, &match);
> +               ebitmap_destroy(&match);
> +       }
> +
>         /* neverallow may have tgts even if it uses SELF */
>         rc =3D ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map=
[k->target_type -1]);
>         if (rc =3D=3D 0 && rc2 =3D=3D 0)
> --
> 2.34.0
>
