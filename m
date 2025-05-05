Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7042557C
	for <selinux@vger.kernel.org>; Mon,  5 May 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473382; cv=none; b=Bu0JOnVY1/91Xtu85aB+ZjaQf9dfkKFBpkS6fWZUwQjky5fomg0rc+5gMs+iMAWZ8gz/BFNd4WvLAprJjo4mdEWUMwgpHHp33SO6Ej2bxbcmse7UIRhC6ksdjt51jbh29wLWZbEFDTTFZcynRCWXMnSd+AEF25anrSdFIMwHnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473382; c=relaxed/simple;
	bh=ts9jnGW8p5ICUsD7ZlKBra4QV9xVaHM93Zl28T4Srr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATE/KjxVsjTJEbYPeybz/WZ4ULpveNfhbVfKJLQoAO4lrU5/s0l8euFUUWeofcFJdRfrZoGjK7krYKw+P4gY/Zo3ES1G/QZNpPbc+nFK0q48NRIZhqeRwo121BVV9YZHqmcek8yhgQspnlTdgj2iv/p4ShjopwP/cX0h8V0aj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWH3kymp; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWH3kymp"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4dad6cc2be0so1404421137.1
        for <selinux@vger.kernel.org>; Mon, 05 May 2025 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746473380; x=1747078180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaVKKZp9eZPzdY84ZJf8Bch5SjeI8eUxoUcZFNAiSWQ=;
        b=UWH3kympZl1VaweuhxRrhqtUgxMacfl/Ix8UJdCh4TKGZaLyxwBBfEVw4fBItMt64H
         9RiLAT/esSGQRf4IZxZYNYGTBMFXTpJzPZX/OMjmq4aRe/Ggm5je0j4+nZHxr8s/J6Y/
         UPIFIHvfYwjixfSytN+sN0+G2sARHTIFG13NirzCLY4zMNOCSmRyVUFslY3yeQ+/OD0J
         PBKYzHbJf2Xyi8pg20gMWTC5R1NvHjbL3X/IVkiLtEbTOn0OCjSD5N72ydTIp1qj0dHX
         y+eAdme9HPf8d58FcuBftos8S5R7bOJu79gn3wk82rigO0kJVD6c4cMRHFX1OILo26uj
         QMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746473380; x=1747078180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaVKKZp9eZPzdY84ZJf8Bch5SjeI8eUxoUcZFNAiSWQ=;
        b=rAxhymTEa0qmojyCL5UORxkD6UgYh7E8vH++ZPjEqrGjT8h5VHUJsHCtFiI5S/36ze
         0/Rd/M/PvTUWo4raZsSJ977nssfnBxe/e2NhorJxOPR3duSL7YKN9TfwBWZHHZeBvl5s
         tzQEQ1iHpC9zVf4peP4j9AiSOceTfU2UQsCdTgr5hXB/NLtJrgrL1qPUJqwRcj+sh29W
         uC1kpXjmJFHdNe5VLuPWhZ6F2gmqWA/Nh4opYILmNdSXY+k1ltWYKSEI2czPwoX3PG3e
         KGK0eNnFqNlO//kw3vLala3Rmzh2ERf4Aq9pvS5glNGn2E6/AbgECvkkeu2rhCffG7xv
         qVvw==
X-Gm-Message-State: AOJu0YzIBk5cD3227n83XBqWsVS8gPCIfvXgAkxRCwRXVwxcE+corJCz
	czJ/eXrlXcrpCpJotaaxb11zhOwwRIRdXY3GYBnDN1wEVOi1TnhocXm3dl+eKp7V+koEqTM3Srq
	2zo9HE4CsgC44lfjJqSZX4J/Ip14=
X-Gm-Gg: ASbGncvsy/5jh3434oxTWobYUxk8rlc76CZ1dX4u2tEAUuSMed0ASMCX2FWqitlQc/J
	ml9e4qDr7D2+LW8fOxnxzt4rrFWj8OXm8yFMQ8wvi+QtF0nMmbJJpK54U9XFWqod6EaWAdQmCr2
	rXDMFi4gnnOLNV732CO8s=
X-Google-Smtp-Source: AGHT+IETYeDd6/MS5dnuKJGQVd+UBBuE9jjHjXRo5ep8RWuwWYgywL5xUypFImWxrW6jKNmMQn9x7EDGrZdbb+3uAcQ=
X-Received: by 2002:a05:6102:3c84:b0:4c1:8e07:40b8 with SMTP id
 ada2fe7eead31-4db147bc8ecmr5121552137.6.1746473380041; Mon, 05 May 2025
 12:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501195915.820343-1-robimarko@gmail.com>
In-Reply-To: <20250501195915.820343-1-robimarko@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 5 May 2025 15:29:29 -0400
X-Gm-Features: ATxdqUF1mzgjWHkKyQ66UikXsVwWqc7KrXh__ZMM5m5G3Zw5T8KHH8wrUMkmttk
Message-ID: <CAP+JOzS-ThMWqJfTLAvSc0xG7XB--FT0G5-evpMm14h2hPFpoA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: run_init: define _GNU_SOURCE
To: Robert Marko <robimarko@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 3:59=E2=80=AFPM Robert Marko <robimarko@gmail.com> w=
rote:
>
> Trying to compile run_init with musl will fail with:
> run_init.c: In function 'authenticate_via_shadow_passwd':
> run_init.c:206:40: error: implicit declaration of function 'getpass' [-Wi=
mplicit-function-declaration]
>   206 |         if (!(unencrypted_password_s =3D getpass(PASSWORD_PROMPT)=
)) {
>
> This is because getpass in musl is guarded only for _GNU_SOURCE, so
> define _GNU_SOURCE for run_init.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/run_init/run_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_in=
it/run_init.c
> index ce499781..4531a8ba 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -37,6 +37,8 @@
>   *
>   ***********************************************************************=
**/
>
> +#define _GNU_SOURCE
> +
>  #include <stdio.h>
>  #include <stdlib.h>            /* for malloc(), realloc(), free() */
>  #include <pwd.h>               /* for getpwuid() */
> --
> 2.49.0
>
>
