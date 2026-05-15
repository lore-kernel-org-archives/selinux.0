Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7319A288
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875379; cv=pass; b=BkyVtgdyauXNhTf4Dyv3zoYjah3CZBthIkm+xclwx01l4HvbhVDvksnLKLqyfgFRhJUdV5x19w8N4XtPN7s2fX1sKE3rEwUur4MwVcmPz/hJ8V1RCWQ4gs3C6IOegnHe+dSF+P4Pyew7Th8D3Cg8/rGHHda0aII4TSKZ/5zgefM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875379; c=relaxed/simple;
	bh=REwLgVw5IlPiZoqBG6YysTS+F6JS3DuzVi9RXF6MlRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3j5MeevXLW5e0CtF4eSD8j5YDmabTM1AbNE+re/VI38nAgyaajCe9dUeF39pkq1xRY7YBuePg1jtcsYD9NWhMPWXNd0MvN7WGcKmsyw/PvHU44OXxL4/Nq/nlEFL3UfpqN5L/kDWMj+r4W8lvl4bxKrCklwQPN9hoDXQrUMHcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ0p7yHT; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0p7yHT"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so247649e87.3
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 13:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778875376; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1kt9QTo4KS19pPkH85jwdyiG19w1STIfeulMQs3nwIEhUdroH+WWqVzyPgzGK3xx5
         QJj0kL07ybjBWt7wMiNL4ms/ZNWJgO/Hj6w30/GBBKV/qA8Hgx0dFkvAghQ1aCStSVYw
         49d0L0uZZSJTU7e3YsUh+4LG1EjugfeiO+lX9qb12Q6aDxFk2GD7lLH30pscYJCa6nJ0
         2qIEA6ais7UsBVHVmgSiZ5YZFAkuAEoJZrKN6G6latZsUedvCkpQ+hSngr50ocrSe7px
         lkNisVBpfGW9BXflWG7en/sGAKdz5VG2ug63y7+EDksAJMWIl/yW1jsZkmM9V82I22GD
         7V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zDjKJRaEWjKu3M0DWLY0mwc6wkblow8mUoy00tGyQE=;
        fh=xAsnehjcEFsFxuJ06JOKwj1JA37MI1HiKFpjHvBpcMI=;
        b=exHzKFRS4x2oG2tBmWWNKEoWXrNtpfqIeCKLxArjxDDgCmF5joXa4b1jlm6GJ6Qpuk
         u5QvqwF5d0/M9BKh4vTNhNlr0jkmymV4KGx2TFiL1/10W5xwgmS/uhfNxVbo/QC/fKah
         R+3qOsoOkwz4/Ndqx7Ci5JyMZpsGpedkGN5VloMRX3HNZEsd4o3m13WxtRPaC6TIpnpo
         swekjtCseXr+EYP6ejKBk0cDJE+Zlo1CWqVgIxHt2tLvDiVGGzapq9WbJnMRNaP0+ULp
         kw99jMZ9Vwf5kjPdaXac6Ei7rby7cZhsyEFuIdBNXNWQZIJNU8a9BJKrNkRJay8W1oKw
         a0+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875376; x=1779480176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zDjKJRaEWjKu3M0DWLY0mwc6wkblow8mUoy00tGyQE=;
        b=IQ0p7yHT8MmFfnU6PhDEJ4CaHplZ7Y5t3dE2PIAzH0666TagI8znbWDEiIXHhVZRs+
         5lc1O1hoqr2TM0AV2//Qx4BP3r9EI7PX9Nn2Q5/3LRl8Ze4l6zQ6bz84OzN/g0JS6qqS
         cxzpVYlzzmFC1B+de5+Tp0qs1JkLsVdGXAjTmGqPZfAJEqwt4vmT7Au0adymO0fCazsk
         YlplAdVb6PG3HMzShx8RsZrf6wFSB3QR7CqSUR9pIKNza9zQrS4uUkfiQ6GCvYXegyXf
         4BNfR/1BmuugZrQuzZtZA2Jdn2uDA0YY9U0P4rC0jwqwuFFbva8cwCkC3UTFGpJ3WiAW
         FRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875376; x=1779480176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zDjKJRaEWjKu3M0DWLY0mwc6wkblow8mUoy00tGyQE=;
        b=Wyfk9thFwvlWMeSNfbIcBrDT+2nOzc2voK7ePAlZkJRaa0TJtEd7hycBR1OnmfxNtK
         x+8GBoBfFOTlvNCpK+hYdw+fm7eJnNUiOoMnhOjBG1iz1p+jA/5KCx6ikWZV3ekXVeI7
         OP2Cpb9in86bfPH4phGARrJHQvWxAp+oOMYPY918amWlFmtdAxxudAcAEAwZZMpU9/Rc
         8NT/qh/oyziD72cVmq8D12MDNuD444Txn+7m0kj4SMn8iud2RAfz1rFRkh1ZFeON0XGT
         AugjY07u++nWtklZiv4RGW4+d7KH786CZipIxd80nLdXA/E0uj1a0SgBE2penA6fznhP
         zRrw==
X-Gm-Message-State: AOJu0YxPxhSj/Z9pHavsJV4pASoKqW6iG9aUsZo2NimxvlvRsKkHxjh7
	uFXHHGM9CXyRN1uWkI6PklhMoc7ggmPOnymCXWURt+oryzSiyMl6bMO7aTlz++b1iYSki3RskhZ
	hn+meXwhInYapGl7dW5ShMz46N6F5q6DIcg==
X-Gm-Gg: Acq92OFkxmH2CB+uRCWc0ZA6noAWVCeyddj7qrpkCg1j3dskZarZ57N2c8gRpwvlqiw
	Qzho7S39LTPAvoQVZmuGW8NfhT9O/VJb37DAZ2OXMKDLp7pTGmmv54KrJhPxws0i12BLmKJpWso
	XL0E/+cL5UzBSJZQtUViIUntMZnUT8wCHYowuIMa4Uwf3n5pq+5mkKcpZIvWNGE4WhKzFcURFIF
	VFpGwbqNXvPRZkMdHnhgfWefI0MwR9QDFlj7k746scmAj/EIH41OaSOzVQaVzbi9sYHrA5WhVc9
	+OW3
X-Received: by 2002:a05:6512:220f:b0:5a8:a201:f27f with SMTP id
 2adb3069b0e04-5aa0e749bd7mr1470197e87.34.1778875375648; Fri, 15 May 2026
 13:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
In-Reply-To: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 May 2026 16:02:44 -0400
X-Gm-Features: AVHnY4IaZToarFSoroUclgZVSHSDxF5FpZXeEX1ThZl3dhITt6oRbfOjiPngBRs
Message-ID: <CAP+JOzRSBYSjUQBjv8+Nt6KrJG-H=g3azyVD9dnT1GOEQyxAdA@mail.gmail.com>
Subject: Re: [PATCH] define matchpathcon_filespec_add/add64
To: Pepper Gray <hello@peppergray.xyz>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gremlins seem to have mangled all four of your patches on the way to the li=
st.

Most of it seems to be long lines being wrapped, but there seem to be
some other issues with some of them as well.

Sorry,
Jim


On Thu, May 7, 2026 at 5:57=E2=80=AFAM Pepper Gray <hello@peppergray.xyz> w=
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
