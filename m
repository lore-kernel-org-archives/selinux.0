Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34F1DED49
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365233; cv=none; b=HN1lXbI+e/OLRHpMQGsgMYdcAzD/NJeQEBEyYAcBgkEvz7KOyOj8KGi/pHaMTvaIYgKc+7C6vKFbcYUbPIIx0ExBa52mPXo7yRLVSQ747P8zljKgjnxIrjmXTJ5jyK7V7XPrhUMONJwVjp/AnoLSpvZ9kKTiUOx0FAhrVZt7J7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365233; c=relaxed/simple;
	bh=37BmG4fz76LYSqvY6wBOTrtn+xEzfWG8QYNHAmxxRk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJMfX4wGQicDG57JjdKKTwitn/f0oEQEYYmsu1eXNUfPZvjtus/GUssfU/G6DaOEsB/zWpWRx/GuijE3n2WESDB1boTt6scx1DPirPPTjnFcDiVEOSZL2TppIIe3nzM+MccQaRMRM4B03/zs1GI1YVzkecegW/1GhOPpz5fYR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ow1egP9N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ow1egP9N"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 48FFA2015BC2;
	Sat, 16 Aug 2025 10:27:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48FFA2015BC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755365224;
	bh=fXR8AFKdWkM6qR2Ry7AGbsp2PNwVeXA39cut9wXmQHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ow1egP9N0K/ZSTElAHv3hh1aJREIt3P5lPyILgy2YCuZuro4pVN4uRO15OCNhTPbn
	 v1vQ4igzgkUy2dKZewr57s0AtahNZWm6hyiCzy8Vt0oAF98JvY/mxXWLIOx0w1hUK7
	 zP34csboxLNK13PhoZVnuFVCQ7eA8ssdtwcYiGQI=
Message-ID: <6c61da87-3da6-4b13-9362-a06f64b85ae0@linux.microsoft.com>
Date: Sat, 16 Aug 2025 10:27:03 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, selinux@vger.kernel.org,
 paul@paul-moore.com
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAKrb_fGECzqWO+Kq7n+5Q=J404npPyttrkLcXwLkdM-UZcZmLA@mail.gmail.com>
 <e5278ea4-33b5-48b5-a59e-bef7c4cfe866@linux.microsoft.com>
 <CAEjxPJ6OgHn6VoXNhcUOxKd5e2AVzKZQajfVaqt40VENor=weQ@mail.gmail.com>
 <CAEjxPJ5H6gWin-fnBMogZJtzZRmxz=q6XeMeP1mR5ju0ENj3xQ@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ5H6gWin-fnBMogZJtzZRmxz=q6XeMeP1mR5ju0ENj3xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/2025 8:02 AM, Stephen Smalley wrote:
> On Tue, Aug 12, 2025 at 8:27 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Mon, Aug 11, 2025 at 3:30 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>>> On 8/7/2025 11:00 AM, Daniel Durning wrote:
>>>> On Wed, Aug 6, 2025 at 2:07 PM<ericsu@linux.microsoft.com> wrote:
>>>>> From: Eric Suen<ericsu@linux.microsoft.com>
>>>>>
>>>>> BPF token support was introduced to allow a privileged process to delegate
>>>>> limited BPF functionality—such as map creation and program loading—to an
>>>>> unprivileged process:
>>>>>     https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
>>>>>
>>>>> This patch adds SELinux support for controlling BPF token access. With
>>>>> this change, SELinux policies can now enforce constraints on BPF token
>>>>> usage based on both the delegating (privileged) process and the recipient
>>>>> (unprivileged) process.
>>>>>
>>>>> Supported operations currently include:
>>>>>     - map_create
>>>>>     - prog_load
>>>>>
>>>>> High-level workflow:
>>>>>     1. An unprivileged process creates a VFS context via `fsopen()` and
>>>>>        obtains a file descriptor.
>>>>>     2. This descriptor is passed to a privileged process, which configures
>>>>>        BPF token delegation options and mounts a BPF filesystem.
>>>>>     3. SELinux records the `creator_sid` of the privileged process during
>>>>>        mount setup.
>>>>>     4. The unprivileged process then uses this BPF fs mount to create a
>>>>>        token and attach it to subsequent BPF syscalls.
>>>>>     5. During verification of `map_create` and `prog_load`, SELinux uses
>>>>>        `creator_sid` and the current SID to check policy permissions via:
>>>>>          avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>>>>>                       BPF__MAP_CREATE, NULL);
>>>>>
>>>>> To verify the logic introduced by this patch, my fork of the SELinux
>>>>> testsuite with relevant test cases is available here:
>>>>>     https://github.com/havefuncoding1/selinux-testsuite
>>>>>
>>>>> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
>>>>>                               BPF__PROG_RUN, NULL);
>>>>>    }
>>>>>
>>>>> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
>>>>> +{
>>>>> +       struct path path;
>>>>> +       struct super_block *sb;
>>>>> +       struct superblock_security_struct *sbsec;
>>>>> +
>>>>> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
>>>>> +
>>>>> +       if (!fd_file(f))
>>>>> +               return SECSID_NULL;
>>>> Is it possible for this value to be null assuming there is not a bug
>>>> in the kernel? You would not want to do a runtime check for something
>>>> that would indicate a kernel bug lest you accidentally hide the bug.
>>> I always think being defensive is a good thing in kernel development.
>>> But you have a valid point, and I will review and update in next
>>> iteration if appropriate. Same applies to all similar comments below.
>>> Thank you.
>> The Linux kernel way is to NOT check conditions that can only occur if
>> there is a kernel bug (or use BUG_ON/BUG/etc macros for such checks so
>> they can be compiled away for production, but adding new instances of
>> those is generally frowned upon). So unless you can identify a case
>> where these are userspace-triggerable, you shouldn't be checking them.
> On a quick look, the only other use of "CLASS(fd,
> f)(attr->token_create.bpffs_fd);" that I saw was in
> kernel/bpf/token.c:bpf_token_create(), and it checks for fd_empty(f)
> rather than fd_file(f). The other question I have though is are we
> guaranteed that attr->token_create.bpffs_fd is always set on all
> callers of this selinux_bpffs_creator_sid() function outside the
> context of bpf_token_create()?
Stephen - you are absolutely right. After seeing your comment about 
allow rule for 'kernel_t' in my test, I started to debug and 
'token_create.bpffs_fd' was exactly the root cause. I have fixed it and 
things look much better now. Thank you. I will send out new iteration soon.
>>>>> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>>>>           bpfsec->sid = current_sid();
>>>>>           map->security = bpfsec;
>>>>>
>>>>> -       return 0;
>>>>> +       if (!token)
>>>>> +               ssid = bpfsec->sid;
>>>>> +       else {
>>>>> +               ssid = selinux_bpffs_creator_sid(attr);
>>>>> +               if (ssid == SECSID_NULL)
>>>>> +                       return -EPERM;
>>>> Should this ever be null? See above (for this and all repeated
>>>> occurrences of this check).
>> If this check remains in your final patch, then returning -EPERM from
>> SELinux is uncommon - we usually return -EACCES on permission denials,
>> only using -EPERM for superuser/capability checks. Also silently
>> returning -EPERM or -EACCES is not ideal for SELinux since it provides
>> no insight to the user as to the cause and no way to override (ala
>> permissive mode) if needed. It might actually be better to just fall
>> through and let it pass SECSID_NULL to avc_has_perm(), which will
>> produce an SELinux avc audit message (with the unlabeled context,
>> since any unknown SID is mapped to that automatically) to the user and
>> the option for overriding via permissive mode.

Got it. Thank you.

