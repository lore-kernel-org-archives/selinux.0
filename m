Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA41DF27F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668895; cv=pass; b=NJEMdrLb2LCGZpsQG/1KyTfqHuq6Tmv+KULQg/68UW8JAVirsEAY1kCMKQPgSOFt/1tJ4oXxC+tYKtdeKh+nk+O7zfRclNwHoR3cuT4gFv4unKl2H8VRuP28U2G6uqfczbxw+k6uQRwOSlf882KlzXhgN1axoz0lWjbvwr0PSjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668895; c=relaxed/simple;
	bh=RSnJHPOpHLn/C9G7VFrmnoqTAlh/2ZpV/PloHaufnKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHNb9CgJKfbw0z8jg2gbnUOh0N0Km9wTU7OWYBdbE9OuYwKFze7RXBWSB0C9GfSu+b3boFsKGMUuSSrjnclqgkgIAPF5bY2uK9+903KzFKQ4YLsJ1x+m1YUkOqxZ9ZZ37ME0Oui55tzTktvFsvRxdKEfvPN4VfPF4Is47NV666U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ3qjbjO; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ3qjbjO"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-396bed274b9so17103531fa.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780668892; cv=none;
        d=google.com; s=arc-20240605;
        b=VGdeiuDwv7AY+He65W/mY+B+Mf7boyB9CoNPkGtWihz0qW7/AP/q1un/6qE5Saw8Yr
         MK7tiNDXfB7kRkiZL/3DkvTupTnT8w3SSG3yZh19UbyFtfKXXeznESjow9IQDKkjPGi9
         PaqWENrk8OC7405pa+HnXjJvlgYrbtWQgSLmz5cqWlZJIeE8i7TqZa35VGiwHJf09G6b
         Mtccq/gwlyrizsG74ncSpeTGG8g0+DX5wj18rRRcAt2+n5Gn0/bhx4XsPQgj4dfdoGE/
         QQxPOTkEFti+yt9kXRpb1GcGSyw/74cdREzO7sOWetJxtGDOa53FCkqQoY3CiiCybTMA
         7+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XmA6Y2sKZwWjVG3v+Y7PnQ2keFQEQuQqwm+/J/qKOO8=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=BDaqznomGPCsHGgMDyv1GOE4VI8S5Ib9GthCsyFRU5CVvH3QdTfFT/guAznCUV4itN
         mA3kGNIhdEf8miI631AE8WDJjuLx54ib34JH1L/9QW4wNYu1WxlBg6XPM2+QdNZpVHWk
         8brvsYmFHeBMr4oyiEseiDqGJ8G2edVPo7IUXQllqRGND58D5SWIGudF/IZXvJbVZCMz
         Br7unM2//iWf3MbEhvNBaYZLQZbg1jQqlX1Unvv85HMA6x3Ld7KqwHInhObHONUaER3X
         FsAJDN3DiFISBxkTf2/W41b7ZEW5b4ZWA/eqKgAnxIoelfjXwhzXgyaMNFIK2LbkW3MC
         PUgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780668892; x=1781273692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmA6Y2sKZwWjVG3v+Y7PnQ2keFQEQuQqwm+/J/qKOO8=;
        b=hQ3qjbjOO+IemOTTb/J5wdXyoKAWoONXcefafKrI4TbbVOF5JNRb4ME3iNl85DHfQ5
         yt+BB0ndASQAtPB8J/CMgyndyE3g7MGFrlnrEwMSzEa9yJ8x/9YEq9Zib+17aev+fSqO
         mjODVeJFu8lBUP+OPrFcMrv6gGn7h9Ft5HUByA5oURGM/tUDVvndLcLydeEpPlFg7tMm
         4DzNYY9u/MHjOh1iTUWlH94riZXH388KWZjsiboTBlDzXj4FdyKaJpN2Uv7oJB0JqGpy
         Ux7GQlKBoxEFXG2JvXuf9Mk4wSd8uA+K9LcCz1Hasl+ERWgzKvM+VFAe9Fyn6Cgjilqt
         ACFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668892; x=1781273692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XmA6Y2sKZwWjVG3v+Y7PnQ2keFQEQuQqwm+/J/qKOO8=;
        b=MS/FpXI/Vk6zr7BlZLdsM7og+KCNZSfIP/OLKEIkmUV+pdYIbUM1j8SxESRXf1m3lM
         WOboUkNnAXA1sHNnUKZz3jbUxWsx+GDM/l6rRueqm0HHjvQOd3HoKaAWk533u8RriacA
         3EMJytAflhHVr06YD5n87mGvHCDH1ta6KpC82OmAn5v+h9fpN+qJfx52Jy9eHt0vtwAu
         L+3OaRnybJfaPyTfhpnNkqw6TBnzjARYed2Q+dxn9tJFCsBGl6Pxm7KuRB5rfc7lTU/0
         G9U4arkqUiRXqD5w0lIUFVf2XTrrlTzAeYFtxbps7pGXT1xmJQcIHmt5n5ysMGXUbhP2
         xFgw==
