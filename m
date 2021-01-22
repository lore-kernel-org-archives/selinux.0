Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FBC433DB
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4FE233FA
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 17:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbhAVRQ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:16:26 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:37138
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbhAVRO2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 12:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611335621; bh=5i9nyJJpCZmPifjzjqrRBjC3ARCVOwClsgglliOLLNQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=IN85HQRld+Bp9AEL2THMs7jCpHFv6CaZEXhj3TD1jKkDv54eY8K/HLRg58cXV7XkxbDsw7RLWeI3oNftegIBDR5T9BjQ7XDSHkonX/Jug7ohGtBNIVk9K809AogyeEtt2ByFlDbLRoCTpa+awOl11zZCc9bWyfOQNkzan1PXO2F4WuRVlLtApN5KXT9RtzhXPfTibFDrqwCjITa7F2jlb2hOgH+sWTehk8vnuNa6fH5mBXn2Zlerf0rIH4IeJnG+8k+7AExji49Louhcf7rBxIik1/ufUwRYKVD778n8b6a2YCpOOvDGGTrGDwUq3C9SGDjZ1mhV3WVkVSdXAw30Ww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611335621; bh=1pBsRWgx4L5NnJW2yu/g/Iodzngsg1+boZ7pfaEPAEt=; h=Subject:To:From:Date:From:Subject:Reply-To; b=K/Yo/8zHaxE0xR/dOgmG0nPP7ssb6h6D7CPbWbdC7d2WE629zkydLbQ8GLd34Vqj5rooG/ZDx85T8SsAe543ZSSBA9h6WcRlabtIEOhlrTp2FfDcdesuE5Qve/A9fHpA1J7MXk3usLNzGUfpkg9hkoWRwkqFDKN2IwtpsPfvRF4n3EeG7/dAs1QqC53vKuZg2263WhmAzyTet8uR8Bt5E2U1+YOPIAgyy+JTCCLH1nZd9C5sHYDbbbqx3FJ4pw43GJCUigzs0pHzspEFT34OC9RxhjJ0R2n0/EsTnwJS1Lr/ww8j6qz++CSkNCvTjnt5HcHdotAonDiCBBGKp2RHYg==
X-YMail-OSG: e6ZCeDUVM1lDR7tjJKV7VZBC0rsWV87Z622NUNo7txrE1F.93RTXXWBQD8rGYts
 H5X7DFKLm7aN8hLlar83d28BjUe6HJeG7SNGZchVcJ8m5dUMiecYC_PVAfRrqC_C2BDolQFezDi6
 AGNoW8Yx98ZUx5mQN5qlHEtn2rXUFuVeHtx611RuM8PkL5XLgpA8vguUtrf9NA9htLH.FENJVw97
 g8pernh2VhN5ZNPqU1Z_eFli.ErgEjxIalxhPgJR_ZkWzDMg9psXn0SpmxprIgQxns_hzliZBeAb
 yMquYWxh0TAplggY_SNev4QqefR9vLqxLEhj2MsJ1AwqkAA0tsj21nljd2ccACIoFYuiSmmimNmY
 vPZnCw0jwGDThSFkjg0e.cnLIDdnfcuK9XHV0aM4Bt709T9FhtruNnXpGW4y_BNqlJ0ST56mpWck
 yK.4JRAiM9FvoqO7mN9s4I1iWkjlG176OqD3sipSpbH6EYrOk.zHzYtspZf4HWEtDmMxkdlUmNsK
 4bMt1X3BZZILcjjQkzcQMUYvCs6TufNq_Ln6sCebjviTmQ2i3rpNt6J2Btq13pWsr6H9.zOtFIEy
 XgFloyTNeOwutWybICdMcM3k80JHYLv3s_Tu5C0FyhX9sib6F9T9_HwEAlmAI_a3X3VWADDKaAJ3
 2ZWm22byznfQo4p5AS1EDwsT6G2A94BFzKBP5n62F1j7wfw1LrrfSkG4pWhxM7mWsvZKI8TticQu
 3M8EMwtLSxZz0vhVNdeCfZlneAR2ewt3R8cQInGOFzTu5P6dHN1pTbIwxdiqkbNEK5OGuLza7sCc
 QNpbvPOVzPHNdZIzc0vQe3gFPv3AcdQARy1TX7lnqTyMSXOZF9xLbWyd7Mkm5dnjXzk8V27DTjN0
 RL5i..M_duA_f_ExbS2Wdqd2.bNgfrQ9H0gCANSSvpCN8A460nk_TUZG8aD8qSECDmTQJc.uPcql
 8BOfVpJyPWtB78p.ef0i.2egOKco_6I7z.dDz17oPJ3XVlQDnGpQJSibbCdbC1EsqcZrF3qmikoT
 Fn1pcce9DA3oVn0nynDtUdhmCZN_RfDyKsJz7ya.Bl6Y6w8jHLc00JoqbGuhXqy1xhJyYV.xvxoG
 Q.7ifRs75m8qjPEXnQd90wjK.vwOBLbk0vtnr2VjHdjzh.cIcTsPFhfFArZyLDN80W0fZSuOCXs9
 kLlGPCOl.dvYaMJmvlCAVFQqS3Wtk8lvAciLEcUr.8ZQtndfun4jl2a7jY6PiUAXYNH0G8aDt1fb
 0uDj.wU.tW6oVVHx821yc0xmwy7c8IjEnyTzCIr2Faj.AFUgbkdpJ9YyFAO7wdwvJxDRLKyfdm.T
 N82OI16NUDUd2HzmZsNvJa9XpEQbVJ2f6nnmX6uReGpRi1YwYBIWb4ifQ6lx7.tnVU233V8u5mqM
 pp6egj46nVS8HtS3Dvuq4K4MO8DAR1jUfJpzmCVnCVd4YYokqOkN6KsIBiu61coC9Ktsu4S2Q58h
 88S4FEnkPsGiXLpM0tu4jUEf1ECXgJaBnVYCO4sg007p3PL1T3TnP9sAVvELG_Z6RdD9Zyio0jHB
 VgAuyO22S8_Guz_nPSCtXV.53xzOE4fIBfSQ4tOIYuN9TT7q2Mp860AfHmbT..RohpyUv4uzebNn
 mid.VMgLLDXC9kpmbGqVttno2SEj1JHll6EpWJKj72QXFztQ4nK8_GqO0QhqHArkqxCytprlgn2z
 15dDKBHLV11Slx7cBTwJtdmnOALJfTy5uEkkHqDLEOwLRmo78lXu0JOjn1xwU0gjMDJyQ1fQFQoA
 b3c0VXNspC8dY_xlIreEIHQNzDooCKtB5gO.ybFKc5RP.WjncekkczAm9xfrI1N1DVGwoYdV4fuk
 kMzOUGeP7a0mIdt2wUdUQS8cJlYxadpbQgs6iQvs.3Vx9YWXTWi6BE_sgwK7gyWaLkXBqLOqIavf
 XXH_FBA1ex744h8K.AewRviYKaTQUT_wgwm58NXUi8bTPHWkTRO9muvrM_Tjhvbjx9rq6APfK6MG
 o4naLga8yMBpUQDMT3KLdw0f.5c89p3HsMPPhAsEVg_1n5q5GsKLVNhJmDaASq2LTe7Wd1KpVM1a
 UNAJvpZyUEXWo29QAYa3GM31rbHX1X_Khwb2WWJgPvH_m8D_Ne1rOXwmiwYA9FayZRmZ22OWSeE7
 7DvEKyehF4FUrETc3ZgWtIn7wOxAga28rEN3n4zfP577bJrlwvOf7mkiLuuggBsuh1KsR0ov7FRm
 Yd_z9uoW_9BZFyydXrl4poXKpa5PgAY9LpTyPhRqEzzNvskyeZagxqGZJDuVKAuR6ds7FJY__GzZ
 D03dIOcuy9UvG.jPjhjGLvKigEyR9iwlCh0uEmuDEearD3fb4wFJzl0grN4qt_n0WV_ccJix_239
 KpPonmO.xGaiPzR8ZXyzyXZEaNYxxSI_H7wUFlP_16rwlHj0kkaM3xhTdaXGEKK0uOESYXDYCVu6
 j8NhsHHkt2kBuIiTe.bb7qjekR3_2yRcIgk6UFUByGeMWV9f79ZsCkUvYwmdB0ApugOszEd0_Yvn
 lXQ3AdNl1C0_rOXeKXUAXzC5kTaUm1ld0bLQWwASIZCZiuGpmyKs0H1O6LpBjmJ6Y3R6cLZZqOV9
 iHiVhmFuzPr.pmhjwoUwnC.tcNiOVVOIKbVT.OJL3vYNYQe3DGXRfxw49gZBKgEeWM0zxTg5ts0F
 Z12uW08tZMj9iQYxK0eEJsQ5vvojdtwa7CUffSG_Ilwmr8yuYI1LhND17q3I1zQRA12P7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 Jan 2021 17:13:41 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2efe479f8244047472b27fb246d420f8;
          Fri, 22 Jan 2021 17:13:37 +0000 (UTC)
