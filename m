Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C8C6FA89
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIOOzB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIOOy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 10:54:58 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF345018D;
        Thu, 15 Sep 2022 07:54:56 -0700 (PDT)
Received: from [172.17.1.114] (unknown [193.120.40.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 574673F128;
        Thu, 15 Sep 2022 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663253693;
        bh=81NzM8N/F8DDJNH7+mZmKwLuSEF8xIuC+0pmVGXrHGg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JWRoNwSiQiVs7J93OTO2WAKzx5J0l3F/YbHSkMcbGZGNLaVqk9rPKkRYh68QbalOW
         XItgf0jWXg4mitJFXGX8CqBWVnZEH6U6pc5IyxaWZ6178SsEkw12ww0RU5ebTMsxqP
         VcEzUVvOU6hn1kaulTPGPMsc7hj5VfZj6MsbWstxpgevySKSUQdzIZTwC3Ki6WCgdu
         qlvt6F41x7hEN9patGYHW2G+22lufWoE2PT+j3mf9vgJlErVER/TfwNgEZR5J3YIqy
         7Sgp3YNzW0EjykwZr9vzCQtZL1Z8qiZSJPgjGWRc3MbLA17gdUgg8lnwsU4qZ59r7E
         sOu0Zy56iihrg==
Message-ID: <9175fe91-8b5c-6715-940d-dddfd1f42131@canonical.com>
Date:   Thu, 15 Sep 2022 07:54:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <7f9ffd77-a329-ab13-857b-f8e34b2bfc77@schaufler-ca.com>
 <c2a3279d-451d-23df-0911-e545d21492e6@I-love.SAKURA.ne.jp>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <c2a3279d-451d-23df-0911-e545d21492e6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/15/22 07:27, Tetsuo Handa wrote:
> On 2022/09/15 0:50, Casey Schaufler wrote:
>> On 9/14/2022 6:57 AM, Tetsuo Handa wrote:
>>> Please distinguish the difference between "enable" and "support" at
>>> https://bugzilla.redhat.com/show_bug.cgi?id=542986#c7 . (By the way,
>>> I hate the word "support", for nobody can share agreed definition.)
>>>
>>> "enable" is something like "available", "allow to exist".
>>>
>>> "support" is something like "guaranteed", "provide efforts for fixing bugs".
>>>
>>> However, in the Red Hat's world, "enable" == "support". The kernel config options
>>> enabled by Red Hat is supported by Red Hat, and the kernel config options Red Hat
>>> cannot support cannot be enabled by Red Hat.
>>
>> The "enable" == "support" model in consistent with the expectations of
>> paying customers.
> 
> Regarding CONFIG_MODULES=y,
> "Vendor-A enables module-A" == "Vendor-A provides support for module-A" and
> "Vendor-B enables module-B" == "Vendor-B provides support for module-B".
> 
> Regarding CONFIG_SECURITY=y (namely in the RH world),
> "Distributor-A enables LSM-A" == "Distributor-A provides support for LSM-A".
> However, "Distributor-A does not enable LSM-B" == "Some vendor is impossible to
> provide support for LSM-B".
> 
> "Distributor-A does not enable module-B" == "Distributor-A is not responsible for
> providing support for module-B" and "Vendor-B enables LSM-B" == "Vendor-B provides
> support for LSM-B" are what I expect.
> 
> Current LSM interface does not allow LSM-B to exist in Distributor-A's systems.
> The "enable" == "support" model should be allowed for LSM interface as well.
> What a strange asymmetry rule!
> 
> 
> 
>>> On the contrary, in the vanilla kernel's world, the in-tree version of TOMOYO
>>> cannot be built as a loadable module LSM. And it is impossible to built TOMOYO
>>> as a loadable module LSM (so that TOMOYO can be used without the "support" by
>>> Red Hat). As a result, users cannot try LSMs (either in-tree or out-of-tree)
>>> other than SELinux.
>>
>> That is correct. Redhat has chosen to support only SELinux. If you want
>> TOMOYO to be enabled in a distribution you need to sell the value to a
>> distributor (really, really hard) Or (not recommended) become one yourself.
> 
> What I'm asking is "allow non-SELinux to exist in RH systems".
> I'm not asking RH to "provide efforts for fixing non-SELinux".
> Being able to build in-tree version of TOMOYO via "make M=security/tomoyo"
> releases RH from the "enable" == "support" spell.
> 

I am sympathetic, I want this too. But RH choices are not a technical problem,
they could easily enable and not support other LSMs (eg. Ubuntu does). It is a
political problem and I don't see loadable LSMs changing this.
