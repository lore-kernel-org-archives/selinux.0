Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1484298CA2
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892778; cv=none; b=EgT3j0zuK8aJkklp2h3TUoO4nXkeZEAq+YIc8lgxpMyn3oz0bkMdSty6OOnJvr4V2zH4P+CxJi0YT7f9uXAckoctDK/8y9k/TUSt4rJ+lui26mlnxErI/xU0wDOako+ttlOv9BTW4zTgL/L7hIImlghBywsqpYQ1bPNBhvVmDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892778; c=relaxed/simple;
	bh=5o5iNF5vR3Y3p9dV+cI1rL7eyLwuB/IxntgySa7q/RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BesOP0KVs7GhCSRra47uddXoOYMWZj4T7b/DmSOauSiq3DrNAGUrzrjYnJN1OREl0Z3ACsSUEuWjevDBzF7VkcsITq32bhUyQIvhb5zTqrt1GFqTQxJjpJKpOwJWVayg5titQw7sFlmFE/V4iGZ54WxzmS4UTwOVz9p1KvNB7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sLzAu+0a; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sLzAu+0a"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B827C3F37D
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755892773;
	bh=bI/oV2xm0uXYEj6u6e/KKEWhLtafSGL7rix/Hpjl/6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sLzAu+0aRPmo4amhMEHnl8bK2gDcXoESV8VDc9aE+T0/y0jWOsSd3dd7ZAY/nMi7d
	 /fERXS1jVrwLVOiQMKRZbSaWNYgdgedA6/1pz6h2bymnLLUAInHSuwdjzCKZO2OXFx
	 zePudHt9rWP6JAwkJXQWBjqb3OB6bcSmsIDDNWRQh3gKhaHFtHurrJI5bg2gb5A0/5
	 B7f21OpFKAiJXe8VAgBYvd/UF5HTKNWz4BxsYVyDTwwlPEV5hFM57Fbe+xPO8PYM6W
	 JmW8dYoVi6FBR/ALulVEPKWigBwIyD6CrZiP0D9FeZnV6fGCY+S4muUqo0k1tXiD1X
	 FM7l7owQqKaSg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2465bc6da05so6868745ad.0
        for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 12:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892772; x=1756497572;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI/oV2xm0uXYEj6u6e/KKEWhLtafSGL7rix/Hpjl/6E=;
        b=hgDe0EmfxDJxjFELVBBxngpadszeu3IdZIcVkjAK8pUIbrjxSNi2RoYjisdBo1YqKD
         R0RkLfTke5z8/6EFmpwcHB2JC8Z8wfKmOj4zkLOQDyJYUks5guSPyKd8Pohz+SzvLzR0
         Zb4bdC7Q4sEGcLwaSjEJXtlhJmh84iciU2v3S1QEKyrlqkQ22ajIKtElyYfWstJ84EsC
         Vwa3c0K1joMKhVioS64xNtoHpT0lw1/oDs7QMpG+2i7cFujTn85vW05JY67WdZ2bNRwn
         NosoOO0IqHHsJrQCymf1T63WwpkFpxboJ0t26Ma5HyqFpAFWQJfxzZotPIS+Djk9CTit
         rqVw==
X-Forwarded-Encrypted: i=1; AJvYcCUvKu8RImVQX4ZiUIaIciiY+diEBMpRV1+/3BVNGsK6wDbdmDenOJO+LdmyWZOzFdR2G2kIOtlx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DIW564gAzF0FgPJorHpNASyZzlySw0uMk8sTbtIwdq5X/RLM
	KzTlG/u5YA8HZ13xN1lKJZRFrT1er/ZPf7iNVP9BsVgnMkNHXFzgxDa5JWbV1E2YVrOChTHmxzM
	/Lnw71hPSMPm0Rlul2JCPvAvHlD8MkyxCrSpA07A8Pc3u92GX00FHQvuNnTzN3mbI5qfr08Oz3o
	i+A1psnmo=
