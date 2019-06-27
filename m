Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D8AC5B576
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 22:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12E82133F
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 22:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pujWvD+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF0WdG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:33:06 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:40058
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfF0WdG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 18:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561674784; bh=xDFv9B/5IVjOAnFelkxRQaJTbIeple0ActjtbWy1S+E=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pujWvD+4EqqHD/miOqTycKpNSpqdjn1jxgGKKwVOzelMVXpq/WtsGs6otdBXFE2pjmdlCmuzhDs8ina/7E9xXmO76D5/ddAXFGXF5FlvwVn1Dw5oR5rtoDolu9rbjgSl50HvGy0xoI7oi5oMK62qtkUwrvWcy23U+a3rQ5AEJ3cpf2pVFQDmU+Q0ObFrKQ/1WF99mvv/Tr/RVHhj4aqgZ2OSf78pqYb3VKcyUKLYVT+3dQ8N5QobxsxtRfiaVWhlqA5u8iBIbiN2RAL89QEhmpJSepv7KuZGYJAIr5s5aBRsnaDC2/El8HdtGCR1jLJk8KVZ0c9CuIRouy7+v11A8g==
X-YMail-OSG: VXVAsJMVM1lw9lizVUJRVFQd59raKSxcCrXk3kb3YgUBYGxQIv1s22odyFZvWje
 ijahYryZX9OR5X70j83obC_tE5hdmfuihhSdRqMfmL5pU2h80w5GJuwIdEXm9F1zgPE3vH5Jsn77
 CeRAMu8365mLu2Q1Eue_h6XBcjf1rOT_g37phyAjqQk.bgwHuoF1HTkv5oMmnVXzqIY1tmZcnTsj
 nMIQ5yecYUj5jvXonYjHaZKRK3rYR5cuUkJCRJD7BV_lkGTaPlra6Mo73oIPNAEB0qZcuC5n1OBv
 lgw3V4po.WIRnsp7qm8Zk9U7XY6KQEeat36CqhYNYxwX_ubfKPH9m.X4CnLpTexGay4nCEDq1IR9
 9pQHTLHwhIjLpPmzsaZgUAMkOxQfkci7z2DvNS7cgGCfilqWSwV4Zlm0reNvbbKiLsAEdctMFvca
 eUiRlRLoFP.E3sUUED2I7B2fklCtFkfx7TRq_hvaa.bLNAaAyGbijU8qHZbM9AM0d8jH1XzC5w8Q
 6qtfF1oLmXYDOY7Zpd47zvc_2SPKkt1.FmS2QvOFQ.IsWTXWMVZUuDblCORAImgPtzZ.h3IarHD_
 BlJLOd8pc3Y_T62kCK977IjY2blR.PDCLodgOu2dUm4dAR0hNrUMugkosaHQrHGHVXB35GaBRDtD
 mwfczRqDvpf3I0IPqR.blznvxztKxIokriPeo4bIfQVFGacfU5DpLBCnU0lPohTaQVhycHNTJtLD
 vKejFskNczGsuNzJoOlAWrlIekGakAMmwlHZV26m1MNKJegSW1jO28SdvmZfGPfsOoHw1Kdd78Nb
 rXgo5v3TV.k7CoEYwEpfhGcM8A1Rowtd6_qfuh.ZSINtANRMgesMCeP3gBDsXtXc31.JCLim__a5
 Q.ZIOXgWZuxnrqloFCJuFp3Gx_pMuVshZlkjQ6xaQ9yrp17k4urKBRd1hMgxwYCr6gbaJRcHhYCr
 jXCQcFpoGeaenXQv1Zwdxg65.Y5Yx4ZRNHniwtXfnnQSal2AC6ijom_F6HQG6imVbYvW.OXoAiOv
 iuqYZBaUj3xT0rLnmCHX5wNkjm9lNm62YgDUH1G2n4eaht2NI248P60Hf2V_r7dr8HCdIthPR4.F
 g4eXx6mIa4laEWv2O120rrlyJKhlHMCWlF6qyQcavKMgy8DU5vkAmrzQ24un7ssYWppzF7XfJwpb
 qgQlHf9M6IpGdZ0ojZJgWSmrWvsEwlPS9cEqkdnaWttFfwmAa37yeAbRfgUY4InRaHNbVC1CLbrL
 MZ3IdvF79RaWhtCgKEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 22:33:04 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3822a81f909d757606ad9ebdfc96dc89;
          Thu, 27 Jun 2019 22:33:03 +0000 (UTC)
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
To:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <f5552cb8-1d6c-eb07-be4d-c85e0722c1fa@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c7d0e190-1b43-3e50-ad35-18346453af15@schaufler-ca.com>
Date:   Thu, 27 Jun 2019 15:33:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f5552cb8-1d6c-eb07-be4d-c85e0722c1fa@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/27/2019 2:52 PM, John Johansen wrote:
> On 6/26/19 12:22 PM, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with any other.
>>
> I have been doing some testing of this with Casey's suggested
> fix of clearing the lsmcontext in security_secid_to_secctx().

There are still cases where the lsmcontext needs local
initialization. If security_<fillscontext> isn't called,
and code later looks for context.context == NULL you can
get bitten. I am combing for those cases and will include
initializing them in v5.

>
> So far things are looking good. I have done smoke testing
> on booting with the following combinations under an ubuntu
> image. For the combinations that have apparmor I ran the
> apparmor regression tests, where noted the display LSM
> was set for the apparmor regression tests because they
> are currently only testing the shared interface.
>
> capability
> yama
> capability,yama
> capability,yama,apparmor
> capability,yama,selinux (no selinux policy)
> capability,yama,apparmor,selinux (no selinux policy)
> capability,yama,selinux,apparmor (no selinux policy) (tests that use shared interfaces fail without display LSM set, pass with it set to apparmor)
> capability,yama,smack (no smack policy)
> capability,yama,apparmor,smack (no smack policy)
> capability,yama,smack,apparmor (no smack policy) (tests that use shared interfaces fail without display LSM set, pass with it set to apparmor)
>
>
> I have more test combinations churning but figure I could report what I have so far
>
>
