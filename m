Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EF40861A
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103214; cv=pass; b=Qk4gw5FqwZy/m7h5xP2UE0EpYSzVnUeyrxkNnzdXg3zDSKmL0uqcBbVNQFG7/+7En73yWJ+8b/+Q8u4GUFdy8tZ3Bq8AlL+8lWMdQ4c7snMsYxzc2WCL2fYUTvvG9IGuiFtcBtw6dxehn6UB1n2qtvC8vCZzO4afN+tlePEFXbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103214; c=relaxed/simple;
	bh=41tMJ0U7hSbdFN1tq8NMMnMskTOoITzufgwp6SslRt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M18cSmCYbOn86H5X8qMxoKFsgHKNbdRTP6uK3knmXeTzIoDlg9ON2Kq1rjmHKQdCIqPcpb0aFqORgcoChS+8rMfIj4ahCWHeCJQ27NidHkvw2hLpKHrQTAGWWIdgVN9SlpeaQea9fvp3W6ZafkNuryD89C2C9Bv3rz2vgdA/nCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrTYNVOg; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrTYNVOg"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-396775c2720so63015451fa.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103211; cv=none;
        d=google.com; s=arc-20240605;
        b=jsPAnnkBZ3nbBLmoTCq7PJkcclYk4Mx5cMLc/CtLX2iQeMjKXT+HfczWkZ8k87hPkP
         OE9rG6VwPvvdCjTw0Hpvxo8D+QsPohacwTRYhaxScxwkypkY8cRb74irA5y6RboWoeNj
         6m8NxrXwjxS7n/8bXQMhkB7cDyU6GkyxXV4dY2spjJuvKbasmpwjans3g9RyQavxlCpz
         VnPUe0EKZLHvMTKdPZk1KIR+yptSlvFlw+ZVTjJiPfNg2viaYKQnNskf4cEZ97WGkXta
         jLttw7Z15/TW1j3EhO8gc3Qfmz4PT53xAOGnu14J7zwZHtpfZqP/aTyGOBC5q4Jxxz1K
         gpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VogZR2JhXV3obvwdQu+gKuoqxjRZG19QYxyefLJxx6Y=;
        fh=Br7Q3QYCCAjnvhHaund9vV2LCS9SOjHrWaBcZeLdftU=;
        b=EAl5VQ59vvaqrFsoB1IoIb7avXcLXM+nLyMFbs6wAU0P4lPCYGw+aVvFOX9+F1HdFU
         PC0zSr3ClZbviwkb+Y3/3C9j28zEYNnL1ZZlhk5FkkB5JgTZdxmCm83/jfOdysNlnlfe
         ASXDj1+EV44138cfDurZUaLKnNaGeHGYxcJ6kGwqIrp6IcOk/nlx3E2iozFn7AXSBXZZ
         +QW3TJvVVKp0jgBjTJhv4h7K4PqAp2xMq1GgNT7ffblDUD39jriLszcfCY3/rMqX3yJh
         Mu1FpFDeDpq3YVgP/YCIM/63KY1lGNCgfMo3laHxQWXsoxxDSBc5rSoFlAFYeJntitlt
         6HxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103211; x=1781708011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VogZR2JhXV3obvwdQu+gKuoqxjRZG19QYxyefLJxx6Y=;
        b=PrTYNVOgSgPGuI+CVmAzOSVlrZQvM80MSDb5nGt5+v98IRlzmFUd6pQqE25PaW62ur
         5tC3Ws5YV/E0mjYBRS+Z6+chRVLQo+JRb0B1raArQ5yoPC2dj1VAX8qFAGJNIV8B6Xnn
         NHSeIBKqVBpWR3LxJnGWE1HYK/rFAk/ZbRLiOYo+jlbLnDJjCa3HN9CBfsn7U6gwLNHm
         vhZAYpG0SbLTU2DFaADVH/6IKgCW5+dyIKKcobXNPefGEdkoVQLmklQFWoFmZFuTBaDa
         UwTZn/tUcv4RxSP/4aweWhqlKZDflUnWbXfTycj4TPwT5F1mQdTd8j3CUVtJjNrbmDkF
         Cjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103211; x=1781708011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VogZR2JhXV3obvwdQu+gKuoqxjRZG19QYxyefLJxx6Y=;
        b=Cu1Qgb191E6qMgMEYJf53sYNNsEY41cnI4iRVrG1iQyJzvS12im7m3T1wpYEkDS3LU
         xjbBuIVQuCYHCqpKT/hIhv4noJHdXVuiYFJdgambKLms5zxhobnXLTpWyd5ptvOol/sG
         si3QC9RivBEZ0hCq6OIgOwXTycySUdfSVgCzTxpZp/bEnz0TTKaG4sxDBWyIWY34utR0
         wICr4uZT2CyP0ERcbN69dtki8ThB02/FZ/GxFeatnD8XEiJ1M1qXiVcD+Uul5s2rG+fL
         oRM/qzwQgSFKCp53VMVo49W0E5jfq5fxzUkaIldRO3nNWPav5JbM2z5nWnYqgx1NG/vd
         rCJA==
