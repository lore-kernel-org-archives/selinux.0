Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8143A1DB
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363674; cv=none; b=Ji1reEB6Oiib4yyL7hhHLmIpYr3a55M8Mv7UWXm/w8sNpOky8KPbB5bBrgNFesYbcvb0VbAHHS0EraE2pHeoOMRDGePs/xdEOJv92xfarzyDW9UQCHxwDsHk6I6qBFMgXAjLpwDKfegFk0UF0igI81LjRRqAEN5aHvqZUatfO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363674; c=relaxed/simple;
	bh=d2oZpTgDZEkfveZZFMsWOGsM7O1Vx1RgOA0Rok9rOl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9lA9v30ZkLtrIGkOcU5zO24HQ3fVYvmvOxUDj2rqDvSU6pXmspyXJHQ1EaqNu1pH8CDrY3aBx5af9oaSLj1eenapCNjZ6jkmuMoNl4w1JE4ouZqQPSU38WyDz0nM78POSJeoeMP3mJXiZtrapJmHkeIh5MgFp0yFsqfntIAL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eught562; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eught562"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23602481460so9645635ad.0
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363672; x=1753968472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu1hUqgROzi9ts7tIKgSjV/K7hA2KoKgptAfoZCxJe8=;
        b=Eught562am7F95orgKlubgBo/2MMFCHlYjKcCtxI2AmtTMEbKanyFTypCu7KyNvJ5T
         3EONhuMiWqzHtfSDi5HwY63EhmP4I+zYDmkzypFDWg5BaS+UEgMJ/7jlfq+8M9itwceg
         SixJd9GZm+B2EUGXoI0BXeA5qkrHs38YegexHSsbvzRnt+jK5NjVnonoDOx3F6S0gf1H
         sNZ6a4LGRG136xAM/vgvRc7aSrMEa2EhBw4HyH6hWPRj6S+L5EGxQg3Fx8fs3ym4njue
         GMA4a3qC7iH0lPSR8GqMaMLqHry7SWq9iA683HzhIyam2peVsYVvObjNJdc556FzaZnH
         vzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363672; x=1753968472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu1hUqgROzi9ts7tIKgSjV/K7hA2KoKgptAfoZCxJe8=;
        b=KdQHyTMBQ+OnXkLum8SM2y5SSbMvwpfPsN15AnXY7jEBs3fdpfi+spdIFEtxWML9Vl
         f3AjOMIODKXmqRYCzvxKMNFJ9hGB+Slgc50IRR+I+Z+FXU6QisRu0233WBpEGWCulLIo
         JIWbBqF7xEp545pFSRPNdLUQKnz1hERsWg81V7p7gCSs/gJWCwmwP7Kl7y9Z9aysCd/0
         LhwpYKB9D0NvqevwgnDkU5XvbomAVh2/c4R7Ir3so4zf0XbfYEjicNa+FoBnyY22CX4P
         TCYEaCUHNi2/8JsCmdzpzzLFtqQwQ6lMGorAU6Ml5g9nRP+L9WuF/4i6Y+jADhJcMJFR
         2mNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIO6VBss0b5uvvKWx/BLK0dHqHpSOxPhUoqrpLTwGDhIXBKTBEnhpIZqh18VsJAMPgOWsZloL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54c5gEOGj6+SsI7Iml/Zd0+vFnI4SvAs3e8MpmOeDvAj+GPkc
	9VXFI7aPqqXz0Wr8aQ0zgVMeR0XyOS1lMKl5dDroec3ydYqJNlUtrbrqiQTIX02cCH1uhBZ0tOf
	K/blfkq5jkFQOW2wuyg5ubesVMOicJzIgMw==
X-Gm-Gg: ASbGncvC0+d59/MtO0V1vRc8deKGShKYccMZ9NCwP23mAZ0lYxqwumEPfR78W6lrx/e
	fCmtlFVNeiKyqdQH6yK2tqDDkFPHt3cUM9dVvC1dsAVRRNgJ0QvxXlOqd0UOKTWMZb/MKpPWJaQ
	Q42r7tPbJjZZ/CcoMQCPYYFBX1NNQ6H/N2Lib/trZr5WozDRB0Rty61DbaVLL5ZX1Rqs3bLhNXY
	oF0J/0=
