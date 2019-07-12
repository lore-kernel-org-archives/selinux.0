Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DFC742D2
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9282064A
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rgWMtJQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGLTyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:54:08 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34213
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfGLTyI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 15:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562961246; bh=vq0j61i1qiTZODuNokOLxkkp5zfkZAZVcE8peQeardw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rgWMtJQOkRnVteFBlHUoyxhgX3a5qCILSeaQSVKz5n4G8MV2khKj+pc3QmWtN2L7A/j7BajhW6tDBXXQyoh9hUHw//wJpu8AAYLoKVNnSsCifmPonbjqSKIxuEzPbxud+0CbIDiyzsgmU7agEz4dclQ8+zTOCvB8MRL5E3+7r11nPHUU5SJPaP8cBMgnEY3428v5gccU+HqGM9ZD3l55NPLQJVALUjj4hGtcNIrwF6DP2JgHy/5unKxWfAQRzfvSEEbLqv92O1XxCmy+h0robXeA4k7wY3W8fzqsuXpTT15dZPBXx5Lp4Qk0xd86vOyyvrPN0r0RY7B4fYow2ZgEdg==
X-YMail-OSG: hHJiXPAVM1mvq9K.RhH3GA3ytEYaFBPNTslR.9AyoXmrjEP5aV7wF3lfwvULxJg
 glhLuCdv0OGFmrJbTf2XbcML2KTHs3EYbLDDf7VPbodGETIHsXAI5I7guR3alKqMkKqe4JGj0QWg
 7IWLOBbnAYoHLEafeasQr0tlA1H6IoiBkVh5ZtRtx5MyT8CqrKGgf1r48hOwa8FCEz4SBxw6325m
 bn9tnU94WBxxggyRuXeAYu2WCLW231HiA.qcwQBj018LcyDetsoa3a9su9_oR3MQ3cPCFDPAtM9F
 n1ykSndXg5RJWqThQLvcv202ESWEj0GNc9kacK6yv6qmBgiWF1..qEBSas_6MWybtbd6_YihgEan
 owU3AZK9esEXulJ6Sh6OzEHqNERPvMbRWGpqAI0DXpnbk1eUcSPCnmpG9bvltQKJjW6FiFgFpDEa
 WP4MY0kQQYyHi1x.8Zb1g3SWAJbtreRGg1YUlGHxbUl6t5IDsx8C440Thl_vJv8qgmoeVVwAcB7a
 BZtDJoPUZwuptA5poGhg44cSo3mVWvkJvRZJoJESbPU2KUsAkSPT_e_3BQ6vi5dUxEDwv3BJ9IV_
 bMhSdPWKSQDUTontWqHHcJLrmXORVQmfCPiMMEnjPTGhdVPM8us26M.OCEyr9O10N3Mz8l7bFKsu
 YMm9.veLHrBD3VM.GfxGUgcKXZpd3uJuQzGV1SHbM5E1Zf5aMI72QWuUglIaoNW35gWphh0FmmoK
 EPdjTykLJ1wce8FrWuhoJ2pUu0foJzR50zXwYpW4W2zTW6UM2.5m68zHSLkPNv4E9zDiac9Tr_Sp
 4a_hD.OhKsp.zOgeOk0LeMrUng0Zvi4A3OvuVdgA.mdzslOIO.4FsbayJmBiCHhCr.lF.wcgQKvT
 YElX72xJn0WeQlyOja8NwOm6EIF9SHBGNQ.b_mhQ.k7Yv7oXMDBag_svvEZ.WmOA7g0AM54tcS77
 mkizFarwNOkWwB4tDa1A_6EI_0Z8yNEZTpQoC_vFKVCOff.fophpPLdzbKZLItHHPBvtd3lhDGFG
 Gj1IWB4mT2AQBuUfFgFB2W_ZDzvDyQILFQKYCvyNRRR1ekBGq8Gvh3bQ0K9sGokubmKMe6oyOlJL
 0wsgIbhw7exZ_KVsUKrUDoauKNXZyFdFwOG3aSvjqSih2zDj5oMdr6j9uYUsgwMSsehP.VUkLHrF
 aIZd5t8knGFq6kXb41c8He7wwP0dvU3XXGqA9MP1fDBlm88bDbF_AzSTsiVcMY_H5O7rH26.SI4p
 0mf_lCGu2783NDo6ur55pLyvvTg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Jul 2019 19:54:06 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 71371a10b1b0e4e2a12b553078137898;
          Fri, 12 Jul 2019 19:54:03 +0000 (UTC)
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        serge@hallyn.com, john.johansen@canonical.com,
        mortonm@chromium.org, casey@schaufler-ca.com
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
Date:   Fri, 12 Jul 2019 12:54:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/2019 11:25 AM, Stephen Smalley wrote:
> On 7/12/19 1:58 PM, Casey Schaufler wrote:
>> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>>> At present security_capable does not pass any object information
>>> and therefore can neither audit the particular object nor take it
>>> into account. Augment the security_capable interface to support
>>> passing supplementary data. Use this facility initially to convey
>>> the inode for capability checks relevant to inodes. This only
>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>> relevant to inodes will be addressed in subsequent changes. In the
>>> future, this will be further extended to pass object information for
>>> other capability checks such as the target task for CAP_KILL.
>>
>> This seems wrong to me. The capability system has nothing to do
>> with objects. Passing object information through security_capable()
>> may be convenient, but isn't relevant to the purpose of the interface.=

