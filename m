Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF4C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD8A20639
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2BFcTF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgHSOWH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgHSOWG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 10:22:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4369C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 07:22:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so21730558qkb.1
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4oNXmj9Xw/4uK48s/EC7K/r+d3Jnuh9ueAuf2ZmzAFI=;
        b=d2BFcTF01CMhp3m3oBTBgZ02t5MK2DQADxzPfTM4ZiqLKecl8gb5DF8Og2eGJtXIog
         z+iT+y6jtMWoq1qaEHK5rt+Soq81E8k6Mh3IvpH0kH8co0r4tbzdu1PlAjzEgncCNsth
         2XxFSJpJEl1LX0eiXRS/LdaDMdWP2gJtT942SQg3W0T0z674okrcYvuPtUR80wNls8ZC
         3ehabph3eyLCu3R2DyGRgX/ZrJEAau+AZHHEBzRTUYak+JTfxY4BHYC5kJf6WgvpUXDJ
         yg7avEzvdSRo+eIEiM5Q9o1rEIae57G7s2FkTtA2t2OotYaGAsmERSdBjF07j0iL84eg
         eL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4oNXmj9Xw/4uK48s/EC7K/r+d3Jnuh9ueAuf2ZmzAFI=;
        b=QUQIlvScwYW1Fcj/UFFx+rtJf6kMC0+2ySlfCC14Pth2Y2T1Wjcd8QKz2kQMxkB7pY
         OjnCYKfoBJT2p4iYwU4bmeJ9I/84u+CwhZ5rjy+ySNwZWt9zCo0dhW3W6RxN2wG9qfoN
         CF2fY8khYeg/x2o/j/DI/nq8uRmo9O+2zjT8ve5v48Q9wwOyiPnWfpGMUXig1lNqP/GW
         7JGSJpG6FC6ZJ1SL1KdpUEGNvMQP9KT4TY+JDWmtEFgELhAYAs6kvzvIopCCGhjsXxC7
         ptqrIl+e0fKO4n8juDHQJcgX9bX8ye9Y8wgJ52Mc6UMY6giQDzNAwCK0ru7HB2d0kZqt
         QQeA==
X-Gm-Message-State: AOAM5338n8Z30gM15s7Mt/rRdbJY5whZ5xbrc6JJ47FIMVGHzfqzOuk6
        kGnqB5TcK9MJiBJueAlj7Ak=
X-Google-Smtp-Source: ABdhPJzrpiY+Bb/Tu4m+gLfqYMnxx36lss8STUowoIIuz69r1ha2Olzp5YykS7gZWPmybVTuGTUTrQ==
X-Received: by 2002:a37:9fd0:: with SMTP id i199mr22415715qke.248.1597846925122;
        Wed, 19 Aug 2020 07:22:05 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id c5sm26433011qtp.62.2020.08.19.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 07:22:04 -0700 (PDT)
Subject: Re: [PATCH] selinux: avoid dereferencing the policy prior to
 initialization
To:     paul@paul-moore.com, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, naresh.kamboju@linaro.org
References: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <434538b9-8889-b765-70bb-3dbe5a3ac2e9@gmail.com>
Date:   Wed, 19 Aug 2020 10:22:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 9:45 AM, Stephen Smalley wrote:

> Certain SELinux security server functions (e.g. security_port_sid,
> called during bind) were not explicitly testing to see if SELinux
> has been initialized (i.e. initial policy loaded) and handling
> the no-policy-loaded case.  In the past this happened to work
> because the policydb was statically allocated and could always
> be accessed, but with the recent encapsulation of policy state
> and conversion to dynamic allocation, we can no longer access
> the policy state prior to initialization.  Add a test of
> !selinux_initialized(state) to all of the exported functions that
> were missing them and handle appropriately.
>
> Fixes: 461698026ffa ("selinux: encapsulate policy state, refactor policy load")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

To test this with no policy loaded, you can do the following on Fedora:

dnf remove selinux-policy-targeted

rm /etc/selinux/config

reboot

It is important to do it in that order; removing selinux-policy-targeted 
creates an /etc/selinux/config with SELINUX=disabled, which you must 
remove to keep SELinux enabled but with no policy. Also removing 
/etc/selinux/config is necessary to cause libselinux to report that 
SELinux is disabled to userspace, thereby avoiding all kinds of 
userspace breakage.


