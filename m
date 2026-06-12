Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287B3EDE7E
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270604; cv=pass; b=YrPQQ5HyqrSfP1bIrr7ipysHSO+ljmvHhiR40iwrHf/jG0EZzcG7tFtKW/NGJrZS9Kylt6VzzC22qdVzrJ3l6Djw687ny8Mn/ZcmUEzxBuhRmAWUR9TgQZmcZpecPR0Q0hpWCBBJXmhTx5Tuz99h5Of2dsx3DbClNIUepXKN1hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270604; c=relaxed/simple;
	bh=B06gKQBrNmK3O6DqlRlQvP1/Vso0EiVW41cs8VUmA8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn6AnpMuOi7NN6gNXoc076r8o0u58ksLzJFzDu7Vz/GWHo+s2WdQ65fCbUu0OeoFLW9e+4YgsfmtNgtGCvVWmIEzpnhDHadXgW4KKXJYUz2fzS9KUcGPCvu7AaUCwe6fN5uRvpn9JTEaXCjG6WqKQGaPpWGZpbaW71RdGnI2QFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN5oq+zx; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN5oq+zx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37474afe908so550983a91.1
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 06:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781270603; cv=none;
        d=google.com; s=arc-20240605;
        b=YAmv9UGM4e5Qz08W6BOg6GW/qqEyARTNdDWtPFakjD8/HcEscnDNd40Ci/dErYtf2+
         BVoAAF7Y/5tb5oaKP+P+xcWuSr/1mmiB20RXVU5lfjwlYo9yKV2aIm6FI13OI2vNxwSB
         pzIv/Ip+ivM/G0FdSdDNSP9Az/U1qOK2RzTj9gW31m+Y1/JlCrBGmw+oRsW0qg6iLMRY
         v3OBg4Duz7Kk+L9SV2FBEceeBioLh8YZ41QxUwVhS2kX41uJ1PiWIOwUJ+yiCq6DLB/m
         YcSpj/VaMh79wO8ycWM/ni/Lwisx4ph9oEPGmooyyuj3ZmKCOdyu6cJ3E1n3WprN8aih
         yo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ngoPCfTClit/o2ctszmA0C+iqu82uNXsSSpNe4LA4I=;
        fh=Br7Q3QYCCAjnvhHaund9vV2LCS9SOjHrWaBcZeLdftU=;
        b=CNdPWQEpW7WnKarmsMw//O62LaxRzVv9T8EYvhG8oGah34q/h7H3WOWKyBcNNTSTkf
         C044n1JNdj3OEIKzLZVZv+heZYRJoN8r8q3HS3fJwUAfx7kjnC2wInCQn/d8zG3r5F/d
         ODWtRob2edW7bQIvqqi9DGbd0NORbaxB2G/FRZcw0U6JpqZ9A7zg02+1y4gPJ1in2ClV
         xVC8bXXKzQpTXS1Q+WpcpIQM1/6rTxVRQxZB28L4CsJ2eMGzBXRMxUhnTr2lKSM70twL
         vUyjHq5mTLq2ds28LeP/BOwH7TX8FbuVFTqou/GA/+Gi/k7dldp146jWC+YwuTNl8Peu
         eeHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270603; x=1781875403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ngoPCfTClit/o2ctszmA0C+iqu82uNXsSSpNe4LA4I=;
        b=UN5oq+zxTf2Tl+kDfkjYEfsvlbhWOpNb9qx/E7noPlEAcpmO9h6ZThpKYbAc128BwT
         KT1IMFncUN7+rBY4SgLjfDkhVb6mV528gRdOKxvSDG0npLPQgQsLV7EPinPfDeb4Dpms
         XyFILsEjESK7nyNGsEUxLs0w5SDqB/Bj6hG2Z5vXCCHm99weTbtfMKOkntvWNQeSBgAA
         EN83SEmXx4xJ3+4MyQ2vl2LjzoDsmdMxrjbcsNVGyI6yev60E5FaiICAVR2ghNlWix8h
         seYilidkENEiXDyRapyY0Jti1/0+9WGP1m1qZKdNBBP6uPLZclK9h6GRMJq0O9MT+Rkh
         qJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270603; x=1781875403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ngoPCfTClit/o2ctszmA0C+iqu82uNXsSSpNe4LA4I=;
        b=YqGNnOiUGXJ18TXy/KVZLZqtb9VhGB7tg7MIrM7YwVquvItHKjnegjDxKcQT7iH94R
         4olLGEHFYpXlBeFtxoWegp76PXj3IZzuBPeg48rIGwAFQ1barDFexDn5LKQt6TRcD/z/
         Unw/Bqmk3wDWL4+Z37Hu6Gve/fpY6JY4MSmq1lPORPdXyAMnWHarTjbWDn+5xMCyGRNR
         Pd9gtQ3NuDWRdqerFN9j9GhCnyk6I5KwswQPdiHBulhwLAIpcuvL9Y+PUNY3pWhGn/rz
         0eSuenvOGQytScwwIsQM6L2Jb12VgrzhpbdJdtaifIAuMxze6PDjL/fFeQ6LBR1IFoe0
         LRjg==
X-Gm-Message-State: AOJu0YyQ3t4vLvU0BjT4SxqcGYxE8V+RdTxLqBHVLG1PvUguk7eSNuqr
	Tohr57n5KawiMi2kxoq57mQ3hroK62ghnGI3NOfB2GTYKISPIAxu7kNoE/eDMjrmNnphfmsGMoD
	sVGnIqSxm7gd0FdBQzAPew4P44DE5pTHwtg==
