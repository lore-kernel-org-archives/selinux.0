Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1236CDFD
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682084; cv=pass; b=df3qWpPiPwNG+1V2uZDtqUR82f2J+945MKDrmgXOwjCHW0Nr/5eb3CJNJ55NGEz6sCAkAxeRPlT5zDmoVrnWIFzM7LfzJAM5lyTa61G8uHvaCol6vk4Kj8ZwjHNWAfl9BQvVyMVBPCqluAjgm1mt0TEo89eQQGu0YdL0Y82pjfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682084; c=relaxed/simple;
	bh=jV7iXrY+qx3LkKJoyUAzftw+93seZ3sH7OCYxJCBqsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLB1EbXmA5BkQsuVYr+JvZNpnZCQ+KEx7+MAY2h7SY8AjjjD7m9z12lGNpALvZ1zZeKjMfYOkEwm4K3u+Qex3xYG0KMtFpVzhIDKZMrsuNfLkb2Q81ZIxz7QGiqnCDQibRgSTBs/iLUGDnHQ7Ja4jGKUBnQZSxDDvfEp5Ip/5aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC9mf8Ot; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC9mf8Ot"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf30d530bdso22873775ad.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682080; cv=none;
        d=google.com; s=arc-20240605;
        b=E2OCJymUJ+Cea18gNfrZ389lpMjbHuqvS1qzNyANP4pLyLgNC2Av8/vBvaJDdsYGAd
         OjDHS0WEUPlkUcO8bB6Qc34cHI0ddwTdVcUZlyvRWF13gJb7c2tbtjUqGwEHouxH/ha3
         TFW21Qqsp71ZkRs+fvvYr/nn1DOGGLZIbtjmTNyiIj+IiX+1vhJZXEHgVYf0iVAtw47/
         YgczTiw6zGm1fiIT07nh0NaPS28c12aQLLuA82gvqi3np6hmKOCFxrdYK+X1Gj++s6jy
         HJEq+jvmJhr86ce+UH9ywP0o1SImwKiPCn/Rg3jLVT3d1A2/araZhqj/hd2W0cXlU5UL
         SSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUXtqYTUVj1le565dShTCz8cVE+AsRWc5AUVBn7XUTs=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=WBGh2fzO4plc2ZYgtoloSLLUNMsmFAERHQUhdQDjc20vIhm3juLHUfK1a6swEcSuGO
         4HIueWDW4JQ2NPubhiWp+WzbxwbQTtQBJxaX1K50Aqm6jtZL9MELjPxexiIPjo2JWU4A
         Dw2zmzjU5Ja9lkmzfRLNaErgzEv2WiFe1UfvsRAxWSAK5xDGtAAhmDYODTEaWG/DtP99
         uho8F6Uk5FcZgYVvDZIjDklMFLcYTAVcbuT9YeulLwjAsR+0w5JiUDrf+w98+eAhJFuC
         UjCc7tB0Wn2i7TSw+WK7TabGz/2iQLZMNUHTtUwv5s44346MQkgT/55vX87FjBWjEop8
         exQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682080; x=1781286880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUXtqYTUVj1le565dShTCz8cVE+AsRWc5AUVBn7XUTs=;
        b=NC9mf8Otm+a9UcNnPP4do9iXhkCY+MQ6YMCgBLWxUd9abf4aiBLsFFv/sxgGE5iedI
         sle4iaPKM2D2V9soBesUqk7gEBR2hRx+/r9o3aJ75F4Hd55Svzq/7x/8KF/IxccdrjzC
         rhwL9smdsXTqjM71a95gtL4mtWCIH7VxmAWG6iBVpR/cTAZJqJh8j2BZGMqaGyBQfr6+
         wjTChl7+xSIKcrV4oqF6reStCIllMj6PDIQwWFZ5sKJhUBEEYL9gs02Jllth6sxzN4mA
         /vcR3++W5E/UKoHLODrA/uBwIhwCww0VXyx2Wd5e1LGskXKPKjCZLQ+PkaWi8wgmwKtK
         +GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682080; x=1781286880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUXtqYTUVj1le565dShTCz8cVE+AsRWc5AUVBn7XUTs=;
        b=AgmhC//vl3URFFaZNcBrz9QpTLiSgWhmmZoHRjDIJIAR4TEMDTHOAE+lSWQq/eVWVY
         K53WKZd2AKKAtMYvOdTt/LLLnY2FqQ4qitQM/wsaV4V/UE5q6oVkzD7fMTs+IJOq2v7M
         0g0rP7MFCii3NelgIstnMOoAy4KK+kHwBc3TVAcamLSGAfWm5PK38AtCrcIq9FuJHR8f
         Yc9/KWLpjLe7FC2RKfl7tvj2nz5h2+sZXgi8qAit1FfadMjeMwXE1BX2TFBkaRAv02mr
         dgY8lpucujOnGcohfsdfg+PlpYqChbXTSLwMQ3RTmDJ0RCw1B+8rN+dwOB5YL60JZwX0
         PeaQ==
