Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48B3DDDD7
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097405; cv=pass; b=Ltwihe90PZGzIc7lWJzNMQGgaZ1sYeuw0bkzvhgsv6iNcseTsE3L8WT4HA9c93aXshQd45nztJfzd/Ew9m6XJyTQPGSGqG0R0evwkHDKgdn7FGjrBnVYW9YGSBZaLcnA8k2kHpVdmoLC61MQE49aQX91nmh5e2KGenQzId+nO5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097405; c=relaxed/simple;
	bh=OeZLGcYtueRdwJAbeCyCM4MEUcaDlSjDjXvEHaycY1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs48tEFe/JMLsKIgeGIk2fmLuCej4Cf1OEZ5ea678YESVdoM08EokmGyWmbCY5ZycMkCffOKR9uIqdJHBNr57eNDO/CY9S1uugPYzpFLehmpGaaM/nVQMQknWV6LfXaFeKzZNdCd+9sxyKnZDpczlL6DIf1mbxLM8xqE4LpKaGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au0v6FK7; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au0v6FK7"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3967726bc47so62295941fa.1
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 06:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097402; cv=none;
        d=google.com; s=arc-20240605;
        b=S8bElFohRAdpwrMJi0G0C/T7g4Mus7WWEkd9CGECG12jov6PBcmh/z756hORYZbJLT
         +CZcVDl3IQ7gXE91UK88YUev09CPP1/DKoJMzE8EiWgHMKrBK3U6+b2mj/2MvQwzOo93
         CzNjDaYRO5ZUhuLWBPLa1FOdZmWNy1urhZI4Ij+WoyVf4Y0JQcGXp4v1lhXdR5w5pa8C
         WBEN+8y1RaoFK6w39K8kj89uKM46eu0ucoeXT0SWKlgWvnwCGuSAOTneaKaxau6TpfwK
         UH5RwDa2s3BfyW/9wnEUNhcu0sEnY6FgFT7AxDaswnDKX4UEq5rImzeM1xXpmbpXB6w8
         q0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gk5r5/Hhk81x7ymCDBYRIBfa4pPdFOL53ZgTpPY08nY=;
        fh=Br7Q3QYCCAjnvhHaund9vV2LCS9SOjHrWaBcZeLdftU=;
        b=Vp6bufi5vyVH2hThkNTTT3rEoKg81nxwGLufCFN+oJQ/eoT2zrmHSYX1PCnF5Doiip
         BiuGmXmR8BGgHdiZNZx7GvklCHZ77Cq22pQi/ofBJiIBys/ujGLRjPlHE4c1xLBqG5Lr
         ZsSRn2IdhqN6tyop+PKKntP8XUGFTlpO2dIygrrJCqSQW1gWBUOEbtFWJrWcNLYdCOA2
         JXI2tz2t+akoSDY8+k9Ui489LuyaM0hV0nso6Cb0tXn8DloOFwsH6qodg2Hk4ao1WNCq
         ui6Hf957WT1/qNzfe8UgWKHN2STZIuMvAszIcJLOdgJJz0hofGr6hesTgpfq2yLROCDk
         3wVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097402; x=1781702202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk5r5/Hhk81x7ymCDBYRIBfa4pPdFOL53ZgTpPY08nY=;
        b=Au0v6FK73ykvaC0lw9wOles1/FmLat/ROarIgA+vYrxsfBYgIyLgES1hD8mYaRckRL
         74pDBi/TRacy0b7hC49ChieeHAaoBd+c8+9alotdqMxydQberLLbDSaMzqNw9qo+lDax
         1Lx6yLDBfMkK3WgmLRcbsgtxtpk/cUKeDdYEbD0SC+gygj3eALDnOLy8BtMMhWXH8c6Y
         BeCCFhUDqtF2OURIh954if+rwP+MvXR2W22xgDg3Uhd2fjwUvzvcWY7206b5hop9fg5F
         FzIZGKGF4tUDl8KcHWJr+qdboNT2z3mh11leHRHatESLmRNl9Uy0h5c55NBoOzxl5DXJ
         IsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097402; x=1781702202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gk5r5/Hhk81x7ymCDBYRIBfa4pPdFOL53ZgTpPY08nY=;
        b=R3YPqGcaRjKz+35uKe2yDhADKOVbHv0yRpW9bsOeIV+lZAdn/vVgsTfAwiO2KLLzn0
         MrXV7Eh74l/cOVG1YrK9Rl1Q7/KwKg+TFytLTD7eoLkXSaVvy77aaUUFdnQTrWBpXzB/
         cAxam7OJ4qPdbghY1YUNmY6fIDW0/8aNJ0pMlkTPonWRqsGve3HlGJLqk4xyrMFtmAeR
         bIXbX33lWVSCOmMmowZrUd9m/8SWUU452Pxz5WVsLwIFN/v2tODj93zR8FM1KtqDKtti
         n7AMGT2CP86ozizc7cb65Q5/84wHEKW2n1r8MBJmPw1dXl5G9hYSwGpHP8TRm0iWyD8l
         bv6Q==
