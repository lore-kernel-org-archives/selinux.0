Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B7BC43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781B2077B
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WD1KBhIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfLKSJh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:09:37 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:38612
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730837AbfLKSJg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 13:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576087776; bh=viEowQiKvjFND68sR3c3UpyOmWS0jjunhPLnDvcY6M4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WD1KBhIzXiRxcEPjUe9IwVNWcyW9d2flD2Txsj/QkZDd8zVYJipnTTXJkVRuV610oC75JrcuhrqPJlspYND3Dy/Jrb27M1EDORqavOOpr5OQ5IF7NNl3Qxgw5W5FE7cDiRSuzG+S+jzwqRoruqOv8RBE7HFLxgyxvhqntHutPO1K44Ioy+k20/1Fi3R1JfwxL1iN/EEY6/ulYlYWnvj98Dd7NTP5qiu8rd29d8JgvU0xrMnthWXkIRW/mDu+AopPVnm1ycc2/RSnyutdtthT2L6MC1AaqaTC9+BLIJehhV7DoWqaPSepVlZ9OTMss8IJcQP+DT78GTLmoUnVJ9OJ+w==
X-YMail-OSG: fBL42q4VM1k7xLa9X2IFGJgoAK24872TKYR2K4ORstKVu32ePjJXaCO02uZsMOu
 qYKJA2hYjUUCI4o8Khnb2F55PloCI6s.ebM7QuIQG6iU_JDfkRzUOo6rSZTpt0DsVd52K0b.kgOe
 DKRMKNj4lp89hps5nXWLwLnx2kZf4QBY.pYuAEmPTSJV3IJX7kexoCpxZkByo2VOsjZQgpqdeWyb
 S.83mmovxUqmnFU2sPSQMV7mGfErgBj7sqfiwwSA_Kgjkx6lrAbP0YxgOH3ksF.tJL9GLWzjf0R3
 _7t_r8ARZq6jMUD76mMAt26HTnfiWlGs7uJGnVjAuLr94QGDfcN7GX6XPOQNKxiTvsUnV9AwwcIR
 HhgZNgwiHmVaS.b8kzlHL3LB9Tj.g2i93GTRPqlWcnWS2oD7MJOjFyKcoVqWRnziqVGzF7WnrNVL
 PlCSTVuax4boVu9j4RILCju4hS8ckQ37DTvNsC6zEdKeMPJNlb5Dh6F0.mjL9xWRy5tAS7JOtfwS
 zQvsrPCZEfmheYzRhNnX10VP5cdkqCP6Xof4QcgEHz5Evng5W2twb2uVrdDYjtMdAvjfPkvFMgAy
 Lc0u5GraFX.fdHr0v0bXzOiKFxQfHgVXQU6XicMCAlS1S.rwuRlqpOznCsHUhQ.Z5nyKgGZa4s8y
 bPkYUWLcE.mwnV6p4FURRDd4EskCbrN7GNGEXdS81W20bdxSASNUsRdqkRndmnrx3tq7ZcFjZHb1
 nW8Q5_uzsRUargX_Qjt.eOMX0C6vaSUCwbWfaytHo7lV1opqt4VI1YFj95RiQpQx2Oc3uuYTba5v
 I1LCHH8QQhVmXdZQHaKBgWkOFx80NNwoFfCUfd7gqRI1KexRTW3tP_5LLpFFdFaO76j0CFjzhOPI
 4FasepunqXrpPTLXNiguEFI6ZN3u8ASTVCbVbvzQ4JhYNzWMr4sZjCH.fpaFcMVLr26vwOTE7cdp
 1V6cXKreVLB8EnSvtI_Db_kqkN6pOlz_oV8_tpt8THmG.4XsOaFZDi5Nt7ECHp07SU1exrZfq512
 vYKIENYqWy6PyFRJply7uxuTclxBl1nIJY8cTMeHvCAHGiR76yxul0YuEE71W9x.DzP.DrAni_I8
 UqamTVJs_NAxBeT4FwriNvTeugytH0i8bBv5zTyquFkS0_WWEbrNKx2BZYeqHgNT2ZmXHB0NRgx9
 E0.ikmvclco6su5oMn._qh8UKjgvoNYbCGUgPHOvWqb6UUbB8KejFDF0kf3lF7Jy4i2XYdDUwUu4
 sDxI_hWRIWf7kde09AtQ05p1x4rNau6wft5BCfyDYkfyjE5Tq_.r9otU5eQN4udzxCKHmU93Hi_K
 KV4UhEQKdvNtAXBiwuxfn5Y4DjzG88KxhQ_0Dlu.NKiJEgNsv8TQVyYdq36eP806gp_bH8UclFgc
 pxqFlMObdXiPdHh3Hy7RCHsV1uVwcOS28NlnR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Dec 2019 18:09:36 +0000
