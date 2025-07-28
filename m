Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1B26738C
	for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711506; cv=none; b=ZpbVkNZLGBL8h4BFjbS5ezSoOkZNk5WoMM5FZlUmfZis/hL7fUJD+cioxROQxSXAob5UcQAKK35EG04YhTVZp5v7/jN1KQo9z74OGU13hhA/YJjVwZW4fLvHaJF8RP+ks5kYUk3qZPQ+ADSlDk2Jl6THaWZwYxhQUhzuQewN8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711506; c=relaxed/simple;
	bh=qaGtAnLlzpAuCkwScVrC+g8xsetUszPxbcZ/2i22H70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTzlNR4AMs62FW/GIDZAtAYRoGkCpSwQ/x64Mfjo86IZ+Qs3QwiHMWtJswJZgNhJH53hWLeuSnDs1dAw4p8nn9ChttZtR/WzXC91kecMGkFKLEXip/o+J2OkI8AHkbudV3pEBlbaPGISjC9sCI91mCq8Hb4iRupiM23FgveXMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVoFkK2s; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVoFkK2s"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so3788703a12.1
        for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753711504; x=1754316304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYe6HnCUJzYNIpKJwVB1KOpRzewqlQNrWU4trVbAsGQ=;
        b=eVoFkK2s8NIMmqbK+sr5ag412LlTUOq3TkqaOA1ccniziIUxzqVKCyBlQDwu7Co37c
         Nu6vadXo5gn/QXAiY+/1VlqwxPcfTHI5qH/WPRuFV0ZtRMs4rg+jr/Yjzv3lLloMKUIV
         W62+YRCDio+rwZdNExcH62YEabvFQZsf/JeGdCnPXd9iEZDop8ukLV+E0HcA6o3qnw6j
         YrKr2n70dhEDtZSfGEfSXrlkT3G5op3VuibUf0t3Ia+NCODmprOig2zzEEDpM34l5It+
         fP9RV3hAW+Dzklo2A31ZQyX/fv/93INEa1GODLva4SLErCFlJbmV2z8kqIVbi/CoVMJR
         luqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711504; x=1754316304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYe6HnCUJzYNIpKJwVB1KOpRzewqlQNrWU4trVbAsGQ=;
        b=q58Q/r7jwLZj6Bzvm9D+muoyCiqKFokJN3jA/8gFZNW0MwlvG+PW/b/WJQ8Z9Vin7F
         6jHPSySnu49/GmdyWQc8lEkjkCydHivLDPmdz+o/n8bC9+kpTZyaCFybui9twNT1F2XJ
         +455jod0xAfJ87HJOHDeJfywrp28JmECjXzPcKJew4eHooNlQePYf/cm9i3d0AzzmzSN
         o0SAhm9oEQ2MNWOE7j2KoGatIL4AmBh1zgi2+mNuNLidkCti2H6eUSYxb2xALwOZ9Mo8
         RWgXlgTGuvFhc0S/cYd36ICRYTBimguolkkVtnyj7x4Tf15ssxH53FGluWoLFkzjKEjZ
         G8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVvfnAuvstpdRe/kCSwNHxpCjHkOsPvRsMBeKGXfxaaZ9/Yh516KPFz1zEuoaNevNOgE61SBw31@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZkPG2gefpMm6CbFKTjXa9VdhwGqYBP6jPZHqfL9Zet1Q2DJh
	rrbtiG0k6MEeJ8Eb3D7vibx84mwY9mUpGQjQBcPiKGkfc+FNnUTSVCUZXXw/3pjHu/C+fSXVOTx
	0mrQaqVcsWL8tupBHmtAMZc4xczZHUuR4CrhC
X-Gm-Gg: ASbGncuuHVQP7pQ1tmhrooacx7Buvwmmul9/JD7VIOrNQrzzH17jtgfcgJV5aWB0DAP
	eWdXBrDiQznPsujHIHodst5HtTPVJRX+LfVObAgJ5dmyqyldCdt0MDpY/mHhjbhbrk7OaJPsyDU
	4QwgzO1T4qFeBzgc8IqGkPqxne7QXW60TV/d3l4TH3fe1lE4Vrl0oTzH5H1pq9uQ/5DcJrf373H
	IX1dns=
X-Google-Smtp-Source: AGHT+IExO9Pmvtd8DgOvvO8VFTl7lp5Igbs5l75M03WucPkYcWCzRP2jym5Km4HG8JhxtpgiozMoBwAeQRsoCODx7AI=
X-Received: by 2002:a17:90b:48cd:b0:31f:14b:f397 with SMTP id
 98e67ed59e1d1-31f014bf53cmr4500554a91.1.1753711503601; Mon, 28 Jul 2025
 07:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>
 <20250725221525.479629-2-nvraxn@gmail.com>
In-Reply-To: <20250725221525.479629-2-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Jul 2025 10:04:51 -0400
X-Gm-Features: Ac12FXwbyuUG1pujP1dIsKp5Al-gC89wUdjloVgmMBaCOiT-Smy08Sx3Mjpg0Hg
Message-ID: <CAEjxPJ4GN0rTV_aH1eWnr5FGrBeQ=KaXaRDkkDpVwHv5myye-g@mail.gmail.com>
Subject: Re: [PATCH v5] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com, 
	plautrba@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 6:16=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
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
>     if not default to 0 (i.e. permissive mode) as per kernel behaviour.
>     If given a positive integer that isn't 1, also treat that as 1 (so
>     enforcing mode).
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

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmall.com>
Tested-by:  Stephen Smalley <stephen.smalley.work@gmall.com>
> ---
>  libselinux/src/load_policy.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> v2: Follow the same argument parsing behaviour as the kernel does.
> v3: Actually follow the kernel's behaviour where "enforcing=3D" is not
>     provided with a valid integer...
> v4: Update the commit message to also reflect the behaviour above.
> v5: Advance past sizeof("enforcing=3D") - 1 instead of just 1
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index dc1e4b6e..f67e5538 100644
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
> +                               search =3D tmp + sizeof("enforcing=3D") -=
 1;
>                         }
>                 }
>                 fclose(cfg);
> --
> 2.50.1
>