X-Gm-Message-State: AOJu0Yz1QCTuqxd4qktlLZvNtSqsUOwOisLP38Xp1LtFQe6AMAAG1H+U
	K516NEaug8DGAfk/HlKWGJIXc2gaOyfjvM3VQHzSIzbNpBnoiUs0VhG/4O/O714z6dW7VAhSe8A
	V7iU6GY8AAI1NJzbP7ZQEsErvbB7Jz/6sQCvt
X-Gm-Gg: Acq92OG6zJatsio8Ndwmwz8AhmIMhUvMqSPhDSirg/8mTUotkQVk9KOoUiZrifQIv9Z
	XQYmCLih5lRZuEtgzuoie47PdoQcUbDKkyJXi+nNq47HifdxdLSsVeNGokgqQ5h4Q12q+1tEb1q
	Ht1yEXf5tbJLo+Tnwp35K9kSBpefRi8aPALW/PpzIGkOEOpiWl23Um8IYJ+dEVhuQvGpEMp1kFL
	P9SV0C5D7PpCy2s6wUFh5h5wDgAMiMz2Gp4sj927YHoECmOZ6Vcw2tSehrWpSnqP38h+SoFDaeg
	ePGWJYHN63Qy+i8=
X-Received: by 2002:a2e:a989:0:b0:396:6bd5:a9c6 with SMTP id
 38308e7fff4ca-396d09fc199mr65685491fa.14.1781097401999; Wed, 10 Jun 2026
 06:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605171825.362853-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20260605171825.362853-1-chpebeni@linux.microsoft.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 09:16:30 -0400
