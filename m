Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDB3DC4D8
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975120; cv=pass; b=nKeKkDUCaSBbRRx1Hd3XJVr2f8LeTGz60D0K3HQewKkMONsBhwdYrrjueRdKKWpKyJG5/Ywmv4th8OHB/MGUB91BHusLSae5V15QL1mxUqHj7oRrD45MpSSycr03dM+DmuTDQ7STrO5A/9/XuQpF+lN4iAaelrtXQ+Z+ob7qCM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975120; c=relaxed/simple;
	bh=vwBy2s+S/oVuWSQFCOAaYf9dasg9P4SMGGN3EYJKv8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSI80504cu9ihk9RQxU0t6K4jDMlWzyYwTYhIfFSbHyShXaMTvezJzcj5gmb+9PHqV78ZN3IkKNuwtCrUNBRykUVKPxx+JVWVQkywTeRAiYakCd/Yaatb9VnwvoK5UmJ3bIhgmkkvukdJT9mo8rqxmUbVJ6SLsWcBO2M6lLsSs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI0nMWcA; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI0nMWcA"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-446f87b6de1so3404966fac.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 06:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786975118; cv=none;
        d=google.com; s=arc-20260327;
        b=bXu8NFDh0doGr5dlXPi+ReUpstnatYF9m/4OPWty2u57Q/0hgPkFhM5tvDISUB1+XU
         8J1gOFEPdn+hQExF+gpCslF6IyyQJ58yUYQ8eIO3M2+TO++0wnlb7CZbZBF4IsV/r3Gh
         Y8yzSUzI7dOGYNCVFpyguNjTdhOVvU0QLX5KQHtRy/UZLzkCvTwvXEwidpUUwcQ0R/gu
         ZfxXhTpD0XZhsgu/dBXsKrpte45PUbYkbOehYKv/2TIAsGikS7BOaJ16h1bKvtkYL+qe
         QtP9GKSWc7z/D72sSvuP0oGuquGWv83AoYhx5v5/7xmvzm0bYgsYG0qriJUBHFZhAyt8
         rOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vwBy2s+S/oVuWSQFCOAaYf9dasg9P4SMGGN3EYJKv8I=;
        fh=jKypAQsinffTBS4PaCHk3Yr1oHjcu9N+jEMdzGkSCq0=;
        b=PoHTwt/VPy6vTGeJyoMHdQUFFqlMhnq/D5JLumAxchB0gRH/q6YER/6JH6jq+oTrFC
         tFwZGbAG60NV4OxPW/65P6HZWNNPVM69iKruDqHsCHTqRd2O7dBBrG9tuTRrmNMcv8vY
         GgX1jRb9kDhvpuAkQSq0/+iEGrqFVzm75pNopiFm35WWDbXDU/4DitubSiV+hfDISMzs
         LaqMHFBGQBsJLwz2djgL2t7m1YLfRlGCIE1dDwkZNewBdWOON7YN0mSpUnEYWcaQ9P+Q
         wCrsRc8nUQe+qTLLZKdUGtM76+gvYuwtHomqspnbdKOYZmRmIpYjdJMbkRRD+bwsae9P
         uQUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786975118; x=1787579918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vwBy2s+S/oVuWSQFCOAaYf9dasg9P4SMGGN3EYJKv8I=;
        b=BI0nMWcAQ8Cgep5JHFE+9VKwyTmOD8jKH2hjRoofpJmGbuVSH1F7WEsGQKsjHDgR25
         IFsjEWycRHYMi2sZCpZj3IkLUD3HqyUTGqfsR0Lflh09G9IVS562sBNV/8ElhJnJUztI
         UD+yI5R3SyUotXaQknW9XWJeJmoHGrD7H/CBhlheIzsP9ZyvsyAOMdxjKk5+Shl0wXuw
         BZEgCFKvM+CBJktLUE63o3CsyV0ir++idgF0O9aC7np0Y1WZEziGxEwcf8n9JQgrcxYJ
         IaQ7A4D4Ys+cl/VL7MAU88mCFXKdr72h3PNWvVhiG2757C1alThgOUTQQxcHDe/GCHEJ
         c7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975118; x=1787579918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwBy2s+S/oVuWSQFCOAaYf9dasg9P4SMGGN3EYJKv8I=;
        b=PD4t7PsrM+9lOAV/ZrWDs41PEc4kU22F4g0wL66ZsH8HQ3SHQR+ih+Hq229kj4tZzR
         2/rC4Lc/xMOgl6GZPHYnSr5DR1DlGKobHXXeGZeD8vKyf+vHKxsvtp3Qp1FVucS+D7Pc
         tk6OnuIe/YM4d5Dp4FdHoOwDOPJtBGsRth7aJ7F0jac6wfTyyfhLZuEYX3irj6aVyuT1
         cDTstycVrgY5fZDfUdgMlfork1W08oFjrUbXXTHP5+afcp4BWOKbWhEVEaXyec9Wx/oe
         X/E2JpU0Wa1aMKiHw+LwQoE9q2MEulfiRwIaVyKT99GoONStjES9vh51D9MhN0EiHzK6
         dCiw==
