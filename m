Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF5C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 23:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6CC20936
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 23:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rpWEchuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIHXiG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:38:06 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:41840
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbgIHXiE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 19:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599608283; bh=I5ZCgGZFdn0HPlYqNmG+VylBtG4U5fO7P9plk+ErbpU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rpWEchuXnxu6pH/H3f61ihwTLjV4pF+8LEYAW4z6d7cTdsdOv+alUf40jYD/fasM19fNl5Fji0nwBd958orJTkmSzavO7Ftc6UOsntPJQ7xrJs+33eSFsuy52v1LGgf/jjV/iH+r9XFvWFpis4JrphLnXu6vKd8inPT1PBkzxtRKXL3rfHo6j1lc1iVrSY5885xxqYyOOJFYpIoaeFzCQkiUYUf933ILL1VO7Cvsy/tGxCzPPLCzCR1Ldya292E/GXSNCp8RKPjVa6iFo3TR8QQi6Q083jKX+JB6jz02vKkn+XDj+G1ThseYwWwOtNuv6srTrhbSzP1QilwScu0qXA==
X-YMail-OSG: jXx5Q5gVM1mOeCClW_YWzKbQovKb74vYDiw06eADfEekYcUOmag75JucEYacJ4V
 y7SCSK9dr7sbnhafAlpAJqSvAoaIc0rDsH0_GIJZZHuYhBNvqmlZAvQ5s3XrSCSt0FHdtJzrYsrW
 NX5XAjTxMOiOHtFoYzV6o.OC_ty8e8qw6uAFrIb4DruvQAEut2cjNiGASDkE6q1Z6HqKgXW206RH
 HZaTMQrG.kBA24VAw41SdCKPmJBYmrb9qujioQ6ofk2cfaAGE0h5rLqw2hMv471XkXlJIvHr0xPO
 S3h1bSaM61VzeaVz9yIEKuSbOoXD8JMk906efD51_Hb9AQLurufStXMEIjm_u6XgrFrP8PjIkOK3
 f5f4FBu8JcLuajBkaPgOe4Ff8LqJyJnyO9L_A9p5du79xy2ATLRXFOB0IPbi81Mp1OSF6eh0Ydhy
 NjeYXvvV3XdgmXPol3Fs3iTC9YQ_isfaFbP5f9xPXi8v2bg8zHMdPzyqLorh508fAJkkwlAh8Gxd
 cwFS.zxLba4610u3ZTguk2kA4TkcN3_HSUxJfmhDG7ar.vjVSq0B21STe8MdN0v9Bq9haNjF91rt
 3ENOvrizqGfUGcLGJjNuPAJrxA_1u69_ZNPLf84iDmDqPCQijpSlL9wjX5ziW1FSaeAp6U4RtcfB
 UZl4j6RSgoScM7xlXW0_86cZlJgx0h_b7vSdlW0W.6OEktNHyqzmOcve0m7.fiLYyjnQPtc_rd4P
 vCFb8iUkTFia5Wcb6T0L4QP7IISybBVstIannuz_lGxZ0XPk.WDFciOfZrVzIkxQZJY4ubxzwt7B
 HM6ydb12kKpamT5G6fKKaud8YOTFyNLJ26zaT5C3wKUhQpmP2SenJuRLWCxPJtagpYm7gBqE6lpg
 UH_MnKmKl403ANZkZxFvnwQws7JgzvWR5.D8btT22gt5CZBmEUPI7877.Ko_JL7t_cH0LDuHh8Ef
 V58_HU2lduXLcDRciPGu1FBaJsUhovy054GZz2vVq6fTvR_HJpFkhHYrqkpoEWt4bUrgUMkm_PfT
 _QXD3vpf6XuuYMw01PVhhHyka34mZc7iZof3Y8sgSvkB.voxAO.0XA0V4rziD2rBbUfmG_ccKnoP
 FnNZCb.X6wqHpcy6apMiLqc3YXFgiM0JcvT55Zpa_EIHuRaLLWO7rGq5dqE5f6j82WvXbvO4Hfle
 MmTYgbbfkYy6TeRsmEgVc5awJJfR7V8.sJKxhalC.4MtE4mz0BFZMT3.tXngpmyc_rHHjBH2zwO8
 UGeEx_7IdHJj5SZtDZciy7LC6I4qP6M2CGutfLft.XaWqCC7goLDaW1pmDzGqTMNFbKlgSk_HUuH
 pib.V9Zn3tz9i7JBm2TSNazm5R2_rbvzlQXnrSnmkFy86EqpRYw4.G8yiOm0bhZTeZSHhPG3b3hH
 SXnECPLtAX0SPD.eNWRHcT7AUZOFvzlDJtGuPpZ2mQUcKhQU94VfJmOLI9V5hH7WHombMmwLPw37
 bhtm.k5fH2g4H2E7J7t.jGgrP.BJwx3Bs56DCsILgHkLD34GPtNq7H0uSjntw1ZPcBuj.cSosfXA
 fEyeAiEzecjLp6Noq3_b_YvlZzB_uV0i62HcG52gOSE1h
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Sep 2020 23:38:03 +0000
Received: by smtp407.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d768f3d3f91d38854b63b7a8d98c3f3a;
          Tue, 08 Sep 2020 23:37:59 +0000 (UTC)
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, linux-audit@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com>
 <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com>
 <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
 <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com>
 <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
 <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
 <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c5bef71e-6d78-2058-bcaa-8497c76d7375@schaufler-ca.com>
