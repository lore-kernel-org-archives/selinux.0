Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE51C7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjFHVAP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjFHVAO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 17:00:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A752697
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 14:00:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso1330981e87.0
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686258011; x=1688850011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhBhEqU2KKGB3Tu/KFzW+hjk16Xj1KrkkOqPB4qONw0=;
        b=hWWlWm/6WeND4rsGjnWlrcILQ5JLizpqPPlndBr/o+/ZmUqoaiwZlV5HWNakBu/dL5
         I3gBcayqeozbMUIsClltAiY/O8FnqLwS5kqsJ6AWT8jx1G1s9gOjjsNll9TniO6XwK0S
         kcOqDtqnWyUVAVDknCWm3vhwJZfyeyJPqul+zAns+VJE21Nf6FhR7u74sgIeW8++9Hun
         34BSy93D+PO5mhPKQVIKxinzInH09yq9yv2ZTDcrDmSz8x5hV69nPMlEi4p7OJGx7C6w
         PSPwCHo1Lr5eoyRvqNQRf3X6HZFKngnsZLcVSEPOXpP0NEat01qPzLAvxroDhTwTmCQa
         RPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258011; x=1688850011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhBhEqU2KKGB3Tu/KFzW+hjk16Xj1KrkkOqPB4qONw0=;
        b=BHkXv5yeJTyHa2nSipvq64zIdOEmXWC8eXqB/HBP+HISUcdwCUWeFZ3oYDnEOAPsHK
         6AMikSycFr/ZrS0GErhZ4ufLp5jexg3uxpVmm7qK1Ff1okzPjqjwpSJpj2v+ObSwemIz
         QStZsevhgRyMD+hdvtHxBurTrxt8pfWTY8BwNFHwI7GRMpdSkbYs4hz6ofE/gNafcXlp
         GRLpF+MfraJcqEpeJkW4SbY43/uutnLOk6XSDGmog1l7Z0EUvNUW2Ii0q2ZBbs/BWmzf
         f//21bpv6/Z8AmmGuCyeBVWfG8hoRJIW1giPHlZ+vCvQt05ni2vW7oyGYnnSKLEwSWIK
         tOJg==
X-Gm-Message-State: AC+VfDxJPPxiVP1H3qyqRq46mZU/qVO0Wzx8m/eIjznElaoG3j6mXLQb
        Hg4ecUmspvWRGWpR33pIB94p/e4FNeVh5L9xbBzyrn32KIo=
X-Google-Smtp-Source: ACHHUZ6jBGsGZJEhSqsJhQ6tHYYwkJ5nbkeO17qSjXCigOLu9HX154faAS0kAcjAeLoub1IKA2p2/5C79xrFrfl5fZo=
X-Received: by 2002:a2e:a169:0:b0:2ac:8b00:91a2 with SMTP id
 u9-20020a2ea169000000b002ac8b0091a2mr1137828ljl.20.1686258011211; Thu, 08 Jun
 2023 14:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-3-cgzones@googlemail.com> <20230512100845.63558-1-cgzones@googlemail.com>
In-Reply-To: <20230512100845.63558-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 17:00:00 -0400
Message-ID: <CAP+JOzQdRXvEBwYVGoGy+Pmbzwr0jCF6OzSb42CRkYYU_OZ56g@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy/dismod: misc improvements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 6:12=E2=80=AFAM Christian G=C3=B6ttsche
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

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    drop extra whitespace in between ~ and { for type sets
>    (there are still some minor spacing issues like
>        neverallow  test1_t ~ self : file { read };
>    but they would need an overhaul of the common display_id() function)
> ---
>  checkpolicy/test/dismod.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 929ee308..5ec33860 100644
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
> @@ -117,10 +114,12 @@ static int display_type_set(type_set_t * set, uint3=
2_t flags, policydb_t * polic
>         unsigned int i, num_types;
>
>         if (set->flags & TYPE_STAR) {
> -               fprintf(fp, " * ");
> +               fprintf(fp, " *");
>                 return 0;
>         } else if (set->flags & TYPE_COMP) {
>                 fprintf(fp, " ~");
> +       } else {
> +               fprintf(fp, " ");
>         }
>
>         num_types =3D 0;
> @@ -170,7 +169,10 @@ static int display_type_set(type_set_t * set, uint32=
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
> @@ -234,6 +236,9 @@ static int display_avrule(avrule_t * avrule, policydb=
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
> @@ -244,15 +249,15 @@ static int display_avrule(avrule_t * avrule, policy=
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
> @@ -560,7 +565,7 @@ static int display_scope_index(scope_index_t * indice=
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
> 2.40.1
>
