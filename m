Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF2DC35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29800206D6
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WpP3r2ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgBKSfp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:35:45 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:45223
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730599AbgBKSfo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 13:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581446143; bh=UCNm7TEW2vu8+93B7hDJURBqKJ4Ygnq0Cqud7N/fCME=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WpP3r2keapa+Vumw/z7lkjFpnpboZa1iL062u/sxUroTNmyzip7Pbossa8fWdhYwL9wx0EZ5OGjLTT5lmQQILQIgrARbhUMw3qGYF16Y2YPzt5BuOisKomizqRM7sLxMnyAYIrh8JFlwnLd2gv83vB8bV5TeawrW67+RMasHJm0sZUc11WTbSHsKZRe8f+bbRN/x9tvlAV17FngzvFN2KX7VULf/SUBrRqznjcIBjHCedTh01GprtiSeGYfi7BnQ/Y3z50FKkJDYYkUheMTRQEOV6JQSzjvbRDxL3lpbAA8YPQjL1rKCQHZ+Fd044OpqZYfaIw/IhkPcyHQECzyCYA==
X-YMail-OSG: Wp.LOjYVM1l18tQvl1jiHM_v5zei5DnsklrjF6eYqiwQgFlWmCi.iXMJ4C5m6Mg
 64dWlax97Fvff7C7WfafabT_yBlJXaZvyJ4RGzNNQTJrihuesSeV3iBwfWIQQn4SqMv9MruMpNBj
 fGAXqhTceWA8ZDeLT1G3tY0lWiZqAxlHtnpA3DOVUmCR2Uyeglo7RZrmBR2iZuMDNSgmc9R0amUm
 h4CMiop5A15s_S3OydWpSCC5p3MjUdMsPoBlth7RD6.2v4ted0.x7jNJvO92PeeL_MEheOo5Ipl.
 S0HTwCVlqv7YLTvNjzCby0ZRLJlBuiGr4plqDQB9bjyzafu1bVAKG72xagxy2gwjv9XY3XGjWdqa
 c0jcAlW2JsVQbiQ8uRBbd9FiX4NdnoChIIDinxtJe_YlLGwU5zTsqAfIastUMHrwRJJyTx.zz601
 5sP.wx3Pfep.qA64_Ddindo8C6M5vCQGK_sMqrgd0H1HnDFcNJ_m121.kylwr6mModTurG3LlldI
 f1DrNYmsl9zTd7Gad24eNDjibIrv.4qh3DeZLxP6iBjs56cWwGNBS6guc_.HDHd8Atl0m6MJzl6c
 OtZcEpK2crBFbHgzzvdrLJKqtxfAfRm63W9nOt01lROjQy02DmeFxOLT1uwi3STiFgm1YjxVd5au
 58sBfPs10ZplcdCIwW_Rq7etWi9CK27gXCGsFtl8jaokiX44yVcjGrQI.WE6i4e5ztAhEgF0s49Y
 qr_QUwN78m82EkSxYlnM1FouUynF7.xI4PyjC8FN65xUMffPFx6darr_Z42WPYilX5dU6rqiiqQp
 au8obATx6JOQ0Emuqy9sr9yrAO_EXAUZ4KmMj1GFrK5r3k.4jokCediU9ofRikugiXdybAmtk4XZ
 6HVmHfJGp4C23gnMDvE8rjUSG77IaibU6l_Bh4yNBP.jkFafUTJBFERJFWo05NzBw5eIN9PqgQTq
 MttK9qTgqWu_8PPFUkfzclWBwEKKp2tBtTppudsV_FiYLEcJLIKur6HLZOomrhFwoG5d4BC0pyPO
 dzptt8ze0_ZffCwd4grhxBP95Rx_zrn.wUghhffnh_pb48g1Mfmu8alMoJ8kWFVjf.EjJie43Fl8
 ulrlm05QPV526fpTpdeJ48ABiQ41JiYB9kW5mX61k5qU8LoQF4FCFRB_b2ek7On8uT2zdAbE1Sj1
 RSjHu2qViT1pFG7FSBbRYltvZmNtwrDXMPc6IKQUiOiXQkrZ4xxy0AsXsl8bPJLGMOdlOXAbEuiN
 x7fT1j6h7TB_oO.c4Uh8Dh9RkoAWSfLXBefROu07XQLq9tfBx2.KP1OfRx1i9BY616gJkbL.LDeh
 rJqNPpc2u_ejFYJrNscTSjpauzTWdNayNYFU1Yip.wPb4XP6ZS4KDFM32wDBPGXqdm5xOFQrSgGP
 uNvqlNvJ241cOd9eoCtCNLkBPj3ao3XgcXQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Feb 2020 18:35:43 +0000