X-Gm-Message-State: AOJu0Yx3aNhTcZ/UjQoJz70+eiY8eSSWb49NFPNfut4dABKXTe41z4Zh
	m0yk/XMqWR6Z/r3Z3ly1YQdc0pX3D2O7l/TbvlCmFT2Uwr3ZhoFX4Sr4AT0iIC8bOVdINTKjf0d
	dIpzifWWsAXWeKve5mXsCbNauPov/dNFp0g==
X-Gm-Gg: Acq92OFcu6+EqQZ3YgVDge57t2gbd7zWCc0wohtML4anLf1Ueb1+upBtKVq17e/n3EP
	COubIza+/G+qZH3qeCS7N5KuiJPPcUnAvkovjtMJPiJ6E09LVOPDAX824/9wBQa8sfHFcg7F0Xp
	Wa6wZjNYxJvWLPKehz+YrQnDk15hqJZB4jjUFvW3ug9kFXyJp48UkBCQwza53VGIZxZpPvnVQRT
	1gVFXADOLIoFs4wszU+OxHaIstYtifyjwkGD8GTo60hAa1F5cmwk4xiPMzSs0hJxiun73QjOH51
	X2XysWlyouPHmK0=
X-Received: by 2002:a05:6512:124c:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5aa87b5b614mr7547592e87.16.1781103209122; Wed, 10 Jun 2026
 07:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605171825.362853-1-chpebeni@linux.microsoft.com> <CAP+JOzT+h=FJyE81GpL6LRgowzrMkQyXjEF7ZyC7=djcX1Ztzw@mail.gmail.com>
