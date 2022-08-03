Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D93C19F28
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 13:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiHCNNb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiHCNNa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Aug 2022 09:13:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863918B38
        for <selinux@vger.kernel.org>; Wed,  3 Aug 2022 06:13:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i4so19885317oif.2
        for <selinux@vger.kernel.org>; Wed, 03 Aug 2022 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0qI80nKbtNInC7TnaqV1RRwJ5MKOkQCfQlYI1Abu+68=;
        b=jtodadUycK+1LkDSYjWv8XqXchbrV8seFLSfpmqa6P3sOQ/of4IOcRUxXS1Bd4JQBX
         YhmbqlC+yxW9CTOk4i0D6sxWl0tLx5O0b/6PobzrrG7Khc1GwbaSCbDxfaFKRBlVF//X
         yBzwRrxphm+rRMuCnO5lQIVW1fkXROZV4I73U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0qI80nKbtNInC7TnaqV1RRwJ5MKOkQCfQlYI1Abu+68=;
        b=zhZInQP8wFLdgtFAi9vL8QnJV3LyHyb+TzpKVjgmIIWcY6CqBbxOep1EcOkuWub2Wh
         hN2JDMzF9HNuhYyCe0pvEt6sKEinBEjOSUqmzIxBmJGVjVnQyM0NiHLQDh0AWgDAn6qr
         lCEiRnBRLivz3jvINIUDXALSbtoyv53dW2LeqIL1wJliSq8CKtwuBG8n4KvPcH8mT++u
         TAmtDvZDBvmAHX0bN7iifF4LUOB/vwjeCencMtXa+GMhuge7l/WgAaGUBONj2Xd2k8yq
         Gf6988Kuu7dwhZ0IDw+mm02OxJWt4GONoqeUrkpXXqB10BrXwtC+roRNvzT0p8Wms/v0
         WEpA==
X-Gm-Message-State: ACgBeo0Oje4H+i0C/o9EHGzuQB2FgPlY3FAhHFytXpERYaZa/ZXjlKeT
        MScIiEg6a9+JCZWUsVylYxcFtQ==
X-Google-Smtp-Source: AA6agR4YcT+i543RaZOzyZZrxoYafQeMyJMNwQPlZAZ5N2PjqYDcx6ffwBEUmWSpOvruLmyqiKyulA==
X-Received: by 2002:a05:6808:143:b0:33a:d513:1443 with SMTP id h3-20020a056808014300b0033ad5131443mr1620237oie.43.1659532396382;
        Wed, 03 Aug 2022 06:13:16 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id t26-20020a0568080b3a00b0033a3e6e7ce9sm3539763oij.10.2022.08.03.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:13:16 -0700 (PDT)
Message-ID: <11578cfd-3d19-8bda-b36e-5e522e7c4490@cloudflare.com>
Date:   Wed, 3 Aug 2022 08:13:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/4] security, lsm: Introduce security_create_user_ns()
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
References: <20220801180146.1157914-1-fred@cloudflare.com>
 <20220801180146.1157914-2-fred@cloudflare.com>
 <CACYkzJ4x90DamdN4dRCn1gZuAHLqJNy4MoP=qTX+44Bqx1uxSQ@mail.gmail.com>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <CACYkzJ4x90DamdN4dRCn1gZuAHLqJNy4MoP=qTX+44Bqx1uxSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/2/22 4:47 PM, KP Singh wrote:
