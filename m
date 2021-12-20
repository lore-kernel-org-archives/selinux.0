Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E85C433EF
	for <selinux@archiver.kernel.org>; Mon, 20 Dec 2021 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhLTSGM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhLTSGL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Dec 2021 13:06:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193DC061574
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:06:11 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so17092212oiw.0
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLVOZ2B9Hcj4MoS/AnJkVBguM50L//q3kX5msgKL8vQ=;
        b=juP2/yoN7yJMb27GeyrCLl5e3Jcxd3EYPbBFpynPY+TOy/q9BsqA9P3JsoUt+g5X5M
         snyRNEZpt67PrahcJGkiOw6Ag6/d8BiDTjUr+NYX3kFacUkHcjFq2OSDd8SuK8ySin9N
         dR9aHjKeLghJ3C6Q6CPEgdcQA4+aXN4mbIFUw1drJIxtL8xYSv8Qf4F6ALK2drSHcA5O
         uEPISV4qb0uK5HLLVFv15FzfaU/HsFhPDoXnoXKaxHpIyDmYXfobtVmfI2LLn/9MXvOm
         IfbFP/dC3afGzyVz3dGk/RJcggep93x4XABt1VAkGUfBI31zPxdz6d6i9yATdxkNd8Du
         Orbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLVOZ2B9Hcj4MoS/AnJkVBguM50L//q3kX5msgKL8vQ=;
        b=grfkAboDIXX9YfXU8mORPF46jr5QkLx0ksYVSuKHDgRoD+5z2gbHbr/37j1JihRx26
         nDQ0D2iyYXcswUH15NxBSg3SDj5OSrEKvVUQd99Ljw0dd2AIHMWTyWiI1Pnaw8IMayNh
         RyKVU2a4QU7n5YyP/F9kQxYtqpFO8RiyMyIngX4ZbnS9r1ZByCzfd62UK+QyWRLQBQfC
         kNypK63CV01ztHYjc4uheEHZDO9dmQNfBFBYEz5n14P5ViPxo9XB1M+zybI7Rqw42bwe
         yhZU4euuT3S1pTbgNXYXHtSOw+IpJal/q4ZwGqdYY/0UGQOce2VgF4WkNfv7grVnq8Jh
         DafQ==
X-Gm-Message-State: AOAM531U2WKA/alPNChxhbOYLLHAqFikpwPcmqLHVeQVQyD3n6RUx6XP
        SLtsEBct/wJO3/eL8B/J9XSx6xcIVkyqb0JeWSCihKym
X-Google-Smtp-Source: ABdhPJw1BSZRkAiz7n4/XMAbVFCfUPHncef510HvdVfaVQ7LHZJKdaltOAL1SI1h1kpjqAQhl+t6FUWTemfvvsAUCu8=
X-Received: by 2002:a05:6808:300d:: with SMTP id ay13mr120065oib.144.1640023570571;
 Mon, 20 Dec 2021 10:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20211115185829.85614-1-evvers@ya.ru>
In-Reply-To: <20211115185829.85614-1-evvers@ya.ru>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 20 Dec 2021 19:05:59 +0100
Message-ID: <CAJ2a_De+JCWFP=vn=OpKKV1qtNwYcMd8yUHzJE+GASRF2PZ07A@mail.gmail.com>
Subject: Re: [PATCH] ci: run the tests under ASan/UBsan on GHActions
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 16 Nov 2021 at 12:59, Evgeny Vereshchagin <evvers@ya.ru> wrote:
>
> It was tested in https://github.com/SELinuxProject/selinux/pull/321 and
> https://github.com/SELinuxProject/selinux/pull/320. In the process
> it discovered a few issues all of which were fixed in
> https://github.com/SELinuxProject/selinux/commit/b98d3c4c53f35cb2ab77dd5b2973591815932620
> https://github.com/SELinuxProject/selinux/commit/ea539017fbbc972a8239a7944eaa5ce4960b0903
> https://github.com/SELinuxProject/selinux/commit/fe01a91a79574c21712fac2c58af1b54b7f3d46b
> https://github.com/SELinuxProject/selinux/commit/f95dbf2c74246f69fbdf0881434567576159e5f6
>
> Now that all the issues are gone it should be safe to turn it on
> to make it easier to automatically catch bugs like that almost as soon as
> they end up in the repository.
>
> Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
> ---

Kindly ping

