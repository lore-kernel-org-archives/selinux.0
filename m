Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA34B1E5F;
	Tue,  6 May 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519252; cv=none; b=VvVa71OsOPMKHgDFy03odPnQVY/8PE6pGZQBysA1N/98P/CtTnSTuF2Kbo4KYFyghhgcyWPSKSmb+AgollkFbr4oY8+lr7WPQQNfOuyCdC/78Z80vFyxoiCPo3Q+8DDZdTpy+YH+R3Duiyv0zwaRCR2gsUJo1Fgr6mkFfIDoNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519252; c=relaxed/simple;
	bh=9VDTTW822ddqXQnhchXn05RJH6uPsrULAA8DFWaEdSs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sFIll3Ifb1xTBILBdt8KSlnd7ZYMdqq6wT+eu1kY7BM/J4uUY/3svzSAmJKslPig0tGt27RxBusVAHKBYhvwxmpmyIFLLh4mImpiLDmaweq+pDyg6Jjy5BMuBGtw/oQIUk2fFIy5kRPHxfrVLLqDxUCP9ik6N0wFVU6J7kKuYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Unlaod59; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Unlaod59"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so9448397a12.0;
        Tue, 06 May 2025 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746519249; x=1747124049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VDTTW822ddqXQnhchXn05RJH6uPsrULAA8DFWaEdSs=;
        b=Unlaod59Zto3805bxIKh8WSKQBFllw/UNkcUrXjruLdhdbZ2oWcB8UKTTTOKfF61uR
         G3n0Bo8okxIY2APHKDYtf/IXh6ewJqQ6tZg/asRsdEpyFGlc9aoEKYCrxsZKyTz3r59Q
         bIZfy/mDgcB6TvmpoQLFUfAyAYSzmNXuFCnsXMZ0lsxbMzsntBYltbXEIQY/39aa0r4j
         B4E4NnDkrBiBEJXieDeWtdMDhpnIeg0kEz65MlFGMyMObPfEGGeecEq5i9Ts6ceIVaRO
         bMGJcNpSXPMJ3mtVXd0+dhB4/v2cNjNgy8YtHRg8gtHS0+uyTl2+lZdpz/n6B/SwHmBc
         yVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746519249; x=1747124049;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9VDTTW822ddqXQnhchXn05RJH6uPsrULAA8DFWaEdSs=;
        b=w4djffjYzPeCwQMcKUCKMSFtHY/RblM3z/NRdFihevMb0YZ8HXK4JOYFedic+R3m/R
         xf+r1X2YR1ivWeFgcyPk8Vgio29M1DCTeohkrHefdg1GhRP1iULO2GyGuuCcGRUgYiiT
         BEfya2OynofzqJ5OgIhZN45T0yU5Cp5YIRDBJzZ6ekCZxd5ndQ5ccBIsvkb4JNECAS7W
         5snFrEDS2a2xFJaqpBuoojWRK8LOBUVdevQGEskABu+daJjpUhAHGWRtEc/lU4vaPrTJ
         16cE2zbFx3kdaN0qVgZlDu0JI3DSCd3glMDPklamXrYjkFs68yy6s+fc1tCC5Q8feqWU
         QSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIy+qI/SjYx/7M8/36PnjgcQhMGXXqYYjrSComxn8Z9oMD+dae2ZfIoh31QNoBH0lDIVl285MU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywitas6UNCCQ0vPqxMk20nPueu7dHW8CLxo4Ri2tnvTz9YistA0
	OvWWI9eLzEsyaV49Xkqm3/vKbR0KYPSNw/B/AJ6YK76PHGcE5LBZ
X-Gm-Gg: ASbGncuraJG3epMqONOG7gs74lfuiSDDvw6Kj5S3BuHLsANue5XE/jScLeDKpfv6NTm
	De9KIBAf9t3LqsLkk/9hF9Z4kxvDGuaCYnZe0GADEnkWVJCWC+7DRux4lYIiKLweDkHJQL/ppu7
	Ueu1mVQpEL/ya/vfVYnI8RlwPtLLKCp/YQwOj1T6LeuVX7XS5KjTCobjY2vcDL0IELBLxfMfkHE
	LLqfa9gpRJSUcZeTiGKMkeXI7RBAtQ6EpziFlHoHToMqdxesegpDFEi150KDJbRvIgNCwPJN9cj
	jhrd/KrGEEatcW4T3tUHlJtTjrqxHaiZteJbOXiC95g=
