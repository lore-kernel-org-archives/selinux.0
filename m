Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C9398F98
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879918; cv=none; b=Q0ce5b8EPQaUGvX4UmTdPfrp77cdkeU11u/b3wtYAgspA4rNlPG/1M1gtcb2xYlaD7csclBHJJxJVfbuHdOs9BfyQGDMqyultvsDYAfkA44xs0PxEwy51iAZHHhfM05ZT158MjWAMaGbYAY4wiB9sZSeIbI3QHYDpn1Dw2iVWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879918; c=relaxed/simple;
	bh=mXfHvM14ER3ZU2RjLKtiAmfmWp7tp1lS/SLtZWNaHWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE9dYtPR+xJ3As39jReczRYCffVIxwJf5tSOsxoeAvHDY5ue5X/nofMom+wyXEP9tDj3SXjNGyRF0Bk5qUnngGd5x1CB7nnbNobapjsrt1/uOXZRzvxwBx3qIzCDlXVJQ+fCIkjFfuAd3E3FLiRY0Lpsg1D4GSUTi7T+Z024fIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PebvY6Ry; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PebvY6Ry"
Received: from [10.137.198.68] (unknown [131.107.147.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2911200E9C5;
	Thu,  4 Dec 2025 12:25:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2911200E9C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764879915;
	bh=IPKVF/EFNRH6cBN7T1/7CXlHLDt5BRx9Kj9KFcAJ4jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PebvY6RyHOVGyeb+VdyuzS2vIsy+abfJHH1bhp1z6qzTneivriTJnbnsTdozsTzQB
	 kEK4oFtRTBRuIARzb7kRU+bziVnTNAPygC2IBqD6DVsktT5g04YeXbAHj93U3mGW/j
	 k72J+KhI04qOK7u/uRx+Prfv/pxRqFI3G0l5SyoY=
Message-ID: <c856fb1e-bdbf-45c5-8766-d4fd927c9ea9@linux.microsoft.com>
Date: Thu, 4 Dec 2025 12:25:15 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, danieldurning.work@gmail.com
References: <20251116205208.734-1-ericsu@linux.microsoft.com>
 <CAEjxPJ7s8vS_Spt-9wabztTeh-3j+uX6auSEecHZh6RfkPpQHg@mail.gmail.com>
 <CAHC9VhSomsUf2ydNs=nmNHnEc6YSZQCaZ8kmUHjCSmg+tNAxZg@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAHC9VhSomsUf2ydNs=nmNHnEc6YSZQCaZ8kmUHjCSmg+tNAxZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/2025 11:57 AM, Paul Moore wrote:
> On Mon, Nov 17, 2025 at 9:37 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Sun, Nov 16, 2025 at 3:52 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>>> BPF token support was introduced to allow a privileged process to delegate
>>> limited BPF functionality—such as map creation and program loading—to
>>> an unprivileged process:
>>>    https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
>>>
>>> This patch adds SELinux support for controlling BPF token access. With
>>> this change, SELinux policies can now enforce constraints on BPF token
>>> usage based on both the delegating (privileged) process and the recipient
>>> (unprivileged) process.
>>>
>>> Supported operations currently include:
>>>    - map_create
>>>    - prog_load
>>>
>>> High-level workflow:
>>>    1. An unprivileged process creates a VFS context via `fsopen()` and
>>>       obtains a file descriptor.
>>>    2. This descriptor is passed to a privileged process, which configures
>>>       BPF token delegation options and mounts a BPF filesystem.
>>>    3. SELinux records the `creator_sid` of the privileged process during
>>>       mount setup.
>>>    4. The unprivileged process then uses this BPF fs mount to create a
>>>       token and attach it to subsequent BPF syscalls.
>>>    5. During verification of `map_create` and `prog_load`, SELinux uses
>>>       `creator_sid` and the current SID to check policy permissions via:
>>>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>>>                      BPF__MAP_CREATE, NULL);
>>>
>>> The implementation introduces two new permissions:
>>>    - map_create_as
>>>    - prog_load_as
>>>
>>> At token creation time, SELinux verifies that the current process has the
>>> appropriate `*_as` permission (depending on the `allowed_cmds` value in
>>> the bpf_token) to act on behalf of the `creator_sid`.
>>>
>>> Example SELinux policy:
>>>    allow test_bpf_t self:bpf {
>>>        map_create map_read map_write prog_load prog_run
>>>        map_create_as prog_load_as
>>>    };
>>>
>>> Additionally, a new policy capability bpf_token_perms is added to ensure
>>> backward compatibility. If disabled, previous behavior ((checks based on
>>> current process SID)) is preserved.
> ...
>
>>> +static int selinux_bpf_token_capable(const struct bpf_token *token, int cap)
>>> +{
>>> +       u16 sclass;
>>> +       struct bpf_security_struct *bpfsec = token->security;
>>> +       bool initns = (token->userns == &init_user_ns);
>>> +       u32 av = CAP_TO_MASK(cap);
>>> +
>>> +       switch (CAP_TO_INDEX(cap)) {
>>> +       case 0:
>>> +               sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
>>> +               break;
>>> +       case 1:
>>> +               sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_USERNS;
>>> +               break;
>>> +       default:
>>> +               pr_err("SELinux:  out of range capability %d\n", cap);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       return avc_has_perm(bpfsec->sid, bpfsec->grantor_sid, sclass, av, NULL);
>> 1. There is a 3rd possible SID that could have been used here if this
>> is always called in process context, i.e. current_sid().
>> Do we care? What is the typical relationship among the three SIDs,
>> e.g. will two of the three be the same in the common case?
> Based on the discussion in v5[1] of this series, I was expecting to
> see something like the following:
>
>    return avc_has_perm(current_sid(), bpfsec->grantor_sid, ...);
>
> As mentioned previously, I view the selinux_bpf_token_capable() check
> as asking if the current process can assert a capability assigned to
> the token.  In this case that would mean the subject would be
> 'current_sid()' and the object would be 'bpfsec->grantor_sid' as the
> bpfsec->grantor_sid should reflect the security context/label of the
> process which delegated its authority to the token.
>
> [1] https://lore.kernel.org/selinux/CAHC9VhS5-5+LxEstKX=ZHNPK6RazRqejXOEOXv-UJjiNsvQ6GA@mail.gmail.com/

Thank you, Paul.

Stephen - thanks for catching the issue. It's a bug in the code. I will 
send out a new patch for the fix, plus new tests covering both success 
and failure cases for 'avc_has_perm'.

>
>> 2. Do you have a test case that exercises success and failure of this check?
>>
>>> +}
>>>   #endif
>>>
>>>   struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
> --
> paul-moore.com


