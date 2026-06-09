Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B135DA65
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016209; cv=pass; b=HYgwoK7Lp1pT8Tps353J5VWme4ONPcIH9N78UxVnzTSIU5zl5RX4eQS7+tHmZDw3qCKKyr6aUPU3fG2MUiw3vnnAZYlI8dlw5jAkIpMLAZTZu34Ic69LJibmInWuUTW8DRU66MR2wO6CnxZSYjJ4YzDLu9WFzbP0MklO0vte3gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016209; c=relaxed/simple;
	bh=/YsUJPOC8dZOXkQAwYD4FBWT+qzG4pjHJvuibNhxFq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLDAzArSmlZPxjruLEiX+MYkJTxSJeC0ea2IUuYSWR+zR9A2gzSxBpn5QbCPeEQ3FuXbO6DUp29C2+cognteXE/zT0SHmYJ9L8S/hFliSfXaFD3VBlNctmYdd+8xJJnxScUNF41Kw8NoonWPhxmjzgvWwGLM2LApwr6VSPlpzYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Hei1Kp; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Hei1Kp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84230ab8857so2508547b3a.1
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 07:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016207; cv=none;
        d=google.com; s=arc-20240605;
        b=E7yCJepZw+DXXJt2b873gRTnUFhzJEpaqHNk4HtElsATnkj5glwj7Eg9ffDno/hZBx
         Qy49Vkn683AaPyw7mOGfKT0Z4KrAE3Ky74g16/IhbgZ+exZxsZQRtlFeHOhm9cSNvGMV
         2S74boDYKTBFy4KxbL0jAmSRdiJ3hwoMh36aPAw87ETdegcOZSoIXI+at2jQoq+J1XCO
         a8A+KPeunHJeJpmT7fYBP+Jy41PcJRDoBnvke2dmBsUKNP/tQ5qkKvdFi4xWUWl9DbQL
         Id2a1wmc8aGSilD17DrfSHKHJifDaaej67g3nhN/DSlh1RGexrNsZx15ItA46cwwi55y
         80zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X11EnhBlUN8Nlp3IohgQPHkRJmmHNiPOeDtG4Tfh8Dk=;
        fh=qLn5FPXLTak1S/P+p5ozWvgBCyGwYUBkqNxUKV7UUks=;
        b=VEfFLaSxA7ElSJUjEYIFEeXP9us1ZXd6TAXAmpt4LRyr6SUNpwqxSraOTCopq/s9LE
         z5B8wIONV28JCYq/t1M7Xg46vo8hRHtW/+9hrIZiKTmH54RnAgZiotCwh6ME+5DLbqL5
         KSUBR8CqLQt0ofANUwG+booBBVnC1AGIzBUwfIkHkYU29SkF8yL1+Qf3Vhl2mSE2e8Sf
         tdSKv1SBOoGRH+TJYFxdE1zLPZjMGN6gCbESfUa3Go9V9lQ4Q2qWGJmCZwRgF7V6EGR9
         GUNws4kj/3O68OEMdhV9Sd9ECmAudzie2aGkxJsq71wAeq/K/j3HHo4T2hd5Cg54kEwc
         glaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016207; x=1781621007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X11EnhBlUN8Nlp3IohgQPHkRJmmHNiPOeDtG4Tfh8Dk=;
        b=U8Hei1Kp7uzCjFAqMs9IARilORo6wiJJi6CAsN5jwW07jnlKoWrmroA+nh9aF/B8GZ
         aVe1I/eSvf0GN7OsxMvtXC7SU4At7SmdpoXVUmxaPFuw6gTIlIlVcL2azGNLoJpSHRPr
         QfoGtuXaBxUHq5wLwELgj92KBnwdeukif9JisU4edOQqSYzHeiZvW5FePKAJl/BvsGIX
         hwl4MOd3MckHXK536nmomeb3loQ1Z8cRl12c8ijuY8tXH9KIyt1kOxFs6r1aFZ/dnlcL
         uZ9GUUfY/Ep3ykwxkgNwScNQbL2ljMiWmMGEnbeEOx/rpbBns0SB29Q2tkn1o1b3LXca
         LBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016207; x=1781621007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X11EnhBlUN8Nlp3IohgQPHkRJmmHNiPOeDtG4Tfh8Dk=;
        b=DqFVEF4AYYEIv1I3iDh1S958stcaa+0HylOKH3ZTUSM8taGQn5kNIgKVT296JxOM7U
         plX5iVbpwTGe8y6N7k+aPLG7qbA3eots9H9j9gOf01GUx6OsVQ0dTc8w4d8pH1aCXtbj
         qZAmrfGOSyCpb6QXa34TTt2diP3ViXpUrCoAjcRcbnh+J5dNroKZ917GBSauItA/N65S
         KBSZH9xDlk+VreHaAjp/GW2DWWWBX3C3A0cbMWVDAi0BUAlij7quYDRRSHaY4i/yZL8C
         iz/Wq2pfTTZ7qm2yKHLoelx2FxE1kDh4z584Zs2kQEeYkF1vh/SysZbdBureeC756sSa
         z+bw==
