Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F29154457
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673127; cv=none; b=QZbDZZGmBW4W998dLQShIoLgyRoPOp/sDvTuofZchNEtfBCPTrMsCm6/CH2a/KgZULGOu+1w77vGg5kuCbk6nYotHngD+nuIFE4uq83dT1cfAa78Yrj4ytPBpEgEMcivV8Nam2kDPTihaS2hfwMZiTYHiCDywv1WfrteGc+SarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673127; c=relaxed/simple;
	bh=ASWV/URkORvl1tRbDClg9y85rDFzth5BgKi7A19DdQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZAQrKb2XXFi0daqsjlDAf4vAsLAx840QKvK7ucXfy4snyS7flVGA0RmUXwzk8WhVXIG5wajhxFh4DRRsOyDQ2PyMWAvthUGPDM7NOQgVesEZZHQTPn3Vvm5VLRfAB1ZRkns/VhxI0Y2UcFQrXF8s2aVwWbNGfLjwdzPjsAn9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHwTVOjj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHwTVOjj"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ee3a49bdcfso2616636a34.0
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673125; x=1715277925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o0JwQ9F90f0tAF1fTJYcUyBw2lbdtfjYEbb8lHbDbg=;
        b=PHwTVOjjvj2ZAiDplqw+wDJD5Etdf/tbN7UUJLe/kqxBpbFaWkL4hEL1RReJwI5IIt
         ynvfxlAUyOrlTLKGmqPUtNm96QEr+Vb6SqoXyJ4UgQbks3UV+4FSyQ30ohfl7cGb/PkN
         VjDUKVIuoGce/kM2W/EGDnkjaPy0Na/lj3IqK8Xz/ViQUIRGRznUvrrhmLKpeQN6QEFR
         1bmf1zRsOSuke2v7e9sYKimHfmxjcckewjsCqvtIh8dCEcc+nPboEd0mmxpG1CfYM0k0
         fQA2aRg8OEY5u5h6Oo9NcGYcgHhVoyrKDLUKF4CjXAYgb0R5DHBQbclLtmHiJO0dAO2W
         FY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673125; x=1715277925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o0JwQ9F90f0tAF1fTJYcUyBw2lbdtfjYEbb8lHbDbg=;
        b=ETLJUakB8iWPO2Lq3XptrME29fF71alNSmQ/V/YQy2tQfwjMzH36Ui0lBOPNAwaCug
         DfKQu6Eki3ZtfQDdRLm2EvJRGKwRcrYjMm1gDcAVt2wiNHRTQnDNo1joc5mk+ts1BvPI
         wk5pvEmDRANAN8crhlEvEkzMT5k5A9B/GDwYGwf5rzSVj5X6cEBgU338IOA1LAj2OgRW
         +XphHEKV7M6R4alQ3AMRICbj7PfN5aH/8+vW0Sjl6a/BHUmiSsW9LUSrXe1Ab5CGOVSm
         NAMzgjCDZbS9kFhkafGYj/uuYEMDOYaD0luoYEATXzbQsq1rCZvGNKZ3+tWlguvhAZww
         kepQ==
X-Gm-Message-State: AOJu0Yxqwq0mPd05XvChztrZRexeUxEEXFXpI4rlWFTkwGGEFlKF1eM5
	igfPBhxRx+z2Asti7j+efZjfzloYNxJdbF+i7hy6Fi7cxJo2Xf7/tpwjav5F9m8Beit466fgbPf
	Pu0y7p3TOvvl/lnv9UsUZv8eXC5Y=
X-Google-Smtp-Source: AGHT+IGVyCxz4WLh3l1RkhMXKeXPImszX5dlFCbN+7NjI0BJ7RO44RMTnlVIGtuQknsCZ6xNrib7aE0AennZLOAoKaQ=
X-Received: by 2002:a9d:7848:0:b0:6ee:1e31:4ff1 with SMTP id
 c8-20020a9d7848000000b006ee1e314ff1mr552450otm.16.1714673124752; Thu, 02 May
 2024 11:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408154107.72419-1-cgoettsche@seltendoof.de> <CAP+JOzTdtAQC+Ltef4ZCK5RoxAGiRxVAeabb9wzkc4D97WnTNg@mail.gmail.com>
