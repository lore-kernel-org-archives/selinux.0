Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18BC77B7A
	for <selinux@archiver.kernel.org>; Thu, 25 May 2023 20:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjEYUgu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 May 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjEYUgt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 May 2023 16:36:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0F19A
        for <selinux@vger.kernel.org>; Thu, 25 May 2023 13:36:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af1e290921so10706521fa.3
        for <selinux@vger.kernel.org>; Thu, 25 May 2023 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685047005; x=1687639005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIl3VdphiLiG5x8VmDKJzUC41vxCK42nBqjyXCOU9vU=;
        b=oZG966Fm4+jRImGsy0hPZ2vtyCrhYEF9niNhdtKVW4zMvvWa2/JihfN+cJMngDkD8H
         6JjTCY7LUH8Y3YwVbCti5XwCy9bL3x4JZrt7aD4ph0aGEA2CYYKias5u+hFDs8+vBduk
         ku9CSJwjW0BD3INa5QBq5VwQAKHt4HT6zifCYgcr0scJwKlz8aHsZN5z0DsWxqsGKhhf
         l2LgQGgoQyzbNy3l9/z3lpsCjA4Aai7/nifIDYExqaxMNVVlS76aliljHiKN1MMoAS/5
         Yb+0wEtzeY0Vml7e5c3vJdDrrNEQSSCuayA7ZmdgUzrdKcJBvczd7tYnFX8u62lixkbF
         wj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047005; x=1687639005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIl3VdphiLiG5x8VmDKJzUC41vxCK42nBqjyXCOU9vU=;
        b=Oq3tz0fV9Qc2B187Cvue09Mbvy0cfooR0SHlTHoYb4Ev5oZhnZ+YswboG44dmrOjhk
         VH0hpRXxaqh7MyKQCSNgR6NWeGVvyQmbISUs6fD5HGbsUj6SE8tbVOMVPEo6iFDPh1FO
         qmUdqtsq5m+PMGZdxmyar0bvmXcRvfNkEI/+tfsdIoiMwW0WDuf21FMk0NqhD9tENwSY
         I6iQBhkFNuUqiFdX17soy/Ccorbvl0Mo85j2Pnpp/Wjsd60wNg8mEpe/3MmE0n6jE49W
         VmrmXrpQNtnfXhCjZ4m1ITudSygCLTSeZFwUpIG7QzeYF7q4lnp68ADDQtXYoQRiDw3/
         Fc4A==
X-Gm-Message-State: AC+VfDzlR1iY4HUsToNut5P7xM5PN5wdzGEu5814noSmCj7VYkvNOcha
        S5AsHO57R+clhbvwkLnBB6I7afoN6G5hi2rRzh9SC16cq28=
X-Google-Smtp-Source: ACHHUZ6mb6elfxDSF2oby1X6R6ZUyJ7ntLXz/jCQS8/JRDCcgjfW5Bk8dBB25vqizHoyOZwCwWyF3pyTDZPemRJpOiY=
X-Received: by 2002:a2e:990f:0:b0:2ac:75fa:495c with SMTP id
 v15-20020a2e990f000000b002ac75fa495cmr1386612lji.27.1685047005239; Thu, 25
 May 2023 13:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230512093001.49208-1-cgzones@googlemail.com>
In-Reply-To: <20230512093001.49208-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 25 May 2023 16:36:33 -0400
Message-ID: <CAP+JOzRJVORDra0SZ=X+mfaYtj=5NMv5-6CeM9xAewO+6P7uwA@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol: validate some object contexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 5:32=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure various object context entries have a name, since they are
> duplicated via strdup(3), and the order for ports and memory regions is
> valid.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these five patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 301aa200..e0d290ff 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1149,6 +1149,8 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p, valid
>                                 case OCON_NETIF:
>                                         if (validate_context(&octx->conte=
xt[1], flavors, p->mls))
>                                                 goto bad;
> +                                       if (!octx->u.name)
> +                                               goto bad;
>                                         break;
>                                 case OCON_PORT:
>                                         if (octx->u.port.low_port > octx-=
>u.port.high_port)
> @@ -1163,6 +1165,34 @@ static int validate_ocontexts(sepol_handle_t *hand=
le, const policydb_t *p, valid
>                                         default:
>                                                 goto bad;
>                                         }
> +                                       if (!octx->u.name)
> +                                               goto bad;
> +                                       break;
> +                               case OCON_IBPKEY:
> +                                       if (octx->u.ibpkey.low_pkey > oct=
x->u.ibpkey.high_pkey)
> +                                               goto bad;
> +                                       break;
> +                               case OCON_IBENDPORT:
> +                                       if (!octx->u.ibendport.dev_name)
> +                                               goto bad;
> +                                       break;
> +                               }
> +                       } else if (p->target_platform =3D=3D SEPOL_TARGET=
_XEN) {
> +                               switch(i) {
> +                               case OCON_XEN_IOPORT:
> +                                       if (octx->u.ioport.low_ioport > o=
ctx->u.ioport.high_ioport)
> +                                               goto bad;
> +                                       break;
> +                               case OCON_XEN_IOMEM:
> +                                       if (octx->u.iomem.low_iomem > oct=
x->u.iomem.high_iomem)
> +                                               goto bad;
> +                                       if (p->policyvers < POLICYDB_VERS=
ION_XEN_DEVICETREE && octx->u.iomem.high_iomem > 0xFFFFFFFFULL)
> +                                               goto bad;
> +                                       break;
> +                               case OCON_XEN_DEVICETREE:
> +                                       if (!octx->u.name)
> +                                               goto bad;
> +                                       break;
>                                 }
>                         }
>                 }
> --
> 2.40.1
>
