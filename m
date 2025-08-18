Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD827814A
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535315; cv=none; b=BEMgFxefTJYOOWRYeFp0f8eiyKOPES2NHypwbRUrYPomnQpzs4sTOESa0JOscySJ6mtJX6kJ6MSaOOKY6+Z7Y9t/mV9NY80GNoHHCyxNqmbJoLISStbnfKLeGpoRfC8Tw9IcdMhntzB0hD3AFE17yxVb/b2xwImt/Ch9YjUQsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535315; c=relaxed/simple;
	bh=jsW3XSbyQ44OGWAheRp6hZD112RD+fftDc+Rar+RcoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN7fU0AOfhI89Gl/+fNszGVDQ0b7lWzsvTUIX/e47RvcCpqBz4n1dOT4PKBFHg2aiNggerG05G0rH7gYdxvk0jbGOE4OU6clkuUYweORqmxoPC60i4G1FNHvONjqzAq1zu1CtWqI1YVrWx2oSXbEl8sfLw9nhlmbbTCims5fhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jHkpbts4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jHkpbts4"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3516B2113369;
	Mon, 18 Aug 2025 09:41:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3516B2113369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755535312;
	bh=7EwAeM1O3E8EfNrU66OPBwFt2stsYfMxVZRPwEEQv0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHkpbts4IuAMIsJ5Zuy2h07AP7116Rp2h34Yk7p01TIu8kV8NCulTMkkN400vUgO+
	 1GFBvuYiXV/kJaQ0EiHBv4G18OU1pE19dvGAtsnj0BpszIRwPP8R7wqKau2dSTxrQh
	 gOFCAUfxWP0nlvEnJFGEU8c8NzpCS31zBtuCA91I=
Message-ID: <ed5c6547-8397-4f47-af45-f7a83df0290e@linux.microsoft.com>
Date: Mon, 18 Aug 2025 09:41:50 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
 danieldurning.work@gmail.com
References: <20250816201420.197-1-ericsu@linux.microsoft.com>
 <CAEjxPJ64tMA5zsYh=NHa4gBeC6ytDqS8DenfFc5S5H95m_Aeow@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ64tMA5zsYh=NHa4gBeC6ytDqS8DenfFc5S5H95m_Aeow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/2025 6:00 AM, Stephen Smalley wrote:
