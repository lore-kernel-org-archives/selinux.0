Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F291D4165
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801398; cv=none; b=GRuWbg7K8/FjPgGal3zgcYrKBord4qzm8c7fzD7s6rNcnRyC4jDaGseXZO/DJMusKu50XEByRJJVDMFKGj00dT7QP4Qydxhaz8al0sbLOFzoyKSRt6rZ0/p0RPNPXhNvgTnVawH4N1gD0Nd+y1dfcC9ME0fXP4+efUhGOhcSnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801398; c=relaxed/simple;
	bh=jQT9p161eag2r6nmBArpHRcHiIn6cxhXNDxXXDprwbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYcnAfOhsKmhMvrbxnP1d27irCwkRLu4Tqh9Ud8Y4Wb7xiLEdoqbcjUy21jUtLrg3rqK2n0bouYlkdeQpEcYDgzfeHW3FzElUxv0EpuCsRWNq4+pn0QchHRqdsGoY0ffiDCSsYPQNGVmdX3aiySNHIiMe5H12qOaUsMPt8UNIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LRG6uZOd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LRG6uZOd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-69483a97848so59227247b3.2
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724801396; x=1725406196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9+v5+hyP2T6DdZLn783bx+FdqmNBh7kzcAQItJEBKY=;
        b=LRG6uZOdmg8IJ3PpwCH2EYB9H/E6U2WrZNVf5g1vCVFVA67JTIr5BrpsOXUzBy0VvM
         9TgwJL6Fpi5298r9+39N4mABoewaXj4xeaO5KTfZV0Yeo1KgXPLvMFbMJk/MJZhhCZJO
         aopkDIY+MQ2kltx9a5ywC2HhN6NriZQXRqgIi8Q6E4Z0c8CKPYqqp2Fia7AcRy+dNh+K
         zz6RVoEebETA5yrZsnm+0MFOMLuIqhwjUYYFLSYzz0FfzV/DytgaJfqvJxHtBC3pDr8J
         0mKjaARpfB/ww8Wqpysg9qDK5T053AhPhROSm9BJGReZoVZEfEkkBJCMVJd77lKYxM8/
         DeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724801396; x=1725406196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9+v5+hyP2T6DdZLn783bx+FdqmNBh7kzcAQItJEBKY=;
        b=HFcfi8HO7QeQ0OPqKJNimXav3c8OA6CZ287TSUWmwDBCUs4GC/DwyvjhSCIHObem+p
         buzunY+I8Jzi/uDYKJrfL+8GWHad9sguL0OkAsfM8Nh9fzc2HrQWp1YidoyHkr9UcOn7
         JnCfbC/6/lSZ5CoO1H1Ri93HLhQ4WUn8uSwz55hWvrTjuD27Omn5W//kwQ42CdsyRa5p
         BywnKMyBFAGjmd0tpQkYzUpMPglQnKlArNUwmHVDL8vjUBNRcTi1VSOFnvNSK/qxj6Se
         2pj0IC8N+/9bo8vPKg/9unlzK/lgsP/W1csEgPdWIPqyrrNiJS0OHdZJIlxaa8IXgWiX
         qbaA==
X-Gm-Message-State: AOJu0Yx+H2Z1TfsUPIIunyYfiPikyXDocSODUvT6cA5OWS3pYL6LhVGo
	vHQe8rvoCce6UZFfgw8eoThGV8PN6viJgWcS1GEw8Ph4jxr0hufED/s6thxCcLKBnWzP14holYF
	JfmlOVHRo4JcswI3r+liqj7daF6uaAdZC1zONLdFgDIIqRDern1Bq
X-Google-Smtp-Source: AGHT+IFE4X1xDTKtB3M45SdsDm6G4VG0EA0NWT2wZ0eqpinKbeH3aX8pmrujYOsSJx5tvvoPIjIwY0YSUOE8JbtwhjY=
X-Received: by 2002:a05:690c:4c07:b0:6b1:8834:1588 with SMTP id
 00721157ae682-6d171a7cb3emr1208947b3.35.1724801396192; Tue, 27 Aug 2024
 16:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724668431.19755.1.camel@trentalancia.com>
In-Reply-To: <1724668431.19755.1.camel@trentalancia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Aug 2024 19:29:45 -0400
Message-ID: <CAHC9VhTwixOByPkdOko8RAmV3ALEzqWPAHimvhFuN=YtF5gG+g@mail.gmail.com>
Subject: Re: [PATCH] selinux: mark all newly created Internet domain sockets
 as labeled sockets
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:33=E2=80=AFAM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> In function selinux_netlbl_inet_csk_clone() mark
> as labeled not only IPv4, but also IPv6 sockets.
>
> The current partial labeling was introduced in
> commit 389fb800ac8be2832efedd19978a2b8ced37eb61
> due to the fact that IPv6 labeling was not
> supported yet at the time.
>
> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> ---
>  security/selinux/netlabel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Guido,

Thanks for your patch, but it appears to be mangled by your email
client and doesn't apply cleanly.  Can you resend it to the mailing
list using a method that doesn't alter the patch?

The Linux kernel documentation has some tips on how to submit patches,
including configuration options and methods to use with a number of
popular email clients:
* https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-=
no-compression-no-attachments-just-plain-text
* https://docs.kernel.org/process/email-clients.html

> --- a/security/selinux/netlabel.c       2024-08-25 22:19:37.556414928
> +0200
> +++ b/security/selinux/netlabel.c       2024-08-25 22:20:02.860415642
> +0200
> @@ -358,7 +358,7 @@ void selinux_netlbl_inet_csk_clone(struc
>  {
>         struct sk_security_struct *sksec =3D sk->sk_security;
>
> -       if (family =3D=3D PF_INET)
> +       if (family =3D=3D PF_INET || family =3D=3D PF_INET6)
>                 sksec->nlbl_state =3D NLBL_LABELED;
>         else
>                 sksec->nlbl_state =3D NLBL_UNSET;

--=20
paul-moore.com
