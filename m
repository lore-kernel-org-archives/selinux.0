Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335583A4F31
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940196; cv=none; b=nF+D7ysrNK60rXcJ2p26ZEt00vxBXzU6jRMJHYWPwSQQFuM81ywlVYDrXEQoU6wy+2hlzLYGe5GDwTe4dt9EiQZny2mEeOpXhkU544saztiVbihvwG3dXnmw9CSLVRvNmxfKdZJQ8rQzfBFQmCvSPBJkPFeDXlOCvWY5w41y8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940196; c=relaxed/simple;
	bh=/yY4gfA9Jom3JGU/9x4gg7eFqpX3XcbbUuND8/0V6E8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WlkB1DEr/L/112mMsMa/QKxKipWEAflQ7BhS+EuW3gIh4itNhbwNYAGnJbMKH1Ic9TNgvSmx7bGoJDY10OHhroJXHTp3FZ87AAQD0KmIBsutQ4EEOxDbKc/gJdxrdMApdFQjizlJVHpMCimZIbjOZApNwnBl1w0MxGsS6j9jNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ver2GztQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ver2GztQ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f256eaedf8so10948756d6.2
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782940193; x=1783544993; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KLChwP9CCHoIdwCuJ2NmwwjgE40WemT8hY2SoxMxzw=;
        b=Ver2GztQ/OqVGwbrYBeTVdAb4Pld23+LnuMRlxRh+l/Xzq0MSVQ76/yS3Pz/lcmxFd
         5/bIZnr7BSESzamLcpgiSzMJycUrbjX7KjljoUoCcdfoGY4nhZQXHqjhZGi0X3LGtkia
         As6zYlCoBh4lOQYogUfAhOnwKVoLnrxJkm17iHPu24yMPbMlNnIQxOKN3c0jqBSXnNkq
         OKFWqrqD/FjTqdaZAvTnuDD1ZC3KrzLSQDjtOmRooFOVN7adrZ1dZryf/wiBFOSsplzm
         kXRm9rXMWHcyCrmleQNkYvYXo/JM2W0U5+OZjRcXNTzX5y69tgbWzbMNGI29+uxbcJ+u
         PEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940193; x=1783544993;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KLChwP9CCHoIdwCuJ2NmwwjgE40WemT8hY2SoxMxzw=;
        b=hNP9S1Z7DfNDKkYzVE1HzLkZeerwnmhHgkOW6d+7jSFNvL7q/VHMmVA8VifmuVBAn5
         A7TrpBb+4zTVQEdjShncDj4xrzOCXt9y9dZZTrXxRtkZfVnz9+X0JxuiQkYGuVGyFWqr
         7ce1bqMFqvAG3w0/8NfpbXOrTxSZ2tLgoE5S+c18QBxBcNjyiD20u80Uld7R3dnyEEHt
         Ih1UC30KBs1s8DkiFg8aLWu7nouR1DPRklXctN+TzMyqJFBaEh/rxALH5dQy99LeMqav
         DwcVKW4Ww29ryHfHbbXJhWNeN4wTebBTkS1u5j2P7gV+MDHMpkhTUbQ9qbdFRWeIzGij
         feVg==
X-Forwarded-Encrypted: i=1; AFNElJ+cOauwGJDGaBdUjBgNiK6S94T0POWpGDrvL5fkzTT+1bggHfEsHkOObOdK+EEAeb9YoK9e04Ha@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUgQfflr2zJan9an3k7+jw9sIXjz+3B5can8cbMXccYV/q1L6
	QXFHXjzWrxi9+wnMrgOFEz3Mp5sz8h8fJNGa5RVaAiwgleMJXc6QVC6xU294E/MMMw==
X-Gm-Gg: AfdE7cmeAdCDUpZctKpEq3Szkuc0GLJY4zamBRx2chYMz87tqRaBchuADlaBGsCgC2R
	uyaRJhoTs7oZbnlWWK82QDGN4NMyBdDqDLdl3SSzk5VWzpnamT2Cf+3sSiDIMssOsHdn7C1cmil
	7W2DeZ7DSbRKgDjsM2vZa+sNCOdDh/ZuRt+LKJuuQ5DUKqhaCDZd0bgKYW9zGSe8hCA6RkrQYRe
	lC2xPSR9jbA1DAPR3SS0ABBCMrexYdPKJuvZLK76w28XwbyAg/betK7fv0WUZZgKBWJKUVE1SFe
	ARK0giMguBYQ+DpqDdiHhd1eyvNMiXzIqPSbH3CifNpm0TQF+drrfwQRTTkkQNWceoE4U9ulWPE
	zwOmO+ZrrK5YKafk64CSjjJO5TPDHDmzXu9ghjNqJVnJ6vxBfVKrKxcfHNJWMqMXQxXIJ+dOt1F
	Lqo4j9RHXUqnKb+Y0B6DawBHRWBnuqJvzqTPtZ4JTv8p5TEHsrKTKUlNArhJJZsrQ71fD4
X-Received: by 2002:ac8:7d04:0:b0:51a:8eca:78e3 with SMTP id d75a77b69052e-51c26a2c494mr44377371cf.5.1782940192991;
        Wed, 01 Jul 2026 14:09:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c67294sm743611cf.30.2026.07.01.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:09:51 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:09:50 -0400
Message-ID: <8c1cb3dd478f6e59b682bae3a596a0d2@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Bryam Vargas <hexlabsecurity@proton.me>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [PATCH] selinux: check connect-related permissions on TCP Fast  Open
References: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260618175513.112443-2-stephen.smalley.work@gmail.com>

On Jun 18, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Similar to Landlock, SELinux was not updated when TCP Fast Open
> support was introduced to ensure connect-related permissions are
> checked when using TCP Fast Open. Update its socket_sendmsg() hook to
> call selinux_socket_connect() when MSG_FASTOPEN is passed.
> 
> Link: https://lore.kernel.org/linux-security-module/20260616201615.275032-1-hexlabsecurity@proton.me/
> Link: https://lore.kernel.org/linux-security-module/20260617180526.15627-2-matthieu@buffet.re/
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Reported-by: Matthieu Buffet <matthieu@buffet.re>
> Reported-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> NB Build-tested only so far.
> 
>  security/selinux/hooks.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

I tweaked the alignment of the if-conditional to better follow the
scope/parens, but otherwise this looks good to me.  Thanks everyone for
the report, the fix, and the testing!

I've tagged this for stable and I'm merging it into the
selinux/stable-7.2 branch to send up to Linus after some soak time in
linux-next.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..855cc32a7653 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5270,7 +5270,23 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
>  static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  				  int size)
>  {
> -	return sock_has_perm(sock->sk, SOCKET__WRITE);
> +	int rc;
> +	struct sockaddr *const addr = msg->msg_name;
> +	const int addrlen = msg->msg_namelen;
> +
> +	rc = sock_has_perm(sock->sk, SOCKET__WRITE);
> +	if (rc)
> +		return rc;
> +
> +	if (addr && (msg->msg_flags & MSG_FASTOPEN) && (sk_is_tcp(sock->sk) ||
> +		(sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
> +		sock->sk->sk_protocol == IPPROTO_MPTCP))) {
> +		rc = selinux_socket_connect(sock, addr, addrlen);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
>  }
>  
>  static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
> -- 
> 2.54.0

--
paul-moore.com