X-Gm-Message-State: AOJu0Yz4Xg60npnzMvRpiuGS68xLurpNr1nzBMPWQnmyt7YZu8rGCU6M
	wlqyQmsPCIL4cmTqRxtd8LkNtW+x9VpSwiPHug7nsf900yU94uCCPOC9oWiEeRDIGIp0W/2xeal
	IgXHGmCd7m/Tk3hwPYTRRUfNLQ3OJhI8=
X-Gm-Gg: Acq92OG+HmpCRZcDKZQw4jb4YgIorRvhop5TUdLzgZElsN5WPdN3j4AOHq8OisVOQl4
	R23c09HNsTnND1M3rQdzKAtqqqetAJzSPeOvMTTVgrxvQr2bRw7Ckerg/6Af6grFp3cTrCU9HbH
	bWUni9tQHy/UXXWIkDDditA0E7cbQStWwsoIBLHv/SmaUUH8MI4f9oxmRGU0D0Tox8T54JhTC0+
	0Sji99Xmr5MepeDv/oX+j7Fx7A28kLEBpcbdJ/etCGw/L+7ItFShHubzIuH1EoG5ZGpgHw94OcZ
	VX+R6Pks3WtxTF2zDSP8kx5jxw==
X-Received: by 2002:a2e:a915:0:b0:38b:be3e:b752 with SMTP id
 38308e7fff4ca-396d0951a68mr11276851fa.20.1780668891515; Fri, 05 Jun 2026
 07:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125940.255722-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125940.255722-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:14:40 -0400
X-Gm-Features: AVVi8CcMsTo7q4ub6RILCqJ9mzEzghWH2FxfB8bLmtRZaQFelbVV8P-3fSn7ayU
Message-ID: <CAP+JOzTcY4iQR-ePFoCvyMQNqKC+OVXMfZx3pktHUVcKXnm_Zw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: serialize legacy compat_validate() callbacks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selabel_fini() calls compat_validate() per lookup. If a legacy
> myinvalidcon or mycanoncon callback is set, e.g. via the
> matchpathcon_init_prefix() call by selinux_file_context_verify() or
> selinux_lsetfilecon_default(), then the callback is invoked with no
> locking and will validate or canonicalize the context on every
> lookup. Replicate the logic from selabel_validate() so that we only
> perform such validation or canonicalization once and that we do so
> with appropriate locking.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/matchpathcon.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 66cbb0dd..2623e5dc 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -43,11 +43,30 @@ int compat_validate(const struct selabel_handle *rec,
>         int rc;
>         char **ctx =3D &contexts->ctx_raw;
>
> -       if (myinvalidcon)
> -               rc =3D myinvalidcon(path, lineno, *ctx);
> -       else if (mycanoncon)
> -               rc =3D mycanoncon(path, lineno, ctx);
> -       else if (rec->validating) {
> +       if (myinvalidcon || mycanoncon) {
> +               bool validated =3D
> +                       __atomic_load_n(&contexts->validated, __ATOMIC_AC=
QUIRE);
> +               if (validated)
> +                       return 0;
> +
> +               __pthread_mutex_lock(&contexts->lock);
> +               validated =3D
> +                       __atomic_load_n(&contexts->validated, __ATOMIC_AC=
QUIRE);
> +               if (validated) {
> +                       __pthread_mutex_unlock(&contexts->lock);
> +                       return 0;
> +               }
> +
> +               if (myinvalidcon)
> +                       rc =3D myinvalidcon(path, lineno, *ctx);
> +               else
> +                       rc =3D mycanoncon(path, lineno, ctx);
> +
> +               if (rc =3D=3D 0)
> +                       __atomic_store_n(&contexts->validated, true,
> +                                        __ATOMIC_RELEASE);
> +               __pthread_mutex_unlock(&contexts->lock);
> +       } else if (rec->validating) {
>                 rc =3D selabel_validate(contexts);
>                 if (rc < 0) {
>                         if (lineno) {
> --
> 2.54.0
>
