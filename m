Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294A40862D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665290; cv=pass; b=hmgzUoUPjDovwEk0PJH9utHPCg4Xuk/7hIT8GnkkV5X1HI/HOUAlh/b1Xf6CS9d6l56+3lCm4AXUkCpUprn3Gx+KkfEQVDNKWVRElKJ0yQEwHLxQdHaQ0LhXnot+q43rnYeyCcSXJu1NXQ9QWdt0UtoJG0Kqm1xNuDECg8jJe5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665290; c=relaxed/simple;
	bh=7UhcyBBT8TvYoolkw9CA1FsLex0GtaQZWfeljLwZHpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auH5s2f1JZpK2DLsR4hUBSPCAiUbs1SHisFJha09MnX+vbhz/oS5Mbo+FSqO19mez6j05uJgdX9of4qq6yDO/eEY+mBdmQkGi63EYTmPlmjlcs+XOojwHMN/kz9YEGNMKV8pn+YTNHhpGWXbdYosSowCRbUFqOcZSbNktqLeVN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL4z6vZC; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL4z6vZC"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677c80386so21498721fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665286; cv=none;
        d=google.com; s=arc-20240605;
        b=cGEsvkjP6cVpRiAh1h8yWSg7VzuarA63RNekcWyt6lDoXyfuW2kuTQ3azsef5XnMEy
         zHxgxEB3W9lpz9Bfl8Bf/370x4YIS1WYVYTPCK1RpvFjF0ZqE+aCrsvL8Nv2Ona5UXdX
         GDoBF/Qr/fR/m73glyJbbc+2oxlRNproHnTCFhC4gHPx5EGOMgV6p0P/Iu+GVav9S/ms
         VI5AYxyeX0uzGdJFymUym2R5Q8FcABU58/tyoAGoVIyj6DaIafGxoCZ/A7w4s8ldhtHT
         TwU0jZ5p4yyXmYQdJreQDxZBu2Tj7BeQ/62CjyIwCz8pIVw8fDNvOhY/rWkb+5dl2HnK
         VE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9fX5+4pp3udPCfU+qwydxxJ525XHUsTwQFo6LaISHqQ=;
        fh=cy3W3ogCfS7FLxBbVIR6hBi2W4stU6kfkkXrDJLiYxE=;
        b=R2MeoX1tjvv88nfpahB7+jGyw4i+8pXUHHgv23/2domLOurtwGkqhkWN2flsmtCaYf
         dgdpc0t6nNu5fo3zFK0rkknPLalu4WaZ/n2ZQ8LM3ZMGdWzU9QibigSU1TaHtTV/OPc/
         xeUkRRsw+Qn866ConLvshoal2qSg5wMomNAs/2zb4F/WJhGveW5qe7REKRGVQC8YRgyn
         U+O9Jy0aIlVGKlS8LiM1q7J6zdJAnQZUZwLpKhZHjgMD4ufNFNYwgxkMDgwcr3Z/n4Cu
         oRRrzHemCjvQAtlCzA5VFC/qxsn6yWK+Q4iqgZkuvtF90QK2u2XIYNXfs/8TJmN8up90
         0rmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665286; x=1781270086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fX5+4pp3udPCfU+qwydxxJ525XHUsTwQFo6LaISHqQ=;
        b=OL4z6vZCvkY3usZYCdHc7vtBAwa0ViNbxNEPPITDzncXUmTC2w8SzSG7dwTf6cJm+a
         Bc1vvRXljtCT5mjBDL6SEfc0yoOLxKDKjGI8qr79zHme2C6K4InORbx5CnRiC/DoiFC+
         8cnKzK0Nvspto5mjgmxPEHJBcuiDi1YflWDurcBWhLDzmnjqjxOWqro0Wpnz2OtA7DtK
         6rnn2KGmuS7tVY3SPuvTux1o5ZCB+RhU+TX9a8rWsq7Mipmc6OyuG7nI7SbAsBwnDBIy
         8JOYkSfzZ/Q2bqDf9/GV+WQZe0454Tes3vPjd04tNVcmsPNADpQbjthhtvSSYOctgoSu
         MW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665286; x=1781270086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fX5+4pp3udPCfU+qwydxxJ525XHUsTwQFo6LaISHqQ=;
        b=A2d83OqdWZVXRpMBUP1dbGHEeExs5BmEH3WiPz24nHjirk96I0ysQ84wbYcvdTzU4J
         7EVsUvdgtmVKJRRKw5uZRabL3rG1uUnlPPZ7NyxSa/ZLiUF61wOpaR7DJ4O6K5je0hcL
         M7rf9T7sBZKibRTkxb5OBwcyUo7ifplI4pTuQER98xUUnrXnNGmVIJfKeXS8QQhvwe1H
         qdcOUhBM9AaxcL8boOugxztnaScY1ahSbZm9gUKF2KcM0TcFf2qZftz7pQMgblp3futx
         +e4cs7stM5CnOm32pInxq0K1loGaexQY2fK7M+L9+wQwRjeP9PmDceqxDRmBH+/jzV1D
         C1fg==
