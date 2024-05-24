Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8A39FF4
	for <selinux@vger.kernel.org>; Fri, 24 May 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558592; cv=none; b=oEuJNZaV4V2N+LgdxnxUpA/8QOFPADEDUcnTXmW6tVVmldnxAy0EJeTu/O2S/C481ZzMXQoUGTPyQgQmCCDw0cp3sPz3oHjWkbtplaxQ9tVmycEZuTnuGXmtyHu8r/6Eu4L6g2nXt4xQOorT295MOIqARhCoKKUPK5NL/YcPKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558592; c=relaxed/simple;
	bh=cu576r8YtmA4/xWbyiCXBgp+mXpiqYf81yanCi65XMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt4G3gOgKCDPae4piJ8zQQi6nRKaXeiM2vTvb+fp0rNexLGB6Zm5CTf5y09iE7PKsAfZOob1TmBlOpWTkUT6oUHdN1XIvv49oGFxEmunwx8IjMMuY37vkQGHrntY1qY0r7bxD+cQDzFnTsvgJ1sqjq4O4lTkE1cXLwx3t0mTrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWWlH5f6; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWWlH5f6"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-481e9c27378so1088358137.3
        for <selinux@vger.kernel.org>; Fri, 24 May 2024 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558589; x=1717163389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkCJLeVms57bj4B47hgkODunbUclPyxvyxSRsZAD9qc=;
        b=eWWlH5f6MEXup0M35R5pP4GKh4wHIcYp5sf8RhqLU9YFRbgRJH39ionzg2wB+remr5
         +LD3kp/qATMzthdg+TEHLPHAtM48zxjE7rVRDVgnYO+TfiaRS1giqzBhHHFiKo5+Jz4p
         Pyts6BwK7a4/w1n4ETqS4UlL4HxqUrKzNr8uc+TBUblj+5aNiGxFwHQpGALi1EakxgvQ
         znZ+VN5hwYcIIDylz8IQCFpLOZOtogBl3XL60a4LG0OnXu10OZ7QncRvAt6CjKZXti8K
         DIJvwmrozD0N63gi6O5vagoj3oaTavWgqpitqXiRqlPOrz2kO4bFDGj1KLN5iJf3s4A8
         aE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558589; x=1717163389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkCJLeVms57bj4B47hgkODunbUclPyxvyxSRsZAD9qc=;
        b=jfSyhv8RWFvXyjAlAf46Op9ZERMDpDWhj0KjTPVqKh0iOXNLQkzZJjRKrCZWYkEEtF
         dkgSNzvDgIRBPo+fHAYMmjwkf15wi8fD4ksYTVIsvGoZGsUawsuHZ0+5AlYhzm74xhZQ
         JhEEZXvSWys3sgIPhnQbw4rB9uZrzah54RpMC7t5blOjgnlIWwDOJ7mbp468w3cvJgaR
         uxlwFVlrddH2k4ZXpojU62NWH5lMh4YwLxuKq74/h3/cC6lqaXMP1h3qXH/n6GqXe8lk
         mJ0pLw3uvKDXDET/dQo7NfoNnKB3QO9Fed5nDO/cNAzj53ygkMKley0u0Moew0+GYKRm
         J9tQ==
X-Gm-Message-State: AOJu0YwqY3Cui99EBkeApo37g0/Stk2DfuXCsFyVD1ICRJL5iG9/vcxd
	dI6pZgBzC95HPQCGqktBRtCC2X29cPYdhVzw5fxxkHRCG7asr7ID4+NV2zY1mpQQCs3YTvAyh7R
	Q5JEw3P83vzg6B7umb9qWUxObcPJEuw==
X-Google-Smtp-Source: AGHT+IGC7VebQPYRrgPwHZxrHtRZMMR4glGBIHBuNtGnLMQqkuFfbuyj/FxQc/HiKlVZiGN2lJIFeaX0Bj5jjw9W5lU=
X-Received: by 2002:a67:f2c7:0:b0:485:9a12:ca5 with SMTP id
 ada2fe7eead31-48a385c72eamr2261913137.17.1716558589517; Fri, 24 May 2024
 06:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508170422.1396740-1-cgoettsche@seltendoof.de> <CAP+JOzT-5hq2bx-XbXWMsFORY2FX7jAO5Lae=87+pRqZza1bXg@mail.gmail.com>
In-Reply-To: <CAP+JOzT-5hq2bx-XbXWMsFORY2FX7jAO5Lae=87+pRqZza1bXg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 24 May 2024 09:49:38 -0400
Message-ID: <CAP+JOzSkv6F4pZLXp2gQp2TYpYDJW4jSy1FpvC0Y8ErxqEa1iA@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: perform contiguous check in host byte order
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:16=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, May 8, 2024 at 1:04=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The contiguous check for network masks requires host byte order on the
> > underlying integers.
> > Convert from network byte order to avoid wrong warnings.
> >
> > Fixes: 01b88ac3 ("checkpolicy: warn on bogus IP address or netmask in n=
odecon statement")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index aa2ac2e6..9671906f 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5292,7 +5292,7 @@ int define_ipv4_node_context(void)
> >
> >         free(id);
> >
> > -       if (mask.s_addr !=3D 0 && ((~mask.s_addr + 1) & ~mask.s_addr) !=
=3D 0) {
> > +       if (mask.s_addr !=3D 0 && ((~be32toh(mask.s_addr) + 1) & ~be32t=
oh(mask.s_addr)) !=3D 0) {
> >                 yywarn("ipv4 mask is not contiguous");
> >         }
> >
> > --
> > 2.43.0
> >
> >
