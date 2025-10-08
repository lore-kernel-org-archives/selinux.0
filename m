Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54862638AF
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962030; cv=none; b=t9cZTqIHF12Woe1PDBf0yRWa62CEd4zSTWUHJu2jE4LTnpynaolxPhojj1EBLXquvHSwOMD6rg0hUuL4vKciogek72yOpyqn/pEkY5dgZ+/8cl1/n4qNrbAB9QrKYHyU/5BJuG6rWlou44YrRqmm01UxOqatMo7TB4yy8I5j5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962030; c=relaxed/simple;
	bh=LYrkxe9SRbsvuwKu0MbUQylLeb1H8+rUXYbasdcl4bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p80emTnjbaMiwA5fJ1lOZtLsm0xPmp6z5dDV8VB/ari4urLLLdqvMPBRXXchCl+sh0SghE3HFuDwNx5jVBDW8y6ziUu3A7RRla2uP3Bb/RFyDEkFC5ojASFMN0UmZCX2k0LthnFCVJL1nbCI1C3nHX0tf/1SRMCLLyEGqQ823v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AqGNzVmQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AqGNzVmQ"
Received: from [10.137.198.68] (unknown [131.107.147.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF0EF2038B79;
	Wed,  8 Oct 2025 15:20:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF0EF2038B79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759962028;
	bh=oN4TwwX0+EXPbmG4/jD42ZFhH45p9aoB5ivfnhc6jgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AqGNzVmQGi8MAlIT5kXxejQpRy8BlLAAubRO8lfWlUtDVFRwNGjbZ8cJhm9tiDjtt
	 s9lxg3ezM7KEqrlVkQk9y5NbVlk6r0bUzW3C2T4nJc1fhdjfYaRIAeviAeIrfGluOO
	 Z3+wvJ6ifgeptM0G5OFQA4Rxi71mGEtOEy73LdXs=
Message-ID: <fe6f4419-06be-4169-b694-b2ba26c7f141@linux.microsoft.com>
Date: Wed, 8 Oct 2025 15:20:27 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
 danieldurning.work@gmail.com
References: <20251006172205.429-1-ericsu@linux.microsoft.com>
 <CAEjxPJ46pVykPEeXT73G5h_sAXuU68+w4kfW-fQrfM0EMq+xzw@mail.gmail.com>
 <CAEjxPJ4XyNmyXB5w+8a78fkQDMwF+DHP1efEJhXZPTsSABEAuQ@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ4XyNmyXB5w+8a78fkQDMwF+DHP1efEJhXZPTsSABEAuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/2025 12:11 PM, Stephen Smalley wrote:
> On Mon, Oct 6, 2025 at 3:00 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Mon, Oct 6, 2025 at 1:22 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
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
>>>
>>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>>> ---
>>> Changes in v2:
>>> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>>>    creator_sid from wrong file descriptor
>>> - Removed unnecessary checks for null, per review comments from
>>>    the first patch
>>>
>>> Changes in v3:
>>> - Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
>>>    allow it to fall through to the permission checks which will fail as
>>>    access denied to unlabeled_t
>>>
>>> Changes in v4:
>>> - Added initialization of creator_sid in selinux_sb_alloc_security
>>> - Enabled handling of creator_sid in selinux_cmp_sb_context and
>>>    selinux_sb_clone_mnt_opts
>>> - Minor updates based on review comments
>>>
>>>   security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
>>>   security/selinux/include/classmap.h        |  2 +-
>>>   security/selinux/include/objsec.h          |  2 +
>>>   security/selinux/include/policycap.h       |  1 +
>>>   security/selinux/include/policycap_names.h |  1 +
>>>   security/selinux/include/security.h        |  6 ++
>>>   6 files changed, 102 insertions(+), 3 deletions(-)
>>>
>> What is this patch relative to? Didn't apply for me on
>> selinux/dev-staging or selinux/dev.
>> Optimally should target selinux/dev-staging at this point since it has
>> the memfd patch and hence its policy capability defined, and your new
>> one should go after that one.
Let me move to dev-staging and send out a new patch.
>>
>> Also, did you ever explain why your implementation lacks a
>> bpf_token_capable() hook and whether that still needs to be addressed?
Just looked the code and I believe it's better to have this function 
implemented.
> Also, if you could re-base your libsepol patch on the latest selinux
> userspace, updating your policy capability definition there as well,
> that would help with testing.
Sure, will do.