Received: by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a029c04c6646e1d74c28813840f48281;
          Tue, 11 Feb 2020 18:35:39 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
 <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
 <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
 <37fa9076-6f15-0261-3bcf-1883236f9c3f@schaufler-ca.com>
 <422e5db4-1b61-0048-b608-78881f5fa4b4@canonical.com>
 <af6b224c-4a32-40fa-77ae-1e2a5580054f@tycho.nsa.gov>
 <d3dfd552-cab1-f50e-f207-b6308d0d5990@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <397af078-a44b-6fcd-e125-8fdb0b441097@schaufler-ca.com>
Date:   Tue, 11 Feb 2020 10:35:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d3dfd552-cab1-f50e-f207-b6308d0d5990@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/2020 9:58 AM, John Johansen wrote:
> On 2/11/20 7:59 AM, Stephen Smalley wrote:
>> On 2/10/20 2:00 PM, John Johansen wrote:
>>> On 2/10/20 10:32 AM, Casey Schaufler wrote:
>>>> Because attr/context (and later, SO_PEERCONTEXT) are new interfaces
>>>> there is no need to exactly duplicate what is in attr/current (later=

>>>> SO_PEERSEC). I already plan to omit the "mode" component of the
>>>> AppArmor data in the AppArmor hook, as was discussed earlier. I woul=
d
>>>> prefer ASCII, but if AppArmor needs bytestrings, that's what we'll
>>>> have to do.
>>>>
>>>
>>> sadly, to not break userspace its a byte string because that is what =
the path based profile names are. AppArmor does support a more limited no=
n path based profile name but I can't guarantee that is what userspace is=
 using in policy.
>>
>> Ok, so /proc/pid/attr/context and SO_PEERCONTEXT have to be defined as=
 returning bytestrings.
>>
>> So far we've talked about having AppArmor drop the trailing newline, b=
e consistent with regard to whether the terminating NUL is included or ex=
cluded, and drop the mode field from what it returns for /proc/pid/attr/c=
ontext and SO_PEERCONTEXT versus the current /proc/pid/attr/current and S=
O_PEERSEC.=C2=A0 Is that correct?
>>
>> How do we envision a liblsm processing the value returned from /proc/p=
id/attr/context or SO_PEEERCONTEXT?=C2=A0=20

There hasn't been any serious thought put into liblsm. To date
there hasn't been an LSM level interface to worry about except
for /sys/kernel/security/lsm. My notions of what a liblsm ought
provide would seem archaic to most of the people here. I can make
proposals if there's a notion that liblsm makes sense.


>> It can certainly split it up per LSM.=C2=A0 But can it then take the a=
pparmor portion of the context and pass that to existing libapparmor inte=
rfaces without breakage?=C2=A0 Or will the changes to the format describe=
d above create issues there?
>>
>>
> libapparmor can handle the changes. It does not require the mode string=
, currently anything unconfined does not include it, and we have already =
done experiments with dropping it in other cases. The trailing '\n' is ha=
ndled conditionally so only if its there; this is well tested as the curr=
ently out of upstream af_unix socket mediation that is used by dbus does =
not include a trailing '\n' on the SO_PEERSEC.

So it doesn't seem that there would be significant difficulties
switching from "current" to "context". It won't be transparent,
but we're providing "display" to address that.


