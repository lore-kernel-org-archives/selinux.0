Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A174C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0458722522
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kVSgV8hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgA0RQ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:16:57 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:39810
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgA0RQ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 12:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580145415; bh=0fViQReKy+gFlmgn9ij5P4aUkBWO2S6xe3/RWlH4sP4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kVSgV8hrjdV+B5ORUx8iNgZ0zx1j+PLe5fdUyew3ACONDAi6imuRD0ltiN4tF248aJeRkm3G1soJNvqJeyLnf1JbxvY3Nzyd9Z+DqzUQ6iCJ+iYyfRZUUkQK39Fe40aGsNUlmfSuQ5CxREuOwLH4rgYg0yN6JEkmRXDvyMQz9LdEiUVXw8ISgQLcGC4EYeoc+zb3bEuO8OFlExeATqPFvlJ7NtshJZhGppF75sUyfABx8hpbBLFouUMI40wtUBbJ3q+XVcLjnVi6Ys9aQKXgwe2X7SYBZmSVoJRcOcmUJY6aruIzzx9U9cfVdmOQn3wsq3EEaXFSw5LlWAjl9YlP6w==
X-YMail-OSG: 08dyS_cVM1lxW7J_zFDsIs9d10Goy.Wvd6pAF9NqL_7mJij3lKclBRi3QPKNFaY
 4fDxOqJgtEOjTP2vPXMPtyL.s1iRst.H9798vqS5_O17.yAG9ib4Rb8jGZi4B0dMaHG4TuAjiNft
 87nMZBJ.DGs3d8LpsTwiyiZWwLjMjNT8jRkbfZhQ2tcsytAKTfRwIM6q3DIoAv3VjB.7_dA7B7f3
 Wqfaq1S19HDS61WGjsnn34DLa7dqOib7zO4uR1DkQYDo4Sr35VKnkBqq2gMZ.8K7wRAXqc1mH4J8
 SG8jSJGYY_Qdl9o2AobqunuE9sMdOyf4I_.zoWBhjOLn4TWz1TxlaIT6QbziDu7HmG3.rcltq0RS
 2lvLnhXCucYudX0IZPbjsREwkLVLw9Xw56KcONLlJkYjc6FFF1pjhI2gk6I8s2wikg86Uxz1VW_u
 wroguNKWWiA_LGkr1uT_uwVEQ3WefCNnbpjzNkJXxlC_tP_tTqQ_Guwhya_4CMmUPhBOLKCzw9eJ
 jEmazR4leQjuNS2mIBrQdcDwI4bHGbq76aRZHzRGcaSeYr2NlKq0gDMFBkQOl_7mtoJdob.8oPTg
 zFJ6O87FWW6UJYN3fKk4U05glJX2jLV.e_Us3liumAR3.Xp6JVF4Nwdb_0WD1lXIbr7du5ayHY_3
 e4DiKQN..knq14slgNjKvhofiD.84McVpShScEFcJzj63vZr4fk2_Xc876ScZqDPIhBNHUiuhlsQ
 mAQHxdeFkIZqFusWI7XijCcHVCIk4eHkgehJHLLXBcbIEQ5g5I8pRyoAognDbm2ek7wUEuAAets4
 Z3XXw94ScxZ_3IWHp7T1X69R0wi2CgnoYuTvohklnolQx14Bp3w98KvtZ5MpJBJdDz1b_YTqWi1O
 xnyqTeRX5IjQJCqOGN4.58RFMt.ogDcxqg7rWzJWoNPBMXGcvBhHK0n62QFcXDQsSwyxLRrgz4jP
 ytRqmTwq3aNlehLOM9RfJiRXDSwJ96GF31vK1oUSrkAG9yzjrczRzJbKwkEYfcz5nYhhV8lusG7C
 z67.89o7gKmJ_kqmAzPrmcj.KbHMpmq3UQ6EphNqVniAxJ4TcMYsxzT9bkk_SiK.foSfepY.Vp.W
 oVu30FAeAq9Q18SYV0..xv0WdpaihjQjmS3aZbnuBF4tHXVF9rsR_lRanlJRtzaX_E9hlEa0oV_G
 jKE8F2wXa2mEUMxoXyc.xMeYu1tQFFgDBHoncGNnymJCJfSAX3BmAry08Z.rOR17Lxl55zTJe35l
 lmpaFmE11vWvWnw010cTphG2MS_jGzijVa2n6LToMN9gXfXHA0jsu0yXP32kAhZ7KEgEycgEQQ3t
 ShyNj6vO7KVAPY7CFYFSySDTUncXMz8y9_90enyz.DSMABtRdLVoBMNbBpQPhVpzDyQHP16NE3HA
 hFMY4k3phDNGVs5y92wBjV3FyaFA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Jan 2020 17:16:55 +0000
Received: by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 913935b546cfccf16602707797098b0d;
          Mon, 27 Jan 2020 17:16:49 +0000 (UTC)
Subject: Re: [PATCH v14 00/23] LSM: Module stacking for AppArmor
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
 <20200124002306.3552-1-casey@schaufler-ca.com>
 <22585291-b7e0-5a22-6682-168611d902fa@tycho.nsa.gov>
 <6b717a13-3586-5854-0eee-617798f92d34@schaufler-ca.com>
 <de97dc66-7f5b-21f0-cf3d-a1485acbc1c9@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <24227f64-096c-1f26-1cca-2abf497593b3@schaufler-ca.com>
Date:   Mon, 27 Jan 2020 09:16:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <de97dc66-7f5b-21f0-cf3d-a1485acbc1c9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/2020 8:14 AM, Stephen Smalley wrote:
> On 1/24/20 4:49 PM, Casey Schaufler wrote:
>> On 1/24/2020 1:04 PM, Stephen Smalley wrote:
>>> On 1/23/20 7:22 PM, Casey Schaufler wrote:
>>>> This patchset provides the changes required for
>>>> the AppArmor security module to stack safely with any other.
>>>>
>>>> v14: Rebase to 5.5-rc5
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Incorporate feedback from v13
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Use an array of audit rules (=
patch 0002)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Significant change, removed A=
cks (patch 0002)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Remove unneeded include (patc=
h 0013)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Use context.len correctly (pa=
tch 0015)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Reorder code to be more sensi=
ble (patch 0016)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Drop SO_PEERCONTEXT as it's n=
ot needed yet (patch 0023)
>>>
>>> I don't know for sure if this is your bug, but it happens every time =
I boot with your patches applied and not at all on stock v5.5-rc5 so here=
 it is.=C2=A0 Will try to bisect as time permits but not until next week.=
 Trigger seems to be loading the tun driver.
>>
>> Thanks. I will have a look as well.
>
> Bisection led to the first patch in the series, "LSM: Infrastructure ma=
nagement of the sock security". Still not sure if the bug is in the patch=
 itself or just being surfaced by it.

It looks like the tun code is making a private socket in tun_chr_open()
without initializing the sk_security member. It's possible that this used=

to work implicitly, but I don't see how the change should have broken tha=
t.
Investigation continues.



