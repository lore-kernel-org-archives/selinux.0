Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7AC00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 23:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72DC22245
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 23:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfiaoekp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJ3XFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3XFM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 19:05:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7AC0613D5
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 16:05:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s7so9138270iol.12
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aDIvIxswanB9c8y6NVHo7t9+CSzn8rd7bV7fmMrhVI=;
        b=sfiaoekpH7gAkY+OwC14jL139/DbUTWHRBvx6TNC7/3CdOlR7tFkAjtvQtfHiA2K5a
         axqcz3l8ROcefg1jN7PQUTmCvnrBdfkIVMCf4mEEWkKKqP3k1s63GAv7lXVDrvpzc+CO
         tqXZC/T6ONmpJK6gyeaGiWgTGER89ckmeLbc4cf0cH6lH13Vg2Mf37ZpmjLQpXRyUv5Q
         VZuogb8eIDYA2gX985U842Y9/1yPU/euVKbSGvMUX8zBwBKB2gh/oT4fbG/zec+ts85s
         iEIYaVqGSjFgL+cfIBHwnYDKe455RsJOpCDbYk+cjNxo6//IB1EGvmIF8YXMlyKtRNNV
         tyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aDIvIxswanB9c8y6NVHo7t9+CSzn8rd7bV7fmMrhVI=;
        b=JvLwiek5cZQO5UhOyeX9vHyevsUktY9wour8J42N55K7Z2QzhopW6ZkvDUbM6EGV6d
         +pLf3YScrqAeiBRNq8G+MThOYXBTaXE7VVXdB7P8mQ/sj5R7Cc2QzASlgRSY6ulJmImj
         VimHPSNUaklzYLGp+DhncXNg43VSLAqHrpz79wcz0EAWZdaNEnLEXoMLWbG7Jk6SHVzE
         C4J++P73GL9UYYkySHWIsStcm3nY/tde294mxpwZz5SDsCERewac63uTUh7wbO8jSpFt
         QwRx+Yzj5FMVbCCywp2K9Zn71E7G+CK/ylUIa1t+UxIROiTb36SIyn0OlFvuPpP9hSHR
         sQJQ==
X-Gm-Message-State: AOAM531sjfwlcmRZtsTMIzykYKFbHKU+KBKpOnhvcgtnhsjguvFAVr/I
        /4uJOQ4YoXNKDmQxHlSjtoVGJanbbWHirZy8t65beoVy
X-Google-Smtp-Source: ABdhPJwUdiXJRxlDor4WAalIttieixbIJa89uvBVUPDWXSiuw5jNVNbOHYGq2yvJvfxCWbAMgpejT37AAaLV9gZPsZU=
X-Received: by 2002:a6b:7947:: with SMTP id j7mr3515125iop.143.1604099112267;
 Fri, 30 Oct 2020 16:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201030211327.111834-1-omosnace@redhat.com>
In-Reply-To: <20201030211327.111834-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 30 Oct 2020 18:05:01 -0500
Message-ID: <CAFftDdrws1qjTPZzg4aAAUPX2xeO8a6Q2YuHqDM7poaabM0fNA@mail.gmail.com>
Subject: Re: [PATCH userspace v2] ci: use parallel build
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 4:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Pass -j$(nproc) to all make invocations to make the CI run a little
> faster.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: use POSIX $() instead of ``
>
>  .travis.yml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index bd3c9842..8ea6cc74 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -74,7 +74,7 @@ install:
>    - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
>    # Make refpolicy Makefile use the new toolchain when building modules
>    - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
> -  - sudo make -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
> +  - sudo make -j$(nproc) -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
>    - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
>    - sudo mkdir -p /etc/selinux
>    - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
> @@ -129,12 +129,12 @@ before_script:
>
>  script:
>    # Start by installing everything into $DESTDIR
> -  - make install $EXPLICIT_MAKE_VARS -k
> -  - make install-pywrap $EXPLICIT_MAKE_VARS -k
> -  - make install-rubywrap $EXPLICIT_MAKE_VARS -k
> +  - make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> +  - make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> +  - make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
>
>    # Now that everything is installed, run "make all" to build everything which may have not been built
> -  - make all $EXPLICIT_MAKE_VARS -k
> +  - make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
>
>    # Set up environment variables for the tests
>    - . ./scripts/env_use_destdir
> --
> 2.26.2
>

Ack
