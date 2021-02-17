Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF8C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556DF64DFF
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 16:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhBQQa0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhBQQa0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 11:30:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E50C061574
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 08:29:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w4so2602519wmi.4
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTWpgH98pgrxv9NqW7J+6GrnRnbfNi6aMlWwqDg2nzc=;
        b=Y19Z5WMQbLokx6qnHHDpF2wpU/QJEUbkm9nD1TXs6sEnJ9BQu8vcjqI/fUMsvK3XeQ
         BvoNJbD0n1d1KimlnYzLaLkqH2GXixzeL0cnMUdCKHwdXoZVaKNCDyOJe3w5LHLAZS75
         oGman5V5hS+fHrM7+qCvtrQC3GtWyLIavuWyQTGaqpfFu4H8KknRX5SFJveBPwmmbGZz
         PZob1Pp5D1dOJkm+1MN7wumbeTwbl3VvvWIBkFSMrTOt5+W6p4UDtBnpI4msbwOMg69m
         b55+LPiotwbxAZ4uUW6QuAjkV4x70l+l9EcrZ5xjADlaANiQnygpxk6BMQoIfjWCbSka
         kS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTWpgH98pgrxv9NqW7J+6GrnRnbfNi6aMlWwqDg2nzc=;
        b=Dv6DjfVqskf23E1gfrLUbBk+tm6nRBVobUXOyryy1hWtOfHYvv8xB1+VSWUhjAT/82
         s3kgAK6HsnsaJRFFzR4haxRjVFsobmOHXEixkhL26DlLXKShmK5+ihS8TgN/XwluXbqp
         gHI+j/IYJP4aiviWe2OXs8FEanXd9OIBsq3k0lQuDgDEfaa2AR5RDS+oaRF8F1Vol5o+
         3dM7QPY22SyJPvtKOJDxHHi5cLllqsTWi8LN+UHPxH4yDaYpW3HMhxZzF0xXmIENVaQz
         wDv/YbnsLXlp29/NMaYsHxVfcTtT5HHE925/hPiKQ7Lmu7bOItw1BPntWMK6LljTDKC2
         lowA==
X-Gm-Message-State: AOAM530IJTqONtKk1WBW8JC1HrK+W0flpxpsfFDHF0IDC488c1wt4yH/
        2YgZ1qhVxXahuTm6zxi3/0GoGf1Sjw0=
X-Google-Smtp-Source: ABdhPJwGxzRkM+Rd0qnxjtPJIXwNHvG0vW49kajD2xiAmVqT1m3u9BJI6jaA5gI0kZk50QtZN6i8Sw==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr7556985wmb.53.1613579384007;
        Wed, 17 Feb 2021 08:29:44 -0800 (PST)
Received: from ?IPv6:2001:a61:1143:1:6a3:b28d:bcc4:1981? ([2001:a61:1143:1:6a3:b28d:bcc4:1981])
        by smtp.gmail.com with ESMTPSA id f17sm4510122wrx.57.2021.02.17.08.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 08:29:43 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <65111b4f-23b9-6758-9cd6-d2f8429916fb@gmail.com>
 <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Subject: Re: [PATCH] policycoretuils: sestatus belongs to bin not sbin
Message-ID: <88e9a3a6-529e-9391-c472-95d621db5564@gmail.com>
Date:   Wed, 17 Feb 2021 17:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/16/21 10:31 PM, Nicolas Iooss wrote:
> On Sat, Feb 13, 2021 at 9:44 PM bauen1 <j2468h@googlemail.com> wrote:
>>
>> It is quite useful even to non-privileged users and doesn't require any
>> privileges to work, except for maybe -v.
>>
>> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
> 
> I agree with the reasoning, but changing the location of an existing
> tool has the potential to break software which depends on the precise
> location of sestatus (like
> https://github.com/openstack/cookbook-openstack-dashboard/blob/86127240974041b456086b5fff6f8f525c9cf555/spec/spec_helper.rb#L82
> and https://github.com/rapid7/metasploit-framework/blob/4a380771d3a18011af153e47e1d08a4a83feb452/lib/msf/core/post/linux/kernel.rb#L276
> and https://github.com/RedHatInsights/insights-core/blob/6fd58aeab11232a62ea97ba576220abca808c660/insights/specs/default.py#L815
> and ...).

While I personally believe those shouldn't have been hard-coded in the first place, that is a good argument.
Would it be acceptable, if a symlink is added to /usr/sbin/sestatus to link to /usr/bin/sestatus (or the other way) ?

> On the other hand, if you have a clear use-case of non-privileged
> users refusing to add /usr/sbin to their $PATH but willing to use
> sestatus, and that supporting this use-case seems more important than
> not breaking programs which rely on sestatus being in /usr/sbin, this
> patch will be acceptable. Do you know of such a use-case?

My use case is logging in as my normal user account and checking if SELinux is properly working.
I'm not sure _why_ I should have to add sbin to $PATH to access a tool that works properly for non-privileged users, not that I couldn't do that.

IIRC I did once (~2 years ago) have /sbin, /usr/sbin in $PATH, but then I end up with a lot of tools in tab-complete that I can't actually use (properly) and I don't like that.

> (By the way, there is a misspelling in the patch subject: you wrote
> "policycoretuils" instead of "policycoreutils")

Thanks, I'll fix that if necessary.

-- 
bauen1
https://dn42.bauen1.xyz/
