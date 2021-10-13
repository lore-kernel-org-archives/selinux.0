Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7ACC433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D53261164
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhJMPlx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPlx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 11:41:53 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214DAC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:39:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o4so4338697oia.10
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OdzbtTvgl6qcZObU2gZsdi1ShY/hhV3/SOYS1aSIWYI=;
        b=kiH10yCiwdGzTxtxe1Gm8XqGtCGqX0Ow1NDgCzNppY69u534mK1dVOw7tUGdUpSZUQ
         PteFn92dtQFSAFhDFC2URAaOTNPipgcTRQlyAk5w6pynY7njQqbmJ+DM1nE2HhnTwMKr
         HDk48S2v2C7W+1rtwua0X3j37eE/U5A8ie07M8WKvObr/YqFNCTf+q8fkcKXXHYKgG6I
         3suB6923EaklLE6V4bL8ibrE8w6/2/FZ+5m+LPqY3nceFhjzHahsipLSNDLtEeaG5ied
         CMLGIoXBrUOPDXBAKNCqzYcJaRa2hqsxVdVd5RB/bxCekYKJECaw9MlakJAuiLsXcacE
         ogKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OdzbtTvgl6qcZObU2gZsdi1ShY/hhV3/SOYS1aSIWYI=;
        b=3L2ocV8wa0x8ZvXkZou//ketx7yEIlKm+E3+ONmecpSNLUyBfrUD4pbxB0cPgfJdg+
         Fu/hxYyYmipdaUhp4yf2uRJa3QczebI1s59f89NY3c7b+0u7Bzw1caJGk1IgwJGxuvTV
         q+qd/t7dP+LhCf3WHN6W3ZsucmWj1xAoxkAhzmA+MG/tke27+9VhDF1V5Q7463x95vUD
         MHfABowMlBx5NWBPPigamevGLZbquKlbgWmQljx53S4tlpXdgW6T7+OqNqYxCmOu8GXk
         cdgVwQc2J1SUkDqKTUw0lQVHhh3EYiif9HbwaZck/0bm+4k7nvD5WlVCQqUeamPs0Ubr
         pXbQ==
X-Gm-Message-State: AOAM532XF2i3LBzOo8ymDPgm6jWWdR86dnu9XNphwAyLPe3Ce8iUil7J
        nCv6kwB36TKOqq6zWJWjL3RkkyDaieOfJUd7y3as8V/x
X-Google-Smtp-Source: ABdhPJzfGXEPW/Z+S9RY2Sv+eCTukVTEzoUIUYuPHewuGJ58kQp7M8mXvE/9Uk/tqjteh0ByiLCw5hg1t3KFMi8b3QI=
X-Received: by 2002:a05:6808:545:: with SMTP id i5mr8568971oig.16.1634139589483;
 Wed, 13 Oct 2021 08:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-18-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-18-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 11:39:38 -0400
Message-ID: <CAP+JOzSY3mJJMpSq4aW3O=iAvK0S0ujFR9YF0vr2eLj4DSaWdA@mail.gmail.com>
Subject: Re: [RFC PATCH 17/35] libsepol: validate types
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
> Check all types are valid values, especially important for aliases.
>
>     =3D=3D9702=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addr=
ess 0x602000000af8 at pc 0x000000560698 bp 0x7ffcca93b9f0 sp 0x7ffcca93b9e8
>     READ of size 8 at 0x602000000af8 thread T0
>         #0 0x560697 in write_type_alias_rules_to_conf ./libsepol/src/kern=
el_to_conf.c:1424:10
>         #1 0x55af16 in sepol_kernel_policydb_to_conf ./libsepol/src/kerne=
l_to_conf.c:3131:7
>         #2 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:38:9
>         #3 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #4 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #5 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) fuzzer.o
>         #6 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #7 0x7f518b1d57ec in __libc_start_main csu/../csu/libc-start.c:33=
2:16
>         #8 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index a6ae728a..c9700399 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -348,6 +348,14 @@ static int validate_level(__attribute__ ((unused))ha=
shtab_key_t k, hashtab_datum
>         return validate_mls_level(level->level, &flavors[SYM_LEVELS], &fl=
avors[SYM_CATS]);
>  }
>
> +static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hasht=
ab_datum_t d, void *args)
> +{
> +       symtab_datum_t *s =3D d;
> +       uint32_t *nprim =3D (uint32_t *)args;
> +
> +       return !value_isvalid(s->value, *nprim);
> +}
> +
>  static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, =
validate_t flavors[])
>  {
>         unsigned int i;
> @@ -406,6 +414,9 @@ static int validate_datum_arrays(sepol_handle_t *hand=
le, policydb_t *p, validate
>                 }
>         }
>
> +       if (hashtab_map(p->p_types.table, validate_datum, &flavors[SYM_TY=
PES]))
> +               goto bad;
> +
>         if (hashtab_map(p->p_levels.table, validate_level, flavors))
>                 goto bad;
>

This should not be in this function. See the comments for patch 13.

Thanks,
Jim


> @@ -707,14 +718,6 @@ bad:
>         return -1;
>  }
>
> -static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hasht=
ab_datum_t d, void *args)
> -{
> -       symtab_datum_t *s =3D d;
> -       uint32_t *nprim =3D (uint32_t *)args;
> -
> -       return !value_isvalid(s->value, *nprim);
> -}
> -
>  static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], =
validate_t flavors[])
>  {
>         unsigned int i;
> --
> 2.33.0
>
