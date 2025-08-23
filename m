Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5B22DFA5
	for <selinux@vger.kernel.org>; Sat, 23 Aug 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755990024; cv=none; b=rLoc2Eqxi3w43E8qjeTfjvR8Vls651zE56ZHaaSwzNfKkOtVlpn7K1OCjNc1E4aBxR9JyGKSDgBArSOGBMPkIHi78EWXitDBGcSsKKxeGkctSdwIa4ewSDXQYmHd2DBMrZ+T7O1+2a6sitDnPS5kYuMfalxNyyL3Gi+YCBemNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755990024; c=relaxed/simple;
	bh=Ri22cNfdnKHIHUXFd/pgqVBS9GD3zmbaKwsaRCETXeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0gaoltYLG91XmvcdBNwaFDyCV1XUU3BbMpaI2fcFNEK15yXvmqexlImF8C59llGfKmZ25xGAvjo3Z4YknmrjVOzyD6B4Ln8U+GU9FjEpMiwInozC1HKtl4mIy0rAa43GnB5UiYpxS/c53sCx6PYCxYytifacIU2Z4Sg42eWyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dlelskLB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dlelskLB"
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF4754121E
	for <selinux@vger.kernel.org>; Sat, 23 Aug 2025 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755990013;
	bh=+iL6G6FlAx7fdjD5SOe9TdNAg2cc6mtD1588FZiKemQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=dlelskLBLoo2vto0i0QuX1ZGUV8MFiF4LG14jobGReMFxKemzOUXLvxzMcyG0qOaG
	 4dIHCrteufxJdikp0LaL73ftcaMoKf10oerRqXaaAq7M3wj3NEQysnF56nasSBLmQW
	 FgCyNsWny2V/qr24MFMuKu3nEbg1PXoCfwAOM1Rcgs+Kn+G5QJ/56PAZuxFJS66E4k
	 RKY3R7L3rsbaXoN071MBOjVKLHP926xtWcF85jNlQioRiUrMLIOjgwaZ7orRqxUaHa
	 GuctD5JVLiPlgkzxg9J5uEHTT0nYNc69/x2lbjHA9JUYdCf1F1DKCVd/tnioqWtSOW
	 nDxgrWVKZaY+w==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47610d3879so2613363a12.0
        for <selinux@vger.kernel.org>; Sat, 23 Aug 2025 16:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755990011; x=1756594811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iL6G6FlAx7fdjD5SOe9TdNAg2cc6mtD1588FZiKemQ=;
        b=vA2rsA7HiiRv6GIqRqP/tEeJdOwXn0kbb65KnqZn7JcX1AWLPbLVwExWZ8E4y+rzD2
         HPqhoJIlEHESWRV5bj+GDf6Dk+VSoNs1I+Mq1N3gXlPPLBRHEphJwprmHeZncz/ywAYh
         ygbXA3Wcx31IBNeOzx5QOC6s6WCpnYe2yYqLazdv3cgUMneRaqXTmWXCDfcVqSBuIL5i
         ZJn5kroAolJYUTlg/k+AoZ/A7rkC91YHCsK8DyAJdAUShLKW++gwd0JOXB2uwq4n6EpF
         SvfpIQLtDr/EXAWBloZu4X50ZwiSPJRjtYw0K/XgOjxfc00AeGbyqDDVX0XpCQnvJjkh
         kdzA==
X-Forwarded-Encrypted: i=1; AJvYcCUXuODb3K1bjN65ftjilhPnj+WShycgLildeUk5cXMqCYdo+qe+ZSFGFXtJpTmO8AO/trSRvnjT@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYOlA++9HOO0au2EEnWZmBjPf5XXjHW4BAbM/wlOW+c+NluvU
	gkpl15EpkEL2DG97AZ68T1ZukauAzkaqyq0YQHzY7Qu1ZvZo4nOlnj9dbW98+ooqq5MFLcsyCm8
	0hpSvrTz0uXegekJevZZVkUeGoGwMO+HnomYXkVS4pOWTP7ZKAtuqkfCe0Z9cazDjEM07UNYE0L
	g=
X-Gm-Gg: ASbGncvL2JZW8G3wrV2cnGNIL7vHiWAtOrr7rPf32YmJHz/whAH+9W6vtbJAHtlYDzQ
	9yOFc7V1ekiXRHozJuHoye1cJdqjhwK6Q/BBtVwicnuDLoJxFe7vIXTOjL+kLGOp54qPL31tCou
	0dkIGMH0IMeL5iNnlA2zhwOH2y0/FOM5K1OquzR38IIG1QrPF9HwCvEBqJzoZ8iKZkA8YC7F4qg
	M8Thmt/qKO+1ND7AEkD9Orl2NDi1TZeDHIWZ92v0EkWKPrOvGYh4px580PVfdBPp730fARsFriC
	rm4WoVbuhmIOsNleXgrG2HShiRx/GYTdZEt9HPZTUyGzMMx59eBbkA==
