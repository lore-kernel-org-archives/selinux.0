Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE6C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378F061154
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMPkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 11:40:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BFC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:38:50 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so4198020otr.7
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=feQOfcUJcRd2ufwFOtLtPmcOthKwoZX2ikg00gR7aSM=;
        b=WHxGxus/HeK9O/a+EAGjMPDK/tqPGMhHjQCKbD3GvwwagVFB2D/K++PFx5X+ueYoQp
         tDC/lgmf6ym/tsy5QUEsqyo72s0uEGSqPBfBX5Os1HzOFssoujA2QRRGnoCACD7XvL4j
         2OYDnDr8LIn9oeDn36TE6k1LX+EICiR3d8biTXDUjnvdO9UwwgU2zDEPrx2gShoULgnF
         kK/LiwpaSWHyCXI8DFFE8d2/Jn4ewGPlW3db8dI0dgYWC6SYX0a8S5X0vUbQw/27xOTL
         WjoSS3t2i4e9SIxGY21VMZ+cy9MNC6X6/tjY3I2vurOoyppP4w05jYE4lFKh4+QnNiRO
         CkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=feQOfcUJcRd2ufwFOtLtPmcOthKwoZX2ikg00gR7aSM=;
        b=p6Yu9l0EdtjxD0oC3etBmFV0qs4f+UIeoBQ6kBGjCswkv0XU3zGNrCPaVH2ITmYqgO
         G1UcdwcsVuJpKfG3mDeGW+VuO+/K9sqkaNborFAkCA9eh9V8E/UhgqjKQ/y8A/1XoPJI
         jUgehoY/zfmwBjJsGr71VUZWH781ojMpOniApeOefF7yiqyDOl5xiYm4j999KvhhBlAx
         ZRxKPvfdlQA36on4JlXHVTlBAflngelEUJ6HfdV2zYlelDuS2w2zPy7kb0M1BkHPv67X
         MMb//YQe82tFZf2agjlcgBjSgmhI5w+ocsDfWIlJyy/PM/T71jCjQS9tj11bmgSLt3Su
         KZmw==
X-Gm-Message-State: AOAM530xlffAnFbqup2j74zNBVIvEMOwwoJQlXOQ9fm4H18KOJXUuq64
        N0qsjtcuuRvVxq3URvhw6Tpmp0lw+2A9Tqt1JeD9a7XHlfs=
X-Google-Smtp-Source: ABdhPJwuxlXzQG0Lp63miKfe0igIxzXsXqdro/uLCmiY7p1VbTUKzsHGURXZ9vbWw3BeOoG3+nc3HcpTkhFIHxsOdWA=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr9499911otj.53.1634139529393;
 Wed, 13 Oct 2021 08:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-14-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-14-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 11:38:38 -0400
Message-ID: <CAP+JOzQgJK7pt39O0-sTsAMJ-NB+2DrngD3ccqy3r2=U587ePQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/35] libsepol: validate MLS levels
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Validate the level map of the policy to ensure no level refers to a non
> existent category.
>
> READ of size 8 at 0x602000000c58 thread T0
>     #0 0x568d2c in cats_ebitmap_len ./libsepol/src/kernel_to_conf.c:1003:=
14
>     #1 0x568d2c in cats_ebitmap_to_str ./libsepol/src/kernel_to_conf.c:10=
38:19
>     #2 0x55e371 in write_level_rules_to_conf ./libsepol/src/kernel_to_con=
f.c:1106:11
>     #3 0x55e371 in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.=
c:1140:7
>     #4 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to=
_conf.c:3103:7
>     #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzze=
r.c:38:9
>     #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, =
unsigned long) fuzzer.o
>     #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsig=
ned long) fuzzer.o
>     #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned c=
har const*, unsigned long)) fuzzer.o
>     #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>     #10 0x7f741d0d67ec in __libc_start_main csu/../csu/libc-start.c:332:1=
6
>     #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 5804d247..ca0dcca3 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -310,6 +310,29 @@ bad:
>         return -1;
>  }
>
> +static int validate_mls_level(mls_level_t *level, validate_t *sens, vali=
date_t *cats)
> +{
> +       if (level->sens =3D=3D 0)
> +               return 0;
> +       if (validate_value(level->sens, sens))
> +               goto bad;
> +       if (validate_ebitmap(&level->cat, cats))
> +               goto bad;
> +
> +       return 0;
> +
> +       bad:
> +       return -1;
> +}
> +
> +static int validate_level(__attribute__ ((unused))hashtab_key_t k, hasht=
ab_datum_t d, void *args)

I would prefer validate_level_datum for the name of this function.

> +{
> +       level_datum_t *level =3D d;
> +       validate_t *flavors =3D args;
> +
> +       return validate_mls_level(level->level, &flavors[SYM_LEVELS], &fl=
avors[SYM_CATS]);
> +}
> +
>  static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, =
validate_t flavors[])
>  {
>         unsigned int i;
> @@ -368,6 +391,9 @@ static int validate_datum_arrays(sepol_handle_t *hand=
le, policydb_t *p, validate
>                 }
>         }
>
> +       if (hashtab_map(p->p_levels.table, validate_level, flavors))
> +               goto bad;
> +

This should not be in validate_datum_arrays(). This also applies to
patches 17 and 33.
I think the best course would be to pull out the validate_X_datum()
calls out of validate_datum_arrays() so that the only thing being
checked is that the gaps in the X_val_to_struct arrays correspond to
any gaps in the X_val_to_name arrays.

Have a function called validate_global_symtabs() or something that
walks all of the symtabs and does the checks on the datums (including
aliases). So this hashtab_map() call would be in the function, along
with calls to hashtab_map using modified validate_X_datum() functions
that can be used with hashtab_map().

I think something like:

if (hashtab_map(p->p_commons.table, validate_common_datum, flavors))
            goto bad;
if (hashtab_map(p->p_classes.table, validate_class_datum, flavors))
            goto bad;
if (hashtab_map(p->p_roles.table, validate_role_datum, flavors))
            goto bad;
if (hashtab_map(p->p_types.table, validate_type_datum, flavors))
            goto bad;
if (hashtab_map(p->p_users.table, validate_user_datum, flavors))
            goto bad;
if (hashtab_map(p->p_bools.table, validate_bool_datum, flavors))
            goto bad;
if (hashtab_map(p->p_levels.table, validate_level_datum, flavors))
            goto bad;
if (hashtab_map(p->p_cats.table, validate_cat_datum, flavors))
            goto bad;

Thanks,
Jim
