Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15318ECAAA1
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 00:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGAuu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Sep 2022 20:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIGAul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Sep 2022 20:50:41 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34779A78;
        Tue,  6 Sep 2022 17:50:39 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1D6A640977;
        Wed,  7 Sep 2022 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662511837;
        bh=wDg5eQyO0EVJiuTOe+8WDODJWHFdNWnd7uyyWVes5o0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pjrtdwN3YEFvSojW5JT7uDmtONmUJRsWTlSsi+MzLCObRe/9OwSI70NMNepE1wEfo
         KDqxreOzvmY6IV9dE27SDfGxdlugBQ5azwQg13BFuEJSDCXe8v5aVzkH5NUBUKisEL
         /a7hRtPlirXhHl/PFBjMz7RQyFzm1h0ms/TrwojoF2KPeXe25MMQjbiTXe27V0TmKo
         BHJJCHYpAF2Nm6YnetFIuFLy/1+x7IPKZR7tDV771UwTVPOpqec9HuTXwXaJtT5Jsu
         yV2SuEsVvAE7EmfXcqZM4UhdYKEpm/n9P9RAkOWBlcWFIIQpXTeBjt+72QWmqqC6os
         IUugTa/G31LEA==
Message-ID: <a1ad1791-2f1a-a005-b1d0-5f807c8fa727@canonical.com>
Date:   Tue, 6 Sep 2022 17:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <282b66ae-ac7c-533d-75dc-4973fe440fea@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <282b66ae-ac7c-533d-75dc-4973fe440fea@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/6/22 17:39, Casey Schaufler wrote:
> On 9/6/2022 5:10 PM, John Johansen wrote:
>> sorry I am wayyyy behind on this, so starting from here
>>
>> On 9/6/22 16:24, Paul Moore wrote:
>>> I can't currently in good conscience defend the kernel/userspace
>>> combined label interfaces as "good", especially when we have a very
>>> rare opportunity to do better.
>>>
>>
>> so I am going to grab and hold onto
>>>>> Further, I think we can add the new syscall API separately from the
>>>>> LSM stacking changes as they do have standalone value.
>>>>
>>
>> what I think Paul is saying is we can move the LSM stacking patches
>> forward by removing the combined label interface.
> 
> Do you mean /proc/self/attr/interface_lsm? /proc/.../attr/context?

/proc/.../attr/context is the combined label interface.

/proc/self/attr/interface_lsm is an interesting question. Its not
a combined label interface, instead it is a new interface that allows
controlling of which LSM the task get to see on the old
/proc/.../attr/* interface.

Loosing it would hurt (its a useful tool and is currently necessary
for the SElinux host + AppArmor in container use case) but I think
if that is cost to move forward dropping it at least for now would
be worth it.



>> They won't be as
>> useful but it would be a huge step forward, and the next step could
>> be the syscall API.
> 

