Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A8FC433EF
	for <selinux@archiver.kernel.org>; Sat, 12 Feb 2022 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiBLBDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 20:03:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354503AbiBLBDY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 20:03:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4ECCF8
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 17:03:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cf2so18765621edb.9
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 17:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Jylezh7VS7G/BlhafyJFuuTI7qFqw+HPxN/oW975++k=;
        b=AemSTSkf198WSX3kAPoUztl2230IHGfYjmc7H9pNaYKIP5YxSCFtkkddu7W/HOpIc9
         ldtwN/+j13sj9VlBpFxQEvUTG0Dn3qvFqGzyXRy78tvrYZNdBVrrmu/H06CtlZQ5KbZB
         5xKSk9K1ATuOHkOxvWb5UCO5t5hg6Qgy6w9/OEmvWmZveRq6qwHvejvGQ6YdzD0KH9Yz
         6ivzKD1piZJV+WEUQ/supju4+dA2/08V4gVMt29aMxlU8FLRbej10yY3wbyElCudzXo3
         9zMidJVf+XC3/QO9fxH5cDg9S6by+/lazfAUaTxk6xGD4v3e45Ichf6nezBbmKJwAeb3
         +LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Jylezh7VS7G/BlhafyJFuuTI7qFqw+HPxN/oW975++k=;
        b=iaz0H/e7hNB//+o1VOGlX8ekfE9BapG/u0VFjzkQ7TshWQo+dbMJJa3gkA7K5bT6kx
         /+KyI5kki+uk1HKPJtPT7APwGBdH3g4Qusyd5SKoUwTckx5zbQtcNFKop4vB8HRYctUg
         smZTpny3g74dfyWV1oYvZHX9LhYAgeckThHqLHIfmXeCZqWYssm82W+bZ5vlSBnJDa5M
         nIend+sh5+UVe0guYhUkGYAXREOUpqymJG9zieNNKi3d7Nfx4OBYJyw06Fq1PfeiGDjZ
         7TX1xtLLAed0RcKa6NOdryt4A7aV3wD4x5You52CY0srcSeS7f0VZjwPvIqhUKITrYcW
         625w==
X-Gm-Message-State: AOAM530Q/BbjoCoCm9EDcpjFiPn6Cj3kIG7EhxryjFd2OKQal6/x0xyX
        oiyX5N2FQ5lqYnPsA5x7vR2+gQjg5K8=
X-Google-Smtp-Source: ABdhPJwIflNpTDEwWOpk0G+CHh3hQQNCeYQ7ewHf8F+XvsIjfDtTGzGWDoAZij26XPapHJvpGady3Q==
X-Received: by 2002:a05:6402:4415:: with SMTP id y21mr4560156eda.162.1644627800013;
        Fri, 11 Feb 2022 17:03:20 -0800 (PST)
Received: from ?IPV6:2001:a61:34b2:1901:395b:b68e:7b61:ae3e? ([2001:a61:34b2:1901:395b:b68e:7b61:ae3e])
        by smtp.gmail.com with ESMTPSA id e4sm1325829ejm.116.2022.02.11.17.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 17:03:19 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <969a8728-ed17-821a-cbeb-38c0ed56e889@gmail.com>
Date:   Sat, 12 Feb 2022 02:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] libsepol/cil: Limit the amount of reporting for
 neverallow violations
Content-Language: en-US
To:     bauen1 <j2468h@googlemail.com>, James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20220114192002.730773-1-jwcart2@gmail.com>
 <dd96ca20-2f8f-ea6c-48b8-6649915fac1c@gmail.com>
 <CAP+JOzSeF50B5fYCLLKJpnGCXXWwxkEDEFU=61ZUY-TyLU7E+g@mail.gmail.com>
 <d6716dff-d46a-9a2f-3033-fe1bf0205681@gmail.com>
In-Reply-To: <d6716dff-d46a-9a2f-3033-fe1bf0205681@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On 1/19/22 14:04, bauen1 wrote:
> 
> On 1/18/22 16:48, James Carter wrote:
>> On Fri, Jan 14, 2022 at 2:44 PM bauen1 <j2468h@googlemail.com> wrote:
>>>
>>> Hi,
>>>
>>> as a heavy user of neverallow / neverallowx, please don't limit this.
>>>
>>> When adding a new neverallow rule there might quite a few types violating them, and having to rebuild the policy every 2 types would make fixing them incredibly annoying.
>>>
>>> If you want to limit this, then please make it opt-in or add it as a command line option.
>>>
>>
>> I am trying to limit error messages because oss-fuzz seems to be good
>> at creating policies that generate a lot of error messages and
>> subsequently take a lot of time to process.
>>
>> But I am not going to do that at the expense of people actually using secilc.
>>
>> I was already thinking about making the amount of error reporting
>> depending on the verbosity level. What would think of it limiting it
>> to two by default, but unlimited at any higher verbosity level. I can
>> even add a message to use "-v" to see all of the errors.
> 
> Thanks, something like that would be totally fine for me.
> 

I've also just noticed that typebounds will only print the first 2 violations.
So if you make this depend on the verbosity level you might want to change that too, just to be consistent.

-- 
bauen1
https://dn42.bauen1.xyz/
