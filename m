Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18AFC4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjKFPdz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 10:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjKFPdy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 10:33:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB2B8
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 07:33:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507b96095abso5812748e87.3
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284830; x=1699889630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjXkSlZSebul032ZhyHaqcCre85WhZ0AMx853XBlg58=;
        b=ZSUIH4lRtgI/+NJG7+uI+owEyMniyr1Bf1S/F79xl3lIzHraosl+xzJBdV2G4i9XNE
         MhOZlp7eEbQH/mFImOig3+/AhLPYo690GzOaXYj19wRwui5fpnWqkkdvuf/CsU4ejHpG
         BBOp/1sTiuYtpkTZ1BKq5ySDq56bciGZeWnYNDylz2OFJMTCcaoAuwYF1jhpzDn+Svi8
         niqeRF/43ozh23aLLefUP6CVOi9v16ASgrxvMy6bX8km+EwPToWLE5jCy7TlBB4FPtb5
         nsaHQYrER+jvWALtGJH567VkDgdx3dl40RQjnShYMacLz8tIEXMeTNb13081N1oaLtno
         dxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284830; x=1699889630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjXkSlZSebul032ZhyHaqcCre85WhZ0AMx853XBlg58=;
        b=oqkxoGy3jrwyo6JNRYNpWKmnM5OPog0g7ADz0saolC/9ouEW5b0HSFjfr2pDmhZRdj
         K8Ounloyl7s5kIFHJ+YrG4+aXVSAYuOZ73hxnd1DYySaztb8HauMjFAujpDcxE2f4GRH
         /2frjvb056UUv/0sw8sDF8fJCrt1AURA7FZE5UOVZO1FZZ18f4AgqpXM0n8nvoxxu3Ty
         eTuPpL9UPCqEYmg0H0inY8IlO7OFiIWscUOHDpTAkPDSTLPgdNpyieeS7eSwLrMUEQMG
         usZBpO2H14y+J/Dfj2b5inAULzg7XuKtUe8cr9JXSNb347qAYz2E2MgABKKhXexvY1Ax
         plVw==
X-Gm-Message-State: AOJu0YwxUtktxIbqN287LXBk45RGUSCJPUBrYvL0sJ5FrNB1erW/d3ih
        i5mDdtjFjxDCWorf81ObAx0fay6AkZOVOcgmXZghu+CbAYU=
X-Google-Smtp-Source: AGHT+IEMdmBoRCghTT9CoKhO7NbRT8QS+GtUkZqLeu7QcprPgNt5171AjCYFrD7sB/ShRzZveATrkOqMEUFkClY9AmI=
X-Received: by 2002:a05:6512:10cd:b0:507:9e56:5b1c with SMTP id
 k13-20020a05651210cd00b005079e565b1cmr27863382lfg.13.1699284829726; Mon, 06
 Nov 2023 07:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20231103182612.84821-1-cgzones@googlemail.com>
In-Reply-To: <20231103182612.84821-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 10:33:38 -0500
Message-ID: <CAP+JOzTBHhe8vAwOZQaVnBONma4r8LWJVHywa2BHKkvtO4_pcA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject unsupported policy capabilities
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Kernel policies with unsupported policy capabilities enabled can
> currently be parsed, since they result just in a bit set inside an
> ebitmap.  Writing such a loaded policy into the traditional language or
> CIL will fail however, since the unsupported policy capabilities can not
> be converted into a name.
>
> Reject kernel policies with invalid policy capabilities.
>
> Reported-by: oss-fuzz (issue 60573)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Alternative to ("libsepol: ignore writing invalid polcaps in fuzzer"):
> https://patchwork.kernel.org/project/selinux/patch/20231101163852.177983-=
1-cgzones@googlemail.com/
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 892a0ffd..1acaa74f 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1,6 +1,7 @@
>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/ebitmap.h>
> +#include <sepol/policydb/polcaps.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
>
> @@ -1522,6 +1523,23 @@ bad:
>         return -1;
>  }
>
> +static int validate_policycaps(sepol_handle_t *handle, const policydb_t =
*p)
> +{
> +       ebitmap_node_t *node;
> +       uint32_t i;
> +
> +       ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
> +               if (!sepol_polcap_getname(i))
> +                       goto bad;
> +       }
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid policy capability");
> +       return -1;
> +}
> +
>  static void validate_array_destroy(validate_t flavors[])
>  {
>         unsigned int i;
> @@ -1544,6 +1562,9 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
>         if (validate_properties(handle, p))
>                 goto bad;
>
> +       if (validate_policycaps(handle, p))
> +               goto bad;
> +
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (validate_avtab(handle, &p->te_avtab, p, flavors))
>                         goto bad;
> --
> 2.42.0
>
