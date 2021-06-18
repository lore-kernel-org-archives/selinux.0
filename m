Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3CC48BDF
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E47F61042
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhFRSLt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhFRSLs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 14:11:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB388C06175F
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 11:09:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s22so15187940ljg.5
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+HORiUuuTSsd8aZJA20ziiNFQgGm1FNF9Gh2cywZDMo=;
        b=niDF2yoTd3XHH0AGBT6to5mdb5CnZWB3PEQDD1ehu2yWK70bURvScd7tlcJsAQ7Qw7
         7snjgVz+9JeQ4SUMz/20hpZ32dLuoH86YhUINOawj1usZ2kSZEa8PSo/ul1wLyyIcOu4
         m6lXeZ9sMC3s6vbqyZ7xKbl7Es9uxqvickwwgOlEhj8kFPgq3rsHmUb28eRaGC2m08uO
         PSfO1IhEU5XW8lx9liqVHXdylHTq8cs11OYTnZNSvvc8GREzY4ucBThFXpIcFkyGB2hq
         MBhPhd6vT+zZ+XMu45gqpONmqaeETyyC5Q5ZJ1iI6zEkcQ8ayiLbp2YwZPWN4yKN4K7n
         ybUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+HORiUuuTSsd8aZJA20ziiNFQgGm1FNF9Gh2cywZDMo=;
        b=rRiykXKzwOqNwrJXK0bl3EOBdBQjEek7xXvo7l9woZfbBDYvq7Ja6S8zuAsxE+GLkq
         IGTIgbdbsC8xaLdXmi6YjojlfdQx81/ZpKnUFM8/912efM7uoEmDWH4glb8BItpGzJtL
         CyDeSU88bDjb/WCK9+uhGDvIZqME2Oluy13/Z6JfUGpozR1a6DcM7eOniEdLYy1H5lJJ
         HLbm9bVxLVm213kIdCVxlnaGe058WjqrIR23X6Xkgl5HaXc+BZFUcfPZ/Qg19IIp9KUP
         MQRaaAH8+Wsm0Uwhmie64/hAu/2MVbXsI5ZKszskBsQxHJFv6p2fQ6VN09VS5AFqe2eu
         w/SA==
X-Gm-Message-State: AOAM531WNK6DfAQ5mw8DaTI2DpxSSYJyVvZemQ2plwIeq7CgwmGCxRPk
        gzMfQWnQ3asujqvbZiV4ifJegqQEoZ4=
X-Google-Smtp-Source: ABdhPJxe2lbo8Eh66dohjiT8MD6IqCjhl9QppndDcWaQ0exdDBhz+w5PNkNsrw3BhgAZ/fyzd20klg==
X-Received: by 2002:a05:651c:1682:: with SMTP id bd2mr8629187ljb.355.1624039775430;
        Fri, 18 Jun 2021 11:09:35 -0700 (PDT)
Received: from [192.168.1.37] (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id i21sm1136667ljb.10.2021.06.18.11.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 11:09:34 -0700 (PDT)
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20210612081403.16732-1-toiwoton@gmail.com>
 <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com>
Date:   Fri, 18 Jun 2021 21:09:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 18.6.2021 6.50, Paul Moore wrote:
> On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Describe cases where nosuid_transition or nnp_transition are needed.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>>   src/computing_security_contexts.md | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
>> index bb946b5..7bd1d87 100644
>> --- a/src/computing_security_contexts.md
>> +++ b/src/computing_security_contexts.md
>> @@ -84,7 +84,14 @@ Processes inherit their security context as follows:
>>      *default_type* (policy version 28) or if a security-aware process,
>>      by calling ***setexeccon**(3)* if permitted by policy prior to
>>      invoking exec.
>> -3. At any time, a security-aware process may invoke ***setcon**(3)* to
>> +3. If the file system is mounted with *nosuid* flag, type transitions
>> +   require permission *nosuid_transition*. If the thread has
>> +   *no_new_privs* attribute set, the transition requires
>> +   *nnp_transition*. For both transitions, policy capability
>> +   *nnp_nosuid_transition* is also required. See also
>> +   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
>> +   section.
> 
> Thanks for adding this text, however I might suggest the following changes:
> 
> "If the loaded SELinux policy has the nnp_nosuid_transition policy
> capability enabled there are potentially two additional permissions
> that are required to permit a domain transition: nosuid_transition for
> nosuid mounted filesystems, and nnp_transition for for threads with
> the no_new_privs flag."
> 
> ... does that make sense?

Yes. I'd then add:

"If nnp_nosuid_transition policy capability is disabled, such domain 
transitions are denied."

-Topi

>> +4. At any time, a security-aware process may invoke ***setcon**(3)* to
>>      switch its security context (if permitted by policy) although this
>>      practice is generally discouraged - exec-based transitions are
>>      preferred.
>> --
>> 2.30.2
> 

