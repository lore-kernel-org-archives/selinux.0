Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1E397E8A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682211; cv=pass; b=St1U+G18GCxDxfuavrKw+cSqMLv81v2IAitJp4u0T7zW8hpaFX2XyTJBin0o5p47csZOpwMc6zcVAOMjLuyEzD+MG1EjFV7cCcutGTcqjdCO1BLLuCj6zcxTWA1Jq3l/znWx2VbgoRN+TSvGfiaV46fDOLhVksJoRrgkhnHX5Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682211; c=relaxed/simple;
	bh=LKqdWE/M9t0B9WsQYsm2QdkHiA3+0jmsGnhjQF8gIUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU3YujwVeUmnjMXWi6tk2LbmTcBLE8oshU+Y1Zlmf1wSzNM+xegemFXmCb7nMRXHz2c0KaACCj6CLqxImUyBSLDhao88fTjdkQT1PLrHoulQ/qh/M0Wd9aQg4ezJu33Ix3RBkKJACSlCIB/7ijY/W6EyYbPLu3HrovgY3RyLE6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWcBF9nP; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWcBF9nP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf1f074a12so23139165ad.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682209; cv=none;
        d=google.com; s=arc-20240605;
        b=CME2suGKMo4shB1rHRMVH1i3DrRspQowjLvCShHPIj74bwuaFCGr6OALmvAjig3E5s
         2QRUCoCO999ollSzqsOB2ioQPZIBwj1W1j+QfUIf2ccpX9eMTAr2IRKpLlCdzAgvu+Q1
         2sxEs3sYUnQ8WvkpgoFORXoeHUPSR9lVVq/cX5AWZ25kZo3I/vlA81Y9bXNWEJmVQynV
         OEEIJTg+QhYH+8U8RFyj+d920HjeBqxdD4IGjXjwvUoiIf0Ylhb8PUUXpXAYuNJdEF59
         3u5xTX/+l3YeeV/e8s3KD5neihHwrUCXVMD8896ClbxHWnT10Ioiq0PkgBvMAV67o3Hv
         VR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gx49aoUX/OQnm+IiC9EhgoHHBGU4HJpz9aRfPzY1rU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=E2A3XfqXYcflTc0kMlv/jLXsjw8gMRnWcEZH+I2C24IzJNsRJjSoqCVdCJTtwa0Qp2
         52HvDqQD8iHqJEMJzUN1hbaOJb6UncWWhUyBQyuTV25DDL2o0BR185tsYo+XBYmZsPev
         WPRLnI5WOlkBbuz3zOSLMQOiNTo96HYl3O9hfI92a7GQ0kilzzwmhwTJVUeMR96rzuJq
         BJPQeVgQOqxFE86qFSLCm+DlCAI09aHUR2BIpnYV+UV8ufesfypB6YwEPR3Q9vtzSxhT
         ao+6tJcUdr/KMM9O4z7t4HBK79FzCbrv4uRwWxTk1ZqGPqbZn8ThBA0xtJ5g8F7liIxk
         Exfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682209; x=1781287009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gx49aoUX/OQnm+IiC9EhgoHHBGU4HJpz9aRfPzY1rU=;
        b=CWcBF9nPGlj9Hgk9gYhwlRaVtvqoVWC1sJfeHKhTAbcgqjQP+qLI9tDnSQZx1waS2b
         C4aTUFgxiyV67ANoMvbM7fMFDlkLg19waeUWvC5iDYNa3OBENbLgsnbKVAYLMfUSoBLw
         SKuZ+PgSQE6HQvprYDQ2xf4fTcSYZz0dOsVwXElo847ie5RM93gPyVfch10NTRAdwh5r
         b8be7cBXgLQRAXYC3vQU7AkxwZ2FP/LCVd9eDKxjfHoB3amCJkw9Vui++BchikiMkj2x
         06wHe5RhXYXkINnN1y6GEI78cDdUfXdYsQh4NHnyCBLkyF3AsEdQ48uAp8gtnlRuJGnQ
         GQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682209; x=1781287009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gx49aoUX/OQnm+IiC9EhgoHHBGU4HJpz9aRfPzY1rU=;
        b=sTBkx8CH9KXGyT6472DnGZmgK1rZEysNM81geiI1Cuu+qOs+bK643X9PJauMrh0z3d
         FmkKN5bHXmMXEvqQ/RMcyn2C7FV1u2EtsswX4RzdfXMAK6ZC3n4RQbexKlcrpP2yBil1
         6Gm9Sr/pc4YQ+02IcdsOrMGEMmoBYgHGySOzoy9j3jLlmzJ7HAs42T0v8fDg5wfDTQw9
         zd6msYOOhiC6qxT4B1dcm6pKx7mZiGJz6k8B3WosH1mcxjj6qssGjiWrCfRfa98ICPMc
         HRgNyDCWCh71JeWpqdB1Q0lJ6ubN27p4qj/i2rdLqbH2kyYGtfG+X1uVXlCC5yrKdljE
         QuwQ==
