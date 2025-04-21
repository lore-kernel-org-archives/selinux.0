Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8D1E7660
	for <selinux@vger.kernel.org>; Mon, 21 Apr 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745264340; cv=none; b=mop4ywIon5xkxOc8W/lWdxqRKOCode5dyiOYHHn4L5CGme/cJB9WCfKiA4TYsQx0TjQ471sfSAVIMZivDGiRy74QkZjkrrU9ij03kIu/X6u5o2Z/HUUC9rzzvUCDEHoINPpxUhHhxdxIsKlLjsWCx9MObOSmHyT1dMz2vIRH84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745264340; c=relaxed/simple;
	bh=hHANdwYAd1WrOUX0UX8ii/gmZG/1ncSQjlMNBRj3qag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0Lz3CieDJAsyI3blzK8UOXfyXjf3cecftnqWUs2bS9O2N9YzoGoLRX5hdooFF6vqLfaxvkuq5PCuy7zpdGq4pSU9e+ORBrqaRm2zUnKJnJ5e9ua+A98Gbo0kw0NIwcc+w/AJ1me8iMZKAEaxB7Ph2AnWIJhRkZLjHLPdksyRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj7+p8cN; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj7+p8cN"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so1455269241.1
        for <selinux@vger.kernel.org>; Mon, 21 Apr 2025 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745264337; x=1745869137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/wtKPALI59HlhcQ+2GgFXPHlO5BlvL8Ie8t42MqvzU=;
        b=cj7+p8cNF811mmEQqMJsU/eYuhTu4GIHkj9T4B26/cLYShjDJJxuL33pWMs79wh925
         EKXWYsdUfGdqrrvVRBb39KNm21akoEoW1SprzrSwvNzAEPekgLjQ/5v6kLpUQCnTHscs
         L+SRFGMrS9dIvhJVlu27L4eiMKaTqHzRtqUGtkhBTdqc7Rz8xjgDDOMDrjhpJUyhVIlT
         sEgL4k+2DlyENn+wMsvybpLjmT8eHUY4h9/eQE00mAlt0b1wjL2d7mtqeu3wUO3pDFAo
         01yQnxir0gqvxzwLRcMZHQfAAVbQlXPqfx5LbTyw9csCMkjC8YX0pokOORK8zJGceBQu
         co+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745264337; x=1745869137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/wtKPALI59HlhcQ+2GgFXPHlO5BlvL8Ie8t42MqvzU=;
        b=n8cUjChooZ14tPbGU8b6Aku8IhpeId5/Al+eRb3GGhg6wV0cQPnl0UbP8OgnjI3mqO
         QPkOMEunLVr+JfoviLcOGZIyuJxi6Qou2N8U90LttynzwnLX1g3IJr8JRVX1LtACJsmF
         AFD7AVeR7kZ5dVJYEOQdwTFbmik54jw8+99xK33ujKl3ODBxL/SqwM9GyYoM2ZLu15Uo
         QB2i04xA9CnAMsgfU35x7APTlLaKbrbdNQqBAsG4W3Rn3uKPiIPTmjtNUeCwXYUh90Ix
         YPtfzkS9L4ekWxDf8q9Kj77yWxjIzp2RupWfWQ4A+PggNQSrIPYEG8LWcR3nn4KhV2TU
         0zcA==
X-Gm-Message-State: AOJu0YwR6uS+f0G2QEfYmUludaZcNTgouPzOh3Uw2aI+TpJZIR1yx8g1
	KhSCmUwkr10LiJ0PZICjr39tNuo4Wa1eY/9N3CZsLxuBQozzq26YzLqDpBf+SEAZlTxlRwOAyur
	/EkPmJ5JZO/dKrC78Iywmq2f/syKZqntW
X-Gm-Gg: ASbGncuMd3R3oXB0fBmWRPcRShnDNrS7XfFqzUbtVK9xxXtBIFu+bl2H3lTLcct0x5A
	cRUhIpsnDBiwCPs7bHeCjgBWfVXkNgccSAdu3GrXiZ3DM3a6/MIAJpCXKkbO44fQr/umh6nyhB3
	arqE98qfu3FerQ2/I5Iio=
