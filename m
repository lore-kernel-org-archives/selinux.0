Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F573C5517A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B4920853
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6D39AZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465293AbgJWOsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375546AbgJWOst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 10:48:49 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B5C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:48:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b15so2071968iod.13
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8HSBO95wGjvcaZRM6C4gQpt9mhiebFGlv9siBpJYW6I=;
        b=Y6D39AZZoN4pfcxvy11dbTfKVnwReXCcnamgArElTmTyM//DloSKhEHp/sORQ1lyRm
         2gik98VIftvqsiepmzxoBgIzLRb52eyua2fdrw5NsHZvOaCJke9rPxS+IRMe+I/JTNN7
         ly62TtS8iccnS1cV17PSls02toDwmWxh3miSk4G8+HoQvM4yV/n/XX9RFwbsIPyOl5RA
         fGEAYbwU5zyAmLeIyhv2BSvCozsM9PSrSN8eBGDWl77jme4EjvVa4SkDgc6WuPM5BYs6
         t3R3x5M5RRuFIgJJUG36H+r1DUL6eE0svuBY9Cj51Z8pIXXw3feGikMb8TeA7i/nEhq1
         sOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8HSBO95wGjvcaZRM6C4gQpt9mhiebFGlv9siBpJYW6I=;
        b=kStupKIvKfSFk/PhtPbJd4w1pPlC3FzlGYCvkEezIHLN+zbTxaEPvGyYaNkvEEj3Ay
         JK2l/CI1Ungc2T+4TJrWj1uqgkY9NYjGGOd0CLueWcy/8vUl/h8DuE3xzeGoQkxiZ1sR
         lvuAQ9hwivN7x2oEGMpgtnX8t2eq7SBPWwG9tgxSkqNDsAV2mW61iWjXxKssNSheioc4
         0MthYAepjKB5876Z106AjenUW5Tv4Vrm+eN4ebwlC8apguEpYanNHhfEhL9JUbPYwhdO
         ZtSXrlEWT7QWjrCXkW1/inD9PO9hfolWbuOLtry88fTkxbLKruO6/JMY76vTlTRFpV2a
         aH/A==
X-Gm-Message-State: AOAM5321GRUUSHFXFy3UUw3fkC01ZohiYLAkHliSeWfS1IpVSlwESGPk
        rq5SCS+VW6dalzI51ttlv47w73fORvUChh3a0BkXFHVK2ilJQw==
X-Google-Smtp-Source: ABdhPJwjvESKRp0HPEgLkQonREorLXWoaXjdLJ10CoDDeWQKNiiGLW8peZiZL/gx64quhHBaEwwdazBND+BxoJ9/rjk=
X-Received: by 2002:a02:3e13:: with SMTP id s19mr2176925jas.61.1603464528673;
 Fri, 23 Oct 2020 07:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <5825612.FvA7u9GNv5@odin>
In-Reply-To: <5825612.FvA7u9GNv5@odin>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 23 Oct 2020 09:48:37 -0500
Message-ID: <CAFftDdrgFQdw0Ctf4Y1L6zfBqL-Awfbvq7qr4eMP5r-3K6ALKQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Add build option to disable X11 backend
To:     =?UTF-8?B?QmrDtnJuIEJpZGFy?= <bjorn.bidar@jolla.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 20, 2020 at 7:28 AM Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com> wr=
ote:
>
> Add build option to libselinux to disable the X11 backend without using
> ANDROID_HOST.
>
> Signed-off-by: Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com>
> ---
>  libselinux/Makefile     | 5 ++++-
>  libselinux/src/Makefile | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 6a43b243..cb5872b7 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -17,7 +17,10 @@ endif
>  ifeq ($(DISABLE_BOOL),y)
>         DISABLE_FLAGS+=3D -DDISABLE_BOOL
>  endif
> -export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
> +ifeq ($(DISABLE_X11),y)
> +       DISABLE_FLAGS+=3D -DNO_X_BACKEND
> +endif
> +export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X1=
1
>
>  USE_PCRE2 ?=3D n
>  ifeq ($(USE_PCRE2),y)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 190016e2..be0b6eec 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -126,6 +126,10 @@ DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
>  SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))
>  endif
>
> +ifeq ($(DISABLE_X11),y)
> +SRCS:=3D $(filter-out label_x.c, $(SRCS))
> +endif
> +
>  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FL=
AGS)
>
>  all: $(LIBA) $(LIBSO) $(LIBPC)
> --
> 2.28.0
>

Acked-by: William Roberts <william.c.roberts@intel.com>
