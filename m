Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091323B27CA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669913; cv=pass; b=crjux12G+T/exN92z8srMPtLw/WHb3hh1DPDIuYaya9OaLoMLN0ssjo8dXDBIvBGQKR00xT4IauEzqw/whVvLsJOHwhmJ6+f+7YzX58t234Ru2E5f7vTFAjYsWmo6/O7KU1KsBiqnBzmsdpayCgINapAALBtVfv62/s8aBkloZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669913; c=relaxed/simple;
	bh=fq+mN1R5ElNqijWix3JJImc4EFqfLNcSSy3VNTTXfjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLsgg+ASZaY2Urz8r3ougbHT659nrHxFGGk2FH7BkUn8V1khbsu5MOMD9fqliTCRMm3jt7wYRa7fesO3bvB6Ew58IFKqIFHn+Ue69F50LVliHl56SwmtpehYeWGIXbzQ8X/AyWTWNH3WXAoKgpcxuuhNxjaf/azHFlOcQirMSbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWtPHBCO; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWtPHBCO"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39677c80386so22521671fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780669910; cv=none;
        d=google.com; s=arc-20240605;
        b=BQM5lgEkiPkBBsn/CPTWzrqaw3tWZYEpWeKoJHZdM8H8dcvEnv4D6LP7Nm30qfKZPn
         Zpxlm9ooLTZa73PNJIspK4Oz69oNB5+glDzB9QThgEv34fNkn9kfudhx0+kUHJoTp2Yz
         qFBMPXMfgMM2WbhJp0Ik9iWyvW2vF6oIOqeGAksTqyyZSX9GMgsimMhZD4vU1ZaW+SjA
         6u+Ll3YV5UUK/uvc/V6DtKuloXw157eW2R+X3uA5iQ0ZfXDIBD+Ksp1IVyNiCi5KJTaW
         J123Ab4sq57Ec82s4ZkAxkkqeLt9NaNZL8dOsFNImzqZHpYZZKg4j/8N44/DcrwPIB6d
         PkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FE2WNqHsooFGzmeB6uE2YHRsHxyYn+8Jm9Ncs7nqlbE=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=CG0/L4qSBaT9nB5Nsflo5tobOG0uf20xGj+KanaZLSzLS7cPKIgcWxL2wePkHID4Jl
         Flqs3lUp05QaUIjEGyGepj/dWuRfv2RfcWDA8yoYK8uEGChwdCm4SLXR05FipjL55HKi
         qSu7R1JyE0CHAhvlI/nhU1INXMQ4u39hEGGdtv3PNPgk7AztfQ2Hl8RkKy/MAb0mYzez
         CFrtOJ7ER+ibztTDCb89Iq2qux76iZ9TZo9zitUsGHmMEJ4oxL0+xqAhl4+UWw9dZAWr
         OyweR2Gx1cNvUucrtnW4hgSlnIiwOm8JHzNmeVzW0ibxMdpPH8yEPq3vszLStyKQoprk
         4S6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780669910; x=1781274710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE2WNqHsooFGzmeB6uE2YHRsHxyYn+8Jm9Ncs7nqlbE=;
        b=HWtPHBCOEIDEsW+NUt6d08j/Or9c6Wr4eyVqjVHobvD+TAW02s6vkRROPHeBg8kTJH
         v+TmDh9pWQFKxm9/iOEMpCPVjhoyKxxc58OpKjME1wPfmryXMTHfn7H6wS8i6/dc9VE0
         PfI4JAK4Uh/Wm/P4+moj+qeEQFnIR42XgzNbVb/RYLnbvOQ0dqabeiZz3CC2rFu+sYJn
         ul8dtgXRjq/eEGg/Trha6vABFoo3/alRtIeOMwjKatVZpR3nG7XvQWsVIF5vpT5zeq+V
         yzVSxDjqREG6Ah8d3H32g9+3gZDnZPJDrxa4pS+Mjmk++jXxkebCUQDN7PcYJXywDG50
         7z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669910; x=1781274710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FE2WNqHsooFGzmeB6uE2YHRsHxyYn+8Jm9Ncs7nqlbE=;
        b=p09EGR1NkMK7l6cR8YgEFM423Pf2IZJOKfJ7jRUnKsL0Bo8JeAFzbK9Zy43tM0SASs
         DS0f8Zjh7BfEoC9xldn6/HrOPVcMAdAWQpcaAs1ijsGElzqn/L1grD4TSe/ySKzoQ6YU
         MsbaQcY9rVdymvG6BuWJqubDfW4CL7QEo48ek8ebt3Rs6W9QDHip/mNootsMMc63YkUz
         FhicCwfQrEwVlPT8REIyQZ2oj9MltXLNbBl6mpZmXih8hxKciRdbSbGUjsZgdUG+g8l8
         LlzjJgGa0NuYqKGAZoqC2nYwgLV1dvEHFohJzV0RAUTCIs9Zk3Z2cInSbfBAyKs+3aXZ
         9iDQ==
