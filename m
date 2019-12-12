Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD22C2D0C9
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B398E2253D
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HcSYgbRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfLLS2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:28:49 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44086
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730386AbfLLS2t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 13:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576175327; bh=3t9DZx24z3CXAi8VUdGEzPN7OFMR6NbknufutwlXcRU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HcSYgbRKyPWidsn1FMzdBfkJuUR9QlsYMpLAxDF+9JTr+CG86eCzfED7h2TIhPABK5V9uZwTzjrZ7XfPeKID9gz/ebO6WeCNMyS6sTULq+bCUTw+pSwdcfoERcJjNsOXlCUktqsQaeiev5QjpOjE2o4zXkQbrsZU3BQs4M/BEW/wiOVsyMvlIalUtDEzMZGqLL9Q78u5cr12u8Oy1miLzQPIza0Vj3jc7+7AWwMejUmLwDsvfUFWoRpcwzPAqmZWbQhdug/wy9DFrL48RzBtc8bjXCGvWH8I7kgsEzcj+PYLm9zWpqLau6BfbVTpnwbBYTx+9CkqDVDYjLW/X/eXdQ==
X-YMail-OSG: _WKRBoQVM1l5it4R4nJrYPm4KW3npQW6K647fC8LsjUFc8fmoixzHxY4B2QUunh
 yxHRIdhCmC9ucjMMuXmigKbXFtavpS4g2dwIH4.l4MVGXU_gssxU3EMzfAEW9QXU67sFZKWYEQzK
 VmlQCuaYllVtfC8xmjs4R1bZ25VLrcENZ3buXgTz3kWUIZxVrvVrMpaqoPtMsCX2TvcdYJNNTGtt
 WvMWqe7T92jhPAQoHVfANvxdc.6MVSzTKmssMvOxPRGAzoLWBTt6pe9y2G.wdV_1FSl_QbDRfhTF
 5n0DcdwDlXhnx7pNdowqvOBs3wgwiSaD7Pea3m6M8U4nR0O9WiiWUr734YjpL8zsFWDowNTiRRBz
 D6O1BH.fjCzJdQ8HmhLBxs4E.e9qYyzhJ7QC3xc20omoXDE9zB2Df9UUUcLBrNIrUp_W8_d_aVMc
 wDEK_TpU0YO7.eO8.iO8BeZkDCnz5FblsTqpY_u3nqsnk0mbjdrA33SnAOoysR5mnDP2zgWqT0iW
 r.GGnSelbI3lgRJuRNLopbHbuYZRQvwq_6Q8qGyWO47KfEzIHXz1hgb7ILbmjeYcLsS_o72KKj1T
 sqSmiYBzbLSiJ8.gwf_KqClkS_u4xg90NtmdWTghx9yuk9QwPc34a0i5M09ZrII2ZiqiPwmISdN8
 08TAwQbjLtJojjYwqZvXeJagtCbzHa9bvrWQQhexvpNPeviq.YmpWVheHWWy6F4z.Ad2INtPuGA9
 Ro2B4TNCjSdIfVQcNLFYkJHZhzwjnjJiiRo6IudtN7GwJ9BZvBPhXKEB8VEcN1uwQwBneMx5UJrU
 3wOpHwLBrFcsDAh4nGcjK5c.Tcujskm.PhPEe.nwNMTSDMQQ4dVriTKagCmZf2hZPyHTHMy29ncA
 .dI2uNn8Q.NI.y0NEcW1hzJ7kGm7BJZOrzrneaUnErNJDRUMTLK6rRZTXEjk1h6l3y3vbhkWLy.2
 Srwq.NS85IiRwlKq6iBh5hyW5Mb1Lqcd7D1BiK0zbQiKPUauLxxfspWnzk84nzytHUbKDKI09Amd
 00QpjiWuy3vmUBeQuOugye8wJOGzjNqSNzvoaxhnlgPFzbcjFikJHaCWif55pBdtRXq1BeShQi6W
 TYC4oYblGOJU26p4vCOpztHw8p5qesdIrk0AoFBEjvPTE11OPr9F9JDFllA3bvXgOKytxtCI9Yb3
 e12qcwrT0UkajBmLlvbfs2kf.V40vAD0lTwHK7068pbo8GzTUbiH7CNdQTsL_rKD_U_SeyFAmW5S
 sWmIY8HVCxU6Wf688EMXzNRkuplaP8EmjVXPdaQ08gij05x6o7nJIzHTsUASmDfAIonzytV223W1
 RHA8Ajc9wD7HUgQKr.P383ohgykT3Od6zJuCMa71Dd6ZakOzh8UJ96P.TtCATQ10O7KvoOg1i3RI
 Zk8ceD9iRhZdtbj_xNXrMOJvMlvl7ygoq6h96WQbXN6GPnQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Dec 2019 18:28:47 +0000
Received: by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 709ae9512669f06d48013f3f3108e48e;
          Thu, 12 Dec 2019 18:28:42 +0000 (UTC)
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook>
 <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
 <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
 <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
 <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a5112f83-7080-a267-277c-1b4c8f9ea06a@schaufler-ca.com>
Date:   Thu, 12 Dec 2019 10:28:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/2019 10:11 AM, Stephen Smalley wrote:
> On 12/12/19 1:09 PM, Paul Moore wrote:
>> On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 12/12/19 12:54 PM, Paul Moore wrote:
>>>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>>
>>>> ...
>>>>
>>>>>>> selinux_state.initialized reflects whether a policy has
>>>>>>> been loaded.  With a few exceptions in certain hook functions, it is
>>>>>>> only checked by the security server service functions
>>>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
>>>>>>> there is a lot of SELinux processing that would still occur in that
>>>>>>> situation unless we added if (!selinux_state.initialized) return 0;
>>>>>>> checks to all the hook functions, which would create the same exposure
>>>>>>> and would further break the SELinux-enabled case (we need to perform
>>>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
>>>>>>> tasks and objects require delayed security initialization when policy
>>>>>>> load finally occurs).
>>>>>>
>>>>>> I think what Casey was suggesting is to add another flag that would
>>>>>> switch from "no policy loaded, but we expect it to be loaded
>>>>>> eventually" to "no policy loaded and we don't expect/allow it to be
>>>>>> loaded any more", which is essentially equivalent to checking
>>>>>> selinux_enabled in each hook, which you had already brought up.
>>>>>
>>>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
>>>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
>>>>> might be the best option until it can be removed altogether; avoids
>>>>> impacting the LSM framework or any other security module, preserves the
>>>>> existing functionality, fairly low overhead on the SELinux-disabled case.
>>>>
>>>> Just so I'm understanding this thread correctly, the above change
>>>> (adding enabled checks to each SELinux hook implementation) is only
>>>> until Fedora can figure out a way to deprecate and remove the runtime
>>>> disable?
>>>
>>> That's my understanding.  In the interim, Android kernels should already
>>> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
>>> choose to disable it as long as they don't care about supporting SELinux
>>> runtime disable.
>>
>> Okay, I just wanted to make sure I wasn't missing something.
>> Honestly, I'd rather Fedora just go ahead and do whatever it is they
>> need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
>> they have a plan and are working on it), I'm not overly excited about
>> temporarily cluttering up the code with additional "enabled" checks
>> when the status quo works, even if it is less than ideal.
>
> The status quo is producing kernel crashes, courtesy of LSM stacking changes...

... that went in 4+ years ago and are just now showing problems.
Either something's changed or no one has really cared in the interim.