Subject: Re: VSOCK & getpeercon()
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc:     selinux@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
 <CAHC9VhSCmhkcRgWtGQNhSr8SQueHWtw3qW9SEtNnEgC=AyzVZg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3b5a02e0-1361-6fe5-9a2e-2a9113e99d2b@schaufler-ca.com>
Date:   Fri, 22 Jan 2021 09:13:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSCmhkcRgWtGQNhSr8SQueHWtw3qW9SEtNnEgC=AyzVZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17630 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/2021 8:27 AM, Paul Moore wrote:
> On Sat, Jan 16, 2021 at 7:48 AM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>> Hi,
>>
>> getpeercon() isn't implemented for VSOCK. Note, I am not very familiar=

>> with SELinux, but I was porting some applications that uses AF_UNIX to=

>> AF_VSOCK and reached that point.
>>
>> I found some previous discussions about VSOCK & LSM from 2013, but the=

>> reasons it was abandoned don't seem so clear or valid to me:
>> https://lore.kernel.org/selinux/1803195.0cVPJuGAEx@sifl/
> Hi, my apologies for the slow reply.
>
> The SELinux/LSM VSOCK support wasn't abandoned due to any significant
> roadblocks, it was simply a matter of time - I seemed to be the only
> one who was interested in working on it, and I couldn't find enough
> time to work on it ;)
>
> If you are interested in spending some time on adding proper
> LSM/SELinux VSOCK support my gut feeling is that it would still be a
> good thing.  However, I would suggest spending some time investigating
> the current state of things, while you may get lucky, I believe it is
> safer to assume that anything from 2013 is horribly out of date.

That's a pretty safe statement. You really have four options at
this point:

- netfilter to set the secmark
- CIPSO/CALIPSO if the protocol supports or can support options
- examining the peer process as is done with AF_UNIX
- eBPF *I think* but you never really know with something that new

There may be something else out there that hasn't gobsmacked me
in the stacking work, so that I wouldn't know about it.

BTW: Please include the (CCed) Linux Security Module list
<linux-security-module@vger.kernel.org> in discussions like this.

>

