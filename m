Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA8364953
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908959; cv=pass; b=KSsEzuTmqH1t2v65KwcsJjYsCY5egItxAHt3GKUhh5vGLWKILOw7+1XXft87iVQ+M7w5YTR1BvRiWCHCGbxsPkkUO+JZIV37VcdktmPmuQXD2bsse4Yd1TZHMjoGFCQotSEIBOxHkp2ZSDFu1iJM416hbcariptmiezIw8EIoRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908959; c=relaxed/simple;
	bh=dRD32VCNKlgPvQ9024rGqlEa2MvmG20+ikitH0scLxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI1f9ur09lAD1PEoM2qc28n0PVpOWAUn62l4mXky3iDXaStXiL4lZ++ftm/d9leAeTyHvLLML5Q6AxStADCFfhoLwZ9omtluf4TCzlwVIOOZdapT/yYC78TJ2wZ62dBS66xUOykkGIuqdNwUJ4IRmNW4F9nEKWT70KmugcsAxuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVjjrs5B; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVjjrs5B"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-835b78c3797so5347159b3a.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908957; cv=none;
        d=google.com; s=arc-20240605;
        b=jsqpBiWDy8hs/x3l+BwWTEwMnkyG9WnSsHA6HTEv/MbPIpGuI2IeayT5HAmIWgoynH
         mOUHZsprceylFmrxhzy1qfkhLXOBX8PIhpbhMlUq02l+k5RAou/ScWT4IaL8KW6SZRfT
         LXKhaigYJ85EQcj43RDLbjQGYkhrh8AVWECCEF6Ud8vr8bu7/fho6IoiNiv0el0z3Neu
         E5s8HQ7FDuXzYTelg5k0NoTWSjl9XLeAmVPUFTT2gt75pZ795O+qkNAOCwRYYQh9EeEw
         xGL/otSsGkhInKJfWKRnG/N1v1dOVLjXATXx3hVR8mLwrZnFowdylEbnxZ68anyTj634
         Jyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDTPfOgrCarSJEFI1TRVPx5xXSi0YbFUWeubApup3T0=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=BNrnpZGbyguTa3SlpZ3X4GtrXNiJu84FbrKBToQ1iA67mB+c6Z/PYflcCFpwP23Wvn
         fgGqJdCz20D8owmspUBIP74f5vrESUywRDO8fPw0h3ZAXnay+DQ1z/muZTgL9m6KhwuY
         3+wb+U2KKbjImYFlLBuGtkeEBIGOprb8E1Ix0oz8X7UfXRYoNLGS3lKiC8K/3IBY2qDh
         oYne5g0Z/bKAXvFaBiMm42bFl1BwMAasi/DSncf9JKFX9mjuX3DdB5WuTnNru6VdCcbN
         pn+fd0w1cMGOYl68kAYpPYXM8jevlMtzSXuYrpUsmQLfFKC6poxASSt3HAwG/Y/L8NU+
         beWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908957; x=1780513757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDTPfOgrCarSJEFI1TRVPx5xXSi0YbFUWeubApup3T0=;
        b=SVjjrs5B8Ya0EAMdzSi5DytzGy4v0aoOnEUQpKyVf2kLT6l5Zxun2VlGnsdKrOOWBW
         PLf7u5ZB4K79TxYEFReZvrCdImQNnESH8x3aUTqZw7NmYyfHqL6/Ue/O90Mkp1IlJZXW
         lW2XnyB6OWiSIPyVivQhM3X3qSBmucNoJpnbua5MpkenSIeDxcQX46GvI/2zgk0NrNYa
         D4r+0SK5omcuuKE/fDH+eLkqrIdLAHHo2HhlCFNZkqU+X64jdJT7+c97p1JeQOPjiN8C
         /NcvKsx8YwX9NgMAn0a8eyCsrKL/E/dEVsUCO5qvK73l6c0/L4u5ADsrh6N+2NkEBG0h
         2VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908957; x=1780513757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDTPfOgrCarSJEFI1TRVPx5xXSi0YbFUWeubApup3T0=;
        b=pBo2BV55dq1dYGHh3+Pi3zv6sSnw4s/KQrKqREUGefzV/8YdHIII96DlYbz9QMDcAP
         iExPUjo+ydRLffuSJFlJwVzFLK2XWvFbQlU4SkrklQzYanXL2dv7sGULgtSL3Lar+bNn
         52+/eD+DI5GaGhlQMlDAu/jLvUQqNaEIFYDkB/25MOhbEbZN7dtuZurH6mmDszuTJgFA
         aBWVc06gVJR859kOA/EYLDgrKAhQitEtc05eDMtUMFT+34E9+LMlG0BMBQQ3F7nFZttF
         Tgp+vweSbaYCl6B00ggtggdkkHzpLgJ1+UAs1XFe2AoAhdmRFxBMlJ4WcKuwn8utstr7
         60uw==
