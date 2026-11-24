Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486786;
	b=2O31pvoDr5sY8nhXewbHSKjXaK8iecxXXrVeuErTDS3FJzYMISJmUuZlAwC7+0tStK6C
	 o0nPPszjm0Q5EcRbmOtbkuS5lP+ofzzrz9QR/gsvq3JcW58iHx0V210qrSRlx7dSNgW03
	 C2MEIlTl2Rtcf+v1kbUd6zfAqJHYFOKe6lEa4A9ECYgjB1Vcld2keZVCRDtqMmsP/q0Cl
	 0/6ZKA8/MIYAKTmmvqjvcJDmwxRLLiDcdcsi3+O3lNfkZlRWtCF0btyuiKlrYb0f9ADlM
	 HRTdvalCe7djqw6eZqZQorZ4bLJUW6SdTVJK6XWWPwLObnBPYZJjPrcMBr0vvJDJGxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
	b=Ocek/vIfl1SOjX0QwRoy6CFoAYggezLhcJWziMLhgEgPjL7ugyn+xump5rzbr+tNYIjg
	 u6pECox44V3oPPvj2y7w9cYk5GL6/PItxrrW+HdAA9hBUMuBcALHOVTxJl+i788eNi+TU
	 qZLPz7U5qQPJbahfqbxKX1Zyzu/f0xUgtAhRerYzKYRu6/HM2WMChxnm882Y1YAd29bYX
	 QPDll31rH4yda8cJ44kocmsJiGjCCvZ1DHDxIMNnW+INZzETnxTynYFM2EHx2VWam2LxN
	 PCeBBebP2UV9Je+cUDgKhDmOQvi0+qV6Cc0vMCrELsgpQjs/sf92u0nN9kNI26WDs2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gXLmoeGp;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4768606A326
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 02:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4768606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gXLmoeGp
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9213f004a14so49176926d6.3
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795486785; x=1796091585; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
        b=gXLmoeGpp4YC4I6mCpHK2JTvgYkWuqbvABel0yKurKWRD86NbmnEpxOCsbDHXlGUfG
         90ysuBuVV3x0DumZtT9aZ/ZMYHhmBy129SlMJwiaN8mAMmz94b1JeI8fEf6sRhtwa81j
         Hs3DSUfs3f63rbs0OuWXTugp+WQHby0xxjMT3FkjK1iEI4yDhlE4ARTLT1uSz5UzDshf
         SV9ToAVyt3jXDngs7GhS5kJknl+DexPchuFfLV03z3rNdFKMSbp5yx7q/zNMseIEXVlO
         lON1hdivcYRYe4Eu6AJ54f6kYbiDY+fOh0nj0OVFyMKjghqT5tPUzbqrQfWKUaAl+Hjm
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486785; x=1796091585;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
        b=cWUbCWUptGwKRUHFCZQaV7fA7+Q2bZSnewv1RoRkPlW5nm/rwWSTysX4KkiZAJ2Dnm
         jmexYivhRpkCBBlJtTTWZ2nrubAVZJ71P4R0XR8Tl7yhyziwrrlhuOldyLzTUeaxFUga
         cPOTr7iIRwwyte6fvyegfpLUENsgfEjiyc3wGcO9hp3A7ktvbkJwJ4L9epWa/8Nmmhbi
         GFmsJih+pfZrIgHBVoDuC1guY9Y8/2HFJnPxtuRxPbomGrBb47vtl6geixLphpnomvEK
         /FnFPyY8KsCm1k3ujV08k6eX4yiRNy/gSBWP9ZoVcAROEIXs6VbxxIxi40xCY31iJPEe
         wkew==
X-Gm-Message-State: APuU4Z/WcAaImlJ5wJ9tJNSrVkws1Rb1xw5JyQLkspViaVVCmWJZP7Ib
	ICxRkSk0hFNVnnJ5WhRdJqlE1gLcRnnFEraGQYHWgZUSQhBD5ooY2SLUB/+0diY67w==
