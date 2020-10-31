Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C557C388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D53A206CA
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMH1bQPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgJaN5a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgJaN53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 09:57:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12BEC0617A6
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 06:57:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so8996002ilr.12
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WQd1gs/mpR3dsOUNmKM72WzNl9+kYOYUd19XZZvrtrk=;
        b=IMH1bQPXy9A/yHWHeu9ItAz0onnAUGZZdjrNj2SVsKIDur2O8lFAP0DXNuJ7hKuf3k
         crrc7m0iKVirt3L306DUt5jJkvbyRUHjF5BC2dmzZYctR2aVMZCoA400MlsDyhodGqe6
         qCIOtuPbnAYtrQEfflU36DCZ6P31Gv+7S/Jxv/7Z77kSdudz3+BGy/AZRbhXm6mx6C/d
         6ttFtZNN3OIWiCqpQAoN5etMtkfsVvaewwgliS5xjp74wF795RcvgR6drAFF6M7kntdb
         IHw0tsDF7VDz9bQURWbazXCjxaE57pOcYYPByCejW+Dg8XM6KruxH9VKcCrL1OKaRpjR
         2rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WQd1gs/mpR3dsOUNmKM72WzNl9+kYOYUd19XZZvrtrk=;
        b=HMvC+vpo4C0Gk7RP0efgtz7h/K1uB20pDspXwgRAmthwHWqD5bTc+DWVkYGV835Mjc
         zqZFvrnwVaN6pXFmHuQ6H5mneqTlrcvvm0+wpmVxXsjooM9V/B/FszDXmMO87p5qEI1s
         AGauUfgGD2VDx1RQKEy0wIB4gL+qUIa1qK1TU2bHFFIaDwARq6FTsFZVQwFxp8H/n7rW
         wsO9pJH6DO7IPzB20lheX2yzBXk+iz8fkcnilYGkInGkw971WU8ha2774TS/mGabE2ZJ
         qL5eBdvgRDFYYxg6106965rb2kcdxNFCUGRjTjJP++ATJzSRxRCx069kwwvRyM0uAKb0
         lYmA==
X-Gm-Message-State: AOAM531ChiF/j1ySXkKXRVON+xEk7C6ZTr2RncuUN7ku4BKZ/aq1hskC
        uhhsnV5tJbA/9cxVyMSYNXk0yQiSmztp1Q5ZNuykObmmz1U=
X-Google-Smtp-Source: ABdhPJx3Hhy5KIUy4b7aAK+fJPt8QcFleFhmnAjSR/W33Xx7ngJo9MlBLaF08HhG8ENVBFkB3zul3SnqB3+CFbfJfUw=
X-Received: by 2002:a92:5e9a:: with SMTP id f26mr404932ilg.129.1604152649151;
 Sat, 31 Oct 2020 06:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <8651564.oA283WntVp@odin> <2475881.4AeNWvRDVU@odin>
In-Reply-To: <2475881.4AeNWvRDVU@odin>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sat, 31 Oct 2020 08:57:17 -0500
Message-ID: <CAFftDdqcZ+wsMTsKos7qzhmB1TUxHmju7ZHW0aWQaZ4SK4FHaQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: LABEL_BACKEND_ANDROID add option to enable, rebased
To:     =?UTF-8?B?QmrDtnJuIEJpZGFy?= <bjorn.bidar@jolla.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 7:45 PM Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com> wr=
ote:
>
> Add option to just enable the android label backend without disabling
> anything else eg. using ANDROID_HOST. Enable by default when using
> ANDROID_HOST.
>
> Signed-off-by: Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com>
> ---
>  libselinux/Makefile     | 3 ++-
>  libselinux/src/Makefile | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index cb5872b7..ac16c15e 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -4,6 +4,7 @@ PKG_CONFIG ?=3D pkg-config
>  DISABLE_SETRANS ?=3D n
>  DISABLE_RPM ?=3D n
>  ANDROID_HOST ?=3D n
> +LABEL_BACKEND_ANDROID ?=3D n
>  ifeq ($(ANDROID_HOST),y)
>         override DISABLE_SETRANS=3Dy
>         override DISABLE_BOOL=3Dy
> @@ -20,7 +21,7 @@ endif
>  ifeq ($(DISABLE_X11),y)
>         DISABLE_FLAGS+=3D -DNO_X_BACKEND
>  endif
> -export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X1=
1
> +export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X1=
1
> LABEL_BACKEND_ANDROID
>
>  USE_PCRE2 ?=3D n
>  ifeq ($(USE_PCRE2),y)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index be0b6eec..52c40f01 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -122,8 +122,12 @@ SRCS=3D callbacks.c freecon.c label.c label_file.c \
>         label_backends_android.c regex.c label_support.c \
>         matchpathcon.c setrans_client.c sha1.c booleans.c
>  else
> -DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
> +LABEL_BACKEND_ANDROID=3Dy
> +endif
> +
> +ifneq ($(LABEL_BACKEND_ANDROIDT),y)
>  SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))
> +DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
>  endif
>
>  ifeq ($(DISABLE_X11),y)
> --
> 2.29.1
>

Why would I want this, is there a specific use case for this one?
