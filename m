Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F994C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIHQAv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIHQAu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 12:00:50 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323EA00F7
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662652848; bh=XDCO5aPTCVBv9f1fuT1Jlx4Q06cByO5juQa9tKlRbMQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gD8s0VeutSBwswT9UCHPRkiCWPpNsoDgmpQ8++pzK9Nv7BK6P2X7rJwL2kaYDetBzodIeV9+5d1hWzPVpzrVCCYwxu+B8oAffRtGDydnFcIH5R8vop4SlrMbmTLscW+DossMfsBQb9iBeaIA4E5jOelFYK4RXwy/hSZmXFEBO4DdhcdwXsYvUYIKivIRPb1MlUM9zMuYDRqm4h9ufg6gH07Vrzx8uaNcqdsa/aKo21k44nFcK0PQ7vCjADPYcdGI6x0lNaml1ivYpDQ1HiuI63nuF39jtMirUlciIpDHJFS7HTT09apGXzYP6smiBag79YeAL/42dGKQrbVwE9TJxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662652848; bh=dmFOWfHM51Qbvc8GFDN4ZHjCSwHpKUS+kKqk2VuaIP2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VzJlZ8KyZ1f/EGfItpHwWN34l2+wAyLWhnMNksbHiW9IlEeyI9I+d4eaHCaBY+MeADl2GG/tuCgZjHdNZfIV954WAKKJAp2SYx001SLca6mjglPqlaXI3VAACF/uQBTBpMpKOApsxO0ihrFjJ0wwT2+bKg+wIhGhaHartcj+EE501oJskQ3nnOecw2poq7UE4BywaNnuQhTVWuQmxUiNrnuH30XCSsnXW+ViEZDmwENZPFdHIkR8vtUUrWocABb9WXe6x01qjbX/x6jbOxX77tcYe3Ncg8Jco25uLuZGbgYgJwkd3eOaKPWzo/ZA6xa6uHc1ZYOfwc2aceRCvL3fpg==
X-YMail-OSG: Gd58AMYVM1l1HjEQQRqbEghtn2yaDbKgMApKJa3TQ7FNbXtrntvrC95cTGYndHX
 d63Ow95W.dbqfbJkkwwSL_yMuuDn_2cb.SL_xxCx3wmnxBftg7FFYr3f8mJANKqK4qIFee1ZY.yX
 lkE9x7d_FuWLowC1qFn6FNElJfiejm.XT2yQB9VuLTFmBPgwQcd3n2tPelkIrZSbt1mvLTkHOwmg
 iY6ONGwEk3TAWbM3yO0KC65rIqXk4ssELoi3UF08cF8b_lzLZk10fEXonengJZJZUdV6UnQDhx2q
 gs6mIELB8apO9L8ZGztXNpL6GOOu.xVPTA6PL6RbNVZ1SyyWiYR7YGt9HbftnUG8oFoYIfOZIM75
 eBfFNukr1CyqIpCqupyHRon2PxVOxjsxME_LQOfs1G2VIjOZj5uv6c6JY.8jVuLozWJn4uIdhUUF
 wl2kgH_iSIHUgz9xAEs3gowyM1p5a9R9qs.aOGqPoSPnSE4Zljefv_k5uPFBMYQS_8Sf9IKfdMCd
 z6OsmE3Og8cfbSFe3pZaHkdS9Zitk4Gi_QRO0z4LdO2DyMbsQhOO58mth8AKm.kMoCSkdnvW8f2v
 KiU2odGFZEFi2zYmVnn.EaSZFiTvD.LO7NCjzeiwQVsy50WTuVddhOkd0dem5XJZqTXIJhpkDQWh
 XxbDLsV5Q6WKvddY_SEgFe.P29Z1YqMvy4wTJ9NL45PYDWe_QcFWjg9f5DMqcCyYlK8wI_eVk6_Q
 bxSYci_KWF7EUCxnV3lXPdSp54a0uWnv0w_1sIg5RFsl2zuAWjBiLP8P_BaVPNcK4GTJNJuLaa7n
 wHm_PhbIVU1yu8yIYYjonhYFiLCWLSmdQ.LDUlAKiw7Eg4KuxjfKxo9ZOFnV8gcQxJVrcqTj1XTO
 _l9QrZ7Lw4Lu807wxPPQFlJbm6jIvhU.BDit1ORsZo2Hp7vNUkag6RaNEZAtcYovaBtPGUGUoRKn
 DWXi0qpNJ6dxrL7Sp_lZXIEZ4Uvr0lNf8SdtuICEc4PYcGdxatp.qu_2rWfGgNxw3iikmXjlIiNk
 FzaFH2GF.pD17N9xeOM8ScSvtESqxztARjwmhAOob08n6.KLyS3LKN.VBC8FrY9ae675HzV8Bkr8
 gG7yLDVGcQQ2w8b7CMl_.kXzdlv7.zhD5pZWN9zXaXzg82LfoNVilLUUI.qmIJQlzEahEeCR7jPR
 pLrUDFf8OBdvCPLXyj01dyhQzYZQxYO76U8zKBUzu1SkoPWmBaVjogxZjhB63IYEP_y6ozavZKuG
 v554e0httEAEYaVhKcNhT1CrAtEsuDvA7oNk4Ubch.0A_NgR8hhyF.quPHILQssKz2OChLyqFgx2
 ndL2K63W2zJk41k3gSwGePSprTBygSF7VlZVNSccApZ_c5Pr3q7dgcKN8KkbbW659x8eVNIIStDj
 AHWTRW4_M9rPV9bLMx5eLY6F3dYYJLzD.8.ioQz85n4bSbUCrjhlY_oBt58O0r_WFvcwe2x6vscT
 SXjFnozrcGQEEpgIVQlT9.wpdMxdD_kQRrc1.0d97.wj.6E6LIth8F_ELKcsIP5BMtGtH3jpYWSk
 xfGDV7pYlN75Y_mVfYkc.5FqQc9T1D167SMlxAEDKePWW4mGDoSSzfkpUJnwQWOAhw0DV8mRFfgm
 ugyBgZeRUcBcYGkeOL.F3pB.OtVYsoShbj.qEXin7SQ5tiI5gafqUDOW1x8jlMwMs_nf7JvXzVF2
 gKQ4Q5_eiI2sz4UjImpq5TbORCPH0EFprnvwOrTAPZKM_qUExLRjLG6HU7oAHEKtCBhN4MUsKh_E
 HUoC_LEtxd50amYvLc3QjDyD2Efzx82n8g2PxqJ5a.FkrysWAmEORswc3YuGs0Hh8DUswY8EnSbS
 D1c7ESph.TaC2MsEuv7hpncQgUgAyGMVTJ6UiXhFsVS4GB0eqTFWIlZifQ0JbnsGuqCqLb3xuiTv
 sHFJP03qy44DevnpH_mi4KFYZnn11fq9XmSZdBnO2E9D6GSulAGvCGRm8th889QFWX6gc7..HU39
 6YIaX7DXewBFzG00gWKt81osnKOvdqKx6T.nCHWJR.1i212jleaeWTQUHEYmmh0wo.rhse6aov0I
 5ZUz4tfP10Gnw1C5d8icgnEfhQd3KzTCkCeN3UjtqgINmQuj5rZ8B1mOEZIwZ4adpoAyVpg6xxt.
 LUoDW4_D4K3R8BNje5_.RAPua8x7RB_zk7dZgXpIMXm7zxeEsr_U3jXZuJCCqRzhVjSu5gJRcpRL
 0KnQheLN4IabTAeBgsgqkf64KLWTPbmyIO6eT2M7D9IfHvwDP.I2Np40nWO8GwBYa
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Sep 2022 16:00:48 +0000
Received: by hermes--production-bf1-64b498bbdd-k67v5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 94c6992c183f1261feae5fcdbe418045;
          Thu, 08 Sep 2022 16:00:43 +0000 (UTC)
