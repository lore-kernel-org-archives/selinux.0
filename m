Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0CC43334
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiGTO6A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiGTO56 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 10:57:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6E4A803
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 07:57:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u9so11125449oiv.12
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XSU2WUPOvF0fUCTGSGRZkl8WCZhfSChGKTGTEOsuYNI=;
        b=iGIpbP2d3UEwVFWw5G9dZlMqJx4o8UCPvRj6piZLN7Qixwv38zIteUBoiwtf11TzoJ
         8pcI1FzJmEI8s8Z8r4wNd/P56A7AMD40p0ifu6Z8wqaycmhnxl9M7kNdXzB8SXogNKD/
         YVqd80JtH2cgsBKx3SUf9wdgi1qit4j7Py/II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XSU2WUPOvF0fUCTGSGRZkl8WCZhfSChGKTGTEOsuYNI=;
        b=Gef2uKKBHFrM+E4IVMH8QMnjbBqoeeENQtauFaboWDWlUtlj++Mh/JRAG9IgoaPEZa
         Pscpo9hRrapoQTiVpF2JEAETP1gAtwNrJw5DF+Zb5K1FXcd4rzChzHbdu+LbQui7GC2o
         ks6WAK27KJ1DLEWUysQ22gc6gX0jRBR3Zns0i5N7j5TNkRu54ixiHRxpgb9vzqCH9twK
         Abnp0a/iu1n5KcBwxzufUbYnAR6dVsjc8fqurr77t0UmgRWIuZzV4YpE+Jbq+QzDRz7u
         pAOlhB4aoRr19sjhfsy51AbKvbA1K1cmy/ZOBMb28JipCNOE4tahBo8PWo7llpkSiOkl
         3bGQ==
X-Gm-Message-State: AJIora9zo1iK2uEemxMuUKW//7+fgRmFJu7cqtT88DE4UpZJpDOdtIGo
        F8UivPMaorVNymKlsjCfkaYmcQ==
X-Google-Smtp-Source: AGRyM1v5UNxUPAVexBnv65PVVqbWvE8t6MWf9AqqczcauOBSa7XBiaehpgEh3k3h5n6IkYivB27NLA==
X-Received: by 2002:a05:6808:170c:b0:335:1d14:f99d with SMTP id bc12-20020a056808170c00b003351d14f99dmr2435919oib.243.1658329076048;
        Wed, 20 Jul 2022 07:57:56 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id z14-20020a9d62ce000000b0061c7a5691f2sm7425058otk.47.2022.07.20.07.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 07:57:55 -0700 (PDT)
Message-ID: <42069251-3ea7-b0c7-4efb-e144c52ebf51@cloudflare.com>
Date:   Wed, 20 Jul 2022 09:57:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] selinux: Implement create_user_ns hook
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20220707223228.1940249-1-fred@cloudflare.com>
 <20220707223228.1940249-5-fred@cloudflare.com>
 <CAHC9VhTkvPvqGQjyEKbi2pkKBtRQE=Uat34aoKsxjWU0qkF6CA@mail.gmail.com>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <CAHC9VhTkvPvqGQjyEKbi2pkKBtRQE=Uat34aoKsxjWU0qkF6CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/19/22 8:32 PM, Paul Moore wrote:
> On Thu, Jul 7, 2022 at 6:32 PM Frederick Lawler <fred@cloudflare.com> wrote:
>>
>> Unprivileged user namespace creation is an intended feature to enable
>> sandboxing, however this feature is often used to as an initial step to
>> perform a privilege escalation attack.
>>
>> This patch implements a new namespace { userns_create } access control
>> permission to restrict which domains allow or deny user namespace
>> creation. This is necessary for system administrators to quickly protect
>> their systems while waiting for vulnerability patches to be applied.
>>
>> This permission can be used in the following way:
>>
>>          allow domA_t domB_t : namespace { userns_create };
>>
>> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
>>
>> ---
>> Changes since v1:
>> - Introduce this patch
>> ---
>>   security/selinux/hooks.c            | 9 +++++++++
>>   security/selinux/include/classmap.h | 2 ++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index beceb89f68d9..73fbcb434fe0 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>>          spin_unlock(&isec->lock);
>>   }
>>
>> +static int selinux_userns_create(const struct cred *cred)
>> +{
>> +       u32 sid = current_sid();
>> +
>> +       return avc_has_perm(&selinux_state, sid, sid, SECCLASS_NAMESPACE,
>> +                                               NAMESPACE__USERNS_CREATE, NULL);
>> +}
> 
> As we continue to discuss this, I'm beginning to think that having a
> dedicated object class for the userns might be a good idea.  I believe
> I was the one who gave you these code snippets, so feel free to blame
> me for the respin ;)
> 

No worries, I'll make this change for v3.

> This is what I'm thinking:
> 
>    static int selinux_userns_create(const struct cred *cred)
>    {
>      u32 sid = current_sid();
> 
>      return avc_has_perm(&selinux_state, sid, sid,
>                          SECCLASS_USER_NAMESPACE,
>                          USER_NAMESPACE__CREATE, NULL);
>    }
> 
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index ff757ae5f253..9943e85c6b3e 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
>>            { COMMON_FILE_PERMS, NULL } },
>>          { "io_uring",
>>            { "override_creds", "sqpoll", NULL } },
>> +       { "namespace",
>> +         { "userns_create", NULL } },
> 
> The above would need to change to:
> 
>    { "user_namespace",
>      { "create", NULL } }
> 