X-Google-Smtp-Source: AGHT+IGsmjXqawkOwau02ZkYZYENyox3mB5W2YWxJCO2d8HkHzipLxLgULx49gL+8b62GvxNihfl9QpMzzOfbiTHJtY=
X-Received: by 2002:a17:902:f708:b0:22e:72fe:5f9c with SMTP id
 d9443c01a7336-23f9821e19amr93122555ad.42.1753363672378; Thu, 24 Jul 2025
 06:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>
 <20250724130511.317098-1-nvraxn@gmail.com>
In-Reply-To: <20250724130511.317098-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 09:27:41 -0400
X-Gm-Features: Ac12FXy78Pp1yywTG_qbB1EKV7yzImVzqwfWaa4UoSL3hb5T0g4nNyYb3Wpl9gY
Message-ID: <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>, Petr Lautrbach <plautrba@redhat.com>, 
	James Carter <jwcart2@gmail.com>
Cc: omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:05=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Currently, parsing of the cmdline has two issues:
> - By using atoi, no error checking is done. What happens if an argument
>   that isn't an integer is provided, e.g. enforcing=3Dfoo? And as there
>   is also no validation that the number provided is actually valid, 1
>   or 0, what happens if enforcing=3D2?
>
> - After the first strstr, no arguments that follow are searched for; if
>   I have enforcing=3D0 enforcing=3D1, the latter enforcing=3D1 is not tak=
en
>   into account. This is made even worse due to halting searching after
>   finding the first "enforcing=3D" token, meaning that if the cmdline was
>   as follows:
>
>   fooenforcing=3D0 enforcing=3D0
>
>   the enforcing parameter is entirely ignored.
>
> This patch fixes this by:
>
>   - Using strtol to actually validate that we got passed a number, and
>     then validating that that number is either 0 or 1. If instead we
>     get passed an invalid value, we skip over the argument entirely.

This is not quite correct but not a big deal to me since you clarify below.

>
>   - Looping until the last "enforcing=3D" in the cmdline. Latter (valid)
>     arguments take precedence over previous arguments.
>
> For the case where "enforcing=3D" is provided with a valid integer, 0 is
> treated as permissive mode, and anything else (such as 1 or 2, etc) is
> treated as enforcing mode. When "enforcing=3D" is passed an argument that
> is not a valid integer (such as "on"), default to enforcing=3D0, i.e.
> permissive mode. This is in line with how the kernel parses the
> enforcing parameter.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

This looks good to me wrt consistency with the kernel but will defer
to one of the other selinux userspace maintainers to merge.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/load_policy.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> v2: Follow the same argument parsing behaviour as the kernel does.
> v3: Actually follow the kernel's behaviour where "enforcing=3D" is not
>     provided with a valid integer...
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index dc1e4b6e..ec2d5614 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -244,17 +244,28 @@ int selinux_init_load_policy(int *enforce)
>         rc =3D mount("proc", "/proc", "proc", 0, 0);
>         cfg =3D fopen("/proc/cmdline", "re");
>         if (cfg) {
> -               char *tmp;
>                 buf =3D malloc(selinux_page_size);
>                 if (!buf) {
>                         fclose(cfg);
>                         return -1;
>                 }
> -               if (fgets(buf, selinux_page_size, cfg) &&
> -                   (tmp =3D strstr(buf, "enforcing=3D"))) {
> -                       if (tmp =3D=3D buf || isspace((unsigned char)*(tm=
p - 1))) {
> -                               secmdline =3D
> -                                   atoi(tmp + sizeof("enforcing=3D") - 1=
);
> +               if (fgets(buf, selinux_page_size, cfg)) {
> +                       char *search =3D buf;
> +                       char *tmp;
> +                       while ((tmp =3D strstr(search, "enforcing=3D"))) =
{
> +                               if (tmp =3D=3D buf || isspace((unsigned c=
har)*(tmp - 1))) {
> +                                       char *valstr =3D tmp + sizeof("en=
forcing=3D") - 1;
> +                                       char *endptr;
> +                                       errno =3D 0;
> +                                       const long val =3D strtol(valstr,=
 &endptr, 0);
> +                                       if (endptr !=3D valstr && errno =
=3D=3D 0) {
> +                                               secmdline =3D val ? 1 : 0=
;
> +                                       } else {
> +                                               secmdline =3D 0;
> +                                       }
> +                               }
> +                               /* advance past the current substring, la=
tter arguments take precedence */
> +                               search =3D tmp + 1;
>                         }
>                 }
>                 fclose(cfg);
> --
> 2.50.1
>
