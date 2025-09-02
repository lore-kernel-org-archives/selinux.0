Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2312F5485
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810554; cv=none; b=qatgeA7jJKUqgk9MFY8vk3ONb92VIAwkDfI8VgiWf2SjYMdr2tUtxltuO25fbUBwxvRbJkNMz2lqiQkOtaXi7scLzzkjYmPjGP6IEfXAzZXSpO0AeV3E+f9WWl1wK5384xEyZiB90JcjEJm9lIz0GV1uzZekr9U/bASjgr2yzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810554; c=relaxed/simple;
	bh=ByuBIuwAWIxSLClTIUZN4ySZrSFmL+PeRsdIKSKSjgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRoMkKA7j424ovlLH9c8wIk/HR2GOefHljcOllGPL2Y1TPOuz9MxfK6Fajs3gPwLd27NIbn8sPE58XjCbaCIKYPMtbLCdYaKJ4TeI6kz6UZvHgPhwC1udFmN76j97sqkOOpbnzLyWJ1bbZW0CBvgYN4YNx9xE5s8kQeWpL0tY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I28APpwY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I28APpwY"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2038B3F078
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756810543;
	bh=g0AESLL/ny5eMLIMELNF6/UviHrWXVaIVvb0JDKI3FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=I28APpwYd8g0q2a1hjiAu7OHGiTjFlLUGVTjoLgBLrB/fNgKwTxd3CdedVlexDanU
	 KEKU1sRlbeTJIKi6OIXsVMQ1NLAle7KMv032AwQAQVIidcSSlA73UbZ9orOMCXyDRR
	 ek3mx0uP94bi6W2tPyUviDOKbis1jFJ/qaORJLbKA+aM9seOiNj3ByQGtB2G1Kn9cw
	 ECnyNS4OOZ1Q4oDSiHL9qgJoCpOzhqvaINEcDNVcnGj1L9/W/9YCUBsD2wo5C9EJLl
	 Kf+rIVTPTG2gZMt+4oq+h0reNiF4ePOYQwZEuXi2iDswyFqAoIWVJJly74WQYUeVrv
	 jg2KllXjj0plA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e395107e2so5167131b3a.3
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 03:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810542; x=1757415342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0AESLL/ny5eMLIMELNF6/UviHrWXVaIVvb0JDKI3FI=;
        b=Z2SIwUMuissNIj7bA+vsWMVNwPjsXxe6nX14fVzLtMAmjwvzP6Szq8mjFi/tkyNy7Q
         kSSmEPf1sVjN9uASOapOrKolJvk8tWpNkSA1Z/6JgNKifkDxE19CCaY4ztZG0bqRly8o
         7Uv7XaSJcgFuaQV7TkuEYrRAWS08qMMjQizQQkZtP+yOJJf1rDGxeZf3XqNf0le3hHJ4
         GX1D2XyIOM22uuI985mXVz2VYhZSS+/rIqr5BtQ3bF0ojte+AF6VkHOm6lJ5zwq2Q7WA
         OPBWnzhZ3He8JBvnV3DXG/dLweCn2jQ/F5y3P2p7clMPwsJPWbcS7TbVXK5WqYsXHYKE
         7LeA==
X-Forwarded-Encrypted: i=1; AJvYcCXOCyrf+jLmJ5uf6fiJBYqgp5ZIlNm7kIv6ma8AGznWmoRXVZLk+FJxlW+NcJh7xTU0leAQbpPi@vger.kernel.org
X-Gm-Message-State: AOJu0YwREZJSW07Q8F2nyjZAb7p8UwEI6mUfceVuQiuBKqrFIFbQwNNn
	UGBy4v1oG5paHZJTDa33alW3iWzoj2Qwz2ONUwm9ORj+doTXbopqjYsr7rC4Q5xtbOp0U/p2B/K
	bX5SBLT0XLtVbUruLC0hm/fXKh8MefAJ2owxxPSHVqj76xh/k52NMTKwtFxjwXLII12Sgh0WXk0
	k=
X-Gm-Gg: ASbGncslyZh1H2y/mr/MUT0sZJ+lOR0o5BM/Cn0pW7KCXZcereC9RKmHFELCAqNkriP
	ssbKh8enGVZqQDrlHsqGEHF3LnWNctQqEp9x1/6SH5R0pvrNOXtD6FV5vFfS9RXtD/GLbyimJfE
	cQvmv81UKYAbhD9CAFhBQTGQ4fQGkq+mmmxTrMIp7v9nHPUfpEqrx9kE4L9Pr8uB+0Z1t0FwN7/
	XmNbYA3xNOI8oQXTFmnA68qDK5yVu1GdjMXVv6pPHUWaHGndSdLViqcRAqjY5H0TF0hhH/gfYrg
	30nwouZ8wZjZcR7AcSlFHzYX9jlkPsnKWCjw262Th2q34zmbtIlSvw==