X-Forwarded-Encrypted: i=1; AFNElJ9OdZS/V20CjyIZ1IaomKUdWV4H7/T/nJVTsjKSg4EYcd+/EfGjqxNXheO88gau1bsKmRq+2jTi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9tigWZAbBoeVO5mkffN2z9pIE9jQOv/VuVDU4JnlLkJsfoSS
	RMZlNXwGwdq+VPT991i/hpov9p32YqLiYGTjdaDRslb5t3CNskDkMUSeaMHB9ICTQ9t1Iun3y/V
	uqozOkZ1YtFf5qBNqd4OUyOkfwfkKi9A=
X-Gm-Gg: Acq92OFSGAcB88OmWCRcf0LevNLebcnMJiLA/iGP0hGqjS8BOpYXJv8SjT7MrYKdq7N
	DhjqvJ0KEo2qCfq1gmcyOkd9i1cE4BlwZ/eG432Jrbd/KkJ8lqdHg8P7bZwLHx71FNnXH4QsXQM
	xP0nSqQhvmCY8b8SVEcbLoKRCqqJ1+NgkD+KMyxt3yLDsLoOaQxGI69s57HUXHVLjinHj1s/guu
	niT3z43zfD064sloqW5MfNlWgDeAMr6SFohXIapbJ7GmyP5jApL06rqeVyuHMXbOgBTfmoOK4Bc
	qnJmSN25QS16zUQ=
X-Received: by 2002:a2e:bd0d:0:b0:38b:f0f0:e3a8 with SMTP id
 38308e7fff4ca-396d08baf9fmr12044871fa.3.1780665286307; Fri, 05 Jun 2026
 06:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605112614.2397757-1-lautrbach@redhat.com>
 <20260605112614.2397757-2-lautrbach@redhat.com> <CAEjxPJ5EQroOXUgCKzSGwX26D0xjfF181bVh-Lsx6nLy4Wd31A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5EQroOXUgCKzSGwX26D0xjfF181bVh-Lsx6nLy4Wd31A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:14:34 -0400
X-Gm-Features: AVVi8CcIuM6IYiD6aRlB2v_OC7HwJqXII6x5_HfJm80QpYgktCGs_EzE-vNX4oI
Message-ID: <CAP+JOzQuiJ+ALk6w8d5BvF3-dGt2GiJGGkKQxjph=94KdT0Myw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux,python: Use system Python3 build module
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:08=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Commit dfedefffbbdde609a7aacb1ef570c7ca1bb70915 ("libselinux: update
> > pywrap targets for modern python builds") added `pip install build`
> > command. This fails on build systems without network.
> >
> > Revert the install part and add python3-build to packages necessary to
> > build Python bindings in README.md
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  README.md                | 2 ++
> >  libselinux/src/Makefile  | 1 -
> >  python/sepolicy/Makefile | 1 -
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index ece18c394ee0..5e65a0495e39 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -64,6 +64,7 @@ dnf install \
> >
> >  # For Python and Ruby bindings
> >  dnf install \
> > +    python3-build \
> >      python3-devel \
> >      python3-pip \
> >      python3-setuptools \
> > @@ -97,6 +98,7 @@ apt-get install --no-install-recommends --no-install-=
suggests \
> >
> >  # For Python and Ruby bindings
> >  apt-get install --no-install-recommends --no-install-suggests \
> > +    python3-build \
> >      python3-dev \
> >      python3-pip \
> >      python3-setuptools \
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index c62ad1edda58..52b2c621c042 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -151,7 +151,6 @@ all: $(LIBSO)
> >  endif
> >
> >  pywrap: all selinuxswig_python_exception.i
> > -       $(PYTHON) -m pip install build wheel
> >         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m bu=
ild --no-isolation --wheel .
> >
> >  rubywrap: all $(SWIGRUBYSO)
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index 4a4a351219be..518129805fca 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -14,7 +14,6 @@ BASHCOMPLETIONS=3Dsepolicy-bash-completion.sh
> >  all: python-build
> >
> >  python-build:
> > -       $(PYTHON) -m pip install build wheel setuptools
> >         $(PYTHON) -m build --no-isolation --wheel .
> >
> >  clean:
> > --
> > 2.54.0
> >
> >
>