Date:   Tue, 8 Sep 2020 16:37:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16583 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/8/2020 6:35 AM, Stephen Smalley wrote:
> On Mon, Sep 7, 2020 at 9:28 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Sat, Sep 5, 2020 at 3:07 PM John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 9/5/20 11:13 AM, Casey Schaufler wrote:
>>>> On 9/5/2020 6:25 AM, Paul Moore wrote:
>>>>> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> On 9/4/2020 2:53 PM, Paul Moore wrote:
>>>>>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
>>>>> ...
>>>>>
>>>>>>> I understand the concerns you mention, they are all valid as far as
>>>>>>> I'm concerned, but I think we are going to get burned by this code as
>>>>>>> it currently stands.
>>>>>> Yes, I can see that. We're getting burned by the non-extensibility
>>>>>> of secids. It will take someone smarter than me to figure out how to
>>>>>> fit N secids into 32bits without danger of either failure or memory
>>>>>> allocation.
>>>>> Sooo what are the next steps here?  It sounds like there is some
>>>>> agreement that the currently proposed unix_skb_params approach is a
>>>>> problem, but it also sounds like you just want to merge it anyway?
>>>> There are real problems with all the approaches. This is by far the
>>>> least invasive of the lot. If this is acceptable for now I will commit
>>>> to including the dynamic allocation version in the full stacking
>>>> (e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
>>>> to take even longer than it already has. Sigh.
>>>>
>>>>
>>>>> I was sorta hoping for something a bit better.
>>>> I will be looking at alternatives. I am very much open to suggestions.
>>>> I'm not even 100% convinced that Stephen's objections to my separate
>>>> allocation strategy outweigh its advantages. If you have an opinion on
>>>> that, I'd love to hear it.
>>>>
>>> fwiw I prefer the separate allocation strategy, but as you have already
>>> said it trading off one set of problems for another. I would rather see
>>> this move forward and one set of trade offs isn't significantly worse
>>> than the other to me so, either wfm.
>> I remain unclear that AppArmor needs this patch at all even when
>> support for SO_PEERSEC lands.
>> Contrary to the patch description, it is about supporting SCM_SECURITY
>> for datagram not SO_PEERSEC.  And I don't know of any actual users of
>> SCM_SECURITY even for SELinux, just SO_PEERSEC.
> I remembered that systemd once tried using SCM_SECURITY but that was a
> bug since systemd was using it with stream sockets and that wasn't
> supported by the kernel at the time,
> https://bugzilla.redhat.com/show_bug.cgi?id=1224211, so systemd
> switched over to using SO_PEERSEC.  Subsequently I did fix
> SCM_SECURITY to work with stream sockets via kernel commit
> 37a9a8df8ce9de6ea73349c9ac8bdf6ba4ec4f70 but SO_PEERSEC is still
> preferred.  Looking around, I see that there is still one usage of
> SCM_SECURITY in systemd-journald but it doesn't seem to be required
> (if provided, journald will pass the label along but nothing seems to
> depend on it AFAICT).  In any event, I don't believe this patch is
> needed to support stacking AppArmor.

Stephen is, as is so often the case, correct. AppArmor has a stub
socket_getpeersec_dgram() that gets removed in patch 23. If I remove
it earlier and throw in a touch of scaffolding for secid_to_secctx()
we can leave the secid as is for now. This can't be the final solution
as AppArmor will be using the hook someday and we still have the all
modules case to worry about for the next phase. It also assumes that
The BPF module isn't going to suddenly sprout a security context.