X-Received: by 2002:a05:6a00:1748:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7723e3fcb56mr13975146b3a.29.1756810541516;
        Tue, 02 Sep 2025 03:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCN7M6kUCwWtQ3IZH+i1LnZV9W02oNZNisGV980uF1TpDab6pinXpPyBVjYvpid9hfFlg01w==
X-Received: by 2002:a05:6a00:1748:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7723e3fcb56mr13975107b3a.29.1756810540931;
        Tue, 02 Sep 2025 03:55:40 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm13100776b3a.24.2025.09.02.03.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:55:40 -0700 (PDT)
Message-ID: <fc3aadf1-9598-4fc2-bdb9-290df425b5d8@canonical.com>
Date: Tue, 2 Sep 2025 03:55:39 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
 <aKcskclwVVe1X4kP@mail.hallyn.com>
 <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com>
 <20250901160102.GA9179@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250901160102.GA9179@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 09:01, Dr. Greg wrote:
> On Thu, Aug 21, 2025 at 07:57:11AM -0700, John Johansen wrote:
> 
> Good morning, I hope the week is starting well for everyone.
> 
> Now that everyone is getting past the summer holiday season, it would
> seem useful to specifically clarify some of the LSM namespace
> implementation details.
> 
>> On 8/21/25 07:26, Serge E. Hallyn wrote:
>>> On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
>>>> On 8/19/25 10:47, Stephen Smalley wrote:
>>>>> On Tue, Aug 19, 2025 at 10:56???AM Paul Moore <paul@paul-moore.com>
>>>>> wrote:
>>>>>>
>>>>>> Hello all,
>>>>>>
>>>>>> As most of you are likely aware, Stephen Smalley has been working on
>>>>>> adding namespace support to SELinux, and the work has now progressed
>>>>>> to the point where a serious discussion on the API is warranted.  For
>>>>>> those of you are unfamiliar with the details or Stephen's patchset, or
>>>>>> simply need a refresher, he has some excellent documentation in his
>>>>>> work-in-progress repo:
>>>>>>
>>>>>> * https://github.com/stephensmalley/selinuxns
>>>>>>
>>>>>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>>>>>> about SELinux namespacing, you can watch the presentation here:
>>>>>>
>>>>>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>>>>>
>>>>>> In the past you've heard me state, rather firmly at times, that I
>>>>>> believe namespacing at the LSM framework layer to be a mistake,
>>>>>> although if there is something that can be done to help facilitate the
>>>>>> namespacing of individual LSMs at the framework layer, I would be
>>>>>> supportive of that.  I think that a single LSM namespace API, similar
>>>>>> to our recently added LSM syscalls, may be such a thing, so I'd like
>>>>>> us to have a discussion to see if we all agree on that, and if so,
>>>>>> what such an API might look like.
>>>>>>
>>>>>> At LSS-NA this year, John Johansen and I had a brief discussion where
>>>>>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>>>>>> could opt into via callbacks.  John is directly CC'd on this mail, so
>>>>>> I'll let him expand on this idea.
>>>>>>
>>>>>> While I agree with John that a fs based API is problematic (see all of
>>>>>> our discussions around the LSM syscalls), I'm concerned that a single
>>>>>> clone*(2) flag will significantly limit our flexibility around how
>>>>>> individual LSMs are namespaced, something I don't want to see happen.
>>>>>> This makes me wonder about the potential for expanding
>>>>>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>>>>>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>>>>>> provide a single LSM framework API for an unshare operation while also
>>>>>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>>>>>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>>>>>> individual LSMs can opt-in to the API fairly easily by providing a
>>>>>> setselfattr() LSM callback.
>>>>>>
>>>>>> Thoughts?
>>>>>
>>>>> I think we want to be able to unshare a specific security module
>>>>> namespace without unsharing the others, i.e. just SELinux or just
>>>>> AppArmor.
>>>>
>>>> yes which is part of the problem with the single flag. That choice
>>>> would be entirely at the policy level, without any input from userspace.
>>>
>>> AIUI Paul's suggestion is the user can pre-set the details of which
>>> lsms to unshare and how with the lsm_set_self_attr(), and then a
>>> single CLONE_LSM effects that.
> 
>> yes, I was specifically addressing the conversation I had with Paul at
>> LSS that Paul brought up. That is
>>
>>    At LSS-NA this year, John Johansen and I had a brief discussion where
>>    he suggested a single LSM wide clone*(2) flag that individual LSM's
>>    could opt into via callbacks.
>>
>> the idea there isn't all that different than what Paul proposed. You
>> could have a single flag, if you can provide ancillary information. But
>> a single flag on its own isn't sufficient.
> 
> If one thing has come out of this thread, it would seem to be the fact
> that there is going to be little commonality in the requirements that
> various LSM's will have for the creation of a namespace.
> 

yes

> Given that, the most infrastructure that the LSM should provide would
> be a common API for a resource orchestrator to request namespace
> separation and to provide a framework for configuring the namespace
> prior to when execution begins in the context of the namespace.
> 

