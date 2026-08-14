Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC93914FA
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717385; cv=pass; b=a9RmdTRKB1Fpopp5dYQ/KRFzBAwZ8/Mxle1lSdqfzaqVkLOVnwXXsel+tbVPi/wS2evEeIgkLGkOWO9lnfQV5bS7F56JRCQ+lm4oONnC0VxvGPMW3lY/s7A+OL2Q48g5CJHYEfNeekk8NFGzQz8kJ1EBn1r3OQJqBl6n+aFSEw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717385; c=relaxed/simple;
	bh=RKHjv2de7PcfTaQfUIvTqpPTPKpywtK6SXUi+uypo7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arQx7KOtW+cZJW0sxTEVSssgDDruvsc/6SmH0UFfHSVQVpZRhNTOqXKzlyOqzFzrmmF4tvHaPvSJ43JXdvfaQ9ItHrwfu91jOoPDMu/kfJgU1SN3GFu6XGQ6RUZ5uab3XVTVkbkYhJX1dykKH+rrfZ18Mq7e9FUvseANXyFPHD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFFMlxgb; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFFMlxgb"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448b69cfc6dso744970fac.3
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 07:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786717367; cv=none;
        d=google.com; s=arc-20260327;
        b=J4uS+wVV84QH1K/3wcdy+dsYPsMPlJrnWXbu1pKANbrZz5E0BaJOW7ztK7pfR6C7rY
         R2c7aJCz+7JBCPPTkD0hWui/BEnbcYr0WD5CdTeNbnIZUGXb+ymlSPv9AQ+rnNKsLu7v
         4Z/XylMGQrzdX2plKOprrOCjYhLBG7SHmzVW0WV3jzBXxg7eZ4nKiO7MKZO7pDQY8r8R
         GyT7VYiMR17JQ1gnYkb14sEY5PHuX0hhaw8wxO9FNYL7Ryd7CUi/EHIvHTVfQzArr96R
         mhG84EonvIwOUWi9p8QL6n6BcP82K97ldS0PFJSh6XiugAhHwEa1tH/1ImgphRjwXFfV
         g+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9PJYYa/ZpwKgEQ/ep2W9ZMTAciYg9SYNR1FTSyrJdy4=;
        fh=ioEzxjIYy2lWKkptRdF8KF1tkY5XGT4L4QJl8Ctk1RQ=;
        b=NtPEwOKgaQYHWs8mU0+6Cqm4UJuwQfKpUJxk5VKiy8j91Ync5oYHoMqTmrrA3uUhSn
         6WwY2216aFiWRK++gwPMXhQylkSpNz9EkW/k6FC0NDIBiLsTzL6vtycpVIMIR6CPj0E4
         KU7HJcObTc5P+TFoA6InaV3+ib7nNdtmwPUAmxO4yude0vrVaZpuvELkwYWr8GwGHFkS
         wrOlrGLC8X5voY2kHoceaMmkq7crHwixdDPWNyfbInwfvGgEtOc3z8Crx274eYbik02u
         ObtAFGv9iOyBsisnIa8SLjuViV/xYpAad1VBz8AjAGZVqCJCmnSkn0V4cTVUxn6ZlcYo
         MOaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786717367; x=1787322167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PJYYa/ZpwKgEQ/ep2W9ZMTAciYg9SYNR1FTSyrJdy4=;
        b=EFFMlxgbT3PyKEnItXl6Rh7xX9N+rm7vfXOO2ecoC94K8txQhh7DJ1/dRWg2QwgWI8
         VarqzTzVYDyx+3Bp4wdF9OrYZQ7n/BcQiP2aUth/2xMU8B3Y01W6lWFnEhuGBdx4XC0d
         3nBwiSNCjmqef4PWHRmd9mBOme3ZgO9+FzO4wavS2ELhzYcCC9GLNnx6knN9t8Xw5y85
         sxw0clM0L3RhWoJJ37XCyFWUIzKD9d2DprqtdkiGpuJPB9K8LpuYlFkaePUCQxYr0Fz2
         t1v1A2w6/Vv6HAgo9cCPDz2G/Cyz3dEf2Hwbv4zjy5k0I7dOlHnl3oPMV24oAIzqOEYt
         JVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717367; x=1787322167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PJYYa/ZpwKgEQ/ep2W9ZMTAciYg9SYNR1FTSyrJdy4=;
        b=O/NS5VHlF5HkSDcbPxWsVLqlZCJk+lxmp3l5u0Ho/4L/3MctjfhblFA0zhI7xn8hSf
         2H+E0KhS5HE5cP/tdeIoeGr7xh+w6Bmx6aJVEi0FcI9VqCkPO6dQFEkcuuU19mpwei8b
         s2nG4nkyRnFYxcoF//9oC3nrNgEIzC+mLdbSA4re9LW5nV/IJnTsN8r7yZuat2a658kv
         FbOTKdvO7fz56sYR1PPK4Tpg/uyfcT9zDK09chin8DZPtognyXMaaum+W8xrysPw1Rx/
         W2f+dmRDKWoH2gRy8P30n4CpgZod82mo8VmxMxb+kqkkpKubzZqnr52KQd9VUhlEShsN
         RIAQ==
