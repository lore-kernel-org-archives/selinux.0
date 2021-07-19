Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BCCC07E9B
	for <selinux@archiver.kernel.org>; Mon, 19 Jul 2021 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4298E6023F
	for <selinux@archiver.kernel.org>; Mon, 19 Jul 2021 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350607AbhGSQbJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354721AbhGSQa3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jul 2021 12:30:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB4DC05BD2E
        for <selinux@vger.kernel.org>; Mon, 19 Jul 2021 09:37:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso18815748oty.12
        for <selinux@vger.kernel.org>; Mon, 19 Jul 2021 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xJSZ95c/XSztOz6EVr111O+4jlJvpIp+A69E2BmpMp8=;
        b=fv6A2U0+dFnd0Uapl1/BJlVvH/9p1prFVdkTaUr5IxhsIIoVRO5khhewBsiAWtb5BU
         79xqEt0AvQ5c7MSXQANEeXIcdqjQ4LyqY6FY1Oqsr3r3+UL3S8H17lORTYc1x3/lCZ0X
         gGl4aMn1QTtj+lNaPQEv57l1Ylal+SkhI+8YhVTrXOMu30CMRgdoSJmDVDrwvZUVIcKc
         dqjVMnIFXrsimpUhjWRH2EX8F6i0PsYGIiKSmsDMQVDLhHIBMYidLf/09cSHL4SVAtDW
         C2hi28BN+t5lCSIobHkQgrrF/uOQNcGQWlsuFiaLvrT+wrLfMLSRz9dYs/ABoQiAVWUu
         ZV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJSZ95c/XSztOz6EVr111O+4jlJvpIp+A69E2BmpMp8=;
        b=CqtWZ7kURrT3XsMdzx60fV7jQzrU3ojyYdF8eJ1KEOt6P/RnvXsJzphQw3rrUnEVyQ
         QDlseautxKHCFVC9ddOQbeU2CqkgrBkwnu6iyeJofrQJ/1KAitZLCnRuPCk3G4z3K+bT
         76eSx4lYd6KcCmi1Tc5dMp9a+6OnGR3y3SWuhSz/mF3lWPaV6z8xPMHYhrvjBspGu8Jd
         k1RDtP23wDJgfoqCn2rkwlbyaVQ/VwVbrF2QgT3Eu0cC3l/5xeOPb2kBpCayQ7KbAE1r
         casRlGCGK+koJYZQT8oda4UohYLachlOdlylZ3fPE0460yNZ4IcqidE4c1t61LKlYcUb
         VvGQ==
X-Gm-Message-State: AOAM531V990Cm6WvJ6XLvr11B+VBAAQqh3swd5j23ygACHPHPZxSe/9j
        ML9z6Zhfb2rwrm0oflg/ung3xYq+3rloazniKSs=
X-Google-Smtp-Source: ABdhPJzXIncm48Zft9WVJDgI5id96zRzDTc355eh6Ap4XvWgEpY0SlHDdnTuYrE8Yh+oYdoDCZ9Ejud3SAB6e2pysRI=
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr18826544otl.295.1626713925959;
 Mon, 19 Jul 2021 09:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210714181343.58880-1-cgzones@googlemail.com>
In-Reply-To: <20210714181343.58880-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Jul 2021 12:58:34 -0400
Message-ID: <CAP+JOzTxL=PsEHdL8PMRv8=dPLcLypPMnYEWj2WHUygXMVpeGQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/run-scan-build: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 14, 2021 at 2:16 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> - use multiple jobs
> - define _FORTIFY_SOURCE=3D2 to enable checks on standard string handling
>   functions due to macro/intrinsic overloads or function attributes
> - allow to override clang and scan-build binaries, i.e. for using
>   versioned ones
> - set PYTHON_SETUP_ARGS accordingly on Debian
> - enable common warning -Wextra
> - print build result
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For all six patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  scripts/run-scan-build | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> index ae5aa48b..ef07fefc 100755
> --- a/scripts/run-scan-build
> +++ b/scripts/run-scan-build
> @@ -1,6 +1,10 @@
>  #!/bin/sh
>  # Run clang's static analyzer (scan-build) and record its output in outp=
ut-scan-build/
>
> +# Allow overriding binariy names, like clang-12
> +export CC=3D${CC:-clang}
> +SCAN_BUILD=3D${SCAN_BUILD:-scan-build}
> +
>  # Ensure the current directory is where this script is
>  cd "$(dirname -- "$0")" || exit $?
>
> @@ -20,14 +24,24 @@ export PATH=3D"$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DE=
STDIR/sbin:$DESTDIR/bin:$PATH
>  export PYTHONPATH=3D"$DESTDIR$(${PYTHON:-python3} -c "from distutils.sys=
config import *;print(get_python_lib(prefix=3D'/usr'))")"
>  export RUBYLIB=3D"$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["ve=
ndorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorar=
chdir"]')"
>
> +if [ -f /etc/debian_version ]; then
> +    export PYTHON_SETUP_ARGS=3D'--install-layout=3Ddeb'
> +fi
> +
>  # Build and analyze
> -make -C .. CC=3Dclang clean distclean -j"$(nproc)"
> -scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. \
> -    CC=3Dclang \
> +make -C .. clean distclean -j"$(nproc)"
> +$SCAN_BUILD -analyze-headers -o "$OUTPUTDIR" make -C .. \
>      DESTDIR=3D"$DESTDIR" \
> -    CFLAGS=3D"-O2 -Wall -D__CHECKER__ -I$DESTDIR/usr/include" \
> +    CFLAGS=3D"-O2 -Wall -Wextra -D_FORTIFY_SOURCE=3D2 -D__CHECKER__ -I$D=
ESTDIR/usr/include" \
> +    -j"$(nproc)" \
>      install install-pywrap install-rubywrap all test
>
> +if [ $? -eq 0 ]; then
> +    echo "++ Build succeeded"
> +else
> +    echo "++ Build failed"
> +fi
> +
>  # Reduce the verbosity in order to keep the message from scan-build sayi=
ng
>  # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examin=
e bug reports.
>  set +x
> --
> 2.32.0
>
