Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB93E0758
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975308; cv=pass; b=IDIIGNjLVzW9T2DGuWOLFMVtYuo3Xpb/IhEAtOqywyeB1rwkFXns3l7PhqAhUtgvb2l1cXmAAr/QLCDaQzQMUFfMdOrPpTs30iEcUgT3P5JCrSdO1fsaKzBFVOk8TJm9lIeq0oNcwt5/zzTkhAsVC9XUtd81FdmxcZw/GFWICMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975308; c=relaxed/simple;
	bh=zK2I9M6aQNsrm12gX+RuiMocZLGaUOdrf4hO3hCx0RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V77+7TPC62ZTMJgt36YntoIEFhgBZjsYzN/x9VqqdmrkHaQl6KrQa8xkE8mQu/tXJivgr4cSexh8Bi7V1LtYT5gxatHUfjFgzay68vjBmm1kFK8oK/sCnkb8j/uPWDeDd8nrP4EZaLf2Gck3dqeanzd0yL1/0nmWO3F3k3gQzoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2d1Oa3I; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2d1Oa3I"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc85eda6b6so65105195ad.1
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 06:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975305; cv=none;
        d=google.com; s=arc-20240605;
        b=Pg3+Afd1IoksTLeumiW7c5XUKkflCVRYeGr/FZMe1tLpQ9qw2p9Nf4Zqc0+ani1g1u
         BQYEE7VXGW/EvrxY+pK2+gzG7yb9I6CVBYw9NoOYXOOEZyel33q+gWh3SQqNbMSJJgXW
         WJHL68ufxqOUGVugAfWmV9D3chUChiZdvtIrYiZDMIeO70J5c2sgdTVWBqKcE1/jUsMw
         cfrsq2bYYLaOcXDbc4/fi9A2tk92xwO+JAok4RFTDKyd0zCxO7zWWogxgu48hXXnI3ci
         EX4eReRAMvislXo13cB6VfcPRdjtH2ngl3rEwaJBorVuZnSIYECjdzLVODbbmuY0jhaM
         CVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJTT65kxXQ1/cZFaV9zIpChzfGqoCBldpoe41MJjbkA=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=Rf34yAS+KtO+I1mVtNIL8z0lZgIrHdDq+w1urKNWfzbzh2S4ue+dgpauWnVmMNHwjk
         eh2TvUCF4Gz1wqKLx0HPxTIXkLcEk3R/CwlpfqOBwwQTlUreBbeTDmCf8xpPg62/4HJv
         DHZlZVPqE85UH/VeRkbjXkSkGxcaJUJFCljexE1gXsfoHt+z4dZTyRrdG1MwUCA5KSq8
         qI8Eh8hjcuRT0na2YpzhBl2d8q31NMIk61r/gYZrD+XsJs6EzKZ/EgUcAyN7cz4wqZ4+
         Zw2yu7W/GlJpSKyvbWV4jNbSQ0ZeAfN2KK9M3WsVC8OZJqxgRQq3DZvpN7AXR3L/gm7+
         s0JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975305; x=1780580105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJTT65kxXQ1/cZFaV9zIpChzfGqoCBldpoe41MJjbkA=;
        b=P2d1Oa3Ilq4MmaZ83CM5uoM5JtWJo3ElNugspcWlR8ofdZe8p/HSEjNqoW0a1wJM5J
         yCLUX1EsuZklE3flMBRUM3b1kCMy1N4inqhC/vCD2D0kdIlI9Kg2MbHirZrKaGTBrRmH
         2zhWNe6BZTpXI/sw6bifIOFF0T3vmwwSrUFEY/Ywuc9FgUZiIcAvuZUMbOdGLC+RrotC
         rM5rt8v4gKXYbEJatz5n/7uYEht9t1jrcE1m2YWiWfByVG0obujBZ3ZKKyc19fYuHdOo
         ly1Tm5XvM9m/45nwjp55H3QleJpGkyNYf6Pv4B7eoTsjJu0qs+K3KHR+f0PvxlDOh0S0
         bFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975305; x=1780580105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJTT65kxXQ1/cZFaV9zIpChzfGqoCBldpoe41MJjbkA=;
        b=jqfnk9ROVEhW4uFKlJH6/A12WvLzZnYFGAzs8Ja19fyYq49NhIaT52Q7iBniB5Mrh1
         jmpE3o08UwVm5NWWMHLw4BxqCskRGFAICOgbIiJWtcq7z85Tz5nJGlw/mNPtN8qLO6jb
         trkyj1LoLSHKuT/egsdvwzQ7vykIqyF72YAQgaOXi6jto3BUU86tX5SPv2gaduyySvSS
         uHtnwRUzA4zZ03aUahf2Ll+3hfTKa+kz8+JS6w6+NJzapKNBljQG1UkRkX6/6FcErCt7
         1mjYTeKzPaxolHCuZsgvQRpgOtPONj+WGG3Zl0TfJWl72ZLHwtpL/Fb6O9DHdenRg8C0
         2yrQ==
