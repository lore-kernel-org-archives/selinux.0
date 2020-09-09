Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19177C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB35A2078E
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DBLFblvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIIST0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:19:26 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37632
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgIISTN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599675552; bh=r5RA72B8M0PbMZ8OXrxfQa0gOCDGfgumYndjzVpg/ig=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DBLFblvY99sCWN6dVL0AfXDll9Tt7ZA2gvtrhEL+etZfMGpTZAG5ue0PnTOlZwrX3U1864fxRmaqL+BuWrwhaQx3379dcfFs6b4Qczzh6n+m9q7fLTHZEkO65reM4akPq/FRzKZEJHg6LirHoj3Ly2hwJNma0bBnpGe10qiqZzziAXxvdmHdb9ziRktW/driB4LGXlW8EfBmfBqyU+9/pRLpwgz5f62HBNP99yFqEm2wXobO1xMb8KH9uW07+rDORiwvdEIcAJGkGh5gRHXP8eDvSzvf7dUajd9r3MiFFl/ycxpyfVM3BjWws6QUCXXmWS+SdNBRi8kDHdtx622g9g==
X-YMail-OSG: m2I8PoQVM1lqYaCHkEasTGyFyhIFm2YkHLec_faD9uRviX0VwMSZp03xCx8p9El
 LIDgH9o2n6fc7koabZzF9WshiugznbkK321qXIh2o91ESU3BOHDmhs2sXwoQ56IFtNMNrs_6hVHz
 O3AjTTgq.nuLjlw01bcvlyhRWpnOgYuK7PNWe1Agw0RyhB2aaMFZ8guSKYyGGmi9WxKqzRKjnvwA
 4RySW90WqcuaIJj6FUPQRTRZF7rKCieruedWPWZi_R7l_.1D49tKqkcnpLLathK1moO9_km8eYQE
 eHjFsUn8unnKUa7auXkIl0lDo58gft0SHHOm9r32i9EbbQkK6iZtQ2pfs4ZkltpxsFm97.3dEGvG
 tQCw24ypiTYnuA9Gi.RrFufElNiU25ye0vY3EmCEC8rby6ety7wh.LC8IzBTmYHcz9EmKioIVwFR
 Myu9O_e4y2hWfS6Mg9Ul4GGK5Na9bVTvk_srLuFfV_h_AeXBtoP5E7AYu1AkeItINFaP7ODOz.Zw
 czU0RbUfcwSRwmJPEyb5rSO.EBPm9VmPB6Nlw6ZRw2lAWTfc5OPcdb8TVH8ONdnPdCY2mrc8kcah
 AO00miRIj8o8ocghOAKVqZapF5bb749Nle7o1QI0OjhghJh5F3Wz30M4rukWN27S1K.Rs0Fq9SOt
 YLGfRC.fZFilqrqZptXb3736toh3moVjRkeZQ.moQYWyJIh.qiIZ.0Fp_WSQYatCfUbqfScVzO.i
 fLsuJQkOpUx8Sr6dMCWF0ZVGCLxa8S306BJXj6JIBlmo3EaRDai4a7j2Zj00JahT.BJACqMkTLND
 LvTnsCHk4LBAmTS6dk9dQ7yTbJseDBfx0DnWcuiDYQkbXLAf3idbgET3AYcu3thygdZw5uQxv1Gd
 OrzhDalr4QRBG.gNYyOiOATgFFir6znjg5EsPDQ5NRhxXe9pELvM_8ZgQaWBDPLpddbQ3sgNH3Zq
 WqUDl_DusR4K7hfPNaXUKIjHGIzzFstJCBkgekdUmxM2tB1n17upy95MH5.LGfuRZXJOdFJQu7c7
 yog_mWcOLrYeClnaECY1rkdDqyr7f70Cn0KJw6W04lMfm1dDAz.2JNO8GsTnwFK2ScPaUJWy3rKE
 qPrMuMaH4r6FgoR_cAAtHT6Fbf0aBohINd6cM9uUkdpKwKAkcFUnRScWnFlYG3lX_qmWksOOMDz_
 F0kbQMvOLe4Y3bmul4hzA5D4v2jIgAswG4NcTCotitiLWeBYfpkiR8TtkRIG9Vawbfk6R8RK_avH
 DkqgUKZre4cFrKc69QCPpAxXPwwxN_ajfV2tyOOqgcyPh6g47lRGcmRb.YnXkj8nPCrFzLcc9Ce5
 t6aCUvmKkGceOKxPaEc9HmnREbZFX9ZIh1zZKgPz0hMw6pJMTOnMbC42jls3.QrjsLN.Q64g9L4w
 2ttYH9b0Q9PiP730Dr._N96cobRfIOD1uDkTaaXZwYqfEpOy_T6Cx6F9mPkXNZqGl2U4mS4OWq.v
 GQLCIRRRviGx64ZV1HImjF_cDrdhamJXEVCTNKMDG0J.FZDOwFbcZGVcXT9f8MRcPp14gqysCcG2
 4xUvtP5fMEJioBJT7.qqItTGAvGz5_BUpRHmdLA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Sep 2020 18:19:12 +0000