>  .github/workflows/run_tests.yml | 42 ++++++++++++++++++++-------------
>  libsepol/tests/Makefile         | 10 ++++++--
>  2 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
> index ef4be8af..fd3626da 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -29,6 +29,9 @@ jobs:
>              python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
>            - compiler: clang
>              python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-gold}
> +        include:
> +          - compiler: gcc
> +            python-ruby-version: {python: 3.9, ruby: 2.7, other: sanitizers}
>
>      steps:
>      - uses: actions/checkout@v2
> @@ -88,6 +91,11 @@ jobs:
>          elif [ "${{ matrix.python-ruby-version.other }}" = "test-debug" ] ; then
>              # Test hat debug build works fine
>              EXPLICIT_MAKE_VARS="DEBUG=1"
> +        elif [ "${{ matrix.python-ruby-version.other }}" = "sanitizers" ] ; then
> +            sanitizers='-fsanitize=address,undefined'
> +            EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
> +            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
> +            echo "UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1" >> $GITHUB_ENV
>          else
>              EXPLICIT_MAKE_VARS=
>          fi
> @@ -139,18 +147,18 @@ jobs:
>      - name: Run tests
>        run: |
>          echo "::group::make install"
> -        make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> +        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
>          echo "::endgroup::"
>          echo "::group::make install-pywrap"
> -        make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> +        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
>          echo "::endgroup::"
>          echo "::group::make install-rubywrap"
> -        make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> +        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
>          echo "::endgroup::"
>
>          # Now that everything is installed, run "make all" to build everything which may have not been built
>          echo "::group::make all"
> -        make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
> +        eval make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
>          echo "::endgroup::"
>
>          # Set up environment variables for the tests and show variables (to help debugging issues)
> @@ -164,19 +172,21 @@ jobs:
>
>          # Run tests
>          echo "::group::make test"
> -        make test $EXPLICIT_MAKE_VARS
> +        eval make test $EXPLICIT_MAKE_VARS
>          echo "::endgroup::"
>
> -        # Test Python and Ruby wrappers
> -        echo "::group::Test Python and Ruby wrappers"
> -        $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
> -        $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
> -        echo "::endgroup::"
> -
> -        # Run Python linter, but not on the downloaded refpolicy
> -        echo "::group::scripts/run-flake8"
> -        ./scripts/run-flake8
> -        echo "::endgroup::"
> +        if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
> +            # Test Python and Ruby wrappers
> +            echo "::group::Test Python and Ruby wrappers"
> +            $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
> +            $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
> +            echo "::endgroup::"
> +
> +            # Run Python linter, but not on the downloaded refpolicy
> +            echo "::group::scripts/run-flake8"
> +            ./scripts/run-flake8
> +            echo "::endgroup::"
> +        fi
>
>          echo "::group::Test .gitignore and make clean distclean"
>          # Remove every installed files
> @@ -184,6 +194,6 @@ jobs:
>          # Test that "git status" looks clean, or print a clear error message
>          git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
>          # Clean up everything and show which file needs to be added to "make clean"
> -        make clean distclean $EXPLICIT_MAKE_VARS
> +        eval make clean distclean $EXPLICIT_MAKE_VARS
>          git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
>          echo "::endgroup::"
> diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> index fc9bd1a3..a72c327d 100644
> --- a/libsepol/tests/Makefile
> +++ b/libsepol/tests/Makefile
> @@ -1,3 +1,4 @@
> +ENV ?= env
>  M4 ?= m4
>  MKDIR ?= mkdir
>  EXE ?= libsepol-tests
> @@ -44,10 +45,15 @@ clean:
>         rm -f $(objs) $(EXE)
>         rm -f $(policies)
>         rm -f policies/test-downgrade/policy.hi policies/test-downgrade/policy.lo
> -
>
> +# mkdir is run in a clean environment created by env -i to avoid failing under ASan with:
> +#
> +#   ASan runtime does not come first in initial library list;
> +#   you should either link runtime to your application or manually preload it with LD_PRELOAD
> +#
> +# when the source code is built with ASan
>  test: $(EXE) $(policies)
> -       $(MKDIR) -p policies/test-downgrade
> +       $(ENV) -i $(MKDIR) -p policies/test-downgrade
>         ../../checkpolicy/checkpolicy -M policies/test-cond/refpolicy-base.conf -o policies/test-downgrade/policy.hi
>         ./$(EXE)
>
> --
> 2.31.1
>
