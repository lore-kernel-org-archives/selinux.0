Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174F3AFB17
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596112; cv=pass; b=N/heKmv5ozi4VMX0zfldrm6h6wgiaCVWGI0VdxhEWAuPO2fw9/WFQuuV7T2V2/Q8+tNqSNEW5aTYkfE+8tNn65e6CfIXJqx788lFPXZKNbiBq4NaWUIZWUl1aEzmbZe5p+9Xke9Uim8xedQWvykPiKWSTreds2mX0AY7eZMbw48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596112; c=relaxed/simple;
	bh=Jtl/qHt5ukcbuO6DtFMxpGej8ZVN5qtiWw2bEIMa7b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmU3qwxp4AkBj48/q8aPPJzs/vi5CIVm5lLkfU8ELYgkj7JfnMry+fMoKgPeKUeWxdPIFrwKsnREEI+nRaba/04g66Yz21JTW/vt6fHSrJxuCL0cqwqx7BbGGEi/zIwVBIl2p5/8h3kuZ3Wsq8gvTAANmEOiCR6kilidzkl43ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmMuF6wa; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmMuF6wa"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so2339248a12.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 07:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596110; cv=none;
        d=google.com; s=arc-20240605;
        b=Dsm8rIjc5caB7vFe0HBB3Zkdx2H+1Lvc30Q0SPwGJ5mftpWzyBqyWfonmLebWz+1yh
         /GRwZzsNmbZ+CU4LIqCUuWlOVFHzzf6mloJBv2c3j/vrD7gFTE2Y609C6h6XdLtvIs5S
         xxTBi6TkY3Xq0BakWzfyZ30uW3cLkNBp2fRUBTYN3u2Yjh/EQOv6lpOpgxqrDijugRuL
         NEs2LbcwfcjfX4yL0bg0YbYgWNUpYd5l00Sui2Z7M2LAvTNgsiuTzWT5oa55FN/ZDU5c
         Z86OIz2xcPcM/Tb9vXx+lnyEMJ0vILECx6i4DUR/bIBdpHn+D1aV6NdCYgOlYxXoJOm9
         TSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ya/JLy/tYUOQS0MqG/mwWrRhdkBnJqtB68oY45li29s=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=Zkeptzpc9K1NFc8fy0eiUXR0FzdEMo39dvOboJgAHfM8w3qBlNs6WPPQcq18KITFE+
         EfhniT0SgmvFaPBRp3m4rWB9jdKayA9J5nlfdqUIrJMIY/hBsUJlPU0x63UZDclZLrpY
         Z69I3qdHvddnpuqe3fNpkE0KAU2FbaaUHWzB3HDtt8j9iSPO2j9TmV9TACL/gTBeHtwj
         7M1+LuC2ylr+F4L1DeRHrLeAbYe4tv06FOVEu9haQKAPJbpEzHYRyU9UB7pELIrQcR00
         Zinsf0UbHQmQaG+9QJLVpuP81ZHhcnHguw98/5pkePHPGrOuMuywl8vYI8Z1xIiiefNI
         9sWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596110; x=1779200910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya/JLy/tYUOQS0MqG/mwWrRhdkBnJqtB68oY45li29s=;
        b=WmMuF6waruGs0WiwAlrALjYE43bGLcNxIe0Fvq5h+3d/I6t07Xc5BhFULLskiPAgZH
         HDCae/PWMfWPA7BXibfA5+AI91Pf84P4phBqi88xP7Y4egnbvl9AAyqsiigHLNso/lgy
         gTomewESQ1eag/1Jh55peK2Drz5SyCLhyhfzcpLJOgj3ptSOjYZK7H7RyBEmFQmCdq4X
         EohJB2Jv8nholskfwbF39cSErr4zP28hKc8zJGdZnYdxVaORHf419UEPIOvkw4GEKTe4
         X7kKVA+oN51VW/n67hsvljDGDaLiuMnaMpuPd6VSaQWWk/HqkewA+hkU+t4PigJLDh7O
         pOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596110; x=1779200910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ya/JLy/tYUOQS0MqG/mwWrRhdkBnJqtB68oY45li29s=;
        b=lzyNPi9xZ7q+zvnK7lc5VijIfQZn9pevc2Lz/rIRsILebzy7OsMMqVi30hVkfNo9Q+
         8GDO+lxpxc783oF2o4tuqi/cKyuJZf21ksP/UmwcoZJ5kDYaOweMIUHvlqJt1bcdsak5
         G96ZPdC6F/xhmMw6u4gDYuNWEPgM4SYIwPbFz9wNx5PDrtUrZ4S4MTnNP/KZqxcCen83
         8EClLKTxoGfrUQE1QoPGPvaW47dWe29vKcwFxnXB+lxcVL/JpIvvCRzU47m4hWnpm9+W
         K6x8TGV26y8xWQyOqVEk2FQZChKkzWUDxQLGe0odgPBC+7eSj//TvTdwWfmuaCdjfEXw
         XiGQ==
