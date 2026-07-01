Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65211624C0
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867682; cv=pass; b=EwZTtUr+W5ScVch8RKNE6fDagu+7RUt4zKZls+YQ7H4ug8jORhpVI2pW0fhBSLaYAjro5pxySxpsD6T2Z1HqneU0pFULHfgQopfaAwTKadd/P9W1r1MDQ5J9Mb9y50Wzfkw1yuwZtQn7xqyvapDaOc0dbqXl0YPrJ9Dtz6pQtsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867682; c=relaxed/simple;
	bh=lCKZN6ToiTF97drWiuXRNZ7dBkHGtNuNvs56AaKZVKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXs09ZrpHNa7ouNbU738G9EEPLlIcwCfmgaxYDAy+sLeAysafV41t+UkauGjS/2alqd0HYYD2bEfbRVycZX/ZZOWXfAERfkwgnAfPCElb08X2jOSDvfe0F3Sg+M0at+RrIZ3CdhGzn7a29rG/5eTIRQ+fHuYlmUsoGyIHwrrja8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YAqp9bZ6; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YAqp9bZ6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso57196a91.1
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 18:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782867680; cv=none;
        d=google.com; s=arc-20260327;
        b=lNde16NDY48PVj/yQ6U4FAj2lcCF8icnInk4JGIOplNE567OB5KeLEDMK5DAIZDGCl
         e4BIJ/izECtz+51+YmvzSppWpr54PkkiE1dEXLRI0WW2XwfGE5jUBOqeQlVwAToRZSXU
         hKnUKU5Q8Se/4GwmKJWP884tG8BoHkbIN8PB4UOAF9lKN4N9Iaj2QVEumNX5Op7tQNPJ
         3tMFOjnIlEIMWbSse9jTc+46xJvd/VIoytebfUDlLAZ8ZYBdRLE5G1iV2x0oCx6qgbvc
         AzCc/mGbkDM/wJbBs9Z+y1u4g6/9fH3v3O/E8shqJhCHsnU6JKYvTtA5GC5JlSOKN1AN
         hn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ci7gWP2h/xtf3jvVwNd+rFboszO2fpzultsBVkBU2u8=;
        fh=5Gus89Gl8D4KsHCmzC5w8pSX5IAUEn4bc7ln5LslHE8=;
        b=fcyG5wAI7pjlP2jHTqAr71Hp8E2oVNOrgeLfU86+F7z/pcT3+kcZnE0IfoU/v6nV+F
         KTfMmjwUogK2BV3cTEs7PWRJecN6buY5AJ40Z+XGTM8xqGD4XZn851Iouiu7/X0SziXc
         uQ8wGL5H3mqAECGiOvlu3Ha3+A2iGCnwy8rG00gj/fJHbSHhCMcFvo//WauGFAlz/2aL
         fm9KeA+AZhFenC/z/hDagN4f5u/hFVoyBVINOAHVOuryYUJSeXDWD9RZSW6KUjKNBh9j
         nIr3loGrze/eAhdyh2dJLGc/bYw821dCZ4vmPJlA0yQpjWh9htQ2Hqkewm3HO4a1M+NR
         QQww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782867680; x=1783472480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci7gWP2h/xtf3jvVwNd+rFboszO2fpzultsBVkBU2u8=;
        b=YAqp9bZ63/OGTlYMnDuzQ3M1GMKIE/AOPSTFdGhII7cCBu2UY8BStFrGD85mTY731B
         qIkq1CQtosK4G+LfRO+XXePtgXdVTm0ZlBtIh6pEdoNXBgnjGe4ionwUdrr7AwFwF5I4
         0MtC/RVLS/tcgJAb7M8mhxpWvwqSSfVLX5w4FLnuIpi8OhXE2ZO/PhLSBCP143jXRdEr
         P1GTxR5WkP7sVpKCY2KUdX7+S3rlqSpe44wBZBu8qwIsTZM8s+wtlS63cr/wySjFXzLr
         +LiBIN0BxDiLSijIvHQYZdQtiJjKNp3o49xZMu+JjRm30fodR48TYz5SXGZtPSogUBbb
         SIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782867680; x=1783472480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ci7gWP2h/xtf3jvVwNd+rFboszO2fpzultsBVkBU2u8=;
        b=sy+Gd8835BUBmLz6tzv6IEHY6e33S3CtkIr18mr9+A62L5fJADJVezkn4vph8I6IzG
         eHn+IAGs6HmF7pi3cJo97e9CVEHPuu1pUK77v44xv+8Wnn/go87qqtEP5/HmB0PvRTlo
         +3Ng/96+U21oOdzCapG8LYqE9foQZu7vFmm0ClzC/7LbdSw5M8szVS/fRey/Lnda9ual
         256J3qtGm1gPJ2ZIdDN8+WPoneoeDZ+Rjtw3sGriHLj+ZVBgD4XVYl0wugZbLNL3cJpv
         cm9G6etbxzPShSbtnQZRDowjGImQJbmxQfj2soD961n7kAw6lJVZaJGQmXUngyE2AZ8a
         vgaw==
