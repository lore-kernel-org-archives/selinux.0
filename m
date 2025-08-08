Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB126FA4E
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679438; cv=none; b=p7onXanLitf6QrTElFPxAR76gP/CugReW11NNoz1bGiDDONE1b6vQERCpf8mn2MI9TFqHH9rBB9QUKEPiY04F7R2qaFHz7LgdLJpystfuT/L1l9ZsTzu/IBccNbRUG+E7PFw43WdpdJOlcQOwOzD7G/cVTRCEvf/NqGVsPJ2rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679438; c=relaxed/simple;
	bh=ZkkXYRiVRG9k0IaW9WKZ5lwukI1XqmXNvzVIobvjBaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uwah37D42tyw/koga9M1Qlb2OxA6ZiR5BjKfPzVOLytlWKu3Npyxy72yYZP53bftj+AQT18+ZeXp9FnWv3qAIepdehITPVrSLT4kVS7KfEe/AiptFXiU202becI1ztfHpp3PCpe0YVhmjRwmcr3ExJigt8lBa3b6ZPrHjWTJQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dGni8Kj5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dGni8Kj5"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id B36E02030EAF;
	Fri,  8 Aug 2025 11:57:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B36E02030EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754679435;
	bh=7cpb5uCxO/BkPWhGZSKgMeJ31AMftBmQyUu4dImNvqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dGni8Kj5AlPuvApZqITSq8yGA3GTShV8Ri6S7gjsc1kAp5iorAA7lmqSXsNaQEjuN
	 eCpAm010L5Vt1KkspsS/Y06dv5Y3lzwQ46GuMISlKgMtZ0/Nv5GYiqDMPPHc3RlW5g
	 c9S3wO5sxP1q8ZgXEouDZaRavZ5HQSWsLdDZikzo=
Message-ID: <34426151-7d7b-427b-912e-84174c4d9e92@linux.microsoft.com>
Date: Fri, 8 Aug 2025 11:57:14 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/2025 6:46 AM, Stephen Smalley wrote:
> On Wed, Aug 6, 2025 at 2:33 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Aug 6, 2025 at 2:07 PM <ericsu@linux.microsoft.com> wrote:
>>> From: Eric Suen <ericsu@linux.microsoft.com>
>>>
>>> BPF token support was introduced to allow a privileged process to delegate
>>> limited BPF functionality—such as map creation and program loading—to an
>>> unprivileged process:
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
>>> To verify the logic introduced by this patch, my fork of the SELinux
>>> testsuite with relevant test cases is available here:
>>>    https://github.com/havefuncoding1/selinux-testsuite
>> Interesting approach. Added Daniel to the distribution. Can you please
>> also post your testsuite patch to the list for review as per
>> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#submitting-a-testsuite-patch
> Also, since you are introducing new permissions and a policy
> capability, please include instructions in the commit description for
> running your testsuite, see
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#add-new-permissions
> and
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#adding-a-new-selinux-policy-capability
> for instructions and links to example previous commits.

Hi Stephen, just posted patch for user space capability and it's 
available here 
https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.microsoft.com/

also posted patch for the testsuite 
https://lore.kernel.org/selinux/20250808184711.291-1-ericsu@linux.microsoft.com/, 
and yes I ran the tests with policy cap enabled in my environment.

