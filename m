Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C62ECEB9
	for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970095; cv=none; b=udmpiPROAXggSdR5d89Cc1A2rMzzfLMb8H1pMDKUECwaXvEYCFSFzAVwzyEbxMuuOwpVLGZfGLS930U8SHsA+FwjjzPGaKLmxjni+SJqKOMHJ7sQz9kWm4gIeEgM8TKfFe2Yd3bUaz32PCoD0DK3HY3F0HAF1CS0pkWJ169CJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970095; c=relaxed/simple;
	bh=5Sei9lyUWSOLhlYdKRw6PW2wVc1AbAWeD9H0Czpu0rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOCwc9gdYE8eKS+V/I/9jKMq66BD+h0hJ9cel60z9EbdLn62GMr8uUr2RWbwcLTsLhH+DUsXFvwyCGAF8uCvfzhFaHs7ZaN57PESJwMDYqO0YpqpAR7TYdLvljIZHxEwwDYT1g1CPPYIQ6jjCzdhExXxh/Ho+DVU7HvyjkCwXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pca3ldvv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pca3ldvv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e4b1acf41so12468257b3.3
        for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750970092; x=1751574892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpKARRHV0GlXown+jCeEHukDG3Xhdv37C5V3FKJqbJc=;
        b=Pca3ldvvZJ1etzYTFj4jM4ToRIfFcnx80WymTNAnsBLKLee3mQpjIErqq77ZhfpXO2
         30AmWyttKeHIGsQj0Fy461tYgBlxxMBPQUJH8Q5iIjuVnAZqvEXQnG+hqA/9z3qpU8UT
         jySP/Gz4O4y3Nr9Iidge2L2ELH9bzY+G3i+Ni5i4VhHmq3+GmjJ2tkSmqvcV74ETyLk8
         YGxPud6TbP2Dzb6o+mGqnk04ghS9jyqm8+1N3yimo4TtkkByfM0MVNaiiLm+p0+n/3xe
         xIVlksYJfZPFVGJvjBAvQ2w14YRYIr4hGItHYvGf+6IzLKpdEv912AUfLlum/FMajWIV
         Y0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750970092; x=1751574892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpKARRHV0GlXown+jCeEHukDG3Xhdv37C5V3FKJqbJc=;
        b=T9D243XzIbB2kTPYnEn4VzO5VvveuKBVx9/lSRyAp99fo/4ASj44cx2l9Sb6A5Td0Q
         OgXjuOnzksTquNHFRN8SrdyeZ1fW8xOERc4EZasb8ulujkDvyj0m92XHePNjs7mA1nAh
         6HzjdT57iiEs60XmBy409FBV9pSerfmaSHcs4qIh0Zy2AV0m9djb5iSvVLmBgxZGvd65
         c/zbGczQ3BDDBKwYU2N3R/pPv2K3MjaBIxD/QkxLFLQEYN7ImRXOJU3Y2FVbDytZxZQf
         nWYv1NYqmx5DwPCOEvfqq4mbOdPu8VyQ0mMLxZ0chZtT5ROvDvuEev83mzanIhRi/veC
         6vpw==
X-Gm-Message-State: AOJu0Yy97qd/OB1LRJDhY6wn2WdGADEcT7Qsal/MOJQbJf+bO/9ptz06
	UOBWFc7tYHvpMpNx8W4MUXXdkfjPLRJf2gt57X0yhiGa8ecmzhPKmvi8ZfPjbjnTeQuqkCIQjmA
	5Eg/PZr8oJ+rKdbXJq1k3Z0QD2zEbc17VhfkM72bW
X-Gm-Gg: ASbGncub1zMx37PHtSNswttTOPOpM9kxGEN4Gbz4CuVV+eKuFAjqcIjI4XaIqnUQ1SG
	XNkW3aMHz7cPrlCDMcFVn/REhc70NHw8dnYKQXMTORFoqdpgCUNMEO9p4VnNbzVMYNVymRlQ8sB
	J0lyo6mXbjDlEZ5KzIHqOhFRlNn7fICsHwPiDAp62DKvo=
X-Google-Smtp-Source: AGHT+IHK6VrXQfdfID3SjOhyl6IPk72MiKVK27mNqNBczZWqiASKyULPsr+tAuUGH9hU7iw48NR0JSPXXG0U4bQCVTQ=
X-Received: by 2002:a05:690c:490c:b0:708:21e9:a20d with SMTP id
 00721157ae682-71517150ef9mr13469587b3.16.1750970092045; Thu, 26 Jun 2025
 13:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Jun 2025 16:34:41 -0400
X-Gm-Features: Ac12FXz_mZxWuwijRdHKTeuO_d15FWDGmK4mlJCNU4L6OWArd1G631v-_4JZPTA
Message-ID: <CAHC9VhSMC1Kvj4RtNXUB-Yc87Vdifb-G1009LDhmy55hkW9Udw@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> No hurry on this so feel free to wait until after final release if you li=
ke.
>
>  SECURITY.md | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 4f624f5d..2fee4927 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the disclo=
sure window.
>    *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62A=
E
>  * Paul Moore, paul@paul-moore.com
>    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8=
A
> +* Stephen Smalley, stephen.smalley.work@gmail.com
> +  *  (GPG fingerprint) 5073 3D29 EB3D 5CF7 17AB  32FE 100E 57E3 3B8B 54F=
2

I'm not in front of my system with my full GPG setup so I can't verify
this, but we should verify this key to ensure that it has been signed
by others that are trusted by the SELinux project.  We want to make
sure that Stephen's shenanigans are actually his and not some other
Stephen ;)

>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
>  * Steve Lawrence, slawrence@tresys.com
> --
> 2.49.0

--=20
paul-moore.com
