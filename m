Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64479C2D0BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388462465E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SfmdHbs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRQcP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:32:15 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:38434
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbfLRQcO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 11:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576686730; bh=KSPqT2kOCWuAQuLOtkUGHlKHV3q/VyX1rpfQ4dFIiik=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SfmdHbs00rkjwPc8g8Env46Vnj/gCS/gSbIWHDvqnZp1r+gs7lLgClGKzH5aJuHIh1ug4Tv5cQO1IV3Babt1WUrbZRsHNOYntSzkNQwHCZjkHi2WFNChrI+rvb1ZLVyJi3NBYt7e9jZ6R5ZxbwbANcdU1SiliqSYUf/5QJbrPt0Ne4CJ7QFtPXDt5dARveyW4wThE+9RQEFIcUzzE5AqBjuhQqsRqdfJcwkUtb/mqv1KEg+hgpCjnvkJBcu+RwHXd+9C+HVF93F+6McLdLV/6higOLysAVtL6nbs3CSci2h2vjZZ+CayBjtDFS/YM++yq71gsIjlK6bOVHqvAQJEhA==
X-YMail-OSG: XwmV87gVM1lqfsF1mKqgvxQRgMw3LMgMiCRaNAtNfprI5cAeStIRL23wqwOfik6
 qRaxW16nqY0.IkSx.ex6RQZQIOVPDGB.g_m9TX40ycFtDd5aBzfyirfMDqmMQ8tlaS1mQPmJTaww
 tkHDBRafQIgPCXbOdaKe00WIMUEfywlLaDsdYmoLDWIwPb5LDUrLSaW5tHxIhXYVGv4cVldZIFsR
 fvKBNmGaigIoIdN8sE4F03Kug3kII961Y_3pR4SmtC.uSoa1vR32nX4fi.awhBdpWERP3qrKEusf
 pm8LVTsOq_H_bXDHpDU_1lrmn2ml.j_LJEsQOTk2oU.DyEU0YdrMUpXhzZ_Trp5o69WWlwqGOoA6
 qrSdzcaAonlsOmgi8bslfGI17qQ19wSuqp9zNETcWwM34wZbsh.iRyqvC7DzLnvIychf8_cp_N._
 2FcdROxcvo_aRYyYsfqm8MgC1qNB6Cjq8z7se_OnZYKRp33p_9wAxh5JVaSpm62azV4ZWcnC8UcO
 e2QIyt_PHBlWt3GJO0KvVyohXhVa9XnD.1844MbNBbFzVEORk1E.JCZ29zNHfl8Y1xqAAZaiVCQ3
 dMAjMlISnIU28m7s6Hq8DmZJh61tWmxKk_lEKDDKGHMPpKe3.LC8urHbZk6.Qjb9XPFTeb_ZNe31
 sShUJR0B.SEJk4cFevSaC_FAmTAwLZMb4kUnatho7DvGjjO5brM5lSXZZmk5f_EcLsk9.YmOIoPv
 in77HYGB1HRt9TNd3E3H3c6eYe7jWfpCnmTfsCBCttHIEpGO8x_y6hjSj4H1dB6uX.jZbrp4pWaT
 IIryFNEmBY67M7P7zHPdXvu24y1s2lgCr6.rmcjmqhUdhFLt8aZXQHXNplykDq2OTQbkmoBNke2v
 DkU1UxKYgzse5UF16q6bZMd0Xi7tPJrO2SLgfXM7YcmDXgKIj374ekDxWtrR5uo8ZI29Q_tDrsI9
 wxIWc4TZ8GJ3dxG0Pf.g_OauhJMqIQAi.1pZdw1iR_Vmh3ABIMxw4cd3f3.Qxt6.Vihu3WGpgcf1
 JsdcDhcZabQ_xpLx.4nlgzEhRIH0TZjfB7WZSRhiNV22lzfGxl5.iC6UHdPzqziHlGaRdzn8yb19
 AyBMU8sku12wN1FnLGbCxUIeWb.J1.O1WhjkxMF_sJw84vqeY1gT45z36LYGkN.LZk3IZ8KENEor
 j5tgyEo6DLeY7P57kE4Cp4_ggmU7gosCiP.pUYAojqIXzlUS.sXGjXQHK0bR.WxGiaxx9drHHxXT
 LQ7gfWWcQY2lU8gtBydyMcKnFdRQWwRKYSRNHsfJDexmZguQyX_c0XDNxZ9jE.cLUVWxWSelVAmi
 0iXJ6GhN9xlBbAV7bKWXkhCDUKKfHonIghcbClHtJ_a94nl4kJ5DD84WVYuPg.9QvYh0dd8JjC70
 hOruFvqmVHDfovX2MhJd9oLfsbT4j26UU4aaNbJdHWckSyxiIc4uEDBIIoyc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Dec 2019 16:32:10 +0000
