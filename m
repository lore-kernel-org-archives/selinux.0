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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7293AC433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E7720797
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgANsxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgJOR6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbgJOR6U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:58:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB27C0613D2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:58:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id q136so4033714oic.8
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/lDNSwtkiYpjdfq0k3fZjzToh6+beBBtKs7Un1J3Fg=;
        b=IDgANsxJxc+jz67Z81gxo7c0t7EbzxB0SzFsCIzlnw9LUCcBICgGUPgGdz/15lgEHS
         icseID7onZlBtUxL2iqKONP+Ibg1ur4TRglIX0vN0kT8zAitVlc7DuoFcxxGbWI6Vuee
         pZ1s7EdFqxbVp1h//1FXvAmrh285FMVWkPMGpKwJDgCC/jl0MmFby51McISrwqZ7uJS3
         zD24JR1hvo5VnsLwibjfNG6Lss+eWj9wezzuVHL5HizAP1neR1JAzbT+hUU+p5ofU06V
         P8m3OUtSxuuXtM5Eq7eb1DIryQHuQ8a75vEqUdGGlJkPf0D/xR96+IQxo8iINUd2WDib
         fGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/lDNSwtkiYpjdfq0k3fZjzToh6+beBBtKs7Un1J3Fg=;
        b=J2Kvr/Da72OBZbVuJHerJ2ORQJbR8w0HGEn7CmewHJ+rYAiIgT3mkYcQjPQBbhP9CA
         eBQcEYp2hKrzA+xWPpjOcTTKd2aN2/rjnAu/ECoR3Fwik5oC74iGZVJ90v6zk+hQ2fDM
         6wwvKx3qffAG+WQtNqfbh849x+sQElmknB+uSnu+faHKxjh6r4k0ufD6YTvhyRlP8rxl
         gwgCehmjO3stwwE7JuetTEi9YaIp8V/UuMvzKv6rxyLIG8C25mzDX9SNdJ/I4PFU3eLJ
         oXJoVqAGVHbbu2XhWneCF6lExN+qlQSDCO0uD84/mJllKUaJCpJZcqmfWLynU1+OQrwY
         LZZA==
X-Gm-Message-State: AOAM532iLUGILOcEqGUM+MR5iqKO1Oj6T5ZV+i8R2tvcFjCuMQ889gyK
        VGPye6T2bIFHQ4quxf/MvAyLju+mNkmSO/Xtr74=
X-Google-Smtp-Source: ABdhPJwPSSTXzMjmjKEDf7EPwfBq7iVu4iaTjVzQNvrvZ4hufdHc5+c6wEwRW1CsAD22t4eWMxJt54PsVjCN2l5pr+8=
X-Received: by 2002:aca:498b:: with SMTP id w133mr13613oia.138.1602784700118;
 Thu, 15 Oct 2020 10:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-7-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-7-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:58:09 -0400
Message-ID: <CAP+JOzRkDu6b_TZ9xwNNxphonPr7hz+dC+viJw_gFRdULAUFgw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:48 AM Petr Lautrbach <plautrba@redhat.com> wrote:
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
>  libsemanage/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index a0eb3747d74b..ab6cae51f5c3 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -32,7 +32,7 @@ YACC = bison
>  YFLAGS = -d
>
>  VERSION = $(shell cat ../VERSION)
> -LIBVERSION = 1
> +LIBVERSION = 2
>
>  LIBA=libsemanage.a
>  TARGET=libsemanage.so
> --
> 2.28.0
>
