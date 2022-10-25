Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36639C38A2D
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 10:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiJYK2N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiJYK1w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 06:27:52 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66615F93B;
        Tue, 25 Oct 2022 03:26:20 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 22B144230C;
        Tue, 25 Oct 2022 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666693578;
        bh=3sCInTdft8yjEPkkTthN7v6dHtEH+P9/EcMebV5xMWg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SVsVFVCNwLBRTddXJB8eUl+fvgGyTynFDFRZPX46OC9fuKy5q5VwB7AZnfv55JtzS
         oDNNdwFRUVKskPRGQ8MSfkmAq6xG7dXmCkt3UgeBqvv4Tr3cyEcCHa0PU2DQupSuru
         Bfcm9zV24AhbB8mjlPWoVdbhBkJkKx7bJfEbMpzaQ9EatP+TMi+0AgiN1GS5hW1FyN
         YOsQ1yFnNvqVvL/OnzBPDpxitNdUwz/z2uTkYxcX6C+g3zEPotgqKpO8GwRjuElxwj
         yvG/izP/CW9tLmS4GtFmCXONnvx02Ha5IEjPQu0a90Qvfn/SWuF/gwE8V32v5lzKpG
         DwxYpQ0u4Tx6w==
Message-ID: <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
Date:   Tue, 25 Oct 2022 03:26:17 -0700
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
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
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
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/25/22 02:48, Tetsuo Handa wrote:
> On 2022/10/25 1:37, Casey Schaufler wrote:
>>>   What I'm insisting is that "warrant the freedom to load
>>> loadable LSM modules without recompiling the whole kernel".
>>
>> Since security modules are optional and the LSM infrastructure
>> itself is optional you can't ensure that any given kernel would
>> support a loadable security module.
> 
> Like I propose adding EXPORT_SYMBOL_GPL(security_hook_heads),
> I'm not taking about distributors who choose CONFIG_SECURITY=n.
> 
>>> Adding EXPORT_SYMBOL_GPL(security_hook_heads) is the only way that can "allow
>>> LSM modules which distributors cannot support to be legally loaded".
>>
>> I believe that I've identified an alternative. It isn't easy or cheap.
> 
> No. You are just handwaving/postponing the problem using something unknown
> that is not yet shown as a workable code. Anything that can be disabled via
> kernel config option cannot be an alternative.
> 
Uhmmm, loadable LSM modules if they ever happen will have a kernel config.
If not distros will carry a patch just like they have for unprivileged
user namespaces. Trying to force distros to allow out of tree code just
isn't going to work.

>    Quoting from https://lkml.kernel.org/r/2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp
>    > Like Paul Moore said
>    >
>    >   However, I will caution that it is becoming increasingly difficult for people
>    >   to find time to review potential new LSMs so it may a while to attract sufficient
>    >   comments and feedback.
>    >
>    > , being unable to legally use loadable LSMs deprives of chances to develop/try
>    > new LSMs, and makes LSM interface more and more unattractive. The consequence
>    > would be "The LSM interface is dead. We will give up implementing as LSMs."
> 
> The biggest problem is that quite few developers show interest in loadable LSM modules.
> How many developers responded to this topic? Once the ability to allow loadable LSM
> modules is technically lost, nobody shall be able to revive it. You will be happy with
> ignoring poor people.
> 
> You are already and completely trapped into "only in-tree and supported by distributors
> is correct" crap.
> 

no, Casey is not. He is trying to find a path forward to get LSM
stacking upstream sooner than later. He has made proposals that
admittedly you have not liked, but he has at least tried to propose
ideas that could work within the insane set of constraints.

>> Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
>> security modules. That's one of many reasons loadable modules are going to
>> have to be treated differently from built-in modules, if they're allowed
>> at all.
> 
> Then, I have to hate your idea of having fixed sized array.
> 
> Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 

