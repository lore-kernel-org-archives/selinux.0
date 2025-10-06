Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234E17A316
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769222; cv=none; b=J6gdt/yZHLKq7DjDdecSkdc79RyuuEutx3S9tQd1GhWHpR9U1EWBMNegm+hkl7wJUQeRPlO8D564nGEr83Arp9ThC/0k1cAQ1KkDW2bZD1YcjN5tLLp4XncQ3MCTacbgFbvI6d+GYX6sMcU9cwWtkaHn/GqZh5BJF1NzQsJCFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769222; c=relaxed/simple;
	bh=GewNgGLRXk06CkbNWe17baUwwdbp+3Z2ojtSvnyjUd0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BIgKLI6UD+cNYNXyo/ssjICMN0DwCaQ05Q9G1XO21lljedYgXvgGAxSrdKaJtXOWmZUOXfJ9T3STwMCkBXTpDGS+9rxXbMYEntWReCS79scvrS8X6C5KsWe0XvLtUcRk558/VCkUt7BYbIdcpcwnIE9bGusFic2zvc8Ke9oDay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jLktZER1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jLktZER1"
Received: from [10.137.198.68] (unknown [131.107.147.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C51B211AF2F;
	Mon,  6 Oct 2025 09:46:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C51B211AF2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759769218;
	bh=hDRQd9RCqeqACa1GNu4dKWNpCWjr8a8VvsJcr4te/eU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=jLktZER17TmBELsh+yXC1p5qhGRwhfTVIVYYZJZO6WshufW7esOaZPGbgGOkyyX9O
	 WMT2NiPLqQi8li9ZtSJd15U/zJWP4NWuQLwJb+XSMey15TyzOxGatcQremQhKAR8Ux
	 nNBGsJQSvncdWiUinaDIkwtfax25mfmp++nWdFVE=
Message-ID: <a09f3304-9011-4b85-8371-78fec23327a8@linux.microsoft.com>
Date: Mon, 6 Oct 2025 09:46:57 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Suen <ericsu@linux.microsoft.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, danieldurning.work@gmail.com
References: <20250821182021.304-1-ericsu@linux.microsoft.com>
 <1752d2d2f04b17d4da2e40990985be51@paul-moore.com>
 <CAEjxPJ6qiw_T+9u_GuYgmLXShhbcG7hSt34Z9kvpiH9AQ9nmKA@mail.gmail.com>
 <CAHC9VhREWrw=2u66pbba+KC=SrSTfZ=5bn7jiqngyHh7qyv3Xg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhREWrw=2u66pbba+KC=SrSTfZ=5bn7jiqngyHh7qyv3Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/2025 7:59 AM, Paul Moore wrote:
> On Thu, Sep 18, 2025 at 9:36 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Sep 17, 2025 at 5:48 PM Paul Moore<paul@paul-moore.com> wrote:
>>> On Aug 21, 2025 Eric Suen<ericsu@linux.microsoft.com> wrote:
>>>> BPF token support was introduced to allow a privileged process to delegate
>>>> limited BPF functionality—such as map creation and program loading—to an
>>>> unprivileged process:
>>>>    https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
>>>>
>>>> This patch adds SELinux support for controlling BPF token access. With
>>>> this change, SELinux policies can now enforce constraints on BPF token
>>>> usage based on both the delegating (privileged) process and the recipient
>>>> (unprivileged) process.
>>>>
>>>> Supported operations currently include:
>>>>    - map_create
>>>>    - prog_load
>>>>
>>>> High-level workflow:
>>>>    1. An unprivileged process creates a VFS context via `fsopen()` and
>>>>       obtains a file descriptor.
>>>>    2. This descriptor is passed to a privileged process, which configures
>>>>       BPF token delegation options and mounts a BPF filesystem.
>>>>    3. SELinux records the `creator_sid` of the privileged process during
>>>>       mount setup.
>>>>    4. The unprivileged process then uses this BPF fs mount to create a
>>>>       token and attach it to subsequent BPF syscalls.
>>>>    5. During verification of `map_create` and `prog_load`, SELinux uses
>>>>       `creator_sid` and the current SID to check policy permissions via:
>>>>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>>>>                      BPF__MAP_CREATE, NULL);
>>>>
>>>> The implementation introduces two new permissions:
>>>>    - map_create_as
>>>>    - prog_load_as
>>>>
>>>> At token creation time, SELinux verifies that the current process has the
>>>> appropriate `*_as` permission (depending on the `allowed_cmds` value in
>>>> the bpf_token) to act on behalf of the `creator_sid`.
>>>>
>>>> Example SELinux policy:
>>>>    allow test_bpf_t self:bpf {
>>>>        map_create map_read map_write prog_load prog_run
>>>>        map_create_as prog_load_as
>>>>    };
>>>>
>>>> Additionally, a new policy capability bpf_token_perms is added to ensure
>>>> backward compatibility. If disabled, previous behavior ((checks based on
>>>> current process SID)) is preserved.
>>>>
>>>> Changes in v2:
>>>> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>>>>    creator_sid from wrong file descriptor
>>>> - Removed unnecessary checks for null, per review comments from
>>>>    the first patch
>>>>
>>>> Changes in v3:
>>>> - Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
>>>>    allow it to fall through to the permission checks which will fail as
>>>>    access denied to unlabeled_t
>>>>
>>>> Signed-off-by: Eric Suen<ericsu@linux.microsoft.com>
>>>> Tested-by: Daniel Durning<danieldurning.work@gmail.com>
>>>> Reviewed-by: Daniel Durning<danieldurning.work@gmail.com>
>>>> Acked-by: Stephen Smalley<stephen.smalley.work@gmail.com>
>>>> ---
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index e474cd7398ef..d949e9c5aa31 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>>>                goto out;
>>>>        }
>>>>
>>>> +     sbsec->creator_sid = current_sid();
>>> A few things come to mind as I'm looking at the new creator_sid field.
>>>
>>> First, we should explicitly initialize @sbsec->creator_sid to
>>> SECINITSID_UNLABELED in selinux_sb_alloc_security() just as we do the
>>> other fields.  Yes, the LSM framework does some basic clearing, but this
>>> is safer long term and it isn't likely that superblock allocation is
>>> going to be common enough to where the extra assignment is going to be
>>> a concern.
>>>
>>> While I don't think this is an immediate issue, I think it's a good idea
>>> to ensure that the selinux_cmp_sb_context() function compares the
>>> @sbsec->creator_sid fields and only returns true/"match" if they are the
>>> same.
>> Hmm...that raises another question in my mind - what happens if
>> multiple processes mount bpffs filesystems currently - do they each
>> get their own superbock or is that shared?
> Good question.  If the superblock is shared among all mount instances
> we need to do some extra work to determine the creator label/SID for
> each instance.
>
>> If the latter, then making this part of the comparison will block
>> subsequent mounts by tasks with different SIDs.
>> But not doing something here would lead to using whoever was the last
>> mounter for the SID, so I agree something needs to happen.
> Eric, can you look into the code and do some testing?