hrmmm, certainly a common API. Any task could theoretically use the API
it doesn't have to be a resource orchestrator, but I suppose you could
call it such.

I also dont know that we need to provide a framework for configuring
the namespace prior to when execcution begins in the context of the
namespace. It might be a nice to have, but configuring of LSMs is
very LSM specific.

We don't even have a common LSM policy load interface atm, though there
is a proposal. Configuration is a step beyond that. Would it be nice
to have, sure. Are we going to get that far, I don't know.


> The first issue to resolve would seem to be what namespace separation
> implies.
> 
> John, if I interpret your comments in this discussion correctly, your
> contention is that when namespace separation is requested, all of the
> LSM's that implement namespaces will create a subordinate namespace,
> is that a correct assumption?
> 
No, not necessarily. The task can request to "unshare/create" LSMs
similar to requesting a set of system namespaces. Then every LSM,
whether part of the request or not get to do their thing. If every
LSM agrees, then a transition hook will process and each LSM will
again do its thing. This would likely be what was requested but its
possible that an LSM not in the request will do something, based
on its model.

In the end usespace gets to make a request, each security policy is
responsible for staying withing its security model/policy.

> It would seem, consistent with the 'stacking' concept, that any LSM
> with namespace capability that chooses not to separate, will result in
> denial of the separation request.  That in turn will imply the need to

Not necessarily. They could allow and choose not to transition. Or they
could not create a namespace but update some state.

> unwind or delete any namespace context that other LSM's may have
> allocated before the refusal occurred.

The request does need to be split into a permission hook and a
transition hook similar to exec. If any LSM in the permission hook
denies, the request is denied. If any LSM in the transition hook fails
again the request will fail, and the LSMs would get their regular clean
up hook called for the object associated.

> 
> This model also implies that the orchestrator requesting the
> separation will need to pass a set of parameters describing the
> characteristics of each namespace, described by the LSM identifier
> that they pertain to.  Since there may be a need to configure multiple
> namespaces there would be a requirement to pass an array or list of
> these parameter sets.
> 
yes it will require a list/array see lsm_set_self_attr(2)

> There will also be a need to inject, possibly substantial amounts of
> policy or model information into the namespace, before execution in
> the context of the namespace begins.
> 
Allowing for this and requiring this are two different things. Like I
said above we don't even currently have a common policy load interface.
Configuration is another step beyond policy load.


> There will also be a need to decide whether namespace separation
> should occur at the request of the orchestrator or at the next fork,

Or allow both, but yes a decision needs to be made

> the latter model being what the other resource namespaces use.  We
> believe the argument for direct separation can be made by looking at
> the gymnastics that orchestrators need to jump through with the
> 'change-on-fork' model.
>
Looking at current system namespacing we have clone/unshare which
really or on fork. setns enters existing namespaces.

We either need to create new variants of clone/unshare or potentially
have an LSM syscall that setups addition parameters that then are
triggered by clone/unshare. If going the latter route then its just
a matter whether the LSM call returns a handle that can be operated
on or not.

> Case in point, it would seem realistic that a process with sufficient
> privilege, may desire to place itself in a new LSM namespace context
> in a manner that does not require re-execution of itself.
> 
yes, but it is questionable whether security policy should allow that.
At the very least security policy should be consulted and may deny
it.

> With respect to separation, the remaining issue is if a new security
> capability bit needs to be implemented to gate namespace separation.
> John, based on your comments, I believe you would support this need?
> 
No, I don't think a capability (as in posix.1e) per say is needed. I
think an LSM permission request is.

>> You can do a subset with a single flag and only policy directing things,
>> but that would cut container managers out of the decision. Without a
>> universal container identifier that really limits what you can do. In
>> another email I likend it to the MCS label approach to the container
>> where you have a single security policy for the container and each
>> container gets to be a unique instance of that policy. Its not a perfect
>> analogy as with namespace policy can be loaded into the namespace making
>> it unique. I don't think the approach is right because not all namespaces
>> implement a loadable policy, and even when they do I think we can do a
>> better job if the container manager is allowed to provide additional
>> context with the namespacing request.
> 
> In order to be relevant, the configuration of LSM namespaces need to
> be under control of a resource orchestrator or container manager.
> 
No, the must be under the control of the LSMs.

> What we hear from people doing Kubernetes, at scale, is a desire to be
> able to request that a container be run somewhere in the hardware
> resource pool and for that container to implement a security model
> specific to the needs of the workload running in that container.  In a
> manner that is orthogonal from other security policies that may be in
> effect for other workloads, on the host or in other containers.
> 
sure, assuming the host policy allows it. Otherwise it is just a host
policy by-pass, which can not be allowed. K8s people have a specific
use case, they need to configure the host for that use case. They can
not expect that use case to work on host that has been configured
for say an MLS security constraint.

> Hopefully the above will be of assistance in furthering discussion.
> 
> Have a good week.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project