Message-ID: <998087b2-c17d-e536-66ff-a473fe6b799a@schaufler-ca.com>
Date:   Thu, 8 Sep 2022 09:00:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/8/2022 8:18 AM, Tetsuo Handa wrote:
> On 2022/08/03 9:01, Casey Schaufler wrote:
>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>> patch set in the LSM next branch for 6.1. The audit changes have polished
>> up nicely and I believe that all comments on the integrity code have been
>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>> There are serious binder changes, but I think they address issues beyond
>> the needs of stacking. Changes outside these areas are pretty well limited
>> to LSM interface improvements.
>>
> After ((SELinux xor Smack) and AppArmor) is made possible in next for 6.1, what
> comes next? Are you planning to make (SELinux and Smack and AppArmor) possible?

The stacking isn't going into 6.1. Paul's decision that LSM system calls are
a requirement will require additional work. With LSS-EU next week and a long
overdue trip on my part in early October I don't see 6.2 as at all likely, either.

The commitment I made to Paul some years ago now was that the stacking would
eventually include making all combinations possible. That is still my plan.
The issues beyond ((SELinux xor Smack) and AppArmor) are primarily network
related. Secmarks, netlabel and SO_PEERSEC in particular. I have posted
preliminary patches in the past, but they need to be revisited in light of
development that has occurred since then.