X-Gm-Gg: Acq92OGjtcLk45LdlmhQY8+m6UPe3Xc6JEyUu1SJM4azlY/bWgvewSk9Yg+cZwd5ASE
	Vd08QJCaDxRzcZHOzmeKVIIamBExrFfFsecLQHaApbRcInsmUtW1D16AhuNw5A8X2wdwyEjYwB7
	5O7Wb2/FAkf9YsH7qtxT3jbzd1y0OXQocKqXAuM6ikx277GYXhxbA7EeTzsWD+wsRj8CKvapb1X
	iIEZipqByeG7R/HBEd0TzrBbywow5gOVy+75YB1JzjW/dF3bl0TILzKW8umjs0klpYihFIFZ4a2
	y0iB968=
X-Received: by 2002:a17:90b:1f83:b0:36d:8e6f:8d94 with SMTP id
 98e67ed59e1d1-37a032e5303mr3003131a91.15.1781270602588; Fri, 12 Jun 2026
 06:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Jun 2026 09:23:11 -0400
X-Gm-Features: AVVi8Cfs4TqYhDQc_c-UiiFHKWrQ1UhqG05cHLkXtxnEy6xnokHKWL3uXG-bKqY
Message-ID: <CAEjxPJ7QOaiBekF_uj1p70Ld-aj497_taYvBGUde7==_tX-UYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] CI: Fix variable use in build-userspace action.
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:31=E2=80=AFPM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> The code was incorrectly using the matrix variable, which isn't available
> in other repos. The matrix variable use accideentally worked in this repo
> because the action runs in the calling workflow's context, not a separate
> context.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .github/actions/build-userspace/action.yml | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/.github/actions/build-userspace/action.yml b/.github/actions=
/build-userspace/action.yml
> index bad6e33d..f5d21b7c 100644
> --- a/.github/actions/build-userspace/action.yml
> +++ b/.github/actions/build-userspace/action.yml
> @@ -71,27 +71,27 @@ runs:
>          echo "RUBY=3Druby" >> $GITHUB_ENV
>          echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
>
> -        CC=3D${{ matrix.compiler }}
> -        if [ "${{ matrix.python-ruby-version.other }}" =3D "linker-bfd" =
] ; then
> +        CC=3D${{ inputs.compiler }}
> +        if [ "${{ inputs.other }}" =3D "linker-bfd" ] ; then
>              CC=3D"$CC -fuse-ld=3Dbfd"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "linker-gol=
d" ] ; then
> +        elif [ "${{ inputs.other }}" =3D "linker-gold" ] ; then
>              CC=3D"$CC -fuse-ld=3Dgold"
>          fi
>          # https://bugs.ruby-lang.org/issues/18616
>          # https://github.com/llvm/llvm-project/issues/49958
> -        if [ "${{ matrix.compiler }}" =3D "clang" ] && [[ "${{ matrix.py=
thon-ruby-version.ruby }}" =3D 3* ]] ; then
> +        if [ "${{ inputs.compiler }}" =3D "clang" ] && [[ "${{ inputs.ru=
by-version }}" =3D 3* ]] ; then
>              CC=3D"$CC -fdeclspec"
>          fi
>          echo "CC=3D$CC" >> $GITHUB_ENV
>
>          EXPLICIT_MAKE_VARS=3D
> -        if [ "${{ matrix.python-ruby-version.other }}" =3D "test-flags-o=
verride" ] ; then
> +        if [ "${{ inputs.other }}" =3D "test-flags-override" ] ; then
>              # Test that overriding CFLAGS, LDFLAGS and other variables w=
orks fine
>              EXPLICIT_MAKE_VARS=3D"CFLAGS=3D-I$DESTDIR/usr/include LDFLAG=
S=3D-L$DESTDIR/usr/lib LDLIBS=3D CPPFLAGS=3D"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "test-debug=
" ] ; then
> +        elif [ "${{ inputs.other }}" =3D "test-debug" ] ; then
>              # Test hat debug build works fine
>              EXPLICIT_MAKE_VARS=3D"DEBUG=3D1"
> -        elif [ "${{ matrix.python-ruby-version.other }}" =3D "sanitizers=
" ] ; then
> +        elif [ "${{ inputs.other }}" =3D "sanitizers" ] ; then
>              sanitizers=3D'-fsanitize=3Daddress,undefined'
>              EXPLICIT_MAKE_VARS=3D"CFLAGS=3D'-g -I$DESTDIR/usr/include $s=
anitizers' LDFLAGS=3D'-L$DESTDIR/usr/lib $sanitizers' LDLIBS=3D CPPFLAGS=3D=
 OPT_SUBDIRS=3D"
>              echo "ASAN_OPTIONS=3Dstrict_string_checks=3D1:detect_stack_u=
se_after_return=3D1:check_initialization_order=3D1:strict_init_order=3D1" >=
> $GITHUB_ENV
> @@ -110,7 +110,7 @@ runs:
>          PYTHON_SYS_PREFIX=3D"$(python -c 'import sys;print(sys.prefix)')=
"
>          echo "PKG_CONFIG_PATH=3D${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $=
GITHUB_ENV
>
> -        if [[ "${{ matrix.python-ruby-version.python }}" =3D=3D pypy* ]]=
 ; then
> +        if [[ "${{ inputs.python-version }}" =3D=3D pypy* ]] ; then
>              # PyPy does not provide a config file for pkg-config
>              # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and =
bin/libpypy3-c.so for PyPy3
>              echo "PYINC=3D-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
> --
> 2.54.0
>
>
