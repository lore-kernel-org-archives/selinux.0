Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2AC48BDF
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 20:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E2A613C2
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 20:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhFRUjR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhFRUjR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 16:39:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B2C061574
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 13:37:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r16so15667287ljk.9
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJY4ErYj7kkBIH/QkJMBqMydsEYND/c4qzKMYDvxJQQ=;
        b=ct8u2bKcb3tbWVVIiliy2aIn+WCkw7+Nf+dcoHXZ5Y8e2SfnsiQPCfJxGvz1VD2J7b
         lBk1Z812EfCL5BDJKidsmnhDeSXBaUDb581HTvcp672cd5mu0h2DhztT0/Fe61Z7I1Wm
         Oncr+FYzlSP/bEU2sLZYrMh6y0tPBRmKPlVl5MO9CFNeHKuzix7L0o+FaPIG9IVXgAJc
         mrIjxJ0PITj2LOZdZ54qbpLREWM9C5ZWRO53n4Xi0Rr03OdtKsH8hOM8pZaREqVsniO7
         KsNqpwtEoKg+CgBdMoQBDUn5l4td1LZXEoCV2yRs29QFGMDkn/JEkBTYecPhwlDsCZKd
         4JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJY4ErYj7kkBIH/QkJMBqMydsEYND/c4qzKMYDvxJQQ=;
        b=AgLtVvvz2D4J4DLIUqLAscs2ZnZyumJWvns0xHc/KeCvE6ZaB6hZ4LWQkMVzTCf7t/
         iMex4KMlfVX3TQ3l1fu97zLvPSlQcaNsqI+OqrtlUWlI/qkGhQalNiONlfsNK262INWy
         Dr1UHyUc9kADgewG8UDJC5odCDj+ahoaLG1dJfK0/pbnXw+97SjIVV+XlKXXNmzDmbuL
         AB8fIEO4x1RJDwAVxX09CIdaepI3969yevdjG/rDRNJ0f0MfyKMUv1K8bLPYeWFs9A3L
         6fC5uesZViWBRMMj2QcyLdrnFNzy4DjCzGOr6EwK5wV8bNJFbOr8M9528RCS9Ew45KR3
         RmVA==
X-Gm-Message-State: AOAM531GQda38sF3aC0OqvlT69mfEHQIOHQjbofWl+lH6DXdU0c8K+19
        H0oSZVTbSfCvVtcaQ3eUJrxTy3dTZss=
X-Google-Smtp-Source: ABdhPJx+A05xWIo6yX7g5geZVjHQ+w5mCqaUHojHymFZrmvB0gTaMk1S4NuaqArxY8u9dm5Cpx0wdw==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr10744045ljq.375.1624048625039;
        Fri, 18 Jun 2021 13:37:05 -0700 (PDT)
Received: from [192.168.1.37] (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id x193sm289258lff.54.2021.06.18.13.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 13:37:04 -0700 (PDT)
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20210612081403.16732-1-toiwoton@gmail.com>
 <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
 <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com>
 <CAHC9VhQfVqRCuR4Gn7vAOrqVeZQtzE6GjuqvFhQHKVufCk_N3w@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <7d638d58-386f-b0e9-7a3d-e626fc8ba108@gmail.com>
Date:   Fri, 18 Jun 2021 23:37:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQfVqRCuR4Gn7vAOrqVeZQtzE6GjuqvFhQHKVufCk_N3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 18.6.2021 22.32, Paul Moore wrote:
> On Fri, Jun 18, 2021 at 2:09 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>> On 18.6.2021 6.50, Paul Moore wrote:
>>> On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>>>
>>>> Describe cases where nosuid_transition or nnp_transition are needed.
>>>>
>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>> ---
>>>>    src/computing_security_contexts.md | 9 ++++++++-
>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
>>>> index bb946b5..7bd1d87 100644
>>>> --- a/src/computing_security_contexts.md
>>>> +++ b/src/computing_security_contexts.md
>>>> @@ -84,7 +84,14 @@ Processes inherit their security context as follows:
>>>>       *default_type* (policy version 28) or if a security-aware process,
>>>>       by calling ***setexeccon**(3)* if permitted by policy prior to
>>>>       invoking exec.
>>>> -3. At any time, a security-aware process may invoke ***setcon**(3)* to
>>>> +3. If the file system is mounted with *nosuid* flag, type transitions
>>>> +   require permission *nosuid_transition*. If the thread has
>>>> +   *no_new_privs* attribute set, the transition requires
>>>> +   *nnp_transition*. For both transitions, policy capability
>>>> +   *nnp_nosuid_transition* is also required. See also
>>>> +   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
>>>> +   section.
>>>
>>> Thanks for adding this text, however I might suggest the following changes:
>>>
>>> "If the loaded SELinux policy has the nnp_nosuid_transition policy
>>> capability enabled there are potentially two additional permissions
>>> that are required to permit a domain transition: nosuid_transition for
>>> nosuid mounted filesystems, and nnp_transition for for threads with
>>> the no_new_privs flag."
>>>
>>> ... does that make sense?
>>
>> Yes. I'd then add:
>>
>> "If nnp_nosuid_transition policy capability is disabled, such domain
>> transitions are denied."
> 
> In most cases, yes that is correct, but bounded domain transitions are
> still allowed in the case where the nnp_nosuid_transition policy
> capability is not enabled.

I see. May I propose then:

"If nnp_nosuid_transition policy capability is disabled, such domain
transitions are denied but bounded domain transitions are still allowed. 
In bounded transitions, target domain is only allowed a subset of the 
permissions of the source domain."

-Topi
