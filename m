Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA32153CF
	for <selinux@vger.kernel.org>; Thu,  9 Jan 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414699; cv=none; b=EkGbyS5IM99XBtEFRqRxtZzjJc5SxU8NS+PFsaJED/XoODxKLKN5IIlkjwV2pfI531q2CLQgJx7dznFZE5pURTWghHS+fgdRlgxbPuaMMQzbVH25gvN7qpaGkft/aC+QcjerxD/r5+x0MiIrQh89vEhIQmNz2te7Qxohl+eM9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414699; c=relaxed/simple;
	bh=L5i8L8vWWYkt0gtsjdsyrb1GPxinM310z9jA2KtCYN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3cQDdIbut7b0RlZ21so/Pv9se7onv/k14bdaGQaQGDBezuyim4Pvhwtr6UpMubIt10udWepGkkEzw6AO37CpKvVSguzWHiPm7bSSrZAMxFTtY1QyttsA3DAzdfOJnT1Vdm7Nces0kEpI0wkTwwJHkIhLL94mS2aHfOCg7+awks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dr7K1FuO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dr7K1FuO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436284cdbe0so1051105e9.3
        for <selinux@vger.kernel.org>; Thu, 09 Jan 2025 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1736414695; x=1737019495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6fwwdpIdVMnI2XF+i5+tXNgS/k7VPLfX7Im7tSV5FSU=;
        b=dr7K1FuOeP7o4jbX95OzPmN4xLx3XjwiTCHUe8dVk/+GNPTLYgA9xV5qQzolt38vCR
         P+uB0TtvJjWvNB53bFi6BcN3I6ENqv6FmIy7tRKkMAlvDfqgio2n6F5FOVcl4Xl5T6Em
         mDXpWpxO7m631UgkZoHkCPRQoTEXNYi9nFuZZgjsYWBVMLCmh3eNdaBbxkCcF1utAawE
         Rz3zmrIU5coR6nugpB/UxXztojv+ROh/lEUdOCyE67xKZYxuEY+tB9glEAt9z/YxNu8w
         uEY0bCQy0cyPM9YyaXfv8cl7P19Km3O10OqCwozi1SEVf623EXJ9plwUbQqh3AuSyILi
         ZZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736414695; x=1737019495;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fwwdpIdVMnI2XF+i5+tXNgS/k7VPLfX7Im7tSV5FSU=;
        b=oQRMu0Zb/cZzNAEsg9rnkgsv4Vt1cdOdVm8atwT+WXfY8vP/RXCXZQDvNbNN6udHja
         ryO6JhVBhbMRqlBsqEQr8t9on4I3CHGKBMNhJ3+HFeI1bPsxQlPBebPNWHJSlYKH863Q
         2uQ4fWEFDSdJdkM36xncgLcMNiThTmW91x9ikrPT3dI4VTQBULOshLBzrsWrGW8i0d2G
         iPyXuDRO/2zKce7FC0WjzPC92FEQRcdYONQQtH7fCrX6zYgsFGM5SYDFPRmGxtTuh1WQ
         uy28U8cYFGmV6JeMEU/3X/OySKz5NLksa+nykUe2A5uaKRZ8++WNSITdMas2CSX9s6/u
         d/BA==
X-Forwarded-Encrypted: i=1; AJvYcCUgwJVPnAdYc7pUsvkKkV4dK7r/tWbWbQBvI2WhXWMVcXvHmWmUsONgsare4JTmGKBDBVV3PdcW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4Dqi4puTEXp2ULRrrCa0q0f6/yHbP6oVA3R2SC8yiH3d0AOv
	70RAS7IabVv0fHRmQAQa/E4Orfm+i/LQW6S1wYqZcSi0p1Dc00zOiOv32EDkpug=
X-Gm-Gg: ASbGncsY5k51RAWw2NCIE8CoIYnSK/pLmA4ub17GpfeW4LrV0AIA1KUo9V7HamNUy08
	qVU6Lnb13GR3wCV2+CdO0UmjRqj0Et6CISURQDhLtTt5BxeDTCTzPxuTQ2WF0lQiijrbjVracLF
	QeuljMAuDxE4bTv9h81rApQ5BuinOxofTOfvphlInIDed/fvb2Mi5o+h87DKQECnPafoZSA6gOv
	LSda1TRhHNL9vv0zr0bMdTm0fjhf+NZyXvSIvsIRPW2+cGXiCAnUSxqruk4VoLIUbSALcCbZ6bu
	OQl6/9a3w5Tfg3WHZM0AdvIWUmaxBwpgcw==
X-Google-Smtp-Source: AGHT+IF567dxiBb/07iXMh69b5WH52czFz7cR2N65fQFUZV1SxcNFwyyB0gXKeKlwZX0jZJH6XqZLw==
X-Received: by 2002:a05:600c:1d07:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-436e26f4abbmr20840175e9.4.1736414695099;
        Thu, 09 Jan 2025 01:24:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14? ([2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6336sm48679115e9.8.2025.01.09.01.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:24:54 -0800 (PST)
Message-ID: <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
Date: Thu, 9 Jan 2025 10:24:53 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Paul Moore <paul@paul-moore.com>
Cc: "David S . Miller" <davem@davemloft.net>, selinux@vger.kernel.org,
 netdev <netdev@vger.kernel.org>
References: <20250108231554.3634987-1-tweek@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250108231554.3634987-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/01/2025 à 00:15, Thiébaud Weksteen a écrit :
> The mapping for RTM_DELNSID was added in commit 387f989a60db
> ("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
> expected from userspace, other RTM_DEL* types are mapped to the more
> restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write in
> case the implementation is changed in the future.
Frankly, I don't think this will ever change. It's not a problem of implementing
the delete command, it's conceptually no sense.

I don't see why the DEL should be restricted in any way.


Regards,
Nicolas

> 
> Fixes: 387f989a60db ("selinux/nlmsg: add RTM_GETNSID")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  security/selinux/nlmsgtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 3a95986b134f..f97e75301018 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -71,7 +71,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
>  	{ RTM_DELMDB, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>  	{ RTM_GETMDB, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_NEWNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> -	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
> +	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>  	{ RTM_GETNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_NEWSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_GETSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },

