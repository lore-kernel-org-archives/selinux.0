Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE422C433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiDAQzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbiDAQzs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 12:55:48 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423BB9E
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 09:53:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z8so3394298oix.3
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i4PpMpUw93goKYna2HfRFMM50GXSCBAlgogfEyVIQXc=;
        b=OIirfs73RaLARbThCjigrseujn8DMhHxn9bcbch5LUV+KCrt0Jl8FJGZyNQmv3mtO3
         pvRLQiQhsf9CslyisIJ6LbE2TW1JkapyhYJnQKi+GTGDDxjUYGwexahXQcd+RO6zHwhH
         r+xkIiCPX0zqwxSVUoElM3V4effLdkvMP0mSaylGKE3jU95HGVWWdt6CdSj3KKYG4qZa
         6EaAe1vaFoCQZuBZl1xWs25gnD0nzahNEvOF8oZjLFim6jVhvXOezNssiNs32P8DXFct
         E96THm8zJc3e+eG9GY3knJvSq34qBWrgxItZ7GJ9gVpTB9x8ra/OGoA/Ohlr0ENyix3F
         Qypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i4PpMpUw93goKYna2HfRFMM50GXSCBAlgogfEyVIQXc=;
        b=SYTJRhbPAEapaNU38ow9mQCuyrxuh9TqUp3dt2L3sCjAA/7KqPRUoTZvT0QdRlJrUn
         FRu3b7MhGHPOOcyHVqEIT+A4vbOLsgOkunMNecWQhnRbAZYtnNVLyWFtdK04+rt1bOMc
         jnW3j6CrXyqhO5v1NlanTKPNvHCfI3OCxhgq5KBwyUbgqE5dp2ZpQokXDf/JyNnDodVc
         A7Cb940+0lSnlxosmhAXdLM7TbS9nUQ3NrqS2SjSVID6ut5T0fMQzPoTY5mlYLxZOQ0G
         OC7DbpCcaeiBmDaXpYaDIhqeP3ir/cwby+Fg/uuVeJd8zO8Twx8xWC0LOFUK3eXGI/qt
         /ocg==
X-Gm-Message-State: AOAM533UiXMArnj6/R+9ZsOegSRDLR+PvY7qQjX1yKFX1kYZP/CS1MKp
        GBEuWji5kBQqNO3oUhom5yeBMqFDEGPOvswdjy7YIJAvcf0=
X-Google-Smtp-Source: ABdhPJzpi0PSqMMAfIH+CGLvHyPsrajx1yo3BqynVpYJ4LcOQmC5tteiV0XKtIEw+mZTZTVRKfqtyRKyKnPEORMgPVY=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr5114184oiw.182.1648832000276; Fri, 01
 Apr 2022 09:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144343.30689-1-cgzones@googlemail.com>
In-Reply-To: <20220331144343.30689-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 12:53:09 -0400
Message-ID: <CAP+JOzSvNxZP86C5xvQbbQ_JopwoYCj5AikS3-djjww4fVVu7Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: silence GCC 12 array-bounds false positive
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 11:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> GCC 12 produces an array-bounds warning:
>
>     In file included from ../include/sepol/policydb/context.h:23,
>                      from ../include/sepol/policydb/policydb.h:62,
>                      from ../cil/src/cil_binary.c:41:
>     In function =E2=80=98mls_level_init=E2=80=99,
>         inlined from =E2=80=98mls_level_destroy=E2=80=99 at ../include/se=
pol/policydb/mls_types.h:99:2,
>         inlined from =E2=80=98mls_level_destroy=E2=80=99 at ../include/se=
pol/policydb/mls_types.h:92:20,
>         inlined from =E2=80=98mls_range_destroy=E2=80=99 at ../include/se=
pol/policydb/mls_types.h:149:2,
>         inlined from =E2=80=98cil_rangetransition_to_policydb=E2=80=99 at=
 ../cil/src/cil_binary.c:3231:6:
>     ../include/sepol/policydb/mls_types.h:89:9: error: =E2=80=98memset=E2=
=80=99 offset [0, 23] is out of the bounds [0, 0] [-Werror=3Darray-bounds]
>        89 |         memset(level, 0, sizeof(mls_level_t));
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ../include/sepol/policydb/mls_types.h:89:9: error: =E2=80=98memset=E2=
=80=99 offset [0, 23] is out of the bounds [0, 0] [-Werror=3Darray-bounds]
>     cc1: all warnings being treated as errors
>
> This is a false positive, by inspecting the code and compiling with -O3
> and -flto.
>
> Closes: https://github.com/SELinuxProject/selinux/issues/339
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 53017e2d..d5211f69 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3222,7 +3222,16 @@ int cil_rangetransition_to_policydb(policydb_t *pd=
b, const struct cil_db *db, st
>                                         } else {
>                                                 cil_log(CIL_ERR, "Out of =
memory\n");
>                                         }
> +// TODO: add upper version bound once fixed in upstream GCC
> +#if defined(__GNUC__) && (__GNUC__ >=3D 12)
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Warray-bounds"
> +# pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#endif
>                                         mls_range_destroy(newdatum);
> +#if defined(__GNUC__) && (__GNUC__ >=3D 12)
> +# pragma GCC diagnostic pop
> +#endif
>                                         free(newdatum);
>                                         free(newkey);
>                                         if (rc !=3D SEPOL_OK) {
> --
> 2.35.1
>