>> It appears that there are very few places where the object information=

>> is actually useful.
>
> A fair number of capabilities are checked upon some attempted object ac=
cess (often right after comparing UIDs or other per-object state), and th=
e particular object can be very helpful in both audit and in access contr=
ol.=C2=A0 More below.

I'm not disagreeing with that. What I'm saying is that the capability
check interface is not the right place to pass that information. The
capability check has no use for the object information. I would much
rather see a security_pass_object_data() hook that gets called after
(or before) the security_capable() hook in the places where you want
the extra information.

>>> In SELinux this new information is leveraged here to include the inod=
e
>>> in the audit message. In the future, it could also be used to perform=

>>> a per inode capability checks.
>>
>> I suggest that you want a mechanism for adding the inode information
>> to the audit record instead.
>
> That is part of what we want, but not the entire picture.=C2=A0 But wit=
h respect to audit, the problem today is that one sees SELinux dac_read_s=
earch, dac_override, etc denials with no indication as to the particular =
file, which is unfortunate both from a security auditing perspective and =
from a policy development perspective.

I can see how that is a problem.

> The only option today to gain that information is by enabling system ca=
ll audit and setting at least one audit filter so that the audit framewor=
k will collect that information and include it in the audit records that =
are emitted upon syscall exit after any such AVC denial.=C2=A0 Unfortunat=
ely, that is all disabled by default on most systems due to its associate=
d performance overhead, and one doesn't even have the option of enabling =
it on some systems, e.g. Android devices.=C2=A0 And even when one can ena=
ble syscall audit, one must correlate the syscall audit record to the ass=
ociated AVC record to identify the object rather than having the informat=
ion directly included in the same record.

None of which gives any rationale for adding the information
to the capability check. Sure, it's in the right place, but there
is no object interaction with the capability call.

>> What would a "per inode" capability check be? Capability checks are
>> process checks, not object checks.
>
> Ideally it would be possible to scope dac_override and other capabiliti=
es to specific objects rather than having to allow it for all or none.

That would require a major overhaul of the capability scheme,
and you're going to get arguments from people like me about
whether or not that would be ideal. Besides, isn't that what
SELinux is all about, providing that sort of privilege granularity?

> Just because a process needs to override DAC on one file or one set of =
files is not a reason to allow it to do so on every file it can access at=
 all.

That's an argument for privilege bracketing within the process.
Not something I recommend (the oft referenced sendmail problems
being but one example) but the only way to do it properly without
delving into path based controls.

> If we want to apply least privilege, then this is a desirable facility.=


The capability mechanism is object agnostic by design.

> I understand that doesn't mesh with Smack's mental modelbut it would pr=
obably be useful to both SELinux and AppArmor, among others.

I'm perfectly happy to have the information transmitted.
I think a separate interface for doing so is appropriate.


