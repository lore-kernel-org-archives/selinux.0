Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A823DDDCC
	for <selinux@vger.kernel.org>; Mon,  4 May 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902475; cv=pass; b=l/weFrRyr2ffMzbdkMy19GmPbLAmcX+kcpJfnT6mu2+6v5mxd8hoANOwF+h28gUMnWnOquz39/esF3I9VXQ308jOzioKask8rdii/27EZb+dzX3tjHzP5Y9sjBLU+u4LuVoF72YNjfTsmsA9vCYhNwqWp3NODKVmiJcpC/jLRYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902475; c=relaxed/simple;
	bh=p/IvpPtcvGIus/T2KsMX6Czg6rXKArj99fzUIlsPYLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZka1TNO+NGYc277jHy1nkjBA/xHVwfLGKyw/1Q/wZyu5Vd4eTZ3j/1XT64lM3XZnIdvVm02gQfoN6tPRK7OENa47oMbvdsuWSxxJ/nVQP0pMm1LJtFilupDuB0HykV8ZA2X/9qPD5vpAht0QRFq9FrGVyP3FiZk6IISilZqv0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5/hJFBg; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5/hJFBg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3878de20527so33367211fa.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 06:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777902468; cv=none;
        d=google.com; s=arc-20240605;
        b=Hw6mGKrqstmI3kekrrIs3N1du6S3gvbViZ6+YRy1tSTymATesSXiYZj3xAD7ojMviU
         J40XrVJHaEfDA8ce67GSvTmI1VjJPXOfxnCvndoQgEm+/ANaOVhNpLBm8BQMmttYdo40
         98rvQWKvzPuT6n/1B1TVGrsPIT+esbibb9W+BAr/9w7fbFXIjoFh8jDWisjt1/RyT2ER
         s5cHyz+UWNI4FgHyuwkIAXiy+fWO+We5QFxJ0s1xppl/jf4vGN5pAsZw/9Mesc+QCeGl
         fbBaXrCkyO1rG9I15LDR/GshXsMlE0O2mtALJmEw2dkYwsrE3fwqCxHjC9XbcuW2VIbD
         fsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c5N9SDT3Q1caN0UJXneo+0+OOmvX4J3uvQAzkRmVsQM=;
        fh=QlIcG2BdZhmxnO0USMuM4wLY6ASh5rqEfIpBcO8YIz0=;
        b=TYL+h6/Tqp3oNxnowwwVhLrtKPOEwPY2iifA0lcmxu460+QtTgWlPzQuOTI3ZcKnKT
         CXDEex9JYyOC67X/gg+SrpOqbgjERBZ5pHOKJrFtr7pPJEZg7ABtyD7UmKwgbRD1M5+A
         ylJTiVg+I58+s/odsEKt4/nv5uXEEnTn1unj4MQX/Pq6OaY5+ZOkdgu8zp6yOLE0LlW9
         bDgmGpv9wZ15YugmVJdY3NhaLHAF/0+40ShVr2iZz5rL05eQv/N50OuGTaJL1Gvcxtxl
         mMLdxeddV5dK4JhV8JNh3gKZB0/k7PYAdqF1oOwKzhJHmIOwXa+GJSTeoL3Pic1X4eRF
         OuGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902468; x=1778507268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5N9SDT3Q1caN0UJXneo+0+OOmvX4J3uvQAzkRmVsQM=;
        b=W5/hJFBgItSpCOjWcxe8zcKiquNBMP21XKawg2rRNkisptA8GTVNd7+8kWnF3nGCFA
         5/A7T2A3uNRwU2nz01eQ/ogTvl7WFknidJg32gELdwE3c1uhMJbJ6MNjJQmWj8M6CE7B
         nUnRC24KKiF2bQSZ7z8h6f89jmHj1PK3EtI1w/IjqUlkC5fQfuVvZrF+ymapOE+WPx9J
         nsp+kDgwjcYo7KHwI9sx9C+IWNWnAcYSxYIynfAWvQZO8wiw+sAN+JVLJnfQprguqIOy
         36Hs0qwhJTxy4uR8DR/TguT8RmCM9nQ91UsA/FSz//QI8l502Kov9Uij/6MCN5GMvhzN
         NJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902468; x=1778507268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5N9SDT3Q1caN0UJXneo+0+OOmvX4J3uvQAzkRmVsQM=;
        b=A/PTIE1O0KS6S2uoB1Wo6CT09w0VHn2LJmfu4YTjm7+sVC8HxZI68ZYNkwXgO0jYC7
         4FFS1dDf7r7RjKIe50Wo1gfEvK7C7C+bGYbiA9nN23gLCtD0WNDZReZNOJGcVJACoEyP
         p/qUC5jvxkcSmgAj/p1Cb9kXv8E2TIJ9ChYol00boZcW0vpR2Ti0oL8mbW/UrU6Q10Er
         3huCZbXQi1GJlPIGV9TyxqKTMWrL/zF5uQpywrg1ET1wA0ppWNfrEEQiQD/St1S5mCfi
         WPd5KcxKFwQOnY9WgJnVklggAKb7w6Hryyz/2QArHXq6vGIlhK6I8RybeKUvoKC01C5M
         eJAA==
