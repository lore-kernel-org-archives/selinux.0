Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55E1FCFE7;
	Wed,  8 Jan 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348822; cv=none; b=uqt7U/TPSj397RQAjFXjdFNR4KtUbAWH4HSHhgCTtzVvC/T/YPKqSoFuUgVORDdPwc453Cu1RgljZr5b5XU7iEHl02iFIwpr3L7DJtxfzZKB0VUt5rTRuLdgM/WCC8+dqG/UmGQXd0t6eAlgmFmUz/2Uqm9UGIX1LIBTi9Ns5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348822; c=relaxed/simple;
	bh=soyxPENF5yRD/vNYDGrcMk72y0wBsij0YIRwjEDdhdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvyljz92Xn5muRQLoYSy7h1RPg9Exi1mLFH8egjty0ED1yh8CitYu8/1jiyV9c0d/mS24GRZwy1/tcQa2RneienXyTxiszDAw5+WB8oEoVkXvOt0F8mFlFdodltpSFk0UXcYLKlQQGpvgQFv3vC2QL1ROpEhuM3PcA8/VoiO144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VmjWmUs4; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VmjWmUs4"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e54bd61e793so5747844276.2;
        Wed, 08 Jan 2025 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736348820; x=1736953620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYeijlJhb8/hUscYVxlFwBT9DMI5FRL4gN/jsJsz5W0=;
        b=VmjWmUs4mrGPAN3mArAJB0zRlU2IPcJRjBiGIE8R4Vgtnl5FvLfS/m/JZkKnMKhpO7
         0FcQgxR0l5CIjUUfOKhbizsflTNCdbyFKhXnD6XAwlbo5+gObPwWvcj2+Zs1hUHN3tyn
         0uWc/uLcr0lie3RL05i7sXpQGbNMsglxm0XQ2eOqMS5YzooZt2F70pzV2p2XDSemGpHf
         1WYrUbXxx3HXrWyR1IcMsggYqIgQ4wHWrjlNtKTGbqYqOIBzqwE7u3xh6ob/eJ1HnPmN
         BsBip/Z91QSABMlHbO1kzXYUY7Zot5gAztjxgv47RYWv9/ojIExJCrl8hnkjynTUzhH4
         6Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348820; x=1736953620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYeijlJhb8/hUscYVxlFwBT9DMI5FRL4gN/jsJsz5W0=;
        b=QxZfY8TnnWMKxvZHJXt1MbZ1SH6EbFPhlsQw9xZP9wE2BerWsNuOfMlouNc8QYLv9N
         5GbG3M95G4ku03+VxP8gVGGSDDWUakE2hzR1mo7bNuq1Xq/R6N2p+k9V3obC7JsiwtRH
         U0PJ6+R4M2YONkndLJCNZcJuDU59Rk9dvWx8XPS6TOU46HOUe52b5ntfSUkxCzkaCFg1
         3CRIODjtjIYZ/4RR+Y8lM1yX+peLFrBnGpZWxXAO2XET2VnS3qmXdav9oTIuM3xIGD9p
         0qX5jiCW3wObiTdhBKEKq1EaLW/9ZYyq+NnvZGVrp7NfNCx5TV3yBJOkgyTAIoadrCR3
         t1kg==
X-Forwarded-Encrypted: i=1; AJvYcCWXzethuapMyinvnCw86uZjJulU5a4k6xXWrRvDb5QadMg32IR/SOQyNXou+758h/Y5T9JteTOUu6RsShg=@vger.kernel.org, AJvYcCWjFzxdv3XkWMsE+PInmRhKwoSvfj2+MfNTBQ7uVfom7M+yHLZWL6zB/wg0X0BHEf1+hdRPtnLVMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNEgrDkFiAaCHoLavefDDS/gQOQc5exuKR+eCP6siyO7WvalB
	iCg7yQjAsD/J0XmqsntHNVW7H0S+TdofyYMd7jaj15Fr+NVeg8pl5k5Yr9qLZUro5xsmAVxq/m8
	ItWp3wrHWLP0pWAO6Pe4KlQj8eUQ=
X-Gm-Gg: ASbGncssM3BPi6fZ1EP0YnH2ofLqmtp94p2tjB9NyeQ7EgDAESL0YYYf4FAqf3o0rFn
	rbeFimxOHjtrMHdmdhJFsWUtTirZ/KZqD8D2y
X-Google-Smtp-Source: AGHT+IGGm3l2oxrf3+zWOkjSO6t07aSjkSBoeyHSaJxV3miZwqOavRZ0KXeHI3LOettm6bkm2lsOwJ/oGS3l4akaQQo=
X-Received: by 2002:a05:690c:6707:b0:6ef:6f74:9b18 with SMTP id
 00721157ae682-6f5312a6375mr26852567b3.32.1736348820205; Wed, 08 Jan 2025
 07:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-5-cgoettsche@seltendoof.de>
 <01df64ed8f6eb9e6f2780b5b0aa3be5c@paul-moore.com> <CAJ2a_Dei0Bg14N2E9U2FzM0OEvEQbOcTvQ76FH4Ut6JYq5VybA@mail.gmail.com>
In-Reply-To: <CAJ2a_Dei0Bg14N2E9U2FzM0OEvEQbOcTvQ76FH4Ut6JYq5VybA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 8 Jan 2025 16:06:49 +0100
X-Gm-Features: AbW1kvZf3lTwTc8MUnTJ9mwBMMlk3lMwFXegltwaB3DKwHH3bIGKFAqjqVZg4A0
Message-ID: <CAJ2a_DegsCWSB224rFVNjs7QOy0xR-k5OhoQuSvpT7w_+RD_ew@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/22] selinux: avoid nontransitive comparison
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 14:17, Christian G=C3=B6ttsche <cgzones@googlemail.co=
m> wrote:
>
> On Wed, 8 Jan 2025 at 04:00, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Dec 16, 2024 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoett=
sche@seltendoof.de> wrote:
> > >
> > > Avoid using nontransitive comparison to prevent unexpected sorting
> > > results due to (well-defined) overflows.
> > > See https://www.qualys.com/2024/01/30/qsort.txt for a related issue i=
n
> > > glibc's qsort(3).
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/pol=
icydb.c
> > > index 3ba5506a3fff..eb944582d7a6 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -37,6 +37,8 @@
> > >  #include "mls.h"
> > >  #include "services.h"
> > >
> > > +#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
> >
> > I'll admit that it took me a while to figure out why you decided to
> > name this macro "spaceship_cmp", and then I had a little laugh when
> > I realized why it was called the "spaceship" operator :)
> >
> > Anyway, while the spaceship operator is likely familiar to people who
> > have a Perl background, the kernel is still mostly a C project so I
> > don't think we can expect a base understanding of Perl, especially
> > these days as Perl isn't as popular as in the past.  Can we rename
> > this to something else that makes more sense in the context of C?
>
> There seem to be 4 similar macros already in the kernel, 3 named
> cmp_int() and one instance named cmp_ptr().
> So I am going with cmp_int() in v3 for now, but I am open for other sugge=
stions.

p.s.: C++ also had takeoff:
https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0515r3.pdf

> >
> > --
> > paul-moore.com
