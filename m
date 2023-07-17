Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF854C0015E
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGQUNv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQUNv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 16:13:51 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B6136
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:13:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5700b15c12fso49597917b3.1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689624828; x=1692216828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvmX32zU8Nu+p0waGNgOm71AAY+i07Pz66RGGQaXTI4=;
        b=TW2a91JW8lK5lF2iBDyb423VMHB7QMlgmU4F+iQGe2w8EbUik3ZYW9UKlKomjOj4tf
         sQRhV1SAUZKvdLDOAn9hVyYiY2C6Hf/lbAJWjZ8sP5qq9nKX0DCjzab/WCl8z27bGzxE
         kF2QdhKoABhJfwzkWjD2UFsaFxAQl6krAVfT2GSVtTO7HyX0Gzo3zwwaCOa4Cx6mDIoA
         qYzzplJpNvI1KX+Wm2zmJ0eFlMphPTbZq04g9LOyj8h+LNU7wx0qEnFd8LifFNQW4gdi
         cRsLvXvqtIxRtqdEczKI+eofyQfyE//gDa2HYXAY/pWt9SfPL4gaWExTCVNv+hOIeL28
         ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624828; x=1692216828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvmX32zU8Nu+p0waGNgOm71AAY+i07Pz66RGGQaXTI4=;
        b=ZOvBDweOtuYchSlA9Bs4WQsaVkkOh94GLhdCT11Tf8aNYqdA3lpvhqR1A6b+xURzlP
         YmMIjGRQuhbkYchgxkqAZVNc+Y+/gQz94/j5GeC68JnYY6FtPE2uahKOXRANlk2C0z7l
         Mw8gO1sCMFyOdNz4DpSuRgeOlcUKPBJ/VyMN2KE81IOPAthRFSduqusVjdfxqAJEpW06
         FZ2hLKdosBvmLkANbp4ChC3vEloEGROJRPZDqDPScPQSHrorIXhzNBi64zAlil1sZ9h9
         1KOW3OL6ESHeFF/KsuzN0fQXUi2/NmqcqhbMRy5sTgv2uFtS/2NhzO3buKPoGRF17DGK
         QDPA==
X-Gm-Message-State: ABy/qLY2SqsqdUqG6kRWEMO2CIMpygsbVVhlUM5+pnIhGRTaibacsVu5
        PXbIl0snJiQsNwRXzCYmhvwVa6iXM6njfIhrbH2U
X-Google-Smtp-Source: APBJJlGhTds1F4H7StCSwQsY4qTQeDMOf+WNZ+mPKJNceWZyCzdFeKNXKO5Qm7EYDdTG4lnOzurlRAja2C9Ltt/7bfU=
X-Received: by 2002:a0d:ca0b:0:b0:577:2340:605f with SMTP id
 m11-20020a0dca0b000000b005772340605fmr12508948ywd.2.1689624827830; Mon, 17
 Jul 2023 13:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
In-Reply-To: <20230710082500.1838896-1-lsahn@wewakecorp.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:13:37 -0400
Message-ID: <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     lsahn@wewakecorp.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 10, 2023 at 4:25=E2=80=AFAM Leesoo Ahn <lsahn@ooseel.net> wrote=
:
>
> The major part, the conditional branch in selinux_mmap_addr() is always t=
o be
> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.
>
> This usually happens in some linux distros, for instance Ubuntu, which
> the config is set to zero in release version. Therefore it could be a bit
> optimized with '#if <expr>' at compile time.
>
> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

First, I agree with Stephen's comments that you should ask your distro
(you mentioned Debian) to move MIN_ADDR higher.  Beyond that, I have
one request, see below ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..a049aab6524b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long addr)
>  {
>         int rc =3D 0;
>
> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
>         if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>                 u32 sid =3D current_sid();
>                 rc =3D avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>                                   MEMPROTECT__MMAP_ZERO, NULL);
>         }
> +#endif
>
>         return rc;
>  }

Pre-processor conditionals inside a function are generally something
we don't recommend.  In this case I would suggest doing something like
this:

#if (MMAP_MIN_ADDR > 0)
static int selinux_mmap_addr(...)
{
  /* current func definition */
}
#else /* MMAP_MIN_ADDR > 0 */
static int selinux_mmap_addr(...)
{
  return 0;
}
#endif /* MMAP_MIN_ADDR > 0 */

--=20
paul-moore.com