X-Forwarded-Encrypted: i=1; AFNElJ+l60xBx+j2yzhHATuvCH1m23UC67mOSaG+fWX7aO7Op4b277OYJHtGNRCttSO0b3HG+DR6h2n9@vger.kernel.org
X-Gm-Message-State: AOJu0YzcX/+1FMdbKiPdPJKyhzWpGFeGOTCifY6lQJgNP4yMujKKYitd
	6RPMeN/mSj/xKeUAW6N2DmFCZclGkhzV8u4wLkcNXQlv8+RgCRempi/4518ShU740Kh/HKfzYRV
	TsG/RTj5NEBTDeCIuCPAPVXtyuQkJu+0=
X-Gm-Gg: AeBDieuQ1hJR4BeYaMh/+qYtyKvAOs5DyQ3PSQV1dx8hRF8yVAYce8rNivCg8u4BTtD
	rFxxtZhcDuwrUvi/39xmhA39Jg/vdmKpub75UKJkiJthKqHkzkvZAAynweTBlNssZdIkYYr3w49
	3Tm1tSEnAzbNEUEcEk+mMydH4G1SNVSktfqi0exhZAVsZJWJr4OXicx26ldYCW0hyO7HGggCw0x
	ujrekPwO5/kUUXAJMsL8Lc/704O41Tv2tUCAV5f7FdUlR/MvK4elz0tPTOR7p4a1hCST8rvYIuy
	LZKd8pn2KeP3A+Q=
X-Received: by 2002:a05:651c:1602:b0:393:93c1:b7d8 with SMTP id
 38308e7fff4ca-39393c1b8ddmr21775961fa.28.1777902467502; Mon, 04 May 2026
 06:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330015148.1482594-1-tweek@google.com> <CAP+JOzS0p2d=43EiumHpe9ESQTjaYuk4tAhyD8Er44p7HUAjgg@mail.gmail.com>
 <87pl3b8o99.fsf@redhat.com>
In-Reply-To: <87pl3b8o99.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 May 2026 09:47:34 -0400
X-Gm-Features: AVHnY4L5b4xNKg6amL_wI3O-0pLsGW0bzsgL1JDaAg5Ooype7P_NY2UernXr0tE
Message-ID: <CAP+JOzRNDtiagk0AG_WjX_weaNLJetTrHd+CazTVWuv+knhzaw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix off-by-one error in cats_ebitmap_len
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 6:25=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Sun, Mar 29, 2026 at 9:51=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@g=
oogle.com> wrote:
> >>
> >> In cats_ebitmap_len(), i-1 was incorrectly used instead of i for looki=
ng up
> >> category names at the end of a range. This resulted in an under-alloca=
tion
> >> of the buffer for the CIL representation of category ranges, which cau=
ses
> >> cats_ebitmap_to_str() to fail its safety check and return (null).
> >>
> >> This fix correctly uses i (the current bit index) to look up the name =
for
> >> the category at the end of the range.
> >>
> >> Proof of Concept (PoC) Policy:
> >>   class p sid kernel class p { f }
> >>   sensitivity s0; dominance { s0 }
> >>   category c0; category c1_very_long_category_name;
> >>   level s0:c0.c1_very_long_category_name;
> >>   mlsconstrain p { f } l1 =3D=3D l2;
> >>   type t; allow t self:p { f };
> >>   role r; role r types { t };
> >>   user u roles r level s0 range s0 - s0:c0.c1_very_long_category_name;
> >>   sid kernel u:r:t:s0 - s0:c0.c1_very_long_category_name
> >>
> >> Reproduction steps:
> >>   1. checkpolicy -M -o poc.bin poc.conf
> >>   2. checkpolicy -M -b -C -o poc.cil poc.bin
> >>   3. cat poc.cil | grep userrange
> >>      Before: (userrange u ((s0) (s0 (null))))
> >>      After: (userrange u ((s0) (s0 (c0 c1_very_long_category_name))))
> >>
> >> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Was this supposes to be Acked-by?
>

Yes, sorry about that.

Acked-by: James Carter <jwcart2@gmail.com>

> >> ---
> >>  libsepol/src/kernel_to_cil.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil=
.c
> >> index 06cf4498..49040ae4 100644
> >> --- a/libsepol/src/kernel_to_cil.c
> >> +++ b/libsepol/src/kernel_to_cil.c
> >> @@ -1018,9 +1018,9 @@ static size_t cats_ebitmap_len(struct ebitmap *c=
ats, char **val_to_name)
> >>
> >>                 len +=3D strlen(val_to_name[start]);
> >>                 if (range > 2) {
> >> -                       len +=3D strlen(val_to_name[i-1]) + strlen("(r=
ange  ) ");
> >> +                       len +=3D strlen(val_to_name[i]) + strlen("(ran=
ge  ) ");
> >>                 } else if (range =3D=3D 2) {
> >> -                       len +=3D strlen(val_to_name[i-1]) + 2;
> >> +                       len +=3D strlen(val_to_name[i]) + 2;
> >>                 } else if (range =3D=3D 1) {
> >>                         len +=3D 1;
> >>                 }
> >> --
> >> 2.53.0.1018.g2bb0e51243-goog
> >>
>