On the other hand, I'm getting the "when are you going to retire?" question
way way way too regularly these days. While I intend to complete the work as
promised, I don't expect to be working on much with significant importance
come 2030.

> My concern is, when loadable LSM modules becomes legal, for I'm refraining from
> again proposing CaitSith until LSM stacking completes.

I would not wait. There is no reason the efforts cannot progress in parallel.

> Linus Torvalds said
>
>   You security people are insane. I'm tired of this "only my version is correct" crap.

My favorite Linus quote of all time. I try to include it in every presentation I give.

> at https://lkml.kernel.org/r/alpine.LFD.0.999.0710010803280.3579@woody.linux-foundation.org .
>
> Many modules
>
>     SimpleFlow （ 2016/04/21 https://lwn.net/Articles/684825/ ）
>     HardChroot （ 2016/07/29 https://lwn.net/Articles/695984/ ）
>     Checmate （ 2016/08/04 https://lwn.net/Articles/696344/ ）
>     LandLock （ 2016/08/25 https://lwn.net/Articles/698226/ ）
>     PTAGS （ 2016/09/29 https://lwn.net/Articles/702639/ ）
>     CaitSith （ 2016/10/21 https://lwn.net/Articles/704262/ ）
>     SafeName （ 2016/05/03 https://lwn.net/Articles/686021/ ）
>     WhiteEgret （ 2017/05/30 https://lwn.net/Articles/724192/ ）
>     shebang （ 2017/06/09 https://lwn.net/Articles/725285/ ）
>     S.A.R.A. （ 2017/06/13 https://lwn.net/Articles/725230/ ）
>
> are proposed 5 or 6 years ago, but mostly became silent...

Yes. Unless a major distributor (Redhat, Canonical, ...) decides to
include it the upstream potential of an LSM is very limited.

> I still need byte-code analysis for finding the hook and code for making the hook
> writable in AKARI/CaitSith due to lack of EXPORT_SYMBOL_GPL(security_add_hooks).
> I wonder when I can stop questions like https://osdn.net/projects/tomoyo/lists/archive/users-en/2022-September/000740.html
> caused by https://patchwork.kernel.org/project/linux-security-module/patch/alpine.LRH.2.20.1702131631490.8914@namei.org/ .

The BPF people made noises about revamping the way LSM hooks get called
for performance reasons, but I have not seen a proposal from them. I have
assumed that they will get around to it eventually.

> Last 10 years, my involvement with Linux kernel is "fixing bugs" rather than
> "developing security mechanisms". Changes what I found in the past 10 years are:
>
>   As far as I'm aware, more than 99% of systems still disable SELinux. People use RHEL,
>   but the reason to choose RHEL is not because RHEL supports SELinux. The only thing
>   changed is that the way to disable SELinux changed from SELINUX=disabled in
>   /etc/selinux/config to selinux=0 on kernel command line options.

