Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78488177981
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422904; cv=none; b=jD6T8HrxXaJoyDgJ5nudybBI/XoT6C/kSIYcgEZfX8oJJcBS6+U9eqLbcw0k8gsYXYRGySRt24ox0/pim4Vbpfno297Al+WTpjgpim3347CYAxLIGiwZUh8jJppEp3Kwz75QaOM3NlGv19dxaILFNPYtIBcE1NhfAV7t5ZrLjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422904; c=relaxed/simple;
	bh=o3PoayYOLzcUlzKH9AUlsfB9fQvy58WwRQnX2vFRZOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzOjOXzS9RrOoB9bac4JgWY6UXLWvKtvkJ8xnIFK7xnsc2ZspOMfDSzExoPqVRr6NwuHACHrIRqK7e9lntxHYFGun2axwaI+4eD4p5u6a2qcB+USBLpP4pfgXwhyz/02yL0zxRBsCqjRvTejfOboHPyNUr9y8DnmBsM0WxeAhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItWen0FW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItWen0FW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so11562231fa.3
        for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422900; x=1715027700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhDD6c/QDbgeP5ov1fwYFEcdyyMJ18AsqsErDgxT+5M=;
        b=ItWen0FWeCsnOEGXd77+PnrrB1YImpRNlWcIjrUuWOzrv2RTjWEKt0t7//o6zyy8P/
         9OUAvnDH/A2FjipPUHqsfdpVGBEuGhqZJxXyoJA2LixqHxLRSysIZpUhsfs6uz9OHMpm
         Hc0B7octENP9E1pGhhxS2vsvCgls7CtNb1hQxRMwX/b5lmudDr0mBX9P0BDRZcE1+vtq
         KgMrGKBszSk5CsW4mmXwwmE1B7tTlFAVZmX0w5m+jbiSyibs0fkdSFB4KiK5k2WtrWc3
         Uix+gaV3IxguOgklFYTo5ZoPf5Ya+rEvrNSYzedT8jyKF3IduYLv2FtNFqFekpGqe3xW
         5LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422900; x=1715027700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhDD6c/QDbgeP5ov1fwYFEcdyyMJ18AsqsErDgxT+5M=;
        b=mTbGYDfM/IVQ8yxu/aH9IsElZaGozoMdywD+bGtKRu9RmN92Rz0c3jRIRvMgX/vzY4
         jtwC/XMLbBVEi7bpGp92OoH+7GkHvH4Kysgq1c7Tjv9/mXdQY7y8OTicEst5DPMW5+qU
         eYt5do7W3wwJGi1lN65vbyhwFmKr1PhjaSFmJgF/Xu8isJ0fUtqN3GZ/p0ytlpa/iRHf
         oMuo48PNS4ducWftO4YfAbD5nB2dVnvbJhDeajY6pmWASBpu5jHOAizTD6Z6C2e2uiib
         qAprxWWQmSF06R5nSRlMimXDtro5CGJ5AUTgSXijpcpw9ZqpfKeGnj9/2sGLbHmLBfHg
         WfQQ==
X-Gm-Message-State: AOJu0YxSKedMeWUAQxqLdcSJRgsD0866T+ZkggUSk6p4koCn+0S0bL8F
	BiNfZcRlmZXVvUtKua2w1L541JL8DExU6IjcmjSukAnd6K8pM8gVYUbv1K2hIbio6bV63vKGaDv
	jR6cZx7aw60obRaeIs8Y5xt5nu/M=
X-Google-Smtp-Source: AGHT+IFtKnq3PGmgVjTcZcxLLRafrEUx62Dq1cWvv1yNDLeiHr+rAMIukpgEQfphPUzvGiZH47M1WhaVoSyP+Ikqw6o=
X-Received: by 2002:a2e:8608:0:b0:2d2:f5fa:f37e with SMTP id
 a8-20020a2e8608000000b002d2f5faf37emr4905429lji.51.1714422900304; Mon, 29 Apr
 2024 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163901.65239-1-cgoettsche@seltendoof.de>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 29 Apr 2024 15:34:49 -0500
Message-ID: <CAFftDdqRZcQm4kW8+pAOYQDQ46Ze9Q0zzpqsKYi9KNz-1wduTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In case scandir(3) finds no entries still free the returned result to
> avoid leaking it.
>
> Also do not override errno in case of a failure.
>
> Reported.by: Cppcheck
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/booleans.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index c557df65..1ede8e2d 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int *len=
)
>
>         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR=
);
>         *len =3D scandir(path, &namelist, &filename_select, alphasort);
> -       if (*len <=3D 0) {
> +       if (*len < 0) {
> +               return -1;
> +       }
> +       if (*len =3D=3D 0) {

Changing this will allow scandir to fail and it continue, what's the point?

> +               free(namelist);
>                 errno =3D ENOENT;
>                 return -1;
>         }
> --
> 2.43.0
>
>
