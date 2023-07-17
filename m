Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2182EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGQTU4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQTU4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 15:20:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD1C18D
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 12:20:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2657d405ad5so3342163a91.1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621655; x=1692213655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKAe8F03mMr+4kFaFR0CJWFag8p3e4BtGSMPYxblcI8=;
        b=WA8qNaTb7Otp3SIHoBuVUTn42bdaPRwlRJMjAOvax+CeeJBrHRWnTDYeQUVQpCmM/x
         qyct/2n7ox1BvLf5XPEr51bLSaPNOm2sA9YkMKY/59F+RrQN56RVqrYhMdVjzEWmpnlX
         QiuubY5JjPXl8ARUK1FYbPoT31Nv/EUhwVPNf0tuLKugmtLeZ0+Bcx4e9oK0wfsAQ44D
         tJx8OPKeZJ08lj+9rgc/+QCxby4EDAbVWDUdUcE87NALIaUWjPqEHReYttfKqi9usiaD
         TxulNz1qswlIWTYXSxnu75IpnwaCt2RJwvk6cRItO3c7R0Kb4d2CdK40Xlzu5of3rRG/
         GSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621655; x=1692213655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKAe8F03mMr+4kFaFR0CJWFag8p3e4BtGSMPYxblcI8=;
        b=NJB2knvjayCri+qO4M6U+JmBaZpQvFqLIjVVXZJ83qqkufD2DIFdxisZsMALYkI6O6
         CigkQli+yNyJx4ma7pI7m2SVEAu1uJE4k3u/Ma2TCRtZkS1Y3v4klP/5UMyYse8l6WM9
         5uH91n67U4Ncj4WPBBvxSRSycCxPpxHYglnEP0bA4AiTGgoWVRcGqqxgAvvbWNLmlITe
         Akg2wd/zERQPKs/AfPlEESXr5kBcK56kR0PiYDZkGSijXsHjsCjFKKnboU6ckWkm3afh
         kc238BOgzs5UsQvWAtf66nvn1sft2hYE8REv2+sucZbpq3X6EEyaUAprPToZoko37HNV
         8Kpw==
X-Gm-Message-State: ABy/qLa6psVvgUE6xfw+IwmsS1lO17XEvp7kDlGMbMSqFiagrh8kDjoi
        BpBdWSDJDyiCK8BExJvjLEPBOl+vllQ7OBZ2j3E3/9xc
X-Google-Smtp-Source: APBJJlG0uO9jXi+R8rxb64L0GKKFQGSaKuiPFh8GO2QnvVxli+To1KcNQaRTaJdfuDikaqUZCyZXZYNaTkDnJHoO2iQ=
X-Received: by 2002:a17:90a:65c6:b0:25e:bd1d:4f0c with SMTP id
 i6-20020a17090a65c600b0025ebd1d4f0cmr11789295pjs.10.1689621654819; Mon, 17
 Jul 2023 12:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
In-Reply-To: <20230710082500.1838896-1-lsahn@wewakecorp.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Jul 2023 15:20:43 -0400
Message-ID: <CAEjxPJ6Mun2m3=uHpTR9dh74kxMsav3yd7CF1QeBPYuX=eN=dg@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     lsahn@wewakecorp.com, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
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

If your distro is configuring LSM_MMAP_MIN_ADDR to 0, you might want
to bug them about it, because that's not a great idea for security.
And if you intend to use SELinux there, you'll want it set higher.
Default value in the Kconfig is 65536.

>
> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
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
> --
> 2.34.1
>