X-Gm-Message-State: AOJu0Yw41gGzRc9FKLAs+l7r+i6l3Qp4kwsNuCi+B56NWo5Ia8ZZeTBh
	Iv1l9bHvjWZ2Hgy0FgsMacoNuQv530LzCCkTOP4fFRBuT2kOriAiOoRsy0NwHqSz3BB2MmFX6Y/
	P2OwQ3d0Holgp1Ir1nrGBKBNmY8QJf6v3YQ==
X-Gm-Gg: Acq92OFnRJGRTbVv3681gBIxYHDmOdDP1QNdsQ3XAiMRC4wK+vav9bRI5QSalXJozjR
	+ttynblHkN8lQNtfl5kEEH/OrCfO6BmNpuatmsjZVMfwyWYIT0q2Eu7VtL7H3iFNiuZTNd+XEVE
	oY45cGuhHN/Oa0Fff1ARpPQdYoNdGG1bnXB+nOAYVSBmsrB25KcagQMmx/mlmpjBfRZUmanUk8H
	KsnqPIJkDAVHWKjav0J25jFWeyDyPARDiDIxDOUXbmzBMWeQdWWfz3noxtEbyr36DeOx+2RAVDQ
	yyLMKbMvrfNnibDXdA==
X-Received: by 2002:a17:902:ceca:b0:2b4:604c:ec6f with SMTP id
 d9443c01a7336-2beb069853bmr303950265ad.32.1779975304909; Thu, 28 May 2026
 06:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528123020.35148-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260528123020.35148-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 May 2026 09:34:53 -0400
X-Gm-Features: AVHnY4IrhZGAGA52sOEpCSe09vv55DDOvDB0JPp-Y_e9c7JV0i6ZNymITTXYcDY
Message-ID: <CAEjxPJ54Vv_xupX9_CzHBGG5rpr0hFJN617ywLtCdxxKwHueKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mcstrans: fix off-by-one in MAX_CATS / maxbit comparisons
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> For a given category name cN, N must be strictly less than
> MAX_CATS and maxbit, e.g. if MAX_CATS is 1024, the last
> category is c1023.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index ee99a19e..ff33621c 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -192,18 +192,18 @@ parse_category(ebitmap_t *e, const char *raw, bool =
allowinverse,
>                 }
>                 if (sscanf(raw,"c%u", &low) !=3D 1)
>                         return -1;
> -               if (low > MAX_CATS)
> +               if (low >=3D MAX_CATS)
>                         return -1;
> -               if (!fromconfig && low > maxbit)
> +               if (!fromconfig && low >=3D maxbit)
>                         return -1;
>                 raw +=3D numdigits(low) + 1;
>                 if (*raw =3D=3D '.') {
>                         raw++;
>                         if (sscanf(raw,"c%u", &high) !=3D 1)
>                                 return -1;
> -                       if (high > MAX_CATS)
> +                       if (high >=3D MAX_CATS)
>                                 return -1;
> -                       if (!fromconfig && high > maxbit)
> +                       if (!fromconfig && high >=3D maxbit)
>                                 return -1;
>                         raw +=3D numdigits(high) + 1;
>                 } else {
> --
> 2.54.0
>
