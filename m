Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A65C7618E
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjDXTNF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXTNE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 15:13:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910A7A99
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:12:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso8375814a12.0
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682363568; x=1684955568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQOuYXIDx3snxH44eUGb6Wnk940LG0Aq1IEr+cRoa+I=;
        b=JYJXDuBuBHYV32EkipK3KGx9IpA4lUAz2n/OpYbUkB6bX5FtwiI05MRUi+oZC1K82R
         YjDLeF3GyCr6yEjlcftd3m3qi1ipWMqCRtHFNsBF6t5fxtQx2mj7bPhFJPANabuOY16t
         SDAKRIITW/BODwJIwPOZA5Xe/KwM1L+mNUFds7NOrtCWtDZBFQPpzlZz2cbgomGShqTI
         Zw4o/+RXuwBN/bV/zG/oJR9ZaV6Zm38iNtcjuodhclFv4u8PkXl4tMqoinRaaBWydU9r
         Ltfonh2MuBNEnCWmr848RF+JRv8gxg2F42qOwM76sHlp/VlLpXiXXqKr3z+e9lqekGmg
         psCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682363568; x=1684955568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQOuYXIDx3snxH44eUGb6Wnk940LG0Aq1IEr+cRoa+I=;
        b=T7cC90d3wEPeMAWBWPV+tvGhnLTLxbYqVmOFIr94Td/sVgMVNJIyKFweNeQkt/I5Vm
         bd2BnepugQ6XEbdQJPJVVfhN7XFKG3VqOQ+2SH0eFDwrwC+R8sWQA56lVa1M2srpfJjP
         bQvAz//FZnoT42ssCeYvTo6xpRayC49mFxuuDldE6+p0tVNQL4hob4kqWwVQ10k8c9NA
         /Nxgw/HcB7BSqut34Szvyt9bf3HEKbhLsjBBAbBlklq2K6YtDvT0alXfHqUFoWXIngKh
         9HThH10e5dhH9GAMgQrp+NE2X7u3FofLwKBfcFo7HpRmoax6lAi58j6BrduImTajyOTN
         XJ/g==
X-Gm-Message-State: AAQBX9dU0FBWJ8jVl8YLqBtxagnzBhpABjcwooFo50kYkCMBGDaWJ05T
        cS8GckxbBz67wpsygXzYoqaQz4qEbVeVRUaK6cg=
X-Google-Smtp-Source: AKy350Zd8TTqIsmW6m8XbNUzI6t7PO1MwAG9XrBYxDGftbCQkm7ASppILg8copUhFZEMn0iBJoLEZeuZVZKXHEaeYpY=
X-Received: by 2002:aa7:cd71:0:b0:504:8bff:8285 with SMTP id
 ca17-20020aa7cd71000000b005048bff8285mr13254920edb.14.1682363567968; Mon, 24
 Apr 2023 12:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-1-cgzones@googlemail.com> <20230331173442.101678-3-cgzones@googlemail.com>
