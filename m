Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA32874F1
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905523; cv=none; b=EMZ9UTOMwqCTcgobSe7g1KmLtVhpbKjigdkEhULiFeRzP9f1qnhzXGY5gf7N4EIT2wbQ7uemvCJItjPji92x06yaiIvX8e10Oc/v03VDgi5+z7ZMTWeVWHkT4h9UluIQCW6GUAND96kj8MTeX4muewsV/NuRZ8S3PVeaRqbB8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905523; c=relaxed/simple;
	bh=EAGcp8JRcog6WFp3910GFEt14cmLruVhZk7xiH7AZ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWx8NhTk8CnogPxbI6n5qIlNvFOtUlEL36Kr7xUN+RAPvGAWqmq6Nf5+ZwQYUD93Iwx0iqjnG+XEW2KaXRiEeLUf7kMx/lV/LoYStJ21kYuTrxLjXzBmLG+3191huyENByItgm6qps8PFK1cPXQjG7vnxxsu77BgATk6K+f89uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJUr2O3t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJUr2O3t"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso37228901fa.3
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905519; x=1766510319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bYpMDl1bLx4FkBAO9Cl8Jqvc4y2NlUHRwIBpkyNxAU=;
        b=aJUr2O3tOIYMfizl5DOBtOpPO9v+4ULOBjf+yd2JH8kNxQNYqWvV+982ecwn+/hnrV
         RE7X5pZ+ZI7B2jUXZdj1pHWToW7JaojbsKtdcCzXeyfuL7l/XXcnHprmcRkSrde2HBuS
         AtQX+l/tZ79XgS2z8qDOMkLAynYZP3b13IaZD1U8seofPWLjHj7ero58zG0BiFkiNnCr
         aDxoB/xefHm9mwaPPsVGmHhjSI8ao890EEA0+vfauBc4yKydiVaqw5WNe5fLBXeh/azD
         ufLfq1kfvTNNq4amAcPmDoeilJPJHD48uYofZRymPJg0KWfR/idRSfi2bL4Y5JINkmit
         Bptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905520; x=1766510320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bYpMDl1bLx4FkBAO9Cl8Jqvc4y2NlUHRwIBpkyNxAU=;
        b=W1AHifaVL/k9soEdbJSALiv72BgNA5wnTGanaT13QgKrhi8atsfKFVq1a9tn+zwE1p
         IepmAVIwGsMtLj6DAyrRabjXPuXvOM0U+9PXE2lPah6zzOGYXGsxVxPRWql3mGMwD1m8
         OO/t8Wy3dHcO/4QbuUzr96bbqkDCuXrFHrZlgKzB0xMuTVSlr9jMe579OKybUP8JVlel
         +2rZCnHovbvjhq/GaGLjgTw/HK3Hz2R2yLcEzebheex47JjmtwH5KQn/tX6JFfTd+9vE
         AGEU51K28/yHfhkrSl8E9VJzPyWpFqpzndIxkGsS3mI6zwQ8AzarkLSWCsZ/86QW4Crl
         OfvQ==
X-Gm-Message-State: AOJu0YxiJKrEg9BASIVj6CFR3T8SW8lyDx/+KKIBbQHZDDAKWJiyNOdT
	10zPa451m10vElO6B8W5hfeBUEhbkmymS0x91AmvuGglrjlyej/q7qKIh0nlKtM7FkgfM0tV6iU
	XSTMA67P4gnxtLMjqKJ8CN/7Xx5FDQlQLqKcy
X-Gm-Gg: AY/fxX49uiwog0KBIHSHMB3u6lzrm5Vdug8P8rxA91Sreah9NZExmUZ+51fidWayqNY
	oF4T+B54FMxRRvgFWHM1LAeC3upLKSOwljwuQMo/Y/JkZ8KNnP8lI6QnXg0QGQtIeP5jXGSpX6j
	HUdM/rybW20E21RPeJX9z1ya93Ai7TL2QUD0U1/0oImgg9lOc1vYTzeR2b1dxZO3kX1R3lFstLE
	QXgxGNx0LD8BcJedFYqEerHAX9qnMXkPViw34qRZqy/boWxm+Nr3FWLJVGGJCBw3pKx
X-Google-Smtp-Source: AGHT+IHYQLTy4XlNm9Q7srNZkd//LnsB3aojslp0Vw/o72ZepPWJxu38abwHGSim5N6KxT15iPchmb6X0XzoF2mxwYs=
X-Received: by 2002:a2e:a989:0:b0:37a:30c5:af1f with SMTP id
 38308e7fff4ca-37fd1fbc752mr50460621fa.40.1765905519457; Tue, 16 Dec 2025
 09:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123065843.377806-1-nvraxn@gmail.com>
In-Reply-To: <20251123065843.377806-1-nvraxn@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Dec 2025 12:18:28 -0500
X-Gm-Features: AQt7F2pbWTS7LyNjMW_8eTsTR5XZYi6KOLGg2pmkq9XrYwod00xr0eivAPCmV3c
Message-ID: <CAP+JOzQRf9cvUAe1CJyxUh_QFxxZ+-PRCgWSW==XNifMJ1s+xg@mail.gmail.com>
Subject: Re: [PATCH] cil: reference guide: remove extra @ in valid symbol chars
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 1:59=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> @ is listed twice.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/docs/cil_reference_guide.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index 5ae5a3a3..bcd34b68 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the p=
olicy. Duplicates will re
>  Symbol Character Set
>  --------------------
>
> -Symbols (any string not enclosed in double quotes) must only contain alp=
hanumeric `[a-z A-Z] [0-9]` characters plus the following special character=
s: `\.@=3D/-_$%@+!|&^:`
> +Symbols (any string not enclosed in double quotes) must only contain alp=
hanumeric `[a-z A-Z] [0-9]` characters plus the following special character=
s: `\.=3D/-_$%@+!|&^:`
>
>  However symbols are checked for any specific character set limitations, =
for example:
>
> --
> 2.52.0
>
>