X-Gm-Gg: ASbGncu44KkkgknFzbmR6Sjy2u/MO0s+UHQxuelK66y296U0M0ix33duNViZb+DWlzs
	tEyMkziUGdw24VUXl+JHPsaKs50Nu6IMLGUT25rGklEAGX24ZoxcgyMO9FhkDJ4WtYJ5kOFQS3y
	zuu2FWzg+Kn2SR5aC8u5qTd+n0Cj/RsCyUuKyThBIDkyGffGMwrdhIGvNv3BrqJVLp9hVlhlONT
	NdIfDFGp8z5tepQXLpKX8DWXzjiVWQcqBh1vbzqIE5svG/phLFEpa34USTXP9uVZECHUUkM7IW8
	ugbrmSxdY8sBy5v7AkC4My3vOHhhH7MbXbRxRXhLXirOymW7aZTDSg==
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr35801885ad.5.1755892771946;
        Fri, 22 Aug 2025 12:59:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3qpYSvHC+OZRK+eA+RVCmZkR0p+1DMePLmyzuuXlBp7zlP9fYNLsL+nXYkfx6nq46onbZtw==
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr35801515ad.5.1755892771466;
        Fri, 22 Aug 2025 12:59:31 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466886456csm4054785ad.72.2025.08.22.12.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:59:30 -0700 (PDT)
Message-ID: <47fb07e3-5047-49dc-b5fa-83b4f82f9dce@canonical.com>
Date: Fri, 22 Aug 2025 12:59:29 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore
 <paul@paul-moore.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <20250820.xo0hee4Zeeyu@digikod.net>
 <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com>
 <5612ec76-9257-402b-ac98-bdc8a8287a60@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <5612ec76-9257-402b-ac98-bdc8a8287a60@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/22/25 07:47, Casey Schaufler wrote:
> On 8/21/2025 7:14 PM, Paul Moore wrote:
>> On Thu, Aug 21, 2025 at 6:00 AM Mickaël Salaün <mic@digikod.net> wrote:
>>> On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
>>>> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> The advantage of a clone flag is that the operation is atomic with
>>>>> the other namespace flag based behaviors. Having a two step process
>>>>>
>>>>>          clone(); lsm_set_self_attr(); - or -
>>>>>          lsm_set_self_attr(); clone();
>>>>>
>>>>> is going to lead to cases where neither order really works correctly.
>>>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>>>> where the unshare isn't immediate, but rather happens at a future
>>>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>>>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>>> The next unshare(2) would make more sense to me.
>> That's definitely something to discuss.  I've been fairly loose on
>> that in the discussion thus far, but as things are starting to settle
>> on the lsm_set_self_attr(2) approach as one API, we should start to
>> clarify that.
>>
>>> This deferred operation could be requested with a flag in
>>> lsm_config_system_policy(2) instead:
>>> https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical.com
>> I want to keep the policy syscall work separate from the LSM namespace
>> discussion as we don't want to require a policy load operation to
>> create a new LSM namespace.  I think it's probably okay if the policy
>> syscall work were to be namespace aware so that an orchestrator could
>> load a LSM policy into a LSM namespace other than it's own, but that
>> is still not overly dependent on what we are discussing here (yes,
>> maybe it is a little, but only just so).
> 
> Policy load and namespace manipulation *must* be kept separate. Smack
> requires the ability to "load policy" at any time. Smack allows a process
> to add "policy" to further restrict its own access, and does not require
> a namespace change. There has been an implementation of namespaces for
> Smack, but the developers disappeared quietly and sadly no one picked it
> up. Introducing a requirement that LSMs support namespaces in order to
> load policy beyond system initialization is a non-starter.
> 
yes the ability to load policy must be exist separately, however
policy load could be made namespace aware so that a parent could
inject policy into a child.

There is also an open question as to whether we need to allow, but not
require, some kind of policy manipulation/injection with the creation
of the LSM namespace so that the there is an atomic transition with
entering the namespace. Is there a case where policy really needs to
be present atomically with the creation of the namespace? If so we
need to further break it down to

1. is it sufficient for the LSM to do it, without container manager
guidance?  An inherit of policy, or already present policy that can be
injected. Then we don't need policy load inject to be considered at
the point of clone/unshare.

2. do we need to let the container manager hint/load policy.

So far I think the inherit/policy directed injection works for
apparmor, and selinux. Container managers generally speaking have to
additional setup after the container is created before running the
work load, which means a separate load phase should be fine.

However I can see an argument for having policy in place when
clone/unshare exit. Admittedly atm its largely around flexibility, and
nebulous ill defined use cases. Just because something works for
apparmor, selinux, and I think smack, doesn't mean it would work for
all use cases.

But we also should add flexibility for flexibility just because we can
see there might be some future utility for some future use case. It
would certainly make the interface uglier, and more complicated, and I
would hate to have to carry that without a concrete use case.

I think unless there is a solid use case for making clone/unshare
policy aware we don't worry about it for now. A new interface can be
add in the future if the capability is really needed.




