Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C13D564B
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226660; cv=pass; b=PXYyapQwySVkKKqTWj7adx52EbnSdVwr0Mfqj0lSAhTPNSq/cJtWcDpb86wKDKfCQ2IGY5gzLT9ps9TJ6Oq/8pMKXrcYSfNT0Ebt7V4uQydkAv+BtJWa6hMLIyy6etx0QDumdHpbufrOhbFseBr6iHploN1Tbz5nZ03EWiDvbag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226660; c=relaxed/simple;
	bh=y1Bq6gFNyH6l1pG/2QMFYN9ADDfhE568GYOakzW1M4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixwkl8pjen14kVJImY1cCN65Xlk/SyU8MhtopUeCLsh2v8eEBat8Jknca3rSBo5LyoYGF7DC5Zfg+OkM8jLUdg/rTAfQ1in+z/YsiZCA1uF/mca22lz3URtADInE9AcP8fPonTN0/8Zh5uM8goazUfARdxJcfrohUdIs9ks51P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awB7zioH; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awB7zioH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so14728b3a.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226658; cv=none;
        d=google.com; s=arc-20240605;
        b=blQqUUSFC0jFXJ3LS9gRw0KHm3qTKyOyRRusT9kvmb5zBbM8GCEfVXTuHk3EDjRX1n
         DBE3Rcc3r5MyZQN/L16xAVflwZUJF7f1dxP9ibK+KMBLTWZz9RaLyKJdWCziT33LR8uS
         /XBYMUwxxN0HzjwA/YzK7SxZU2/AfmWrr0V/MIz9HRweySufSGD9KhV1WMnNXjfiqBs4
         fvrZnhE4Ac22N24tlcba+3PQ5dEXFXUynayZy0nVNkQUuVw09ixN/uJhiJrnl0d32jJE
         kRvICAL9/GkrvhmisOfK9KhBq6QGczduG5LWuDu7eIm6Kak47ZuLUl0PCBMV2HDUdNuv
         PGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GbfSMZ51Rfwc8OkttSQhZYId5X58njiDoKyO/iHS5E=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BUjMb+MOiukYxOUHFvI80t4Zc8puBI1pPzi+JHIR3LiuGyTwgWuAruGZS5QI0RKgvJ
         1yrEhF6YHxPZV5Kl3c3SHf7UNcS5Y0d8v4aaaq3XsdNmNUpkl2iB8+UloQMqstqTJ2C7
         AcpFk9AYYVlDZf2X1nGKhVjipQ0xPHaB+ZEk0kgIPHtc5S6rJYJmTIxbxhb1J+gBolM+
         JKakdzbMvWsod8Q1YzYadnpI3XUI2SMZKKAVHaftNPpYnRtmg19/E5vgTAu7SHvA5apA
         EkoMPwfU4nJ9O+7CSrikiZ+VMDDVaBJk9DEvxhnvBPYEgiyQqMWL6rBBZuavuGVbZT99
         O1dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226658; x=1782831458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GbfSMZ51Rfwc8OkttSQhZYId5X58njiDoKyO/iHS5E=;
        b=awB7zioHtzq3orOXwncKYi5QcIzLhRXUMrlRqQhUURQ7m5OdwesYyolEQYxNVvNDgI
         H+mYXqf++I8/DJ47ICQus2rN9rmQxku3dgBoCjXv5uQfdiS/ZQQ8rHLb9Co1ScGwGId2
         /SV5RkPpgKDnW0p7EWoaCbU1EQoK40pj6jd+2mNeX6pimOAv8NAy277/nk/D+aAjChKa
         OunyhgZyRGg4SccP8hQB53ECsyUW93kaxPkQsfD8frd5PmArPpInhQrV1051pg4EkzOZ
         fzUIQnJ5M0WKqeWL5sA/dZ3ec2FdkPxdYa+gvXl+k+wLPc4CBOFqfws7TK9Xh9Y2FISJ
         4G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226658; x=1782831458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GbfSMZ51Rfwc8OkttSQhZYId5X58njiDoKyO/iHS5E=;
        b=BJyVikmCX4TMuenxf07LWFAuU9X+4Pe1h8o5IW6hzVCk1+Z5gWs3rzRNGViCRBdp8S
         ZzeXOGkcSvdOwVj7n+wheh/wegly+c6xx/88sh0r/Ju5mJLD9SJOzkiyEwMd0n8fX3AP
         6CbkTNIA/dsUyfAijqFT63e32VVKTGLO2I9Wo0RuKEX+lXm3QHj9ZHBw0GkWtlZAi6g6
         2QW3HrHtd1+UwHuXm/edqJaIkHj68tdAZJsUxnRLZMv3PE0DKCfFYVfv8nkwK/c0GtcM
         Bjn3B5ZZZDgZ2U6nfnKltJSPAcsEVqvg6XsVQItHQhSD0inXUHB82I+/ZcBBNbC1Zf3I
         yRGA==
