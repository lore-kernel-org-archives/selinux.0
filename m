Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F73C38A02
	for <selinux@archiver.kernel.org>; Sun, 30 Oct 2022 07:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ3HXL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3HXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Oct 2022 03:23:10 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9F23B;
        Sun, 30 Oct 2022 00:23:08 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A59AF42305;
        Sun, 30 Oct 2022 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667114586;
        bh=fWiynvHW2/C4gBbh4jcwj+16jBNZF3SuLMTYnurby7I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ouu4OORScds5NBF7WexjwsTY5nTHDWCoC+5LFXdsjKf8o4MkwqPcMbNMDspiRYNUk
         bV1aCpWS1+BGGiPRQ2bNhw88nhernZKH6xtOwh0e0i6L8lJbErZvwNR3YYaU0DgJvM
         lFtZFQu/6o/NONPHZCmWKC/e61Mfm8HDpSHiJhvyyJkR4lLbU9BPibskn5cmNiRsAZ
         fTBV02KAEE1dMD1DuJPw4xfqJ2JwflgKkocVfjwvXoOZWVAsKOe3H9MP/qYpxmUErG
         l7LwRXdkiHsIP3epZuvITBzKPpPTkDAj7nHlbEQDxQACmQfARcK4yd9FDY4wYOzjFe
         XuXDRDS7FSWRQ==
Message-ID: <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com>
Date:   Sun, 30 Oct 2022 00:23:06 -0700
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
 <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com>
 <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/29/22 21:03, Tetsuo Handa wrote:
> On 2022/10/28 19:14, John Johansen wrote:
>> On 10/26/22 03:19, Tetsuo Handa wrote:
>>> On 2022/10/26 7:41, Casey Schaufler wrote:
>>>>               You need a built-in LSM that loads and manages loadable
>>>> security modules.
>>>
>>> That is no longer loadable LSM modules. A loadable LSM module must be capable of
>>> loading any code and using any interface that is allowed to loadable kernel modules
>>> using /sbin/insmod command. That is my understanding of what you have promised (and
>>> the reason I am allowing you to continue working on LSM stacking before I make
>>> CONFIG_SECURITY_TOMOYO=m).
>>>
>>
>> Tetsuo, think of it this way. LSM stacking is going to make it much easier for new
>> LSM modules because they won't automatically be excluded because one of the other
>> LSMs is needed.
>>
>> The problem of loadable LSM modules is orthogonal, and Casey shouldn't need to
>> solve it in this patch series. That is further work to be taken up by another,
>> as Casey has clearly stated its work he is not interested in doing.
>>
>> However the real problem you are trying to solve won't be solved by loadable LSM
>> modules, though they may help. Just having loadable LSMs modules won't mean a
>> distro will build an LSM as a loadable module instead of disabling it, nor does
>> it mean a distro will allow loading an out of tree LSM module. Even if the
>> upstream kernel doesn't provide an option to block loading them, distros will.
>>
> 
> What do you think the background of
> 
>    Ultimately the challenge is getting userspace developers to accept a
>    change that is not part of the upstream Linux Kernel and thus not
>    guaranteed under the usual "don't break userspace" kernel API promise.
> 
> is? I consider that the reason is because
> 
>    We do care about userspace programs and users who are using userspace programs.
> 
> . If we don't care about userspace and users, we would not mind breaking APIs.

Like it or not kernel developers draw a very distinct line between userspace APIs
and what is considered kernel code.

> This reasoning is more stronger than "we don't care about out-of-tree code"
> reasoning.
> 
Look many developers really just don't care about out of tree code, and others
well I won't say they don't care but its impossible task to monitor and think
about how the broad swath of different out of tree code bits could be affected
by kernel changes. So the only practical thing to do is make changes based on
what is in tree and let out of tree projects deal with making the adjustments
needed to adapt to the changing kernel.

This comes about because the kernel does NOT provide a stable ABI for out of
tree code. This is not a technical position as other projects do provide
stable ABIs for out of tree code, with varying degrees of success.

It is a community/political position that is certainly informed by technical
merits but also other considerations, like GPL, experience on the costs of
maintaining stable ABIs and a desire to where possible push for code inclusion
in the kernel.


> Distributors have rights to block loading loadable kernel modules which are
> not included in upstream kernels. But for example Red Hat is not excising
> the rights to block loading loadable kernel modules (e.g.
> https://access.redhat.com/solutions/1376133 ). What do you think about the
> reasons of not blocking loading loadable kernel modules which are not included
> in upstream kernels? I consider that the reason is because
> 
>    Allowing loadable kernel modules which cannot be supported by distributors
>    to exist and to be loaded into distributor kernels is more beneficial for
>    users.
> 

For some users yes. I am not saying a distro will want to block it for everyone
one every kernel just that they need the option. Ubuntu has taken the position
to try to be as inclusive as possible on the base distro kernels but even with
that position we have special kernels that take a very different approach.

> That is, we have been allowing out-of-tree kernel code to exist because
> out-of-tree kernel code can be beneficial for users despite distributors cannot
> afford supporting out-of-tree kernel code.
> 

yes, no argument

> If you really think that we have the rights to lock out out-of-tree kernel code
> and/or disable loading of out-of-tree kernel code via /sbin/insmod, firstly achieve
> 
>    (1) Disallow loading of non-GPL kernel modules. (It is a trivial change.)
> 
I have no desire to get involved the that debate :)

