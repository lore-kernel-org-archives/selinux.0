Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DCC197A0
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 18:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKTSMY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 13:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKTSMX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 13:12:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADFBA
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 10:12:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50930f126b1so6048024e87.3
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700503937; x=1701108737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2AOAuSgAF6ykSPOrgrvW/imlQ1EOpeTeWmLMAJIGVE=;
        b=WtHBPIXKOEgLx/1Zgf1aQTkns9JUUkA/mQQRm60tAogiXMWLb4O/j5oAyC09L2KLCr
         /2o0IdiefPNzNEaZHb+05Pysc8knR27oIs1yckFwUvJNmD6mOeyqN42PCV1PxuSSa6ml
         OREyvNBhqToRyRmhY7DKEQnv7JuAn/nd/I2C5fYXFSVDkrwrgmv2M7vjR2vcYbUzPPtR
         3o77OxWoTC8dU6EzSSnAx+GyaNFwMCxARr9i5zd5U0OjyG5T6esKSoFT7LIwfQL/gPPD
         lso4A00wOf6uktSsIYd9gSaCDEwwqrBDZgDC60zB3SWuc/aPZcVFQ0l8mWmg1KLF/gJw
         gCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503937; x=1701108737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2AOAuSgAF6ykSPOrgrvW/imlQ1EOpeTeWmLMAJIGVE=;
        b=IR3lQ3cex/4O9nvw9UeevTX/xIPVnGDuEGigThrYqJt6HJHfDkV9/3FMmbNsS2Q+cp
         YrbLkwUzObP1QGrodOyvSYub0b3OAsN7uU2u60T952z27QfBBcLbSm8ypEPyaJUwK2aT
         nrB/dOpHFhuD99gqLrPuoG+sVakzSC66mF56oX/AEmQBrVLF/i9u3Z4RipPl4xQ4tVNi
         GVt1QnDXSig23eK2cz6IE52XN9bcHkvjgoWzBBvO5D1/811wswOwOT/IzAkZCqFpkn1M
         1MWZXO/pIjE21YSD62dgEPIPu5hirPoLQwFWP2gHhSkxAnnCxhUR2eKHvySMIbhMuPGc
         Imbg==
X-Gm-Message-State: AOJu0YzJUqwbqMzmQ/o2C98mHGWfvl+uxCFEErnN53UT+WCOxxsqm7Pl
        WeR5cy35Hnc+HdJvXtDPXZTQynsjreZD0hwIeqO0R7DPiUc=
X-Google-Smtp-Source: AGHT+IFzwrjJ+/7f9RokPlCqm5S7k7b0njbC07tpkOJ3HDywspbT8NtWprE4hlfm2pGrGRUS/Lw1gwyuLqD3uzxM1xw=
X-Received: by 2002:ac2:4c81:0:b0:4fb:7559:aea3 with SMTP id
 d1-20020ac24c81000000b004fb7559aea3mr4982497lfl.39.1700503937153; Mon, 20 Nov
 2023 10:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20231120154735.450915-1-cgzones@googlemail.com> <20231120154735.450915-2-cgzones@googlemail.com>