X-Gm-Message-State: AOJu0YxVGDIEcYPTFshfaioWT9ecO8lv4LS4KkbvskE1H687FviXV21o
	DHbdWGmC7xvg88xT0uWAKtO4yCRXXQ90s8ksqqG9M3ZZ/8zA3/Lt8tawWz89m2ZHmh8wVy2sHpG
	uxTCLAuBU4qXf+raGIr7grwa65vnQX2RB1g==
X-Gm-Gg: AR+sD10mzyp7qk4RzctxBdOIMDwOmEWoDTKEm8RvVGkdfWotRVijWVsCuyR5PZmac79
	PthAmsgJuaXG6XIV8JGwHxUgtn3RaNLpBlFU6oyeZMUbbIt2s4dlTq1NTwZzzb8TeHI+wP0pnO0
	AqSowbc7qe0rY8OM97uEuDmvNtEdMArCIyObLllNruoQ1qn6zRE5d9MfGMD8LYLETUPsRBcI5o1
	QlKqHcLt7cNhSfet+tUnmpLXzE5HETJwWLPGLH4M61uOC/7GkK0PZTS/oRGQjwJf+5hZUxVQv27
	oddIYQyUOf+DPlQa2LcrQf+UwAvj5aEywCVODQNh6568
X-Received: by 2002:a05:6871:c949:b0:456:cdf2:ae66 with SMTP id
 586e51a60fabf-45f3782c89bmr480353fac.20.1786975117937; Mon, 17 Aug 2026
 06:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814230432.53831-1-kalevi@kolttonen.fi> <CAEjxPJ7diECpC9H+ceKZwZzDVXQ9bbn5R37P+uD8JnpBe3jVyQ@mail.gmail.com>
 <CAEjxPJ6AH+PyS5v80_Q6v3Gx3AOmb3r1X=hnGf5pan=wGHbygQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6AH+PyS5v80_Q6v3Gx3AOmb3r1X=hnGf5pan=wGHbygQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 09:58:27 -0400
X-Gm-Features: AcwNN1WO-DTBiXbGKP4mPu6WHS80z3qBMZmYf6RQD64_jB4K5N7Lh_xpkk7uylY
Message-ID: <CAEjxPJ6NGxMic8PVrHZX6OtUMewp+WSfqsc2KDLso5=nKdUHng@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use bool instead of int in validation functions
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, James Carter <jwcart2@gmail.com>, 
	Petr Lautrbach <lautrbach@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 9:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 17, 2026 at 8:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 14, 2026 at 7:32=E2=80=AFPM Kalevi Kolttonen <kalevi@koltto=
nen.fi> wrote:
> > >
> > > This is an effort to use boolean return values instead of
> > > int in as many libsepol validation functions as possible.
> > > The functions passed to hashtab_map() have been kept as is
> > > to avoid excessive reworking of the codebase.
> > >
> > > The change from int to bool requires adjusting the callers
> > > to invert their return value checking logic. The caller
> > > conversion has been performed to keep the existing logic
> > > intact.
> > >
> > > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> >
> > I am hesitant to apply this patch for the following reasons:
> > 1. It changes the semantics of the return type of a function that is
> > exposed to multiple source files,
> > 2. It does not rename the functions to make the change in return type
> > explicit and ensure all
> > callers are updated.
> > 3. It doesn't provide any runtime or memory benefit.
> >
> > Other SELinux userspace maintainers are free to disagree with me and
> > merge it if they desire.
>
> Also, your patch breaks building the fuzzers due to missing #include
> <stdbool.h>;
> to reproduce, run ./scripts/oss-fuzz.sh to build the fuzzers.

One last reason to not apply this patch: it makes the code less
consistent, not more, since as you said, you don't convert all the
functions to reduce the scope of the change. I'd rather keep it
consistent.
