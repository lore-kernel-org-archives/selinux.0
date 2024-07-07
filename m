Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D4CA40
	for <selinux@vger.kernel.org>; Sun,  7 Jul 2024 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335602; cv=none; b=Jx5DDEArec8bTxpksZfYGVsvnpB5pfaZj2LtwPUn8U0ThJ0aJyoFpBHZi+9OjYHm9I/PCIGTzTVcOo5lAe/OWmkiZd251GgtxPVa7zGQLiGroe/UxKo304mQfuGgSOrH6+qyKbF+GR9GHGvaMMfmPNzL6dSgrzUwvvucKC8YIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335602; c=relaxed/simple;
	bh=PXllK+OJigD3jSbmRsTeNWU8M1Hw+9Ayzx3V+EGMaoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2aHNo+rp32phey14s5qCjF+NU01dHOZCBOA1fDueDv4YuorReUgzogzADxgGUd0GR1oNRa6W/xuIGo4BILjUax8gWNpIZRMhbEie2v1mhQjZfFiOhvHQsy/v12+hfeM6XDdGeyeCOtEK6ZmVxnlC52z1Dy/Fst+nHIW50aZ/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mmq+yGrY; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mmq+yGrY"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so1952396276.0
        for <selinux@vger.kernel.org>; Sun, 07 Jul 2024 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720335599; x=1720940399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0AIL4ZXpVapvXV/fgnvM3k01TReZ6fi3ltnZmlRgHY=;
        b=mmq+yGrYYUbKepXs7RbpKBO3GNLPodTCMgWMBkk2KoAX/1qCYUWIC16AZE+mJtyv4g
         F2bk0Jzy56L/NHD3SB4IH+PPthqqS1psYCy28kaOzw5B4lR7Lt+iiLMAnf9fFU+CB9ON
         jKmOLCdI+3dNgMPty9IXCW2Pr7TDXUl8It5RFqBBcPzMEZ1QmpGXVGsYTip4Mcvr/9B5
         vkC1JZ/erJHjUzepS1MODOOJjNRcGKCQt0vaURWBuf3M+5TjOXHskNU76IjIkpl7K37o
         E/OrR0788cdPBxtc3JqHwNCr97nEEHdSzWh8tTJQoni4pWNfmq4mJYWifxWIKW9f1K35
         /7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335599; x=1720940399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0AIL4ZXpVapvXV/fgnvM3k01TReZ6fi3ltnZmlRgHY=;
        b=r04dVKkcLYzbO0Ng7x+iwjadxf+Xr9LW3wu7SKu3rk+D5oTeCIGsAnapxR+93Bbsvn
         f3b5wfL4ebUa62NCCg9homJUYPjmJeQSdR0Hnr6gp3d7Cr734XqOj/5oznUZSB3pybb3
         iNx9rDtwY718Z2XjJDdncMpWVbkMvzkgisyd1JHobEfTfA9D2EyH5W1sm7gBK4yi+W1R
         GbXIQWs7sRAZkMt/ub0OKfs9tpYs+y7+Ez3RKYckYuj5lQ0OePzKVFTqix8XrcCI0H4/
         9etnk4KZl84PZjSlQsJMzZvm1ugz11jQCnW8RP4R/YvG39kkQJMsN9DW1geWnSE9PgJB
         39IQ==
X-Gm-Message-State: AOJu0Yz5GcWjiD8CbdsGxRuw0jxzB7cRlTdSa5OHp2I8fHdDopuG7MMW
	TdrRugf6flEmkxsSep3fMrfm5PUKP/5lrTIBPwtsynZEG9EMgH7f9eHcQQTOAZnoGVrSSNHxsLT
	zkIsVwEbdltKsjUa/xgEhBiEVmYZOKQ==
X-Google-Smtp-Source: AGHT+IE+Ncc1/sHSBdb2nTt1n11hvrb3CLJWVSSumunel2f5Be71aVNChIvQn+SPYRgZ0zhciIDO2Yl6ejkuV5CA0as=
X-Received: by 2002:a25:ab67:0:b0:e03:5b4b:fdb1 with SMTP id
 3f1490d57ef6-e03c28cbf11mr6177790276.8.1720335599471; Sat, 06 Jul 2024
 23:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701182732.85548-1-jwcart2@gmail.com>
In-Reply-To: <20240701182732.85548-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 7 Jul 2024 08:59:48 +0200
Message-ID: <CAJ2a_DevjOD55nbGxqjEPx+Z6q4bpXWZDVu15-4iAV0_mQgpzQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix integer comparison issues when compiling
 for 32-bit
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jul 2024 at 20:27, James Carter <jwcart2@gmail.com> wrote:
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

LGTM.
Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

> Reported-by: Daniel Schepler
> Signed-off-by: James Carter <jwcart2@gmail.com>
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
