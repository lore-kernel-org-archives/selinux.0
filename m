Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53734847A
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066248; cv=none; b=iBE62za9+lHx7eCyKDyLRebmiFQueoZR1qDcD355zQOeiB3nLK6+w3FO3zK6B+3CviWldWINuuY2t+IsQzFI82EIYBnKjo0+STq6ntVQCiLzSUSFagJFwN93ritrZOWmn6aYkGv62JZ8n7rlMg/RtQBnj97wGnzm3C2t3IKx/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066248; c=relaxed/simple;
	bh=Ihd6ap1KwjC1inIQFRGbIl+NbqmfeURse1Sn4DNnV1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvR9rTyTH4tpNCU/SA8Fv83fMSdHZKuZ9UrZ6w6XZzGO4HfiBJDVp8Amm9Ish/WlsPqNerLbC4/Z7K90pvRssLttGJSPxPcWIzKeF9/GBZVKLxuv/xD5Cq0RuFUitkeLL/XqKy34GMXNCOWSxB2asNIrk6BC7CjFy1tu9UnSQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hk1ayF5V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hk1ayF5V"
Received: from [10.137.198.68] (unknown [131.107.147.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A6AD201DAC7;
	Tue, 21 Oct 2025 10:03:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A6AD201DAC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761066239;
	bh=hgHz61oqRNE+WzTPjUvU/XcqEbT2DnJ2Wy8gyhkaO6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hk1ayF5VZEHNUistQfCGBZz2BJACphByWvUuDUjTOlKbWNwAnIFEVAx+hOVD6uPBW
	 ghXAhZsaVPTSLDBZ0DSyOzIqgOy5yUorBjFAZMVqupY3kQDLCG/HnkFeJ2t6FPgqEz
	 84x2jRfUHjAtEhNBVafhglxhBuBgRpkvfMHmoYXA=
Message-ID: <aa8862a8-1898-47e2-93e3-96584e7efaf1@linux.microsoft.com>
Date: Tue, 21 Oct 2025 10:03:58 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, danieldurning.work@gmail.com
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
 <9f91729c4030890ebd10a6faa1009589@paul-moore.com>
 <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
 <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com>
 <CAEjxPJ7YU71UuWDa8tVm-dJAF+wZrmhujC9M2zkf+UXB44cEww@mail.gmail.com>
 <CAHC9VhS5-5+LxEstKX=ZHNPK6RazRqejXOEOXv-UJjiNsvQ6GA@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAHC9VhS5-5+LxEstKX=ZHNPK6RazRqejXOEOXv-UJjiNsvQ6GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/2025 9:10 AM, Paul Moore wrote:
> On Thu, Oct 16, 2025 at 11:52 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Thu, Oct 16, 2025 at 11:02 AM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Oct 16, 2025 at 10:05 AM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> On Wed, Oct 15, 2025 at 5:36 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
>>>>>> BPF token support was introduced to allow a privileged process to delegate
>>>>>> limited BPF functionality—such as map creation and program loading—to
>>>>>> an unprivileged process ...
> ...
>
>>>>> For a normal capability permission check, it makes sense for the subject
>>>>> and object to be the same as the process/subject isn't operating on
>>>>> anything other than itself, it's simply attempting to assert a capability
>>>>> that it has been assigned.
>>>>>
>>>>> However, I don't believe it is quite as simple for the BPF token
>>>>> capability check.  In this case the current process isn't asking if it
>>>>> can assert a capability assigned to itself, it is asking if it can assert
>>>>> a capability assigned to the token.  Due to this I'm wondering if we
>>>>> should change the subject to the current task, leaving the object
>>>>> as the token:
>>>>>
>>>>>    selinux_bpf_token_capable(...)
>>>>>    {
>>>>>      struct bpf_security_struct *bpfsec = token->security
>>>>>      bool initns = (token->userns == &init_user_ns);
>>>>>      u32 av = CAP_TO_MASK(cap);
>>>>>      u16 sclass;
>>>>>
>>>>>      switch (CAP_TO_INDEX(cap)) {
>>>>>      case 0:
>>>>>          sclass = initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USERNS;
>>>>>          break;
>>>>>      ...
>>>>>      }
>>>>>
>>>>>      return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NULL);
>>>> My understanding, which could be wrong, is that this hook is called
>>>> outside of process context (or at least outside of the context of
>>>> either process involved - token creator or token user) since it can be
>>>> called during any eBPF program and hence we can only use information
>>>> from the token, not the current process, for our permission checks. We
>>>> could perhaps pre-compute the capability access vectors at token
>>>> creation time and cache them for later checking instead.
>>> If you take a close look at bpf_token_capable() and you follow the
>>> bpf_ns_capable() call down to ns_capable_common() you will see that it
>>> calls into security_capable() with the current task's creds.  I
>>> haven't chased all of the callers of bpf_token_capable(), but if there
>>> is a case where bpf_token_capable() is being called outside of the
>>> current task's process context we have a larger problem that needs to
>>> be addressed.
>>>
>>> Aside from the calling context, does the subj/obj change sound
>>> reasonable?  While I think it makes sense, I like getting a sanity
>>> check from others on things like this as the impact is significant.
>> I suppose the only residual question is whether the bpffs creator sid
>> should factor into these checks too as it does for the
>> map_create/prog_load ones. Daniel's patch didn't have that construct
>> and hence didn't consider it.
> Yes, good point, I was mistakenly thinking that the token's label was
> from the creator SID, but it isn't as the child namespace creates the
> token.  I think we probably need a grantor_sid field in the
> bpf_security_struct that is set to the superblock's creator_sid in
> selinux_bpf_token_create(); the grantor_sid would then be used as the
> object in the selinux_bpf_token_capable() check.
>
>> If not, then I suppose the proposed
>> subj/obj change is reasonable albeit a bit strange looking to those
>> who are used to capability checks always being task-self checks.
> Yes, I agree it would be a bit unusual, but I'm more concerned with
> the permission check properly reflecting what is being requested by
> the kernel.  I also tend to think that the bpf token capability check
> looking a bit unusual may be a positive thing as it will allow policy
> devs/admins to better distinguish between "normal" capability checks
> and token-based capability checks.
>
Learned a lot from this great discussion. I will look more into it and 
send out a new patch.

Paul - to help minimize merge fixups next time, should I base my next 
revision on the latest dev-staging branch? Not sure if this branch will 
have all the changes from the merge window.