X-Gm-Message-State: AOJu0YzerkWsW2JxL3nN8qOdXELGHB5cbfzyNTDb3sRoswwSD4P4uh2t
	coDXKPsCYB2nVw1yeJvwYZk3BJ3mmmlJilpK9jBaSa+3KdSw+r4/1dVR0XUYmVZ9Fv6EiyyCDUn
	4EPbei9qcUvj1xms8rYsAqJAa1Jlsgsf2KOVb
X-Gm-Gg: Acq92OGgrbI7HWvZqB/1YLfQAFGMR1RkJlxt3/z5ymLbEtjmfW8VxKISss0NDUTIsDw
	K9TYVAs4hHZniosicHiVO+BIeoOr2K4/DKCYGCMBi9l/R1YBwThKY/Aih7j7AXipivthjPnT1pm
	HHOgfcH6c9Ra1GkK4qSfIkxYn0MWMuCoX6/hZ8mokXwOwHucVWhVp4IROn1q2hfabzA7ZOLs1qV
	p7Fd/0dky7QITXmITas/zfYJe7hzgpKJBvuw9CFg0km9y9NhObjDet8OmkC2jFlDP052lTBGhGs
	UOhlSNzIOMJKCMDyyQ==
X-Received: by 2002:a05:6a00:18a7:b0:83f:2568:d466 with SMTP id
 d2e1a72fcca58-8415f30a0demr24643586b3a.31.1779908957450; Wed, 27 May 2026
 12:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527123411.26088-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527123411.26088-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:09:06 -0400
X-Gm-Features: AVHnY4Ipp5wXeVWHXSp8NRoNoW4YXVBn1glYh5uIWp52wZ6qY7URcfwmVmXdH-Y
Message-ID: <CAEjxPJ7-9PoKUBOg_6Uuozo5mUx4kVMNNbCCCE3PM22bDqYjHw@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: cap maximum category bits
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 8:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Cap the maximum category bits to 1024 by default, overridable by
> defining a different MAX_CATS in CFLAGS. Only update mcstrans'
> internal maxbit value after successfully setting the bit.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 1baf7ba9..daf9b7a6 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -46,6 +46,9 @@
>  #define log_debug(fmt, ...) do {} while (0)
>  #endif
>
> +#ifndef MAX_CATS
> +#define MAX_CATS 1024
> +#endif
>  static unsigned int maxbit=3D0;
>
>  /* Define data structures */
> @@ -187,20 +190,24 @@ parse_category(ebitmap_t *e, const char *raw, int a=
llowinverse)
>                 }
>                 if (sscanf(raw,"c%u", &low) !=3D 1)
>                         return -1;
> +               if (low > MAX_CATS)
> +                       return -1;
>                 raw +=3D numdigits(low) + 1;
>                 if (*raw =3D=3D '.') {
>                         raw++;
>                         if (sscanf(raw,"c%u", &high) !=3D 1)
>                                 return -1;
> +                       if (high > MAX_CATS)
> +                               return -1;
>                         raw +=3D numdigits(high) + 1;
>                 } else {
>                         high =3D low;
>                 }
>                 while (low <=3D high) {
> -                       if (low >=3D maxbit)
> -                               maxbit =3D low + 1;
>                         if (ebitmap_set_bit(e, low, inverse ? 0 : 1) < 0)
>                                 return -1;
> +                       if (low >=3D maxbit)
> +                               maxbit =3D low + 1;
>                         low++;
>                 }
>                 if (*raw =3D=3D ',') {
> --
> 2.54.0
>