X-Gm-Message-State: AOJu0YysqFL6yaT0W5cuXfxxOInCLJDokKU8XL7/BSfXDTLAz4FSmw7Q
	c2O7x6bR0NqfC+UstB76oNTOWZU9JVMY6gSe1B6JnXATtEAbYwzIAV/WakVE7Z4uOr47JX5mzTW
	n1FvFgedx205lBWpv+10OKENK7T34MKMQ3piF
X-Gm-Gg: Acq92OFQO7SS+6FlXjUOFEG7UzaRobKjh3rBF/OngdZXsxoLocosDlF6vgqRIjhs56l
	2V2veTO+ZwbruusHdcrjWpmSHLjdi/cyhkgeDj5zvAXfiGimTBSiYHuoj1WjHhQNIaFBr4FR/dn
	Gn5VwkOsV44cqEKaTQscPUyIAw7iz7tzCU+fbsVndx+06+RViPPAfphehFgO7Yl6rnCmMmKciKx
	nLPDaX5eYRspFgyqu27dHHT6qU+N9ZgP2YLPBPnIloNto+aCQ9watX6ZEkmnXs8pTqFhKzn8/MH
	PBr/5lQy7tyzKDTSCw==
X-Received: by 2002:a17:902:f64f:b0:2c0:c4c9:4cb with SMTP id
 d9443c01a7336-2c1e7e7a6eamr52623905ad.14.1780682080027; Fri, 05 Jun 2026
 10:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:54:28 -0400
X-Gm-Features: AVHnY4JJKLWLlm3vUmq3l3dW-PTFdY_weukBhvGo5YVQdoe-c9-KZsfkFHjBGSM
Message-ID: <CAEjxPJ4qaN0w8SBUN7vb492LXUNnf7NHn+ARu_-aqXTw9CeHXw@mail.gmail.com>
Subject: Re: [PATCH 08/11] secon: check selinux_raw_to_trans_context(3) for failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Bail in case selinux_raw_to_trans_context(3) fails.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/secon/secon.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index df32c830..2f2b06ed 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -2,7 +2,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <assert.h>
> -
> +#include <errno.h>
>  #include <string.h>
>
>  #define xstreq(x, y) !strcmp(x, y)
> @@ -637,7 +637,10 @@ static void disp_con(const char *scon_raw)
>         char *color_str =3D NULL;
>         struct context_color_t color =3D { .valid =3D 0 };
>
> -       selinux_raw_to_trans_context(scon_raw, &scon_trans);
> +       if (selinux_raw_to_trans_context(scon_raw, &scon_trans) < 0)
> +               errx(EXIT_FAILURE, "Couldn't convert context %s:  %s", sc=
on_raw,
> +                    strerror(errno));
> +
>         if (opts->disp_raw)
>                 scon =3D scon_raw;
>         else
> --
> 2.53.0
>
>
