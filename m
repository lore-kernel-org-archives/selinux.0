Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278B2F1FDB
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483571; cv=none; b=m6R2V/jWk522X7/R84yI8y9k34r+cwk5imlGeBd/JKMTJm84sdGcY5VQgvv4oiLLJ955gtTOBQ64VW1eracjatd5lyg2iuNaoXuVyQT+d3apzo2bGDPeN4JzuxnYb4nYg7kVWjcMUTWWaNWsaRa/vDrQNyNjqxC8YpQnY/AtsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483571; c=relaxed/simple;
	bh=1642rGZU74xq68vkkweVLhTE+cy6BZY5sk7VdbrI4a4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BEjJK8lxvvdAR/ezZFr+HYIwR7UqlMrGAoLF5bQf3XCtk+ynw/2GQYhdG1xjsCdS/b0Z6rlwlZOwwkfk0Bg4vL6+nZIvCwz+9ljLY5xxz3rcE/+4z8XGdAKgOlfNDPgOiFpWHOhJm6lrSExsPPryTO1qBT6988uLUB9jm5fGXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KdegFOMp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KdegFOMp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85b94fe19e2so77879685a.3
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483568; x=1761088368; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbABftJegktvEinohUrVBBGjwcxyYpb8QQ5osopIRnM=;
        b=KdegFOMpYsupAOXjSJGtqNhl8APNu4dx2+jxEUywNkrXGUzzhfQykLvIpUGxx1W0Od
         7/Au+rZgQsDMd+zf2V015yjJETh9AsKtnZEc/MY5bTDqz6XfEgQ8Ilsdn95VLg0VclmZ
         jY/QgKfxooc2iEsJLTI9Bs6LphnR73DmIqNoZwm8AP142UO+65LELAqdqQUwgQ9/I46O
         yoEs/HHdPxq7nP5PSk4UzJNLmStxFepz8dO9VuNC5X844ZoD9X8OQeG2+QYUHKadq/AU
         9CfNP+REtYWg4BOnJjVGaJz9K5hiW6bPSZ7Dmine7XRYrMZeTr00F0hOSO9XUKDamwK9
         4IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483568; x=1761088368;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tbABftJegktvEinohUrVBBGjwcxyYpb8QQ5osopIRnM=;
        b=d+t7czFYyjgbRcwMXgL8Oe2nIuYS2+e8tJx11FURRQYrv9oCZp/Vbm8nlusdcZnmeT
         WczQBfE6j/OLezAUdA2jfgYct05fWHwCAJaUWmSv7o3UKblGpDgVnsuPGRZ31/2h9SIi
         iVrKaq1ZVP3OkdEar4Zu0MlzuvWrtw+eCWdF1B9f+03v1oQDOPA9cN7bjJmsFKbwiQ4b
         YJUrYC0PDAvEtMzZGr5IHczx5gCW+fmyEK/bfcZ2peZiXRhPBdPJz4a9yWEYIqpUvake
         8QvcmFN6uW3I2eLlsA/p6NrUR3zdVY9LccLqmBHO8oXTniD5pFhQgyoHtveXZtLAbf89
         M9zg==
X-Forwarded-Encrypted: i=1; AJvYcCVFGkLkX4ktI/hMO2b3LEnhCQm7C4KEmInNzqrNZEbw3Fu7l55Z+6CCvGkmoCqno05xh20IQpPS@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1WOaWCSgF0F7i0DPFKtAqI3S0MyXRkl43zlTTy+dvtZVocJP
	a9VstSVqEua7xIYwGRKYoFtd4sMabcjB4ESv9O0Ozc7/ZQiCmGzYRMA6MrxDxki8wA==
