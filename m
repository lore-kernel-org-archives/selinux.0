Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81171DF982
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769185; cv=none; b=gLbOB/xGe3Z56+OgIPjTR1AVYDrHFN56m2UxGgkKKIrGQyGC2X3iFASoBMyUNNau1GuwwhMv1BZSH2IZOJRQRWOg3DtgbOQtsW8M/cEaYLM6VUeRMoEupvwjDanb4vFJ0jGjv7wZNlAuVv3HiTJsVRfGqilbUVz94DUA0kYSc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769185; c=relaxed/simple;
	bh=pnw4T8fmr/3qFT9680yUyvoi4wDP4r7vX8cwW/E10YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBt5prRhpguauBM+4PxVJX8jNaprkPqdtwhlEE6+QpnVawRQg7gHcRwsBjc3s31xOjjONiN1Rbw7c2b8Y/1Jq/CMtiTjeu8HEDKYuMJ7ZV7BqiTNEApvWuf2l5l6S/hczcPe7/O2HUKqzPeJPV4aJseYAhSIZQ+Jlyvzyx8G6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaJXmp23; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaJXmp23"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-791c287c10dso558873b3a.1
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759769182; x=1760373982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBgZ32kzsgoiw+/b/kYiEsqyOmgnWMuJfoSPctgjFDY=;
        b=AaJXmp23RgXBebjPRQftsxNoXOLK+4Gpbf0c41EbOFaZ2qEiO4wVMhrveJjOgfewsl
         0fg8ETjlSzPSLu6zJ3yPjAmpzCP4aBaLKjcwZckdVuk1iYTG08Uoi1sEX8nxLDwwUYDH
         UOc6FOO5XWUxvrxCcyN5zoKgpKlxuOczSn+Le2xtHuV9xeN1hVwYq0eVOvrlAUllTeu9
         aXvYs/zweSnutO5Z9SnGBlNbJa3zQWtYoGkRwB2Jil2kN238IK2ZFR0D+THHdxMGiNVe
         CtGu6sZCtSMb+55Tmg9oWWXIBQp/vV51afRfAV3RCbqr+Ch6L+2Fy3pdCf1gyvGE+ssb
         FIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769182; x=1760373982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBgZ32kzsgoiw+/b/kYiEsqyOmgnWMuJfoSPctgjFDY=;
        b=GYGea3P/AkeVdDI60S+rfO/OonADSEWCRI+wT1IC8rxADResZd8fwVxyMhmhQl//+w
         9ocEdNwU41eNhV6ZlPwvJZv1LhtPbixJ32VvETETnFR87wvEbId2wAjGKxYnTZ+5ZtR0
         i1VhfGvetAIXNudzUwv44/6Ddng9XwY/HuTRaU1TuMMxPK4IW3QRmmkk7rcL0aFLJwvC
         VJpWkgcJ3ubft0w0LYmCcO8qlS2b+UQQDx24mdCQuu2w3jehuUQXd2BXCQtbnpPRa94D
         WILlJ0ybNZFeP9iyn6KiWyNgiguaBR/pF1LNwKIWG4rjbsr/jlZmnxJ9cEQAajuAefY3
         cWMw==
X-Gm-Message-State: AOJu0Yycxf79F5KZalPuCxhWC8n1b/mMEuAf+yaVQp+r+t2XIYk5ZHY1
	T1iyk+L08J5Jq5EN87+WD+pEl4DfzVObvwN2CGUiTCtKmEyeviM2jqTYu91vtMLgI9BG+jHP4N7
	N7GbXTwyuzo1ReHzM1cbq3RrC1yDl1bNH8g==
X-Gm-Gg: ASbGnctCVlngJrYyw7H31e9wbQljSW7iLAQlTWOGWrNa7gEHKxqiSxt6U5VRGa2J7Cw
	XEE07miVgKIIi3s2TPtObQ08MEkdB72s4TM+mF8a7+FfZoX1T5JAjCyP3Nz85OxVxpAYPuODtz8
	s2WJVT1FcJ7dMc9OxBB0flnmxoeHuMNTMZp8N4jI5FycUeBpOUlJBS1IUZCycagTRAqPOt1ooC6
	Py4VRo1mPBdiCda98OfZTe/85P9kuE=
X-Google-Smtp-Source: AGHT+IHTfJS5UFe6kubwUAM+qhtfd1q5rADEdsSandg2W5dY23rh8elOMiWVXdioHUVBRfOyGKfKI6aK5APL6WxNVeY=
X-Received: by 2002:a17:90b:1e0c:b0:32e:a4d:41cb with SMTP id
 98e67ed59e1d1-339c276d8bbmr12108409a91.1.1759769181918; Mon, 06 Oct 2025
 09:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925172647.931521-1-nvraxn@gmail.com>
In-Reply-To: <20250925172647.931521-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 12:46:11 -0400
X-Gm-Features: AS18NWCxsmAMSLP6tjO40FV2y-r_CQGAZqjRMzUdxvLW9jUwvZDoIdiFW0X9T6Q
Message-ID: <CAEjxPJ5xCiHe=m=jS0TEgUbn8DtJqvfNpiyu=+SSO4Sv6ppUgQ@mail.gmail.com>
Subject: Re: [PATCH] build: Make sure SHLIBDIR respects PREFIX
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:27=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Not respecting PREFIX can pollute the environment in various build
> configurations. LIBDIR already respects it, so we may as well make
> SHLIBDIR respect PREFIX too. Fixes #494 on Github[1].
>
> [1] https://github.com/SELinuxProject/selinux/issues/494

If you don't have usrmerge, this can produce the wrong result by
default, i.e. installing shared libraries to /usr/lib instead of /lib.

>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libselinux/src/Makefile | 2 +-
>  libsepol/src/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 261c22d4..c855e759 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -10,7 +10,7 @@ PKG_CONFIG ?=3D pkg-config
>  # Installation directories.
>  PREFIX ?=3D /usr
>  LIBDIR ?=3D $(PREFIX)/lib
> -SHLIBDIR ?=3D /lib
> +SHLIBDIR ?=3D $(PREFIX)/lib
>  INCLUDEDIR ?=3D $(PREFIX)/include
>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?=3D $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index a1aed072..f8574d70 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -2,7 +2,7 @@
>  PREFIX ?=3D /usr
>  INCLUDEDIR ?=3D $(PREFIX)/include
>  LIBDIR ?=3D $(PREFIX)/lib
> -SHLIBDIR ?=3D /lib
> +SHLIBDIR ?=3D $(PREFIX)/lib
>  RANLIB ?=3D ranlib
>  CILDIR ?=3D ../cil
>
> --
> 2.50.1
>
>