Received: by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cd2b57daaca91078fd7aa46e455916da;
          Wed, 11 Dec 2019 18:09:33 +0000 (UTC)
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <16e9e399-2ebf-261f-eee5-cf9ace2a82b9@schaufler-ca.com>
Date:   Wed, 11 Dec 2019 10:09:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/2019 2:52 AM, Alexey Budankov wrote:
> On 05.12.2019 20:33, Casey Schaufler wrote:
>> On 12/5/2019 9:05 AM, Alexey Budankov wrote:
>>> Hello Casey,
>>> =20
>>> On 05.12.2019 19:49, Casey Schaufler wrote:
>>>> On 12/5/2019 8:15 AM, Alexey Budankov wrote:
>>>>> Currently access to perf_events functionality [1] beyond the scope =
permitted
>>>>> by perf_event_paranoid [1] kernel setting is allowed to a privilege=
d process
>>>>> [2] with CAP_SYS_ADMIN capability enabled in the process effective =
set [3].
>>>>>
>>>>> This patch set introduces CAP_SYS_PERFMON capability devoted to sec=
ure performance
>>>>> monitoring activity so that CAP_SYS_PERFMON would assist CAP_SYS_AD=
MIN in its
>>>>> governing role for perf_events based performance monitoring of a sy=
stem.
>>>>>
>>>>> CAP_SYS_PERFMON aims to harden system security and integrity when m=
onitoring
>>>>> performance using perf_events subsystem by processes and Perf privi=
leged users
>>>>> [2], thus decreasing attack surface that is available to CAP_SYS_AD=
MIN
>>>>> privileged processes [3].
>>>> Are there use cases where you would need CAP_SYS_PERFMON where you
>>>> would not also need CAP_SYS_ADMIN? If you separate a new capability
>>> Actually, there are. Perf tool that has record, stat and top modes co=
uld run with
>>> CAP_SYS_PERFMON capability as mentioned below and provide system wide=
 performance
>>> data. Currently for that to work the tool needs to be granted with CA=
P_SYS_ADMIN.
>> The question isn't whether the tool could use the capability, it's whe=
ther
>> the tool would also need CAP_SYS_ADMIN to be useful. Are there existin=
g
>> tools that could stop using CAP_SYS_ADMIN in favor of CAP_SYS_PERFMON?=

>> My bet is that any tool that does performance monitoring is going to n=
eed
>> CAP_SYS_ADMIN for other reasons.
>>
>>>> from CAP_SYS_ADMIN but always have to use CAP_SYS_ADMIN in conjuncti=
on
>>>> with the new capability it is all rather pointless.
>>>>
>>>> The scope you've defined for this CAP_SYS_PERFMON is very small.
>>>> Is there a larger set of privilege checks that might be applicable
>>>> for it?
>>> CAP_SYS_PERFMON could be applied broadly, though, this patch set enab=
les record
>>> and stat mode use cases for system wide performance monitoring in ker=
nel and
>>> user modes.
>> The granularity of capabilities is something we have to watch
>> very carefully. Sure, CAP_SYS_ADMIN covers a lot of things, but
>> if we broke it up "properly" we'd have hundreds of capabilities.
> Fully agree and this broader discussion is really helpful to come up wi=
th
> properly balanced solution.
>
>> If you want control that finely we have SELinux.
> Undoubtedly, SELinux is the powerful, mature, whole level of functional=
ity that
> could provide benefits not only for perf_events subsystem. However perf=
_events
> is built around capabilities to provide access control to its functiona=
lity,
> thus perf_events would require considerable rework prior it could be co=
ntrolled
> thru SELinux. Then the adoption could also require changes to the insta=
lled
> infrastructure just for the sake of adopting alternative access control=
 mechanism.
>
> On the other hand there are currently already existing users and use ca=
ses that
> are built around the CAP_SYS_ADMIN based access control, and Perf tool,=
 which is
> the native Linux kernel observability and performance profiling tool, p=
rovides
> means to operate in restricted multiuser environments(HPC clusters, clo=
ud and=20
> virtual environments) for groups of unprivileged users under admins con=
trol [1].
>
> In this circumstances CAP_SYS_PERFMON looks like smart balanced advance=
ment that
> trade-offs between perf_events subsystem extensions, required level of =
control
> and configurability of perf_events, existing users adoption effort, and=
 it brings
> security hardening benefits of decreasing attack surface for the existi=
ng users
> and use cases.

I'm not 100% opposed to CAP_SYS_PERFMON. I am 100% opposed to new capabil=
ities
that have a single use. Surely there are other CAP_SYS_ADMIN users that [=
cs]ould
be converted to CAP_SYS_PERFMON as well. If there is a class of system pe=
rformance
privileged operations, say a dozen or so, you may have a viable argument.=



>
> Well, yes, it is really good that Linux nowadays provides a handful of =
various
> security assuring mechanisms but proper balance is what usually makes v=
aluable
> features happen and its users happy and moves forward.=20
>
> Gratefully,
> Alexey
>
> [1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml

