Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892E2192F5
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052531; cv=none; b=r4AQgQH2uVSNcrDOnSM3q1gtY0qMmPG9jv6OEJe6yIPkMb7DAL6V1yBmojhC/HEBtTk3Nk6ISrWDWBwTc2u4w+RNGmLAsaoYX9b09sATrYQoqhBhqksQiLhL6wgR8gv7DVfBsJOSzIxuLzHbc20YFrsCGp//om/IX3MeYjvxzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052531; c=relaxed/simple;
	bh=bfFd+8/PDGUbkEfMxytbKNsVmFs9Ox9N7yEkdLPc5yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcpkiX11NLeXyz3jKZvtzgO7A7qXeOYxon3V2bf8GO4o2S+7a1/Iw8v2j9FD7RbhSf8IKsr555X38mW0TPJhuS8OfczXWzsfsXmRBLzrdUKf3yI6qiuUddOKQNCMnTjijvSeEiMC+ZrwOud5LNdLQRDNsXYC1kg0GjHxB+BdHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM2+Ch0+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM2+Ch0+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d53f4960so5700505a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052529; x=1761657329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN2xDQWD5EyYAn/fWuDwR3IxtRPz0rtASHvPNwxxXns=;
        b=lM2+Ch0+rd+EABFIsVyue/uXZ1FDBOR9tWmVORkf7FcAcYp/4r47SOKRSJr2oQV3kH
         /YZtfYP/QuqZH50HDc4RyZ+6sQZEPmnSquERFuLwlJZpzYgunpM2jIUext0cbm19cSqy
         QrmfrmzFjwCEA7VhaoKk5McM/JpoGa/8C7aY3AZ7wtzeTTm23GzpjI0tBjYszLExhFyJ
         RiUcrPEN9cb0U/9q8czmmgmM2PsJO9hTkBDuAe7UV+DS86IDqoFBgtnTSn0S8SaFD9gT
         ylD/b5WtpIUJw9pD1/vy49JmpqANxtlAPTjQmbRx9VI15FRmcTzFPVcl/z4bRFbS8qLJ
         RpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052529; x=1761657329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN2xDQWD5EyYAn/fWuDwR3IxtRPz0rtASHvPNwxxXns=;
        b=DFyZKirhJEGPEK5zbKtPW5JyZpvc+xmBgyi5fgatp6GvRtzw1j8PPknOdOfuM/8GQU
         41aqStrNUeJmcX3Ndx5qVPzE8BF3s7drwHShRtIs1HBh8cfVFRgMQbzAND0gtbnl4xfK
         +kzkrBw22/SxAoieaa4iCjHAIbYSXn/pQvrpa/ivEl0R/BvCvREoKCsXSovGyN0wzg6e
         cQj1IxlLS9sLHRDYutfo+MldXbIXAabWEiUj76oT2JC5U2FK0J7ovcyR66MEYs5EO9/x
         2x0UOz+bPbNjeY50hD5GSafs7a0vI4AybNt5jPhx+ruZ2ABTlZECiiTPbjF7l2QCuf+I
         5F4w==
X-Gm-Message-State: AOJu0Yw+wwjz/akf1XhuJfOu9rP8CK60Ol07NUoshiQ/o5opBBhYurly
	t9jotRZWA0N1Ytoq83DQ7FhTClCEbLLhswe7w5nyA8k4P0TbgOt3zzsFw66lJgSC51+G7hR7MvJ
	y1yV1HH2+l96ocqN1FNw4GVII/Am3+OXJcQ==
X-Gm-Gg: ASbGncsH5GcyGs1GxMfD941J7GoIyRVoQnbpv0sZY4UozlqJYe4d9HIxea40oFiWOnT
	0/Gv+BsqdmOsFhai+xGyaf6a5zstxtkv7vhbvLjcP9BLfnOtUpDI8SPIqDynknRu2VNnKWuUems
	02ve5BGBsSG0aDKf/taUxSPsFSAcWQo1FSAy4iojUXV0bUsWMKQXyH/m9dZnt0cs64TmQk5rRQK
	dcRlCKN73dP5E3xzUf2+97+Va9Z0yrlG9iZQY4V5KsfKsCM8QOwey0vzXGzxzdgxo+h2vKznp7d
	PAsewA==
X-Google-Smtp-Source: AGHT+IGUR5pSEV6vo3bWdc5H6S3cDqMIu5HqiY5BPj9O85A6DyaphLTrgeEb2mQ75ZoP+McWPqsTTaKYgGgBNiuBP5s=
X-Received: by 2002:a17:90b:5105:b0:329:e2b1:def3 with SMTP id
 98e67ed59e1d1-33bcf87f412mr20731851a91.10.1761052528912; Tue, 21 Oct 2025
 06:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021113626.40772-1-nvraxn@gmail.com>
In-Reply-To: <20251021113626.40772-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Oct 2025 09:15:17 -0400
X-Gm-Features: AS18NWDF4bDTYMVsBXZc88vPZ56o8UN14hI6Ja6KCUpxeP9ufHVHpL0_U8iaiSI
Message-ID: <CAEjxPJ7=xQBqEp+TWs8GEr_Oi_-t3MaW9cUh0TE8i1F7qWZ0jg@mail.gmail.com>
Subject: Re: [PATCH] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:36=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Parsing KV files with a separator of similar format is fairly similar,
> so we may as well add a helper function to make it easier to read.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/genhomedircon.c | 81 +++++++++++++--------------------
>  1 file changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 34056562..08a22df1 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -308,6 +308,29 @@ done:
>         return retval;
>  }
>
> +static int parse_uid_config(const char *file, const char *key, const cha=
r *sep,
> +               uid_t fallback, uid_t *out)
> +{
> +       char *path =3D semanage_findval(file, key, sep);

Not new to this patch, but more obvious now that it is in a dedicated
helper: seems odd to call this path when it is a UID string.

> +       if (!path || !*path) {
> +               free(path);
> +               *out =3D fallback;
> +               return 0;
> +       }
> +
> +       char *endptr;
> +       const unsigned long val =3D strtoul(path, &endptr, 0);
> +       free(path);
> +
> +       if (endptr !=3D path && *endptr =3D=3D '\0') {

This could end up dereferencing the memory you freed above.
