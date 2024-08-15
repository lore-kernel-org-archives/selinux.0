Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991381AAE07;
	Thu, 15 Aug 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739333; cv=none; b=UPHNiPh/kTmHJJqrrVmQs5EM/0htGPbxOzhVlDO5CbPffrS5KpjpIFaRGhvdGu3wfaPN9ZiRPzpm+QwNUneIx4ih+h+yX82FLaX8hbmv41P+xMLcOgGK1pflikLU+eXvP1rv8oRRpYwa6HH6K5T6qtO4RpkpLNZyRVLTZcr5x4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739333; c=relaxed/simple;
	bh=G2vjXkCo3WoU09RZvCkxs69lra0STWMgvtE63F/T0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kk3oqUGi6N6Itkwr+e1HLJ/bWSiJeSaYzk/pmtrzSmCOCal7k3rjqOEA37QYea10JfciEayhSF+hr9SzEjyH3EyVROoSuktiNipeECfjJo4G2fe94Y/d0ii/4AFULEt5GKAUTZwpUJmSTPyVi7nD7FF7GB4euI8HODUWlMsTEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqGmzQBC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqGmzQBC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso806669a91.3;
        Thu, 15 Aug 2024 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723739332; x=1724344132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT7q6gNPUhxM41IYuWi2ghaep8xWadC3XH4KLYRLhT0=;
        b=QqGmzQBCIBzz72K+RcwRQnjVmM1YjJVk5IV6mPeelzL+lVPknLxUx63fz7tIk162T2
         +8463B+YSL4H2CY0idTeG6ckvvvYJZpfsZS1OnENQ3+rb6KQHE9ZScmlqh3ZG3oFfpik
         cSsD7LKcIpYFXO0HtCsybOfVcVLJZE2MK6P1ePmQv5EdNyE97IgIEQE3HdcVSsuc/z5k
         GgFTqUbV8l1Dz5hdzpaN9nIf4tW3jfaMLQ1hFRDZwmYCatQOMv7clSGVQjvH9ueTokC3
         rXv9skEIyl8Qd31GGeO+Hkxo4ekwJN0yI26tlnOwnkVpE81iJ7539cdRFLiLZAmj4L1h
         jtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739332; x=1724344132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT7q6gNPUhxM41IYuWi2ghaep8xWadC3XH4KLYRLhT0=;
        b=dlmyiPfgiK4fCTDLkbVNm7xdgAlafuDP2FGp8pHTZObXCxUxlJp7+8M0IgcBzJcQs6
         7GU85F804/LaigRm7RXMCsH6hYzglbWuPAyXolFAmls7hC8Ram4exep+iPjkC6T0sChU
         Ks9NcpfAXQI3HPiBBqg9777y9TtawKQwK6jkNNWDypYDaA1yHzCK/BZwSC0q2PR+zln2
         ZGVxI4+XzfhWRGp10xCfoJpBUuD1hWVfdOSOlfWmA7Xmq1MSgNEFE8YEydgFBen+1ZsM
         rBC/Dw/+iirdnS/bnHsqFzaH8qlHmmFUbM9b6sHrlI5Q6TYW9T6s0hToZpbQlX1qY8XJ
         bxPw==
X-Forwarded-Encrypted: i=1; AJvYcCWIU0BjU0X5tFVsInWM1E86NvQWYBdqCvVRpXHLG/pGGnV0YwCJ496emrOjOu6+rEqKFVyW+TkwpK7btIO260ajtKtQFe8Rgt1eQpk7xRsNRVXdOEBEuNZe0N0n4IgKbl0YgVM+Cw==
X-Gm-Message-State: AOJu0YywRfMjZVV+UHuiDs0INcAjCtc5TvdZGBVnVjlGizpVPLEB8Leb
	IcK0f6mz3I8/4TY+xrvAt4RqMvZKeg3jtNbnVFk2fwKZbkHqCCl9DcTX9cZResBGP0kmeDLJmFP
	f66Figh9SMyGsFmTkQys5trgZjDPl3TYh
X-Google-Smtp-Source: AGHT+IFL+qZl1przmnWpFvgID5pODREgrnM07LLC7iFSHY8vUIH0L7N+m3LiAHyCnOZtOMlBE07VE4A+D/2HV0SHSyo=
X-Received: by 2002:a17:90a:d98f:b0:2cd:27be:8218 with SMTP id
 98e67ed59e1d1-2d3dfc378b0mr217797a91.8.1723739331667; Thu, 15 Aug 2024
 09:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com>
In-Reply-To: <20240815083229.42778-1-aha310510@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Aug 2024 12:28:39 -0400
Message-ID: <CAEjxPJ5kdNHO3_=JnYnAtc2zyd3dAKMDL51CDz4ZYNABGLJ-1Q@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:32=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> IPPROTO_SMC feature has been added to net/smc. It is now possible to
> create smc sockets in the following way:
>
>   /* create v4 smc sock */
>   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
>   /* create v6 smc sock */
>   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
> Therefore, we need to add code to support IPPROTO_SMC in
> socket_type_to_security_class().
>
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Fixes: d25a92ccae6bed02327b63d138e12e7806830f78 ("net/smc: Introduce
IPPROTO_SMC")
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bfa61e005aac..36f951f0c574 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(int=
 family, int type, int protoc
>                                 return SECCLASS_TCP_SOCKET;
>                         else if (extsockclass && protocol =3D=3D IPPROTO_=
SCTP)
>                                 return SECCLASS_SCTP_SOCKET;
> +                       else if (extsockclass && protocol =3D=3D IPPROTO_=
SMC)
> +                               return SECCLASS_SMC_SOCKET;
>                         else
>                                 return SECCLASS_RAWIP_SOCKET;
>                 case SOCK_DGRAM:
> --
