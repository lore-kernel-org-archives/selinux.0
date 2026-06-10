Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56B3F7AAD
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100474; cv=pass; b=sQzQNqTwDKYpmUQQNNDlHIORqwRVIKyue9DE2wXe/0vA5wEsF+eMu5qKiBQG2kkjbfbguLIlUEaQVALTijiUCguqzD3aeNBaBoJXEyVnhpCg7FlPjpqg+TFgpqXQJHIhppfSwTwe4FRVdgW1ZlLlNI4BqLw5ZlQk49UKGLX5qH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100474; c=relaxed/simple;
	bh=UH4Iv8a6fYCprJnll/tmmtNn9kmFo6s0eAoo1BBKJOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ2RWUHcBJgz0+i6zzhBGe0mBeKTO/Ov1czegOw2BGoHAFbRYnc62q2uzV04hQptpf/z7Q1Hx8k2qA4ADN0zpBo2Y/qyoPlWE2uliLvnfsWt7UY1sqq9AaAIAMUMY3++KFS5+zGNRwKMnD6Uav8Yf1X0yEm7PuvIVZmsBVEalEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLbYQ8aW; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLbYQ8aW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842cd900ee0so1909363b3a.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781100472; cv=none;
        d=google.com; s=arc-20240605;
        b=DyahneS6w4bM9mEWxEoBmJY+D4rvYh48gmBOHnpdZ7fvqpEaxceiWnIizhRPg7doly
         qjfNTvY5scK4CntIdcFD8O4RYkP/sjIBHA0Okc3LD9V2vVy3P1gVzx9uTC+3Rzjh41ou
         Ye40wQxxgpZ6bUITZDw9gbcynZLhuyrFSK2i/npdP6QJ9Y/G1Syx4lsWRKh2aW0vWxiu
         2/zZa45mWmRLhQRDjAE21IEqF2p694w9Tcy9Y03C6Zkffod4P4/tCxMLtMaQ9YKevUIf
         dfPSWfhqTGNa8P8nvOckyFjtjleayIaG1ugKQWd59ISjP6du6EiKvCWqfMv1seD0S9rz
         8xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ir5+mPzU+Te3RGrldTrhsCz2KSEFzYefdHLeYYrg3VI=;
        fh=wY8gy0iOksnwzvOC7hqRV0Sf7JK9ec7jJ+1ccj8gvlo=;
        b=Xl3eUo6J4dhVZkyQBeKqy0n5UbD/zMZP9VC5Cbr2SY12nuopQb1lEoqcFwECPQ7oCB
         FjaS+XnJrcs5Oor3wC3pXm5Q4S0DWQx5VxzdGWtLE31rq8F04hfoqzJ9Ws1VPwEkETNS
         O1akESZCqP3gx1BpjFkEUvIspv9wk9HkRfZCkWX0VLhcXHfcoVsW8Mol53jJqY5l7weo
         dcScwOoSbNh/T6vaW9P8IyfuuG03smOy4EgGTYx7o1VRfWDg7MnCBrf3sou3baJcBvK6
         cFbhNzgvsp9+M3J63c+zrs2SlDrR3ez3W66H5YABpVIiddpomhoqAOGdoDkL8To51K88
         Yoyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781100472; x=1781705272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir5+mPzU+Te3RGrldTrhsCz2KSEFzYefdHLeYYrg3VI=;
        b=BLbYQ8aWNTDyD+3LDWvW8wt8wwogqacJYtvB2IVaC7UMK8cMkNrO+MgoZs4biSkMgC
         H8ARQvsBUX+Yf+neFoz/zfu87V8NgV7qGvXMnrAdhScioeBY2e1qaEGWwvuve0c0LHjD
         wG1eyJMoyqj5+WpgIJuuDkhLqIqw1wy+M7gKQRkuQe6IQeMvtRdVkyvmbj+/zjHnEkNc
         5oq86Y5/elrjKlde3K7L8xRnbJdc5Mh6WrZRmQSHiu7LX/4sTh9gxxi6dPqe0spKFcj7
         L2HQ17OPp50+Z5evvjviB6kHVROCKORBwDnN+4Xy8ahmsy1ORU6VXrawJPSGbjdpc/6i
         CIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100472; x=1781705272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ir5+mPzU+Te3RGrldTrhsCz2KSEFzYefdHLeYYrg3VI=;
        b=Hql8KsJvaiQTFzZE0PKa3KCp1KR/1d2gg7PQUbFurE7M3LBkSUAiJCPBLor7Ihjab2
         W/ltnQb0k4V7hxb8eIgmeD1CNBSaqhXi73EUKPMRGbBgQoiE+rVT7rcsmkwQNBL4sZSa
         qqiZ0KPDP1nGvfIaXfv88uGCCHQjxpd51dxiMSN3fTRqBzvqRrR7YQirc8D+Jx094rqd
         TgMtgtpu88s7FrZrlxdQTDMl94KGt0P7FqCbapPV5AxfjpOjCj5TdVaHO0AuejCuLnLi
         5EWKF5/UKnOhTES35Kgdqt/gIACialjTN2LOOcLW+1ONSVvNOTi0HmO8zFsN/dDJAITk
         1C7w==
