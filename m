Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17343CA4B
	for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799639; cv=none; b=ZhlbOrPOwc6v9NaGt9sQe6uyoeS+tIOCJFpH8oZkZKSR3RGBSjMbqUbUU4OsRz+FckZInHmSxzUSwK+nbyEMf2XRpbkMraAss5z6x9zS/aP5xU0EE3MFH/2fd3wlsF938YmPzav27ivXLcoe2XVKFqqVJ4g8/DqsidTqS9GicFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799639; c=relaxed/simple;
	bh=hu7OaxbYesvpo8rMIBACAw6Ph085ioSQQGl4eqkmqQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWUH+tJRJ6dVauD6G3xBrs3wLqsRHRQ0g2GHYV7abQ1NBilCZU5v22/i53EXPFcznk99n/k8DzRAB9ITkS2iPG/tDGc5kkQ5yFLIb3PjfVBldpZE/zV9zsvEolXeIIbUw725bRQktChSCSg0PC9U/vo4n9JcSCPyWq4BJWRPkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Bnj6RN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Bnj6RN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so285376a91.1
        for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753799636; x=1754404436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbmq3Gn6dT1E62xNXfEFsvikT/GPc2RNney7gZh2nFQ=;
        b=R0Bnj6RNLgWg117CEfmhudkzxJf/WOO3yyHHm94NXrBlS0e5sZrFqIj9Evnww4GBqx
         yN0dN9+pNKgoXVXHaxCjSZN7XEvFtkCf0MSZm8u1Wtxtqsde66k4CgJrzcV3w2tigH1K
         dhfTqoK7jSFm8Zyg7+/4NZcoiMOxtB3k2AuGPQobWJaqNwtYCYUg9TKssKqkcKqJGu96
         rB5BQSKopU5G6h8cGP7Oa2qSoEdFzBcO1YQUCNnq0qeTqAg2GMV672E1SeBhlzV3nyfT
         XFBH7czQUS/UUX4ZElZmwuKxKM/QBY2Q+Xrvk8rWESYl0hVI4Nc6Ga85kbq9WZeMPsIj
         /f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799636; x=1754404436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbmq3Gn6dT1E62xNXfEFsvikT/GPc2RNney7gZh2nFQ=;
        b=JksJPiRmj+HhlKC/ErDC9+jU457Xr31uyejwRCzB+7kgdack5NZr8rvy0slbmk4FXT
         CHi0xrXvo6DatPbg2Gw8XBs46FHDagsUZesfEHOjac6bOZVYpG9giEDIqaSFEDaQrqA4
         rfac5lP04r7N1eqXkioZs4Zk4svCszFX9bbXizBPMVPgxOeZslgAffG4BPreqXQmwJqA
         Q7HLKjmLUnCu8j3E6hLvNaEmNJ9S5SntTU5vBahNtNvFNl3laPhQrlYieQj61QN5bvKp
         I00lX/DPWqWS8SErL3jxg/DbjNXp3uyku01B88W4PFYWR/UgDuDbUCRjldmzmNajSnkd
         Zkkg==
X-Gm-Message-State: AOJu0YzVDwD1ivZhYvzLamYIxtmNmMMvY9h6SnICCV/pLMkTr+DguRi+
	n1x1qI4YdcdxMWdh9lFCRLnrtIpd7sjovCrJOnB4wfoxWl1r0kQcu5WROTLBx0fx7t4JfTyGOQ9
	KaoM3L7JMLjNFO57agT85yFP5uChvM/9CXg==
X-Gm-Gg: ASbGnctj3QSLpVA6QIhmKhI9jPdPYSbowCLo1a2Guue9TDk6Y/FS2Gmv4PygqzG6tcI
	jEarwDcT8vpNdIyr3M3+XUALwUkJWQmVaviJ5ABzu5y5M8lm/7qrAminX4mIyD6/b7H/JFh24vD
	UWm23Cb4dg1rei2TnL7QQ7vtsAb2lToHGXXjU4kUbTD7sxkn4kzmX/rAO0T2O7tV+iiE9Ykhd73
	MYkJfsg/CqmT9RTnw==
