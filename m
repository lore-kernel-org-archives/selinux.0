Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D3C19F2A
	for <selinux@archiver.kernel.org>; Thu, 11 Aug 2022 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiHKROC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiHKRNl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Aug 2022 13:13:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51775252BB
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 09:55:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j5so16326423oih.6
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=D17GdxCU4LJVFFa8lFaIk+u9vWaKInqpidXcdeZs2es=;
        b=WY5lPXzfy9t5tRDH1dXLAtdMrC6ZtNmgk24DL86VdMZ+zmULUL0wFG07je4xX1gDx7
         HrDo5278UcophOdWgd1CKzfN3UFeGeGtrwbT+BJEGgI+yHYQunawA+HSgFAcQOIK70sj
         XceWXU2zy/cpp0dt3zO7rP9mBqhCJ3i403pkzibnNo/+tUiuo7pnDvfrrNnAgEaXKs0c
         sAGHuZ4DiqXojrtmf/f5aGf90m8xGVszpPgbJRh9DPPUA34OfyYjzk0GeRLaCa3kn0j4
         10riTNyW7pi7xqgkYD/Ew3QlK2yHZMOKnNEj1L1v040LkEgWfSyUC+VDr+5ul+MOd+UZ
         /1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=D17GdxCU4LJVFFa8lFaIk+u9vWaKInqpidXcdeZs2es=;
        b=MGTZkYH3olf+tkZShAvYyTl3jG80B3G2KAkC1Ppggb+eE7DnfrauEdbd4UE3wflE6X
         gcsJ6rCAF3nkrojYIbtZyI8oG8F0jR9ILY6PymgBpBmBY63nYtfJ30qqpTmJgiwiKEjh
         89cT7WuKPkmB/lvAY0uvm8CxvaPgDZrbAPbSpCbDgmnUwoBmeii4VrGNNQW/DSqdh/ND
         EpEfZE2QGpc9TulABT/DMpUlskkz6WocIy7fmdcxqeMFrf07tQg9juiuhFMAYt0JcUT5
         Vfabm7wprAde9dwfBKs/i9XgzCGjrxFmGXJrWfC6iBBalSKWDofYJgjEH9Mj1DMWAJVQ
         qyBg==
X-Gm-Message-State: ACgBeo0kcATf9Ekfv6vNEPK1ydz9cqr8Nf2IPJaiXFMBta4aZ1s67MYR
        nfoP9HiXtucabkwpdKi+VOhYcmnRHriW+bJD7zWDKE4LEPI=
X-Google-Smtp-Source: AA6agR7LviuA8NTYAqn1u+fcrNSPK4aMLb7z6jw+EfpABr4aC625w4OH/FCeiw8CSkD2cEQTFFdjBwLMRzJp27ptnbE=
X-Received: by 2002:a05:6808:9b9:b0:343:b4d:592f with SMTP id
 e25-20020a05680809b900b003430b4d592fmr4098081oig.156.1660236918610; Thu, 11
 Aug 2022 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220808173655.16867-1-cgzones@googlemail.com>
