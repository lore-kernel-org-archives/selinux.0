Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0382209B
	for <selinux@vger.kernel.org>; Fri, 16 Aug 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772817; cv=none; b=Uerz1TNHOolz9nkQIQfl9bRRAg9TquvMbcyHWTQN5o3HYbHsH2di9krjni/7UM8KuEXhBDNxvoW0jrd0AiAiGWQzaKz1Ax0kPwI+y4Drr1o2G+hzJHLwlxx/8JnNRhkElqqB9sV926wa/yjyyez87BkOsXfMFI9h5BKC+GKDv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772817; c=relaxed/simple;
	bh=NIBOoJMVb1dDnKkwOEKZDat5dY+ftvJcIF5qfVLXbzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcp8zSV/tX0zOHAgn4P6NgkNXhFVmwhBk764KQurknHCwyp6XiF5bAGM4emmf5I502oBKFgVG17+ZZ44AVHNX3Qr6K5xdfpMaEiiFYA7TBw9wWt9dAb23EvBBtutSa7rMTvLQ0Y/4Wy39OEXOCn2tIW0Dk1XQ5P8XTByjnD87jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XWkYg7Ak; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XWkYg7Ak"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-699ac6dbf24so14934837b3.3
        for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723772814; x=1724377614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXHD3XO0PVbm7MDlXwMyq4trppUptHzxvJNrfQsqgyE=;
        b=XWkYg7AkTKZ3Wy6l9jeNcP+eL7dcaV/j/nz/5DXZEGzxJTDj+CeUHpWrb8/2wPYUBR
         kcDvKE/r2sjdOHW2r0ASljGOqE+SaLjqZz7JEIpVBcNc6nBNALZlKdTxVpCzZxNChRD7
         zkVi70EgT82jcRsjV1DFhCWMdQrxFFNrL+mXfP+JmMANtbD/ldGCNxinR2M1e2xSHjdj
         H417tTuY9bNdx7NQtREmioNqADTxzBdxZjIvd6dOKb7tbKu4OfFwJ+vKyzRXu6L+gCVd
         VOU7uPBZp7MWxiEfXLGc623TDS7SveW8bUQ9Z/RU6N4SCBl92eoVowHYRG20Xf2NY3Pu
         BrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723772814; x=1724377614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXHD3XO0PVbm7MDlXwMyq4trppUptHzxvJNrfQsqgyE=;
        b=LoG6LYBb2CBc5gcKt/pD8GDzHoqB4usmdpSzClSE2ez8UPnQ805smw4jv0XgHso3db
         VwrmFinHpAEgHkYGXn/YTU4xro8OcmNzINagFqVr7IcfkHcWNIAUp8upVsTnb4Bf5KNs
         ALOISewFvut8PQL5l6HZWDG+wJ8hpxM2hzMB867MAl1EyoUW5BXBh3lKSt2qHGmhOtYg
         bbN/TxgbQg/8iFePMVJiERyoFG62c1dnhQLsU8ktg4EMqOGfM/dU/BdECTC++wdgxogT
         ytOxA4HMp1O6z97us+3J1OG4ThrMhVdFdg6bMDV30XVIC6ysMqDO3ZYwZ6j2Jvx6bAEp
         aEPw==
X-Forwarded-Encrypted: i=1; AJvYcCVclmQx2cE80LqKBS5QOrT1meEtOFTIlKIU7vXLOoykg6+bC4fE3jnqyCJ+9H1GJfmToR7Zi1J++K22U94wWDjJZiNYK9p5BA==
X-Gm-Message-State: AOJu0Yx+8ZA5aLyfWhfkwDtZ4htjTyUh4BTwpvxU2twbGRblqVXNcjaF
	egpxy9CE0URoaR0p4rgR5Oyd0HRIPzeGZeJ5KtzyIU99I9JwCbdtlMnfN7rOx8iI928VyXpXkL0
	wIvdIOC8ilX+RdCTEP9Pfz1DsUd++PPJEoEOV
X-Google-Smtp-Source: AGHT+IEgrfjyTo+Vmdl9sEQ0LsmBBkJ4rasMnzHUl4tlI9dxrpz4WNlKI6P75hWT2tcxYRdGCsEh/8CmRjwaTivtMi8=
X-Received: by 2002:a05:690c:60c7:b0:69e:a7da:f9e5 with SMTP id
 00721157ae682-6b1b871ccddmr18784047b3.19.1723772814670; Thu, 15 Aug 2024
 18:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com>
In-Reply-To: <20240815083229.42778-1-aha310510@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Aug 2024 21:46:43 -0400
Message-ID: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
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
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm a little concerned that the small patch below might not be all
that is needed to properly support SMC in SELinux.  Can you explain
what testing you've done with SMC on a SELinux system?

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

--=20
paul-moore.com
