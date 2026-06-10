Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E0312803
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100935; cv=pass; b=qRchYO9/Lvigo12jUNx8vpzs0wlagLIGHT09NX0uXhB/rjdhpmCp2rLKzdzZLBDjS585UOfBYQ7ZHcixP8P/rRER/eKW55mWsvMf1OxwICmk3Js6nwm93QaK/T4vCmWjNtWcGTdi9kuN82YLqLJ+B1YRn5QZWBUB7IKJMuYwu5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100935; c=relaxed/simple;
	bh=2wMhK0XPpMwVAsj4YP/XF592mB3GQYKg3gWaQYin06I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgF0/ytQA+vB9NDLG3fnEAM52f8a+/LrDRv8Y2PGbi9r8JrVoEburo+4ioZz3OuYxpsCbKqDamWMq9bfg4j7XSqDz8ZDOIBIfAapGB3dQEl1O/SocVTP5xzfsP1f64Ezd34FGwu5z1iannvm+Mo4/KW2Z5uiQmqUXu6hmoLB9Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPObNyC1; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPObNyC1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3967725a77fso67397851fa.1
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781100932; cv=none;
        d=google.com; s=arc-20240605;
        b=ORW0uh9hDVVwenqGDRqW6bcdSF/aGr7J4tsOCpd+/9geVaY7T6v/Z5rh/9Dfh6/AQG
         5MH0mYjTjPypfOTfmmU3+XpHneofNQu/J59x8xfx5IV1nmoxzTHqKtpyllBqPxJP84wT
         Xz00Y+HLZVFwNcSqr9P7Sox5PkWF93ycb63fQJdXN76lDNQEKy03gZuuWEzuaw5fhIzp
         D1so4j5wADTpbxNJhk9Rk2sd8ZtKYPCXcGk61MjfHlg4RGhPCP6lmiHgBm6T6I58oAK3
         wswafLx971tN+yoDddJr4vAztIal9xq3EJnPCdtXRA+yD7GgeYLVHS3cjKaXfyINnz1N
         p1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pNQWjDOX0WWGbP5rz+iiHNWiRUd3AKuT4W+k3635/nc=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=Uh5ZpRBJsH6cvY/eSxYiq7CztcBbKA3VMy8ZCwGIog5v9vzX/V4lY60t1IspCw+VFt
         8y6F/Tue9cxRGUyw46KHipmNO4NpTUWTy25HymPzqS4EALFWoaaULVpGARPgJGugtCLU
         yDJhjTn9plFC29upEckcws9KuxhveFsAPZ+/6h+qiQT29BYBcY49h9tTyWtYoFJhgddw
         8W/zdgw7mxc1wfeYSI7KAxQyQkJsw4AYJZm39OTzc0rcQLiRQ3dxnAIcuATyficOtjpA
         8TpeJZKoNR2TEMpdzDp+M/Gzc0M7RHRvallgjtdQ9Y3Cf3nAGcoELiqsdEXbWJI6L96l
         ++Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781100932; x=1781705732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNQWjDOX0WWGbP5rz+iiHNWiRUd3AKuT4W+k3635/nc=;
        b=GPObNyC1ppwhQEXTdA3sLAQDMeXhs4uY0D0lGSREgeaGVKN982VCROyIzakgLEV7fz
         uA29Wqdzq6bkdmc4pr/f3LHlpyYPKlCUySRfZCloA5opGbXX4TuXb2DAW9Uqc/WRqAmn
         RB8Itp1c1dfhbpp4/ZRBHryB7xvAt6KUTfPmgpdYxlp+sZ3qtal0DtXykpi6H/QO2Mr/
         JAGIItL4URtr6rgjMHVuXjAwgVIH8l/PoGkxd1EMedtyP7tcXgT226l9UY8TM2PUQHvN
         f+VwljYJyuD95aXxDIDB8vBDY2EdIsmB2bYM5WTTiAdQYPZtx1oXP3GkHh0X9AFO97CJ
         b5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100932; x=1781705732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNQWjDOX0WWGbP5rz+iiHNWiRUd3AKuT4W+k3635/nc=;
        b=HRGkwMw5H7YR8bAR05hjjmLvS7z+NuvXO/QvvpeIOXqfsF/YXzgn5bkB3+HcNZ9acb
         UPYTcESrcr45fiu/L1zMWGtkVwaEY1aKI9PHvwANJinlWaXX80slkxtleUcwFl67aUKt
         a6hv7affvDQliXjFH15ybMKPuYgMqiK4l2sQEYZMf7YuSccQw88Nfoa9CjEhjle4/atS
         iJN4s3RnTXlwbhRorDEmkQ+eO/HQKfoeu6bOxGDeTNoh+WuWiRFV4KyP2aHKOJ6vythJ
         Y92DTM1z2GGCJbk4j43xA9AWMe3sLZ8fgYqtdNW9DjRDIAVUeWhRZUxYIiAAH86dXuZO
         hirA==