X-Forwarded-Encrypted: i=1; AHgh+RpAJvUCMfGErZqVThAwP6bu93YS8WeBxQBa1Q0fF4gR4cIYzq2A6CaKW5hpI/IrKHyHNGwkwlMb@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOpAIecdaxOzn7XSQGGn4MGggs9CU9dUHDy+ckp5PXj1gzuMl
	TbUW0b13pf8/5sT393IOYVGdNi9H/v/LzfM0qxvQUTEJco3H0TWbQL7UphLygOfodHFdFHvwiQo
	REXLgXUuviVefX/P+DZVKQ0xVHSANioUF3B7fYx9Q
X-Gm-Gg: AfdE7ckB8p9oSGT5ei7Gfd4S+QKX3iU7LvugWpdERN5KXanCK/rVQNzCiw3trS/WOv2
	e6l6Q0AIapSbUvOKvRn7gG9Oo00EtJAJ4+kg+vu1o112HdzIkd77RmTcRb4ssZ4PoL7xXbPfVAf
	z0geifZCTdmklfvG09bYyyv0Sl2meTlAOAppZSSykpvi5av0y1Kt3xzbYb21vCISUWgAd0lFOxt
	xrczrxfyCO7kGJK0x64PxjwWDFhbcQwwKvYJr8OaQfoy3STegsZG5hzAK7eM90EXS0h7uwMtSza
	ux9YPAM=
X-Received: by 2002:a17:90b:4f4d:b0:37f:caf3:171a with SMTP id
 98e67ed59e1d1-38052559d5emr5595765a91.4.1782867679957; Tue, 30 Jun 2026
 18:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-security-v2-1-560d33c13ee6@kernel.org> <akOZERjhp302jhut@kernel.org>
In-Reply-To: <akOZERjhp302jhut@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 21:01:08 -0400
X-Gm-Features: AVVi8CdzHGjJVtgP64OlHgyKiOBBF-BFKpTaq8pGUJg-AodsMxNfqrpADS4MUHo
Message-ID: <CAHC9VhSekkkDajeFxpjAvaRyUnrfThX9hB1MD3aYBhYMCoRcTQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
To: Mike Rapoport <rppt@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 6:23=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Should have been:
>
> Subject: [PATCH v4] selinux: hooks: use kmalloc() to allocate path buffer

No worries, I just merged the v3 patchset, it applied cleanly.

> On Tue, Jun 30, 2026 at 01:15:24PM +0300, Mike Rapoport (Microsoft) wrote=
:
> > selinux_genfs_get_sid() allocates memory for a path with __get_free_pag=
e().
> >
> > Such usage does not require a "page" and the size of the buffer should
> > actually be PATH_MAX which may be less than PAGE_SIZE on some
> > architectures.
> >
> > Replace __get_free_page() for allocation of a path buffer with kmalloc(=
)
> > and make it explicit that the buffer size is PATH_MAX.
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> > This is a (tiny) part of larger work of replacing page allocator calls
> > with kmalloc:
> >
> > Also in git:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-k=
malloc/security
> > ---
> > v4 changes:
> > * rebase on v7.2-rc1
> >
> > v3: https://lore.kernel.org/all/20260531165852.1478916-1-rppt@kernel.or=
g
> > * get the args in the right order
> >
> > v2: https://lore.kernel.org/all/20260531151502.1467515-1-rppt@kernel.or=
g
> > * explicitly use kmalloc() with PATH_MAX
> > ---
> >  security/selinux/hooks.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1a713d96206f..d1f089917a82 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry =
*dentry,
> >       struct super_block *sb =3D dentry->d_sb;
> >       char *buffer, *path;
> >
> > -     buffer =3D (char *)__get_free_page(GFP_KERNEL);
> > +     buffer =3D kmalloc(PATH_MAX, GFP_KERNEL);
> >       if (!buffer)
> >               return -ENOMEM;
> >
> > -     path =3D dentry_path_raw(dentry, buffer, PAGE_SIZE);
> > +     path =3D dentry_path_raw(dentry, buffer, PATH_MAX);
> >       if (IS_ERR(path))
> >               rc =3D PTR_ERR(path);
> >       else {
> > @@ -1361,7 +1361,7 @@ static int selinux_genfs_get_sid(struct dentry *d=
entry,
> >                       rc =3D 0;
> >               }
> >       }
> > -     free_page((unsigned long)buffer);
> > +     kfree(buffer);
> >       return rc;
> >  }
> >
> >
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260520-security-6cdd60da7129
> >
> > Best regards,
> > --
> > Sincerely yours,
> > Mike.
> >
>
> --
> Sincerely yours,
> Mike.



--=20
paul-moore.com