Received: by smtp420.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9d5afc86355914571948f120000f50ab;
          Wed, 09 Sep 2020 18:19:06 +0000 (UTC)
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
 <c5bef71e-6d78-2058-bcaa-8497c76d7375@schaufler-ca.com>
 <b320f0f6-02db-95a5-acc5-cadd5dbb57dc@canonical.com>
 <CAEjxPJ6wFJz935RR_1u+-EjAw3VMv4nabo-Za_OqkZGJuNS5Sg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <258ef772-0560-3fc3-9b9b-89941a7713fd@schaufler-ca.com>
Date:   Wed, 9 Sep 2020 11:19:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6wFJz935RR_1u+-EjAw3VMv4nabo-Za_OqkZGJuNS5Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16583 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/9/2020 6:19 AM, Stephen Smalley wrote:
> On Tue, Sep 8, 2020 at 8:21 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 9/8/20 4:37 PM, Casey Schaufler wrote:
>>> On 9/8/2020 6:35 AM, Stephen Smalley wrote:
>>>> On Mon, Sep 7, 2020 at 9:28 PM Stephen Smalley
>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>> On Sat, Sep 5, 2020 at 3:07 PM John Johansen
>>>>> <john.johansen@canonical.com> wrote:
>>>>>> On 9/5/20 11:13 AM, Casey Schaufler wrote:
>>>>>>> On 9/5/2020 6:25 AM, Paul Moore wrote:
>>>>>>>> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>>> On 9/4/2020 2:53 PM, Paul Moore wrote:
>>>>>>>>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
>>>>>>>> ...
>>>>>>>>
>>>>>>>>>> I understand the concerns you mention, they are all valid as far as
>>>>>>>>>> I'm concerned, but I think we are going to get burned by this code as
>>>>>>>>>> it currently stands.
>>>>>>>>> Yes, I can see that. We're getting burned by the non-extensibility
>>>>>>>>> of secids. It will take someone smarter than me to figure out how to
>>>>>>>>> fit N secids into 32bits without danger of either failure or memory
>>>>>>>>> allocation.
>>>>>>>> Sooo what are the next steps here?  It sounds like there is some
>>>>>>>> agreement that the currently proposed unix_skb_params approach is a
>>>>>>>> problem, but it also sounds like you just want to merge it anyway?
>>>>>>> There are real problems with all the approaches. This is by far the
>>>>>>> least invasive of the lot. If this is acceptable for now I will commit
>>>>>>> to including the dynamic allocation version in the full stacking
>>>>>>> (e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
>>>>>>> to take even longer than it already has. Sigh.
>>>>>>>
>>>>>>>
>>>>>>>> I was sorta hoping for something a bit better.
>>>>>>> I will be looking at alternatives. I am very much open to suggestions.
>>>>>>> I'm not even 100% convinced that Stephen's objections to my separate
>>>>>>> allocation strategy outweigh its advantages. If you have an opinion on
>>>>>>> that, I'd love to hear it.
>>>>>>>
>>>>>> fwiw I prefer the separate allocation strategy, but as you have already
>>>>>> said it trading off one set of problems for another. I would rather see
>>>>>> this move forward and one set of trade offs isn't significantly worse
>>>>>> than the other to me so, either wfm.
>>>>> I remain unclear that AppArmor needs this patch at all even when
>>>>> support for SO_PEERSEC lands.
>>>>> Contrary to the patch description, it is about supporting SCM_SECURITY
>>>>> for datagram not SO_PEERSEC.  And I don't know of any actual users of
>>>>> SCM_SECURITY even for SELinux, just SO_PEERSEC.
>>>> I remembered that systemd once tried using SCM_SECURITY but that was a
>>>> bug since systemd was using it with stream sockets and that wasn't
>>>> supported by the kernel at the time,
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1224211, so systemd
>>>> switched over to using SO_PEERSEC.  Subsequently I did fix
>>>> SCM_SECURITY to work with stream sockets via kernel commit
>>>> 37a9a8df8ce9de6ea73349c9ac8bdf6ba4ec4f70 but SO_PEERSEC is still
>>>> preferred.  Looking around, I see that there is still one usage of
>>>> SCM_SECURITY in systemd-journald but it doesn't seem to be required
>>>> (if provided, journald will pass the label along but nothing seems to
>>>> depend on it AFAICT).  In any event, I don't believe this patch is
>>>> needed to support stacking AppArmor.
>>> Stephen is, as is so often the case, correct. AppArmor has a stub
>>> socket_getpeersec_dgram() that gets removed in patch 23. If I remove
>> right but as I said before this is coming, I have been playing with
>> it and have code. So the series doesn't need it today but sooner than
>> later it will be needed

Is sooner like 5.10, or 5.15? It matters.

> I don't understand why.  Is there a userspace component that relies on
> SCM_SECURITY today for anything real (more than just blindly passing
> it along and maybe writing to a log somewhere)?  And this doesn't
> provide support for a composite SCM_SECURITY or SCM_CONTEXT, so it
> doesn't really solve the stacking problem for it anyway.  What am I
> missing?  Why do you care about this patch?