Received: by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 67f34d36f77f50ff93d9e28f9221cc2c;
          Wed, 18 Dec 2019 16:32:07 +0000 (UTC)
Subject: Re: [PATCH v12 13/25] LSM: Specify which LSM to display
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-14-casey@schaufler-ca.com>
 <cb93ecc4-97aa-770d-25c8-ec128f3bedc2@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <65ba70b1-73d6-d44e-c3e7-6053e05b312f@schaufler-ca.com>
Date:   Wed, 18 Dec 2019 08:32:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <cb93ecc4-97aa-770d-25c8-ec128f3bedc2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/2019 7:17 AM, Stephen Smalley wrote:
> On 12/16/19 5:36 PM, Casey Schaufler wrote:
>> Create a new entry "display" in the procfs attr directory for
>> controlling which LSM security information is displayed for a
>> process. A process can only read or write its own display value.
>>
>> The name of an active LSM that supplies hooks for
>> human readable data may be written to "display" to set the
>> value. The name of the LSM currently in use can be read from
>> "display". At this point there can only be one LSM capable
>> of display active. A helper function lsm_task_display() is
>> provided to get the display slot for a task_struct.
>>
>> Setting the "display" requires that all security modules using
>> setprocattr hooks allow the action. Each security module is
>> responsible for defining its policy.
>>
>> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
>> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   fs/proc/base.c                       |   1 +
>>   include/linux/lsm_hooks.h            |  15 +++
>>   security/apparmor/include/apparmor.h |   3 +-
>>   security/apparmor/lsm.c              |  32 +++++
>>   security/security.c                  | 169 ++++++++++++++++++++++++---
>>   security/selinux/hooks.c             |  11 ++
>>   security/selinux/include/classmap.h  |   2 +-
>>   security/smack/smack_lsm.c           |   7 ++
>>   8 files changed, 221 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index ebea9501afb8..950c200cb9ad 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2652,6 +2652,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>>       ATTR(NULL, "fscreate",        0666),
>>       ATTR(NULL, "keycreate",        0666),
>>       ATTR(NULL, "sockcreate",    0666),
>> +    ATTR(NULL, "display",        0666),
>>   #ifdef CONFIG_SECURITY_SMACK
>>       DIR("smack",            0555,
>>           proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 7eb808cde051..2bf82e1cf347 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2186,4 +2186,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>>     extern int lsm_inode_alloc(struct inode *inode);
>>   +/**
>> + * lsm_task_display - the "display" LSM for this task
>> + * @task: The task to report on
>> + *
>> + * Returns the task's display LSM slot.
>> + */
>> +static inline int lsm_task_display(struct task_struct *task)
>> +{
>> +    int *display = task->security;
>> +
>> +    if (display)
>> +        return *display;
>> +    return LSMBLOB_INVALID;
>> +}
>> +
>>   #endif /* ! __LINUX_LSM_HOOKS_H */
>> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
>> index 1fbabdb565a8..b1622fcb4394 100644
>> --- a/security/apparmor/include/apparmor.h
>> +++ b/security/apparmor/include/apparmor.h
>> @@ -28,8 +28,9 @@
>>   #define AA_CLASS_SIGNAL        10
>>   #define AA_CLASS_NET        14
>>   #define AA_CLASS_LABEL        16
>> +#define AA_CLASS_DISPLAY_LSM    17
>>   -#define AA_CLASS_LAST        AA_CLASS_LABEL
>> +#define AA_CLASS_LAST        AA_CLASS_DISPLAY_LSM
>>     /* Control parameters settable through module/boot flags */
>>   extern enum audit_mode aa_g_audit;
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 146d75e5e021..16b992235c11 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>>       return error;
>>   }
>>   +
>> +static int profile_display_lsm(struct aa_profile *profile,
>> +                   struct common_audit_data *sa)
>> +{
>> +    struct aa_perms perms = { };
>> +    unsigned int state;
>> +
>> +    state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
>> +    if (state) {
>> +        aa_compute_perms(profile->policy.dfa, state, &perms);
>> +        aa_apply_modes_to_perms(profile, &perms);
>> +        aad(sa)->label = &profile->label;
>> +
>> +        return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int apparmor_setprocattr(const char *name, void *value,
>>                   size_t size)
>>   {
>> @@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
>>       if (size == 0)
>>           return -EINVAL;
>>   +    /* LSM infrastructure does actual setting of display if allowed */
>> +    if (!strcmp(name, "display")) {
>> +        struct aa_profile *profile;
>> +        struct aa_label *label;
>> +
>> +        aad(&sa)->info = "set display lsm";
>> +        label = begin_current_label_crit_section();
>> +        error = fn_for_each_confined(label, profile,
>> +                         profile_display_lsm(profile, &sa));
>> +        end_current_label_crit_section(label);
>> +        return error;
>> +    }
>> +
>>       /* AppArmor requires that the buffer must be null terminated atm */
>>       if (args[size - 1] != '\0') {
>>           /* null terminate */
>> diff --git a/security/security.c b/security/security.c
>> index 32354942b7e8..aaac748e4d83 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/backing-dev.h>
>>   #include <linux/string.h>
>>   #include <linux/msg.h>
>> +#include <linux/binfmts.h>
>>   #include <net/flow.h>
>>   #include <net/sock.h>
>>   @@ -43,7 +44,14 @@ static struct kmem_cache *lsm_file_cache;
>>   static struct kmem_cache *lsm_inode_cache;
>>     char *lsm_names;
>> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
>> +
>> +/*
>> + * The task blob includes the "display" slot used for
>> + * chosing which module presents contexts.
>> + */
>> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
>> +    .lbs_task = sizeof(int),
>> +};
>>     /* Boot-time LSM user choice */
>>   static __initdata const char *chosen_lsm_order;
>> @@ -438,8 +446,10 @@ static int lsm_append(const char *new, char **result)
>>     /*
>>    * Current index to use while initializing the lsmblob secid list.
>> + * Pointers to the LSM id structures for local use.
>>    */
>>   static int lsm_slot __lsm_ro_after_init;
>> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>>     /**
>>    * security_add_hooks - Add a modules hooks to the hook lists.
>> @@ -459,6 +469,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>       if (lsmid->slot == LSMBLOB_NEEDED) {
>>           if (lsm_slot >= LSMBLOB_ENTRIES)
>>               panic("%s Too many LSMs registered.\n", __func__);
>> +        lsm_slotlist[lsm_slot] = lsmid;
>>           lsmid->slot = lsm_slot++;
>>           init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>>                  lsmid->slot);
>> @@ -588,6 +599,8 @@ int lsm_inode_alloc(struct inode *inode)
>>    */
>>   static int lsm_task_alloc(struct task_struct *task)
>>   {
>> +    int *display;
>> +
>>       if (blob_sizes.lbs_task == 0) {
>>           task->security = NULL;
>>           return 0;
>> @@ -596,6 +609,15 @@ static int lsm_task_alloc(struct task_struct *task)
>>       task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>>       if (task->security == NULL)
>>           return -ENOMEM;
>> +
>> +    /*
>> +     * The start of the task blob contains the "display" LSM slot number.
>> +     * Start with it set to the invalid slot number, indicating that the
>> +     * default first registered LSM be displayed.
>> +     */
>> +    display = task->security;
>> +    *display = LSMBLOB_INVALID;
>> +
>>       return 0;
>>   }
>>   @@ -1551,14 +1573,26 @@ int security_file_open(struct file *file)
>>     int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>>   {
>> +    int *odisplay = current->security;
>> +    int *ndisplay;
>>       int rc = lsm_task_alloc(task);
>>   -    if (rc)
>> +    if (unlikely(rc))
>>           return rc;
>> +
>>       rc = call_int_hook(task_alloc, 0, task, clone_flags);
>> -    if (unlikely(rc))
>> +    if (unlikely(rc)) {
>>           security_task_free(task);
>> -    return rc;
>> +        return rc;
>> +    }
>> +
>> +    if (odisplay) {
>> +        ndisplay = task->security;
>> +        if (ndisplay)
>> +            *ndisplay = *odisplay;
>> +    }
>> +
>> +    return 0;
>>   }
>>     void security_task_free(struct task_struct *task)
>> @@ -1955,23 +1989,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>                   char **value)
>>   {
>>       struct security_hook_list *hp;
>> +    int display = lsm_task_display(current);
>> +    int slot = 0;
>> +
>> +    if (!strcmp(name, "display")) {
>> +        /*
>> +         * lsm_slot will be 0 if there are no displaying modules.
>> +         */
>> +        if (lsm_slot == 0)
>> +            return -EINVAL;
>> +
>> +        /*
>> +         * Only allow getting the current process' display.
>> +         * There are too few reasons to get another process'
>> +         * display and too many LSM policy issues.
>> +         */
>> +        if (current != p)
>> +            return -EINVAL;
>> +
>> +        display = lsm_task_display(p);
>> +        if (display != LSMBLOB_INVALID)
>> +            slot = display;
>> +        *value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
>> +        if (*value)
>> +            return strlen(*value);
>> +        return -ENOMEM;
>> +    }
>>         hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>           if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>               continue;
>> +        if (lsm == NULL && display != LSMBLOB_INVALID &&
>> +            display != hp->lsmid->slot)
>> +            continue;
>>           return hp->hook.getprocattr(p, name, value);
>>       }
>>       return -EINVAL;
>>   }
>>   +/**
>> + * security_setprocattr - Set process attributes via /proc
>> + * @lsm: name of module involved, or NULL
>> + * @name: name of the attribute
>> + * @value: value to set the attribute to
>> + * @size: size of the value
>> + *
>> + * Set the process attribute for the specified security module
>> + * to the specified value. Note that this can only be used to set
>> + * the process attributes for the current, or "self" process.
>> + * The /proc code has already done this check.
>> + *
>> + * Returns 0 on success, an appropriate code otherwise.
>> + */
>>   int security_setprocattr(const char *lsm, const char *name, void *value,
>>                size_t size)
>>   {
>>       struct security_hook_list *hp;
>> +    char *term;
>> +    char *cp;
>> +    int *display = current->security;
>> +    int rc = -EINVAL;
>> +    int slot = 0;
>> +
>> +    if (!strcmp(name, "display")) {
>> +        /*
>> +         * Change the "display" value only if all the security
>> +         * modules that support setting a procattr allow it.
>> +         * It is assumed that all such security modules will be
>> +         * cooperative.
>> +         */
>> +        if (size == 0)
>> +            return -EINVAL;
>> +
>> +        hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
>> +                     list) {
>> +            rc = hp->hook.setprocattr(name, value, size);
>> +            if (rc < 0)
>> +                return rc;
>> +        }
>> +
>> +        rc = -EINVAL;
>> +
>> +        term = kmemdup_nul(value, size, GFP_KERNEL);
>> +        if (term == NULL)
>> +            return -ENOMEM;
>> +
>> +        cp = strsep(&term, " \n");
>> +
>> +        for (slot = 0; slot < lsm_slot; slot++)
>> +            if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
>> +                *display = lsm_slotlist[slot]->slot;
>> +                rc = size;
>> +                break;
>> +            }
>> +
>> +        kfree(cp);
>
> This makes me slightly nervous; I see that it is correct currently but worry about cp being changed at some point to no longer refer to the start of the allocated buffer. I'd favor not mutating term (i.e. pass a temporary to strsep) and freeing it.

Sure. I'll make this more obviously safe.

>
>> +        return rc;
>> +    }
>>         hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>           if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>               continue;
>> +        if (lsm == NULL && *display != LSMBLOB_INVALID &&
>> +            *display != hp->lsmid->slot)
>> +            continue;
>>           return hp->hook.setprocattr(name, value, size);
>>       }
>>       return -EINVAL;
>> @@ -1991,15 +2112,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>>   int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>>   {
>>       struct security_hook_list *hp;
>> -    int rc;
>> +    int display = lsm_task_display(current);
>>         hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>>           if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>>               continue;
>> -        rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
>> -                          secdata, seclen);
>> -        if (rc != 0)
>> -            return rc;
>> +        if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
>> +            return hp->hook.secid_to_secctx(
>> +                    blob->secid[hp->lsmid->slot],
>> +                    secdata, seclen);
>>       }
>>       return 0;
>>   }
>> @@ -2009,16 +2130,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>>                    struct lsmblob *blob)
>>   {
>>       struct security_hook_list *hp;
>> -    int rc;
>> +    int display = lsm_task_display(current);
>>         lsmblob_init(blob, 0);
>>       hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>>           if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>>               continue;
>> -        rc = hp->hook.secctx_to_secid(secdata, seclen,
>> -                          &blob->secid[hp->lsmid->slot]);
>> -        if (rc != 0)
>> -            return rc;
>> +        if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
>> +            return hp->hook.secctx_to_secid(secdata, seclen,
>> +                        &blob->secid[hp->lsmid->slot]);
>>       }
>>       return 0;
>>   }
>> @@ -2026,7 +2146,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>>     void security_release_secctx(char *secdata, u32 seclen)
>>   {
>> -    call_void_hook(release_secctx, secdata, seclen);
>> +    struct security_hook_list *hp;
>> +    int *display = current->security;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
>> +        if (display == NULL || *display == LSMBLOB_INVALID ||
>> +            *display == hp->lsmid->slot) {
>> +            hp->hook.release_secctx(secdata, seclen);
>> +            return;
>> +        }
>>   }
>
> I was wondering why you didn't use lsm_task_display() here and retain the same pattern as the other hooks?

