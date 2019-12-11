Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B7C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93B22527
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G5ewl5eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLKV0B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:26:01 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:37361
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbfLKV0A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 16:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576099559; bh=9VE2We9+H5oASaC2w6ZEvV6uAebZhrgZ3rBtS0R5FWk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=G5ewl5eotaQDoEkrlpg5M5lUQfF+DRgZi/xk+vcdLRPPfpEewW8ttv/MlOwJ3cxPlnqirRqBsJUqBK3kQ0Ueu3OVG2J76Op7TWTe8gyiY/4p1BeN5g94cZSs6le4mGqreJYPmXYxQZqNW4ltu41CI7BzeqZEDhaevlGBsDEmm4CwubmKxtA69mzsYrxasDM4Cis716AFLQgNgwHyt/H/6Eog1SbuySPzE4+683aLcPBOrbkUj3wOAw9N3I6w75SEcDwb9yZ2jsmbZiVl88ErsUuNrUbCbycxLCAi/AUVf/v/3X17l5CEyejvCUhA2nkpgicO0Ms3IOBsqylNb76ZAg==
X-YMail-OSG: 9Vscc2cVM1k.umwPL9c1nn_K0qlRdMsze_DJI1vGAiKjokRZY6eccLoimaYRoq0
 xdcUlFTatcGdmL.dD2E8vlF7vt6ZbmNR7kqlDncSOqAgnr4G5QwlA5Ex633tOsFC3W5VFs8_sLoD
 C62Ev5D898KZERialFhrD_uwCaFM9SqbgDZ18C3Kka46mD848ZO68v20JY6N_gTJzxF_N4tkHf8B
 dKsci80sZP5meoub9qNqZNi.H6N565bHDQiL31RVJhSRx0OwqfLcQ1hIWtJphFz8DqbOCPxuuvMU
 MXoqc1nzYw8k3f74AtumaQuSnsqRY76T1UIr1Gfgfyro7d_Tf5El6T_LPnHxm3ImbNDRE2eZTcfC
 TCknKZEn0QOyTV4Wn77UA3.ur08D..bVZOHKcnEWtd4IQdZzB7jPHYChCW3ZyxW7NeT.yjNboM_Q
 aWFrPMgGS7a2wnxkzy.hhjWFvd17BzTPnvZzE__0..f64ZSLiGrHXjEX5rRDPICKFB0MoobpGB5d
 nSBHAPpAr1QjyvYk8y3c78WeU_oWHBkDGcw67QxoQNKvgL4fdVgH_rxxlMDyD5CaumEOlUfTj3XI
 5kFXMlE9bJy_555nkZuHME70JyOSGh.lwa8RzP_o3bzTWAb.F6Gaz57t8Do9KSi_89rV15js1_OT
 .K9PDjVOwk_0KyPNrg0afxZv3njSSMrsQaHoxFbndPJPeWp7lWnUr8YyaeicIuT0tq2TGjv5BLGj
 qPWiOHY.QMsYa1XIedpqWxg_6iTLGXM5xvcux6UGdOU9Z7llROpgCs8uEfW2.mjt00xZ9nzVpDxT
 hlpKdSr236no80N6HnAVMzU9jEqrmKzSUeMmSkn_xlv6oAgilQysXaFLV73qyMaVlsMtJkozo8OW
 Lycy.tM1lD0tEYRDGRDavzlz_yaTorQ8sk10lbtUmMjoxODz2iTUaqacF2G6NDFktoBw0f8LhPHL
 vAqlDyPqCJW8tUXwfxP31wE56FaIOcUbiGUfyNGWewTQr.kf2rFvNXYR61k0WZUwhv1miZ1l2.ht
 nOTLFSfbRC0jkfHOnVJir8EBWySYnQYSaiM_hb9TMUTlZ6c..Qs3FE5AV0utqj5UI45o8scoVm2S
 j4HhsIL2.X76ho6edcfEXv7jkYuPbpLaaDSrLTPg3nVoKsuvfgcjYHqvuv1E7x5u3KforMxdL798
 VBF8zKhlzalvrG35ZUwq_A71LQ8HQOsvEOwBsttU_WNHChZUcAaBs5umtESACRynr405AzBE4QUy
 OX2iywakGc9D1t06SdOOFWv81EWfc.QWN4tO7pYRV60I6H1d0Mj.5qOOiMAbAl_mCqmnjlk8uRFq
 6V14ecNGV8OZ2bVUfq0SeTg3szIAXXiIYqKmp5tkGzlFxqibuw7Wn7.MdalCNSdNVoCCnGdOuwD.
 mXFgzh6Vq9zrLe0yG0JFEmdK3UF7P9JX.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Dec 2019 21:25:59 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7fe120ec31eadbbe31198fbcd11db570;
          Wed, 11 Dec 2019 21:25:55 +0000 (UTC)
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
 <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
 <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
 <16e9e399-2ebf-261f-eee5-cf9ace2a82b9@schaufler-ca.com>
 <20191211203648.GA862919@tassilo.jf.intel.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d09a3ca0-02e8-78f9-aff9-8b824bed4ffe@schaufler-ca.com>
Date:   Wed, 11 Dec 2019 13:25:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211203648.GA862919@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/2019 12:36 PM, Andi Kleen wrote:
>>> In this circumstances CAP_SYS_PERFMON looks like smart balanced advancement that
>>> trade-offs between perf_events subsystem extensions, required level of control
>>> and configurability of perf_events, existing users adoption effort, and it brings
>>> security hardening benefits of decreasing attack surface for the existing users
>>> and use cases.
>> I'm not 100% opposed to CAP_SYS_PERFMON. I am 100% opposed to new capabilities
>> that have a single use. Surely there are other CAP_SYS_ADMIN users that [cs]ould
>> be converted to CAP_SYS_PERFMON as well. If there is a class of system performance
>> privileged operations, say a dozen or so, you may have a viable argument.
> perf events is not a single use.

If it is only being called in two places, it is single use.

>  It has a bazillion of sub functionalities,
> including hardware tracing, software tracing, pmu counters, software counters,
> uncore counters, break points and various other stuff in its PMU drivers.
>
> See it more as a whole quite heterogenous driver subsystem.
>
> I guess CAP_SYS_PERFMON is not a good name because perf is much more
> than just Perfmon. Perhaps call it CAP_SYS_PERF_EVENTS
>
> -Andi