X-Gm-Features: AVVi8CfWaVKYywAqnLsjkdqA-skGOUxEk1eBQinrHYBgkyyfdwMcEth2MRqAbGU
Message-ID: <CAP+JOzT+h=FJyE81GpL6LRgowzrMkQyXjEF7ZyC7=djcX1Ztzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ci: Refactor build into a custom GH action.
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> This allows other projects (refpolicy, setools, etc.) to reuse these step=
s in their CI pipelines.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .github/actions/build-userspace/action.yml | 139 +++++++++++++++++++++
>  .github/workflows/run_tests.yml            | 114 +----------------
>  2 files changed, 143 insertions(+), 110 deletions(-)
>  create mode 100644 .github/actions/build-userspace/action.yml
>
> diff --git a/.github/actions/build-userspace/action.yml b/.github/actions=
/build-userspace/action.yml
> new file mode 100644
> index 00000000..2e4f513a
> --- /dev/null
> +++ b/.github/actions/build-userspace/action.yml
> @@ -0,0 +1,139 @@
> +name: Build SELinux userspace
> +description: Set up Python, Ruby, install dependencies, and configure th=
e build environment
> +
> +inputs:
> +  python-version:
> +    description: Python version to set up
> +    required: true
> +  ruby-version:
> +    description: Ruby version to set up
> +    required: true
> +  compiler:
> +    description: Compiler to use (gcc or clang)
> +    required: true
> +  other:
> +    description: Additional build variant (test-flags-override, test-deb=
ug, linker-bfd, linker-gold, sanitizers)
> +    required: false
> +    default: ''
> +
> +runs:
> +  using: composite
> +  steps:
> +    - name: Set up Python ${{ inputs.python-version }}
> +      uses: actions/setup-python@v5
> +      with:
> +        python-version: ${{ inputs.python-version }}
> +
> +    - name: Set up Ruby ${{ inputs.ruby-version }}
> +      uses: ruby/setup-ruby@v1
> +      with:
> +        ruby-version: ${{ inputs.ruby-version }}
> +        bundler-cache: true
> +
> +    - name: Install dependencies
> +      run: |
> +        sudo apt-get update -q
> +        sudo apt-get install -qy --no-install-recommends \
> +            bison \
> +            flex \
> +            gawk \
> +            gettext \
> +            libaudit-dev \
> +            libbz2-dev \
> +            libcap-dev \
> +            libcap-ng-dev \
> +            libcunit1-dev \
> +            libdbus-glib-1-dev \
> +            libpcre2-dev \
> +            ruby-dev \
> +            swig \
> +            xmlto
> +
> +        pip install flake8 setuptools build wheel
> +
> +    - name: Install Clang
> +      if: ${{ inputs.compiler =3D=3D 'clang' }}
> +      run: sudo apt-get install -qqy clang
> +
> +    - name: Configure the environment
> +      run: |
> +        DESTDIR=3D/tmp/destdir
> +        echo "PYTHON=3Dpython" >> $GITHUB_ENV
> +        echo "RUBY=3Druby" >> $GITHUB_ENV
> +        echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
> +
> +        CC=3D${{ matrix.compiler }}
> +        if [ "${{ matrix.python-ruby-version.other }}" =3D "linker-bfd" =
] ; then
> +            CC=3D"$CC -fuse-ld=3Dbfd"
> +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-gol=
d" ] ; then
> +            CC=3D"$CC -fuse-ld=3Dgold"
> +        fi
> +        # https://bugs.ruby-lang.org/issues/18616
> +        # https://github.com/llvm/llvm-project/issues/49958
> +        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.py=
thon-ruby-version.ruby }}" =3D 3* ]] ; then
> +            CC=3D"$CC -fdeclspec"
> +        fi
> +        echo "CC=3D$CC" >> $GITHUB_ENV
> +
> +        EXPLICIT_MAKE_VARS=3D
> +        if [ "${{ matrix.python-ruby-version.other }}" =3D "test-flags-o=
verride" ] ; then
> +            # Test that overriding CFLAGS, LDFLAGS and other variables w=
orks fine
> +            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D-I$DESTDIR/usr/include LDFLAG=
S=3D-L$DESTDIR/usr/lib LDLIBS=3D CPPFLAGS=3D"
> +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "test-debug=
" ] ; then
> +            # Test hat debug build works fine
> +            EXPLICIT_MAKE_VARS=3D"DEBUG=3D1"
> +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "sanitizers=
" ] ; then
> +            sanitizers=3D'-fsanitize=3Daddress,undefined'
> +            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D'-g -I$DESTDIR/usr/include $s=
anitizers' LDFLAGS=3D'-L$DESTDIR/usr/lib $sanitizers' LDLIBS=3D CPPFLAGS=3D=
 OPT_SUBDIRS=3D"
> +            echo "ASAN_OPTIONS=3Dstrict_string_checks=3D1:detect_stack_u=
se_after_return=3D1:check_initialization_order=3D1:strict_init_order=3D1" >=
> $GITHUB_ENV
> +            echo "UBSAN_OPTIONS=3Dprint_stacktrace=3D1:print_summary=3D1=
:halt_on_error=3D1" >> $GITHUB_ENV
> +        else
> +            EXPLICIT_MAKE_VARS=3D
> +        fi
> +        echo "EXPLICIT_MAKE_VARS=3D${EXPLICIT_MAKE_VARS}" >> $GITHUB_ENV
> +
> +        # Find files in order of pkgconf to be able to find Python.h
> +        # For example with Python 3.5:
> +        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x64/=
bin/python
> +        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
> +        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/x6=
4/include/python3.5m/Python.h
> +        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.5.=
10/x64/lib/pkgconfig/python-3.5.pc
> +        PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)')=
"
> +        echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $=
GITHUB_ENV
> +
> +        if [[ "${{ matrix.python-ruby-version.python }}" =3D=3D pypy* ]]=
 ; then
