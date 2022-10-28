Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA60ECAAA1
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 10:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJ1KOU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJ1KOT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 06:14:19 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35051B8649;
        Fri, 28 Oct 2022 03:14:11 -0700 (PDT)
Received: from [172.20.1.180] (unknown [62.168.35.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E91F5422EB;
        Fri, 28 Oct 2022 10:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666952050;
        bh=QOVPGGl1Px8T1+mV9Kvd/BwJ9ofEBLRLHMNLh/7/g2M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IN3QDYXAbK6CtXyvxpSNa3C30NrqUeOZenksIIIUsuvZ30sW636gRG6eKGhHqmOYj
         yextF8kycHxvCCRGPIqX9GtWzlXKyC32kDfIVOaF9KsGrETSfRyJkKB5g86bkmzKgB
         JZmvxG/2ORc0TO+TTx7SdNsoWyx2a0NDXQLpoe8E2ECIcU4LkMH+UIdCT4NpdbdNcq
         o9oFs7rguNrA2aj28o34UEi7ObtllkvxSSQXQq1XxWSo2KtDbAxMfBMFPf2dkGNMaN
         Ey5w2Aa/O7j0iKyEncxSJLuSSRGEZyJbIFwWB3scyZ6+d/NXktXo0LDZSIiNJ1WqCe
         Jj9dgKJjbYQGg==
Message-ID: <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com>
Date:   Fri, 28 Oct 2022 03:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
 <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
 <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/26/22 03:19, Tetsuo Handa wrote:
> On 2022/10/26 7:41, Casey Schaufler wrote:
>>              You need a built-in LSM that loads and manages loadable
>> security modules.
> 
> That is no longer loadable LSM modules. A loadable LSM module must be capable of
> loading any code and using any interface that is allowed to loadable kernel modules
> using /sbin/insmod command. That is my understanding of what you have promised (and
> the reason I am allowing you to continue working on LSM stacking before I make
> CONFIG_SECURITY_TOMOYO=m).
> 

Tetsuo, think of it this way. LSM stacking is going to make it much easier for new
LSM modules because they won't automatically be excluded because one of the other
LSMs is needed.

The problem of loadable LSM modules is orthogonal, and Casey shouldn't need to
solve it in this patch series. That is further work to be taken up by another,
as Casey has clearly stated its work he is not interested in doing.

However the real problem you are trying to solve won't be solved by loadable LSM
modules, though they may help. Just having loadable LSMs modules won't mean a
distro will build an LSM as a loadable module instead of disabling it, nor does
it mean a distro will allow loading an out of tree LSM module. Even if the
upstream kernel doesn't provide an option to block loading them, distros will.

