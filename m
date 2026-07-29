Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7B455160
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342524; cv=pass; b=dgnjzxjQ0h71IU+3WPfOTMJ3oofmTL6S+XfsnhNTLgUoNQzcxJooZ+tvPui087oTtoHdhPwfotbeLgG8qzc+CwB80DwclYLTsMvNJbm+21c423Y2DQCPfxLy4r9QLLI1MXVgoMebTaTdeZgaPNJgX5/k9bthaxfBQFJORm1en3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342524; c=relaxed/simple;
	bh=UT/QissGvymtMbTX13X3IEOCG2MDNs8Nju9/B+7m5PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU6IIAuuzZCj9MzmLJ07H7jJiF2IMpFqLcAEXgKfZlH0MD7KFVnMgFwZ718tp3+CM9JCADuHn4oO8G3NgLaPEqsgFEfEn9afBYx2fdf8mfjCedi0t5Io3Rdf7bzilw1TMkW+oDHUfRaT8hUTxNtD1Bcha+uuxDF1FdI8J95sTrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcdkxfFA; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcdkxfFA"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6aaee9a5084so698497eaf.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 09:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785342521; cv=none;
        d=google.com; s=arc-20260327;
        b=Ol5IYeuthThD2cllJSOT67SD3qZo84/P9AIG49ImGRn/QNnPp0NuOjV5Cxx8TMRyWG
         DO9TblbysquboPCTmh5usEitw0LfDex9bcxK1xtkf3aGzCb8j0MIQ4+UyQb/JB+2ORQZ
         UO1luVypBi+/fC0Z00FvmambW3UOEzAdajKF1sWhVID494tlpQyA59iJ3ZGLz+RmVBUD
         GxBfBEeYAfxTzbr2Du/1BnIsRwNvsed41yxZXiNs9kK0gIof+fS27bkAL558W/mwMNVk
         s7zoukyIl9m+pcQUfxf/Fjbzk9k3Cqi3dKiAH+rLgfufFEWP60wwkpGpGkKBVfouOFYZ
         1yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZI2Yr1g3Oa0FFo1ZbH1RR7kBCE4FMD841nhy44eN90=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=VrZf7C2ef6sQhs7R1+SzILAIblhO885xw6wOrArrjYVmO0vex6mNbfGuUsH0BG8wdv
         W6bhMAEsEMFl0muoTANA1SG5sAOj9mYAStoRjboFK/K1mWkjf4MYCygRM6zdh/BlSOYa
         PnZ05C4pRDJMEE6JMkwj24OrFBpRZeAKe3IAs3TfRRvzztA+WElx737oEkCohjLQyw5L
         nAuedaG/qcRNq7vf0Qn8yFeFDBOiB9yhyw2zP8HJidANEBPuFUqxprsqGczFCwVMp7/W
         disgXXvd1SQOfoJCpGM1XwenOalTz7/ZYPDYiUdPpnvQbr89+A/bgcQtZS6mIGOvE3iB
         dPHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342521; x=1785947321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZI2Yr1g3Oa0FFo1ZbH1RR7kBCE4FMD841nhy44eN90=;
        b=IcdkxfFA1rRYEnk6JGFFg8o8/pQXgjEhlstY2fYR78b8iui37oOsHqjkc8YrQWoNl7
         eeZ/Qw0yUnbMr66fWyA9wcV5m7TaooMq07EWl9FrM+mnh4Oj8FscnvJKuO5fKt+WzY0n
         fmqgbainrMwh7ieFx72GI/M8kDC2nU30P4EbhzMbndPaW8YLedDFL1eJUwqNtRug3k0k
         m9zqzuOMaswGlD87kFEHTm+8MJui6wSiD8QW+ZiM/qmPxG0l+TS+lW54sHGgtH1VW3+d
         R/nY7DnGeBk7NdzFRO2NjcuJ6Y+EIIxqY9ASgtjE9zFuwSnl5Y5pLxXAc+MT/iA7fBL7
         ujCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342521; x=1785947321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZI2Yr1g3Oa0FFo1ZbH1RR7kBCE4FMD841nhy44eN90=;
        b=RhGI/qkhAG5qR/i/b37Wdikqla8+v31CUWJls6t6stIsUw0WiSc743wGtzqRpC5W31
         0bp+0N6oECK2OVouutGk8GckZXaZ+2u3ZgmrHDjkPtrZU+65bn7YOSEkziFZ8KoptKbi
         Smxnnt3Z++hWWzEq26IclaA09xe4C2nqfH+z2qEAePG3KQgRa0RRJuI/VzolLWMhG5xO
         vD425dlfHhjHwsCXIkm8WxRYKW0QEJMl+t8yzKcv3uC/y/Y/FWuV3TMBLO++MfrzHBYa
         HCSJjc58OgsIdStpmkDKA5hGTZl9r13b/hKi+yI5mM9SdRpRzqpWWnf4jSdslYkQ+dLq
         Nk8g==
