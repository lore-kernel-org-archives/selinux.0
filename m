Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906C1C8611
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804683; cv=none; b=dZ5lKR9D2mOSY2pJAmsF12Vo53AFYilwwrodyb3V+w0/D/rs+7rMTGLC12u6rdth5/v9DCgfj4hIsbX1Xm621ehUkXuajixF9Pm4Qwehl49AmVD79ZCKieZgYQCn5I3Bc9NeuK2YegRZyH6b/YZxzBcj/F/1CgfD+FV5syHy/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804683; c=relaxed/simple;
	bh=fCBaS7/TlYHyrtTGKXrdd4PcmBCn/NRFYN2zqKwb4mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rcp5sxsV50FtLD5+sZ71Jy4I/dq0D0XIhD3V+Z6/nCscmNbKHd5JiJD+vbJWzS0qbYduorpabkUG3nOySNaFxTzlvY/MrCaredOxrOm3hY7Q0ksb0jtW3io45AuxNXAPRi23Uwg+oZ6OtFhz1fZLegH4f6ExrBqGC9nw1vvUkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYzxyT9z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYzxyT9z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1093659a91.1
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758804681; x=1759409481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y+QHu/58Ua/X7dBROxwIF10Ht/mCbydwR7yMHO0GFU=;
        b=OYzxyT9zAjmtdhmvplh6ECWQi6UuI4udtoyV9YzPeoFcSrXVqvCzNmFLWSWbxQ5nbH
         Ber4rm4CsZ5/nQ6E+eQDgT75yHmVDgg2h0shWZGGOfZohZm68KNON42Xo9apshAcU5PG
         MgMSmmwpkddHXovR9Lgtq3YN7oVRwUoeeSRFeZPT/yehuXhPv6h6UzX5NxIBwcTxe5E9
         noDduQlWjRptMPgePSH0AdPiR8jmX1/JiO4LXzWw3zFHXEPW2m5K+sJYzYgH5yia49Ji
         sG0ShoWCzZnvJD4k/E1KctSBgS3Umkp1p9Ri6NwO+5Dzanx3U4WEKdPxTeYljOwhxBUQ
         +Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804681; x=1759409481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y+QHu/58Ua/X7dBROxwIF10Ht/mCbydwR7yMHO0GFU=;
        b=c/SVs2Z36CEaiZZyLH4y2wFNHw2eJdqFaNM09AqpAF85oYAF4SJWnK2Bcntk6/lOgX
         3NGQvAkIl9OHM3lFE5wHC1FbIEnHfEQluWDFSfSvVbpe/8kWZXzsQqvc0sBGxzy2ef+G
         rEOk0wxOh5cN6LVPGZhTna400fKOEa6zkdsMPekwHPYCmR32jM4DoR5rcokWaZKDDxxV
         c8xGEWv4MMn+fe57TCWA3JESdjlSbnTUUQ8OPcTUJwA8l4f2ixBYNLCc0xtQpIkwHTGA
         mWHN5SWT4Hy/HUa+2DDcaaJskXuafsuu1X0EumLtTqRpC3nNUnqXtvM45RyFdA2aqK1X
         qLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLNvycXvTeQygaMf37bfRpL0fOxqJHuDkD42MtzHaPIXKjOQxYmqwc8ET/zTxajikE1d5lAMh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CIOBvWJXIsHXxc1qawXirMjHQ4Um55e0sJTWDTAm44lSE10/
	i+jg0bcvhUWfO9+7o7KXHD+Hbrr1R2eqPqT7lTQiQqbM6Bwtx9v27Mi2KDcGYYjqpYEea+ob8X1
	nAjiHfyEmg9yc5hvqatYDr2ScOYlbP6s=
X-Gm-Gg: ASbGncs+IziCjeE7DcM86camfLJJC+22rRgA4Hutvgv9GwOqMgGQYerz7qoFKXmsyZ2
	Bv3ITLzdR9eL8BheYc3WwBpGPdnpuhlLCS6Li7cQisKGMTULu2jIA9E9fvGzNbSh5psdjg7D5W+
	1UxSaIyBfPQWMQ/LqDUxuEVw8sZfeK2tymtz5BVetpk0bQyF/HUZ9zRpsA1w2dTQtXb2SjnJP9q
	xjY7hY=
X-Google-Smtp-Source: AGHT+IFhi4xltKU6TZWCCwtzswOj5FvsvZXm44XkezkVkcM4F8corx/pr8JlfpOrqeNtbBzgArl0Y6bNYT7UNcV4yRo=
X-Received: by 2002:a17:90b:180f:b0:329:f535:6e4b with SMTP id
 98e67ed59e1d1-3342a2e8ac2mr4215441a91.37.1758804681113; Thu, 25 Sep 2025
 05:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758633723.git.zhanghongru@xiaomi.com> <5188e81963654bbe9d1e70fe6370a38fdf4ae677.1758633723.git.zhanghongru@xiaomi.com>
In-Reply-To: <5188e81963654bbe9d1e70fe6370a38fdf4ae677.1758633723.git.zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Sep 2025 08:51:10 -0400
X-Gm-Features: AS18NWCoG_eFZ1r7KuFm5jkK7b7rT1gpr9P99y3JZSAqAeHHkpK2UHVqE35X22g
Message-ID: <CAEjxPJ7DgWyQYwfR4T2FZCw6f5SLx0O0jgoW3oyoQi7G8dsWQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: improve bucket distribution uniformity of avc_hash()
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:56=E2=80=AFPM Hongru Zhang <zhanghongru06@gmail.=
com> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> Under heavy stress testing (on an 8-core system sustaining over 50,000
> authentication events per second), sample once per second and take the
> mean of 1800 samples:
> +--------------------------+-----------------------------------------+
> |                          | bucket utilization rate / longest chain |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
> +--------------------------+--------------------+--------------------+
>
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>

Can you re-run the latency tests from the 1st patch and provide the
results with this one applied?
Also, checkpatch.pl reports the following warnings; please fix:
WARNING: Block comments use * on subsequent lines
#47: FILE: security/selinux/avc.c:160:
+#define C1 0x9E3779B9 /* 2^32 * Golden Ratio, classic constant for Knuth's
+    multiplicative hashing */

WARNING: Block comments use a trailing */ on a separate line
#47: FILE: security/selinux/avc.c:160:
+    multiplicative hashing */

total: 0 errors, 2 warnings, 24 lines checked

> ---
>  security/selinux/avc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7a7f88012865..d08f30d57bac 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -146,9 +146,23 @@ static struct kmem_cache *avc_xperms_data_cachep __r=
o_after_init;
>  static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
>  static struct kmem_cache *avc_xperms_cachep __ro_after_init;
>
> +/*
> + * Advantages of this hash design:
> + *     - Minimized collisions: Different inputs won't produce similar
> + *       contributions
> + *     - Bit diffusion: Each constant effectively scrambles input bits
> + *     - Mathematical guarantee: These constants are theoretically analy=
zed
> + *       and empirically validated
> + *     - Complementarity: Three constants complement each other at the
> + *       binary level
> + */
> +#define C1 0x9E3779B9  /* 2^32 * Golden Ratio, classic constant for Knut=
h's
> +                          multiplicative hashing */
> +#define C2 0x85EBCA77  /* Large prime-like properties */
> +#define C3 0xC2B2AE35  /* Large prime-like properties, MurmurHash3 const=
ant */
>  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
> +       return (ssid * C1 + tsid * C2 + tclass * C3) & (avc_cache_slots -=
 1);
>  }
>
>  /**
> --
> 2.43.0
>
