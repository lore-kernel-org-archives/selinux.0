Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92911C3BFA
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342720; cv=none; b=J+z8NTBX+BYyNVsfDavevNg1Qru1fudEV5gNeFXewSrigl2TQw0xE+/EDszJ30d80128j4Z1vxod8GeFEUc6Yr4ju4Ql8ixpBvoNWEJCPaxki06U9KhGGTajJAW6uCdxCZvXrVnyzXqLwzZHdYVsMQRav9ia8yhabhatm3bSgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342720; c=relaxed/simple;
	bh=DM7hS8ynXivxetDl3eO/2fKN/tN4Z+0TeBM8lVcCcG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI/Gg5LvH5nFJYySSOYNNapAps49pJopgcpH4mvNDQsi5OINuMxc81GG5CnT7HIMXDSXHh07RK8zfZGZEE0gfD69GJGPfYhMdIRsUA6NBEPfwgLeatlC9HawDZkiLZgQV7OHSeWgMusS+10cWluxcYk6Y5Uu8eu9qa+oClL/BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZXugKX1; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZXugKX1"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71d56fe8240so137161a34.0
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733342718; x=1733947518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOjoLFUmYtIZsu2k/3oGmhH8G+vMQgnrRqENgY/7c8A=;
        b=BZXugKX1xIPDIzHrMrbEKXLAs+IfPX6x1yuMUFT3rbeTTwejPV1UHmmXJQKGyw0Tm3
         IAUmiHZEilTlM+DZYyOYjEPTOXbxfe6L4dJCY7kx204+fB0ypFnzUY4Uf5UvcjuujoaF
         YR33m22BQcBUIdXswYQKpgiFVnSyFAfS6Fla7dKSWX/WAno6ayUkmXfYnYqC2ay5B9XO
         QtGVWi7u2cu0ci6L9pr4OnvlQzPtNk1hQLo13v65x9ADq+Kd92iB7OqFTRRTz6nXbfQE
         JN0pmX4VVqMTtt5C+JrrAa3JgYyzAF7HsxbvbmdgZjVqGryj1lhS+qbCrjG73P5KSHMk
         4sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733342718; x=1733947518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOjoLFUmYtIZsu2k/3oGmhH8G+vMQgnrRqENgY/7c8A=;
        b=IfwBQkzH9BEPES/RDvJM8GKv0QfaGsa1GT2rKpboVN/dsT/G+byWomlPsO5WDDWtFX
         dQRmRj0/n4SQ06RJoTPR3xPVVxWbuJPgyY+byqKnOLUevLdB4YJEN3OdLYOh4NBcj2DT
         RgeeabmP4mmVVGrF2UnlPfJQicHQyBMootl+7saf9zWF6MmMPaJhv5QFasbJybg9rMqM
         DbpC6qq1Z2f0ZU04psi3oh0Q898o/sUJ0a0wuoRGxpdQAeRvHzDhKHkZ0riyJNQcRbbc
         bvDYNyc83nh9Opj+UYsCX4wLRNWCeo7xwRxPsrJHRJgxNm+OtZppW8GytAiALZ1M5AL+
         Gi0g==
X-Gm-Message-State: AOJu0YywtV+ArdzbXCCe1uoZdqu8z3gLt+onEDgksAiCF/Zuhy1O3eRd
	kUkhg/7E8ENY5oLC38OU3H82ICSCs2sUb06lgul41rhtekOV/fbwcT0aAzs4aosWpOTgz+s9MNg
	D8OOtI2jHbq/GCl5ewfZJycfOsS8=
X-Gm-Gg: ASbGnctJ3ZjSTCXdYbYV2aUX6tKwWORwr6zdW+8gbRgX70OlU19htOuQOVYA8PKk1gT
	LhDAFhYoImfRXEG0h+T7xn/M34EjXT34=
X-Google-Smtp-Source: AGHT+IHOWSSZyN+b4qkJPIGYZzNE+uWSqFVFwxoyQVPAJU0Qwt9H77CWJYodVwJ+qzLMz2DNEUhSZpQGc0NHRFHkGeI=
X-Received: by 2002:a05:6358:938c:b0:1ca:9540:33d4 with SMTP id
 e5c5f4694b2df-1caeac44a78mr702595655d.23.1733342717787; Wed, 04 Dec 2024
 12:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140614.25879-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241204140614.25879-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 15:05:07 -0500
Message-ID: <CAP+JOzRL6S4fP-9u-CJ-O1n0+XQZKeZNqUTz+uGimzw=y5wuHg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add missing word separators in error message
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:06=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The concatenation of the multi line error messages misses a separating
> space between the boundary words.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 4ef98449..89c80e7e 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -231,13 +231,13 @@ static int avtab_write_item(policydb_t * p,
>                 return POLICYDB_ERROR;
>         if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
>                         (cur->key.specified & AVTAB_XPERMS)) {
> -               ERR(fp->handle, "policy version %u does not support exten=
ded"
> +               ERR(fp->handle, "policy version %u does not support exten=
ded "
>                                 "permissions rules and one was specified"=
, p->policyvers);
>                 return POLICYDB_ERROR;
>         }
>
>         if (!policydb_has_cond_xperms_feature(p) && (cur->key.specified &=
 AVTAB_XPERMS) && conditional) {
> -               ERR(fp->handle, "policy version %u does not support exten=
ded"
> +               ERR(fp->handle, "policy version %u does not support exten=
ded "
>                                 "permissions rules in conditional policie=
s and one was specified", p->policyvers);
>                 return POLICYDB_ERROR;
>         }
> --
> 2.45.2
>
>