In-Reply-To: <20230331173442.101678-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Apr 2023 15:12:36 -0400
Message-ID: <CAP+JOzRkrwxuizU_pWY=X5yOkXBki=Twv=VEHcRsirA_BX4r5Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] checkpolicy/dismod: misc improvements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 1:37=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * fix minus self formatting in neverallow rules, avoiding `~ - self`
>
> * show neverallow and neverallowxperm rules
>
> * whitespace improvements in output
>   - avoid duplicate whitespaces before permission list, since
>     sepol_av_to_string() already adds a trailing one
>   - avoid duplicate whitespace after wildcard type
>   - unify indentation for xperm rules
>
> * drop unused global variables
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/test/dismod.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index a2d74d42..ebc1eec3 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -54,11 +54,8 @@
>  #define DISPLAY_AVBLOCK_FILENAME_TRANS 7
>
>  static policydb_t policydb;
> -extern unsigned int ss_initialized;
>
> -int policyvers =3D MOD_POLICYDB_VERSION_BASE;
> -
> -static const char *symbol_labels[9] =3D {
> +static const char *const symbol_labels[9] =3D {
>         "commons",
>         "classes", "roles  ", "types  ", "users  ", "bools  ",
>         "levels ", "cats   ", "attribs"
> @@ -86,12 +83,12 @@ static void render_access_bitmap(ebitmap_t * map, uin=
t32_t class,
>  {
>         unsigned int i;
>         char *perm;
> -       fprintf(fp, "{");
> +       fprintf(fp, " {");
>         for (i =3D ebitmap_startbit(map); i < ebitmap_length(map); i++) {
>                 if (ebitmap_get_bit(map, i)) {
>                         perm =3D sepol_av_to_string(p, class, UINT32_C(1)=
 << i);
>                         if (perm)
> -                               fprintf(fp, " %s", perm);
> +                               fprintf(fp, "%s", perm);
>                 }
>         }
>         fprintf(fp, " }");
> @@ -117,7 +114,7 @@ static int display_type_set(type_set_t * set, uint32_=
t flags, policydb_t * polic
>         unsigned int i, num_types;
>
>         if (set->flags & TYPE_STAR) {
> -               fprintf(fp, " * ");
> +               fprintf(fp, " *");
>                 return 0;
>         } else if (set->flags & TYPE_COMP) {
>                 fprintf(fp, " ~");
> @@ -149,7 +146,7 @@ static int display_type_set(type_set_t * set, uint32_=
t flags, policydb_t * polic
>         }
>
>         if (num_types > 1)
> -               fprintf(fp, "{");
> +               fprintf(fp, " {");
>

This causes a problem with a type set using "~". It gets displayed
with a space between the "~" and the "{".

Thanks,
Jim


>         for (i =3D ebitmap_startbit(&set->types); i < ebitmap_length(&set=
->types);
>              i++) {
> @@ -170,7 +167,10 @@ static int display_type_set(type_set_t * set, uint32=
_t flags, policydb_t * polic
>         }
>
>         if (flags & RULE_NOTSELF) {
> -               fprintf(fp, " -self");
> +               if (set->flags & TYPE_COMP)
> +                       fprintf(fp, " self");
> +               else
> +                       fprintf(fp, " -self");
>         }
>
>         if (num_types > 1)
> @@ -234,6 +234,9 @@ static int display_avrule(avrule_t * avrule, policydb=
_t * policy,
>                 if (avrule->specified & AVRULE_DONTAUDIT) {
>                         fprintf(fp, "  dontaudit");
>                 }
> +               if (avrule->specified & AVRULE_NEVERALLOW) {
> +                       fprintf(fp, "  neverallow");
> +               }
>         } else if (avrule->specified & AVRULE_TYPE) {
>                 if (avrule->specified & AVRULE_TRANSITION) {
>                         fprintf(fp, "  type_transition");
> @@ -244,15 +247,15 @@ static int display_avrule(avrule_t * avrule, policy=
db_t * policy,
>                 if (avrule->specified & AVRULE_CHANGE) {
>                         fprintf(fp, "  type_change");
>                 }
> -       } else if (avrule->specified & AVRULE_NEVERALLOW) {
> -               fprintf(fp, "  neverallow");
>         } else if (avrule->specified & AVRULE_XPERMS) {
>                 if (avrule->specified & AVRULE_XPERMS_ALLOWED)
> -                       fprintf(fp, "allowxperm ");
> +                       fprintf(fp, "  allowxperm");
>                 else if (avrule->specified & AVRULE_XPERMS_AUDITALLOW)
> -                       fprintf(fp, "auditallowxperm ");
> +                       fprintf(fp, "  auditallowxperm");
>                 else if (avrule->specified & AVRULE_XPERMS_DONTAUDIT)
> -                       fprintf(fp, "dontauditxperm ");
> +                       fprintf(fp, "  dontauditxperm");
> +               else if (avrule->specified & AVRULE_XPERMS_NEVERALLOW)
> +                       fprintf(fp, "  neverallowxperm");
>         } else {
>                 fprintf(fp, "     ERROR: no valid rule type specified\n")=
;
>                 return -1;
> @@ -560,7 +563,7 @@ static int display_scope_index(scope_index_t * indice=
s, policydb_t * p,
>                                                                      p, o=
ut_fp);
>                                         } else {
>                                                 fprintf(out_fp,
> -                                                       "<no perms known>=
");
> +                                                       " <no perms known=
>");
>                                         }
>                                 }
>                         }
> --
> 2.40.0
>
