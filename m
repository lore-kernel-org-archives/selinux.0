Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110E38735D
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724490; cv=pass; b=TUxkK435zf6HPGhWKfoZQhft0aSf3MSr1ebzurPS1fYOyy4rAjQLqg2ibZMDmCM+9DkhRfzeikzpmtkENpBxtQWaAdsbyEjzKlkFVhp8YMk7HXTCTKl37mqYY5MYPn5272rYrRRsMiFpovZ3/NhH/613Shz2O65Xv+s90KZqAE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724490; c=relaxed/simple;
	bh=mX7pX/gyDqrGl3uZhK2jkjvsI82bY4DTXtvCttLicJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld0qBtFpzN3g2GVuzkHWaUgNJJpYlpzdFLDXCvMQTQ70fyK2qYUdB2+Mcn6IhoqR43ms3q0z3KRv4HJFu53ZattVdZwYbxNZXkvBtQd9P4F1GeasJemxd9GeXPGuaTgVPm+AEOfxZYjLFunNDWbCTDF9EwUc6A/qZsxdhnUpRko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzB6bu7o; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzB6bu7o"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so118767e87.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781724486; cv=none;
        d=google.com; s=arc-20240605;
        b=RvSkY3bAL4QEn+ZcJZoZndLsjD86cE+UqJYKtuRRbhWy/Hd1yw4hEbMnpUnb3XN29d
         A2HZ9l84NeOGOjS86xkUDo8wBnJG6FYfUNKwjsb4LzAhLpgcJUyz/sCyh/L+PHpN3vnq
         /REiyMBPbVIym7WUoeK0qN9hu17qaWuKvLsFaJVPk6+7CQBL8WlNWSQHCrsab4i+z0uL
         mtF0NK2g0ruzxquwVw2V56EXyLHajaX+sA+1tZzgUoTYFYCCL8AOBYrV8es7Hofv9ZET
         0Z6eb5xW8SaweXKrjF2rsOU1pgvVbqSiF16TiFiVYhBWOCMCPYKrHDAGvanJ+kcOqoZj
         9k4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTE0bHcGiq2aIu+Tg1an+CNa9fV6ic0KhZk2mziGzPQ=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=DFKyLMJ6tmcsM/GMB1JJVuX/8e+tNMXE1b9IAaZvHOySM7LgbymSsMSzM/SQpiQGTu
         2UMAxJ2Y88GBmcKhKNm383S0KYeKKTyGf5D0yvj2Wjc7+J7P85hLElEyhYqRvAqaflMh
         lXG27JvpYhX0Ge2IBsvkV/PuV2crCqRiGjouhj8hTshTfEP9QIt8CGwnYjKOEeoC9NNn
         Tl4zWW4Ne9C2Kf7GvCi1+to1t3ZxqT+8wvI+3eGFA//ko1HAfbSM3883qf0pAz82exV/
         z0gSm9+GX3dXRN1f1CmpRVJf34PHeOGNt+PmQooP8MEP1C7NeBg+To9855l//3U6SmlX
         GFsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781724486; x=1782329286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTE0bHcGiq2aIu+Tg1an+CNa9fV6ic0KhZk2mziGzPQ=;
        b=LzB6bu7oZOwjnBqTsab8VCCvAzTJabB/NTcw7ryEcZck04f0apW3Ps+2hMxyF34sgJ
         IUCbP5kIGMG0rVxFBCtq+NTe0GjCpMY60xay/N8FuSf3obdulVoWx/KBn8D+SergIg5+
         CUtDJuHXf3nMfzeDnTVZNC/hAyPg8+Go5nGBai4vj1AgCsnlvXEA/EiHBqGvN3oCmfG0
         5Tr5bAEmt8rVKoAoW4u37bADN/APiREnSER7u7LN1wwwgMAZEeEEvPkgdZxq5fslBU8R
         O9ZhWLOcsUN0HIWYgRfuxX2Th6JiVbYy50J6gjNl+hx7dvMueitwcnYAT7TQxjyEoTUq
         WiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724486; x=1782329286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTE0bHcGiq2aIu+Tg1an+CNa9fV6ic0KhZk2mziGzPQ=;
        b=jDfXtzjZG2jIONMVxnUGy+i9iiayVCH/JgiII+wY/5NnN/v0lqD9BWyBcUuMNgJpzM
         YLn3nsBmyDoJnKUnarO3qBofRsF9+ThsGZhwTDB+9K1D8IMbfCG3NOSbRlUP1RWrcIE8
         vL3JMjz9QMlA8BI037hiIEfpW1iQcVwT7HspwtO0OCGV+sYNUawbDv/VniicFBG6SCV3
         efNeFGW3G0dem1c/kCOpC9pKlLzYOtM2V3Zyxjg/oyLK9EawBxuyR2j3OxVGX9jRFto8
         dx5ysiOI3MMXUMr7YbkKUBWRG5OgJYPwZ/qsWOuKPalsioNPq8Q6CRbBRB5Fx6NrmsuR
         pcsQ==
X-Gm-Message-State: AOJu0YyHfx+Os8pk8uzY8mE+pt6/Xfu/uyhF7CYufACVChjkJWEdQdKz
	CXmYEzTOS/xzWvKIy4tNm6Sj8VcqiVc3tw0scBuaIOlumL2nzf0riQ0QXjX2ATsIY6kdTf0ZaPf
	fhKK/SV+axGDq/xiYuYKM4jFt1DCV3e7hRj0H
X-Gm-Gg: AfdE7cnYDlSL3Izh85QKTr77WXQtaOIXvudqXApm60KW1rlPxG2G0K/Apj4WVHb36Ho
	uFWBDyUPW1ufw+hWB5q2UO5+u0EZmmvUpLyf45SEjWMXlHryt7SftGQfDxViCqFVr55Bqt8LinC
	lrWdxejLHgsI64v2grkWH/MMhjp7XGnHSr9dMW9M4B1V6ZBbCbIOv+LJUs5AqTjySDgR8YHbYRC
	c06ZBsZkswCuD0GGLeg2xx1zZsBfYIWAX9bFHACkA2JasobG6+34+SZ65hGol+458qJrw==
X-Received: by 2002:a05:6512:234f:b0:5aa:75f7:f01f with SMTP id
 2adb3069b0e04-5ad47d9bee3mr1513883e87.4.1781724485430; Wed, 17 Jun 2026
 12:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616161418.62569-1-kalevi@kolttonen.fi>
In-Reply-To: <20260616161418.62569-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 17 Jun 2026 15:27:54 -0400
X-Gm-Features: AVVi8CfcgP8hj1limOPatb_FxCXRdvxBB5Kaec_nAIGVf6iELOV5lJiXy88caYE
Message-ID: <CAP+JOzShTOCMYodDcyC73Rx0EUkGWk5Rd=D1SOA45gSQ=vfN7w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Add missing comment to context.h
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:27=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/context.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/context.h b/libsepol/src/context.h
> index 525c43df..7c99c9b6 100644
> --- a/libsepol/src/context.h
> +++ b/libsepol/src/context.h
> @@ -13,6 +13,7 @@ extern int context_from_record(sepol_handle_t *handle,
>                                context_struct_t **cptr,
>                                const sepol_context_t *data);
>
> +/* Create a high level representation from a context structure */
>  extern int context_to_record(sepol_handle_t *handle, const policydb_t *p=
olicydb,
>                              const context_struct_t *context,
>                              sepol_context_t **record);
> --
> 2.54.0
>
>
