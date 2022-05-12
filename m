Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B241C433F5
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357401AbiELR6x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357371AbiELR6s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 13:58:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF8C5E65
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:58:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w123so7353464oiw.5
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sW7hriktRNsH1wKB8Ddq3xv2eT/uN/X+U+/RsVYKGSA=;
        b=bzszQ2NIY0NgsAhVKeJ9VjFiCqLpYtDii9OVfgUlSc265XNM6C3n8XxB4zz18UEoNk
         F3JGl7D0yiNG7pJs4D5dqAcoklkRJ2dISmbZufkD4tLv2YMseWIY92bou7HhEU4aKOho
         gXrM+CM44KllEy9ISmv3Zk0PHQn3F6oDAmEMlSR+sYipr55VMEKaV0AWAyIVWGufuts/
         iShzWr6X9oy64oMHTtL8LDqoYGhyqVIX/oCrmxcS7niFzNFZ3eHydOoSaSilKK8hyM/2
         Jx2gzdPJuV2BkH4bi/FizDXZg/dPDcX1L5dN5vLDBfrUJqTkKhbpCcnKeKMlVKCgZu5x
         WnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sW7hriktRNsH1wKB8Ddq3xv2eT/uN/X+U+/RsVYKGSA=;
        b=O+ctXhmZWOoBjCxRF/IgYM2xjahHAQB6vHPzSF3NV2JddCbgE5tDaF7wW8BAu7n0xM
         gE+CRSyFzANm8w1b9B7UlK0ZI5VE/eMebPMHaG99uQAAn/6MF0L5rN2VgxfbZv9fi5aE
         OPNQ7uaEC6wpZeU+Kzjs6IC3KYA8mRcl/yR+AtcPUK4SPRppzAGtuj3l0Zg4fFOVwaL7
         D8Y3NyqtoePt29WxO45t+1p/tSaDxiyfYJoWb7nvcfborv/3U/ouz4RoWSjlSBnVG2xj
         Lz5x1nR6XMNwyZqleILC71JUOdpDyb9V85atWxCsEofxhJIkYVtxquxa74FA0/bRwnF1
         jeGA==
X-Gm-Message-State: AOAM532LcU/Us3cy4apJMIImBTzvN4Z9ihhPZCcI6ZrABNil5RYDMuqG
        /zWoArSLko6o47D2C3LDzgojSwmnON/TWkfu0hc=
X-Google-Smtp-Source: ABdhPJzjj2qlT5v23dv74SM4LCFkxayqVHsQfl/Y0qMpdZWhgV5qA1QAWlmfFlWwFvWbA1ZlsMcBkZ4wjCcyU1L2YEI=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr562765oiw.182.1652378327122; Thu, 12 May
 2022 10:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220511184132.217891-1-cgzones@googlemail.com>
In-Reply-To: <20220511184132.217891-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 13:58:36 -0400
Message-ID: <CAP+JOzQfnzb-FRB9rMOiej0YE1ESTOc51JNNdwaWhO5GdmQF_A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: preserve errno in selinux_log()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 12:02 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selinux_log() is used in many error branches, where the caller might
> expect errno to bet set, e.g. label_file.c::lookup_all():
>
>     if (match_count) {
>                 *match_count =3D 0;
>                 result =3D calloc(data->nspec, sizeof(struct spec*));
>         } else {
>                 result =3D calloc(1, sizeof(struct spec*));
>         }
>         if (!result) {
>                 selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes =
of data\n",
>                             data->nspec * sizeof(struct spec*));
>                 goto finish;
>         }
>
> Preserve errno in the macro wrapper itself, also preventing accidental
> errno modifications in client specified SELINUX_CB_LOG callbacks.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/callbacks.h              | 3 +++
>  libselinux/src/label_backends_android.c | 2 --
>  libselinux/src/label_file.h             | 2 --
>  libselinux/src/selinux_restorecon.c     | 6 +-----
>  4 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
> index f4dab157..5a4d0f8a 100644
> --- a/libselinux/src/callbacks.h
> +++ b/libselinux/src/callbacks.h
> @@ -5,6 +5,7 @@
>  #ifndef _SELINUX_CALLBACKS_H_
>  #define _SELINUX_CALLBACKS_H_
>
> +#include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -32,9 +33,11 @@ extern int
>  extern pthread_mutex_t log_mutex;
>
>  #define selinux_log(type, ...) do { \
> +       int saved_errno__ =3D errno; \
>         __pthread_mutex_lock(&log_mutex); \
>         selinux_log_direct(type, __VA_ARGS__); \
>         __pthread_mutex_unlock(&log_mutex); \
> +       errno =3D saved_errno__; \
>  } while(0)
>
>  #endif                         /* _SELINUX_CALLBACKS_H_ */
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index 66d4df2d..c2d78360 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -93,7 +93,6 @@ static int process_line(struct selabel_handle *rec,
>
>         items =3D read_spec_entries(line_buf, &errbuf, 2, &prop, &context=
);
>         if (items < 0) {
> -               items =3D errno;
>                 if (errbuf) {
>                         selinux_log(SELINUX_ERROR,
>                                     "%s:  line %u error due to: %s\n", pa=
th,
> @@ -103,7 +102,6 @@ static int process_line(struct selabel_handle *rec,
>                                     "%s:  line %u error due to: %m\n", pa=
th,
>                                     lineno);
>                 }
> -               errno =3D items;
>                 return -1;
>         }
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index b453e13f..190bc175 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -444,7 +444,6 @@ static inline int process_line(struct selabel_handle =
*rec,
>
>         items =3D read_spec_entries(line_buf, &errbuf, 3, &regex, &type, =
&context);
>         if (items < 0) {
> -               rc =3D errno;
>                 if (errbuf) {
>                         selinux_log(SELINUX_ERROR,
>                                     "%s:  line %u error due to: %s\n", pa=
th,
> @@ -454,7 +453,6 @@ static inline int process_line(struct selabel_handle =
*rec,
>                                     "%s:  line %u error due to: %m\n", pa=
th,
>                                     lineno);
>                 }
> -               errno =3D rc;
>                 return -1;
>         }
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index e6192912..ba7b3692 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1032,7 +1032,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         struct stat sb;
>         char *pathname =3D NULL, *pathdnamer =3D NULL, *pathdname, *pathb=
name;
>         char *paths[2] =3D { NULL, NULL };
> -       int fts_flags, error, sverrno;
> +       int fts_flags, error;
>         struct dir_hash_node *current =3D NULL;
>
>         if (state.flags.verbose && state.flags.progress)
> @@ -1286,18 +1286,14 @@ cleanup:
>         return error;
>
>  oom:
> -       sverrno =3D errno;
>         selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
> -       errno =3D sverrno;
>         error =3D -1;
>         goto cleanup;
>
>  realpatherr:
> -       sverrno =3D errno;
>         selinux_log(SELINUX_ERROR,
>                     "SELinux: Could not get canonical path for %s restore=
con: %m.\n",
>                     pathname_orig);
> -       errno =3D sverrno;
>         error =3D -1;
>         goto cleanup;
>
> --
> 2.36.1
>