X-Gm-Message-State: AOJu0YzSGvy5ZtNZdwjAztu4J4UH/L2pc6iaeoU9H0mzyjyjKi/DCK2L
	EYI0XfqT/ffFyA3csvIYyF6t1GawZNikBFREtr+qGhLBOB73rGPCb6qbpyEhs+TnQXh9xzuKIo6
	son6lHUjY/o+4hq15Vhz1/G6fJyYKSy4=
X-Gm-Gg: AfdE7clPTyTgAs7B8aJaRyu6ujJmx4X6lIMoBFrddj6DBgL7Ln6q9177LoG/pMo+VZz
	eGIWLyObQ8FZJG62r5LzbfMspRvfGCuqRhtv8+HlEx1p9nzDWLDPTGNzihRmpDE2ZX6oCVUlGb1
	8b4IRtbDtjyqycsVAFzIO5Wc5SfWYIlGdaN0XBtOCzJgnMwNShv30Ty3DnGYbhTdiFWxsZaCrFq
	NyUjKA6BLC9iK1b/XvX+Gb2CjTk+CwdPfAXzzEgUI0bmcg87vpjPuZ9Lk+7GU2GI/I3Gxbv8J6z
	6cXYD8c=
X-Received: by 2002:a05:6a00:ac05:b0:845:286d:468a with SMTP id
 d2e1a72fcca58-8459709561dmr3887756b3a.13.1782226657926; Tue, 23 Jun 2026
 07:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:57:26 -0400
X-Gm-Features: AVVi8Ce4-yRp7NUZZZVGE7B0-lGsfhy9KdsE7CAOQ6fWOSfGmt95ZxWJn7qRSmM
Message-ID: <CAEjxPJ4EYo_jJkHb1wUonpKvjTEi=-+eLmApeR4y=_jEw7xP8w@mail.gmail.com>
Subject: Re: [PATCH 03/24] libselinux: strip only a trailing newline in type lookups
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> find_default_type() and customizable_init() dropped the last byte of
> every buffer unconditionally; a final line without a trailing newline
> lost a real character of the type name. Test for '\n' before stripping.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

matchmediacon.c does likewise.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/get_default_type.c     | 2 +-
>  libselinux/src/is_customizable_type.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index 6a09ca22..f689b4dd 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -38,7 +38,7 @@ static int find_default_type(FILE *fp, const char *role=
, char **type)
>                         errno =3D EINVAL;
>                         return -1;
>                 }
> -               if (buf[0] && buf[strlen(buf) - 1])
> +               if (buf[0] && buf[strlen(buf) - 1] =3D=3D '\n')
>                         buf[strlen(buf) - 1] =3D '\0';
>
>                 ptr =3D buf;
> diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_cu=
stomizable_type.c
> index 4eac6cad..124ee38c 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -44,7 +44,7 @@ static void customizable_init(void)
>                         i =3D 0;
>                         while (fgets_unlocked(buf, selinux_page_size, fp)=
 &&
>                                i < ctr) {
> -                               if (buf[0])
> +                               if (buf[0] && buf[strlen(buf) - 1] =3D=3D=
 '\n')
>                                         buf[strlen(buf) - 1] =3D '\0';
>                                 list[i] =3D strdup(buf);
>                                 if (!list[i]) {
> --
> 2.53.0
>
>