In-Reply-To: <CAP+JOzTdtAQC+Ltef4ZCK5RoxAGiRxVAeabb9wzkc4D97WnTNg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 2 May 2024 14:05:13 -0400
Message-ID: <CAP+JOzSV8F8mRQrAuEKLSq=Ep5vhZ3qhEOfVZHhO_ry3Jyis1g@mail.gmail.com>
Subject: Re: [PATCH] github: bump Python and Ruby versions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:10=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Apr 8, 2024 at 11:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Bump the maximum Python version to 3.12 and the maximum Ruby version to
> > 3.3 in the GitHub CI.
> >
> > Also bump the setup-python action to v5.
> >
> > Since Python 3.12 dropped setuptools, install manually.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  .github/workflows/run_tests.yml | 43 +++++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index 3bd859a3..f8b6f146 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -10,36 +10,39 @@ jobs:
> >        matrix:
> >          compiler: [gcc, clang]
> >          python-ruby-version:
> > -          - {python: '3.11', ruby: '3.1'}
> > -          - {python: '3.11', ruby: '3.1', other: 'test-flags-override'=
}
> > -          - {python: '3.11', ruby: '3.1', other: 'test-debug'}
> > -          - {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
> > -          - {python: '3.11', ruby: '3.1', other: 'linker-gold'}
> > +          - {python: '3.12', ruby: '3.3'}
> > +          - {python: '3.12', ruby: '3.3', other: 'test-flags-override'=
}
> > +          - {python: '3.12', ruby: '3.3', other: 'test-debug'}
> > +          - {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
> > +          - {python: '3.12', ruby: '3.3', other: 'linker-gold'}
> >            # Test several Python versions with the latest Ruby version
> > -          - {python: '3.10', ruby: '3.1'}
> > -          - {python: '3.9', ruby: '3.1'}
> > -          - {python: '3.8', ruby: '3.1'}
> > -          - {python: '3.7', ruby: '3.1'}
> > -          - {python: 'pypy3.7', ruby: '3.1'}
> > +          - {python: '3.11', ruby: '3.3'}
> > +          - {python: '3.10', ruby: '3.3'}
> > +          - {python: '3.9', ruby: '3.3'}
> > +          - {python: '3.8', ruby: '3.3'}
> > +          - {python: '3.7', ruby: '3.3'}
> > +          - {python: 'pypy3.7', ruby: '3.3'}
> >            # Test several Ruby versions with the latest Python version
> > -          - {python: '3.11', ruby: '3.0'}
> > -          - {python: '3.11', ruby: '2.7'}
> > -          - {python: '3.11', ruby: '2.6'}
> > -          - {python: '3.11', ruby: '2.5'}
> > +          - {python: '3.12', ruby: '3.2'}
> > +          - {python: '3.12', ruby: '3.1'}
> > +          - {python: '3.12', ruby: '3.0'}
> > +          - {python: '3.12', ruby: '2.7'}
> > +          - {python: '3.12', ruby: '2.6'}
> > +          - {python: '3.12', ruby: '2.5'}
> >          exclude:
> >            - compiler: clang
> > -            python-ruby-version: {python: '3.11', ruby: '3.1', other: =
'linker-bfd'}
> > +            python-ruby-version: {python: '3.12', ruby: '3.3', other: =
'linker-bfd'}
> >            - compiler: clang
> > -            python-ruby-version: {python: '3.11', ruby: '3.1', other: =
'linker-gold'}
> > +            python-ruby-version: {python: '3.12', ruby: '3.3', other: =
'linker-gold'}
> >          include:
> >            - compiler: gcc
> > -            python-ruby-version: {python: '3.11', ruby: '3.1', other: =
'sanitizers'}
> > +            python-ruby-version: {python: '3.12', ruby: '3.3', other: =
'sanitizers'}
> >
> >      steps:
> >      - uses: actions/checkout@v4
> >
> >      - name: Set up Python ${{ matrix.python-ruby-version.python }}
> > -      uses: actions/setup-python@v4
> > +      uses: actions/setup-python@v5
> >        with:
> >          python-version: ${{ matrix.python-ruby-version.python }}
> >
> > @@ -69,6 +72,10 @@ jobs:
> >
> >          pip install flake8
> >
> > +    - name: Install Python setuptools
> > +      if: matrix.python-ruby-version.python =3D=3D '3.12'
> > +      run: pip install setuptools
> > +
> >      - name: Install Clang
> >        if: ${{ matrix.compiler =3D=3D 'clang' }}
> >        run: sudo apt-get install -qqy clang
> > --
> > 2.43.0
> >
> >
