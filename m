Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5C1A00E6
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351683; cv=none; b=U1sTmeoV7EOBYwcW6WQHhkrzt8iL/wGbPk/N2qTjGBsPR7NUNYrODNDusLFCWh76GewAywSEktk6Y7rKiZAfqxV4IDHrSBn022IpB17jl5WuOiuh44R4XtPB2FA4Ujzh1JT98hbyFCQu0ipkNb5ytHCOnv0TlZdFhR7XExuGdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351683; c=relaxed/simple;
	bh=8WoUxtfCF8v8WyBryPBcDhfZHdeQpOCMwITGsu+G13w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZDNeVI7IgOXipKbZHesSENRen/3kuPPE+XVlygpS3ZOI3I29CzGpKT9K3MMlN5fAo6rpgI24dQwMPiMIEcx+AIqJotLDuGdrrJ7ZkJjQOoZ3tflbFY0ZU0BC7mQYMg9IwBZys/Mxcl7LwSk6ubUBzBi8O6dF1vrKjjM+/W4wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR11y75h; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR11y75h"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7515437ff16so3550848a12.2
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722351680; x=1722956480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsxV3fut1xBl+ezrbLKSsc3vM1a/P+ooBO2TjvFZ9zY=;
        b=iR11y75hoMCx3Dqj5xwr3XAzXpfuEtmSV4h0Seee4raxf54ZE3BM47OwaGLO0Feab6
         Tk5xdOwozSyKLsvjGvsAyAhPmhJlJOLMXZ0DvxJ/6Zm04Bhk15hunZ1tbOTA4qn90WXM
         rspbBpH7cisT3Ia0o3jZ7a2gnnl+flHHfGhcCvxN0Ym2SUxoCuUZqRnfjB4DYw+5PuyC
         yCumgu5bNi0/7G1nOjI8cs58IHyaGxiODjhs8YILG8CUitwc42xP2Gj1hyten/tnsgpK
         UDPs6MZVpE+Ma9AbARD0k9VlsBJaDtFuT67veIQ/xaPEdo2XhF28kOpawIS5jbY37/6V
         wKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351680; x=1722956480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsxV3fut1xBl+ezrbLKSsc3vM1a/P+ooBO2TjvFZ9zY=;
        b=Jw8W3uULMlJRGrwfu5cMzGHhM44coP98WC07a8itXy9sb8BugOZn6wW06EgUpNEFkJ
         ljKg4sAN/CP9GcfCqhzXArI885a2HG4mK6Djd1bJLi0hfuRgKC5tvHnwXnz55YCV1U9I
         BwZGyaNsDTEAg3rnKBRru4hLVmOJrx8F0C4rupMrdJztr5bVyVS6yWmJoVr77c+AZQFK
         gS3uHpx7o/yqZA73OxNkpXiSWsjw87ZH0rYQqbH0pSJ+WZX+aiGz7oabJ0llvH6YEuhI
         CIAYu7iBs14J6f3Hrhv/+UB334LN5WDz4HxHcka75QHKOQI/hLFOm1iHgH+ngXMk70rQ
         iP7g==
X-Gm-Message-State: AOJu0YyxstA5nxocxYrtlNvxwJ9BLiYT4hwJlTeBZN6fhACb6ajs4tbn
	fhVZ0ozkfZCDnKQiRqkB9zL1YfcsRoK3QDRvllde4E2OCE8usf85+YBb9i+ajDA+6u71TMVwnz/
	qUJKkQCMk5tgtTxRpCbdyE4arMIVVYg==
X-Google-Smtp-Source: AGHT+IGOmVIKSlWr+k/2F94qcWn0zFXPz1fPjcMN8DABfzxYhwy8RrEGh7lUCEY+ZdY7+Gxt56eWKDcaXr450uerVwI=
X-Received: by 2002:a17:90a:1081:b0:2c4:d00a:15cb with SMTP id
 98e67ed59e1d1-2cf7e216834mr12340439a91.21.1722351679697; Tue, 30 Jul 2024
 08:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701182732.85548-1-jwcart2@gmail.com>
In-Reply-To: <20240701182732.85548-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 11:01:08 -0400
Message-ID: <CAEjxPJ6BZoNhswFc7ERnBykTfQr_AeMphGUKny5X94J+TDSZRQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix integer comparison issues when compiling
 for 32-bit
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:27=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> Trying to compile libselinux for 32-bit produces the following error:
>
> selinux_restorecon.c:1194:31: error: comparison of integer expressions of=
 different signedness: =E2=80=98__fsword_t=E2=80=99 {aka =E2=80=98int=E2=80=
=99} and =E2=80=98unsigned int=E2=80=99 [-Werror=3Dsign-compare]
>  1194 |         if (state.sfsb.f_type =3D=3D RAMFS_MAGIC || state.sfsb.f_=
type =3D=3D TMPFS_MAGIC ||
>       |                               ^~
>
> Since RAMFS_MAGIC =3D 0x858458f6 =3D=3D 2240043254, which > 2^31, but < 2=
^32,
> cast both as uint32_t for the comparison.
>
> Reported-by: Daniel Schepler
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index acb729c8..bc6ed935 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1191,8 +1191,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         }
>
>         /* Skip digest on in-memory filesystems and /sys */
> -       if (state.sfsb.f_type =3D=3D RAMFS_MAGIC || state.sfsb.f_type =3D=
=3D TMPFS_MAGIC ||
> -           state.sfsb.f_type =3D=3D SYSFS_MAGIC)
> +       if ((uint32_t)state.sfsb.f_type =3D=3D (uint32_t)RAMFS_MAGIC ||
> +               state.sfsb.f_type =3D=3D TMPFS_MAGIC || state.sfsb.f_type=
 =3D=3D SYSFS_MAGIC)
>                 state.setrestorecondigest =3D false;
>
>         if (state.flags.set_xdev)
> @@ -1490,7 +1490,7 @@ int selinux_restorecon_xattr(const char *pathname, =
unsigned int xattr_flags,
>
>         if (!recurse) {
>                 if (statfs(pathname, &sfsb) =3D=3D 0) {
> -                       if (sfsb.f_type =3D=3D RAMFS_MAGIC ||
> +                       if ((uint32_t)sfsb.f_type =3D=3D (uint32_t)RAMFS_=
MAGIC ||
>                             sfsb.f_type =3D=3D TMPFS_MAGIC)
>                                 return 0;
>                 }
> @@ -1525,7 +1525,7 @@ int selinux_restorecon_xattr(const char *pathname, =
unsigned int xattr_flags,
>                         continue;
>                 case FTS_D:
>                         if (statfs(ftsent->fts_path, &sfsb) =3D=3D 0) {
> -                               if (sfsb.f_type =3D=3D RAMFS_MAGIC ||
> +                               if ((uint32_t)sfsb.f_type =3D=3D (uint32_=
t)RAMFS_MAGIC ||
>                                     sfsb.f_type =3D=3D TMPFS_MAGIC)
>                                         continue;
>                         }
> --
> 2.45.2
>
>