> On Sat, Aug 16, 2025 at 4:14 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>> BPF token support was introduced to allow a privileged process to delegate
>> limited BPF functionality—such as map creation and program loading—to an
>> unprivileged process:
>>    https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
>>
>> This patch adds SELinux support for controlling BPF token access. With
>> this change, SELinux policies can now enforce constraints on BPF token
>> usage based on both the delegating (privileged) process and the recipient
>> (unprivileged) process.
>>
>> Supported operations currently include:
>>    - map_create
>>    - prog_load
>>
>> High-level workflow:
>>    1. An unprivileged process creates a VFS context via `fsopen()` and
>>       obtains a file descriptor.
>>    2. This descriptor is passed to a privileged process, which configures
>>       BPF token delegation options and mounts a BPF filesystem.
>>    3. SELinux records the `creator_sid` of the privileged process during
>>       mount setup.
>>    4. The unprivileged process then uses this BPF fs mount to create a
>>       token and attach it to subsequent BPF syscalls.
>>    5. During verification of `map_create` and `prog_load`, SELinux uses
>>       `creator_sid` and the current SID to check policy permissions via:
>>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>>                      BPF__MAP_CREATE, NULL);
>>
>> The implementation introduces two new permissions:
>>    - map_create_as
>>    - prog_load_as
>>
>> At token creation time, SELinux verifies that the current process has the
>> appropriate `*_as` permission (depending on the `allowed_cmds` value in
>> the bpf_token) to act on behalf of the `creator_sid`.
>>
>> Example SELinux policy:
>>    allow test_bpf_t self:bpf {
>>        map_create map_read map_write prog_load prog_run
>>        map_create_as prog_load_as
>>    };
>>
>> Additionally, a new policy capability bpf_token_perms is added to ensure
>> badkward compability. If disabled, previous behavior ((checks based on
> backward compatibility
>
>> current process SID)) is preserved.
>>
>> Changes in v2:
>> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>>    creator_sid from wrong file descriptor
>> - Removed unnecessary checks for null, per review comments from
>>    the first patch
>>
>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>> ---
>>   security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
>>   security/selinux/include/classmap.h        |  2 +-
>>   security/selinux/include/objsec.h          |  4 +
>>   security/selinux/include/policycap.h       |  1 +
>>   security/selinux/include/policycap_names.h |  1 +
>>   security/selinux/include/security.h        |  6 ++
>>   6 files changed, 104 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 335fbf76cdd2..29b35ed4c306 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>                  goto out;
>>          }
>>
>> +       sbsec->creator_sid = current_sid();
>> +
>>          if (strcmp(sb->s_type->name, "proc") == 0)
>>                  sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>>
>> @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
>>   static int selinux_bpf(int cmd, union bpf_attr *attr,
>>                         unsigned int size, bool kernel)
>>   {
>> +       bool bpf_token_perms = selinux_policycap_bpf_token_perms();
>>          u32 sid = current_sid();
>>          int ret;
>>
>> +       if (bpf_token_perms)
>> +               return 0;
>> +
>>          switch (cmd) {
>>          case BPF_MAP_CREATE:
>>                  ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
>> @@ -7086,10 +7092,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
>>                              BPF__PROG_RUN, NULL);
>>   }
>>
>> +static int selinux_bpffs_creator_sid(u32 fd)
>> +{
>> +       struct path path;
>> +       struct super_block *sb;
>> +       struct superblock_security_struct *sbsec;
>> +
>> +       CLASS(fd, f)(fd);
>> +
>> +       if (fd_empty(f))
>> +               return SECSID_NULL;
>> +
>> +       path = fd_file(f)->f_path;
>> +       sb = path.dentry->d_sb;
>> +       sbsec = selinux_superblock(sb);
>> +
>> +       return sbsec->creator_sid;
>> +}
>> +
>>   static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>                                    struct bpf_token *token, bool kernel)
>>   {
>>          struct bpf_security_struct *bpfsec;
>> +       u32 ssid;
>>
>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>          if (!bpfsec)
>> @@ -7098,7 +7123,12 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>          bpfsec->sid = current_sid();
>>          map->security = bpfsec;
>>
>> -       return 0;
>> +       if (!token)
>> +               ssid = bpfsec->sid;
>> +       else
>> +               ssid = selinux_bpffs_creator_sid(attr->map_token_fd);
>> +
>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CREATE, NULL);
>>   }
>>
>>   static void selinux_bpf_map_free(struct bpf_map *map)
>> @@ -7113,6 +7143,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>                                   struct bpf_token *token, bool kernel)
>>   {
>>          struct bpf_security_struct *bpfsec;
>> +       u32 ssid;
>>
>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>          if (!bpfsec)
>> @@ -7121,7 +7152,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>          bpfsec->sid = current_sid();
>>          prog->aux->security = bpfsec;
>>
>> -       return 0;
>> +       if (!token)
>> +               ssid = bpfsec->sid;
>> +       else
>> +               ssid = selinux_bpffs_creator_sid(attr->prog_token_fd);
>> +
>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LOAD, NULL);
>>   }
>>
>>   static void selinux_bpf_prog_free(struct bpf_prog *prog)
>> @@ -7132,10 +7168,18 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>>          kfree(bpfsec);
>>   }
>>
>> +#define bpf_token_cmd(T, C) \
>> +       ((T)->allowed_cmds & (1ULL << (C)))
>> +
>>   static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>>                                      const struct path *path)
>>   {
>>          struct bpf_security_struct *bpfsec;
>> +       u32 sid = selinux_bpffs_creator_sid(attr->token_create.bpffs_fd);
>> +       int err;
>> +
>> +       if (sid == SECSID_NULL)
>> +               return -EPERM;
> Still doing a hardcoded return of -EPERM here with no log or audit
> message or way to override if permissive.
> Is this even possible? If so, would still prefer to let it fall
> through to the permission checks that will show up as access denied to
> unlabeled_t,
> which will alert the user and offer the option of overriding via
> permissive mode or an allow rule.
'token_create.bpffs_fd' is passed in from user, so yes it is possible 
for the sid to be null. I will remove the 'if'. Thanks, Stephen.
>
>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>          if (!bpfsec)
>> @@ -7144,6 +7188,29 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
>>          bpfsec->sid = current_sid();
>>          token->security = bpfsec;
>>
>> +       bpfsec->perms = 0;
>> +
>> +       /**
>> +        * 'token->allowed_cmds' is a bit mask of allowed commands
>> +        * Convert the BPF command enum to a bitmask representing its position in the
>> +        * allowed_cmds bitmap.
>> +        */
>> +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
>> +               err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__MAP_CREATE_AS, NULL);
>> +               if (err)
>> +                       return err;
>> +
>> +               bpfsec->perms |= BPF__MAP_CREATE;
>> +       }
>> +
>> +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
>> +               err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__PROG_LOAD_AS, NULL);
>> +               if (err)
>> +                       return err;
>> +
>> +               bpfsec->perms |= BPF__PROG_LOAD;
>> +       }
>> +
>>          return 0;
>>   }


