Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECC37B409
	for <selinux@vger.kernel.org>; Sat, 13 Jun 2026 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393368; cv=none; b=Lu/oEq5viX+fKwQO1D2J4sLQw8iKQW/cHvSjz/xw4ddFRZlxOPShGkfFT8azZPMbo17tHn7o9wd2YUhC4mMDz1vH73oOEp1v4QQcpvoavdgZCyR47Y7r5DN09iD0+J86XrIMOnrL1Uu+EL4QSEpZusYBiq84LNM0h/rswfiNNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393368; c=relaxed/simple;
	bh=FeunYxTQ20QVXHtamKD9y3ZA4nZm14K23tmnTCQUTWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQPqkrW1BhPI1674r/wdYJwV1FUsh4OlzNCG9x9WugpaCTbi3AOUZBUwofs+gU+h246EJQ5rgYkzHDij2YjVvWCfgTKJCFUgN2EXkVYhMju2WAi5VKQkYdlRje2WJFu84ygG4/qsKrn9RUR68Ofc1DSffhwBIhBMCUWDiQrPoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Tu3GLQ/m; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Tu3GLQ/m"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C56A93F1C0
	for <selinux@vger.kernel.org>; Sat, 13 Jun 2026 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781393362;
	bh=2cQ35Uy1t8wPqUI+pk9yl3MtHFjj+gQLsjP+hSrbKIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Tu3GLQ/mtaq+gd9xvy4+dhJfOgTY6RzYeAt4eXJNgqvfny4fVcVMdkSLdp71FrZjr
	 H/YJ4XhxdQ9Pe1YkvMT6VzcPU+ga+fPj55aWhvKzIJEqmr6X6w+rlsnWTRlX8IG0jD
	 cVasHCyyf8wlR4ms1/nQCMy9GHaIp2J4AZirPaiH0arKnl3jmk13dRYH9BsAhj9M4u
	 2bZJM+t+sYrboQeAdQ88jomgRVZ74WjH/E8kTWD3HnlIB0pyQJ34iWXvmO8JRraO//
	 bDIR2mHQgIAuCNyTqfPbDcZioZGXpsKTxj6xiMJwaL0lcjshsVBqiAtFQqvrjZQIw4
	 ZuFvIgJvsOjskl3JLFcufGe0GzIM+gPs+Z0eRqgHoN7hTpL22Y0DREPjg6z3mQIZjK
	 t3poysiDyCH+T5d6wKGQa4N6gcG/4BULGuZweWHM4TrGPyOJYhXmKQRPfIVMg1mgAg
	 6WWaSX2Bzp2FPEYuLacxwBx0fF3EXlUHKJxFN2gsMlHLAX6Z3huBifE6PNqWA71tSS
	 hk+bGPFIt7Rmq2X1yRGi/g974vyWAZqPpAmbyfd/YkbCcM+VKWJQ6OR0Ks757n6BaQ
	 T1ql0bDkfXc0ZT+WbCD1eEkzU0ZJtbuy2TNoEVys8ZJf2xQ8eW21kKZZwuzqPUaiiU
	 gzASTjnmKFNAUsOm88Il5N58=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1954408a91.0
        for <selinux@vger.kernel.org>; Sat, 13 Jun 2026 16:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393361; x=1781998161;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cQ35Uy1t8wPqUI+pk9yl3MtHFjj+gQLsjP+hSrbKIM=;
        b=lR7WASnkwpk00hi9YWTn2YG0ZV2iqqFt/+7yUHtk5M8Lxs2CNRJllGBYZDziJ008Jl
         9ZA2lwXP2GY/ARSyFbAS/oSglocl9W9Gvs1HG9qfDk5NfbdX8jXPiB7MrBpqx/YCsNRl
         h9cSaAK73BluIFb/Wr0uGHaGpTTgTZpwcUuQstH66iV994l60C0c9yrqr67bc9XOdYZn
         egsbSUQGza53TXkxV4fClzrcunv2t2nyQlHORsLSMqmSB+NI5IqoztC475Nt6rY/kFm6
         eN8VFGvcGaMVdUNbZ8Eu9ecVMzf4yOLVzLD94prRjHfKK4uSS8TG7u1dLK8PxeI3WWBZ
         5wLg==
X-Forwarded-Encrypted: i=1; AFNElJ9R+lKA4JVJLQ51Q5Bcax2d7NxncIb38bho5V6LvDnusMIYi9kIjyeNOtU2bZ15vk/OVF9gLw51@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSXX4rjiM/3jwYL16OTgfxcGWe58+Jvtz/Gpvf+HAKZzi87t7
	hJV0yES5uhSh42nvNPXv7uaKRyulsmGkCY0wwVGvRZDmcwXefPror1HNgmQIkfmhgJHXbOjcWxG
	pd2ykufc2rjjtZ25wDhjLIUzrMkPzh7jouIRT0vPkrtjGPCAF/24EbObBIk067cyrHAmMLbd2Km
	0=
X-Gm-Gg: Acq92OGWdcRkZ+HaN5k1sqvGxchn7QWkrIJXo5IcsACOZQApJQ+JYX2e/ygsiJDMbPc
	I6aVnwhCPzw8btxBrfIOvwUeuYH+WmNZRwNLuKsmwrSesI3G5ZYBBnWcKy+C6BKu1auvqZlruvG
	3ttXg+n9F7NLEyYoV9Y4yyrUdzf8lofpcm83b8VwDU77rpC61x7ox0gSud0nHROarYpOPN7RN4s
	yTFCRyhzveCSDsw36X44tBumtiaqg5i1hP8B9aWEzCGBAEV4eylML1i1dNeO3lWaaVIven6QJeo
	0gPR2QSMFEEKPAw3wzwcPzcv0IIDcu5Vf0vY7aC7v1evfgY2jbW4kO2RB5hEWX6AaUkCIRK8x7b
	2+Ltwp1j7UalfBPEAiPiKZXj+u+jeYAyauuI6
X-Received: by 2002:a17:90b:1808:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-37c2bd5b02bmr5322482a91.23.1781393361009;
        Sat, 13 Jun 2026 16:29:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1808:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-37c2bd5b02bmr5322467a91.23.1781393360635;
        Sat, 13 Jun 2026 16:29:20 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c86651a0090sm5119636a12.26.2026.06.13.16.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 16:29:19 -0700 (PDT)
Message-ID: <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
Date: Sat, 13 Jun 2026 16:29:17 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com,
 linux-security-module@vger.kernel.org
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
 <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 13:47, Paul Moore wrote:
> On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>>
>> Just as proc_pid_attr_write() already does before calling the LSM
>> hook. This only matters for SELinux and AppArmor which check
>> whether the process is being ptraced and if so, whether to
>> allow the transition.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   security/lsm_syscalls.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
> hold on to it until next week before sending it to Linus.  While I
> can't see why John would have any objections to this, the extra time
> should give him a chance to respond.
> 
you would think?
well finally getting this far back the backlog (sorry)

no objections