> On Mon, Aug 1, 2022 at 8:02 PM Frederick Lawler <fred@cloudflare.com> wrote:
>>
>> Preventing user namespace (privileged or otherwise) creation comes in a
>> few of forms in order of granularity:
>>
>>          1. /proc/sys/user/max_user_namespaces sysctl
>>          2. OS specific patch(es)
>>          3. CONFIG_USER_NS
>>
>> To block a task based on its attributes, the LSM hook cred_prepare is a
>> good candidate for use because it provides more granular control, and
>> it is called before create_user_ns():
>>
>>          cred = prepare_creds()
>>                  security_prepare_creds()
>>                          call_int_hook(cred_prepare, ...
>>          if (cred)
>>                  create_user_ns(cred)
>>
>> Since security_prepare_creds() is meant for LSMs to copy and prepare
>> credentials, access control is an unintended use of the hook. Therefore
>> introduce a new function security_create_user_ns() with an accompanying
>> userns_create LSM hook.
>>
>> This hook takes the prepared creds for LSM authors to write policy
>> against. On success, the new namespace is applied to credentials,
>> otherwise an error is returned.
>>
>> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
>> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> 
> This looks useful, and I would also like folks to consider the
> observability aspects of BPF LSM as
> brought up here:
> 
> https://lore.kernel.org/all/CAEiveUdPhEPAk7Y0ZXjPsD=Vb5hn453CHzS9aG-tkyRa8bf_eg@mail.gmail.com/
> 
> Frederick, what about adding the observability aspects to the commit
> description as well.

Agreed. I'll include that in v5.

> 
> - KP
> 
>>
>> ---
>> Changes since v3:
>> - No changes
>> Changes since v2:
>> - Rename create_user_ns hook to userns_create
>> Changes since v1:
>> - Changed commit wording
>> - Moved execution to be after id mapping check
>> - Changed signature to only accept a const struct cred *
>> ---
>>   include/linux/lsm_hook_defs.h | 1 +
>>   include/linux/lsm_hooks.h     | 4 ++++
>>   include/linux/security.h      | 6 ++++++
>>   kernel/user_namespace.c       | 5 +++++
>>   security/security.c           | 5 +++++
>>   5 files changed, 21 insertions(+)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index eafa1d2489fd..7ff93cb8ca8d 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -223,6 +223,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
>>           unsigned long arg3, unsigned long arg4, unsigned long arg5)
>>   LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>>           struct inode *inode)
>> +LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>>   LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
>>   LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
>>           u32 *secid)
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 91c8146649f5..54fe534d0e01 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -799,6 +799,10 @@
>>    *     security attributes, e.g. for /proc/pid inodes.
>>    *     @p contains the task_struct for the task.
>>    *     @inode contains the inode structure for the inode.
>> + * @userns_create:
>> + *     Check permission prior to creating a new user namespace.
>> + *     @cred points to prepared creds.
>> + *     Return 0 if successful, otherwise < 0 error code.
>>    *
>>    * Security hooks for Netlink messaging.
>>    *
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 7fc4e9f49f54..a195bf33246a 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -435,6 +435,7 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>>   int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>                          unsigned long arg4, unsigned long arg5);
>>   void security_task_to_inode(struct task_struct *p, struct inode *inode);
>> +int security_create_user_ns(const struct cred *cred);
>>   int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>>   void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
>>   int security_msg_msg_alloc(struct msg_msg *msg);
>> @@ -1185,6 +1186,11 @@ static inline int security_task_prctl(int option, unsigned long arg2,
>>   static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
>>   { }
>>
>> +static inline int security_create_user_ns(const struct cred *cred)
>> +{
>> +       return 0;
>> +}
>> +
>>   static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>>                                            short flag)
>>   {
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index 5481ba44a8d6..3f464bbda0e9 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/highuid.h>
>>   #include <linux/cred.h>
>>   #include <linux/securebits.h>
>> +#include <linux/security.h>
>>   #include <linux/keyctl.h>
>>   #include <linux/key-type.h>
>>   #include <keys/user-type.h>
>> @@ -113,6 +114,10 @@ int create_user_ns(struct cred *new)
>>              !kgid_has_mapping(parent_ns, group))
>>                  goto fail_dec;
>>
>> +       ret = security_create_user_ns(new);
>> +       if (ret < 0)
>> +               goto fail_dec;
>> +
>>          ret = -ENOMEM;
>>          ns = kmem_cache_zalloc(user_ns_cachep, GFP_KERNEL);
>>          if (!ns)
>> diff --git a/security/security.c b/security/security.c
>> index 188b8f782220..ec9b4696e86c 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1903,6 +1903,11 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
>>          call_void_hook(task_to_inode, p, inode);
>>   }
>>
>> +int security_create_user_ns(const struct cred *cred)
>> +{
>> +       return call_int_hook(userns_create, 0, cred);
>> +}
>> +
>>   int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>>   {
>>          return call_int_hook(ipc_permission, 0, ipcp, flag);
>> --
>> 2.30.2
>>