>>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>>> ---
>>>   security/selinux/hooks.c                   | 107 ++++++++++++++++++++-
>>>   security/selinux/include/classmap.h        |   2 +-
>>>   security/selinux/include/objsec.h          |   4 +
>>>   security/selinux/include/policycap.h       |   1 +
>>>   security/selinux/include/policycap_names.h |   1 +
>>>   security/selinux/include/security.h        |   6 ++
>>>   6 files changed, 118 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 335fbf76cdd2..ef9771542737 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>>                  goto out;
>>>          }
>>>
>>> +       sbsec->creator_sid = current_sid();
>>> +
>>>          if (strcmp(sb->s_type->name, "proc") == 0)
>>>                  sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>>>
>>> @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
>>>   static int selinux_bpf(int cmd, union bpf_attr *attr,
>>>                         unsigned int size, bool kernel)
>>>   {
>>> +       bool bpf_token_perms = selinux_policycap_bpf_token_perms();
>>>          u32 sid = current_sid();
>>>          int ret;
>>>
>>> +       if (bpf_token_perms)
>>> +               return 0;
>>> +
>>>          switch (cmd) {
>>>          case BPF_MAP_CREATE:
>>>                  ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
>>> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
>>>                              BPF__PROG_RUN, NULL);
>>>   }
>>>
>>> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
>>> +{
>>> +       struct path path;
>>> +       struct super_block *sb;
>>> +       struct superblock_security_struct *sbsec;
>>> +
>>> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
>>> +
>>> +       if (!fd_file(f))
>>> +               return SECSID_NULL;
>>> +
>>> +       path = fd_file(f)->f_path;
>>> +       sb = path.dentry->d_sb;
>>> +       if (!sb)
>>> +               return SECSID_NULL;
>>> +
>>> +       sbsec = selinux_superblock(sb);
>>> +       if (!sbsec)
>>> +               return SECSID_NULL;
>>> +
>>> +       return sbsec->creator_sid;
>>> +}
>>> +
>>>   static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>>                                    struct bpf_token *token, bool kernel)
>>>   {
>>>          struct bpf_security_struct *bpfsec;
>>> +       u32 ssid;
>>>
>>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>>          if (!bpfsec)
>>> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>>          bpfsec->sid = current_sid();
>>>          map->security = bpfsec;
>>>
>>> -       return 0;
>>> +       if (!token)
>>> +               ssid = bpfsec->sid;
>>> +       else {
>>> +               ssid = selinux_bpffs_creator_sid(attr);
>>> +               if (ssid == SECSID_NULL)
>>> +                       return -EPERM;
>>> +       }
>>> +
>>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CREATE, NULL);
>>>   }
>>>
>>>   static void selinux_bpf_map_free(struct bpf_map *map)
>>> @@ -7113,6 +7151,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>>                                   struct bpf_token *token, bool kernel)
>>>   {
>>>          struct bpf_security_struct *bpfsec;
>>> +       u32 ssid;
>>>
>>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>>          if (!bpfsec)
>>> @@ -7121,7 +7160,15 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>>          bpfsec->sid = current_sid();
>>>          prog->aux->security = bpfsec;
>>>
>>> -       return 0;
>>> +       if (!token)
>>> +               ssid = bpfsec->sid;
>>> +       if (token) {
>>> +               ssid = selinux_bpffs_creator_sid(attr);
>>> +               if (ssid == SECSID_NULL)
>>> +                       return -EPERM;
>>> +       }
>>> +
>>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LOAD, NULL);
>>>   }
>>>
>>>   static void selinux_bpf_prog_free(struct bpf_prog *prog)
>>> @@ -7132,10 +7179,18 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>>>          kfree(bpfsec);
>>>   }
>>>
>>> +#define bpf_token_cmd(T, C) \
>>> +       ((T)->allowed_cmds & (1ULL << (C)))
>>> +
>>>   static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>>>                                      const struct path *path)
>>>   {
>>>          struct bpf_security_struct *bpfsec;
>>> +       u32 sid = selinux_bpffs_creator_sid(attr);
>>> +       int err;
>>> +
>>> +       if (sid == SECSID_NULL)
>>> +               return -EPERM;
>>>
>>>          bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>>>          if (!bpfsec)
>>> @@ -7144,6 +7199,29 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
>>>          bpfsec->sid = current_sid();
>>>          token->security = bpfsec;
>>>
>>> +       bpfsec->perms = 0;
>>> +
>>> +       /**
>>> +        * 'token->allowed_cmds' is a bit mask of allowed commands
>>> +        * Convert the BPF command enum to a bitmask representing its position in the
>>> +        * allowed_cmds bitmap.
>>> +        */
>>> +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
>>> +               err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__MAP_CREATE_AS, NULL);
>>> +               if (err)
>>> +                       return err;
>>> +
>>> +               bpfsec->perms |= BPF__MAP_CREATE;
>>> +       }
>>> +
>>> +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
>>> +               err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__PROG_LOAD_AS, NULL);
>>> +               if (err)
>>> +                       return err;
>>> +
>>> +               bpfsec->perms |= BPF__PROG_LOAD;
>>> +       }
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -7154,6 +7232,30 @@ static void selinux_bpf_token_free(struct bpf_token *token)
>>>          token->security = NULL;
>>>          kfree(bpfsec);
>>>   }
>>> +
>>> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
>>> +{
>>> +       struct bpf_security_struct *bpfsec;
>>> +
>>> +       if (!token || !token->security)
>>> +               return -EINVAL;
>>> +
>>> +       bpfsec = token->security;
>>> +       switch (cmd) {
>>> +       case BPF_MAP_CREATE:
>>> +               if ((bpfsec->perms & BPF__MAP_CREATE) != BPF__MAP_CREATE)
>>> +                       return -EACCES;
>>> +               break;
>>> +       case BPF_PROG_LOAD:
>>> +               if ((bpfsec->perms & BPF__PROG_LOAD) != BPF__PROG_LOAD)
>>> +                       return -EACCES;
>>> +               break;
>>> +       default:
>>> +               break;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>>   #endif
>>>
>>>   struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>>> @@ -7585,6 +7687,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>>          LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
>>>          LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
>>>          LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
>>> +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
>>>   #endif
>>>   #ifdef CONFIG_PERF_EVENTS
>>>          LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>> index 5665aa5e7853..a6ed864af64c 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[] = {
>>>          { "infiniband_endport", { "manage_subnet", NULL } },
>>>          { "bpf",
>>>            { "map_create", "map_read", "map_write", "prog_load", "prog_run",
>>> -           NULL } },
>>> +           "map_create_as", "prog_load_as", NULL } },
>>>          { "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
>>>          { "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
>>>          { "perf_event",
>>> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
>>> index 1d7ac59015a1..b7e55e5c6d9c 100644
>>> --- a/security/selinux/include/objsec.h
>>> +++ b/security/selinux/include/objsec.h
>>> @@ -87,6 +87,8 @@ struct superblock_security_struct {
>>>          u32 sid; /* SID of file system superblock */
>>>          u32 def_sid; /* default SID for labeling */
>>>          u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files */
>>> +       u32 creator_sid;        /* SID of privileged process and is used to */
>>> +                                               /* verify bpf operations */
>>>          unsigned short behavior; /* labeling behavior */
>>>          unsigned short flags; /* which mount options were specified */
>>>          struct mutex lock;
>>> @@ -164,6 +166,8 @@ struct pkey_security_struct {
>>>
>>>   struct bpf_security_struct {
>>>          u32 sid; /* SID of bpf obj creator */
>>> +       u32 perms;      /* allowed AV permissions, e.g. BPF__MAP_CREATE, */
>>> +                               /* for requested bpf commands */
>>>   };
>>>
>>>   struct perf_event_security_struct {
>>> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
>>> index 7405154e6c42..cde6aaf442cd 100644
>>> --- a/security/selinux/include/policycap.h
>>> +++ b/security/selinux/include/policycap.h
>>> @@ -17,6 +17,7 @@ enum {
>>>          POLICYDB_CAP_NETLINK_XPERM,
>>>          POLICYDB_CAP_NETIF_WILDCARD,
>>>          POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>>> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
>>>          __POLICYDB_CAP_MAX
>>>   };
>>>   #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
>>> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
>>> index d8962fcf2ff9..cd5e73f992ea 100644
>>> --- a/security/selinux/include/policycap_names.h
>>> +++ b/security/selinux/include/policycap_names.h
>>> @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
>>>          "netlink_xperm",
>>>          "netif_wildcard",
>>>          "genfs_seclabel_wildcard",
>>> +       "bpf_token_perms",
>>>   };
>>>   /* clang-format on */
>>>
>>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>>> index 8201e6a3ac0f..d3832e4ad4fb 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -209,6 +209,12 @@ static inline bool selinux_policycap_netif_wildcard(void)
>>>                  selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
>>>   }
>>>
>>> +static inline bool selinux_policycap_bpf_token_perms(void)
>>> +{
>>> +       return READ_ONCE(
>>> +               selinux_state.policycap[POLICYDB_CAP_BPF_TOKEN_PERMS]);
>>> +}
>>> +
>>>   struct selinux_policy_convert_data;
>>>
>>>   struct selinux_load_state {
>>> --
>>> 2.50.1.windows.1
>>>
>>>