X-Google-Smtp-Source: AGHT+IEIxiWCG24KvI0eXZ2ZLSBh3crtHgVRArPOzyhcU7EKbcNH+jUEU7FIjps3HMO9fGBW3H6yyLw8VE9bUzn1K+Q=
X-Received: by 2002:a05:6102:53c4:b0:4b6:d108:cac1 with SMTP id
 ada2fe7eead31-4cb801222aamr7293692137.9.1745264336887; Mon, 21 Apr 2025
 12:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cpbjftpok3lt54s6t7qmhzwbhl47vsz3efrxs45t5os7ztp3zg@tarta.nabijaczleweli.xyz>
 <jxjamggy4xaie53uyfuvriryqj4mtdc7gqr4gmjveyhwoukrxm@tarta.nabijaczleweli.xyz>
In-Reply-To: <jxjamggy4xaie53uyfuvriryqj4mtdc7gqr4gmjveyhwoukrxm@tarta.nabijaczleweli.xyz>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 21 Apr 2025 15:38:45 -0400
X-Gm-Features: ATxdqUGm_43v8YDGKhjtKRkwKX7W-MPQ9VFNGjzDX6BIGiR8Zinbfbnflug_HK8
Message-ID: <CAP+JOzRK1h5haxZCXY5b5X771jyeeM504-m89aPFN2zRCzHkyg@mail.gmail.com>
Subject: Re: [PATCH v3] Inject matchpathcon_filespec_add64() if
 !defined(__INO_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as proxy
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org, Alba Mendez <me@alba.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:56=E2=80=AFAM =D0=BD=D0=B0=D0=B1 <nabijaczleweli=
@nabijaczleweli.xyz> wrote:
>
> The __INO_T_MATCHES_INO64_T is defined
> if ino_t would be the same size as ino64_t
> if -D_FILE_OFFSET_BITS=3D64 were not defined.
>
> This is /exactly/ what
>   /* ABI backwards-compatible shim for non-LFS 32-bit systems */
>   #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS=
_PER_LONG < 64
> is trying to get at, but currently fails because x32/RV32 are "LFS"
> with 32-bit longs and 64-bit time_ts natively.
>
> Thus, the
>   static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size=
 mismatch");
> assertion fails (__ino_t is the "kernel ino_t" type,
> which generally corresponds to the kernel's ulong, which is u64 on x32).
>
> glibc headers allow us to check the condition we care about directly.
>
> Fixes: commit 9395cc0322 ("Always build for LFS mode on 32-bit archs.")
> Closes: #463
> Closes: Debian#1098481
> Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
> Cc: Alba Mendez <me@alba.sh>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Changes from v2: fix build with USE_LFS=3Dn on non-LFS ILP32 systems (i38=
6)
>
>  libselinux/include/selinux/selinux.h | 2 +-
>  libselinux/src/matchpathcon.c        | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index f3cf5a20..f64896b7 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_=
PER_LONG < 64
> +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !define=
d(__INO_T_MATCHES_INO64_T)
>  #define matchpathcon_filespec_add matchpathcon_filespec_add64
>  #endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 51f0e4ff..a4f65045 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind,=
 const char *file)
>         return -1;
>  }
>
> -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_=
PER_LONG < 64
> +#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && !defi=
ned(__INO_T_MATCHES_INO64_T)
>  /* alias defined in the public header but we undefine it here */
>  #undef matchpathcon_filespec_add
>
> @@ -280,9 +280,13 @@ int matchpathcon_filespec_add(unsigned long ino, int=
 specind,
>  {
>         return matchpathcon_filespec_add64(ino, specind, file);
>  }
> +#elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || def=
ined(__INO_T_MATCHES_INO64_T)
> +
> +static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size mismatc=
h");
> +
>  #else
>
> -static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size mi=
smatch");
> +static_assert(sizeof(uint32_t) =3D=3D sizeof(ino_t), "inode size mismatc=
h");
>
>  #endif
>
> --
> 2.42.0
