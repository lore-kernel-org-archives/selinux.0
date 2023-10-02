Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD60E784B0
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjJBROK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBROJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:14:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE698A4
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:14:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so249249651fa.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266845; x=1696871645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+vJp4H6DmSwphep5LYVVRq0q6WzuucmbXdaBXwZtzI=;
        b=NpZV65HL2kCLSvahC5PVQSMM6CPbEUC21BngRJt1WowK42vaSLDTTzj3/7fhc5ktLP
         QFw4wI4lHg48B2ijpd5ThSnqBo2fcKmO4qGe28OqRlDgaWVFO258hFkJdaf4kQVZgTC+
         bm9Oew/HyRVdNMBQ1f4vkMebKjZDDnzVe4s18z0fCFe4LeEmFj7zAvK8dF/rgE1maTME
         qxYITb16G1NoX+YOv8VZUbpaZcHRQPYKlaHa4hHWlJDXxStcT9K6TSJ/n4NLsE7b0KX9
         6pN+YZmL3CVGhywUkmezgdVoWx3Czwi32popr0LUOjWKh2q9wucju7A5UNjUA17HJHbn
         HY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266845; x=1696871645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+vJp4H6DmSwphep5LYVVRq0q6WzuucmbXdaBXwZtzI=;
        b=KPH7v5YBSTuFcWe2eDN4UXNSNCzQVZ1Cinn0Ejarf1v987+Na4uVjersgj9XNVdRNW
         CXPRO4gpvezIvN9UvAvcAzI0Mgp8k8bF30JaugZ/yifgw2tuOalGQRiSPQnXn5s2ypao
         GvbWjh5rB1IZZew3HGnULtrkm2gS4cSN2548lIMl/UV2ebG14+OSmzUU/aharKM6/Thy
         RecRMGTrVZcNKP0OFmGph6U9WO+rbpg6HuTUAi5aLZE3XAiqwAC8Dk+RWP+cmKw8UAEL
         3e15pbkESpPAWSdCY0c52AgYCB2wq/AjMCcpseMQd5hbEAV9M6iIJdBECoBbhbMyzW4U
         FiZA==
X-Gm-Message-State: AOJu0YyCsL3zbGzSCccqUBvo4Jrf87YDoWzIwcSfrC2jYeBHh7W6T1db
        UBAb5rB0fBGCZLmvROehIIBKRSJ23jQjuys9gvM800ATc84=
X-Google-Smtp-Source: AGHT+IGQqUyWUO2Xybdnmulg6jGaIPcknhp4rBxTC4y6MIczhquxP7UpoEJ+f6pHw9pDmbuHsHOOjJK5KIcQU2511JU=
X-Received: by 2002:ac2:5f68:0:b0:502:fe0a:af23 with SMTP id
 c8-20020ac25f68000000b00502fe0aaf23mr8946981lfc.56.1696266844852; Mon, 02 Oct
 2023 10:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-3-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:13:53 -0400