X-Gm-Message-State: AOJu0Yw/T4/zrZkkwZqZyJ7O12PTpsCwGfTsOMgzpX96lCvYxQYs2432
	R33xNq3SeN/b+/wH5BuL7l7aaePuDKcL7MLggFjbtr78ClKR/glRnRKX+lEsVuY23AYyvnEBTZp
	LabH0ZQkhWlrPT1JOrt6/BcRgEEOkkdn5ld9F
X-Gm-Gg: Acq92OF+wQWyGw9PtcY3Y6Y7CiXMp8zzyqzbO+OIkQcQ5mr256jpKiJPgVSGM413Dku
	AFtzxuPduuAPVAbthIFrrdTnUBQ4acMjV7iPPzS0jYqCingoBMq0mzt9GzzHN0w7qVEG5kzE0pt
	1sPSomFC5wPLyfiJesQcL1Y7wszvdOgISnxcs3PJ3T1Mc9m9kBO0yNbuif0mIj8IxtldGS3w3IW
	qwXVoeqiEnVudrJsjgUCr8oNyypJIrcCknMznEKgrF1tXZ7NWHh7XtHqRELN/YiHANw4N6V/pB0
	aqwGPtIx+KIezs0NvoMAyiHrYw==
X-Received: by 2002:a05:6512:3e0f:b0:5aa:8822:f27f with SMTP id
 2adb3069b0e04-5aa8822f329mr1062822e87.47.1780669910061; Fri, 05 Jun 2026
 07:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171837.263447-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604171837.263447-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:31:38 -0400
X-Gm-Features: AVVi8CdWxJ6bo5Ipk3P3izZsxEm6QSvg39cbJGQviaG50Ck01JWKBZohkmlFlDI
Message-ID: <CAP+JOzRDg-4nHbtkXY8mfCx_JcUiC=3a2oZ7AmwaY7nY48EdDg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon_xattr: clear dir_xattr_* after freeing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We need to clear dir_xattr_* after freeing to prevent potential UAF on
> a subsequent call to selinux_restorecon_xattr().
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 224a5a33..10807867 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -2021,17 +2021,17 @@ cleanup:
>         (void)fts_close(fts);
>         errno =3D rc;
>
> -       if (dir_xattr_list) {
> -               /* Free any used memory */
> -               current =3D dir_xattr_list;
> -               while (current) {
> -                       next =3D current->next;
> -                       free(current->directory);
> -                       free(current->digest);
> -                       free(current);
> -                       current =3D next;
> -               }
> +       /* Free any used memory */
> +       current =3D dir_xattr_list;
> +       while (current) {
> +               next =3D current->next;
> +               free(current->directory);
> +               free(current->digest);
> +               free(current);
> +               current =3D next;
>         }
> +       dir_xattr_list =3D NULL;
> +       dir_xattr_last =3D NULL;
>         return -1;
>  }
>
> --
> 2.54.0
>