X-Gm-Message-State: AOJu0YxpZOfvJitpG6HJL4VTAy2cKBrLH9Se6k4OCBSXe3kg357i8U8k
	5/AFaEUh51gLE5Hckw+GzZtynuZ3zRP+Qy6WRU6FqYi519YE1sANaYNXWkSUNhg/RLaC9DTchEg
	6fyYdHlrC+VdKUrSHW9KnbxCphI6jrds=
X-Gm-Gg: Acq92OE+kfmCJu/VU29Aix77KS+8Y07Ix0aBkH4tc2E+vb6Hg2YADDR6FLRGyJZ8ik9
	Lb7/iqsIXejPZN5bV5B6dFkXR5lMz9f9LYTLG4IAjomo04YvKhHPzKcjSB8U3gPZgcP7jqaRpRM
	Gebjh9kCuFbjRdkJa9LhcpKaCC7y3shw5iyQxzZSG98hfu+nAlQBityAQ/EKTHKgEwFlMgMSiB3
	1UiY67qG5dgMKkExrkTpNb8uQYYMQqq+mjp8Ur1RKcBTcAtQbX8K3U1x4sJjYzyduXlUKe325r+
	GRdEFepQEjBDA58=
X-Received: by 2002:a2e:bc1b:0:b0:396:78b8:27e3 with SMTP id
 38308e7fff4ca-397f77a90c6mr20870751fa.17.1781100932135; Wed, 10 Jun 2026
 07:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:15:20 -0400
X-Gm-Features: AVVi8CeSSpYAM6trhqZrzM8am0hzT7l63_am_ZLRkfN4LilGmwo7FxgtE-j_PBA
Message-ID: <CAP+JOzTmX6+-YEC67s3pcxsX6ixYa1HY4YLMdvEXWiTV4ich9Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid out-of-bounds access on zero-length lines
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> Several helpers read a line with fgets()/fgets_unlocked() and then index
> buf[strlen(buf) - 1] to strip the trailing newline without checking the
> line is non-empty.  A line beginning with a NUL byte is stored but yields
> strlen(buf) =3D=3D 0, so the index becomes buf[(size_t)-1].  Guard the in=
dex
> with a non-empty check, matching the form already used in
> get_ordered_context_list().
>
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/get_default_type.c     | 2 +-
>  libselinux/src/is_customizable_type.c | 3 ++-
>  libselinux/src/matchmediacon.c        | 2 +-
>  libselinux/src/query_user_context.c   | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index e2186a19..8955c505 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -38,7 +38,7 @@ static int find_default_type(FILE *fp, const char *role=
, char **type)
>                         errno =3D EINVAL;
>                         return -1;
>                 }
> -               if (buf[strlen(buf) - 1])
> +               if (buf[0] && buf[strlen(buf) - 1])
>                         buf[strlen(buf) - 1] =3D 0;
>
>                 ptr =3D buf;
> diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_cu=
stomizable_type.c
> index 0aa790e3..992747fb 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -44,7 +44,8 @@ static void customizable_init(void)
>                         i =3D 0;
>                         while (fgets_unlocked(buf, selinux_page_size, fp)=
 &&
>                                i < ctr) {
> -                               buf[strlen(buf) - 1] =3D 0;
> +                               if (buf[0])
> +                                       buf[strlen(buf) - 1] =3D 0;
>                                 list[i] =3D strdup(buf);
>                                 if (!list[i]) {
>                                         unsigned int j;
> diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediaco=
n.c
> index 3e7544b7..ca3d7980 100644
> --- a/libselinux/src/matchmediacon.c
> +++ b/libselinux/src/matchmediacon.c
> @@ -26,7 +26,7 @@ int matchmediacon(const char *media, char **con)
>                         fclose(infile);
>                         return -1;
>                 }
> -               if (current_line[strlen(current_line) - 1])
> +               if (current_line[0] && current_line[strlen(current_line) =
- 1])
>                         current_line[strlen(current_line) - 1] =3D 0;
>                 /* Skip leading whitespace before the partial context. */
>                 ptr =3D current_line;
> diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_u=
ser_context.c
> index 0a5e8315..c2196de2 100644
> --- a/libselinux/src/query_user_context.c
> +++ b/libselinux/src/query_user_context.c
> @@ -85,7 +85,7 @@ static void get_field(const char *fieldstr, char *newfi=
eld, int newfieldlen)
>                 if (fgets(newfield, newfieldlen, stdin) =3D=3D NULL)
>                         continue;
>                 fflush(stdin);
> -               if (newfield[strlen(newfield) - 1] =3D=3D '\n')
> +               if (newfield[0] && newfield[strlen(newfield) - 1] =3D=3D =
'\n')
>                         newfield[strlen(newfield) - 1] =3D '\0';
>
>                 if (strlen(newfield) =3D=3D 0) {
> --
> 2.54.0
>
