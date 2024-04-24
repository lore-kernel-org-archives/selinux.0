Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2E134A8
	for <selinux@vger.kernel.org>; Wed, 24 Apr 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989441; cv=none; b=CaLxXuuLS5OMn35F9ykOuh9TAI3BIkqlRFSstVk1aIvfOl4h1xwH9YhThTrmXhs6G6IJn0xg+Di5jndxg2coqJ2g+ervXE87GLhIWNvaTwznx+ISOrWncTfv12iqOXVOjBSyqQ0XpznVME3I+apYNBtWtU947EQydhIRVafpy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989441; c=relaxed/simple;
	bh=i8yOY5QIyvnaufvO3NU5AXfsUfxnItSjdOHrD5J+6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdoNEaxgFvdYpWU5hPSiyWR/yX0xcbBhvq7x/cX/bUw7c+jaUtiJsYYKgoX4XQdR13F7g/uPHqFImnQTOQrOWNG1h12pak0KUhCkne2vkK6+D02CVW5qcK2K9wr1IfDXJsFgralGWg4euyHtg5iluV5mLOKkDPq+flvydKJUzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALO8SYmc; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALO8SYmc"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4dae34a3806so627683e0c.1
        for <selinux@vger.kernel.org>; Wed, 24 Apr 2024 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713989438; x=1714594238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrAZbjRDhrF0r9z5a3OhRbewPQ1/z1XopfM5Bq0x7Do=;
        b=ALO8SYmcvy9G4heVWeD3saPnRsV0u55Q4XvxQYkW9+61sTNZoTY1sgL2uy0oc/4ogJ
         H9vT60yHmmtRoUs0Z0N4OL+dOJ5ED3I5QRAx2SjF4ljoiO4Xscc51do1REnDWfhsGstL
         UWeuH6OCwV+772YY2QYJKK9u0Y0TJrigGmBNLI0qo6dUEmutJ+7d/6b8x9kQyaemcMUI
         w2K723lF3lUDmeGd5hPJT43ZFD8dCPS4SYZTdtKMSz0Fb99k95AR0wkiqYfuapRvMp1n
         MVprlK9tyAxHIffSKaxo7qAxbQMf/f52cbFN3HV3CRGJO6eTkWiYeHAeWAUQmW9pgQNZ
         McdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989438; x=1714594238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrAZbjRDhrF0r9z5a3OhRbewPQ1/z1XopfM5Bq0x7Do=;
        b=nkfEeubR1t790bedXal5uQexyMiYi9FtYsR/vEvwDoZKvOIr0FM+ndwrCKNPaVxmyK
         GthhVBYdfQaP8ukqFyTQDXqNxPjPkoIZe7RM3gEDUet2g4os0j0ahgXetVyMtYGgci9u
         68jCy1wbI0vJU9s/F2w7K4awaqTn0+hOnBbpYenK9+p1Lj0DCitNerc9COWawV0KgC2o
         aQkf1Epnm3ZOGGuTGxZ4Sqrw4451HWwB+ilxLi09nO4AMoeAUyU3OLbXmVG0UfxhnAc4
         /xpd6erXfjzwswp29hfyFWvo/6d1lKOLrXMO9KBJhU1Mb8ul68u8t69bWEj8grHfoJqa
         VtrA==
X-Gm-Message-State: AOJu0YzAhLoFaL4uypwJVErxQ2xIRpM9obsnRVatGIeadmhegNK6lSjt
	BNpT4o8GEV1EMrabdbqYJMazzG3dNf5iylrCWlUB4aoqMgxAXLxbGzgmGj6kPZm0me41OtQ1t3U
	FBj8WkrQKihW9B10HpgE1CDPg1fpqqsDP
X-Google-Smtp-Source: AGHT+IHj0KzubRCbxnC+iA837BXrkCvkKJ0PTJez4Dxayi1OT7xll7+b/KL0skR0d54jaT7kTFXY03polgDpvhPZEMM=
X-Received: by 2002:a05:6122:310d:b0:4da:ae51:b755 with SMTP id
 cg13-20020a056122310d00b004daae51b755mr1368322vkb.3.1713989438377; Wed, 24
 Apr 2024 13:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408154107.72419-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240408154107.72419-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 24 Apr 2024 16:10:27 -0400
