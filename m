Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52601209695
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025833; cv=none; b=bBj3P/bX1hHD28mHOpwo6/1DTAuxrQ6VEZ+FFketbI/Xlh7ZL5x+D6/2TDV64+7Yp5Zucg5Oc8mjrGrqJi90MW8JIdQWQc9c4O18hLcx+P8GYesUpaEKyb+DK6JC4wRM9y2T54Ke6NQW8McrB+miAmJqBov76n9yUaVgZx7oC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025833; c=relaxed/simple;
	bh=G8NXQxbFd8lXfA7seWIW4RepyFhVLxTCCiEVw/A/Ewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNQRS6C3Y3q1dTUuQjLoNZAi8lurB9lHyNq15hYLI+fK6RmU3sp0uCidE1LaylJQ8BjbwOhzGXx8wREMvin9CKCkOjgMyy4sqVfLrbt6g0YGZU9oX8h5r9nKLWPpr2FnlkqSjlnrLNrVlLiNe2AQSem1YUa3m6TvD42bUwenj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1AIpJVe9; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1AIpJVe9"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KkX6bf4z1CN;
	Thu, 12 Dec 2024 18:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025828;
	bh=mmduDxqge1hMXP8pqCVta+7mWQvFwUaxg7dZJNiPkaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1AIpJVe96UqBARG4eWr+dRiaTngUAud16ypmPYVJISw/Tn80VdCqrL8EdvdKJJeov
	 OH8GotxEtTzW5zcfzIKb0OyX8TlZbiqSZItUYiR7P3b0sXHa1zbthO6R3dBSCYfpXt
	 kFo6qVbm5TCL3u2AD/aqw7rf1B43Jp0HpWdQzcOk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KkX2jhXz71P;
	Thu, 12 Dec 2024 18:50:28 +0100 (CET)
Date: Thu, 12 Dec 2024 18:50:25 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: paul@paul-moore.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
Message-ID: <20241212.zoh7Eezee9ka@digikod.net>
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
X-Infomaniak-Routing: alpha

This looks good be there are other places using sk->sk_family that
should also be fixed.

On Thu, Dec 12, 2024 at 06:20:00PM +0800, Mikhail Ivanov wrote:
> selinux_socket_bind() is called without holding the socket lock.
> 
> Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
> of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].
> 
> [1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@google.com/
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  security/selinux/hooks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5e5f3398f39d..b7adff2cf5f6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  	if (err)
>  		goto out;
>  
> +	/* IPV6_ADDRFORM can change sk->sk_family under us. */
> +	family = READ_ONCE(sk->sk_family);
> +
>  	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
> -	family = sk->sk_family;
>  	if (family == PF_INET || family == PF_INET6) {
>  		char *addrp;
>  		struct common_audit_data ad;
> 
> base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
> -- 
> 2.34.1
> 
> 
