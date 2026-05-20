Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1D283CB5
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308018; cv=pass; b=l6cKXHeCRVzrQJLmRKNriTGmav+Z/KXJ8Zol2Fk2CxWJZEJEmsW9jIEX2ISB9im856T8HwyDaqyVP/XPsstpsS+SBtenk56snIiNgLEDwHggF1tFLxQnmb9EeWSzYxWFWmUZ7AhFh95U82kpYEWirTCuC9+ndU+4uSpwt0ROk2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308018; c=relaxed/simple;
	bh=3w6Yyyfrd/p5OAJ08oAeN5yWqjzTbzIWTudhXa3GBAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK6oiFnQp1YCBz5F7fsPLra0ng/w+7hJTFEHZNeAUtS60KYVwUpo2GlJaGH+cHPRbgl3oamXWeg1rp13mVitd9BjA2YwnN/f9cm6CJ10mhBVkhtiCLxJPDE7oMWtWRnG4HhdwrxeGxnqol/PGU2Bhkd/p5dPUTUAU0z3CCaCOrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KniEygHn; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KniEygHn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso4061492b3a.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308017; cv=none;
        d=google.com; s=arc-20240605;
        b=IYyV4C+N+bx+CkwkgnUlpIAoRXjmi3RKOrBHplVtNHMkDHTsmVrpJawQNkMX4Oq51y
         ohpUrTnwlkGjFlwev84CA4Bv3hmBKhzDx8kF06hhavczYq0m0IbL06ZY9cBO3ObY2nHP
         YQXQok4iz1VJzcjHjVose78porywF81/JI8H8iqnsV+O8fLkwPw32ajOp4tEGEor0vDV
         r6T87b+ReEILlKtzwSoni3z8iRpi0hHqcuo8kdlpI7Lp61E9wASZDXX105BEbSUF202S
         wiged0zeFpeRbbxGvm9tOYAP9E/kovGBuvTFraj5x/cmovagzIK6yYdbY2btnMwLmYDw
         pKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXFmZmSo7+kTaL7bnRESA7K3blJFK9q9prJk1yLtySU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=I1bv6lbdWfAYzT/P2EpuK7MOLkcCQNjlFNcCtzMpBsliWIV4SrXnCl8SuRU+xHcBtU
         UblXK/cLcOaqxh4ly601x7jFOW+PbjmVVuXncLqhN9piJGBZHaQYuNbEHxVQczpIH7BI
         8RnTUibeUuSOmqEPI66mkz/0rbeLyq6zThOyv9NgKhdEFDUUqN8PzFMMXnjH8pGiS+CG
         TCg1mcntBrRBUlVCkMBOmd4xp+qMj6us33sWMjC1+IlG0iJopeiDyskCbTNPpgkuOIUw
         t0lv1/SLC3pYQ24+pgq3qqWEk9Di4zbY9B5U+Zq56JsEgctOnkM6mlNRysAbj5112rcr
         KmUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308017; x=1779912817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXFmZmSo7+kTaL7bnRESA7K3blJFK9q9prJk1yLtySU=;
        b=KniEygHnby+vPC8Uf7dj/zp8+votxyPAnQCgvdLRM61CFxkEzXBdBHIVHt6RLOBBNI
         w7ErKI3MqLrTVvrsDKVvNuEsZb7T5Fepk7KWNuBjankIZhzzxLnf8dqmfTRImYaJ5rlw
         PHCOBUkizbtmOfqLd8GsZeL49+/FsOOcJ4zMQAeNyTQl9uckiFUlf9ISCQcj1hq2vuub
         TMEE82RgkvPuzqE6aOH17Q1JCLb6zLYCtkhjpBdSzOvWv6mu1XWAEQaB5KVYvr/Mt0/l
         UFSThMUvPPQ/EFqGA1Hk7mMkoxjuLFQYjjBymD0ZeJy1lhIKA3vbOcjBdANFqkj9PAgU
         ofOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308017; x=1779912817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXFmZmSo7+kTaL7bnRESA7K3blJFK9q9prJk1yLtySU=;
        b=J/mwBswgKd4Yg6ChIvRq3Hxqk7P/Z+/eojQJylx9ulp0BcUHTW9EwQJ+SYIzJPhdIH
         3vTUrcvlCeAH1KBpBU1HkBCp9aURw4simp++6HNmQQ8sGSCCXgaEc8Skj+fa4rSOZg/u
         TD7TpN+9Y96VrvuN/YNpF1okXF0G0Wtc60J9MTtRuq5jjUiQGQhbJd9H9eRvWfc5fz92
         k5vfu43iyKNXaYSZ9rmPLvt3dm5gSzXPx62+Yhol7zS74fw+1/Sou7D0p9XHyXFkUp9I
         iJ1acioO6aNQ79wJ4yDscIn7JEZRMlQJ6NORXYemvrLrGz/Lj0LvVi7Z4AX+qvYaIGC8
         zt0w==
X-Gm-Message-State: AOJu0YzoGaTfV9Zp7UZ+7AiCWp7wqHmPiThs+JUAtLIL4DY4XtlS9FLw
	Eqm69kpHxEiWsrHktllxmGuQPqDW4UhEqfh8ed39Ke514/B8DmYMlAz+ALknbYpmvfvfhbjawab
	82Yv+QdsRdhnWAQzn4bUGKMTNiE12ymfMEg==
X-Gm-Gg: Acq92OH32xbm9/ma2u6uc7FjBzJVGwRYQBphh0PbZSRthMjWnZWWMXDv4omlDMINEUd
	l5BBcqiLrPEqrSRrFg899QpiM+3mxdKyxKeK5h3oeRY7g9bGOxeE8OCNg5RqQp88GrDpSJPZXFI
	LH+/XUmLkMMOPFXDp4m+8+XZjH+jwUEdqy884SQirFwJIxU8AAFeNz/3JWn3vPjDZIA+iONypgg
	eJUNYJv2vb0Ttqv2HLqSMZptg4/OIpjI19TR+8DB9XNyRGPqm+msGSq+jmwnHMmzCWEsDxemg2d
	7wpZnkhUpYe0iopL3g==
X-Received: by 2002:a05:6a00:3e17:b0:829:7a62:6a with SMTP id
 d2e1a72fcca58-8414877a1d8mr681517b3a.22.1779308016773; Wed, 20 May 2026
 13:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de> <CAEjxPJ7tHxw7mJewLzO1yik0-S==HwMAu=xgsnsB3m8WVsjuNA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7tHxw7mJewLzO1yik0-S==HwMAu=xgsnsB3m8WVsjuNA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 16:13:25 -0400
X-Gm-Features: AVHnY4KV4xqxuu0ZUXvHw7CRoiodsuTy1OYmXt5S36uqwBWY-gpWdwDaKTSs9ZU
Message-ID: <CAEjxPJ50+1AmGqHSE1AhCTMPZUQyM6wGrWe3=Wgk7q_8+YWFgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: reset scanned file count at
 selinux_restorecon(3) entry
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 8:19=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Reset the scanned file count at startup in case the calling process
> > calls selinux_restorecon(3) multiple times during its lifetime.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/selinux_restorecon.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index b4d58b05..b7defffb 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -1446,6 +1446,8 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >         int error;
> >         struct dir_hash_node *current =3D NULL;
> >
> > +       fc_count =3D 0;
> > +
> >         if (state.flags.verbose && state.flags.progress)
> >                 state.flags.verbose =3D false;
> >
> > --
> > 2.53.0
> >
> >