X-Gm-Gg: ASbGncvjAhQf/hDDuZ9FmSaTzEsMu08/rrVl1W2CZRXUcH4hoHuVH7gM2/4KJ5LDmjZ
	Rc/uFQWyyhnXZTI2mkRDBnmdbzPXo9/LeZMXFJQOfNT5te1yFYX/GCbA4Zu67fI4P/GSpMHRvQU
	w60P64kMY9ulWXPtzkkWrDG+VPKNAAGgTdw8X5/uFMpW6CyzILbB6JCOSCBFDE9om/A/m32Xg20
	eC8tVRQNJKcvVHR/wn96BNgud17fMxV8/nwzlKJRcIDveBrSIxtyxnmfo89YBYbsy+OVLstmARe
	UAj/dcD396q4uK3PWyVB/l9UlrUxX8eqxcxQiGIfVX40wOo13hiE/eNR9Oq+2SS4F1rTGtAeUEq
	+5WdcLbCOPW7e5tauss7W4WrX/+C3jIacuTQH4zSmQiSqAP4y1xwFp/7MJGf18s4b3DRILvtyHm
	HQcikdUP86m68=
X-Google-Smtp-Source: AGHT+IHHUSOIto3fQL4gqQowEcOO80a1JxbaHlWX0zgk1hCAHVJi9l+HUuHQPa5dx+dqlmFZXyLz8A==
X-Received: by 2002:a05:620a:1a91:b0:85e:91c6:cec7 with SMTP id af79cd13be357-88350a7d75emr3604190785a.34.1760483568445;
        Tue, 14 Oct 2025 16:12:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a293bc5esm1285997085a.60.2025.10.14.16.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:46 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:46 -0400
Message-ID: <ee015074a9019ef4725f7e613fd76f86@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 5/15] LSM: Single calls in secid hooks
References: <20250621171851.5869-6-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-6-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> security_socket_getpeersec_stream(), security_socket_getpeersec_dgram()
> and security_secctx_to_secid() can only provide a single security context
> or secid to their callers.  Open code these hooks to return the first
> hook provided. Because only one "major" LSM is allowed there will only
> be one hook in the list, with the excepton being BPF. BPF is not expected
> to be using these interfaces.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index db85006d2fd5..2286285f8aea 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3806,8 +3806,13 @@ EXPORT_SYMBOL(security_lsmprop_to_secctx);
>   */
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
> +	struct lsm_static_call *scall;
> +
>  	*secid = 0;
> -	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
> +	lsm_for_each_hook(scall, secctx_to_secid) {
> +		return scall->hl->hook.secctx_to_secid(secdata, seclen, secid);
> +	}
> +	return LSM_RET_DEFAULT(secctx_to_secid);
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);

Two thoughts come to mind:

If we are relying on BPF not using these hooks we should remove the BPF
callback.  It looks like the secctx_to_secid and socket_getpeersec_stream
callbacks are already absent from the BPF LSM, so it's just a matter of
working with the BPF folks to see if socket_getpeersec_dgram can be
removed.  If it can't be removed, you'll need to find another solution.

Instead of opening up the call_int_hook() wrapper here, what would it
look like if we enforced the single callback rule at LSM registration
time?

> @@ -4268,8 +4273,13 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>  				      sockptr_t optlen, unsigned int len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, sock, optval, optlen,
> -			     len);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, socket_getpeersec_stream) {
> +		return scall->hl->hook.socket_getpeersec_stream(sock, optval,
> +								optlen, len);
> +	}
> +	return LSM_RET_DEFAULT(socket_getpeersec_stream);
>  }
>  
>  /**
> @@ -4289,7 +4299,13 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>  int security_socket_getpeersec_dgram(struct socket *sock,
>  				     struct sk_buff *skb, u32 *secid)
>  {
> -	return call_int_hook(socket_getpeersec_dgram, sock, skb, secid);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, socket_getpeersec_dgram) {
> +		return scall->hl->hook.socket_getpeersec_dgram(sock, skb,
> +							       secid);
> +	}
> +	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
>  }
>  EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>  
> -- 
> 2.47.0

--
paul-moore.com