X-Gm-Message-State: AOJu0YxD37gf1uH1+zlRjbP9iwU7u9P4GtOmhE1Oc9uxOmCu2zNrbwhc
	yNiDE6HkKhLfCYNWERG4lPHTM0IR9gZCME4XNtOkEU8eQjebaMeewogMGMp/7XFLptOQqxWE96p
	XMif5wckomLG0m+IMzjIAz5TO1dlCCrhLZQ==
X-Gm-Gg: Acq92OF2yCYrMC8ptn0Vza2Oio+31I0AUrw/EwxrG057jf06tyBVS+gTpI8x1S89Bv2
	Y5RQe9GUl2VsKrmHdZka+D6IxXRPYeiOiy45Pfs9F0qYt1qmcy+7qMdr+yB67sZod2Cnwi9ed3h
	5s1ObtqtPJbL0/IP9oVMEEquaTX5Ey8sWQobwHVT3hXyQLoz5pTU8QSaWcHCMXeT/EZGuxrRVGS
	hjrnu5GTe7d4zWV6IgQiTplCvK2H5nEIlY59+ibj2fFNsIpfumEo/qNAgFzfw67fcORZqlmTrYO
	RroYPpo=
X-Received: by 2002:a05:6a00:12d2:b0:837:e9cc:d465 with SMTP id
 d2e1a72fcca58-83a5b9d8e54mr28786566b3a.20.1778596110373; Tue, 12 May 2026
 07:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414183946.3867493-2-nvraxn@posteo.uk>
In-Reply-To: <20260414183946.3867493-2-nvraxn@posteo.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 10:28:19 -0400
X-Gm-Features: AVHnY4KCayX3W2MmY6LfsOnmXtpY-XjyNO4cgh2aR78D0kejuSPy7Q8K_Lt3Yy8
Message-ID: <CAEjxPJ5TRLCVOWoxAsP1zC_v73Q1r1oFdXQfmAev7y1bbwPFSg@mail.gmail.com>
Subject: Re: [PATCH] seunshare: guard fallible function calls by checking retval
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:40=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wro=
te:
>
> seunshare currently segfaults is passed --kill and an invalid context
> via -Z.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  sandbox/seunshare.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 2512a18c..e89a9fec 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -679,9 +679,19 @@ killall (const char *execcon)
>                 return -1;
>         }
>         pids =3D 0;
> -       context_t con;
> -       con =3D context_new(execcon);
> -       const char *mcs =3D context_range_get(con);
> +       context_t con =3D context_new(execcon);
> +       if (!con) {
> +               free(pid_table);
> +               (void)closedir(dir);
> +               return -1;
> +       }
> +       const char *const mcs =3D context_range_get(con);
> +       if (!mcs) {
> +               context_free(con);
> +               free(pid_table);
> +               (void)closedir(dir);
> +               return -1;
> +       }
>         printf("mcs=3D%s\n", mcs);
>         while ((de =3D readdir (dir)) !=3D NULL) {
>                 if (!(pid =3D (pid_t)atoi(de->d_name)) || pid =3D=3D self=
)
> @@ -708,11 +718,13 @@ killall (const char *execcon)
>                 if (getpidcon(id, &scon) =3D=3D 0) {
>
>                         context_t pidcon =3D context_new(scon);
> -                       /* Attempt to kill remaining processes */
> -                       if (strcmp(context_range_get(pidcon), mcs) =3D=3D=
 0)
> -                               kill(id, SIGKILL);
> +                       if (pidcon) {
> +                               /* Attempt to kill remaining processes */
> +                               if (strcmp(context_range_get(pidcon), mcs=
) =3D=3D 0)
> +                                       kill(id, SIGKILL);
>
> -                       context_free(pidcon);
> +                               context_free(pidcon);
> +                       }
>                         freecon(scon);
>                 }
>                 running++;
> --
> 2.53.0
>
>
