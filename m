Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF725E7490C
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 18:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjJBSjR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJBSjQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 14:39:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74EAAC
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 11:39:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-505748580ceso7898e87.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696271951; x=1696876751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jp7VsVbrIvb3KmabBg0u1mF2LkA7eoOyHwhP1GkqbM=;
        b=CxF3/PojQ/G3Pote/gNBiEY6o3xBLexEOOmiemi+Y9LXq9qDUxz6I12FMuLoUFoQbN
         rzV6q2EE7dlBETaTbfE9QYMUXufejYBEs0//pL6D5PWi9i+WXtfoenvV6gEOJYxYskNL
         lHjFglszrelsXkJ+Ki4DTGKQ/JrpBCoLOPTknC1PFeAyQt82Ex+Yt1ZgYqC5KrY9bz22
         0LoSIp6dDo4M9bgSLz7uyGgHitRUdBaBCWvB8yBg2Z/X2FDEDXa+GnN1gvLgFYs25jp7
         abQcQ5mYQdwqCrAtDDI0BNKV6P21ILtrj65BUe5OsaKftCppXCLAq9DH+ck32OfzwWJn
         +J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271951; x=1696876751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jp7VsVbrIvb3KmabBg0u1mF2LkA7eoOyHwhP1GkqbM=;
        b=gC/sJF6gyFqkBg3Qx+LSLXcW9eCnB3pme0mMa/Y126YI3wweePcW9mwPl6AMrWeNFb
         fXlba/oBJsn/v2VhmjT4oAQEf6GBl6e7YlHixzd9V9E39LvUnkl+BfRe+rGUYBfBJJcJ
         DSkqQqmiOa0btPOVO+PX6T2dcPqQIMMgf2WLE60C0lWtDVRoRI53LRHbasboCr/aREo2
         LDork/YsANpbdsvRTaCGBV+UkuAIjLau518apfkJ+wnGmmnWol26A8/J/5kvX6zeHV5d
         fv42wtsSswPhhwbaSuSZP9CRzzAzGCHyIjkNM0Sig6vFrvnnMS+2z3Ypw7842GbvlVOG
         grPw==
X-Gm-Message-State: AOJu0YxM7cnX5Nod9KhDco+E0+APDGLV/MjKyxI+yyGeEQgD5sRHkj1e
        jcHdR1CjxEZwUjCzZkk5wC+0tVroWFX1dVY5tUHHR0w0
X-Google-Smtp-Source: AGHT+IEbdU5wASCmo0tVAL5tQsPES+blZgQkvIApJc/SFq7g+RgUUtknf8vXnq3NYtNe/+/qqXXW4JxySNvlkgadh1Q=
X-Received: by 2002:a05:6512:2813:b0:4fb:caed:95c3 with SMTP id
 cf19-20020a056512281300b004fbcaed95c3mr12010381lfb.53.1696271950847; Mon, 02
 Oct 2023 11:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-9-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-9-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 14:38:59 -0400
Message-ID: <CAP+JOzQEbtM6xyTx2nrqoGgSjFGa_VQARhyEpL7v6HXAk=7=fA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/27] libselinux: introduce reallocarray(3)
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
> Introduce reallocarray(3), a realloc(3) wrapper incorporating a
> multiplication overflow check.
>
> Add private implementation in case the function is not provided by the
> standard C library.
>
> Use in appropriate locations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
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
> index 20d79312..ac656257 100644
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
> index 9a9bafb0..a1c5b0cc 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -95,8 +95,8 @@ static int add_array_elt(char *con)
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
> index c2be7c0a..9f1aff40 100644
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
> +       if (size && nmemb > -1 / size) {

Should be "(size_t)-1"

> +                       errno =3D ENOMEM;
> +                       return 0;

Should be "return NULL;"

Thanks,
Jim

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
> 2.40.1
>