>    (2) Disallow loading of out-of-tree kernel code via /sbin/insmod .

Depending on the kernel we do it either by disabling the loading of modules or
via requiring modules to be signed. We have kernels that do this.


>        (I don't know how we can technically enforce such change. Unlike not assigning
>        LSM id value to LSM modules, we need to somehow be able to check whether an
>        arbitrary file is in-tree (e.g. forbid "git add some_file") and unmodified
>        (e.g. forbid "patch -p1 < some_patch").
> 

Just because LSM ids are currently statically assigned doesn't mean that has to
be the case for all LSMs. I don't see a technical reason why an interface to
request and assign dynamic IDs can't be added in the future.


> before you enforce requiring an LSM id value in order to register an LSM module.
> I don't accept "I'm not interested in making such changes". It is your duty to
> achieve if you use "we don't care about out-of-tree code" as a rationale for
> requiring an LSM id value in order to register an LSM module.
> 

As I said before, not a technical problem but a social/political one. I am
sympathetic. I do care about out of tree code, I do see benefit to it, but I also
understand the kernel community not wanting to have to try and make decisions
about kernel code based on it.

The LSM id is far from the only problem out of tree code has to deal with. It has
to deal with changing structures, functions parameters, hooks, functions going
away, changes to locking semantics (rt kernel changes). For out of tree code to
be built against multiple kernels it has to already deal with all of this.
I don't see the LSM id as that different of a barrier and there are certainly
potential paths forward like adding the ability to request an id.

> Nowadays, many software is developed using programming languages which can generate code
> for multiple operating systems. That is, people are getting indifferent with operating
> systems they run their software. Then, what is an advantage of choosing Linux as operating
> systems for running their software, if Linux kernel does not provide freedom for
> customization depending on user's needs?
> 

Uhhmmm wow. They can customize Linux to their hearts content, the code is available.
Beyond that Linux has never offered a stable ABI for modules. Only modules built
with the kernel. Yes you can build modules out of tree, but then the module has
to adapt to kernel changes. The LSM id is far from the only change out of tree
code will have to deal with.

> As web application developers increases, developers who can understand C language (and
> system call) are decreasing. As a result, it is getting more and more difficult to let them
> understand and manage fine-grained allowlisting-based access controls like SELinux. Then,
> what is an advantage of choosing Linux as operating systems for running their software, if
> LSM does not provide freedom for using whatever simpler LSM modules users want?
> 
Linux does allow this, its just not as easy as it could be, and it is not what
you want. And if this is what those application developers need then maybe Linux
is not the right platform for them.

Like it or not, not exporting the security_hook_heads was not a technical
decision. I am not opposed to

   EXPORT_SYMBOL_GPL(security_hook_heads)

but others are and I don't know how to change that.

> Windows operating system provides WSL (Windows Subsystem for Linux) which allows running
> CUI programs and servers which are designed for Linux. Windows users can run CUI programs
> and servers without requiring real Linux kernels and can run GUI programs via Windows
> kernels. Neither SELinux nor AppArmor is required for protecting programs/servers, for

Actually WSL2 is now preferred over WSL and it does use the Linux kernel.

> antivirus software for Windows will provide protection. Then, what is an advantage of using
> real Linux kernels, if we cannot allow Linux kernels to use whatever LSM modules users want?
> 

Sorry I don't see the argument. With that sad I will say the Window kernel
doesn't allow running arbitrary out of tree code. Modules must be signed and
the Kernel is closed source. So if you want something custom Linux is ahead
of the game there.

Would I like to see more LSM modules, yes. That is part of why I want stacking
to land. We have been faffing around on its details for 10+ years, and I
think we likely would have seen more modules by now if it had landed. I
also think having it landed would allow for people to propose patches to
extend and improve it instead of arguing about it.

> I believe that it is time to get out of "we don't care about out-of-tree code".

Unless Linux is willing to offer a stable ABIs to out of tree code this is
impossible. Developers just can't consider all the out of tree code when they
are making code changes. And I don't see Linux being willing to offer a
stable ABI to out of tree modules.

> The "we don't care about out-of-tree code" reasoning is a brain freeze that leads to
> forget about users who still continue using Linux as platform for running their software.
> 

I get what you are saying. But again this isn't a technical problem and
I don't have a solution. What we need right now is constructive review
and preferably code to move patches forward so we can get stacking landed.