X-Google-Smtp-Source: AGHT+IGQdXpJBjcPOLR63YHW98s3vo7dMV1dYz43H+cLr4vB3aPDjuAnn/kOQZjKDFoJQVBD1KsgiQ==
X-Received: by 2002:a05:6402:2803:b0:5fb:1cbb:9390 with SMTP id 4fb4d7f45d1cf-5fb1cbb9429mr5189943a12.33.1746519248544;
        Tue, 06 May 2025 01:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b9047esm7014914a12.59.2025.05.06.01.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 01:14:08 -0700 (PDT)
Date: Tue, 6 May 2025 10:14:06 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	paul@paul-moore.com, stephen.smalley.work@gmail.com,
	omosnace@redhat.com, ericsu@linux.microsoft.com
Message-ID: <6f9de6c4-a2e0-4423-b581-dc15822fc641@googlemail.com>
In-Reply-To: <20250506031833.6107-1-caixinchen1@huawei.com>
References: <20250506031833.6107-1-caixinchen1@huawei.com>
Subject: Re: [PATCH] SELinux: Add check for the user data passed to kcalloc
 in hashtab_init
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <6f9de6c4-a2e0-4423-b581-dc15822fc641@googlemail.com>

May 6, 2025 09:20:51 Cai Xinchen <caixinchen1@huawei.com>:

> When the user writes some data to the file /sys/fs/selinux/policy,
> there is no check for the user buf passed to kcalloc. Syzkaller shows
> this warning:
> WARNING: CPU: 1 PID: 6642 at mm/page_alloc.c
>
> __alloc_pages_noprof
> ___kmalloc_large_node
> __kmalloc_large_node_noprof
> __kmalloc_noprof
> hashtab_init
> common_read
> policydb_read
> security_load_policy
> sel_write_load
> vfs_write
> ksys_write
> do_syscall_64
>
> This warning can be reproduced by writing this content to
> /sys/fs/selinux/policy
> 8cff7cf9 08000000 5345204c 696e7578 15000000 e0ff962a 08000000 07000000
> 4cf523cd 7eec2688 6d70a6b7 c78b496f 1a0a192c ea34ff41 70581a74 3ff0cfb9
> 7ea0f0d1 70d1fe14 41c2f7c8 ea1c78dd 17a19249 35210081 a83c30ec 4171450b
> fc1de12c fe1ff342 a887
>
> Add check to prevent the size passed to kcalloc larger than MAX_PAGE_ORDE=
R
> after get_order.


This might be similar to https://lore.kernel.org/selinux/20241216164055.962=
67-12-cgoettsche@seltendoof.de/

I'll try to respin that patch set in time.

> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
> security/selinux/ss/hashtab.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.=
c
> index 383fd2d70878..18bcf3978c9e 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -30,6 +30,21 @@ static u32 hashtab_compute_size(u32 nel)
> =C2=A0=C2=A0=C2=A0 return nel =3D=3D 0 ? 0 : roundup_pow_of_two(nel);
> }
>
> +static bool is_order_out_of_range(u32 size, struct hashtab *h)
> +{
> +=C2=A0=C2=A0 size_t bytes;
> +=C2=A0=C2=A0 u32 order;
> +
> +=C2=A0=C2=A0 if (unlikely(check_mul_overflow(size, sizeof(*h->htable), &=
bytes)))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> +
> +=C2=A0=C2=A0 order =3D get_order(bytes);
> +=C2=A0=C2=A0 if (order > MAX_PAGE_ORDER)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> +
> +=C2=A0=C2=A0 return false;
> +}
> +
> int hashtab_init(struct hashtab *h, u32 nel_hint)
> {
> =C2=A0=C2=A0=C2=A0 u32 size =3D hashtab_compute_size(nel_hint);
> @@ -40,6 +55,9 @@ int hashtab_init(struct hashtab *h, u32 nel_hint)
> =C2=A0=C2=A0=C2=A0 h->htable =3D NULL;
>
> =C2=A0=C2=A0=C2=A0 if (size) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_order_out_of_range(size, h))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENO=
MEM;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h->htable =3D kcalloc(size, si=
zeof(*h->htable), GFP_KERNEL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!h->htable)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 -ENOMEM;
> --
> 2.34.1

