Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CB284B32
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403380; cv=none; b=WHASgvYH+cJaIoJJnpr9EyvrtTFB764y8uoYSmoHpgZzVOmJrzk36rq3MI3LLRK5rE5zboB6bYJ/LwT+VKFZKh92pFRFSB5oVU44uDB77ymL+Kqsg7JMB9HLmUgAqPIHSJ1aAhK/QLXBb95Y54ZHcxlmZ8aDYj6H1+bZtVY/RVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403380; c=relaxed/simple;
	bh=Zz8alp7eLPIwTzedMMr8/MJPGI2MAf5TOo/6UlH4/vw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RJ8cZ5dsB9LgYjLP1H7FpHYO+Lm1RGZZdTkJbsKfBsX1yMXQlBeio0r4+oFdSnJNCDjvBR0Gfm35fRAy4joFImmUyVZz87R6uF0UFZjALpw8mE34TRguCj6l3+MuzByY+vaIGliCBks69PNoGEyvhv+HNx0JJ2y+oc31vcULkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8u4OxPU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8u4OxPU"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so22470376d6.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403377; x=1745008177; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbHr93LO4bs0ZMoXRyryi8G/f9qfrVu4Cl+FMwxiTZ8=;
        b=I8u4OxPUBdDE1vZ0s0xDjkdQxI3Sbz4HS11OjZqj/AZCzFdRIWHVjkqc5awE81BKBS
         j7Kc/cHuvqOlGR3Y9d3jWA+QjngKx5Fa8LlCtYpuRDOufqQ2FChLBKUCCqDyIa+QGonL
         caMLtseK48RqSJCx05L7kqRD5nZOhqTRsBum3lu7XZZ7RP7WTKHu6xmUDdSw70b7JqQS
         2e3YcahcuxAT4aN4m3byuhSYGJxmMM8NUbxYCY2bLxo/9FKXFmCiJcTJ1b21pkqiTlRi
         kKRYPy5BPP5q2OMKEwueDaXPnvzLZd8TpVOUV2d67RpDdUhEK5OZaTSMtrU6+y3F+U6G
         2a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403377; x=1745008177;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JbHr93LO4bs0ZMoXRyryi8G/f9qfrVu4Cl+FMwxiTZ8=;
        b=Ng7+RMlmVgFMvSQwT5n6uI/uCF1F7KR8FuZmJvpQ/TP/rIJLd6swG+2r6yfbYb8/oM
         NMb9lV9LmZ9Zf0hG9M8m0HpJsMIY9aJ1U4cwmpUSTTtaM2gGrGQnZDhoAaO72Ft5w066
         a6wTpx6/l9q3P2KkAHzH2NRBXThYMBX3jfdk30GmaCZgOhO9bXlfXFLJaLnUrU5UF1en
         lFY09kZlhr/51iMraB2Bjak1afR8tNiHfnoyVgv2zAVuh2r3fJLunHd4QYzU3zCJovM5
         LSidEnpf3uDoTKnWgP2CnAE43+81Sa/DLW+cxy4bI+aNRHJfy9N8NcSiAJZS/Z8y9JWS
         JgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/DqVpXoS1vXmv/BwW73dbt1ME9jHqoqWB9GpIXHLBzT/Zb5tYv48jEzimeNfLqwldxW2jz++@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCmhN4GhKehpr/tesNY4Qu6GBf2P4vVlEJj2IlwLjgax1jgpx
	K/3RVoDljlf5i9VrB1aclpEG/SdEtpbNZMyTIMoFMImBn2dH+As6/YzXAPa2Jg==
X-Gm-Gg: ASbGnctEJghSISaTlxH5OGCc8deyreQbyAHdFZg1p2F8WbIVpedyuGdWsTa3M1JBWSx
	XHlaSxN9Ny8n1z9G4R86hd83mFZSMnRePBpWKKbcHQpIr1vqifd18uHfPYxinB/nIniwvrSuKu/
	1OU9h2Yydam0xWcVMzasyDNWm1gZGv8cNazN+KtJHrTP6+LTXIQXeusk/+ojGHNFcTvlahMZn6y
	cTUS+FBOPIEMjHHrO3lRPURtXn667Fn7EvBpNO6gcxwVOM8QcJgxClBtA0whCH+9uqNPcvRc3c3
	R3URRitiJG+XWEWwUg5MwxC7RwUckGC83N8V9A+LT9o/PwbYuI4cgye1C2NYbaKato5YLaLBpRv
	JnF4nyWayyw==
X-Google-Smtp-Source: AGHT+IEBKJDajZYrrZ3gDKTry1qqALA694IS63BLywJqibFp8HFfvqn3OIAivhRbWMwLbAA37COABg==
X-Received: by 2002:ad4:5dc6:0:b0:6e8:f3b0:fa33 with SMTP id 6a1803df08f44-6f230cb96d5mr64559166d6.8.1744403377434;
        Fri, 11 Apr 2025 13:29:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de98096bsm41240806d6.59.2025.04.11.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:36 -0400
Message-ID: <7ed70f417b10ae1510dbbea501da892c@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] selinux: improve network lookup failure warnings
References: <20250318083422.21489-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-3-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Rate limit the warnings and include additional available information.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netif.c   | 8 ++++----
>  security/selinux/netnode.c | 4 ++--
>  security/selinux/netport.c | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)

How many of these messages were you seeing that rate limiting was a
concern?  Also, what were you doing that was causing this?

> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index 43a0d3594b72..38fdba1e64bf 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -141,8 +141,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>  
>  	dev = dev_get_by_index(ns, ifindex);
>  	if (unlikely(dev == NULL)) {
> -		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
> -			__func__, ifindex);
> +		pr_warn_ratelimited("SELinux: failure in %s(), invalid network interface (%d)\n",
> +				    __func__, ifindex);
>  		return -ENOENT;
>  	}
>  
> @@ -169,8 +169,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>  	spin_unlock_bh(&sel_netif_lock);
>  	dev_put(dev);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
> -			__func__, ifindex);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network interface label (%d):  %d\n",
> +				    __func__, ifindex, ret);
>  	return ret;
>  }
>  
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 8bb456d80dd5..76cf531af110 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -228,8 +228,8 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
>  
>  	spin_unlock_bh(&sel_netnode_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network node label (%d):  %d\n",
> +				    __func__, family, ret);
>  	return ret;
>  }
>  
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 7d2207384d40..dadf14984fb4 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -162,8 +162,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>  	spin_unlock_bh(&sel_netport_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network port label (%d:%d):  %d\n",
> +				    __func__, protocol, pnum, ret);
>  	return ret;
>  }
>  
> -- 
> 2.49.0

--
paul-moore.com
