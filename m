Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814823D2B1
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227840; cv=pass; b=mKaB9I2RrZ8UQBnbGIAPPQRkEzbKVF0gCWLs2cVWQUCF2BPrjc5CUGgZyFIgpMYWJVQ99AXd3H3+uZKv0Z2nOIK+C4s9DdBdCSo2LgZit66EnqsnNLcMqMF7NYK7KYBB5QaxZL303jpgp+Xk+A5oLcbmI1wGlXTvGSgZPa7nW8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227840; c=relaxed/simple;
	bh=IecTDI31cQ92Mljdl0R3nLyVBNwvkulw+FvTHA5N55U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oc8VUDksHil3Atphl8coNI/XqFY4GuSQISB4CT8iIVKgsYZ/vTuL2W2v6ImNQpfiyNr06j7erqrqC4IhR1nRVIQzgQS7d8lg1DV9VFcT37f/YzzfWy5EnFh9c8G/nXQ5ftUPWCU24HsNifzq2E8qNW7snUqecckq6xKR5THpEpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdwto06R; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdwto06R"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so22318a91.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227838; cv=none;
        d=google.com; s=arc-20240605;
        b=EJq+8/2bMvAfLRSI+1YB+0axeHqKmEHBCfolu7bhD9EgdGnVOA4b6mG4SQI50rzr0G
         JD+aJYy72QSMj+hLIDFx/EMqz4OS2BBe1k95xK3r7rK/u4qraJFsKJMZZAkYh4qPQU+F
         d4t2mqcFuB8qIAIq7OWj62nGrlSsOMRNFQQ/lLmwKDCXyeOl/HRIwimZf1a4vktGypD9
         WP0p8qgJ87F0OmjycqNjz6QECJn7dvbnNTTUs1vjBpNvZb2QvfVD6XERCo/fNbiMmL9/
         8qiwrSB/mwIyYyx2g2wXfXf8E15cyGYny5ahrsh0yqYuxMHtA1oX9WiGsVCrBdimQdDt
         8ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npVVRxEWTgzmYdafMEJEOy0pcnFmAuwWxu9W4ycfyDA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=hRFt3dyuhG8mSdN6yDyzGrcs1Echlr3LZpl3B+IBu5V0fbEyxWo1AUH6z+06ODTwii
         +3s/b6K1OZ9GObAGGIyQ99Y92PN6tpaXTXRKbYKVo2Y5JEp/XB50yq7s7qB/nXrJI9e4
         esDWQ7n0Ro7A2N8FfDD7PHwvyPOiE+oX6QJDfxlG0uFjjthN0ZJxnnS1ARKMu9PGG1i7
         OaAPXXZD07a+PNuaCXrQW581iDdimd9T7ylnl4NBe5DETpZ4kDG39bKaQPcrOzJxHZ4Z
         /4tpHo41VEGYqM7PRorlow67zRPe87OUwUIciW9jK05z0X+gVB0RYGuZ99vl09xQndx6
         kgPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227838; x=1782832638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npVVRxEWTgzmYdafMEJEOy0pcnFmAuwWxu9W4ycfyDA=;
        b=Xdwto06R2/AnHBTdLhekbWdzw836bVNBQwzwtgw1IMaDNTfK8l3baSlK3c5/JRBgU+
         8qmq7dW82VSZoNJuNy1Jc2tcZtkoLJL6ffhZVfnwMwK8WgeIro18bodPs456iSZFtaBI
         LR9x153C/udurrdj57gEQqGEqlktBhhBOPO7d8XSw/84zdhP4ghQE06YUiPJXLZF8JxU
         SHdMmy3Z5gzXNwYvYhrp9wMnDU89zlA+BU3lIKk2JuGO3DYcnP9cbFsd+ovT7kJXZeRg
         MgU+U3FTuIHNsUo7JdXBdwynDC2jKFgSNu9JWozbVgEjKUDaHQsHA1TrQoW8Q8r6HVjP
         Rv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227838; x=1782832638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npVVRxEWTgzmYdafMEJEOy0pcnFmAuwWxu9W4ycfyDA=;
        b=ZNTX8qYVofEXFZrFZCoCbIzu7fC0wxbR0nMxlMKOqhIXytcm6v82leUUpL3TFPDrl3
         QJuXvZe8RZU96XKVZQc/n3DYCPrNz3X2+5mKhmhLJvY0149JEQ+cFZoJRwMC501+FO60
         gDduzBJLzI4rxqDtwXgFZGJIQUEU4LFwA4WshZhhBi+gn6GbRVehp0LIk+79q3PW5pQo
         ePxB1EwxdS5MeeK47W/u0emZGJr0MVmm1fEADZn4AX027jSrdn0fF22JotdqSHXBb/on
         7wsccIMZaXmChAZ1EfAHk1HCFsyTi9hAPPKt7YpoAuL5XE0E5A4GocG77TaOozlvpmm2
         60Rw==
X-Gm-Message-State: AOJu0YwpulF/4g+ZC0QFVk1cDFPYPHdnoTXFIUOtOs2tMZKr6BkxxPK3
	xLwWIozC4pUhkeG51IMzZAJBhWYUYqR3CeoqoU4nzI09HKZpCTnpavodIoapbLUnL5EsjQ++Cjw
	TxJVR3GYjYgnMAuN341DEMOz+yUGrKUKtCrCq
X-Gm-Gg: AfdE7ckjixqF0YVCiWlsaoLwDPv+sZcageACZS3YTfoU8EhEqP1W8RO+4tFJ1TEYbDk
	OFHzdA+iw6WXXJXUBjZy4qSYOEE7L2U3mNj/PdCyg9Qrv8BFB7m13DiLQ2x3ZhLbMLwbUBkt3hN
	paivksY8UCfBniiwXggtLUeToK3POMJkNJUz/XU09fw/IZpFa+Df/H0v4WlhvXgh9zVlkaIYag7
	ASUamfxIp4rHcSbOdjpzXb8L1FQhMydMFmP6xE6jtziIA0rHpppVisAtS41j6NxMqXUrFDw
X-Received: by 2002:a17:90b:2fcd:b0:36d:8e49:d8 with SMTP id
 98e67ed59e1d1-37dd173bb8amr3510585a91.15.1782227837829; Tue, 23 Jun 2026
 08:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-13-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:17:06 -0400
X-Gm-Features: AVVi8CdKoYs8X3mXsMBfn126xzlJ_w31q4SJ-UdELnXD8iUP2pu3O4mohgKKGSY
Message-ID: <CAEjxPJ5DU-cQXcfMG3sXTsHgyZwcY1SdGNLUAYQgMErfETLB5w@mail.gmail.com>
Subject: Re: [PATCH 14/24] libselinux: check strdup() allocations in getseuser()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> A failed strdup() of the matched line was silently treated as "no
> match"; bail out instead so the failure is not conflated with a miss.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/seusers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index e4a844df..d33e91fe 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -305,6 +305,8 @@ int getseuser(const char *username, const char *servi=
ce, char **r_seuser,
>                 if (strncmp(buffer, "*:", 2) =3D=3D 0) {
>                         free(rec);
>                         rec =3D strdup(buffer);
> +                       if (!rec)
> +                               goto err;
>                         continue;
>                 }
>                 if (!service)
> @@ -314,6 +316,8 @@ int getseuser(const char *username, const char *servi=
ce, char **r_seuser,
>                     (buffer[len] =3D=3D ':')) {
>                         free(rec);
>                         rec =3D strdup(buffer);
> +                       if (!rec)
> +                               goto err;
>                         break;
>                 }
>         }
> --
> 2.53.0
>
>
