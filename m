Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E746AF04
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853685; cv=pass; b=HYeT3PfpPrAdXxQHIR0Zuom2xnL9LYfCx/nLgNvaFyqe0YMN908FMPa1Utvz2lGCbO3NJoturpRIdnLTMXSwpjMGrrmlCOXWwQinT7ABACJWK+bEoCGP3QbxsYCM21lqIrbQEqowcW2+fNJ5h6RDxJ6/waHiwZG8wKsLDLieCB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853685; c=relaxed/simple;
	bh=/TBq4b/4R2C40l17wP/IUWUvZZPJ/4saO0n+BxefexQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aff6Bq4UhBk5G/UfjLyLv9DuCGHpRzCl+njG0zPzL7dI2Q3jUydKkpY+gm30OdOepbKfInf7ECIAz4HQe5Z9nbEOeq8eNlKH84VJkkchHnhGAR5/UQNLY4w/9qxGTTkXTsimI9/lopL/rqh2L5WkgVBlcDnDrRoBjvdqgu9mdCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK2CJJi6; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK2CJJi6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83659d38e38so3990296b3a.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 07:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853680; cv=none;
        d=google.com; s=arc-20240605;
        b=B2nuw9yHFWyRSyikQXniroozvqkT94HctMPmDeAmkK9Ov/wJZJyuxS9n335wLHNusI
         ILErV9LI3p6a1W6FG6PttwdXSfKqBtj3oc46ut2H+6qkhbgKOxpY/JMKvgB+d+AvsrQe
         ZDsLd1Gp0/F/6eYrAr1ytH7jUxEKLS14YQ4j3OzSBx0qi8KbE5JhZxuqFmct4WL6U0SS
         LHmGst3B5jxUzZ9ICsEXD0H1TPBuxbHTSwNC9+uiYImpzg5ZKUISEqGz79LKkDzsqrgI
         zcRIPvzaIFc4j+ogx88No9feDtqHecZg/EsEB/zsVvOD77wFOG8NvLmpxaEz7RGMSR4Z
         MU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5k+3xzYFBCSm1vHpkh/F6ze1uZ/XsXzwxhuAkGeUic=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=kAK6TOdS7u2u2lKUB0oG2DQvbCldwOikVfjZsOOH/j7rJZNfsy5EF1D/SIuO8RnfDn
         r432tzfKZnOls409GZUahU3G/JffM6JQFAVqDJjGTKJKkbk0iyomW7Tj4/2qX4P8gVz7
         L8LwUYtXcfd2ek1RiNHKOVbR0p8iV4SJhxMSwJ6z5b8lhfH+9CtIsEj+9keYcTw+/JPC
         rf2EdS5lul35TfBizRmMeztYuk+DCyBCePkFM8TkSpQUtiJiqSVLTOvdXJe5ZLCv9x+q
         N47l7nhH06ejmPCt/g92sM5rHRZb5Y1OWFZ9a/LbS6O8m70XoULVw9PIcqlYdyMnjySx
         27qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778853680; x=1779458480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5k+3xzYFBCSm1vHpkh/F6ze1uZ/XsXzwxhuAkGeUic=;
        b=LK2CJJi6wbC0nkUy5iBM1esIYjI76uQCj8iogXhgNhu83PLbhp/ZSJ5VLppZbi4L+H
         po5ZV8ltNE/3enxDnSywjqwFgR8D8jqY6nGlaAwvGC/FiZqUoejVUze0MplKgReyLTZo
         M1zn2y1tEVMZjxV4AXuzTpKKAsHcMef1ogr8bk1MWVZxO3keHQXMMxemtVSQVLLdzlaq
         torMzYl5XKFZgjof972lfmGblHlCIhm+YOvxLr4c47UXU1CeV7or/TG2kOZ0+KxvZCPU
         C62zGM+uSbPIsOSNqgp61PVruN569gxLY109Lme7eewDBjmiZ7EPt7fz3VJUnzUGCfW0
         GOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853680; x=1779458480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5k+3xzYFBCSm1vHpkh/F6ze1uZ/XsXzwxhuAkGeUic=;
        b=OFOp3x3zererOAiEBx0UISAAI6abBYdbL8Qi8vqBbn/2BawSTpk7RiXkhsyVC5X+vl
         TyEVhtE+5W1DSR8+CbHN+V61T3Or3+nj//4bBTgw86G/4bSdv/hCVSDsyFLIX9YTwawg
         g5+FteRwhQLpNe5/2yeviaOhEr9FydrmzsT0xOBlbE3sv6hhgbSEaGyDHgnimmQsCZ6j
         9ZgHb9wBcHmlvwUSQ94JCmk2Nt/DDofAMG62EmIUfMXGvBs2uoC0+0hfa2CyiRWtewFA
         8sjgEhKlKFDHGFD1AXBW3cECo5a9d0qoMsWYe380PIh2jh+sfSN8i3MaV5WC8lWMzYzl
         miWQ==