Message-ID: <CAP+JOzTdtAQC+Ltef4ZCK5RoxAGiRxVAeabb9wzkc4D97WnTNg@mail.gmail.com>
Subject: Re: [PATCH] github: bump Python and Ruby versions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Bump the maximum Python version to 3.12 and the maximum Ruby version to
> 3.3 in the GitHub CI.
>
> Also bump the setup-python action to v5.
>
> Since Python 3.12 dropped setuptools, install manually.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .github/workflows/run_tests.yml | 43 +++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index 3bd859a3..f8b6f146 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -10,36 +10,39 @@ jobs:
>        matrix:
>          compiler: [gcc, clang]
>          python-ruby-version:
> -          - {python: '3.11', ruby: '3.1'}
> -          - {python: '3.11', ruby: '3.1', other: 'test-flags-override'}
> -          - {python: '3.11', ruby: '3.1', other: 'test-debug'}
> -          - {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
> -          - {python: '3.11', ruby: '3.1', other: 'linker-gold'}
> +          - {python: '3.12', ruby: '3.3'}
> +          - {python: '3.12', ruby: '3.3', other: 'test-flags-override'}
> +          - {python: '3.12', ruby: '3.3', other: 'test-debug'}
> +          - {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
> +          - {python: '3.12', ruby: '3.3', other: 'linker-gold'}
>            # Test several Python versions with the latest Ruby version
> -          - {python: '3.10', ruby: '3.1'}
> -          - {python: '3.9', ruby: '3.1'}
> -          - {python: '3.8', ruby: '3.1'}
> -          - {python: '3.7', ruby: '3.1'}
> -          - {python: 'pypy3.7', ruby: '3.1'}
> +          - {python: '3.11', ruby: '3.3'}
> +          - {python: '3.10', ruby: '3.3'}
> +          - {python: '3.9', ruby: '3.3'}
> +          - {python: '3.8', ruby: '3.3'}
> +          - {python: '3.7', ruby: '3.3'}
> +          - {python: 'pypy3.7', ruby: '3.3'}
>            # Test several Ruby versions with the latest Python version
> -          - {python: '3.11', ruby: '3.0'}
> -          - {python: '3.11', ruby: '2.7'}
> -          - {python: '3.11', ruby: '2.6'}
> -          - {python: '3.11', ruby: '2.5'}
> +          - {python: '3.12', ruby: '3.2'}
> +          - {python: '3.12', ruby: '3.1'}
> +          - {python: '3.12', ruby: '3.0'}
> +          - {python: '3.12', ruby: '2.7'}
> +          - {python: '3.12', ruby: '2.6'}
> +          - {python: '3.12', ruby: '2.5'}
>          exclude:
>            - compiler: clang
> -            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'l=
inker-bfd'}
> +            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'l=
inker-bfd'}
>            - compiler: clang
> -            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'l=
inker-gold'}
> +            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'l=
inker-gold'}
>          include:
>            - compiler: gcc
> -            python-ruby-version: {python: '3.11', ruby: '3.1', other: 's=
anitizers'}
> +            python-ruby-version: {python: '3.12', ruby: '3.3', other: 's=
anitizers'}
>
>      steps:
>      - uses: actions/checkout@v4
>
>      - name: Set up Python ${{ matrix.python-ruby-version.python }}
> -      uses: actions/setup-python@v4
> +      uses: actions/setup-python@v5
>        with:
>          python-version: ${{ matrix.python-ruby-version.python }}
>
> @@ -69,6 +72,10 @@ jobs:
>
>          pip install flake8
>
> +    - name: Install Python setuptools
> +      if: matrix.python-ruby-version.python =3D=3D '3.12'
> +      run: pip install setuptools
> +
>      - name: Install Clang
>        if: ${{ matrix.compiler =3D=3D 'clang' }}
>        run: sudo apt-get install -qqy clang
> --
> 2.43.0
>
>