X-Gm-Message-State: AOJu0YzDS7Tp04KmUBixZFIC0p5WgbfOVvTqZEXB2rjuho3AyCQKitya
	gbbqvPECJ2eJY+6ZNVHobNeFQ6SAisso3YHuHKc999vR9++pRbWe8TgKIfly+1dNVBnWFPwiqpZ
	ntLox4g1gjopRc7vHMEQSUhtNewRdLQw=
X-Gm-Gg: Acq92OEvBAE4K/X93n3CQ4Yy3AbZW0XvPqTd92leiB8ImsJCGC4DCe3r7v/Qvwu4OCp
	D63ee/nYIK5qAa47wVjP1J+mUXRTLSDNPbcz1q5oYczi+Ou6ej9rQFEi+uZn0TIEmZloCbPdvGP
	Qg6VMEMudvwbB+oqr9k9LEi51q+rfo/C+d/FBASsarf/2cBH7wqAuw8kesKC0Rs+udJkZ0tNlyE
	APO18gMF7dkeJqhPW/8SrZnCWp9diYewfDU/ngcHD5pRV0PrMNzPY+DhDvmqbQXRcL0xXzPeufM
	Ia14F1MiyKZZTcqagQ==
X-Received: by 2002:a05:6a00:1989:b0:842:4b4c:8a85 with SMTP id
 d2e1a72fcca58-842b1006bd2mr21535269b3a.45.1781016207300; Tue, 09 Jun 2026
 07:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
In-Reply-To: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Jun 2026 10:43:15 -0400
X-Gm-Features: AVVi8Cd3d7H2BWtl155ka3rSv1JYm9vtypHkeguaJXWcEvL5RdW-n__GzefXlbA
Message-ID: <CAEjxPJ7f6Qb3Yg9Yx3Yuog5jwsg0bD2OEidDnR0U1o9HOj7QCA@mail.gmail.com>
Subject: Re: [PATCH] define matchpathcon_filespec_add/add64
To: Pepper Gray <hello@peppergray.xyz>, Petr Lautrbach <lautrbach@redhat.com>, 
	James Carter <jwcart2@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, nabijaczleweli@nabijaczleweli.xyz, 
	steve.langasek@canonical.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 5:53=E2=80=AFAM Pepper Gray <hello@peppergray.xyz> w=
rote:
>
> From ce907fb1daa4d165b29f2d91b3d0958e2eb7f044 Mon Sep 17 00:00:00 2001
> From: Pepper Gray <hello@peppergray.xyz>
> Date: Sat, 11 Apr 2026 15:55:17 +0200
> Subject: [PATCH] define matchpathcon_filespec_add/add64
>
> matchpathcon_filespec_add and matchpathcon_filespec_add64 are
> exported in libselinux.map, so both need to be linker-visible
> symbols
>
> fix: #512
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>

I've added several people who have touched these definitions/code
recently in hopes of getting more insight.
Setting aside the whitespace damage in your patch, I am not clear if
this is the right fix.
commit 9395cc03226a0e1a ("Always build for LFS mode on 32-bit archs.")
introduced matchpathcon_filespec_add64() and the #define to
transparently remap API (but not ABI) calls from
matchpathcon_filespec_add().
Would appreciate clarification from the originator of that commit on
how/if this change would affect the intent there.

> ---
>  libselinux/include/selinux/selinux.h |  4 +---
>  libselinux/src/matchpathcon.c        | 17 ++++++-----------
>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h
> b/libselinux/include/selinux/selinux.h
> index b1431e5d0d..241bb54a94 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -537,10 +537,8 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 &&
> defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> -#define matchpathcon_filespec_add matchpathcon_filespec_add64
> -#endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
> +extern int matchpathcon_filespec_add64(ino_t ino, int specind, const
> char *file);
>
>  /* Destroy any inode associations that have been added, e.g. to restart
>     for a new filesystem. */
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 240c9fa76d..df4cabf597 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -261,25 +261,20 @@ int matchpathcon_filespec_add(ino_t ino, int
> specind, const char *file)
>   return -1;
>  }
>
> +int matchpathcon_filespec_add64(unsigned long ino, int specind,
> +                              const char *file)
> +{
> + return matchpathcon_filespec_add(ino, specind, file);
> +}
> +
>  #if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) &&
> defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> -/* alias defined in the public header but we undefine it here */
> -#undef matchpathcon_filespec_add
>
>  /* ABI backwards-compatible shim for non-LFS 32-bit systems */
> -
>  static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size =
mismatch");
>  static_assert(sizeof(unsigned long) =3D=3D sizeof(uint32_t), "inode size
> mismatch");
>  static_assert(sizeof(ino_t) =3D=3D sizeof(ino64_t), "inode size mismatch=
");
>  static_assert(sizeof(ino64_t) =3D=3D sizeof(uint64_t), "inode size misma=
tch");
>
> -extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> -                                     const char *file);
> -
> -int matchpathcon_filespec_add(unsigned long ino, int specind,
> -                              const char *file)
> -{
> - return matchpathcon_filespec_add64(ino, specind, file);
> -}
>  #elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) ||
> defined(__INO_T_MATCHES_INO64_T)
>
>  static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size mismatc=
h");
>