X-Gm-Message-State: AOJu0YxvLdspa77z9cSWJmTnE7HTtDT+YZTn2MluRiqytkTwSU0UoloL
	hqgfV5bE3vT08u2lipnIg0LEg9ycHIfpk/fLQMwVSDrJFZDR+jo4HxY2sCB4ahPLqbOyFnQmZHd
	3XfmwAqJ1hAqfd6l7KSZAEiCuOY120QRjfQ==
X-Gm-Gg: Acq92OFFBJ2KBePHUBl1AYVIP2KmYgGDm7ZC20/fyHODNMUOcfbmGCzBSAIU/+qlM5/
	2TxMC673iLMhN4QSfb2W//yChFxPGPKRP2aVf5V+yVSI7ro4rA+I4eU8FYUPjeTasJf9xlAa7sc
	Hew3znnKQYCOBULBIQ7z05z/IKI+X/5oCDVCukdGDmm+eZl1L9y2k17ZATu3kjlIrVXowVvzz4j
	5t17INv9sHth6xmCGhZ/yPbGdUo4Bq70jxh1d84yWsEC9Nu1gjzDzSKvSfc3tgvcg3dozZDNjtt
	ksaCE5IdaJJJJkoFow==
X-Received: by 2002:a05:6a00:4009:b0:842:7838:61c3 with SMTP id
 d2e1a72fcca58-8430a711a92mr8848522b3a.22.1781100472175; Wed, 10 Jun 2026
 07:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610133109.6726-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260610133109.6726-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Jun 2026 10:07:40 -0400
X-Gm-Features: AVVi8CfLyrAGEBaqjTYB1fX9CcrAQm4qZ6_m2nRkOozDkE-_6I19Lkj5T2eceVw
Message-ID: <CAEjxPJ6iTh2Qnic=Bjs=-mbnM1Y91tS0pxPNd4n8q3sYqikijg@mail.gmail.com>
Subject: Re: [PATCH v2] define matchpathcon_filespec_add/add64
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:31=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Pepper Gray <hello@peppergray.xyz>
>
> matchpathcon_filespec_add and matchpathcon_filespec_add64 are
> exported in libselinux.map, so both need to be linker-visible
> symbols
>
> fix: #512
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>
> ---
>  libselinux/include/selinux/selinux.h |  6 ++----
>  libselinux/src/matchpathcon.c        | 16 ++++++----------
>  2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index de56b727..105b47a0 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -508,11 +508,9 @@ extern int matchpathcon_index(const char *path, mode=
_t mode, char **con);
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && \
> -       defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> -#define matchpathcon_filespec_add matchpathcon_filespec_add64
> -#endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
> +extern int matchpathcon_filespec_add64(ino_t ino, int specind,
> +                                      const char *file);

This still seems wrong to me, sorry. Shouldn't the _add64 interface
always use ino64_t or uint64_t or similar?
Otherwise, why does it exist?

>
>  /* Destroy any inode associations that have been added, e.g. to restart
>     for a new filesystem. */
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 2623e5dc..f2c7e561 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -280,25 +280,21 @@ oom:
>         return -1;
>  }
>
> +int matchpathcon_filespec_add64(unsigned long ino, int specind,
> +                               const char *file)
> +{
> +       return matchpathcon_filespec_add(ino, specind, file);
> +}
> +
>  #if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && \
>         defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> -/* alias defined in the public header but we undefine it here */
> -#undef matchpathcon_filespec_add
>
>  /* ABI backwards-compatible shim for non-LFS 32-bit systems */
> -
>  static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size =
mismatch");
>  static_assert(sizeof(unsigned long) =3D=3D sizeof(uint32_t), "inode size=
 mismatch");
>  static_assert(sizeof(ino_t) =3D=3D sizeof(ino64_t), "inode size mismatch=
");
>  static_assert(sizeof(ino64_t) =3D=3D sizeof(uint64_t), "inode size misma=
tch");
>
> -extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> -                                    const char *file);
> -
> -int matchpathcon_filespec_add(unsigned long ino, int specind, const char=
 *file)
> -{
> -       return matchpathcon_filespec_add64(ino, specind, file);
> -}
>  #elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || \
>         defined(__INO_T_MATCHES_INO64_T)
>
> --
> 2.54.0
>
