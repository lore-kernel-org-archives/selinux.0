Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17BC4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjKFS24 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjKFS2w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 13:28:52 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F57D57
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 10:28:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507973f3b65so6413047e87.3
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295328; x=1699900128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YqVyUsuaSYFFdWm3THPkGwSpaiK12XVocL4WW/Rq6A=;
        b=HMz8YKii2LA0b8u2G9K2fNhcvsqFmGIEdjI4UG9DPfISgaFwbSfYBginsTp9j5EuvV
         WVZPjuu0OUa1451y7MqbEMbFvqwtVs1nYT0kLCVd4eQLxvrov/QgCc5fg5upol/54sou
         EjzOSLnSmjvUVLL6xUHeiW1+kPkDyJV0XBFTHItRy2RoQAtaKzGvH9wf5K/0IVyUpA7f
         54Vm1CUutJndNe82bXDhx+jQLxCGp3w3kAA6QeUNkmVIMR4WdLTGmrXuxHizqzkyFIpW
         uBpZZxAWsr/3CAxyHVuzSfAMWEHf82X7jGMYNaz5xvMB3Fr8zJ/TPyvi5TvIQ6n47mnb
         9jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295328; x=1699900128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YqVyUsuaSYFFdWm3THPkGwSpaiK12XVocL4WW/Rq6A=;
        b=mtgxJwnTJyyh1ewyPo9tpgx/ETad6ZxzCXNDGWasqP1YwIedHrPGkJRJcA8iw4CcX8
         rPADw0NsEn1kkmZwPEoZRYnfunpCC0ou2EQeeF7PekrT8E2f/rRxcz/dDn2uWi5cYDLG
         U/3cNfrMsglpUcRWpGXwmwJZ9Q8stv8fZfA1Uy/HBBsKEgKP2AXPkeTcy28DJWjLI1Is
         nsUapVV/ND6dIGuVBDfwgsqByAmuLuQp172561POIIcxQ7yy0RiFkv35w+olN4AVhQvW
         FmDFiDp5Vl4vRCqExTW5aC/LsReTHEX6u4oLkY1ve/Yy64FsBPjea1jc71IF351yD+/h
         KM7w==
X-Gm-Message-State: AOJu0YyIfKVsEM8sJiIVgBtO0Kiap5YmJr1JlmCcP7T9YGs8bQ2t0qO2
        9gkVUzwd0UEhIY09v78zyk0ySxRm4fUtPLsk93g0GOpzRdE=
X-Google-Smtp-Source: AGHT+IHirF6I484CPM/DOjRGyLvGGSp7Nnrh42WPg/Qke4zRO338Slm+QMJKr6QxcVv7apfkS/0ZObkOUYT9l7JkW54=
X-Received: by 2002:a05:6512:11ec:b0:509:4655:d8da with SMTP id
 p12-20020a05651211ec00b005094655d8damr9528626lfs.53.1699295327762; Mon, 06
 Nov 2023 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20231101165636.184983-1-cgzones@googlemail.com> <20231101165636.184983-2-cgzones@googlemail.com>
In-Reply-To: <20231101165636.184983-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 13:28:35 -0500
Message-ID: <CAP+JOzQ9eXn_eW20j6eZMxtdC3OP2zV9Eaym4AV745eNiE=j1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libselinux: introduce reallocarray(3)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:57=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce reallocarray(3), a realloc(3) wrapper incorporating a
> multiplication overflow check.
>
> Add private implementation in case the function is not provided by the
> standard C library.
>
> Use in appropriate locations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3:
>   - use SIZE_MAX and NULL instead of -1 and 0
>   - fix indentation
>   - drop RFC and split from original patch set
> ---
>  libselinux/src/Makefile             |  6 ++++++
>  libselinux/src/get_context_list.c   |  2 +-
>  libselinux/src/matchpathcon.c       |  4 ++--
>  libselinux/src/selinux_internal.c   | 16 ++++++++++++++++
>  libselinux/src/selinux_internal.h   |  4 ++++
>  libselinux/src/selinux_restorecon.c |  3 +--
>  6 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index cf830046..7aadb822 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -108,6 +108,12 @@ ifeq (yes,$(shell printf '${H}include <string.h>\nin=
t main(void){char*d,*s;strlc
>  override CFLAGS +=3D -DHAVE_STRLCPY
>  endif
>
> +# check for reallocarray(3) availability
> +H :=3D \#
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){realloc=
array(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 &=
& echo yes))
> +override CFLAGS +=3D -DHAVE_REALLOCARRAY
> +endif
> +
>  SWIG_CFLAGS +=3D -Wno-error -Wno-unused-variable -Wno-unused-but-set-var=
iable -Wno-unused-parameter \
>                 -Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -W=
no-missing-declarations \
>                 -Wno-deprecated-declarations
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 0342823c..9dafa519 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -272,7 +272,7 @@ static int get_context_user(FILE * fp,
>                         continue;
>                 }
>                 if (security_check_context(usercon_str2) =3D=3D 0) {
> -                       new_reachable =3D realloc(*reachable, (*nreachabl=
e + 2) * sizeof(char *));
> +                       new_reachable =3D reallocarray(*reachable, *nreac=
hable + 2, sizeof(char *));
>                         if (!new_reachable) {
>                                 context_free(usercon);
>                                 rc =3D -1;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index b98849d9..e44734c3 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -96,8 +96,8 @@ static int add_array_elt(char *con)
>         if (con_array_size) {
>                 while (con_array_used >=3D con_array_size) {
>                         con_array_size *=3D 2;
> -                       tmp =3D (char **)realloc(con_array, sizeof(char*)=
 *
> -                                                    con_array_size);
> +                       tmp =3D (char **)reallocarray(con_array, con_arra=
y_size,
> +                                                   sizeof(char*));
>                         if (!tmp) {
>                                 free_array_elts();
>                                 return -1;
> diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux_i=
nternal.c
> index c2be7c0a..678bd99c 100644
> --- a/libselinux/src/selinux_internal.c
> +++ b/libselinux/src/selinux_internal.c
> @@ -1,5 +1,7 @@
>  #include "selinux_internal.h"
>
> +#include <errno.h>
> +#include <stdlib.h>
>  #include <string.h>
>
>
> @@ -16,3 +18,17 @@ size_t strlcpy(char *dest, const char *src, size_t siz=
e)
>         return ret;
>  }
>  #endif /* HAVE_STRLCPY */
> +
> +#ifndef HAVE_REALLOCARRAY
> +void *reallocarray(void *ptr, size_t nmemb, size_t size)
> +{
> +
> +       if (size && nmemb > SIZE_MAX / size) {
> +               errno =3D ENOMEM;
> +               return NULL;
> +       }
> +
> +       return realloc(ptr, nmemb * size);
> +
> +}
> +#endif /* HAVE_REALLOCARRAY */
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 06f2c038..af69ff04 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -98,4 +98,8 @@ extern int has_selinux_config ;
>  size_t strlcpy(char *dest, const char *src, size_t size);
>  #endif
>
> +#ifndef HAVE_REALLOCARRAY
> +void *reallocarray(void *ptr, size_t nmemb, size_t size);
> +#endif
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 7ef2d45d..38f10f1c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -175,8 +175,7 @@ static int add_exclude(const char *directory, bool wh=
o)
>                 return -1;
>         }
>
> -       tmp_list =3D realloc(exclude_lst,
> -                          sizeof(struct edir) * (exclude_count + 1));
> +       tmp_list =3D reallocarray(exclude_lst, exclude_count + 1, sizeof(=
struct edir));
>         if (!tmp_list)
>                 goto oom;
>
> --
> 2.42.0
>