X-Received: by 2002:a17:903:240c:b0:23f:c945:6067 with SMTP id d9443c01a7336-2462ef61b0amr87519035ad.41.1755990010888;
        Sat, 23 Aug 2025 16:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdFgQBHjs4i5DefpaxwL17hXeFmj+xxt7TNbxjKkqupjBN+pB4lQ+zPKd549SDZxWNtmIoWA==
X-Received: by 2002:a17:903:240c:b0:23f:c945:6067 with SMTP id d9443c01a7336-2462ef61b0amr87518605ad.41.1755990010316;
        Sat, 23 Aug 2025 16:00:10 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-246687b1525sm30347635ad.54.2025.08.23.16.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 16:00:09 -0700 (PDT)
Message-ID: <55869acd-5666-4647-9fe8-5c16fbcbf68a@canonical.com>
Date: Sat, 23 Aug 2025 16:00:08 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore
 <paul@paul-moore.com>, Micka??l Sala??n <mic@digikod.net>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Maxime B??lair <maxime.belair@canonical.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <20250820.xo0hee4Zeeyu@digikod.net>
 <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com>
 <5612ec76-9257-402b-ac98-bdc8a8287a60@schaufler-ca.com>
 <47fb07e3-5047-49dc-b5fa-83b4f82f9dce@canonical.com>
 <20250823174101.GA22123@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250823174101.GA22123@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/25 10:41, Dr. Greg wrote:
> On Fri, Aug 22, 2025 at 12:59:29PM -0700, John Johansen wrote:
> 
> Good morning, I hope the weekend is going well for everyone.
> 
>> On 8/22/25 07:47, Casey Schaufler wrote:
>>> On 8/21/2025 7:14 PM, Paul Moore wrote:
>>>> On Thu, Aug 21, 2025 at 6:00???AM Micka??l Sala??n <mic@digikod.net>
>>>> wrote:
>>>>> On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
>>>>>> On Tue, Aug 19, 2025 at 1:11???PM Casey Schaufler
>>>>>> <casey@schaufler-ca.com> wrote:
>>>>>>> The advantage of a clone flag is that the operation is atomic with
>>>>>>> the other namespace flag based behaviors. Having a two step process
>>>>>>>
>>>>>>>          clone(); lsm_set_self_attr(); - or -
>>>>>>>          lsm_set_self_attr(); clone();
>>>>>>>
>>>>>>> is going to lead to cases where neither order really works correctly.
>>>>>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>>>>>> where the unshare isn't immediate, but rather happens at a future
>>>>>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>>>>>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>>>>> The next unshare(2) would make more sense to me.
>>>> That's definitely something to discuss.  I've been fairly loose on
>>>> that in the discussion thus far, but as things are starting to settle
>>>> on the lsm_set_self_attr(2) approach as one API, we should start to
>>>> clarify that.
>>>>
>>>>> This deferred operation could be requested with a flag in
>>>>> lsm_config_system_policy(2) instead:
>>>>> https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical.com
>>>> I want to keep the policy syscall work separate from the LSM namespace
>>>> discussion as we don't want to require a policy load operation to
>>>> create a new LSM namespace.  I think it's probably okay if the policy
>>>> syscall work were to be namespace aware so that an orchestrator could
>>>> load a LSM policy into a LSM namespace other than it's own, but that
>>>> is still not overly dependent on what we are discussing here (yes,
>>>> maybe it is a little, but only just so).
>>>
>>> Policy load and namespace manipulation *must* be kept separate. Smack
>>> requires the ability to "load policy" at any time. Smack allows a process
>>> to add "policy" to further restrict its own access, and does not require
>>> a namespace change. There has been an implementation of namespaces for
>>> Smack, but the developers disappeared quietly and sadly no one picked it
>>> up. Introducing a requirement that LSMs support namespaces in order to
>>> load policy beyond system initialization is a non-starter.
> 
>> yes the ability to load policy must be exist separately, however
>> policy load could be made namespace aware so that a parent could
>> inject policy into a child.
> 
> Policy or model load, specific to the subordinate namespace, will be
> a necessity.
> 
> As Casey noted, some LSM namespaces will require configuration and
> management calls well after the namespace has started.  Other LSM's
> will want the configuration to be completed before the namespace
> starts, with any further configurations to the namespace blocked.
> 
> There is a very valid security rationale for isolating the capability
> for namespace separation from the capability that allows the
> configuration of a security model.  It would be an entirely realistic
> security objective for a namespace to block further separation
> attempts, while still allowing for management operations to be
> conducted in the context of the subordinate namespace.
> 
> Hence the rationale for splitting CAP_MAC_ADMIN from whatever name the
> bike shedding process around the new capability naming process
> produces.
> 
>> There is also an open question as to whether we need to allow, but
>> not require, some kind of policy manipulation/injection with the
>> creation of the LSM namespace so that the there is an atomic
>> transition with entering the namespace. Is there a case where policy
>> really needs to be present atomically with the creation of the
>> namespace? If so we need to further break it down to
>>
>> 1. is it sufficient for the LSM to do it, without container manager
>> guidance?  An inherit of policy, or already present policy that can be
>> injected. Then we don't need policy load inject to be considered at
>> the point of clone/unshare.
>>
>> 2. do we need to let the container manager hint/load policy.
> 
> Policy load needs to be atomic with respect to namespace separation.
> In other words, the policy needs to be in place when execution within
> the context of the new security namespace begins.
> 
no, it _may_ need to be depending on the model/policy being used, and
an LSM is in the best place to make that decision and do it for its own
policy as long as the infrastructure supports it.