Just missed it. Thanks for pointing it out. I'll fix it.

>
>>   EXPORT_SYMBOL(security_release_secctx);
>>   @@ -2151,8 +2279,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>                         int __user *optlen, unsigned len)
>>   {
>> -    return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -                optval, optlen, len);
>> +    int display = lsm_task_display(current);
>> +    struct security_hook_list *hp;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
>> +                 list)
>> +        if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
>> +            return hp->hook.socket_getpeersec_stream(sock, optval,
>> +                                 optlen, len);
>> +    return -ENOPROTOOPT;
>>   }
>>     int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 97f2ee6e4080..b8501ca3c8f3 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6323,6 +6323,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>       /*
>>        * Basic control over ability to set these attributes at all.
>>        */
>> +
>> +    /*
>> +     * For setting display, we only perform a permission check;
>> +     * the actual update to the display value is handled by the
>> +     * LSM framework.
>> +     */
>> +    if (!strcmp(name, "display"))
>> +        return avc_has_perm(&selinux_state,
>> +                    mysid, mysid, SECCLASS_PROCESS2,
>> +                    PROCESS2__SETDISPLAY, NULL);
>> +
>>       if (!strcmp(name, "exec"))
>>           error = avc_has_perm(&selinux_state,
>>                        mysid, mysid, SECCLASS_PROCESS,
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index 7db24855e12d..323da8a38c43 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
>>           "execmem", "execstack", "execheap", "setkeycreate",
>>           "setsockcreate", "getrlimit", NULL } },
>>       { "process2",
>> -      { "nnp_transition", "nosuid_transition", NULL } },
>> +      { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>>       { "system",
>>         { "ipc_info", "syslog_read", "syslog_mod",
>>           "syslog_console", "module_request", "module_load", NULL } },
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 82cbb3eeec76..9737ead06b39 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3518,6 +3518,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>>       struct smack_known_list_elem *sklep;
>>       int rc;
>>   +    /*
>> +     * Allow the /proc/.../attr/current and SO_PEERSEC "display"
>> +     * to be reset at will.
>> +     */
>> +    if (strcmp(name, "display") == 0)
>> +        return 0;
>> +
>>       if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>>           return -EPERM;
>>  
>