In-Reply-To: <CAP+JOzT+h=FJyE81GpL6LRgowzrMkQyXjEF7ZyC7=djcX1Ztzw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:53:17 -0400
X-Gm-Features: AVVi8Ccd_-LHGnptbOsyjnde1XU9b9s0fKyV6ErfjJKpgqH4Vf-lk4maTpStnM8
Message-ID: <CAP+JOzSCcRvSTw=heyX8jDLCWZYhPpjm0UADnnU=W0_5_A9npg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ci: Refactor build into a custom GH action.
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > This allows other projects (refpolicy, setools, etc.) to reuse these st=
eps in their CI pipelines.
> >
> > Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  .github/actions/build-userspace/action.yml | 139 +++++++++++++++++++++
> >  .github/workflows/run_tests.yml            | 114 +----------------
> >  2 files changed, 143 insertions(+), 110 deletions(-)
> >  create mode 100644 .github/actions/build-userspace/action.yml
> >
> > diff --git a/.github/actions/build-userspace/action.yml b/.github/actio=
ns/build-userspace/action.yml
> > new file mode 100644
> > index 00000000..2e4f513a
> > --- /dev/null
> > +++ b/.github/actions/build-userspace/action.yml
> > @@ -0,0 +1,139 @@
> > +name: Build SELinux userspace
> > +description: Set up Python, Ruby, install dependencies, and configure =
the build environment
> > +
> > +inputs:
> > +  python-version:
> > +    description: Python version to set up
> > +    required: true
> > +  ruby-version:
> > +    description: Ruby version to set up
> > +    required: true
> > +  compiler:
> > +    description: Compiler to use (gcc or clang)
> > +    required: true
> > +  other:
> > +    description: Additional build variant (test-flags-override, test-d=
ebug, linker-bfd, linker-gold, sanitizers)
> > +    required: false
> > +    default: ''
> > +
> > +runs:
> > +  using: composite
> > +  steps:
> > +    - name: Set up Python ${{ inputs.python-version }}
> > +      uses: actions/setup-python@v5
> > +      with:
> > +        python-version: ${{ inputs.python-version }}
> > +
> > +    - name: Set up Ruby ${{ inputs.ruby-version }}
> > +      uses: ruby/setup-ruby@v1
> > +      with:
> > +        ruby-version: ${{ inputs.ruby-version }}
> > +        bundler-cache: true
> > +
> > +    - name: Install dependencies
> > +      run: |
> > +        sudo apt-get update -q
> > +        sudo apt-get install -qy --no-install-recommends \
> > +            bison \
> > +            flex \
> > +            gawk \
> > +            gettext \
> > +            libaudit-dev \
> > +            libbz2-dev \
> > +            libcap-dev \
> > +            libcap-ng-dev \
> > +            libcunit1-dev \
> > +            libdbus-glib-1-dev \
> > +            libpcre2-dev \
> > +            ruby-dev \
> > +            swig \
> > +            xmlto
> > +
> > +        pip install flake8 setuptools build wheel
> > +
> > +    - name: Install Clang
> > +      if: ${{ inputs.compiler =3D=3D 'clang' }}
> > +      run: sudo apt-get install -qqy clang
> > +
> > +    - name: Configure the environment
> > +      run: |
> > +        DESTDIR=3D/tmp/destdir
> > +        echo "PYTHON=3Dpython" >> $GITHUB_ENV
> > +        echo "RUBY=3Druby" >> $GITHUB_ENV
> > +        echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
> > +
> > +        CC=3D${{ matrix.compiler }}
> > +        if [ "${{ matrix.python-ruby-version.other }}" =3D "linker-bfd=
" ] ; then
> > +            CC=3D"$CC -fuse-ld=3Dbfd"
> > +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-g=
old" ] ; then
> > +            CC=3D"$CC -fuse-ld=3Dgold"
> > +        fi
> > +        # https://bugs.ruby-lang.org/issues/18616
> > +        # https://github.com/llvm/llvm-project/issues/49958
> > +        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.=
python-ruby-version.ruby }}" =3D 3* ]] ; then
> > +            CC=3D"$CC -fdeclspec"
> > +        fi
> > +        echo "CC=3D$CC" >> $GITHUB_ENV
> > +
> > +        EXPLICIT_MAKE_VARS=3D
> > +        if [ "${{ matrix.python-ruby-version.other }}" =3D "test-flags=
-override" ] ; then
> > +            # Test that overriding CFLAGS, LDFLAGS and other variables=
 works fine
> > +            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D-I$DESTDIR/usr/include LDFL=
AGS=3D-L$DESTDIR/usr/lib LDLIBS=3D CPPFLAGS=3D"
> > +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "test-deb=
ug" ] ; then
> > +            # Test hat debug build works fine
> > +            EXPLICIT_MAKE_VARS=3D"DEBUG=3D1"
> > +        elif [ "${{ matrix.python-ruby-version.other }}" =3D "sanitize=
rs" ] ; then
> > +            sanitizers=3D'-fsanitize=3Daddress,undefined'
> > +            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D'-g -I$DESTDIR/usr/include =
$sanitizers' LDFLAGS=3D'-L$DESTDIR/usr/lib $sanitizers' LDLIBS=3D CPPFLAGS=
=3D OPT_SUBDIRS=3D"
> > +            echo "ASAN_OPTIONS=3Dstrict_string_checks=3D1:detect_stack=
_use_after_return=3D1:check_initialization_order=3D1:strict_init_order=3D1"=
 >> $GITHUB_ENV
> > +            echo "UBSAN_OPTIONS=3Dprint_stacktrace=3D1:print_summary=
=3D1:halt_on_error=3D1" >> $GITHUB_ENV
> > +        else
> > +            EXPLICIT_MAKE_VARS=3D
> > +        fi
> > +        echo "EXPLICIT_MAKE_VARS=3D${EXPLICIT_MAKE_VARS}" >> $GITHUB_E=
NV
> > +
> > +        # Find files in order of pkgconf to be able to find Python.h
> > +        # For example with Python 3.5:
> > +        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x6=
4/bin/python
> > +        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
> > +        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/=
x64/include/python3.5m/Python.h
> > +        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.=
5.10/x64/lib/pkgconfig/python-3.5.pc
> > +        PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)=
')"
> > +        echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >>=
 $GITHUB_ENV
> > +
> > +        if [[ "${{ matrix.python-ruby-version.python }}" =3D=3D pypy* =
]] ; then
> > +            # PyPy does not provide a config file for pkg-config
> > +            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy an=
d bin/libpypy3-c.so for PyPy3
> > +            echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_E=
NV
> > +            echo "PYLIBS=3D-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $G=
ITHUB_ENV
> > +        fi
> > +
> > +        # Display the final environment file, for debugging purpose
> > +        cat $GITHUB_ENV
> > +
> > +    - name: Display versions
> > +      run: |
> > +        echo "::group::Compiler ($CC):"
> > +        $CC --version
> > +        echo "::endgroup::"
> > +        echo "::group::Python ($(which "$PYTHON")):"
> > +        $PYTHON --version
> > +        echo "::endgroup::"
> > +        echo "::group::Ruby ($(which "$RUBY")):"
> > +        $RUBY --version
> > +        echo "::endgroup::"
> > +
> > +    - name: Build SELinux userspace
> > +      run: |
> > +        echo "::group::make install"
> > +        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> > +        echo "::endgroup::"
> > +        echo "::group::make install"
> > +        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> > +        echo "::endgroup::"
> > +        echo "::group::make install-pywrap"
> > +        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> > +        echo "::endgroup::"
> > +        echo "::group::make install-rubywrap"
> > +        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> > +        echo "::endgroup::"
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index 82c44fcc..f4aa1a4c 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -41,97 +41,13 @@ jobs:
> >      steps:
> >      - uses: actions/checkout@v4
> >
> > -    - name: Set up Python ${{ matrix.python-ruby-version.python }}
> > -      uses: actions/setup-python@v5
> > +    - name: Build userspace
> > +      uses: ./.github/actions/build-userspace
> >        with:
> >          python-version: ${{ matrix.python-ruby-version.python }}
> > -
> > -    - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
> > -      uses: ruby/setup-ruby@v1
> > -      with:
> >          ruby-version: ${{ matrix.python-ruby-version.ruby }}
> > -        bundler-cache: true
> > -
> > -    - name: Install dependencies
> > -      run: |
> > -        sudo apt-get update -q
> > -        sudo apt-get install -qy --no-install-recommends \
> > -            bison \
> > -            flex \
> > -            gawk \
> > -            gettext \
> > -            libaudit-dev \
> > -            libbz2-dev \
> > -            libcap-dev \
> > -            libcap-ng-dev \
> > -            libcunit1-dev \
> > -            libdbus-glib-1-dev \
> > -            libpcre2-dev \
> > -            ruby-dev \
> > -            swig \
> > -            xmlto
> > -
> > -        pip install flake8 setuptools build wheel
> > -
> > -    - name: Install Clang
> > -      if: ${{ matrix.compiler =3D=3D 'clang' }}
> > -      run: sudo apt-get install -qqy clang
> > -
> > -    - name: Configure the environment
> > -      run: |
> > -        DESTDIR=3D/tmp/destdir
> > -        echo "PYTHON=3Dpython" >> $GITHUB_ENV
> > -        echo "RUBY=3Druby" >> $GITHUB_ENV
> > -        echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
> > -
> > -        CC=3D${{ matrix.compiler }}
> > -        if [ "${{ matrix.python-ruby-version.other }}" =3D "linker-bfd=
" ] ; then
> > -            CC=3D"$CC -fuse-ld=3Dbfd"
> > -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-g=
old" ] ; then
> > -            CC=3D"$CC -fuse-ld=3Dgold"
> > -        fi
> > -        # https://bugs.ruby-lang.org/issues/18616
> > -        # https://github.com/llvm/llvm-project/issues/49958
> > -        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.=
python-ruby-version.ruby }}" =3D 3* ]] ; then
> > -            CC=3D"$CC -fdeclspec"
> > -        fi
> > -        echo "CC=3D$CC" >> $GITHUB_ENV
> > -
> > -        EXPLICIT_MAKE_VARS=3D
> > -        if [ "${{ matrix.python-ruby-version.other }}" =3D "test-flags=
-override" ] ; then
> > -            # Test that overriding CFLAGS, LDFLAGS and other variables=
 works fine
> > -            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D-I$DESTDIR/usr/include LDFL=
AGS=3D-L$DESTDIR/usr/lib LDLIBS=3D CPPFLAGS=3D"
> > -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "test-deb=
ug" ] ; then
> > -            # Test hat debug build works fine
> > -            EXPLICIT_MAKE_VARS=3D"DEBUG=3D1"
> > -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "sanitize=
rs" ] ; then
> > -            sanitizers=3D'-fsanitize=3Daddress,undefined'
> > -            EXPLICIT_MAKE_VARS=3D"CFLAGS=3D'-g -I$DESTDIR/usr/include =
$sanitizers' LDFLAGS=3D'-L$DESTDIR/usr/lib $sanitizers' LDLIBS=3D CPPFLAGS=
=3D OPT_SUBDIRS=3D"
> > -            echo "ASAN_OPTIONS=3Dstrict_string_checks=3D1:detect_stack=
_use_after_return=3D1:check_initialization_order=3D1:strict_init_order=3D1"=
 >> $GITHUB_ENV
> > -            echo "UBSAN_OPTIONS=3Dprint_stacktrace=3D1:print_summary=
=3D1:halt_on_error=3D1" >> $GITHUB_ENV
> > -        else
> > -            EXPLICIT_MAKE_VARS=3D
> > -        fi
> > -        echo "EXPLICIT_MAKE_VARS=3D${EXPLICIT_MAKE_VARS}" >> $GITHUB_E=
NV
> > -
> > -        # Find files in order of pkgconf to be able to find Python.h
> > -        # For example with Python 3.5:
> > -        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x6=
4/bin/python
> > -        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
> > -        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/=
x64/include/python3.5m/Python.h
> > -        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.=
5.10/x64/lib/pkgconfig/python-3.5.pc
> > -        PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)=
')"
> > -        echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >>=
 $GITHUB_ENV