Message-ID: <CAP+JOzR5S45N3uMkTsOu3YbEgK3pcSFJ6AZxPMtuK3R4Hwcfrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/27] libselinux: misc label cleanup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Drop unused parameter from selabel_is_digest_set().  It is only written
> to but writes to the function local copy of the pointer are void.
>
> Constify read-only handle parameter of selabel_validate() and
> compat_validate().
>
> Constify read-only from-address parameter of digest_add_specfile().
>
> Constify read-only function pointer array initfuncs.
>
> Merge malloc(3) and memset(3) calls into calloc(3).
>
> Simplify boolean assignment.
>
> Drop duplicate include file.
>
> Drop return at end of void function.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label.c          | 17 +++++++----------
>  libselinux/src/label_internal.h |  6 +++---
>  libselinux/src/label_support.c  |  4 +---
>  libselinux/src/matchpathcon.c   |  2 +-
>  4 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 586e5e5e..a2efa99c 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -45,7 +45,7 @@ typedef int (*selabel_initfunc)(struct selabel_handle *=
rec,
>                                 const struct selinux_opt *opts,
>                                 unsigned nopts);
>
> -static selabel_initfunc initfuncs[] =3D {
> +static const selabel_initfunc initfuncs[] =3D {
>         &selabel_file_init,
>         CONFIG_MEDIA_BACKEND(selabel_media_init),
>         CONFIG_X_BACKEND(selabel_x_init),
> @@ -56,8 +56,7 @@ static selabel_initfunc initfuncs[] =3D {
>
>  static inline struct selabel_digest *selabel_is_digest_set
>                                     (const struct selinux_opt *opts,
> -                                   unsigned n,
> -                                   struct selabel_digest *entry)
> +                                   unsigned n)
>  {
>         struct selabel_digest *digest =3D NULL;
>
> @@ -77,8 +76,7 @@ static inline struct selabel_digest *selabel_is_digest_=
set
>                         if (!digest->specfile_list)
>                                 goto err;
>
> -                       entry =3D digest;
> -                       return entry;
> +                       return digest;
>                 }
>         }
>         return NULL;
> @@ -121,7 +119,7 @@ static inline int selabel_is_validate_set(const struc=
t selinux_opt *opts,
>         return 0;
>  }
>
> -int selabel_validate(struct selabel_handle *rec,
> +int selabel_validate(const struct selabel_handle *rec,
>                      struct selabel_lookup_rec *contexts)
>  {
>         int rc =3D 0;
> @@ -133,7 +131,7 @@ int selabel_validate(struct selabel_handle *rec,
>         if (rc < 0)
>                 goto out;
>
> -       contexts->validated =3D 1;
> +       contexts->validated =3D true;
>  out:
>         return rc;
>  }
> @@ -215,15 +213,14 @@ struct selabel_handle *selabel_open(unsigned int ba=
ckend,
>                 goto out;
>         }
>
> -       rec =3D (struct selabel_handle *)malloc(sizeof(*rec));
> +       rec =3D (struct selabel_handle *)calloc(1, sizeof(*rec));
>         if (!rec)
>                 goto out;
>
> -       memset(rec, 0, sizeof(*rec));
>         rec->backend =3D backend;
>         rec->validating =3D selabel_is_validate_set(opts, nopts);
>
> -       rec->digest =3D selabel_is_digest_set(opts, nopts, rec->digest);
> +       rec->digest =3D selabel_is_digest_set(opts, nopts);
>
>         if ((*initfuncs[backend])(rec, opts, nopts)) {
>                 if (rec->digest)
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 782c6aa8..273a630a 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -63,7 +63,7 @@ struct selabel_digest {
>  };
>
>  extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
> -                                                   char *from_addr,
> +                                                   const char *from_addr=
,
>                                                     size_t buf_len,
>                                                     const char *path);
>  extern void digest_gen_hash(struct selabel_digest *digest);
> @@ -118,7 +118,7 @@ struct selabel_handle {
>   * Validation function
>   */
>  extern int
> -selabel_validate(struct selabel_handle *rec,
> +selabel_validate(const struct selabel_handle *rec,
>                  struct selabel_lookup_rec *contexts) ;
>
>  /*
> @@ -136,7 +136,7 @@ extern void __attribute__ ((format(printf, 1, 2)))
>         } while (0)
>
>  extern int
> -compat_validate(struct selabel_handle *rec,
> +compat_validate(const struct selabel_handle *rec,
>                 struct selabel_lookup_rec *contexts,
>                 const char *path, unsigned lineno) ;
>
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 54fd49a5..df474cba 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -10,7 +10,6 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <errno.h>
> -#include <errno.h>
>  #include "label_internal.h"
>
>  /*
> @@ -138,7 +137,6 @@ void  digest_gen_hash(struct selabel_digest *digest)
>         Sha1Finalise(&context, (SHA1_HASH *)digest->digest);
>         free(digest->hashbuf);
>         digest->hashbuf =3D NULL;
> -       return;
>  }
>
>  /**
> @@ -154,7 +152,7 @@ void  digest_gen_hash(struct selabel_digest *digest)
>   * Return %0 on success, -%1 with @errno set on failure.
>   */
>  int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
> -                                   char *from_addr, size_t buf_len,
> +                                   const char *from_addr, size_t buf_len=
,
>                                     const char *path)
>  {
>         unsigned char *tmp_buf;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index bf2da083..9a9bafb0 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -35,7 +35,7 @@ void set_matchpathcon_printf(void (*f) (const char *fmt=
, ...))
>         myprintf_compat =3D 1;
>  }
>
> -int compat_validate(struct selabel_handle *rec,
> +int compat_validate(const struct selabel_handle *rec,
>                     struct selabel_lookup_rec *contexts,
>                     const char *path, unsigned lineno)
>  {
> --
> 2.40.1
>
