Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3F78F44
	for <selinux@vger.kernel.org>; Tue, 29 Apr 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940088; cv=none; b=WErUWqXve1aeCnpAsANb9Z8cj8zPz8dHdCqmsaqsc5TSUbz+pDGOdJysK8zU1As2Stfum3AVruy3ITvU0O+0s7sIhYCqpP+g4IU5nmzgq+RBDpRZapjHupvS7iKa5ev3te99HvHWGoDXl3CB9qnWkadF81EIMTFF3kfVM+bXH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940088; c=relaxed/simple;
	bh=hl7E1zpGJofMOJq+EkijY4hMX8LKsFgIpYXA+CdeB2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLp6dlvfA34JfLufkIeqhpMrUTVbXUT7Zd16rTCyEyjmDjxNGW9IFxBkEUM1SVdv0VTWLo+yJOCAHbCIgpSQessikFigGu17qX7D6AZpqpZQMhz4itURXfShwr06KXangCefh5HECC+7N33/gsnn1WDDi3jQCMM63yPqhXFcDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaGu0LMN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaGu0LMN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476ae781d21so72719591cf.3
        for <selinux@vger.kernel.org>; Tue, 29 Apr 2025 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745940085; x=1746544885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4XtKb3nM9N6PHT99uTWr5KczV13omJG4rj+oMKL9dk=;
        b=BaGu0LMNljOrRe2iww+oaaL50QMKb03HNhv+WCjFD0v3N6pLxL06rEferhG50i9erC
         3LApAxrLRzmLQGpJpev7yur5Dqx1HWFDKJxGP2lSI8McNfit8xX08JqtnqoPzRQ0RMTN
         FGl/ZEf9pMm7h8yw48AXsXI25n5Gap/Dn6A3q6tjks97mM7Lf88S5v/2o/BQc0sTXXYR
         Prr5UE8TbIPi1WJcALMGXAWWmY+CqswIYczmFdAt0YAUvcKyfULV5VWZA7cahEPYBUfE
         xHvVyzXVvigChEF11qSOd6rE42Lv/y/FobgZT0DaY9mm/vLE8zqhR0Na44sVpNxiDGyn
         cT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940085; x=1746544885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4XtKb3nM9N6PHT99uTWr5KczV13omJG4rj+oMKL9dk=;
        b=RfXdSR20nIbFZ1idTe4XiP6i0xbVXOwtwdYppVlZtH5YSQ1xE6PDAD5q29wd5p49np
         XJBVHRtZSYLA6xe932OjwgNd8LeVvOEdot8URBphd+G6I9lTZVIMn40Pq1ODrcM7q/Vn
         j07T+sbsTyXY7w2W195ULmzd9d3qgXCuQnCURKpqK0zzN2xIn71JtGBtxZ67b0+NNIEo
         l3eLzzKNEymbQaoqH+/T/L0lA6SDpnPD55UL52LnNXJGR4cVvVPoVdzAS1PlxVqh0zDq
         Xom0mu0XSA8EzNQjliXmJ9XvwfpHbKjFx/Dhacf+QL2Gl2XTeLw6NumflSJnZtoccJ8k
         m85g==
X-Gm-Message-State: AOJu0YyLVyMWAfWUR0GYOlUnLVTvnL55gd1XsYgixMLG+mevT8uXROmj
	sB/rj7WIWHib/HUGw7UkObm0QIcnUuF0+BS/0scjbipSgJgo1uAC7T46C+C8H9nlCej7H9sVmiL
	y9Q7nTVss1LQ+HMukKhjgx466nQwj6GSX
X-Gm-Gg: ASbGncsHr4FM81meEYDiCvM7zd7CDx93Ho4udsQMP5Yv30fsVNpiD3AXQ5H5xb/USrw
	Vvdwg9+2iIFlYAceu44785bBpwDDvklu3PTBKH3gGhmXMD0LN3+sbkBG3xzerwaAWiMTvZOJwuf
	7yp9Q0+9FrObnCGYB59RQ=
X-Google-Smtp-Source: AGHT+IESJtNs1tBfTOFZlghN/v+YLKLHsXN+WwupI51G74vq5YQwC4bZdGX8EvbjFGyopolGC6DohVOjINBuaQbJ65M=
X-Received: by 2002:a05:620a:1aa4:b0:7c5:7a1f:4d89 with SMTP id
 af79cd13be357-7c9668d5f7fmr2511770185a.54.1745940084538; Tue, 29 Apr 2025
 08:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426151356.7116-2-hi@alyssa.is>
In-Reply-To: <20250426151356.7116-2-hi@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 29 Apr 2025 11:21:12 -0400
X-Gm-Features: ATxdqUErSbsbp-pcXwnAc76lhFuD79x5TA3auQmJ1srL0NlTIBZOSRnVldIkMHg
Message-ID: <CAP+JOzQBaGv=74tNgczpjZVGpzZo93kxnHXO0isL+TzmOc4byg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: be careful with non-portable LFS macro
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Alba Mendez <me@alba.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 11:15=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> musl does not provide the obsolete LFS64 APIs (like ino64_t) =E2=80=94 in=
o_t
> has always been 64-bit on all platforms there.  That means there's
> also no __INO_T_MATCHES_INO64_T macro, meaning the check would pass
> and reach the static asserts for the shim, which would fail due to
> there being no ino64_t to check the size of.  Fix this by only
> assuming the absense of __INO_T_MATCHES_INO64_t is meaningful when
> another non-portable Glibc macro, __INO64_T_TYPE, is defined.  If both
> are missing, that probably just means there is no ino64_t.
>
> Fixes: 5c3fcbd9 ("Inject matchpathcon_filespec_add64() if !defined(__INO_=
T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as proxy")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: Made the same change to the condition in the header, as suggested
>     in a GitHub comment.  The omission didn't seem to break anything,
>     but it makes sense to change it there too.
>     https://github.com/NixOS/nixpkgs/pull/391728#issuecomment-2832282846
>
>  libselinux/include/selinux/selinux.h | 2 +-
>  libselinux/src/matchpathcon.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index f64896b7..b1431e5d 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !define=
d(__INO_T_MATCHES_INO64_T)
> +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && defined=
(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
>  #define matchpathcon_filespec_add matchpathcon_filespec_add64
>  #endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index a4f65045..240c9fa7 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind,=
 const char *file)
>         return -1;
>  }
>
> -#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && !defi=
ned(__INO_T_MATCHES_INO64_T)
> +#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && defin=
ed(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
>  /* alias defined in the public header but we undefine it here */
>  #undef matchpathcon_filespec_add
>
>
> base-commit: 2647cc0fdca326b81ee3c08718cbe19b7866b53a
> --
> 2.47.2
>