> +            # PyPy does not provide a config file for pkg-config
> +            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and =
bin/libpypy3-c.so for PyPy3
> +            echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
> +            echo "PYLIBS=3D-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GIT=
HUB_ENV
> +        fi
> +
> +        # Display the final environment file, for debugging purpose
> +        cat $GITHUB_ENV
> +
> +    - name: Display versions
> +      run: |
> +        echo "::group::Compiler ($CC):"
> +        $CC --version
> +        echo "::endgroup::"
> +        echo "::group::Python ($(which "$PYTHON")):"
> +        $PYTHON --version
> +        echo "::endgroup::"
> +        echo "::group::Ruby ($(which "$RUBY")):"
> +        $RUBY --version
> +        echo "::endgroup::"
> +
> +    - name: Build SELinux userspace
> +      run: |
> +        echo "::group::make install"
> +        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> +        echo "::endgroup::"
> +        echo "::group::make install"
> +        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> +        echo "::endgroup::"
> +        echo "::group::make install-pywrap"
> +        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> +        echo "::endgroup::"
> +        echo "::group::make install-rubywrap"
> +        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> +        echo "::endgroup::"
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index 82c44fcc..f4aa1a4c 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -41,97 +41,13 @@ jobs:
>      steps:
>      - uses: actions/checkout@v4
>
> -    - name: Set up Python ${{ matrix.python-ruby-version.python }}
> -      uses: actions/setup-python@v5
> +    - name: Build userspace
> +      uses: ./.github/actions/build-userspace
>        with:
>          python-version: ${{ matrix.python-ruby-version.python }}
> -
> -    - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
> -      uses: ruby/setup-ruby@v1
> -      with:
>          ruby-version: ${{ matrix.python-ruby-version.ruby }}
> -        bundler-cache: true
> -
> -    - name: Install dependencies
> -      run: |
> -        sudo apt-get update -q
> -        sudo apt-get install -qy --no-install-recommends \
> -            bison \
> -            flex \
> -            gawk \
> -            gettext \
> -            libaudit-dev \
> -            libbz2-dev \
> -            libcap-dev \
> -            libcap-ng-dev \
> -            libcunit1-dev \
> -            libdbus-glib-1-dev \
> -            libpcre2-dev \
> -            ruby-dev \
> -            swig \
> -            xmlto
> -
> -        pip install flake8 setuptools build wheel
> -
> -    - name: Install Clang
> -      if: ${{ matrix.compiler =3D=3D 'clang' }}
> -      run: sudo apt-get install -qqy clang
> -
> -    - name: Configure the environment
> -      run: |
> -        DESTDIR=3D/tmp/destdir
> -        echo "PYTHON=3Dpython" >> $GITHUB_ENV
> -        echo "RUBY=3Druby" >> $GITHUB_ENV
> -        echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
> -
> -        CC=3D${{ matrix.compiler }}
> -        if [ "${{ matrix.python-ruby-version.other }}" =3D "linker-bfd" =
] ; then
> -            CC=3D"$CC -fuse-ld=3Dbfd"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-gol=
d" ] ; then
> -            CC=3D"$CC -fuse-ld=3Dgold"
> -        fi
> -        # https://bugs.ruby-lang.org/issues/18616
> -        # https://github.com/llvm/llvm-project/issues/49958
> -        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.py=
thon-ruby-version.ruby }}" =3D 3* ]] ; then
> -            CC=3D"$CC -fdeclspec"
> -        fi
> -        echo "CC=3D$CC" >> $GITHUB_ENV
> -
> -        EXPLICIT_MAKE_VARS=3D
> -        if [ "${{ matrix.python-ruby-version.other }}" =3D "test-flags-o=
verride" ] ; then
> -            # Test that overriding CFLAGS, LDFLAGS and other variables w=
orks fine
> -            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D-I$DESTDIR/usr/include LDFLAG=
S=3D-L$DESTDIR/usr/lib LDLIBS=3D CPPFLAGS=3D"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "test-debug=
" ] ; then
> -            # Test hat debug build works fine
> -            EXPLICIT_MAKE_VARS=3D"DEBUG=3D1"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "sanitizers=
" ] ; then
> -            sanitizers=3D'-fsanitize=3Daddress,undefined'
> -            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D'-g -I$DESTDIR/usr/include $s=
anitizers' LDFLAGS=3D'-L$DESTDIR/usr/lib $sanitizers' LDLIBS=3D CPPFLAGS=3D=
 OPT_SUBDIRS=3D"
> -            echo "ASAN_OPTIONS=3Dstrict_string_checks=3D1:detect_stack_u=
se_after_return=3D1:check_initialization_order=3D1:strict_init_order=3D1" >=
> $GITHUB_ENV
> -            echo "UBSAN_OPTIONS=3Dprint_stacktrace=3D1:print_summary=3D1=
:halt_on_error=3D1" >> $GITHUB_ENV
> -        else
> -            EXPLICIT_MAKE_VARS=3D
> -        fi
> -        echo "EXPLICIT_MAKE_VARS=3D${EXPLICIT_MAKE_VARS}" >> $GITHUB_ENV
> -
> -        # Find files in order of pkgconf to be able to find Python.h
> -        # For example with Python 3.5:
> -        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x64/=
bin/python
> -        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
> -        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/x6=
4/include/python3.5m/Python.h
> -        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.5.=
10/x64/lib/pkgconfig/python-3.5.pc
> -        PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)')=
"
> -        echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $=
GITHUB_ENV
> -
> -        if [[ "${{ matrix.python-ruby-version.python }}" =3D=3D pypy* ]]=
 ; then
