Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B8C001DF
	for <selinux@archiver.kernel.org>; Wed,  2 Aug 2023 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjHBRA1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHBRA0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Aug 2023 13:00:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBAF1712
        for <selinux@vger.kernel.org>; Wed,  2 Aug 2023 10:00:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so50960051fa.1
        for <selinux@vger.kernel.org>; Wed, 02 Aug 2023 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690995623; x=1691600423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaFRPbtW/yWaXdvdUy1bHTf3DFrZn0MORoU1Y3whbyY=;
        b=D3/mZ8x6wImWVBAtY1ESRv5D2ndPg50RSPciYVTG015YK/esm1K2gSHnMCCHovdtN7
         GZsv50V33JBhbPDR85wqO/sGQqHzY4N7O9+7EHfutLI+ct6yMfx1fqe3PRn2mZG0zx6D
         iHMypkxBEfAZ/yUhPp2/YcNGTUp8nj/O4WcmPnCl/zRKjVvTSRN0ti+s4LKGuDU2XgS7
         Ofm27fCRnh+FiOXudixNc2ZfP3ABGARlumVChgcQ19u8C20BIFCgYbm6Zpuu/cdVK8E+
         j0H7V+EKJl0qFXIdIjdseMqYfWMjElGXk1lNGBzYqdB8dSDjgvBfx3ZNmyg7ajCE2sQq
         aCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995623; x=1691600423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFRPbtW/yWaXdvdUy1bHTf3DFrZn0MORoU1Y3whbyY=;
        b=X0OmB0bbP0lGH9b6hoAWHRSTYCdkQOASaNMK06Gp7cPadp2co3pOyv5j6XLk3VQpWr
         C1BOSlKuohokVUJzcxlDDi2CdLYU8hxobYnPICYpJhPscXlkR9cmKfePR6wi++54R0aQ
         0csWjvICtB0x5FPXG2MhpI1OTlqZIx0J1J+M0UKKmiYe1TqLUuJoGgVofPV+vOsjVyvY
         kKSZXtfiAMqfYMuu2E2UMJNxkku3Vi+bUn+eKgsfO9qB2xYHkCAVFvXmTQFqhj/wGTsq
         qx6iIpsjvHTP7DCkqFAWHZnoHA0e5mkxzN/GvQBLYjyK4PEtdMsjcuQy+RsJl89GR2mP
         TXGQ==
X-Gm-Message-State: ABy/qLaRnoN629yhKEaj5GbvMUqPcZyDyTmlDNgyMD/7I2y9FeKx/k7z
        0o5ZMI4Bb/a7GoNuThDpTleuppQyCtu+O9n25QOn1Qhi
X-Google-Smtp-Source: APBJJlG1jt5i+/0D/GMgKa5iRY1zJ8Oo1Zhh3qVD0CeMPrp+ys9faU2KxCELmvK11CxKzP5Ue4Rr3pHGXBI+PeHg1lI=
X-Received: by 2002:a2e:2e0c:0:b0:2b9:2e85:2f9b with SMTP id
 u12-20020a2e2e0c000000b002b92e852f9bmr5875995lju.2.1690995622995; Wed, 02 Aug
 2023 10:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093957.2264516-1-chungsheng@google.com>
In-Reply-To: <20230606093957.2264516-1-chungsheng@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Aug 2023 13:00:11 -0400
Message-ID: <CAP+JOzQvaZK8yYx==xjYwtpJwr6pUYnWLO+X=z2Ti_YgpQdPiQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Add CPPFLAGS to Makefile
To:     ChungSheng Wu <chungsheng@google.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 6, 2023 at 5:50=E2=80=AFAM ChungSheng Wu <chungsheng@google.com=
> wrote:
>
> From: Chung-Sheng Wu <chungsheng@google.com>
>
> Add CPPFLAGS to Makefile to allow users change the flags of
> preprocessor.
> We offen use CFLAGS for compiler flags and use CPPFLAGS for
> preprocessor.
>
> Signed-off-by: Chung-Sheng Wu <chungsheng@google.com>
> ---
>  libselinux/src/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index f9a1e5f5..4e4640f0 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -149,10 +149,10 @@ pywrap: all selinuxswig_python_exception.i
>  rubywrap: all $(SWIGRUBYSO)
>
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@=
 $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYL=
IBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsel=
inux $(RUBYLIBS)
>
>  $(LIBA): $(OBJS)
>         $(AR) rcs $@ $^
> @@ -169,10 +169,10 @@ selinuxswig_python_exception.i: exception.sh ../inc=
lude/selinux/selinux.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
>
>  %.o:  %.c policy.h
> -       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>
>  %.lo:  %.c policy.h
> -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
>  $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>         $(SWIGRUBY) $<
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>

I am not opposed to this, but I would want it for all of the SELinux
userspace, not just libselinux.
Thanks,
Jim