In-Reply-To: <20220808173655.16867-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 11 Aug 2022 12:55:07 -0400
Message-ID: <CAP+JOzSSptmKyETXZakgEGogdxdAaDqGT06uPyspk4jKETtF6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] ci: bump versions in GitHub Actions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 8, 2022 at 1:38 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * Move from deprecated actions/setup-ruby to ruby/setup-ruby.
> * Bump python and ruby upper versions.
> * Bump Reference Policy version
> * Do not install recommend packages and output package resolution
> * Bump to macOS 12
>
>   macOS 10 is deprecated since 5/31/22 [1].
>   VirtualBox and Vagrant seems to be supported [2][3].
>
> [1]: https://github.com/actions/virtual-environments/issues/5583
> [2]: https://github.com/actions/virtual-environments/pull/5594
> [3]: https://github.com/actions/virtual-environments/pull/5854
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .github/workflows/run_tests.yml    | 62 +++++++++++++++++-------------
>  .github/workflows/vm_testsuite.yml |  5 +--
>  2 files changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index 8b7cb720..db0e1af5 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -10,48 +10,51 @@ jobs:
>        matrix:
>          compiler: [gcc, clang]
>          python-ruby-version:
> -          - {python: 3.9, ruby: 2.7}
> -          - {python: 3.9, ruby: 2.7, other: test-flags-override}
> -          - {python: 3.9, ruby: 2.7, other: test-debug}
> -          - {python: 3.9, ruby: 2.7, other: linker-bfd}
> -          - {python: 3.9, ruby: 2.7, other: linker-gold}
> +          - {python: '3.10', ruby: '3.1'}
> +          - {python: '3.10', ruby: '3.1', other: test-flags-override}
> +          - {python: '3.10', ruby: '3.1', other: test-debug}
> +          - {python: '3.10', ruby: '3.1', other: linker-bfd}
> +          - {python: '3.10', ruby: '3.1', other: linker-gold}
>            # Test several Python versions with the latest Ruby version
> -          - {python: 3.8, ruby: 2.7}
> -          - {python: 3.7, ruby: 2.7}
> -          - {python: 3.6, ruby: 2.7}
> -          - {python: 3.5, ruby: 2.7}
> -          - {python: pypy3, ruby: 2.7}
> +          - {python: '3.9', ruby: '3.1'}
> +          - {python: '3.8', ruby: '3.1'}
> +          - {python: '3.7', ruby: '3.1'}
> +          - {python: '3.6', ruby: '3.1'}
> +          - {python: '3.5', ruby: '3.1'}
> +          - {python: 'pypy3.7', ruby: '3.1'}
>            # Test several Ruby versions with the latest Python version
> -          - {python: 3.9, ruby: 2.6}
> -          - {python: 3.9, ruby: 2.5}
> +          - {python: '3.10', ruby: '3.0'}
> +          - {python: '3.10', ruby: '2.7'}
> +          - {python: '3.10', ruby: '2.6'}
> +          - {python: '3.10', ruby: '2.5'}
>          exclude:
>            - compiler: clang
> -            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-=
bfd}
> +            python-ruby-version: {python: '3.10', ruby: '3.1', other: li=
nker-bfd}
>            - compiler: clang
> -            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-=
gold}
> +            python-ruby-version: {python: '3.10', ruby: '3.1', other: li=
nker-gold}
>          include:
>            - compiler: gcc
> -            python-ruby-version: {python: 3.9, ruby: 2.7, other: sanitiz=
ers}
> +            python-ruby-version: {python: '3.10', ruby: '3.1', other: sa=
nitizers}
>
>      steps:
> -    - uses: actions/checkout@v2
> +    - uses: actions/checkout@v3
>
>      - name: Set up Python ${{ matrix.python-ruby-version.python }}
> -      uses: actions/setup-python@v2
> +      uses: actions/setup-python@v4
>        with:
>          python-version: ${{ matrix.python-ruby-version.python }}
>
>      - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
> -      uses: actions/setup-ruby@v1
> +      uses: ruby/setup-ruby@v1
>        with:
>          ruby-version: ${{ matrix.python-ruby-version.ruby }}
> +        bundler-cache: true
>
>      - name: Install dependencies
>        run: |
> -        sudo apt-get update -qq
> -        sudo apt-get install -qqy \
> +        sudo apt-get update -q
> +        sudo apt-get install -qy --no-install-recommends \
>              bison \
> -            clang \
>              flex \
>              gawk \
>              gettext \
> @@ -61,14 +64,16 @@ jobs:
>              libcunit1-dev \
>              libdbus-glib-1-dev \
>              libpcre2-dev \
> -            python3-dev \
> -            python-dev \
>              ruby-dev \
>              swig \
>              xmlto
>
>          pip install flake8
>
> +    - name: Install Clang
> +      if: ${{ matrix.compiler =3D=3D 'clang' }}
> +      run: sudo apt-get install -qqy clang
> +
>      - name: Configure the environment
>        run: |
>          DESTDIR=3D/tmp/destdir
> @@ -82,6 +87,11 @@ jobs:
>          elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-gol=
d" ] ; then
>              CC=3D"$CC -fuse-ld=3Dgold"
>          fi
> +        # https://bugs.ruby-lang.org/issues/18616
> +        # https://github.com/llvm/llvm-project/issues/49958
> +        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.py=
thon-ruby-version.ruby }}" =3D 3* ]] ; then
> +            CC=3D"$CC -fdeclspec"
> +        fi
>          echo "CC=3D$CC" >> $GITHUB_ENV
>
>          EXPLICIT_MAKE_VARS=3D
> @@ -110,7 +120,7 @@ jobs:
>          PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)')=
"
>          echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $=
GITHUB_ENV
>
> -        if [ "${{ matrix.python-ruby-version.python }}" =3D "pypy3" ] ; =
then
> +        if [[ "${{ matrix.python-ruby-version.python }}" =3D pypy* ]] ; =
then
>              # PyPy does not provide a config file for pkg-config
>              # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and =
bin/libpypy3-c.so for PyPy3
>              echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
> @@ -122,10 +132,10 @@ jobs:
>
>      - name: Download and install refpolicy headers for sepolgen tests
>        run: |
> -        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.c=
om/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-=
2.20180701.tar.bz2
> +        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.c=
om/SELinuxProject/refpolicy/releases/download/RELEASE_2_20220520/refpolicy-=
2.20220520.tar.bz2
>          tar -xvjf refpolicy.tar.bz2
>          sed -e "s,^PREFIX :=3D.*,PREFIX :=3D $DESTDIR/usr," -i refpolicy=
/support/Makefile.devel
> -        sudo make -C refpolicy install-headers clean
> +        sudo make -C refpolicy install-headers bare
>          sudo mkdir -p /etc/selinux
>          echo 'SELINUXTYPE=3Drefpolicy' | sudo tee /etc/selinux/config
>          echo 'SELINUX_DEVEL_PATH =3D /usr/share/selinux/refpolicy' | sud=
o tee /etc/selinux/sepolgen.conf
> diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_te=
stsuite.yml
> index 601276dd..92155da2 100644
> --- a/.github/workflows/vm_testsuite.yml
> +++ b/.github/workflows/vm_testsuite.yml
> @@ -6,11 +6,10 @@ jobs:
>    vm_testsuite:
>
>      # Use VirtualBox+vagrant on macOS, as described in https://github.co=
m/actions/virtual-environments/issues/433
> -    # Use an old version of macOS until https://github.com/actions/virtu=
al-environments/pull/4010 is merged.
> -    runs-on: macos-10.15
> +    runs-on: macos-12
>
>      steps:
> -    - uses: actions/checkout@v2
> +    - uses: actions/checkout@v3
>
>      - name: Create Vagrant VM
>        run: |
> --
> 2.36.1
>
