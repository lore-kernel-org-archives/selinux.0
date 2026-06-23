Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910726158B
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228020; cv=pass; b=QqOH5wDFr+sL7VovzH/2qNLl2Fy7jX8gzbWQ+geGYcqZqUQvZOd/OuPIxynxKM1gTykgh9NbVUooeeR7WN/Lo7sluFk++BnPdMQklJyj3LWwFN9xVSyZS+2rQYx1Xjzo1DotqZf2ZnG6b0KgmIWC+9Yr14Cme9ElJu+d3SnSUN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228020; c=relaxed/simple;
	bh=d1gtrw6pUwSqKTB+DLKUtp7JLtZrL7dEpYee7YXZmfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCY3t6L6mJ+0XEnWdFiQEzNZ+svGrQGmaSazEqkgGVGEarxbH/ciHodd0Ymh0yUKWLZCc+dafLccwhIkMJaK4oxgui+4sP8xmx/V23+JLhgBoJ2Asca7ILDqPqzUflPbuQLnf07pdjtdKeTkZMp+HmiBNWbL47eG8rtGcpSiRcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAVcQ604; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAVcQ604"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37c8e7c8137so58774a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228019; cv=none;
        d=google.com; s=arc-20240605;
        b=eQRGF5qcNC+IFqAtME44km4MVlc7GSfceLBL6MSTediZ5PDmSS7KKppPe8dwyCdp+6
         eewmkusoIW70Cpbh7gVf5mr/MGDw2i5WzAhPcnAeop40kTgB7nT6m7D8tsTXesau4tII
         sLUdqOfFhIknzh5uX3mq5NPZDfRPvgRRXYRaYEhWjwkdnxIijO5f+dziVj6leVyWyrC1
         V3xWKYDY4vTYAcDt7UWfSe4WKPCttNAi8dfhC6oFa2908UnxdC354jd2fmrOQkb33GFF
         We7Pi6fSvUBi6eRpKFZiKgeyMLgnhLHqiVnsRUgFRwe/bwl3NBm2regJyLzNu52dxyJA
         8H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sXkJFFQUnPPXbcG5MABoUQzx3eBQgTK7k35vfUoREL4=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=bxTXCwdKmnvIK1ktcVtnhhqq4w5EpiyeR+tYlpN6ZVFbbj8uEgTqKoT3bMosOyPnE3
         a9imdFpvTWSJIdoh72w6vg39N4Mg54Q2XfPlSgGKRnctpI+FkFuvl0mHMlHJEaAIxUsF
         p6jd4+9/sOhnSreHiTOrFBSpYk/bkOVNwuBNZWF325o7lCTq63ZWs1tFAG90Jumm6F/U
         ZeGpW1/Tqg6mlsx6WvMX1Bt3YGceEL9YAm8SVOPpzGbWxBb5DI2ElbLMS+WGZfsYfeD1
         2b1evstLAI6xm+58Juo9UUr3EtuCaOhLy5BPkQDzMNLJNRRD6mItGSDMwMZT1yRxYdG4
         dp5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228019; x=1782832819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXkJFFQUnPPXbcG5MABoUQzx3eBQgTK7k35vfUoREL4=;
        b=oAVcQ604GWHAiNwvS29EGmskYoMzL63SxGx4VThrVAclKBrPe5fQSicz7E7mbvXXQG
         c2XN4wJQB9DInxKeqw4G8lQQogjAwxpC4sPdKvBAO2OY/a32vRWQsyVYzZnGBjNNz4fu
         olQxHoQ4B0D+ZcvYDhyblZWraa/B+Epku7XN/Q6j//n8Z8nIis15wCj9Q5GWZvdBcOqz
         g3vOyfXGRx4rYI8xsUNOxpmmAgcrLHYJd9GP3ZP8YaxCsKr5qjngYmHY3AhbxSLA9Ufk
         MLHWTm4NVMS66RSGx52BoYtTZyfgDH+r5WXsNHD9PEwvOWXnNXQOOcXjkxsQXkwsFBDq
         kM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228019; x=1782832819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sXkJFFQUnPPXbcG5MABoUQzx3eBQgTK7k35vfUoREL4=;
        b=m5uZ5J+aYdC1WvR87wXMduu51Rb7z78tr8lktERGz1cSeOCKtiy9AseBeWnte5Ne/l
         69MN9ydIAaH0VxSF1Ezo4j5Mq8gONAAYWBmXjAsh9tSWFbR3e4NsEE69gtvVr16kK66i
         qQmGOwMLjXdCYcDAB1n4k2dnRolyKeJxnCVW1hoUyc3AtzYMohZ9a1ZgP7gbEGd6ss6i
         4OhdULWcvIA9ksWwPIbekMCm8TAsRyerbak3k2uQH5Jmfl9J6VsOh1HFI5SRcLbJ261e
         jLPTCfEDWdACfVJdwxKXasIR9mnq4heQXG++aAl6ozQYrJWxV6ugK6bF7n20ulaHEc5+
         HNzw==
