Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C421C9F5
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385399; cv=none; b=MfjhsaIUJOLYCkuuzDmHCkhe+sJ3YkVBR1EgxfqpY9XTFQSp7za4bSwrHFPUSxsp38d98DTBgUjPfeUPRhl+6bhHoaz6aINRtJk0YjF6xcPOT3lu095EhKxl6jssTvkqL/BlFzLPgHQhnx1pdiUaohyO2zw2jSR0Qz0yTgsrQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385399; c=relaxed/simple;
	bh=mFMCOY8PG0UFxcLxV/9V64UEEXsIKw4dXaeOZseLvIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/H+m8ASCw4YF9kTIz9RIDzMAh3NzkVvKVJtJkaDc65rWJOrooyhl15czyvFNpNxeDkYyLMJLG2zSFkCfAVhwMjh26tGC7sccHNS4Q6Jmr2QAEvtE7FjFWL8AkTWGtOIiFF3YJe1xU9b3VwVRI5oXiSQ2D4+6ISfOSCwY0NptQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxZg67Qo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxZg67Qo"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso870996a12.3
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753385397; x=1753990197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6aXJGu7/JmKauZo0nUg/Y04K6IgRW8BALfFriIADds=;
        b=bxZg67QohBbtczEF1WZVWt/kK2O2bWH7j4lylMGjHZmEYiKysqAductG1Yoj+IOYgF
         DNcatFUd4Kbi6wv8K8sOKbFqlGywQ4w/D12A56qwsXsnAn1tJwEqiuSuvA2pJCdNskkL
         UHVWkPiSCu5Tqnquxy4cuVCrau9Uug/iQuCsdZYf6bDiJpD+R1DcrRHF9Cd8rwHrQBEy
         vW6ONCQcNUkj7i0fF90tGbcjXq8iehVSUpp398WeX5IrU8QHVr18lglzVUtqozlRcS04
         +y0g6AbLDoT95A2YnXa3u0cfoFs8umTfi1BX95kEmKsDeBLSmvSRGFlFcT0O1XNWDsRz
         kZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385397; x=1753990197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6aXJGu7/JmKauZo0nUg/Y04K6IgRW8BALfFriIADds=;
        b=R7D6VjEq1jhSyEoRgurLcNf5cZnc8xR1yoqN3lNmDwxY1ecm5iDFUNop09Q/k8mClg
         D72xu5Pe+2p+E95oeoIJ3/VgQPyUuZlkHnHRUJkSsV6/sDQBcY70YrKffHt47oQ3TvCF
         nfUo30cZh8QIGc8aLaTwOdkWajAb4rWAlUv6bIeWPcq13fwxeuMvOQBNF2/6mWMx+K1Z
         CM9wYZEKksj9MpKUxIMsAFknRid4FMDE45tgBGmF3hUtM4ibZbi2nBdrNuPyCnnrAlSm
         m+Rb8Mh3vk6Jg/9/infdjOix6TfYAtNQuvyg5alQq2Yvqn6NSH0lMArBTjksq8YXprcm
         ugfA==
X-Forwarded-Encrypted: i=1; AJvYcCXjVg/CpaCS8tWpPTYUKX1uk00ydNrtI3Z0knVUISEG+NSljCLVk9cpn4B5HyONalV2bZUoZTAp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Vi5WkwtH5iLTHa+SxJFVGGEitGCgOQYOHzvRBzRvKMxYJk9Y
	xHdMYZs7swMlfJWAyiAdlWnVx12rFnreSXrmGnZ96ofihcOzrOL6LTOSMKBwHQVQbIax9FCMDpB
	kpbyfGCN82NknlxuSRgD5dc1YBfNYh1NGJQ==
X-Gm-Gg: ASbGncsu3xtKL/B9qJDXbTNGb73BkxLk5RNGzWucwSNLf1SxjjHq54k8wxFuq89dnLy
	SoYylx6nA4HSmI9V2A2LFfvz9YxfNRUWCER645EMYpfN8srcL5NM6Drfx7Wm0uIlb0ysqCyZWs4
	HHxmKNKfAuAyt042sijshvn8Vfwn403wnHKQtA4iEt3D4yLsnn8gM5tl2zpfzhdQa0aQEQCNq3W
	hIRID4=
X-Google-Smtp-Source: AGHT+IHXFmx2530QNFJuD6zlbvcN3F/30hqzEzxEQuaMmrs2tjWvewEHipAI13OTsOT7paub+te4qudsg9Lebl1WDSE=
X-Received: by 2002:a17:90b:184d:b0:313:1769:eb49 with SMTP id
 98e67ed59e1d1-31e50735c36mr13235962a91.8.1753385397136; Thu, 24 Jul 2025
 12:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
 <20250724135138.318990-1-nvraxn@gmail.com>
In-Reply-To: <20250724135138.318990-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 15:29:45 -0400
X-Gm-Features: Ac12FXzu4OObA7yVr0z2KTmNCx3YZkCmF6GRGB0NKjhrdQCWUVv8Kt9D4QfXUmI
Message-ID: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com, 
	plautrba@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:51=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
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
> ---
>  libselinux/src/load_policy.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> v2: Follow the same argument parsing behaviour as the kernel does.
> v3: Actually follow the kernel's behaviour where "enforcing=3D" is not
>     provided with a valid integer...
> v3: Update the commit message to also reflect the behaviour above.
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

Apologies for not asking this earlier, but is there a reason you only
increment tmp by 1 versus by sizeof("enforcing=3D")-1?

>                         }
>                 }
>                 fclose(cfg);
> --
> 2.50.1
>