X-Gm-Message-State: AOJu0YyDXHL9gk0pSpLo4e+XCEweKxBxF0Ei3/sfHPhzZ0T8X73j9n3Q
	N5Iw/ct8RkqKpbVIiSJsv/I6yKc/f2A/wtOwrW8Cg+BHP0IOvlU/PUBo1er5DrT70lfLQRFy/w7
	xK9XMEHEi6JdgvdCwgKhkAy+8WRl9Ypk=
X-Gm-Gg: AR+sD13RPRksjJeG+lRCPygNco/gxCQsgCUF1G7l8Vxh+/zZa1dbipEQ4f0sXgFZ0X0
	3Ni+hFesX7inGcFM1WBNaZVvKINMI28mSH/m1SiBMr6UcAemoCqcHF4u4dlX5Q+YmjZyLFlXtl+
	mUrGh6s0W88Ge8a2xVstVtUjS/rnqro72mLXpcXruzvztca/MALsJUghqMUPG2ENyogMRfrWv+p
	4QchLTkL5DkByrki4x5fU5O4RFKx0riFQsYn+sTNDAy0iNF5yKMx7izF8poMuTj0sEGaIXj/2iP
	esfKLfb70KLmIY1PXcG76UxPPsjIXYRtDkiG14HvG9aI
X-Received: by 2002:a05:6870:a547:b0:456:b249:700c with SMTP id
 586e51a60fabf-45e920d5883mr5117545fac.19.1786717366634; Fri, 14 Aug 2026
 07:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813191248.196973-1-stephen.smalley.work@gmail.com> <CAFqZXNu4D3setEk7vgUpiPt0R=Uuy3QMrWZq4+49NF2kCcAatQ@mail.gmail.com>
In-Reply-To: <CAFqZXNu4D3setEk7vgUpiPt0R=Uuy3QMrWZq4+49NF2kCcAatQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Aug 2026 10:22:35 -0400
X-Gm-Features: AUfX_mwTlPMS04b52YN1pqe64avYFd5fq7kC9thV7MM-a3mtaTJLUGN3umly3_o
Message-ID: <CAEjxPJ6ymt0_7qe7XFCYOHp0833qE7XpnWz+dvZbuKeQriNxSg@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/tf_testsuite.yml: skip testing farm on
 pull requests
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:23=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> On Thu, Aug 13, 2026 at 9:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The testing farm requires a repository secret that is not exposed to
> > pull request runs from a fork, causing these checks to fail on every
> > pull request from a fork. Skip these checks instead in that case.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  .github/workflows/tf_testsuite.yml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_=
testsuite.yml
> > index 7e3993d3..3d7cf081 100644
> > --- a/.github/workflows/tf_testsuite.yml
> > +++ b/.github/workflows/tf_testsuite.yml
> > @@ -5,6 +5,9 @@ on: [push, pull_request]
> >  jobs:
> >    tf_testsuite:
> >      runs-on: ubuntu-latest
> > +    # TESTING_FARM_API_TOKEN is a repository secret, which GitHub does=
 not
> > +    # expose on pull_request runs from forks; skip those rather than f=
ail.
> > +    if: github.event_name =3D=3D 'push' || github.event.pull_request.h=
ead.repo.full_name =3D=3D github.repository
> >      strategy:
> >        fail-fast: false
> >        matrix:
> > --
> > 2.55.0
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, merged.