In-Reply-To: <20231120154735.450915-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 20 Nov 2023 13:12:05 -0500
Message-ID: <CAP+JOzRVwnMBHw6B8_0L-E7EJi5OobHBwLYYVhf5kTaB_1OA3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: avoid fixed sized format buffer for xperms
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 20, 2023 at 10:48=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> An extended access vector rule can consist of many individual ranges of
> permissions.  Use a dynamically growing sized buffer for formatting such
> rules instead of a static buffer to avoid write failures due to
> truncations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    reset in_range on retry
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/test/dismod.c     |  9 +++++-
>  checkpolicy/test/dispol.c     | 10 +++++-
>  libsepol/src/assertion.c      |  7 ++++-
>  libsepol/src/kernel_to_conf.c |  9 +++---
>  libsepol/src/util.c           | 57 +++++++++++++++++++++++------------
>  5 files changed, 66 insertions(+), 26 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index fa7117f5..9f4a669b 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -347,6 +347,7 @@ static int display_avrule(avrule_t * avrule, policydb=
_t * policy,
>                 display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1=
, "");
>         } else if (avrule->specified & AVRULE_XPERMS) {
>                 avtab_extended_perms_t xperms;
> +               char *perms;
>                 int i;
>
>                 if (avrule->xperms->specified =3D=3D AVRULE_XPERMS_IOCTLF=
UNCTION)
> @@ -362,7 +363,13 @@ static int display_avrule(avrule_t * avrule, policyd=
b_t * policy,
>                 for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
>                         xperms.perms[i] =3D avrule->xperms->perms[i];
>
> -               fprintf(fp, "%s", sepol_extended_perms_to_string(&xperms)=
);
> +               perms =3D sepol_extended_perms_to_string(&xperms);
> +               if (!perms) {
> +                       fprintf(fp, "     ERROR: failed to format xperms\=
n");
> +                       return -1;
> +               }
> +               fprintf(fp, "%s", perms);
> +               free(perms);
>         }
>
>         fprintf(fp, ";\n");
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index b567ce77..944ef7ec 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -196,6 +196,8 @@ static int render_av_rule(avtab_key_t * key, avtab_da=
tum_t * datum, uint32_t wha
>                         fprintf(fp, ";\n");
>                 }
>         } else if (key->specified & AVTAB_XPERMS) {
> +               char *perms;
> +
>                 if (key->specified & AVTAB_XPERMS_ALLOWED)
>                         fprintf(fp, "allowxperm ");
>                 else if (key->specified & AVTAB_XPERMS_AUDITALLOW)
> @@ -203,7 +205,13 @@ static int render_av_rule(avtab_key_t * key, avtab_d=
atum_t * datum, uint32_t wha
>                 else if (key->specified & AVTAB_XPERMS_DONTAUDIT)
>                         fprintf(fp, "dontauditxperm ");
>                 render_key(key, p, fp);
> -               fprintf(fp, "%s;\n", sepol_extended_perms_to_string(datum=
->xperms));
> +               perms =3D sepol_extended_perms_to_string(datum->xperms);
> +               if (!perms) {
> +                       fprintf(fp, "     ERROR: failed to format xperms\=
n");
> +                       return -1;
> +               }
> +               fprintf(fp, "%s;\n", perms);
> +               free(perms);
>         } else {
>                 fprintf(fp, "     ERROR: no valid rule type specified\n")=
;
>                 return -1;
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index b6ac4cfe..6de7d031 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -178,15 +178,20 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
>                                 rc =3D check_extended_permissions(avrule-=
>xperms, xperms);
>                                 /* failure on the extended permission che=
ck_extended_permissions */
>                                 if (rc) {
> +                                       char *permstring;
> +
>                                         extended_permissions_violated(&er=
ror, avrule->xperms, xperms);
> +                                       permstring =3D sepol_extended_per=
ms_to_string(&error);
> +
>                                         ERR(handle, "neverallowxperm on l=
ine %lu of %s (or line %lu of %s) violated by\n"
>                                                         "allowxperm %s %s=
:%s %s;",
>                                                         avrule->source_li=
ne, avrule->source_filename, avrule->line, policy_name(p),
>                                                         p->p_type_val_to_=
name[i],
>                                                         p->p_type_val_to_=
name[j],
>                                                         p->p_class_val_to=
_name[curperm->tclass - 1],
> -                                                       sepol_extended_pe=
rms_to_string(&error));
> +                                                       permstring ?: "<f=
ormat-failure>");
>
> +                                       free(permstring);
>                                         errors++;
>                                 }
>                         }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index b0ae16d9..b5b530d6 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1683,7 +1683,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>         uint32_t data =3D datum->data;
>         type_datum_t *type;
>         const char *flavor, *src, *tgt, *class, *perms, *new;
> -       char *rule =3D NULL;
> +       char *rule =3D NULL, *permstring;
>
>         switch (0xFFF & key->specified) {
>         case AVTAB_ALLOWED:
> @@ -1738,13 +1738,14 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
>                 rule =3D create_str("%s %s %s:%s { %s };", 5,
>                                   flavor, src, tgt, class, perms+1);
>         } else if (key->specified & AVTAB_XPERMS) {
> -               perms =3D sepol_extended_perms_to_string(datum->xperms);
> -               if (perms =3D=3D NULL) {
> +               permstring =3D sepol_extended_perms_to_string(datum->xper=
ms);
> +               if (permstring =3D=3D NULL) {
>                         ERR(NULL, "Failed to generate extended permission=
 string");
>                         goto exit;
>                 }
>
> -               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, perms);
> +               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, permstring);
> +               free(permstring);
>         } else {
>                 new =3D pdb->p_type_val_to_name[data - 1];
>
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index 0a2edc85..2f877920 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -132,21 +132,32 @@ char *sepol_extended_perms_to_string(avtab_extended=
_perms_t *xperms)
>         uint16_t low_bit;
>         uint16_t low_value;
>         unsigned int bit;
> -       unsigned int in_range =3D 0;
> -       static char xpermsbuf[2048];
> -       char *p;
> -       int len, xpermslen =3D 0;
> -       xpermsbuf[0] =3D '\0';
> -       p =3D xpermsbuf;
> +       unsigned int in_range;
> +       char *buffer =3D NULL, *p;
> +       int len;
> +       size_t remaining, size =3D 128;
>
>         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
>                 && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
>                 return NULL;
>
> -       len =3D snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { ");
> +retry:
> +       size *=3D 2;
> +       if (size =3D=3D 0)
> +               goto err;
> +       p =3D realloc(buffer, size);
> +       if (!p)
> +               goto err;
> +       buffer =3D p;
> +       remaining =3D size;
> +
> +       len =3D snprintf(p, remaining, "ioctl { ");
> +       if (len < 0 || (size_t)len >=3D remaining)
> +               goto err;
>         p +=3D len;
> -       xpermslen +=3D len;
> +       remaining -=3D len;
>
> +       in_range =3D 0;
>         for (bit =3D 0; bit < sizeof(xperms->perms)*8; bit++) {
>                 if (!xperm_test(bit, xperms->perms))
>                         continue;
> @@ -165,35 +176,43 @@ char *sepol_extended_perms_to_string(avtab_extended=
_perms_t *xperms)
>                         value =3D xperms->driver<<8 | bit;
>                         if (in_range) {
>                                 low_value =3D xperms->driver<<8 | low_bit=
;
> -                               len =3D snprintf(p, sizeof(xpermsbuf) - x=
permslen, "0x%hx-0x%hx ", low_value, value);
> +                               len =3D snprintf(p, remaining, "0x%hx-0x%=
hx ", low_value, value);
>                         } else {
> -                               len =3D snprintf(p, sizeof(xpermsbuf) - x=
permslen, "0x%hx ", value);
> +                               len =3D snprintf(p, remaining, "0x%hx ", =
value);
>                         }
>                 } else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) =
{
>                         value =3D bit << 8;
>                         if (in_range) {
>                                 low_value =3D low_bit << 8;
> -                               len =3D snprintf(p, sizeof(xpermsbuf) - x=
permslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
> +                               len =3D snprintf(p, remaining, "0x%hx-0x%=
hx ", low_value, (uint16_t) (value|0xff));
>                         } else {
> -                               len =3D snprintf(p, sizeof(xpermsbuf) - x=
permslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> +                               len =3D snprintf(p, remaining, "0x%hx-0x%=
hx ", value, (uint16_t) (value|0xff));
>                         }
>
>                 }
>
> -               if (len < 0 || (size_t) len >=3D (sizeof(xpermsbuf) - xpe=
rmslen))
> -                       return NULL;
> +               if (len < 0)
> +                       goto err;
> +               if ((size_t) len >=3D remaining)
> +                       goto retry;
>
>                 p +=3D len;
> -               xpermslen +=3D len;
> +               remaining -=3D len;
>                 if (in_range)
>                         in_range =3D 0;
>         }
>
> -       len =3D snprintf(p, sizeof(xpermsbuf) - xpermslen, "}");
> -       if (len < 0 || (size_t) len >=3D (sizeof(xpermsbuf) - xpermslen))
> -               return NULL;
> +       len =3D snprintf(p, remaining, "}");
> +       if (len < 0)
> +               goto err;
> +       if ((size_t) len >=3D remaining)
> +               goto retry;
> +
> +       return buffer;
>
> -       return xpermsbuf;
> +err:
> +       free(buffer);
> +       return NULL;
>  }
>
>  /*
> --
> 2.42.0
>
