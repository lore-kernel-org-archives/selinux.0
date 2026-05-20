Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B03E7BCB
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290596; cv=pass; b=l1Ba2WNMl2UBYeT6OeVWq6BznFVAyftUJ6pkz9yRgwKgyl37s0oZGUr8meKY0MDqZoO7NpmwXhPN3AY0gIvHwb9UItRZ6T4VwKLlJg9IdyLBMpG/GhEx+bH7xSxHZLWyg0/aOwhRKMJpIpeyAaV+Kj9W6G0xVjSZfJj4qXSz9nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290596; c=relaxed/simple;
	bh=aXvy8Bkfckh6QFS7UZd6AWqmxFqQ2qzYZVRErHYSlQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORsTxdpY3IZxR5tff/nJu4hepOH2PAB8anAuioUGVXYRWPUp3L5oy473kg8Ox4fd3cQQJEvI3Wl2doIvhHFLf6bFtroloVN2labK6FnM8mkhO6qJhQIklQTIhAHEee68s5cf1f6+N5P2H8aZp5YHjaqfq+KLvVjdeL+dDWkQnjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IV9v3B3+; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IV9v3B3+"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd5e373d07so50092447b3.2
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290594; cv=none;
        d=google.com; s=arc-20240605;
        b=je1S7RUljEoJrEM7hvqouIp33aEfjBNXTOVRGiEhuKD4qnAmR3iLsCyLzE9/7EHfRt
         99M4Qw6hgrhBQsH6KKNFcG5bAboUEW2nJgvcyEnY4DaeKnWW1SCAdOyq2IX3hLcw/1kC
         kq7yWxlqLpVh3tm1BYBc1Y0S4/OG4sMJ2q+0Jk2WPQHhfxHOd3CurxCqczBkD65lFfjJ
         HoiJ7EZt+cgpmOcPLgyQZm/uuGm9iWlVRgSkWXrekVgb7iBq/B1ibB0CwN5/YOjlnfAW
         qfHSUybVWhL7rd2bn6lYODG3qRLt73Rh6M790prqqHQreen4XtFxi73RuGy7k0+3KOG3
         wnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9axwrwe+lhYOHuuTV2mez5p545zgNQ5q2pVLYkuZius=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=eK+e4fISt2PdUhD3V5HrkGj/yivE0saM3o2EoZVKBfKP747+N3M7q3nH6+V0fSqnCD
         8/jylpraEBPwN20PZDTyDk+6eiGjKcLBk9O33oZppVFvi+iV1KPxuuWbQCUKoev7zO52
         p3nE9CPtvUHABcfWx7uHpVVAkcPt4HYW6lNm10XrliUCe7sCe0nfSYvv7cd7O43N52Ps
         iH2gFLWJp2EeHspDBYcOwz/y9S2wnXVfXFiUTNKLKVkbtvOzJjPNIvzPFSiRgNdd0lUV
         pM0t9G8KSk2YV+Zi8v1j10+YzrU2a3eTiDDGguqVtbsFjtCC0NU2DsumPk+WqQsLepLH
         aV5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779290594; x=1779895394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9axwrwe+lhYOHuuTV2mez5p545zgNQ5q2pVLYkuZius=;
        b=IV9v3B3+SyrJcqVDQi8gRq3qp3N15rZ0FA64W5wEiR9NRDVBdGO8mUFZ0B21fr1sgN
         bmIRSZeR0a0dTDf9ZKLkLbd8chNuFRC907iiBWs2xbStah0+8SbfFHt/V1InNG0EZG+R
         PVct6dNIcSV0gCuBAcOWpRnQr/mZ3rr2mxLJwFn8MF3vS4BMSGkHKcu/u29Ypym3dzb/
         sohk7TwoQ4cG2XLpOBE7cmtHiqR8/QC6KYmk0fq+G4Vh1KI21tU21yBr7FwtGyGI/TzD
         bn7PcwKNgNR/NaKXCs1OMfRNeDr4OhDGH/nL+i2feDNF/qoIzMkEPqCeNkCQ1amjZnzv
         x3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290594; x=1779895394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9axwrwe+lhYOHuuTV2mez5p545zgNQ5q2pVLYkuZius=;
        b=jN0J/PYduHowpBScmVFbeqM3d+lS8RuNdKetvHXFunxNw1idVAxQ+gJpWLIDBNLgIq
         rQ/7DROUGsp0rVM/qXFB9DoiMVOuMHkqW+4dz+Abp2nLfioWMtOwonmsSi+h3bjsgC7n
         36sc9jEvJlCLyYY2JJPqMAjB6+TI9cyOLfxksGzWbhzQYV9lmt7UYqg0FFWb/UesanDC
         g/EJ/q6/hQRV9m3FnwFpQbFvnGDnONsdeqzR36zURQRG2II9VavQ4ULfCAh2xE9DNtot
         TTgrcGss6K6ouoS5iMNf+kQVXgVF8UbAKBDWoLhDaaS1ZiDzUA4ebz8KmL46+Y/etAdj
         UZMg==