X-Gm-Message-State: AOJu0YwX1BAhd0rAnXVv4idhto8xK8w3e0TL50Ibvd+PdS+5bUFQSTcf
	NdVUEEDA/XV5+M7mnvBCK36NeUd2qwUrHlQotqnLGqX6h2FDqeYh+hKAmZQz+8DMSg0DuLDXehh
	xAL6XhrstBMJ9rjVX1rQFfUyt71Q21Yo=
X-Gm-Gg: AR+sD12V1dehtgI9mNOdECQgEjEK9YHY5KlnEFOVx3Ys4vPNJra8yQwcb0oOJxLrPbA
	tdvbqoCZ6xPd/TngKOqgkWWmLEfUq0YP5SwTU3o07xMQEr/G8h0kPwPaz+FKEQ4lzN+e6SpbGFW
	wIUFR9CvYDvUpJH14tTnIlf+BUx0FS2MwiHcRBHMtVfnXEdR0PULpcOGYfVXOleKyL3IEDl02al
	LozUI3qeWVn+35jlhGJlXVouSDjMDmZTxSPJhQlBx3c/u9UMqeTmDCs2WwODY5ne2UPZtqtoC6X
	7ODx440y/6FJjxM9IY9cU1GPoh5gPS7DtyagPa7aBs7l
X-Received: by 2002:a05:6820:1895:b0:6a1:9a5c:b60d with SMTP id
 006d021491bc7-6ac96cd5c1dmr3840683eaf.65.1785342521164; Wed, 29 Jul 2026
 09:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729154323.14694-1-jwcart2@gmail.com>
In-Reply-To: <20260729154323.14694-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 12:28:29 -0400
X-Gm-Features: AUfX_mwDRxSdDAjGn42BfyfkDbP0hOvNt254yrVMO09kAep4swb3Bx4pGyzuCoc
Message-ID: <CAEjxPJ4H1z2EZWN2hp3E0ff7HMQZRvpgRfE8yNgFkdpeM4A2Bw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for invalid categories when expanding
 semantic levels
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:43=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The function mls_semantic_level_expand() is used before the policy
> has been validated. A maliciously crafted policy might have gaps in
> the categories, so a check must be done to verify that the categories
> referred to actually exist.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/expand.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8d7fe519..35f26c23 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1128,18 +1128,27 @@ int mls_semantic_level_expand(mls_semantic_level_=
t *sl, mls_level_t *l,
>                 return -1;
>         }
>         for (cat =3D sl->cat; cat; cat =3D cat->next) {
> -               if (!cat->low || cat->low > cat->high ||
> -                   cat->high > p->p_cats.nprim) {
> -                       ERR(h, "Category range is not valid %s.%s",
> -                           (cat->low && cat->low <=3D p->p_cats.nprim) ?
> -                                   p->p_cat_val_to_name[cat->low - 1] :
> -                                   "Invalid",
> -                           (cat->high && cat->high <=3D p->p_cats.nprim)=
 ?
> -                                   p->p_cat_val_to_name[cat->high - 1] :
> -                                   "Invalid");
> +               if (!cat->low || cat->low > p->p_cats.nprim ||
> +                   !p->p_cat_val_to_name[cat->low - 1]) {
> +                       ERR(h, "Low category is invalid");
> +                       return -1;
> +               }
> +               if (!cat->high || cat->high > p->p_cats.nprim ||
> +                   !p->p_cat_val_to_name[cat->high - 1]) {
> +                       ERR(h, "High category is invalid");
> +                       return -1;
> +               }
> +               if (cat->low > cat->high) {
> +                       ERR(h, "Category range \"%s.%s\" is not valid",
> +                           p->p_cat_val_to_name[cat->low - 1],
> +                           p->p_cat_val_to_name[cat->high - 1]);
>                         return -1;
>                 }
>                 for (i =3D cat->low - 1; i < cat->high; i++) {
> +                       if (!p->p_cat_val_to_name[i]) {
> +                               ERR(h, "Invalid category in range");
> +                               return -1;
> +                       }
>                         if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
>                                 ERR(h,
>                                     "Category %s can not be associated wi=
th "
> --
> 2.55.0
>
