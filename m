Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FADDC433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A4E22260
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/urhkAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgJOR4d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731528AbgJOR4d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:56:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72405C061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d28so30309ote.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mw7ipMyXBBpffVbbSqhYLAGa0V5fY2TnWdgSrkM7oU=;
        b=a/urhkAZk7aKHe9VN5tc83Y2AvBSQKJFzP7LSI8TZRNrygTywOops556xYpZ2uPpac
         /kx9lgO+U66COoFAh1fArcHDKuKS0Igh1gKCPr+PrVVq7nD7kbQyCwLCqFhrASx6OME5
         nMQGddTqAUmVqjXUHsjeDQRWtG4H7dOwBkyb1ZbdPbe5CiPmsNMwdv+Y5trKUTPoNBa3
         a19awglwcsurupP0DYW869WU51ZGkJXf3WSlza3JVEdUb5Ph24NAzJA/5y0SWga6pzyA
         FH5vGesKSjUU0l3IWMyW/s4TSaIu7e5Nshza3H9jWcYhiCYZ83T1E+omzaKf0Q2zRusU
         s3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mw7ipMyXBBpffVbbSqhYLAGa0V5fY2TnWdgSrkM7oU=;
        b=cHo67QStvMqiZBTsYYhbpN4SODV9H3ayR47XM842V0GYkJM2ijBvOmm00V6xxSPNlO
         RGBGzrKbOxtKN+YrQNXwWQE+PtfTH4dxoch+4KsAjeJt4tV0izEizY+x40eCFSGCeX/g
         GuyuXb+6UHhmQ/BseU9ClejF5rqFrOQCKuOaLn1U+AysDVTvXUkTjoFD3VYWbmDbq3Ic
         Nxyc/ecY/MGh3xxquk1U2mMwrdnxB+fW4i0K9jL3qiiqkgk2vuXw0wZvTwfAtIfDSuyG
         qa6hjrU/TTBNCSns7KR5S/2BZBTR5XCLTyeDdWYlyQBg2WIFMKxwb0eEshCZrZt9/rMM
         yLqg==
X-Gm-Message-State: AOAM5301kUmL3sddOdfgrSfNTFHc62T+mM5eDgjj2AdTMD/IyrHExKLU
        N1AOexNtjdJ4eV/Lsw1LFInZFBQZ1M1Jvnehe30=
X-Google-Smtp-Source: ABdhPJynRdl3tz1iK0XIOQ2F9W7h4M5knBS1E+4wuE/A0ctF8ppozYq2Po5QgolaMmUB7OTdsWF3/csYQM2Zk4o257o=
X-Received: by 2002:a9d:1406:: with SMTP id h6mr3388517oth.59.1602784592793;
 Thu, 15 Oct 2020 10:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-4-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-4-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:56:22 -0400
Message-ID: <CAP+JOzSx=5LKR0H-dWMA7XpSpZ5dB5qR8VSUBJa00=YC-pVf1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] libsepol: Bump libsepol.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:47 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Previous commits removed some symbols and broke ABI, therefore we need to change
> SONAME.
>
> See the following quotes from distribution guidelines:
>
> https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#run-time-shared-libraries
>
> Every time the shared library ABI changes in a way that may break
> binaries linked against older versions of the shared library, the SONAME
> of the library and the corresponding name for the binary package
> containing the runtime shared library should change.
>
> https://docs.fedoraproject.org/en-US/packaging-guidelines/#_downstream_so_name_versioning
>
> When new versions of the library are released, you should use an ABI
> comparison tool to check for ABI differences in the built shared
> libraries. If it detects any incompatibilities, bump the n number by
> one.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/load_policy.c | 2 +-
>  libsepol/src/Makefile        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 2aea826f863e..0034fa53d6e6 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -76,7 +76,7 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
>  #ifdef SHARED
>         char *errormsg = NULL;
>         void *libsepolh = NULL;
> -       libsepolh = dlopen("libsepol.so.1", RTLD_NOW);
> +       libsepolh = dlopen("libsepol.so.2", RTLD_NOW);
>         if (libsepolh) {
>                 usesepol = 1;
>                 dlerror();
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 8d466f56ed0e..dc8b1773d974 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -7,7 +7,7 @@ RANLIB ?= ranlib
>  CILDIR ?= ../cil
>
>  VERSION = $(shell cat ../VERSION)
> -LIBVERSION = 1
> +LIBVERSION = 2
>
>  LEX = flex
>  CIL_GENERATED = $(CILDIR)/src/cil_lexer.c
> --
> 2.28.0
>
