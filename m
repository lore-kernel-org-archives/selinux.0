Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294243644A1
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908999; cv=pass; b=m1WelqG6thdBcya6aw6P49ZPsXe9FJIpgZlEULXCWU3pCtn+3y1bJidctSDS3/iYlcS8OxQ0XmQPH1hxPwiF0WzpTCVMr6E6p2km4KjLotMWHxNwN7oQbPlTOmX7Uh0TTz225imucFAZJiATm4ODDor4x3BIQsN6dKAr8NqkWTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908999; c=relaxed/simple;
	bh=B/KcY0d9LL9NlDvJYINxIOq9gxDXD596Dk34Yn8Wxbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxelqovZA7ckTincWaq8zoWCtnbe67mAz+okS6V/OY2q6iNzh2zwQdFsRLGcEGsJRphkUv8l9AW3EfJl34JtjiA75yzI6yR5DgcH5M9qUpgjofxD+zaGTjkW94zUMz4X0/AY/irVd5+ja8zQDx6/MHyaN9XH89q1Rl32pd1dgZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUorF/7q; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUorF/7q"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so6933578a91.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908997; cv=none;
        d=google.com; s=arc-20240605;
        b=DwdF4n+Oy4jBOxy9Ma0huReWsYfaMVaC2jmnkon7L2pkQv62g1ulYC1MOjj15Or+A9
         4hEvoueBGgW5VTZRkXSUzuRYdv7ycWWlpevF+gNqTMzoT9hpwIBt9AnJN8pl06k2Nisx
         sEm5Imn5Ih/hru2xslKJs+rzWJw9QJ5qajnMU4mEAktzbrEXeSzqjY8MpPefsJN5YHyX
         1RGY06IL7LYeR1uJmq36J3kD5vNU80r18i4iYPUSwJmnTnsikHpRKgNtT5g5PH9/b9SG
         E65IMPv2qn1SsN89WGtyqnEHWrVG4wCj49qEsshLW8IDmpk9N/tRBc7TlJOhZw/lI7pZ
         8t3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lHzpasglx6CySoWZ2m5SPZApWhqvPZS9FqCNnchG5gw=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=N02VHt8GEMfeGfZ12Gnt00ZYLFv1UKJka4qjpCVZmzJSYouXTDLDwaQD6TPsleMW7P
         PqoyHDClFcxvSZmLaCC3P/wqIc4Q2xYFRwam7xv2JPFnHka5LOLTsdHHP4FmoJN8zmU7
         +Vbi6wudcaUz60SmiotLvkmV1Vk3l6fe7LDEZd3HIzPxRrRkmPpC3jxISDJdmOKus1LQ
         Ix8H9KoBkrgogCQ9vle9hJl9TZtqpWEzxwQ2RPwT5JUxWSzbtCo+y0ZVmkX4/a6/FgEl
         tcNh94Cj1+hXz6dGB/QJZp1ggWXF6T20y3iCdifFertPozEfpzInyN5zbz8uERfMUbQy
         4ERQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908997; x=1780513797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHzpasglx6CySoWZ2m5SPZApWhqvPZS9FqCNnchG5gw=;
        b=NUorF/7qwhaKw0G88utvNV8PxBX9eqdNRyWHf6YBAnqhxNLJFBTSJfkqTCFghhUy7I
         /2bdycpCcx2p2ABmqOPHg+ZYw2lqL5fPZ7K0g2qBXZfvHQWc+0W+joNn4i2Qc+8e/Vse
         RpkMxLd7M4fl2eqkHnzcrsQZoRwviXnGpAlJ3JqThyFnzmulP/CXpOs0qPdhbBN9lX6m
         w5P1ZUCvfmjMHme5Y9L8FGlhy4f+BjRBW/eWMr2JhOCk1aTpUHtk9RXa+pZ1SmUGYDZk
         9XfjVYulvPZp+Itc8CAlAnPr3EPAMFz2gNZVhbyKfTh6M+Cmf28jmuy0JEGVBjqt91AK
         /MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908997; x=1780513797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHzpasglx6CySoWZ2m5SPZApWhqvPZS9FqCNnchG5gw=;
        b=O5NTuvh7A4BskSkocyH0z7sC2oj13q+NyNrV0mTC8sFgOEwvUW4LWnI+0vlGlzVxF5
         Shmgw/65lgh5RoFkAtIhpzuEY7Qw8EDs+k3bOJjywo/Zf9eTpcZz8Ask1XuPBWzlibeC
         IXxTtXbFMETp2adLdAZj/Tx14z68Dg4xx6ykpeAtVv3RNDh/5fQ++AsRX63YfCUSGn0p
         ImC1lIKCti30R9qML6cMTs41NV3pX/zU3QrYQAhNrC4vWqy/tnunXNG8uMBdDDHsUSMF
         v2rgQ1UCmFGF95qiKOPIhTgAm3LyQDq078Tq4A3c+B6isLeOJP/TRIJketexZZfpUJWw
         os1Q==
X-Gm-Message-State: AOJu0Yykce4SRyuEcb6+TmXiMxlxBNlI2CNZBmqiBBDC3FnRwsuEmCG/
	vDxpA0HJ/CEX5w03QEExLbQvDgMhwP0sn4WuTN0AhpQlZXCLVwLtS9bMWuqLwmtFs+ijXy/Xzx4
	GbMqpoCR1X4Ujzj6943ay8caXVRaMmlTm08J0
X-Gm-Gg: Acq92OE5WS+QcODRzw9bKULr5EsFHzhbGnBiCB80MZ2eiXSSVeLexFifnDAZ23C/YWF
	OaofbMwWQqzFpAA7M7oBj5hftQaSVRUQDynbjIStvoRtdpFcovUXzp823He3HGyGmhc6iC5trER
	NXdOz012ttGFoRS2SwPOF2CgwwU3Gni09Jtpvs7F6PVbG0SiQ8+rZaCbC3boqeZYm1hAoCFGTJB
	QZIXCFbUguEXQtxvwSzzxOwvNHPCRCJDq4fqKpGhtew+j+tm0OAYtLs32Y38pr6USXMqmBorvM4
	bL0PqV8wku0iRCKDHQ==
X-Received: by 2002:a17:90b:3f85:b0:369:7421:7534 with SMTP id
 98e67ed59e1d1-36a67765ce2mr23380346a91.8.1779908997496; Wed, 27 May 2026
 12:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527153953.27606-1-stephen.smalley.work@gmail.com> <20260527153953.27606-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527153953.27606-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:09:46 -0400
X-Gm-Features: AVHnY4KTUtnRuwsPsuczomC_WxGnOEJYLu7ORiiYAeRWDZnZCLelW8dgXSGek8Q
Message-ID: <CAEjxPJ4tN8HYEhaDArhJcLoRExcA2jOkx5+EPRswNJ1AyFcTTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mcstrans: fix after base classification pointer computation
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> ovector[0] is always 0 because the match runs with PCRE2_ANCHORED.
> If it were ever non-zero, the computation would be incorrect here
> because ovector[1] is already an offset relative to work.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index d12ea587..45935540 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1216,7 +1216,7 @@ compute_raw_from_trans(const char *level, domain_t =
*domain) {
>                 }
>
>                 memset(work + ovector[0], '#', ovector[1] - ovector[0]);
> -               char *p=3Dwork + ovector[0] + ovector[1];
> +               char *p=3Dwork + ovector[1];
>                 while (*p && (strchr("  ", *p) !=3D NULL))
>                         *p++ =3D '#';
>
> --
> 2.54.0
>
