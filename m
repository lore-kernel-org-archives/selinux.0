Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA7272E66
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360146; cv=none; b=GdQ8wPX7aWr5j9mj+GEnLSu5PSrJTns5xGdMdh5+GlN4A6wMjvNklKkyruitP3MfzTyyJO0vFRULqMGobvLHAGY4b7W6aS1+C781N8/6OKBqPqT0CcWA0UdATJ39sCb15b7b4w4MFdtciLi/3vORYGP3657pSLdQtAwvkxxrWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360146; c=relaxed/simple;
	bh=CK0H9PnL+vMic4jWafmej2ZrjJ3lQ0pDuDQOXGr19qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl5+Q43tGedviBn39qmbzG2iraiOj2MOlUUQZ6AyXiOtnnp0T/JSCDjLXkIZ9+d5HR64koOh0UROVDBG+vgvM6nIGSfMewnhIZdrPiu1axJaKDhhwVKsANS4JCe353rCg3HXIo2ZZpKiqEkWcq1gpXt+odanViNg7jn6tJ71J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNK/vnOp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNK/vnOp"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso855559a12.0
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753360144; x=1753964944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZYQiQQ1gEx0AK2OBrJZUyBZ9T51Fc4HZRiWLUj2d38=;
        b=KNK/vnOpt177wl6r46djzkOZ5qk4qB9FUqXkjbgnPWWP5uXT9tCcM2C9JqGadbYN54
         2GoQ7t9lyPzjiodMpnAd7yMIz/gt+5vEtatmUhdos0AnOIXx/AT9xT3chlMQykP30bb4
         2RLx46reWVswvKNVkr41HOu7QhmdcYJDo584EAqBCOXigpCAyLHY5GTjwqB+Amflopwj
         ddK4J1mcontX7SXfYcpHWSjPoU6nQIgh4aTeOCAciTtCMYWN0Vo4PPuYQj5duCFX8E8g
         kbhXuLJmd6GdlpIy0urhIu5pDw9C2BlwU+sdZzmXZoRUtYHhP2KJHgFgXOwbQOEC0gmF
         EvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360144; x=1753964944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZYQiQQ1gEx0AK2OBrJZUyBZ9T51Fc4HZRiWLUj2d38=;
        b=KLsWCnuOFCNUHojVx+rSP3rWk+cTkNnX6EC2+TxpRa+Q6nzQ7fwUcx+dADmO/XhLOO
         zPIb9YSzmfqz2RmIbHlssrmcjekgcuF4LeqdzN+MrYIKCkewNym7PrIli1UuKAAYp//a
         lN1qgrDpRBTbLGItUoekrt6J7vAFIGX5pPcCVSp/ZkjN1LCQK4qipT1ga1meLpL5Z8RB
         bPcbAQmrVLKBexgYYBanA3n4sH7kO8keCxcZ7nEvWJu5nssvdm/Z/XsahDjYtiT8XGDf
         63+offryO1vLgdg6ZMmjzvc9M0vkMniqZVSFYOIF7VD2yQ7SLUi1DA6ruLhThR+yq60E
         ulyA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jJtG1QmUqcJklq2q2Dcw968d+Me0nwVt8Ya7NMHUzhUuessFx3V4lCt/PbHoiruJ40PMbfGV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BY++J2K9MNnnaOvS1OCkxE6btpiCsLhmhvqAV3kqp6I2/V4Y
	z7GPAEVb/zjL3puIx2mPsgyETxmCjnwDzpHu0T9UphPah5xVogzbJAa2ClPMVY6pVvjLTdSkfVT
	FV0a9gjmcD9Wp3kFFw6m85qqtHFsyZ5k=
X-Gm-Gg: ASbGncv/BAjMzsz8YFXyMcOnivWvl/dYeypkjkatb5vtTghVmkt8L2tU6r9I6f46ME5
	rmYvWngMjAEJPwkkXlRAPhl4ZQhHACsUPclnyTMWqxZ0oIp9a2HRvS4qzu5hdzTZymt0uNGHUTa
	6apP9SKolkNa+kegUSRt9hjDdnP4hnVkvvvYtN6C6DwNkgTw/DZh3z4IPC/yXLDp66hEK7pgm1/
	0jRTOs=
X-Google-Smtp-Source: AGHT+IFr3HQS4/Ll2AsYts50MGCihHPPJ8JDVHYyedGzhBFP38Xf7oCVZ/UpeK+s27RSR+L6K7Dxz5oCbX7BDzzeLL8=
X-Received: by 2002:a17:90b:562b:b0:319:bf4:c3e8 with SMTP id
 98e67ed59e1d1-31e507c4148mr11138944a91.18.1753360143865; Thu, 24 Jul 2025
 05:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
 <20250724091320.228757-1-nvraxn@gmail.com>
In-Reply-To: <20250724091320.228757-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 08:28:52 -0400
X-Gm-Features: Ac12FXw3lfwI4OxPfuB3vkTGzYAntSaKXrz6HnL7uNnIo_5UtPBM1_YMa89-8Yg
Message-ID: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:13=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
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
> In the case where "enforcing=3D" is passed an invalid argument (i.e. not
> 0 or 1), default to enforcing mode (so enforcing=3D1) as the kernel also
> does.

Sorry if I was unclear, but the kernel leaves selinux_enforcing_boot
initialized as zero if kstrtoul() returns an error. So it accepts
enforcing=3D2 as equivalent to enforcing=3D1 but it does not accept
enforcing=3Don or similar.

>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libselinux/src/load_policy.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> v2: Follow the same argument parsing behaviour as the kernel does.
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index dc1e4b6e..0d2a16d2 100644
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
> +                                               secmdline =3D 1;

Unless I misunderstand, the kernel would default to 0 in this case.

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
