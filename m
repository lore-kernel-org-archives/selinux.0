Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BF3FE653
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535355; cv=pass; b=U5nZw2QNiJ/HEaV+JpkpBFLNewfP97fJBA/dwElEBFBCQl3bjxClGSIn/Jhq1OCuaS9sgtYesZZz/mvDTjEvm2ceeNii1mWv7Yno61C8SavOpLRgL507RtEljlFdGPrN/1ugfVoFYzX9GrhpBdnVOJV8A6lIVVJS0UcugIc5Dl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535355; c=relaxed/simple;
	bh=tId8rrXlcv77cIzCbm/Al1ZA0Qev2edko6AwgBNeG5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBJe0UUV9T3Kic5fJ2Q4uERa64wyrrtEbKIURETq7ulzIpH+DsHKdiz00jEMx78kiOBWrXgJpUdwT6rEW78+Ppw2I4fGmahymvZiYev3tIpsNK473HpgrO+ETvXIThdhtqUweEmU+/IlsC/4i3qd1p1kOzncEjmLqFL+FmxaXE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evsFGdHw; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evsFGdHw"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so2234397a91.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535353; cv=none;
        d=google.com; s=arc-20240605;
        b=KK54GWvrU/aFpQRvv3h9Sv2Z2iC5plKTXAURHE5AKFWwRe183IA4SE9TOnqMwxpVhi
         4WPRDLyhuNOvwtwzJAIlH8dg4i6Q1O82dpjuhm5UY2Y1y//vXLx+mtcSBVCAQCT8Nb4u
         rI0ZTrqFQC0wGu+FbOVL6Qw58QtjuU8sl1BO9DpRLQxU10sqNvjDlDK8bJEAnjhXahp5
         1FdzRHSHtmD8G3Brgq3qOlhQWMozJHBtxSI8DCrpL4eV85d01FnYtEWAd1Tsgz5HLo5y
         8v9yWEURSOKXo22OvWem8Yw0xkSK5wV5vRX76M+BnvqnkEO0cUqWHLBIsklHgSqnhdTZ
         1kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ClaNzR4HVBk7s68fzc0z+S1HpfbTZPM5AaeqG8mxqA=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=Vwc7fW57NqDmwWHJW2ZUlOYspXAVvGYmzVrOSNT9UjTBHmc20qwK48SgE1AX8AvB9F
         pfu2C3se/e53epjDSn5BpbIChgtHS6HLOe0g5+4zwAf4wtvkri+J87v2AkL8dvvhiteo
         +uutePOSeRSlZnoeQBdp2UCaLTFucYAq5DIsWd2Q12A7WKOLnwNpaMhXMuwGo3ISMJsP
         nere/H4U1uNBXyecK+quRpac98TgFXlcGDYsMMIf4GlQMmvxYipPWF8T6ik5y+9i0R9g
         eV34B8sF2gJBvqQ3genlA2c22iKyI8gzrDglc3eTg1gMqpRV2U4to5qHSauKzkZoxprA
         FS0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535353; x=1782140153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ClaNzR4HVBk7s68fzc0z+S1HpfbTZPM5AaeqG8mxqA=;
        b=evsFGdHwBxpHVzVZ/tfb1+IpAzxc/5nns670y5MU2uGeXS+ZO4mKh4aQRx+hfLYED0
         u5f/g6RlfBYcJFFCmZ00sS+bK15hYAvyH4nvM78LZz4m4Byqu0ZXfbV+QZRffla9AA69
         c7DHwfG6NPNpajRCMRAWNgDg/D1+gPfzHZMXI4wIFGI+1974H1iwYv6lAPCU64hM2206
         0XtvwNPaRmHnhss8dWcCk8Z5OyCSlWWfML/BdsaCuYRNLW8DFruaB+E/1T4YPuEZOqwY
         qzv0bnw24ZY75eDy0Gmko41E+CpVKcn/sS2f23t0eyNURnx4btvvluKlTEZ5m7hTD6Hm
         Wx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535353; x=1782140153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ClaNzR4HVBk7s68fzc0z+S1HpfbTZPM5AaeqG8mxqA=;
        b=LMsGQv+cTZXzr5qOcFVmaf0pgyzJw+Obo+4R9Y548EyAijYRosKpczr32XOM6xnR/U
         K7d9zPaStLY8j0NdIbFdLo4SKZl/WH2F4YCklBabIG5Gh00Z6ItUGbDdzm19NHXKIKMQ
         lw8hLyFB2ZMbHmddwhmBCHpia7Zdev7KgwiDtwjw+C8zKtFnDGYG/thCeM8l+IjwJF6C
         umXRncHjjOyPiL5bXEIUnha/boNcD55Jc7w1iNHDeu3zNQTjDRw7LnnurznGAh21h+y+
         Lc+Dx0Y4EQgH9E4u6CZEKF9KEdqBNUNSXro32P54m38yAJeDipfRqttV6ShjrTNcokGI
         INtA==
X-Gm-Message-State: AOJu0Yyvq+SC52rT2H/Ph2xpA+9O5YrIurboBas7DNSYWfBRw2diiFOy
	Z8+vi6DiV2Wo3eprn3q4q7p62iKLpp1ZpyavmKeB3Dx834QurxHO9ubiWmIN+CkCnv1F3L7WY22
	ex8a2XdKA2vjn9WRCqhtRCqxMSn6tRBY=
X-Gm-Gg: Acq92OFv3ZeOgQL+MSuz9FAaZPhnL33b7kEcuyB5GjouFlwE/R8KYT67krqv3Fk2cOc
	rMDUcdEmpK82W3Yhg9imUoGzLg6r4E90KfyvL4zsYxhYow85dUg5X2HsdtYRA1BAuKmPODP7ORO
	Q6bHVbiuBJtLMt2WesSB9otg5eQL5g+RAZodqocI4jjcfOTiaKF+q+xkETU+z3pIkw1GWO9FNJd
	zupQwsYu32zzVShhBq3qfn3UWWm+wLUivLk4qWPSxxbSiZsgDI89O6vcHjSi8QnrV892OsrKDsc
	oQkA2JA=
X-Received: by 2002:a17:90a:d004:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-37a01c34487mr14586338a91.7.1781535353297; Mon, 15 Jun 2026
 07:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614122904.29873-1-kalevi@kolttonen.fi> <20260614122904.29873-3-kalevi@kolttonen.fi>
In-Reply-To: <20260614122904.29873-3-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:55:41 -0400
X-Gm-Features: AVVi8CeRVwPVFS3YRehV76Nb3gtsMQZrmHQ1D0Wh72s_upRbJTHjmMDsnIz2m70
Message-ID: <CAEjxPJ5smUyjSkAfid3JuxSnWH39Qz9qy-zV6fArMk5cXS7WFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: use null character in a string
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 8:29=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/sestatus/sestatus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestat=
us/sestatus.c
> index 0effc4ad..a719f0b3 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -110,7 +110,7 @@ static void load_checks(char *pc[], int *npc, char *f=
c[], int *nfc)
>
>                 buf_len =3D strlen(buf);
>                 if (buf[buf_len - 1] =3D=3D '\n')
> -                       buf[buf_len - 1] =3D 0;
> +                       buf[buf_len - 1] =3D '\0';
>
>                 bufp =3D buf;
>                 while (*bufp && isspace(*bufp)) {
> --
> 2.54.0
>
>