> > -
> > -        if [[ "${{ matrix.python-ruby-version.python }}" =3D=3D pypy* =
]] ; then
> > -            # PyPy does not provide a config file for pkg-config
> > -            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy an=
d bin/libpypy3-c.so for PyPy3
> > -            echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_E=
NV
> > -            echo "PYLIBS=3D-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $G=
ITHUB_ENV
> > -        fi
> > -
> > -        # Display the final environment file, for debugging purpose
> > -        cat $GITHUB_ENV
> > +        compiler: ${{ matrix.compiler }}
> > +        other: ${{ matrix.python-ruby-version.other }}
> >
> >      - name: Download and install refpolicy headers for sepolgen tests
> >        run: |
> > @@ -145,30 +61,8 @@ jobs:
> >          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolge=
n/src/sepolgen/module.py
> >          rm -r refpolicy refpolicy.tar.bz2
> >
> > -    - name: Display versions
> > -      run: |
> > -        echo "::group::Compiler ($CC):"
> > -        $CC --version
> > -        echo "::endgroup::"
> > -        echo "::group::Python ($(which "$PYTHON")):"
> > -        $PYTHON --version
> > -        echo "::endgroup::"
> > -        echo "::group::Ruby ($(which "$RUBY")):"
> > -        $RUBY --version
> > -        echo "::endgroup::"
> > -
> >      - name: Run tests
> >        run: |
> > -        echo "::group::make install"
> > -        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> > -        echo "::endgroup::"
> > -        echo "::group::make install-pywrap"
> > -        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> > -        echo "::endgroup::"
> > -        echo "::group::make install-rubywrap"
> > -        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> > -        echo "::endgroup::"
> > -
> >          # Now that everything is installed, run "make all" to build ev=
erything which may have not been built
> >          echo "::group::make all"
> >          eval make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
> > --
> > 2.54.0
> >
> >
