Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E95C54EE9
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 17:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIGRXl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIGRXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 13:23:40 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A4B0B2F;
        Wed,  7 Sep 2022 10:23:39 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DC0E33F1D5;
        Wed,  7 Sep 2022 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662571417;
        bh=Drsg09FXSwuquW2KA6ZZVoOFL/4wi6EDyR6M1i6FBco=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Bc8a2cBz67R4G75yW4uIKynqxSS1qrjR7Du/a9OZAJPBgrYvbAA4lcolPz4BDtDQH
         FTfUrOLav0NHdHQXfcFLL2ZqOTahIIwgwA6aD0f85PlwHaYzuzA87tmxHe+gbpGFV2
         8b9y1dZUhBDQwyvRPAlMtYtb3JlOXBKDS/in3a0mvj3hQO6vFxTAfV+i7LEp94MjXO
         n8NhnXGgj17A0gk5S32dXNbgbZyBgYZWZ//2qbH4D12heLZ6InhBnJ8cdf70k5x/7j
         F30iX3FQUqOUsBKPF8QObKbCSFZLD+zUZwddNT00tIh60uE8a0XN8NHW4jNsFKIo+L
         QpYvB06dx3xfQ==
Message-ID: <65d21148-6a6d-4c4c-aa39-fafc1740ce24@canonical.com>
Date:   Wed, 7 Sep 2022 10:23:33 -0700
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
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/22 09:41, Casey Schaufler wrote:
> On 9/7/2022 7:41 AM, Paul Moore wrote:
>> On Tue, Sep 6, 2022 at 8:10 PM John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 9/6/22 16:24, Paul Moore wrote:
>>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> ..
>>
>>>> If you are running AppArmor on the host system and SELinux in a
>>>> container you are likely going to have some *very* bizarre behavior as
>>>> the SELinux policy you load in the container will apply to the entire
>>>> system, including processes which started *before* the SELinux policy
>>>> was loaded.  While I understand the point you are trying to make, I
>>>> don't believe the example you chose is going to work without a lot of
>>>> other changes.
>>> correct but the reverse does work ...
>> Sure, that doesn't surprise me, but that isn't the example Casey brought up.
> 
> I said that I'm not sure how they go about doing Android on Ubuntu.
> I brought it up because I've seen it.
> 

LSM stacking for that use case is necessary but insufficient. At a minimum
SELinux would need bounding, and realistically some other gymnastics. I
don't hold out hope of it happening soon if ever. I have told the anbox people
such. At the momement anbox disables SELinux when run in a container

https://github.com/anbox/platform_system_core/commit/71907fc5e7833866be6ae3c120c602974edf8322

there has been work on using a VM instead so that they can have SELinux
but I am not current on how/when that is used.

Where Canonical is interested in LSM stacking is running snaps with apparmor
confinement on top of SELinux distros. I know snaps aren't popular but it is
a much more realistic and attainable use case for LSM stacking.