X-Gm-Message-State: AOJu0Yzs4NIX/7ovGovq2YHQo9rZST+uXRn1hU62JPNoCyOUB1YXrQW6
	s3VCep2cwZGFsHydKeTu1+8Qvsytff3suhls+5Td6tFW5TvtyxDbZG9AIV260Em6bAEdo6gt9q2
	BmzHCUBtkQucgxIlFHYP8cC2yYwsTMBGD2w==
X-Gm-Gg: Acq92OELGZ/T/F9Z9MlxZ5npSHQqtpg3R2zntpY0z3he9ww1KMfakll79rayuuJSJDp
	1JA91QNHog9zjjcg6uM6WqzDxdvH/wQQikrUFNmqWW4vlL6ebCahNjDoDAcXgj+tUXCsPdXDrnb
	AdyDpVzubZOgyRtlpqIeMxBINAQeQNdYvNtw2vxWoKPKQmjQVzkzn/mFFFfTAJXc/VyfWYLOdPo
	IpZk/x8xsDIvorzXsZA+U9WKFCcl2gTGjxI4/31IkA0fKcf450pThtlyOO7LQf91CbrvVx4VHqZ
	qD3/wwqNN20CajrXIg==
X-Received: by 2002:a17:902:e5d2:b0:2c0:cb90:1dfc with SMTP id
 d9443c01a7336-2c1e8219fccmr52692855ad.12.1780682208637; Fri, 05 Jun 2026
 10:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:56:36 -0400
X-Gm-Features: AVHnY4KpO7kUGP-35bicf1B2t4Oo6UE2WGtP9QotmV8m4QUFZhNHPcDKYveuWDA
Message-ID: <CAEjxPJ6jA8uWL+TcMFUPxG9G1ed5o6y=1kna1mdmYYa_BeuSBQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] restorecond: warn on selinux_restorecon(3) failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Warn in case selinux_restorecon(3) fails instead of ignoring.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  restorecond/watch.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 8e1c36fe..30dfb8b5 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -202,7 +202,13 @@ void watch_list_add(int fd, const char *path)
>                                 continue;
>                         if (len > 0 && strcmp(&p[len], "/..") =3D=3D 0)
>                                 continue;
> -                       selinux_restorecon(p, r_opts.restorecon_flags);
> +                       if (selinux_restorecon(p, r_opts.restorecon_flags=
) <
> +                           0) {
> +                               if (errno !=3D ENOENT)
> +                                       syslog(LOG_ERR,
> +                                              "Unable to relabel %s:  %s=
\n", p,
> +                                              strerror(errno));

Do we need an if (!run_as_user) syslog... else fprintf(stderr, ...) as
used elsewhere?

> +                       }
>                 }
>                 globfree(&globbuf);
>         }
> @@ -286,8 +292,15 @@ int watch_list_find(int wd, const char *file)
>                                     0)
>                                         exitApp("Error allocating memory.=
");
>
> -                               selinux_restorecon(path,
> -                                                  r_opts.restorecon_flag=
s);
> +                               if (selinux_restorecon(
> +                                           path, r_opts.restorecon_flags=
) <
> +                                   0) {
> +                                       if (errno !=3D ENOENT)
> +                                               syslog(LOG_ERR,
> +                                                      "Unable to relabel=
 %s:  %s\n",
> +                                                      path, strerror(err=
no));
> +                               }
> +

Ditto.

>                                 free(path);
>                                 return 0;
>                         }
> --
> 2.53.0
>
>
