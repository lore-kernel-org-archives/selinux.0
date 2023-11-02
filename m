Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA79C4167D
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKBPRq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBPRp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:17:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C51184
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:17:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1244838e87.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698938261; x=1699543061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxUdA9fWj0MUDRG66v4FR5yXEyithhoPwbYADV4TLGM=;
        b=dcBz/YJx/eqvVmGwoLT9alQiDD/AAHRoC4dXhkRo/uc6ECwlgXPJ/iPR9GZ7lSksl8
         4wXPzT4nvnlp7g1mNaOYh1t5oeUwDDZD77Zn7gYNs3rFslA6uD4FITHqldnP2Q4anVIh
         mXYyI4pw3YT6wBZ6MyGTHKEOZY6yx9gpH7yBlRE1zHsmno7pd1Y6z2v8Px94EaG2oqc3
         n3vzJCeWDtTOZaf/cte1YRL1RhewOK+9ZlMI4pezdHJ4uIxilp5f7QVRvPPWCKAAR0Yf
         lGLFBQrlnXINB5ezLsGZliatjdDGqUVs2QBE5M2+FjQELi1pWvrR41NLOHU7j+lVErr+
         ggWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698938261; x=1699543061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxUdA9fWj0MUDRG66v4FR5yXEyithhoPwbYADV4TLGM=;
        b=neY9NexYkvLVFQ82QWWc/OanyUWkeL4THFv6lr9MRqYbA2X+KbKgQpmy9+nD20FOxZ
         PCkLLVNcvptyNIfGZoww/i2jnQb2mE850J6JlTcOmB/vOMiDiiQvNDoto6TTKvuL/2DS
         Bb4mGLjJSgYmwoTFZ9364NKs5CPqN0ZALhun1/uL9Q9n0oWUowcWHXkV9zatIGNCIR1V
         ZfP+MVsZyqKFVeSxqw3s+OKmSYiy83DF3QUe0r+SG+IqxPBX916I6b308gSFzE/1UN3r
         RuD5EsNIzxutZ/UG5uzm2ctMLYDLtDStYEG4w2OD2U34ll9FOpDOwqIF8knUVllRgLZP
         Xc1A==
X-Gm-Message-State: AOJu0YyH/NRsbF2n2yldsh4/nhRH2SVHRsZ7kudGg9VDjdk+N1dRFiDg
        MV6nFLIwuDhIrhkKHLM9MRYHZogRfVZyiwCR/Nw=
X-Google-Smtp-Source: AGHT+IEQA+P9AFD6p5lWu2hPISqKqcT0GsR6Mqv96fg3Qt0IkX110czxbcKy/xIc6VKOesdPV7Wwfz2jcVXFyvirKWs=
X-Received: by 2002:a19:f70d:0:b0:509:4998:f5eb with SMTP id
 z13-20020a19f70d000000b005094998f5ebmr1772143lfe.18.1698938260940; Thu, 02
 Nov 2023 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163725.177237-1-cgzones@googlemail.com>
In-Reply-To: <20231101163725.177237-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 11:17:28 -0400
Message-ID: <CAP+JOzRUv4x1f6qTpREzDE9Edr+c-tx17EnAcnqZ12oJEC5TzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol: reject avtab entries with invalid specifier
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Neverallow avtab entries are not supported (normal and extended). Reject
> them to avoid lookup confusions via avtab_search(), e.g. when searching
> for a invalid key of AVTAB_TRANSITION|AVTAB_NEVERALLOW and the result of
> only AVTAB_NEVERALLOW has no transition value.
>
> Simplify the check for the number of specifiers by using the compiler
> popcount builtin (already used in libsepol).
>
> Reported-by: oss-fuzz (issue 60568), caused at the time by the filetrans
>              prefix proposal
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    rebase after revert of filename prefix proposal
> ---
>  libsepol/src/avtab.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 6ab49c5e..1ef5ee00 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -441,7 +441,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
>         avtab_key_t key;
>         avtab_datum_t datum;
>         avtab_extended_perms_t xperms;
> -       unsigned set;
>         unsigned int i;
>         int rc;
>
> @@ -535,13 +534,13 @@ int avtab_read_item(struct policy_file *fp, uint32_=
t vers, avtab_t * a,
>         key.target_class =3D le16_to_cpu(buf16[items++]);
>         key.specified =3D le16_to_cpu(buf16[items++]);
>
> -       set =3D 0;
> -       for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
> -               if (key.specified & spec_order[i])
> -                       set++;
> +       if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTA=
B_ENABLED)) {
> +               ERR(fp->handle, "invalid specifier");
> +               return -1;
>         }
> -       if (!set || set > 1) {
> -               ERR(fp->handle, "more than one specifier");
> +
> +       if (__builtin_popcount(key.specified & ~AVTAB_ENABLED) !=3D 1) {
> +               ERR(fp->handle, "not exactly one specifier");
>                 return -1;
>         }
>
> --
> 2.42.0
>
