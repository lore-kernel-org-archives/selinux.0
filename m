Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967AC00A89
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC87E2083B
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 11:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="hQMAHIjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgKELvP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 06:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgKELvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 06:51:15 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BAC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 03:51:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y17so1115598ilg.4
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cd6xhvEcE7KVWBpAcJfB5uesvFuUhUZH5J4rZ110meE=;
        b=hQMAHIjVPU4Vv3gDV5O6j8w8vKT0wNgRbNsuj0RQCu2TCDIWrWhCU1YEXWtbJ8MYFs
         ttzNTuKvqOT/uK9hoJ8t2brDr3UIPybbI5jHw/xIk0mIL6ur6568zzJ3IHUWEj1fcP/T
         KmeLo3pnbIRxgFXHi6cbcGH+YqrpCk45IfqQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cd6xhvEcE7KVWBpAcJfB5uesvFuUhUZH5J4rZ110meE=;
        b=UWg9Yp4SO3hczyL3tbihTmgNq4ZN2W2TRva2ugYDCYjGP6eHHvU1rlfD9xAA53pSDY
         yhpNbFXmApwwHW1r4aHfkjduabOu881EnEc79bNehk32D2aop6hWzzmeVsBtFG0VBYq0
         GBnplqDN/r+Uux1OFDy40BIwfRqTLrQQKYKP0x8CDf44BkLAByAJAANtwDWRqhtc0M8g
         AV7msEOxNy9me88R9i3/HOS0Bdl2Hl0X922jgHzyPav5KphSaP08S9TCHydNuOu87M2m
         IW8rX3je7y/PoT1Cbroz3FQkWPRmNnwq17bniBw/Pnfeu/V+kXt0sVgzYYrElgoehGy3
         B5vw==
X-Gm-Message-State: AOAM531TsqkSl34u+JJyfsx9c5a2tHOQYPtaUKR+HbmMYrmYOOWcBj21
        u+64A7eZ8a6LAzQioYX1FwD0c89Dg4nUkQ==
X-Google-Smtp-Source: ABdhPJzhHJfpsD0zq5YGSoGr4EwYtXh3AZG05syb/L4biujFfDoCGME5RVulGIfW4tCFJ09cEiD4SQ==
X-Received: by 2002:a05:6e02:f0e:: with SMTP id x14mr1552974ilj.228.1604577074080;
        Thu, 05 Nov 2020 03:51:14 -0800 (PST)
Received: from fedora.pebenito.net (pool-96-234-173-17.bltmmd.fios.verizon.net. [96.234.173.17])
        by smtp.gmail.com with ESMTPSA id o124sm1091444ila.62.2020.11.05.03.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:51:13 -0800 (PST)
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
 <20201027163749.GA25212@localhost.localdomain>
 <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
 <CAHC9VhQhKkS7hSfyOyef6c-gjmY-ab_L6mMR0SxAshv7d5Tm8g@mail.gmail.com>
 <CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <75de6395-5554-2fa5-183f-a4d361c290aa@ieee.org>
Date:   Thu, 5 Nov 2020 06:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/2/20 10:18 AM, Ondrej Mosnacek wrote:
> On Mon, Nov 2, 2020 at 3:46 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Nov 2, 2020 at 3:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>> On Tue, Oct 27, 2020 at 5:37 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>>> On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
>>>>> On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>>>>> Hello everyone (mainly the maintainers of projects on GH, but to avoid
>>>>>> a huge cc list, I'm sending this to the ML),
>>>>>>
>>>>>> As you may or may not know, Travis is migrating open-source projects
>>>>>> to their main site [1][2] (to .com from .org, where they have been
>>>>>> until now). AFAIK, the functionality stays pretty much the same, they
>>>>>> just want to have open-source and private projects under the same
>>>>>> infrastructure to unify things.
>>>>>>
>>>>>> Recently, they started migrating runners away from the .org site [3],
>>>>>> resulting in new builds being queued for a very long time. [4]
>>>>>>
>>>>>> I tried to migrate some of my forks (selinux-testsuite and selinux) to
>>>>>> the new site and it went smoothly. The only downside seems to be that
>>>>>> the build history is not migrated immediately (but it did show up
>>>>>> after a while). The queue times were indeed resolved after the
>>>>>> migration.
>>>>>>
>>>>>> So, I'd like to propose to start migrating the projects under
>>>>>> SELinuxProject that use the Travis CI (selinux, refpolicy,
>>>>>> selinux-testsuite, setools) now, so that we are not affected by the
>>>>>> lack of workers.
>>>>>>
>>>>>> If there are no objections until next week, I'll migrate the
>>>>>> selinux-testsuite, for a start. The other projects I'll leave for the
>>>>>> other maintainers, unless they choose to mandate me to do so :)
>>>>>
>>>>> Sounds good to me.
>>>>>
>>>>
>>>> Please do it for selinux too. Thank you!
>>>
>>> Apparently I would need to be an admin/owner in the SELinuxProject
>>> group to do anything... So either one of the owners will have to do it
>>> or make me an owner :)
>>
>> Done :)
> 
> Thanks, I've just migrated selinux and selinux-testsuite:
> https://travis-ci.com/github/SELinuxProject
> 
> I can also migrate refpolicy and setools if Chris gives me a thumbs-up.

Sure, go ahead. Thanks Ondrej!

-- 
Chris PeBenito
