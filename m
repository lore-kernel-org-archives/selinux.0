Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD695C43461
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E8F217BA
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Jh2I2gFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgINStM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINStH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 14:49:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB593C06174A
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 11:49:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so9463908wme.0
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ym5wqRvdEnbB/9WjZweVL8bbVbicrEXNW3msbfYURYo=;
        b=Jh2I2gFtzhsiBpLW2d/GE/yDVLY/NFxEETlTfXHIG2e/i/uwnPnMBlfUAOYqRRnpl0
         ifqH71TihyU6lvwQCgdE+7Km+/o7kOE+hcr7nmP84fqZ5XCrfY6GETBifBI0lSME550O
         WcfdMgHMA74ohgzgmRTY5Nl12WYLKjPNPXRZKkHLCmjVqhTWJrkWjvEpF34yMYe9PBrU
         QLWmSMgik+PhkYz+Q3aPZhOG/9t8JZ5IzMtziHoCKbkFRsAX95ZJYxvQHHwvesZaxSDr
         ziXItSkDpw41lg6jo9i0DDVI9I70dInyy6/EqEqDEEDEqdDsmzNAJ9hYCMRiGtdZwFfH
         krdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ym5wqRvdEnbB/9WjZweVL8bbVbicrEXNW3msbfYURYo=;
        b=Z7s7ur1NVhs92RJgch7Q4Ey0FaZmpmqBMCORnfXEn3r3WcWKwayo5C/tRo9pBICIJI
         jJ7xG6CmppGYyAqx/5fwj98Aml3TshxRyZH5JXvYpF4RP/de2eqtTI9BtqiFvS2mUVjl
         rRb0HZEyMvp1fxUWtMQZ8K06yP632Gmp5njnoE+F+Fy52pAFrxcSmr63FL1RhkBT+ZSe
         +bWFbonKmKptmsDJKCwTBFuKLspmGmefCo9aJJ9LBISJ0ZD8eKW2fAWoQlgn3nOPrWcE
         q+CRr9CrRsfk42bKxrRYEIvZcgyRgp4PHjrrcozJdYnHVhpEO7eWjTPp348YmWKmxweP
         2yQA==
X-Gm-Message-State: AOAM5324DukRer+2JQ2Vo6nHO35RSt2gkW5CpGRhBzb2MmKisZulmmyn
        ysIndyUHOT5ZwYRhpasbzx4=
X-Google-Smtp-Source: ABdhPJxNuofGL4ay952+Jp+pLjMoKVMfmUjcC8K5VTPxBlj9fTK6i6N7kHibC95jpyw1p0XoTTiL8Q==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr736464wmk.165.1600109345457;
        Mon, 14 Sep 2020 11:49:05 -0700 (PDT)
Received: from [192.168.178.63] (ipb21bc161.dynamic.kabel-deutschland.de. [178.27.193.97])
        by smtp.gmail.com with ESMTPSA id y207sm21805233wmc.17.2020.09.14.11.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 11:49:04 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
References: <6a791504-7728-3026-17ee-c22cbff8c3d1@gmail.com>
 <d4e55b23-41da-902d-8b6d-83c9c47e7618@gmail.com>
 <CAEjxPJ5FXkArFZgC2Ps56Q_odPGfM5=O79puG3PEtuuYxKxU+A@mail.gmail.com>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Subject: Re: [RFC PATCH] selinux: allow dontauditx rules to take effect
 without allowx
Message-ID: <d3f8d0d8-1878-1dbb-3454-ba9a0a48ccbe@gmail.com>
Date:   Mon, 14 Sep 2020 20:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5FXkArFZgC2Ps56Q_odPGfM5=O79puG3PEtuuYxKxU+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/14/20 7:51 PM, Stephen Smalley wrote:
> On Sat, Sep 12, 2020 at 3:54 PM bauen1 <j2468h@googlemail.com> wrote:
>>
>> This allows for dontauditing very specific ioctls e.g. TCGETS without
>> dontauditing every ioctl or granting additional permissions.
>>
>> Now either an allowx, dontauditx or auditallowx rules enables checking
>> for extended permissions.
>>
>> Dontaudit rules take precedence over dontauditx rules and auditallowx
>> rules take precedence over auditallow rules.
> 
> I'm not following why you are providing different precedence for
> dontauditx vs auditallowx.

I selected this because I thought it is the most useful.
I think my original take was that with dontaudit you want to be broad if necessary, but with auditallowx you want to be specific. But now I'm not sure if the precedence of auditallow in the RFC is actually good.
At least the precedence of dontaudit/dontauditx is good because it doesn't change the behavior of dontaudit in any (unexpected) way.
I will probably change it in a v2.

> Regardless, since this changes the semantics of such rules I'll need
> confirmation from Android that they want this change in behavior since
> they are the original developers of the ioctl whitelisting support and
> its primary users to date.

I've copied Jeff Vander Stoep since he submitted the original patch, I don't know anyone else involved with this but I see you also added Nick Kralevich.

> We may also need to make the change
> conditional on a policy capability if backward compatibility is an
> issue.  However, I suspect no one has been relying on the current
> behavior for dontauditx and auditallowx.
> 

This would break any policy that relies on the old behavior that dontauditx/auditallowx don't enable extended permission checks. If a policy does require this behavior it will grant less access.
But at the same time I have yet to find any policy other than seandroid that actually utilizes extended permissions and even it only has 2 dontauditxperm statements (at least that is what a grep of a recent checkout found).

-- 
bauen1
https://dn42.bauen1.xyz/
