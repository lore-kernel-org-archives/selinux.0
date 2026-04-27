Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99E370D5C
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332419; cv=none; b=WhI4dYkYkA+AEJOk5yv8DD+m5aE5GiASSK5yMX3XFjSwoilnIaFALajIkJJDbx0OJIPyajLhS+Qr7fH57MBmDQNuLN20UFU1qgqU6dGIrsCZOHYYkGvJVMC3J1/dtnu1320/fxJq8ZW2aBgFEttGlMlFJj67Lr31coO3Ve2UQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332419; c=relaxed/simple;
	bh=NGxHlATYjKaulZPUmn1JJtc+VHzOp4saFiBfRB+cviU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=N1WlKHiRogv6oczUJkx/BUULZiG5aY2/lgclBvXCZp4LziKQlMKkOdlkUiTbluanMCbfyiLlFTpZSw5x13fdvmNvOCO7ai8YmZ8j2uMdrwl9SDjZs/j6uwF3ADxijwCKW2j5zXY8eFdubkqYXWpdSxe4FdGYQB7Gn4q52CoJCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ly8zdmvf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ly8zdmvf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb38e86cf2so980552585a.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777332417; x=1777937217; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0OMb6OHqfZz5VEv6dI2eSHAi7ca6Clc6AMsQDmvakA=;
        b=Ly8zdmvfhPDVJT0uw7rTcxq13pdoMeSpePwJzOf1WNctjoQn4Fr7IbVvQ0qjvwc+9Y
         FzKgCSK8ZPVvoZ5sw8qgNz0Zg+Tw1X3/x7++BTRhp7FzggUu642WP3svV7A5k+YtKE6Z
         dok21NqgSWOCYa9yyO9uwtklwz1jZzthSRvjvrAvFJ2/zCgBdISLhLrfAfLvSbERABPZ
         6XSGAYN08UIp4fnFTxpQgseUa5/j4EChcVbGt9HSIHSqbq3X1HKRFW6COIiXRNGThwkt
         wQXWUN0lxgYWYBHHDmtre4mugNnpBRueUXd2wi3/+FI90K07T5ReIq6NMbNHMr66TPq/
         yhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777332417; x=1777937217;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0OMb6OHqfZz5VEv6dI2eSHAi7ca6Clc6AMsQDmvakA=;
        b=HpEbJej9QEpCTWtIAAD63AejOstDcDeutCFYx2VxcLPjdRJnsJ7VxSpmhga9+rv8Mn
         vJtwLIYenmT8DaR1XikHcxVUjm7QmsFtMTxNYuc9+2ePImycJXHwDlLN5sKxHCyMemqB
         JHNpXl+4GZysm8c6DHPZBUB1eM2XANODwWFMFXqQOvbct9DZm1lkWxX7UCaznRNZsme5
         mRCP7K2qD64JbHFe6pwJKVwgBWwIkMi1aZL6WvZXWrbcARx58bY5QThug6ooCs0yyyrZ
         Gc9JtyD3UkYGkYC7qO6tiYhNXJTwIqHCcMqXiwBh1MP0E8Y4m0t1Z+AJxjclggss5AAC
         XXBw==
X-Forwarded-Encrypted: i=1; AFNElJ/smUNAGiJnDaj9FDjmWgWMOJoW6E1E7b/wWzsakvsauV12qG6IHky4mobCKCMJ2/EBg9R8r1vB@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTHQVSmgmrHDYfp+s1U3X68kBpauv5s5qAUX2siJkh7UXhtFq
	Xoa9WWEpHlcTPh7ZPpJDRODMzT8NwBc53VsyUblE0ZCgqXSjCwyb/Fmy3hsqX/M+iw==
X-Gm-Gg: AeBDieuFh2mERn6cZ0UHSzWscBvGVa5XiecbOdDm36SXxVy81TTsiQ/a0B4e3izKPMi
	mOBX5LXMdLicd7991pNp4fLv7idLNkF2UC62/awpfoPI846cglN64XCOy41rAiYr047SzdwLNI3
	ua2TOZtQ1l2HKQKirb4F8ThfQhRRL6QkR8LdRgXPUWwWRK0BaBec1QkzP+P1v3eemXxYHbbSmVg
	EjjPmv38A8SSVGuzXaQUp39vFxXTwAcm3s/1wYy189A2U6CqlGFgZs3Elk9as7x4iVuVwjvJmjF
	G1kig/127+OFPvMSsSxHhpt36qpfiLIbnfq8OuzKwzVFs9kt1vbUHsCK79L7h4cB5JyaxxWa9Kd
	xaMnvD0B90w0Rp8fxb3Bnre3TlOa4nTogz+28oUY/ndEX9X3TIWPMXB403hAACxCLLi0t65rIDt
	mFwEuUoqnPVeL2sxFVuoZePSgNK8YDLXl2gSRVrvdja6oa+My+uVqnZBNPCcUQjPhbmKHS9wixZ
	rTZ4DM=
X-Received: by 2002:a05:620a:bc7:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-8f7d6e3d8aamr106579085a.8.1777332417052;
        Mon, 27 Apr 2026 16:26:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c4fb6176sm56265985a.16.2026.04.27.16.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:26:56 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:26:55 -0400
Message-ID: <38a93d9bff736d54254593922fb13a5f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260427_1759/pstg-lib:20260427_ 820/pstg-pwork:20260427_1759
From: Paul Moore <paul@paul-moore.com>
To: ZongYao.Chen@linux.alibaba.com
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, ZongYao Chen <ZongYao.Chen@linux.alibaba.com>
Subject: Re: [PATCH] selinux: use sk blob accessor in socket permission helpers
References: <20260424073753.2012574-1-ZongYao.Chen@linux.alibaba.com>
In-Reply-To: <20260424073753.2012574-1-ZongYao.Chen@linux.alibaba.com>

On Apr 24, 2026 ZongYao.Chen@linux.alibaba.com wrote:
> 
> SELinux socket state lives in the composite LSM socket blob.
> 
> sock_has_perm() and nlmsg_sock_has_extended_perms() currently
> dereference sk->sk_security directly, which assumes the SELinux socket
> blob is at offset zero.
> 
> In stacked configurations that assumption does not hold. If another LSM
> allocates socket blob storage before SELinux, these helpers may read the
> wrong blob and feed invalid SID and class values into AVC checks.
> 
> Use selinux_sock() instead of accessing sk->sk_security directly.
> 
> Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nice catch, thanks.  Merged into selinux/stable-7.1 and I'll send it up
to Linus later this week.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..49c482e3fa3f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4920,7 +4920,7 @@ static bool sock_skip_has_perm(u32 sid)
>  
>  static int sock_has_perm(struct sock *sk, u32 perms)
>  {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>  	struct common_audit_data ad;
>  	struct lsm_network_audit net;
>  
> @@ -6227,7 +6227,7 @@ static unsigned int selinux_ip_postroute(void *priv,
>  
>  static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
>  {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>  	struct common_audit_data ad;
>  	u8 driver;
>  	u8 xperm;
> 
> base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
> -- 
> 2.47.3

--
paul-moore.com