X-Gm-Message-State: AOJu0Ywd4O/OW98TEHeMjyFzn4ldX0fem66oxfqisHu58ctcZ5jt1uWx
	SioU6V8so+JOinRQCVj4c6eMnxuHG0XV83YCnL6MHyzw2sHU2iW6h3Z5H5DVyA+Ad1BM7JVxqsI
	4/agOHiMVMX4n4W1udO97Mh0A1gqg0wJ2D1BQ
X-Gm-Gg: Acq92OF2dkvfhjeeMg7Vp8CSEQUIUUaFhOQdtf+IyS45AZZhFT3BTZffh3zW/KcYFLK
	xqkuM4QV6DoGrE0Aevb86QXcSeuAifi15vBm/X0tqB6IJyMqI0BCFtkG7pmyqQbXhhs5jfXLuBb
	9xs8SnLBVcmfF+UI6DyxXU4pDI8IzzcdckCulN3ssgHHNmMj1S7Yx52NixF02fRFyWlnI2WNmgP
	VXyBxOh8uCSBMmSSA4agWms3jVMOyEYYgHBncLjUqQFMxlqpeZegKWL4AOD5AUdif3WD76gstwt
	7073qP4kywSvMgACTepRPHaUvlgOHXfb1Wvi8jbjiA==
X-Received: by 2002:a53:ac81:0:b0:65e:4b06:f85d with SMTP id
 956f58d0204a3-65e4b06fab6mr15595062d50.33.1779290593925; Wed, 20 May 2026
 08:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de> <CAEjxPJ6rFoPTjd7++x59Ebz8N8MsSfyqNfHXiR_TJojg3nJGTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6rFoPTjd7++x59Ebz8N8MsSfyqNfHXiR_TJojg3nJGTw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 20 May 2026 17:23:02 +0200
X-Gm-Features: AVHnY4LWAE8WrVs3QrGSOWV5ArwcCUWhlLtEwDvJQSYvlucKkE4rGah5BovWwiw
Message-ID: <CAJ2a_DcfS-vSh-AR3Zwc8gr_y1D98iE3SkVt0viA7uu_FYhbqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: reset scanned file count at
 selinux_restorecon(3) entry
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 at 15:38, Stephen Smalley
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
>
> Should we use an atomic operation for clearing fc_count?

I think calling selinux_restorecon(3) concurrently from multiple
threads is not fully thread-safe yet, for example the assignments to
`skipped_errors` and `relabeled_files`.
selinux_restorecon_xattr(3) is completely unsafe due the
unsynchronized usage of `dir_xattr_list` and `dir_xattr_last`.
At least for selinux_restorecon(3) I think it might be not too
complicated to support concurrent usage, then the reset should be
atomic, yes.

>
> >         if (state.flags.verbose && state.flags.progress)
> >                 state.flags.verbose =3D false;
> >
> > --
> > 2.53.0
> >
> >