X-Gm-Message-State: AOJu0YxxgjTgP3afSYYm8bimf0hEFkmlFB67nzQQdajn7/cgWaDgJ3ly
	WSKOSmJQ5vBmBTjWTkO5gFqsw23etxxfl9lV6YKXMwJtYiN96l5KJ/R9c2BbK5xagInDrpTfmdk
	YUsUq0MXkPV5EBPHo72SJ+sumD4zgZ4r9Bliw
X-Gm-Gg: AfdE7clAHGok9trPrc7GQqTPO+zY4TN8HebMJQE6VzyTZymj3rydPK2ASFroT8ILIoG
	4OqM+Ym7FgYRNUlncgYGuf7AA0bhxKaD8HAkmunTrBr8sTA//3aBRTX9kXsMUUlxj2sxOUiHKCz
	sU/fmNvJoG1Cl591Xen/E1XGEMQf7bUWuEOo+rUeA67WDoQv1hzuuSsrxuDaN0D67T8nw4nwLag
	l9sI0DKzU4yile9HMdlpIVdGadDXKTA/xZmZ+MzpvZEsMjtoA3B7bcNAbzmiV14byG3txiT
X-Received: by 2002:a17:90b:3941:b0:37c:63fc:b2fb with SMTP id
 98e67ed59e1d1-37dd0e18a99mr4458219a91.22.1782228018772; Tue, 23 Jun 2026
 08:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-14-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:20:07 -0400
X-Gm-Features: AVVi8Cc6J6-NmBzEbWOTBRrHILab2FdgMi5MwCdcaz_zjAAxvT7TLqXgP-IqujM
Message-ID: <CAEjxPJ41U7Fypkge5-MtBYuznRnbNJKzQAQmvbzpY9n8WYyveQ@mail.gmail.com>
Subject: Re: [PATCH 15/24] libselinux: fall back to a default page size if
 sysconf() fails
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> selinux_page_size is used as an allocation size by several callers; a
> sysconf(_SC_PAGE_SIZE) failure (-1) or implausible value should not
> propagate into those. Clamp to 4096 in that case.
>
> Also change its type to size_t since it is used as such in all except
> one place. Convert that usage in validatetrans.c too.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

The implausible value could likely be smaller or just always clamp at
4096 would be fine.
Regardless,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/init.c             | 10 ++++++++--
>  libselinux/src/selinux_internal.h |  2 +-
>  libselinux/src/validatetrans.c    |  5 +++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index abed3088..bd0803dd 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -17,7 +17,7 @@
>  #include "setrans_internal.h"
>
>  char *selinux_mnt =3D NULL;
> -int selinux_page_size =3D 0;
> +size_t selinux_page_size =3D 0;
>
>  int has_selinux_config =3D 0;
>
> @@ -145,8 +145,14 @@ void set_selinuxmnt(const char *mnt)
>  static void init_lib(void) __attribute__((constructor));
>  static void init_lib(void)
>  {
> +       long page_size;
> +
>         SELINUX_PROTECT_ERRNO;
> -       selinux_page_size =3D sysconf(_SC_PAGE_SIZE);
> +       page_size =3D sysconf(_SC_PAGE_SIZE);
> +       /* Fall back to a sane default if sysconf() fails or returns an i=
mplausible value. */
> +       selinux_page_size =3D (page_size > 0 && page_size <=3D INT_MAX) ?
> +                                   (size_t)page_size :
> +                                   4096;
>         init_selinuxmnt();
>  #ifndef ANDROID
>         has_selinux_config =3D (access(SELINUXCONFIG, F_OK) =3D=3D 0);
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index ce04b128..b0ef5a75 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -7,7 +7,7 @@
>  #include <stdio.h>
>
>  extern int require_seusers;
> -extern int selinux_page_size;
> +extern size_t selinux_page_size;
>
>  /* Make pthread_once optional */
>  #pragma weak pthread_once
> diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetran=
s.c
> index add381e6..d837b9f3 100644
> --- a/libselinux/src/validatetrans.c
> +++ b/libselinux/src/validatetrans.c
> @@ -15,7 +15,8 @@ int security_validatetrans_raw(const char *scon, const =
char *tcon,
>  {
>         char path[PATH_MAX];
>         char *buf =3D NULL;
> -       int size, bufsz;
> +       size_t size;
> +       int bufsz;
>         int fd, ret =3D -1;
>         errno =3D ENOENT;
>
> @@ -38,7 +39,7 @@ int security_validatetrans_raw(const char *scon, const =
char *tcon,
>
>         bufsz =3D snprintf(buf, size, "%s %s %hu %s", scon, tcon,
>                          unmap_class(tclass), newcon);
> -       if (bufsz >=3D size || bufsz < 0) {
> +       if (bufsz < 0 || (size_t)bufsz >=3D size) {
>                 // It got truncated or there was an encoding error
>                 goto out;
>         }
> --
> 2.53.0
>
>
