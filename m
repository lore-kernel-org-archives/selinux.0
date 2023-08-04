Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9DC001DE
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 03:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHDDu2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjHDDuX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 23:50:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7B4200
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 20:50:20 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHBXn6qpqzrS7Q;
        Fri,  4 Aug 2023 11:49:13 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 11:50:18 +0800
Message-ID: <c3fd6ad6-d84b-2499-ac6c-24551542549b@huawei.com>
Date:   Fri, 4 Aug 2023 11:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] selinux: cleanup obsolete comments for
 selinux_hooks[]
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <selinux@vger.kernel.org>
References: <20230801013718.270018-1-xiujianfeng@huawei.com>
 <CAHC9VhSCujzsMDq1W1w0R1rLPdSQrqeuacP25Ob5XBna8hQJUQ@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhSCujzsMDq1W1w0R1rLPdSQrqeuacP25Ob5XBna8hQJUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On 2023/8/4 10:25, Paul Moore wrote:
> On Mon, Jul 31, 2023 at 9:39 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>>
>> After commit f22f9aaf6c3d ("selinux: remove the runtime disable
>> functionality"), the order in selinux_hooks[] does not affect
>> any selinux function, so remove the comments.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  security/selinux/hooks.c | 21 ---------------------
>>  1 file changed, 21 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 2906fdaf7371..ef813970cb9c 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6951,21 +6951,6 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>>  }
>>  #endif /* CONFIG_IO_URING */
>>
>> -/*
>> - * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>> - * 1. any hooks that don't belong to (2.) or (3.) below,
>> - * 2. hooks that both access structures allocated by other hooks, and allocate
>> - *    structures that can be later accessed by other hooks (mostly "cloning"
>> - *    hooks),
>> - * 3. hooks that only allocate structures that can be later accessed by other
>> - *    hooks ("allocating" hooks).
>> - *
>> - * Please follow block comment delimiters in the list to keep this order.
>> - *
>> - * This ordering is needed for SELinux runtime disable to work at least somewhat
>> - * safely. Breaking the ordering rules above might lead to NULL pointer derefs
>> - * when disabling SELinux at runtime.
>> - */
> 
> I don't mind the hook ordering message, even if it is not strictly
> necessary anymore, so let's keep it for now.  However, if you wanted
> to remove that last paragraph about it being needed to support the
> runtime disable functionality that would be okay.

Thanks, I will send another one.

> 
>>  static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>         LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>>         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>> @@ -7201,9 +7186,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>         LSM_HOOK_INIT(uring_cmd, selinux_uring_cmd),
>>  #endif
>>
>> -       /*
>> -        * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>> -        */
>>         LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>>         LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>>         LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>> @@ -7211,9 +7193,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>         LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
>>  #endif
>>
>> -       /*
>> -        * PUT "ALLOCATING" HOOKS HERE
>> -        */
>>         LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
>>         LSM_HOOK_INIT(msg_queue_alloc_security,
>>                       selinux_msg_queue_alloc_security),
>> --
>> 2.34.1
> 
