Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516D47DF8D
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245526; cv=pass; b=W5eUrKTwfCz1l08c3gYv3ktlvarY6K6fVYdx6P7u+9WFoW63Tb9egoVMZwJ6YIWpvkG5hEg1YaeQpnjo9yrUIZuiM3DAHzmVn3CnIRwL9Pdiwnk/in+oQxm0PfFBSHXPOMihsTvZQIFIkVXkgWO51Qw7jPa34U9KzeDICOoqqL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245526; c=relaxed/simple;
	bh=g5twg+40SIfn365+lCd5i2COV9WDGOXrhyphCKW5ToQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3h2XnMrHpSkVEB+kAbJYycylg1NE7R3iPYOlzVheqJJy7PK73du/qgmq/+Wx3hc/GilMNA0eub48ywC/k6NsxMtmK48mlmpbYRb16OAC4FpOtVQR1HrxKBYVZtf1B0uSalRpVom//2VVUFkR0Pu5ra91VaD1DQ1cfhF5fzsTBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJMYeJK1; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJMYeJK1"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b136c28c46so118473eaf.2
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 10:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787245524; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTW0R6ponsxjE+vkuIlSleaPhuIZaMjkvqyg7jsD2IA2VGlev4YwgUnXKeweLZl9Ux
         RY76oD6Xh/zNBgb9i9FIzEdzV33DEZJHSMHRNH63X8UF60z9EO/a4Xtfy6ndygO3O4sS
         oEdczP5HS68n/aiUJIPTLbo4LHN7o8Gsru0EJ2ZT/dzvrPZ4d6FCheBJX3V3VBH9FwRA
         sK3Y7kH62tF61yy9tVAwqrBzCMUzYRObzbyEdxfi41mVvOWcM+OsEMmRvMuqRrcCQd3n
         zAEHThRLrTHbs1jldrWy/Zs2X1UeoZDorcve4C7Bv8iC6cAa6P9MA4JXR+eph+7JaY0a
         T/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5twg+40SIfn365+lCd5i2COV9WDGOXrhyphCKW5ToQ=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=eqe1aLm7VFL+hffO/ze2GgC5xwXDi5xN1Ljae/iZWXWhzXviYtTyqYX6ZdCclhRMEM
         Dob4tgc1c623l8hObUaB7Xo7YNkW3+URxTLAHNAGu7hh0bBJMIhbyeVYAiyQT+sqxhog
         /nfLVrecFaEix7AX6taIRLDfyCiyS3wdFpGeUHT8bymztCUnp3oy4zZPPqb1b9dPZmnK
         vBXq91MQIMok3wkt3cR9WmKewdoe043euCVlK6gpF9QZt0lRCyJSBK/pRT2Y621r6z4T
         54t8ISfqX46XVcrrN/MJWuAn2WrJhPuX1ubxVz2kYNG83IzOzBn9ulNIUbDpKnOcMKqB
         Qfyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787245524; x=1787850324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5twg+40SIfn365+lCd5i2COV9WDGOXrhyphCKW5ToQ=;
        b=pJMYeJK1CSz7hYxafgtBLYNxPbkOwfBA1z+sD1jhaiSHoTSA52XLHhdCyY04Fjg0d8
         mvFIhGlsb5bM/we09Ss021kUz1t/WM/SKrZeA6rXynTOwzOQoq2M3XP6v84JrDRhPvhP
         RTN3Kzv4o2uq+ZBQiNMpM0XgGWXh6ZNF7dpzs/FvsgtBIn6EkXunCdPDSJBBWaw5zK1B
         vKw+vm1yLKZD+pip1bFNnsH6IYJu/UwqSaF8Um5CNyovYCIFZEoLjGX35M70PSyZFb6m
         v8w37rOPH3fGqCp1wUfji0ueItT7dmXpIK233bfAiKfFJ8ZsUL4hmleOlJzlirRc6kC5
         +5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245524; x=1787850324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5twg+40SIfn365+lCd5i2COV9WDGOXrhyphCKW5ToQ=;
        b=pnuvbHP6CnzayAqHrR06O+okZxGRZE7LI5mrDM8fKe/DXuA9IFQE7o8Av5LPOu4uIb
         aLIJWLhmKc4c6QSuyhJSG5062OdmbnbgdlnGvxd5y6J+pYEEvbdt/X6H1V+ynsd/S9CZ
         Vcm2PwnOpDGI+bHsIQEUUgpL3i9izPR+V9/Te7WwAk0UtJq8gd0RJefPd2bjOrk4gWAg
         q3GK3v3L+QyxLncMEdTmZ6sSp0+cgqBUO/a6WqeS+bCVca1hTaLC2T9yTI094xdbtWDM
         z8Pspl484U1YsNwsbYRZcOxMQR58qB4kr+AbWs1YWy/d9XaLsgz0yoKFX0Uig+4Av6a4
         2IbQ==
X-Gm-Message-State: AOJu0YyYKkxL5r/ihID8TeALEAnnE2FSuxgrwDxkRPatsv44njw2DKuX
	mqvzvVQC8a04kGRbSfYqHQhSTr/qPtQ+5fzbGNxL+chQFPQIf89tZO6wQNjh83Q4X02/bgaKU8Y
	VOws9puVM583OjG7HG+sg120w+1LqM+nbi0If
X-Gm-Gg: AR+sD10b/mEiQ5Cwh2w6FKkv7v2PtpxqP6aeIGQC3fd0H6uT5NEqIRJ4zwiir5PeUfQ
	SAqrRZAagHVyk0XGckT6IHdIuQg9h9eCJdHWNNOOzg6osclx2HpnW6rMtRHVdblROD2GGqNpRfF
	GpKBl1wDPAlU0d0PHEiJy70MKFXSwkxfkV+lIjHnGJ/Rt19ToVYp7kzqD5NMnhbp5xgNZNMz96F
	5KlT1FgZnM0qqFhaq44O0ZbZtbqBDQI/orFieYERbhhpD3zZloHXTXmAGlpgaGIfFdg09aI38oj
	si+L68Q2OFQhMtAWXD8jhYgazmLxJ6f8/WM735ynE4SC
X-Received: by 2002:a4a:e917:0:b0:6b0:b196:99ba with SMTP id
 006d021491bc7-6b1593688d6mr33430eaf.17.1787245523887; Thu, 20 Aug 2026
 10:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820154143.12706-1-jwcart2@gmail.com> <20260820154143.12706-2-jwcart2@gmail.com>
In-Reply-To: <20260820154143.12706-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Aug 2026 13:05:13 -0400
X-Gm-Features: AcwNN1VXlLPEZdhFoUjYhGOXfSXa4pbCw0NSH81VtlP_ZTF_HU1dHUaTSF_bqHI
Message-ID: <CAEjxPJ74w9AbYe5DwwNcUuCZymi9Znw=1fVW=iampiv7Q0nzYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Remove assertion and comment from discard_tunables()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:41=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> Policy validation ensures that there is never a mixture of tunables
> and booleans in one expression, this means that the assertion in
> discard_tunables() is not needed.
>
> Remove the assertion and the comment (which is incorrect) above
> the assertion. Since the variable "tunables" was only used in the
> assertion, remove it as well.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