X-Gm-Gg: AZFdTZcLYnzj3W3MWZ2qP3U9OASt61DnId64HpufcqkVeTjuSIGS80zC22LUzp427ws
	5ZS5WLAUSVmKFU/TLzkFTIT14R/tLpwf9gYZUELhG/3BYVL2Vq8UvVV5xEPbRQyMmTeBJb4oqEM
	mjGg2o3iQ+eyXao2GYUpjxclPywhgDRVrNqZzWLPamxSVYnHieAYxD7tgaINCbkHtrw21HEuBMT
	6seaJAuW+htMtdUIYcwhb0BpdHcKyLOoUVkEgC9wKEMKYUitUACvfGDSqXZjHSa75GjjMWTgQAK
	7whaHtDa/BLyZoS6COWPSlCZo0DNl5r8bhMBYaZ8CTM2r6qZeFYyG5Dqli/zNVED/6fl7RDqIgy
	mx4WMY6O+A/si6n9cAMdicyHuKnj5Te0k69t/WdREJ4aA8ZHF7k+k/y4f9/dTu0hsuM7GPt4qWj
	XQlYylsIOnRyZg9fXljOxkQb6preOSFbbiDFqPqIKgkhA4szqJchzuPk+kHJm5pPtshNgWpT0pL
	FVX1Iy2mE0vcj2efA8jbyc3mCk/8EfXj2af7Lu44jzhZD1paDYUDY3B0Amr15Z8K5XhP4mpibBO
	bgAA3Z22sS7FdNW377htodIqmMXLD+0NprPdOrFN3VsSyGLnr6mCVVjhteYOE/Tuw5Ou2MqQDO9
	HBguQNdUhWozsr8q3BWnGKdm8OWR93w==
X-Received: by 2002:a05:6214:194b:b0:921:1783:1696 with SMTP id 6a1803df08f44-92134a37126mr252343606d6.9.1795486784823;
        Mon, 23 Nov 2026 18:19:44 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213479655asm122232776d6.4.2026.11.23.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:19:44 -0800 (PST)
Date: Mon, 23 Nov 2026 21:19:43 -0500
Message-ID: <04e583c2e9045e6a8990d752a1a2d1eb@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261123_1724/pstg-lib:20261123_1443/pstg-pwork:20261123_1724
From: Paul Moore <paul@paul-moore.com>
To: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
Subject: Re: [PATCH] selinux: reject a 65535-byte xfrm context that ctx_len  cannot hold
References: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>
In-Reply-To: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>

On Nov 23, 2026 Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae> wrote:
> 
> Commit 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set
> correct ctx_len") made ctx_len count the terminating NUL. ctx_len is a
> __u16 and selinux_xfrm_alloc_user() only rejects str_len >= PAGE_SIZE.
> With 64K pages, str_len = 65535 passes, and ctx_len = str_len + 1 wraps
> to 0 (kmalloc_flex() stores the same truncated value first).
> 
> ctx_str[] is __counted_by(ctx_len), so the following memcpy() of
> str_len bytes is checked against a buffer of size 0. With
> CONFIG_FORTIFY_SOURCE this ends in __fortify_panic():
> 
>   memcpy: detected buffer overflow: 65535 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>    selinux_xfrm_state_alloc+0x18/0x24
>    security_xfrm_state_alloc+0x3c/0x6c
> 
> The memory written stays inside the allocation (65536 bytes for the
> string); without FORTIFY_SOURCE the context is stored with ctx_len 0.
> 
> A user context of 65535 bytes can reach this hook through PF_KEY
> (af_key.c only limits sadb_x_ctx_len to PAGE_SIZE); the xfrm netlink
> path cannot, because there uctx->len (a __u16) includes the header.
> 
> Reject a str_len that does not leave room for the NUL in ctx_len.
> 
> Found while surveying callers of kmalloc_flex() whose __counted_by()
> counter is narrower than the count, with the help of an AI coding
> assistant (Claude); I reviewed the analysis and the fix. Tested on
> v7.4-rc2, arm64 with ARM64_64K_PAGES, FORTIFY_SOURCE and SELinux, under
> QEMU (GCC 15.2.0), with a KUnit case that passes a 65535-byte context to
> security_xfrm_state_alloc(): the unpatched kernel hits the BUG above,
> the patched one returns -ENOMEM. The PF_KEY path itself was not
> exercised.
> 
> Fixes: 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
> ---
>  security/selinux/xfrm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, merged into selinux/stable-7.4.

--
paul-moore.com