X-Google-Smtp-Source: AGHT+IEzXZ1zA2NcE8d9HopHBDgTT4lMamsK5wSY71hmW8C89ECtm5br27MXMRa/oHgfXWdrdvieLzzliecuTEF0Iec=
X-Received: by 2002:a17:90b:4c4b:b0:31f:4e9b:7c6a with SMTP id
 98e67ed59e1d1-31f4e9b84dbmr1050556a91.15.1753799636196; Tue, 29 Jul 2025
 07:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727153250.731505-1-nvraxn@gmail.com>
In-Reply-To: <20250727153250.731505-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Jul 2025 10:33:45 -0400
X-Gm-Features: Ac12FXwuiMjQBRrcpNFc7aHTIduzcgSuDSxJaz2-zBtf47U_6PCyO0c-gGKsYzI
Message-ID: <CAEjxPJ483QFyTuM3bHbsgs-i6PJ=UtbezZ-6NPaMBw9JrOCvdg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: refactor selinux_getenforcemode
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:33=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> Invert the check for cfg being a nullptr and early return.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_config.c | 75 ++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 38 deletions(-)
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index 75db14ba..a2335fa9 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -88,47 +88,46 @@ static const uint16_t file_path_suffixes_idx[NEL] =3D=
 {
>
>  int selinux_getenforcemode(int *enforce)
>  {
> -       int ret =3D -1;
>         FILE *cfg =3D fopen(SELINUXCONFIG, "re");
> -       if (cfg) {
> -               char *buf;
> -               char *tag;
> -               int len =3D sizeof(SELINUXTAG) - 1;
> -               buf =3D malloc(selinux_page_size);
> -               if (!buf) {
> -                       fclose(cfg);
> -                       return -1;
> -               }
> -               while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> -                       if (strncmp(buf, SELINUXTAG, len))
> -                               continue;
> -                       tag =3D buf+len;
> -                       while (isspace((unsigned char)*tag))
> -                               tag++;
> -                       if (!strncasecmp
> -                           (tag, "enforcing", sizeof("enforcing") - 1)) =
{
> -                               *enforce =3D 1;
> -                               ret =3D 0;
> -                               break;
> -                       } else
> -                           if (!strncasecmp
> -                               (tag, "permissive",
> -                                sizeof("permissive") - 1)) {
> -                               *enforce =3D 0;
> -                               ret =3D 0;
> -                               break;
> -                       } else
> -                           if (!strncasecmp
> -                               (tag, "disabled",
> -                                sizeof("disabled") - 1)) {
> -                               *enforce =3D -1;
> -                               ret =3D 0;
> -                               break;
> -                       }
> -               }
> +       if (!cfg)
> +               return -1;
> +
> +       char *buf =3D malloc(selinux_page_size);
> +       if (!buf) {
>                 fclose(cfg);
> -               free(buf);
> +               return -1;
>         }
> +
> +       int ret =3D -1;
> +       static const int len =3D sizeof(SELINUXTAG) - 1;
> +       while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> +               if (strncmp(buf, SELINUXTAG, len))
> +                       continue;
> +
> +               char *tag =3D buf + len;
> +               while (isspace((unsigned char)*tag))
> +                       tag++;
> +
> +               if (!strncasecmp(tag, "enforcing", sizeof("enforcing") - =
1)) {
> +                       *enforce =3D 1;
> +                       ret =3D 0;
> +                       break;
> +               } else if (!strncasecmp(tag, "permissive",
> +                                       sizeof("permissive") - 1)) {
> +                       *enforce =3D 0;
> +                       ret =3D 0;
> +                       break;
> +               } else if (!strncasecmp(tag, "disabled",
> +                                       sizeof("disabled") - 1)) {
> +                       *enforce =3D -1;
> +                       ret =3D 0;
> +                       break;
> +               }
> +       }
> +
> +       fclose(cfg);
> +       free(buf);
> +
>         return ret;
>  }
>
> --
> 2.50.1
>
>