> -            # PyPy does not provide a config file for pkg-config
> -            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and =
bin/libpypy3-c.so for PyPy3
> -            echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
> -            echo "PYLIBS=3D-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GIT=
HUB_ENV
> -        fi
> -
> -        # Display the final environment file, for debugging purpose
> -        cat $GITHUB_ENV
> +        compiler: ${{ matrix.compiler }}
> +        other: ${{ matrix.python-ruby-version.other }}
>
>      - name: Download and install refpolicy headers for sepolgen tests
>        run: |
> @@ -145,30 +61,8 @@ jobs:
>          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/=
src/sepolgen/module.py
>          rm -r refpolicy refpolicy.tar.bz2
>
> -    - name: Display versions
> -      run: |
> -        echo "::group::Compiler ($CC):"
> -        $CC --version
> -        echo "::endgroup::"
> -        echo "::group::Python ($(which "$PYTHON")):"
> -        $PYTHON --version
> -        echo "::endgroup::"
> -        echo "::group::Ruby ($(which "$RUBY")):"
> -        $RUBY --version
> -        echo "::endgroup::"
> -
>      - name: Run tests
>        run: |
> -        echo "::group::make install"
> -        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> -        echo "::endgroup::"
> -        echo "::group::make install-pywrap"
> -        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> -        echo "::endgroup::"
> -        echo "::group::make install-rubywrap"
> -        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> -        echo "::endgroup::"
> -
>          # Now that everything is installed, run "make all" to build ever=
ything which may have not been built
>          echo "::group::make all"
>          eval make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
> --
> 2.54.0
>
>