It doesn't appear the superblock is shared between processes. Here is 
what I did to verify:

1. Modified test_bpf_map_create in testsuite so it forks/starts two 
concurrent processes that each trigger bpf map creation.

2. Added debug printf in selinux_bpffs_creator_sid (in 
'selinux/security/selinux/hooks.c') to print out current task pid/tgid, 
super_block pointer, and superblock_security_struct pointer.

3. Observed that the printed super_block and superblock_security_struct 
addresses were unique for each pid/tgid, indicating a distinct 
superblock instance per mount.

 From the code level, Paul also helped to review bpffs superblock 
creation. Here is his response:

You can confirm this by looking at the bpf_get_tree() function which is 
used to create a new bpffs tree.  The bpf_get_tree() function calls into 
get_tree_nodev(), which calls into vfs_get_super(), which calls into 
sget_fc() with a NULL "test" parameter.  When sget_fc() is called with a 
NULL "test" parameter a new superblock is created regardless of if any 
existing bpffs superblocks already exist.


>>>> @@ -7144,10 +7180,15 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>>>>        kfree(bpfsec);
>>>>   }
>>>>
>>>> +#define bpf_token_cmd(T, C) \
>>>> +     ((T)->allowed_cmds & (1ULL << (C)))
>>>> +
>>>>   static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>>>>                                    const struct path *path)
>>>>   {
>>>>        struct bpf_security_struct *bpfsec;
>>>> +     u32 sid = selinux_bpffs_creator_sid(attr->token_create.bpffs_fd);
>>>> +     int err;
>>>>
>>>>        bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>>>        if (!bpfsec)
>>> This isn't an issue with your code, and to be clear I'm not asking you
>>> to fix this, but more as a FYI/TODO for me (or anyone else who would
>>> care to do it), after the BPF token patch is merged, we should move the
>>> @bpfsec allocation/lifecycle-management for tokens out to the LSM
>>> framework so it can properly handle multiple LSMs.
>> This already happened in the LSM tree, just hasn't been merged to the
>> SELinux tree yet.
> Ah, yes, I forgot all about Blaise's patch!  My apologies.  At least
> that is one less thing for the TODO list ;)
>

