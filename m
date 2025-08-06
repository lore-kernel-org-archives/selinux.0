Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F52E36E7
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505027; cv=none; b=p1AP7DreRgbask1hy4OuMGcdwF6m5umcz3SCRWlVr4wwfYIf4JGzOAs9DDcvIZS+j9YGX4sHwug1+mkrSFUXpi+cXB2Ugb5YFYDi4cTO9JVlZrMqkj0Bqy+7QCwH4qO2goX0akjkvNB/Cgs2JbvE8FaJYs6mAZSp7iUq6+7dCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505027; c=relaxed/simple;
	bh=ZPIdYRItYN/q6flawpMCjxN7Jjbd8t5KjdF/U+9Fl+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fwfnykbb0oF4ooMfAwvmzQ7gOW8kPxqHYVhZA+TDBD+Gr0z8+JAoEVbZ8iXVNPOw4cQHeAYo02qvBDXQ+wQujUcOzi0W+7hPeYBJfITBuvp189XPNqz7wP5+/1yYqF3NnihDptiPVk9dFNfPvN4bspTJ1++uHb+adlNIsiG+bws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oQjY9f8j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oQjY9f8j"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCFC42030ED2;
	Wed,  6 Aug 2025 11:30:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCFC42030ED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754505025;
	bh=MBBiE2y+EnUZhmAZja4SSdANUCXxoHK5YYLUemnHffY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oQjY9f8j74QXDcROVW1S/12HjBpSzK6pYM9sZe6JJTcmI8aOdjOGYAUq5go8QgptG
	 jvCRQdPrqU39n81BoN0vtt02cHfXRNUYXS20aDcIadrkFWGUilJmMxaHuDoruKmqTy
	 PgiHt9FzOBB9TTltC+ID7D/6ikXaPbfR09yfX/JM=
Message-ID: <a02d37ef-3b1c-45f7-925e-fbe05e839197@linux.microsoft.com>
Date: Wed, 6 Aug 2025 11:30:25 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable
 hooks
From: Eric Suen <ericsu@linux.microsoft.com>
To: Daniel Durning <danieldurning.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 selinux@vger.kernel.org, omosnace@redhat.com
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
 <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
 <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
 <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAEjxPJ6wM2Jv6J7Vdmk8H4GYXGgoeQFqZfRK3EZkv=9MgOdAXQ@mail.gmail.com>
 <CAHC9VhSmgVM07r=ogDq69gxhVUSMvTh73h6db1dcYiX8XuTdBg@mail.gmail.com>
 <CAKrb_fEe8UmSMXpv2qHNiSMxhJz-msztxeDqzp0n1MckY3BRSw@mail.gmail.com>
 <b69d2b6e-544f-400e-bde6-9aaa4b2964f4@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b69d2b6e-544f-400e-bde6-9aaa4b2964f4@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/2025 11:19 AM, Eric Suen wrote:
> On 8/5/2025 7:17 AM, Daniel Durning wrote:
>> On Mon, Aug 4, 2025 at 4:13 PM Paul Moore<paul@paul-moore.com> wrote:
>>> On Mon, Aug 4, 2025 at 8:18 AM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> Eric - note that Daniel also posted a patch for the selinux-testsuite
>>>> to exercise these hooks and checks based on the Linux kernel self-test
>>>> for bpf tokens, see
>>>> https://lore.kernel.org/selinux/CAEjxPJ7DBDnZEFvgpe58K4B+4kZdOqUGMHvGC2vKt-4Zget=Hg@mail.gmail.com/T/#t 
>>>>
>>> FWIW, I believe Eric has some basic tests too, although I will admit
>>> to losing track of that aspect, as we have had several months of
>>> setbacks lately due to package building, email, etc.
>>>
>>>> Paul - it would be good to avoid such duplication of effort in the
>>>> future, maybe we should be tracking such things in the GitHub project?
>>> Yes, it's unfortunate when we see duplicated work, but thankfully it
>>> happens very rarely in our case.  We can track things on GitHub, but
>>> with development happening largely on the mailing list I'm skeptical
>>> about how successful that will end up being.  Our GH related efforts
>>> have been very mixed thus far.  Another option might simply be to tell
>>> people to announce a development effort on the mailing list, although
>>> I can see that having problems too.
>>>
>>> If there are some positives, it may be that both Daniel and Eric's
>>> work are still in the early stages, so there is likely room for the
>>> two of them to cooperate together on a solution.  Daniel, Eric, what
>>> do you think about that?
>> I would be happy to work with Eric on a solution. Looking forward to
>> seeing his patch once it gets posted.
>
> Thanks a lot, Daniel. I was actually hesitant to send out my changes 
> since you
>
> already have test changes prepared, and I didn’t want to step on your 
> toes.
>
> Really appreciate your openness to collaborate.
>
> I'll send out my patch soon and make sure to reference your test work 
> in the
>
> description.
>
>
Daniel - I just posted my patch. It's available here: 
https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/

Over the next couple of days, I'll build and run your test changes 
against it to check for any unexpected issues.

