Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCA2D5C7C
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102610; cv=none; b=SSfDQcCiLhx3tYjSDNrIB012GMiPtBbg7vTOj88RQBQL6chvauMSwOh8LZxxPEIyjwEhYgVvLKQWIAj0sY/TgXg6S34Sf4bK6cRQPV2nz/W9DxdkLT8TdUGui97/Cf3ToFRIvwV0SNc0o7n+pZz2YjGo5FZiP8ISZwBX9SEuyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102610; c=relaxed/simple;
	bh=+d7e3+otwq/LC5PJAPcL3t8nNCFMmh7YtVYKR5eI55o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxZOWHxq5S4oYKzoxm5TRGnz/N8fvAvP0pr+Ru0nnmDllq0MXT9tekcqA2TZWaAgzFx83jlAmAiBLfMz+DEOFhLITejvLhLpVBFZsUDsLJnHCnLMVRE/1W/tL58z5UG+c4a2m7lQ1yrnU4/MvInmRgK4IWHrKIX2jRn43H0nn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADJ5jEL3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADJ5jEL3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2350fc2591dso40298535ad.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753102608; x=1753707408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1FjnT5gygefK4ldRYssMooMUeDHyPWJ4P0xyA0lSCI=;
        b=ADJ5jEL3qpphRnaJPnTXf7czeZ5XSuwIhfl+Y51hDt4gOeRi5M+jBZ51wToj9OiddO
         UkOXhE+pK+tvxL9xWJbq1GJ6szQU+IOmWOt6563EAFFyILKG/LdI3pZWDxIQiJSE3rsz
         YR3HWddLEhaFdNyyahH1ZJ/xd1DT3MUrMIboY79CV7lCmcjLAWPJ+VoB2kpyEhfN1Tnp
         Ve7QZRzoqBKXEgGabutCrzL1MnRhJkOA5/8MiL2N47XyyGTeAJVSWB1J1tVC8AraK6Hv
         1kSJzgRC4b53XnWHjfZ4BGsPma10B9CnSbzHFt0YNQyyH0a5J8iJiszvaw3jcAJsAeCO
         6S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102608; x=1753707408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1FjnT5gygefK4ldRYssMooMUeDHyPWJ4P0xyA0lSCI=;
        b=UV5+V0GDNWVl15KPaxLIvnyw67aUej83g2T2SBSw4pt07AjXhJR/NDC7AVAmTgatZF
         UsF5duFD8v+BjAkoV5uWB29d9+8Ev3QElxgvTCbtbjxUGj5tQCzmX4UQPJ6GLHTDKPqV
         8rdR4WSBgTEZWF8Jo3SyLpnNw9UUk0rpH+u/D7n11QxE0alOrcOlljFCZTQnI3VVC3Jv
         sGjxxWoco9RjEVrs70sbyLQ1vMbfdDQYq557j2h4R/sqRhNzXaAJjHmgiw23hN4L0ANC
         /ZtcIG1Irc3YpKXANCQDLFADDa9EqPLaKRjVnjSPc0p2csX9W4NngwsgyI7Ulj+vbbZQ
         ejOA==
X-Gm-Message-State: AOJu0Yzs9HjNlIK+rNC71eqb4ylQ7rJSqN+Kc1dy7KkmZCWW9oE31Moz
	NOQ975JdDALj2Z5XU6roNhwYcvVd7C4hymSKz+ybC+OE/pmAVdVfCPNJEsnVEdq7QRA1KIxtEiY
	VHkSa1xcLZjiW0TEaJgaIky/9Y09YtB4=
X-Gm-Gg: ASbGncu2wDvsah61zQn8t4e4NkzE4VyGLkG14WC2ZGygA+edfr1MZKCsPvaRBh0ms00
	Mi7BLvytLODybTHmTa4UACkiSa78OeTqdnlrvClNkvyYOYH4d/pviP38Io8HmJ2xCYxabSpMZI7
	8oLwZpO4c4AI8mzzdJooW3KpiKHmg29I0p4pk0BWxLwvIqqZ3MLj3e8fjBSMY7r08zI2u5ayY7j
	ew5e7g=
X-Google-Smtp-Source: AGHT+IEwGwF7U1OAC3e8R0dJBCtqw1jxWTv4V859GNA++r/xAoyvG+ool+VzbMJxa4NmxPLM0Rqe0Ymv3fZygVsK0Dg=
X-Received: by 2002:a17:903:987:b0:235:e1e4:edb0 with SMTP id
 d9443c01a7336-23e38fab19bmr169077385ad.22.1753102607881; Mon, 21 Jul 2025
 05:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720125229.306644-1-nvraxn@gmail.com>
In-Reply-To: <20250720125229.306644-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 21 Jul 2025 08:56:36 -0400
X-Gm-Features: Ac12FXxU1S6D4j5e0sI8aBz0_RLLCxUTtD4Hi8OrJSdqz-z15o_a7ndYi0k_aRw
Message-ID: <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:52=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
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
>
>   - Looping until the last "enforcing=3D" in the cmdline. Latter (valid)
>     arguments take precedence over previous arguments.
>
> Although this patch (intentionally) breaks the case where "enforcing=3D"
> is provided with a positive argument that isn't 1, enforcing=3D2 doesn't
> really make much sense, and being strict with the arguments we parse is
> a good thing given that SELinux's mode of operation is controlled by
> that option.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

We should make it match the kernel's logic for parsing and handling
enforcing=3D on the cmdline. For reference, the kernel does this:

static int __init enforcing_setup(char *str)
{
        unsigned long enforcing;
        if (!kstrtoul(str, 0, &enforcing))
                selinux_enforcing_boot =3D enforcing ? 1 : 0;
        return 1;
}
__setup("enforcing=3D", enforcing_setup);

And the kernel's parser ignores anything after a "--", passing
anything after that to the init process.

I am not sure off the top of my head what the kernel does if the same
parameter is passed multiple times.

> ---
>  libselinux/src/load_policy.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index dc1e4b6e..9d411b95 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -244,17 +244,26 @@ int selinux_init_load_policy(int *enforce)
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
> +                                       long val =3D strtol(valstr, &endp=
tr, 10);
> +                                       if (endptr !=3D valstr && errno =
=3D=3D 0 && (val =3D=3D 0 || val =3D=3D 1)) {
> +                                               secmdline =3D (int)val;
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
>