X-Gm-Message-State: AOJu0YyStH8/eRWHxCZ68SlMfrnwPmJ7SXa/n1FOrUZIaege6eXgbGiJ
	CcolOYq6cKy6ZI/ZEQ3IgWxaEmBa0mZWaPd04BgwBJisQEAIHQGHtTh5qdxMk293jIIBDO3SE2t
	KOF2X6hGyprEM9S+3GJAPvU0vTJ0t+Ya9wQ==
X-Gm-Gg: Acq92OE/AX6U+FZbkoHqwk5TjrkZNBs7RsaQCMupY7W+jQpt0JO0mbw66yHw4Oe21Xv
	ZQ2fNKUuxlOtONUq4jCXeJrvHP7vpMIo86NDViQS28p6NrnQWYq5InywG7oBojSobKtJv0+UrRF
	bI3z2xpobEjzqwdk7XALbXDibnvRNW1rRIK7QxQWZAQkRB++kOKQ4KzVt1QO4Cbdvt+HpKdPzh2
	KRxQmXH94S1kPEVbp9Cvv181tFFlzFx9vslxkuokFjU1/tSYI6Xqq6ovw7L/P8RGBuDLLx1mkZA
	IvgMYGhqec9lP2w4dw==
X-Received: by 2002:a05:6a00:3913:b0:835:405a:7e6d with SMTP id
 d2e1a72fcca58-83f33b4e65cmr4684868b3a.21.1778853680196; Fri, 15 May 2026
 07:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515121329.10807-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260515121329.10807-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 15 May 2026 10:01:08 -0400
X-Gm-Features: AVHnY4Igx0UJRJU6Gxcy_ZfiI62SjHELua9QjW_M6siKI4JHtSJmx_YRFCEL3GQ
Message-ID: <CAEjxPJ5zEqUzmF1fzL3Mk-ATXdRkug8uM5ZH8dm9oZ67h2PfgA@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Maybe fix CI build failures
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Current GitHub CI builds are failing with:
> python -m pip install --no-build-isolation --prefix=3D/usr `test -n "/tmp=
/destdir" && echo --root /tmp/destdir --ignore-installed --no-deps`  .
>   Processing /home/runner/work/selinux/selinux/python/sepolicy
>     Preparing metadata (pyproject.toml): started
>     Preparing metadata (pyproject.toml): finished with status 'error'
>     error: subprocess-exited-with-error
>
>     =C3=97 Preparing metadata (pyproject.toml) did not run successfully.
>     =E2=94=82 exit code: 1
>     =E2=95=B0=E2=94=80> [10 lines of output]
>         running dist_info
>         creating /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info
>         writing /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/PKG-I=
NFO
>         writing dependency_links to /tmp/pip-modern-metadata-dq7pf_bt/sep=
olicy.egg-info/dependency_links.txt
>         writing top-level names to /tmp/pip-modern-metadata-dq7pf_bt/sepo=
licy.egg-info/top_level.txt
>         writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy=
.egg-info/SOURCES.txt'
>         reading manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy=
.egg-info/SOURCES.txt'
>         writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy=
.egg-info/SOURCES.txt'
>         creating '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.dist-info'
>         error: invalid command 'bdist_wheel'
>         [end of output]
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Never mind, this doesn't work.
Any clues from those more savvy with python building?

> ---
>  python/sepolicy/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index ccb22fe7..d48c4cef 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>         @$(PYTHON) test_sepolicy.py -v
>
>  install:
> -       $(PYTHON) -m pip install --no-build-isolation --prefix=3D$(PREFIX=
) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-d=
eps` $(PYTHON_SETUP_ARGS) .
> +       #$(PYTHON) -m pip install --no-build-isolation --prefix=3D$(PREFI=
X) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-=
deps` $(PYTHON_SETUP_ARGS) .
>         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --
> 2.54.0
>
