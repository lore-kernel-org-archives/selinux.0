Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6F3BC664
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983087; cv=pass; b=JCQfZRnQUxyQcFvUOHSX6wGEWkFn5WL/4+kZLYSH4yKMLfa16f3xSsE223FVzBJWgW52wCmNwNbqqY4/f0ZukWbC39H9tPHXXinUgXxCqnVsnOFenWqsbMgmx01BZmrpm+9gxp0dK/pHDi+wbnrIFVWkVPPyVcfXr+RbHplQDss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983087; c=relaxed/simple;
	bh=FPRkIAy8GT/e+qxM5WbqTJbxe+5v+7wnYQkcNJBds0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjk0V82D3QzcfJLlijeW70WWfa/SipIPQ4i3f32Mt02QHMYGTWAPlVXtmCxjLyDoBCjyp7EDlF51cIaiFIxh+DDOb7Vimvyu9fD4k6Xw96iX0vS7krhlJvYb/h2H4VOMfg1zigc1q9oTo1paXYPVuuCr8sVVLFq8x86cKHqdKRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evb2tc87; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evb2tc87"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-47bad4566d5so528383fac.2
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 12:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983084; cv=none;
        d=google.com; s=arc-20260327;
        b=g6NwXC402BDhGNgyIokYwSMyBWDNRN/6Ad2wHQDOwAbRf2PX47afI8gOOiI2JaW9P+
         bPgaslTrmbJpIXvOx2Us27D0Hji1PSenk5091CawmowjCCixadOAFeutnsAaaGOBYxZA
         hd1ynnDHGDeDQiKwCoQG3+2tdWVqi5EfUfSmKyTFxC9trSsNrP4EUh+gyHmzXH+M8ha4
         UTIDqP3/rosFg9E9TXSN4sfNYDd/VxIIHoQvvp5gzthgFtFLxjRu0yk52AdgbJ9sa/ru
         dZ9KJGh702KE42KeBbcRArzJx2l1HqFcXSgknhrL22IOibKX7XDpAQhdwmA2ojTU8ZZF
         MeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPRkIAy8GT/e+qxM5WbqTJbxe+5v+7wnYQkcNJBds0g=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=mlpgT+EyFTs+DNKhoNGqlNCGMx06Gjhof16X/0/2se7xYwQX1WGGHSUgxQsVwApWdR
         idyDfmiO6EUQaPqzphCNMnAJpPfQ/K9dV8pCSQiVxGjmsg2e17gI8gBTLLUF7lpxCdRs
         /XtkM53OWz/v4dSujANkta7Bz12I/dajYUsa2t9cV3DpVaTPLppjv+Q6eozkQS26oH39
         HTcBg39Wp/4G9BljhwH3dqT/womAh344tGvdNXI9VXS2WyP5T+3WMYhj4hdKf8lZrdSY
         uNdq4+NbHBWpTGtKsEj099ozqjHEZdJDh9M1ryuAyOWxT8xB+dZ2+M8bKmv+lFSU+ejR
         8Lvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983084; x=1789587884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPRkIAy8GT/e+qxM5WbqTJbxe+5v+7wnYQkcNJBds0g=;
        b=Evb2tc87gFAzk7ihSN6j5RU/4xPoHTN8Okj5Wa8LWt3HVs/Gr0ypdpZ44bh11MdJhO
         hC/ZM9zxtIlIaFXwioSCWP0LaxJZos4mWcWa+sKYgGuzbJMHd5qZjr//prg7vzqpHXBe
         12J5k6/73Huv1vYOzYjx37BGAB4N9/AuRAb/8uZKHtzktQxtycMZIMdFGlu+ZTJak6a8
         dvGhzdyD6PdALQ9ddhSdVQOxv1ejkpefwLF7w2n2sHzoBEMFDR94ml0Aq2rZbj6pdOSW
         p+Pxb+4TH77D2fF1b6EITO4Lsvnh9ycYG+CiuNZnwoqGB1zShKZK7jmaOiLYFxazUQmO
         QcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983084; x=1789587884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPRkIAy8GT/e+qxM5WbqTJbxe+5v+7wnYQkcNJBds0g=;
        b=shVdD1DRP6lz8VwyOdy35I534Y6iXwXEV0ZLwqsHIXDYSj3uv9Fwdobq7oGaN5VKB8
         mCZ8cdZ+tRHazUhstFs6RLIy0ETznKw92hohwjVqX9UoL0X3T0P1jIuZg2ASYMrD7afQ
         O3iFYinI4Thtalwq+jSI+zSQhxu+y+21Xk86qxC8cAfgP/9/v4b8K39EhJIdp5EkqcrQ
         vhPnWyrxsgP8ydczx2Qh5/z6c0U+Zx7k1aZlD75dNb8YtA0ZFdG9milfMcoAQY9wyx9F
         unX7RLM30h8Ia8oxsDgILgi30t9tIKFGd5pWs2DfhXZ/oYVecxYymtCeVm5+M1XZ2Y6D
         RxQg==
X-Gm-Message-State: AFuF++kPF5gxB6TsHMG0F7xhoT5WT2h5gahQoLrUsok3hbjdeGtE15l/
	VBPZ3SQDs1XT2EjdP9lm8uhSXqUunJPwl1ldie4wvoVrGA03fmu/TZuKrWZR93Pxc8PNH09Oc2Y
	bUf7YxTDzJ+MJfPK2GG+vYYGFfGgYMbciuw==
X-Gm-Gg: AYBFou2XVf51u0HPQnbHWL2khf6qPoxIzQdK1cNXf5N+PqOXLQrQayY5HxZ2CIHxuPj
	wasW6i/SF9UIZ9gUfAJPtNmlfZuY9W6Jmb+I9BERW68NOnT0Vg+cfb3xVu0Fu3c0qroPX8tj6Hv
	+PvQ/maR7DFGzxQ+L3EUPmnGXpjRvkLXiZxikil2cmnuMrFYUVSMMEUaLl5+q+aFeA6DbtyosHe
	jD+bDpCEFImI94f/5upfYPF/w+46b2bkkfo1Ij0Dq0l4pZqb0YxprhLYWOOESn65j7VTP+HjcBd
	Fyt2aMKc40WW6aOhiKtg/ZXAsWCUImhj0A6Ts+iQZ1S2ZbSdyl166Is=
X-Received: by 2002:a05:6871:ea06:b0:475:e235:8ff with SMTP id
 586e51a60fabf-475e2351012mr23142906fac.29.1788983084635; Wed, 09 Sep 2026
 12:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909175448.32721-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260909175448.32721-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 9 Sep 2026 15:44:33 -0400
X-Gm-Features: AcwNN1X6MH1qejegx_QVIIz9z0p-EKYHGGnOBIx1ysrZnzoMqG-kB031vUR__x8
Message-ID: <CAEjxPJ4OFhQYdn=BrUyvbncbyHxSBLacE=y0Eeq5njrWLm4zew@mail.gmail.com>
Subject: Re: [PATCH] libsepol,checkpolicy: update remaining policyvers
 comparisons to correctly handle Xen policies
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 1:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Even after the previous two patches there were several residual policy
> version comparisons that failed to properly account for the difference
> between SELinux and Xen policies. These differences will only matter
> if/when Xen policy versions > 30 are introduced or if/when the minimum
> SELinux policy version is raised above 30 but we should go ahead and
> fix them now. The remaining policyvers comparisons that do not check
> target platform are only for modular policies, which are unused by
> Xen.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