> A resource orchestrator will need the ability to load the new policy
> that will be enforced into the context of the new namespace.

No an LSM is fully capable of doing this and honestly in a better
position to do so for its own policy than an external orchestrator.
Where coordination orchestration is need is at the infrastructure layer
(LSM), to ensure once everything is decided by inidivual LSMs that
what the security context is atomically setup correctly.

So in that sense the LSM infrastructure is an orchestrator, but only
in the loosest sense.

> 
> In the case of some model/integrity based LSM's, the security events
> related to the policy load need to occur in the context of the parent
> LSM namespace.
> 
yes, it very much depends on the model. I would argue if the LSM needs
this.
1. the policy at the exec/fork/clone/unshare point already needs to
    be loaded.
2. the LSMs policy needs a way to initiate the transition. Eg. in
    the selinux case, the transition is setting up a new layer in
    mediation that will be bounded by the previous layers. There isn't
    a transition from one policy to another, but adding a new layer
    on top of.

> See the writings of Werner Karl Heisenberg for the reasoning behind
> that... :-)
> 
>> So far I think the inherit/policy directed injection works for
>> apparmor, and selinux. Container managers generally speaking have to
>> additional setup after the container is created before running the
>> work load, which means a separate load phase should be fine.
>>
>> However I can see an argument for having policy in place when
>> clone/unshare exit. Admittedly atm its largely around flexibility, and
>> nebulous ill defined use cases. Just because something works for
>> apparmor, selinux, and I think smack, doesn't mean it would work for
>> all use cases.
>>
>> But we also should add flexibility for flexibility just because we can
>> see there might be some future utility for some future use case. It
>> would certainly make the interface uglier, and more complicated, and I
>> would hate to have to carry that without a concrete use case.
>>
>> I think unless there is a solid use case for making clone/unshare
>> policy aware we don't worry about it for now. A new interface can be
>> add in the future if the capability is really needed.
> 
> We will respond more directly to the issue of clone, unshare and
> external process entry, in the other thread where you initiated a
> discussion of these issues.  We believe there is a strong argument to
> be made that LSM namespace separation is a poor fit for the classic
> fork/unshare model of the other resource namespaces.
> 
the other resource namespaces being able to move independent of the
security namespace, or at least mediation by the security namespace is
a complete disaster and should not have ever been allowed.

> Among other issues, a direct separation model places the complexity of
> policy verification and loading in userspace.  As was noted above,
> accounting for the security events related to the policy verification
> and load process, in the orchestrator process, will be a requirement
> for some integrity and functional models.
> 
There are different levels of verification. It makes sense to do some
of it in the individual LSM, some of it in userspace, and potentially
some at another level in another LSM. Unfortunately Linux has forced the
concept of containers to be a user level construct, and this forces
certain verifications around containers to be in userspace.

AppArmor does a policy verification checking that policy meet all the
bounding constraints etc. Is very different than the verification check
that IMA may doing check that this policy is blessed and allowed to be
loaded. AppArmor could support some IMA verification but is very much
designed to be like landlock in that unprivileged userspace _may_ have
privilege to load policy into the kernel. You may not want to allow
that on some systems, but you certainly do on others. The system level
signature check that IMA does isn't appropriate for unprivileged
user policy. But the apparmor verification check is.

and Yes something like IMA that is doing a system level integrity is going
to need a post policy load callback to do verification. This again doesn't
need an orchestrator, but just support in the infrastructure, and a
callback that individual LSMs can trigger. See the work Paul is doing
to rework the LSM init or how IMA is doing a verification of selinux
policy.

Of course you have to trust the LSMs to trigger the callback, but its
opersource and the code can be checked. If you can't trust the individual
LSMs you have a much bigger problem because you just can't trust a
monolithic kernel and you are going need a trust zone/hyper visor above
the kernel to do any form of integrity check you can trust.


> Have a good weekend.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project
> 

