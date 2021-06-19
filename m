Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5496C2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 07:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F166112D
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 07:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFSHpY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSHpY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 03:45:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD8C061574
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 00:43:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t17so443333lfq.0
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SytRCR8UWCxrLKiJOzOXe3PCqNo8nK1JfFnJ+o9VKco=;
        b=TBPxK7UJCgH4kVjHM3Z2yQbAy0JcRF3JDa7yfB7mBbE96mbimDQYOr12hXSG3ymSqz
         UXraDHAhEc8Xx0VNzRzmXMTjXblX5T4Jpzdo5NSj5AElLCzPDrfOtCKhKDQStXDZbSbW
         aMrzszhuoRRAX8RHgI1pnvI9zaLC1y/He6rfpn74s1/tMJAPxBOrEw+2QuRF6Xo4i8Ze
         g1LVqFPdqoQ1rLK3WqtetOVKQVxWQhoIAwZrhNSPA6OjxD48KAhJgGcVkC1Mc1fmbO8+
         BKisDC4cgZXkFOLpa96HssnUmdwlteiLYGSKNf9xd5KB6rvVNmHeG/L3s+0sKnxqZfvg
         f0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SytRCR8UWCxrLKiJOzOXe3PCqNo8nK1JfFnJ+o9VKco=;
        b=tRHNjH9UUfC/5O/KqhaW2XyT1MKm27VI0u3v3lbFfgnquzBSDYBAUMHwsbzeIuYmrc
         dA1ZaKKWIacSBMep7rErJjjVrJrZg4WqUe+bnk081HJy6Jvk8SXY4bqZo0lX9G3livCS
         Pwv9FsBJL4tscNKGCHZq5GXIzzDzNMrSGt1w6yQIDKXJDWzwf971k3EbSTEytGlBeZJs
         7eXljZUOaIKI9G75zzpI+0x6Pf9hpDh1kz6bR6AAR/ck/8UZN8k754SftEUGuz+4g0WC
         nOxOWd4ckwrLLO1dYhVz9Cr3pFzvA2RnYs3hgTI6yVS26J9zuScLeF78jOhqI5bjiDtz
         iCVA==
X-Gm-Message-State: AOAM533bIc7cXn+iHkk9NM0CX4KdVlrDB53xjOHu67tdj/p+f/cafK4C
        w6nXJrd/omw+nGHQ8UVtQNPzy0R3QNc=
X-Google-Smtp-Source: ABdhPJwlLi2cyEvaJUjl7wgrCoCjlBmsanwakvvWU+PXbdoUQcCUab2L8NIR/A190HJiE9mD2SKGzA==
X-Received: by 2002:a05:6512:1315:: with SMTP id x21mr6108152lfu.87.1624088589752;
        Sat, 19 Jun 2021 00:43:09 -0700 (PDT)
Received: from [192.168.1.37] (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id b25sm1148497lfo.271.2021.06.19.00.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 00:43:09 -0700 (PDT)
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
From:   Topi Miettinen <toiwoton@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20210612081403.16732-1-toiwoton@gmail.com>
 <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
 <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com>
 <CAHC9VhQfVqRCuR4Gn7vAOrqVeZQtzE6GjuqvFhQHKVufCk_N3w@mail.gmail.com>
 <7d638d58-386f-b0e9-7a3d-e626fc8ba108@gmail.com>
Message-ID: <384e5df4-223f-f57d-0d3e-9a53aa745130@gmail.com>
Date:   Sat, 19 Jun 2021 10:43:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7d638d58-386f-b0e9-7a3d-e626fc8ba108@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 18.6.2021 23.37, Topi Miettinen wrote:
> On 18.6.2021 22.32, Paul Moore wrote:
>> On Fri, Jun 18, 2021 at 2:09 PM Topi Miettinen <toiwoton@gmail.com> 
>> wrote:
>>> On 18.6.2021 6.50, Paul Moore wrote:
>>>> On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> 
>>>> wrote:
>>>>>
>>>>> Describe cases where nosuid_transition or nnp_transition are needed.
>>>>>
>>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>>> ---
>>>>>    src/computing_security_contexts.md | 9 ++++++++-
>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/src/computing_security_contexts.md 
>>>>> b/src/computing_security_contexts.md
>>>>> index bb946b5..7bd1d87 100644
>>>>> --- a/src/computing_security_contexts.md
>>>>> +++ b/src/computing_security_contexts.md
>>>>> @@ -84,7 +84,14 @@ Processes inherit their security context as 
>>>>> follows:
>>>>>       *default_type* (policy version 28) or if a security-aware 
>>>>> process,
>>>>>       by calling ***setexeccon**(3)* if permitted by policy prior to
>>>>>       invoking exec.
>>>>> -3. At any time, a security-aware process may invoke 
>>>>> ***setcon**(3)* to
>>>>> +3. If the file system is mounted with *nosuid* flag, type transitions
>>>>> +   require permission *nosuid_transition*. If the thread has
>>>>> +   *no_new_privs* attribute set, the transition requires
>>>>> +   *nnp_transition*. For both transitions, policy capability
>>>>> +   *nnp_nosuid_transition* is also required. See also
>>>>> +   [**Linux Security Module and 
>>>>> SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
>>>>> +   section.
>>>>
>>>> Thanks for adding this text, however I might suggest the following 
>>>> changes:
>>>>
>>>> "If the loaded SELinux policy has the nnp_nosuid_transition policy
>>>> capability enabled there are potentially two additional permissions
>>>> that are required to permit a domain transition: nosuid_transition for
>>>> nosuid mounted filesystems, and nnp_transition for for threads with
>>>> the no_new_privs flag."
>>>>
>>>> ... does that make sense?
>>>
>>> Yes. I'd then add:
>>>
>>> "If nnp_nosuid_transition policy capability is disabled, such domain
>>> transitions are denied."
>>
>> In most cases, yes that is correct, but bounded domain transitions are
>> still allowed in the case where the nnp_nosuid_transition policy
>> capability is not enabled.
> 
> I see. May I propose then:
> 
> "If nnp_nosuid_transition policy capability is disabled, such domain
> transitions are denied but bounded domain transitions are still allowed. 
> In bounded transitions, target domain is only allowed a subset of the 
> permissions of the source domain."

By the way, the background for this patch (and others for mount(2), 
mount(8) and selinux(8)) was that I recently proposed new heuristics for 
systemd where in case no_new_privileges would be implied (for example, 
due to use of seccomp), all file systems would be mounted `nosuid` since 
setuid/setgid wouldn't be allowed anyway. The heuristics patch was 
applied but later reverted because of problems it may cause for SELinux. 
I didn't know then how SELinux uses the flag to also control domain 
transitions. Also the case seems to be underdocumented, which I'm trying 
to improve with the patches.

Regarding the heuristics, perhaps instead of tying MAC behavior (also FS 
capabilities) to a DAC concept of setuid/setgid with MS_NOSUID, there 
should be new mount flags which would allow more precise handling of all 
combinations of SUID, SELinux domain transitions and FS capabilities. 
For example 
"nosuid,security=selinux=domain_transitions_allowed:capability=fs_caps_allowed". 
Then systemd could safely mount all file systems "nosuid" (when NNP is 
already going to be enforced) while keeping behavior of SELinux domain 
transitions and FS capabilities unchanged.

-Topi
