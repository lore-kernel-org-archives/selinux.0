Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929EC07545
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 15:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJYPTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjJYPTk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 11:19:40 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E312F
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698247177; bh=m1/30qna0rd38NEzQlZsDzeCUyP9P3MKgm9JFjG/u30=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JFvdGUDLlaK+F2CnR0PPqmgKJ4rC6H1CSC5PuGTvFduf+z4mS2jF2Io3KC73FntP0Ic1Jeu62xHnfq4FNsX8yUF81nmvklIRCEjpZoqyHS7WwKS8mjdtgydCtjPLNuEPMdJ7E6hGCtf6TYoo4WSdDrUDEnff/B0DnRCEhb9punXj8PO/t0qdizsowQVnrcLClxhSzoJbDY+l+J62/s128IJTKg9SFUSz/zH8rM2ytgA5EWA1VBxoZSTeK/wb2jV6iCtGekjkTtf0cTEgZcZSRKcw+KnZG09+S9CMZwf53oWRaWTE9nY7hWk6iF+q8SphOQqQiJc6PmEEbLS09P0kPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698247177; bh=AJE08/vzZyE23+24AxR1izbHVSJQ1LVGOIQaE545DXM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C9bwvBQA+SdTDZaWyTXSx+POOplC5AwFmqTq8uM7ki/ysGP4b6+tsqui63oZhprGYJotKazmOzLeD+EIE+1IWl176YooOJLaiDuPmQ5qyJpi+SvRazfB/iyUaNNjxWOXLY8E09ZmiJBZw4DTu7TfjGA97uMopbpWNAg4/2sh5FuEC/mpLj9cZBCWnMtMygBN/dPNORgT5kYJ9R85dQlZvenedDNDX1Yku5nTQ1CKMJIkQkdGMC7cpyJ/8cOKGOFM5yAOJy5v5GDppIPqnsalI0O0S2EmDsK2q17Z8KgCYcaBivuo2EwEdOBrqWaUCsbH2sjy9FMsAY0DAXbnT7Ct3g==
X-YMail-OSG: z1qmn7sVM1lbID6v2t6GerKcT05eRnkQtl10IpwY.zTUC7E1iknU2geR_9KQ4LM
 QY1h39vTsFFFsaxini7RKKVfZeo.2yl1JkcEyH.JgEGk0US2Cv4fxhzQ90ZKH82Pyo6u4D78P3Ro
 cXDMx.rcWS1vvpSTK.rTnf9nkF0a6ue_ddkHATVqiCZ1Nw3vflPVVhQBIRZaE7aAz2BWQ8TV1lCV
 gzVOqZCHCMlwVqBs1eOLnko6a5K9kWDIQfTdfJQg4yoLgz_0FKab5fXYowx.PSOp.kA63dqsCC7h
 klEHyLwKWOwAYRKaAV6oQw0DViNrrlC3.PDg24qp3gEzYymYF2fZ4zyuM.rGbNbq_4CaSMfFGyGP
 VjF1YG3J15pPb.RiJ.chZdQCIyjr4hqDT6UOpaiAPh97Ciz5iBKcqWjvZ2mfgsM8UNeqGBL3CCJj
 vBsZPHD5BE5UX8qdu.pyUsHTz.neiuXJ.FxKZ4qSP4VcuzIDewHdaxR4RtMKPRB6oSKcGCtdEH6b
 Om_i2wJL_BUmg_RB4xojUCvAi4KX2fcnjQmFPSRx4zOGp.7YQVvDEAhNsl1W7CaeBMzUKyg.HEcr
 K2sL01CnKRWSdJPYT1wP8EAvSvmusQZtKIPx1W1WfVIPMbUcSpwqGIj0teQI6cow3uZSUp82gUBT
 2QQ6zOEZR3OFg17iCGBvZy1SyLtRyxsOcnLKggrxjQV9vUF150JnSQABEv91DpPZAtVvYw4rsMph
 mhYFpA9hmWeWm6j59XNa856nfvXEsuyc_8mRAMMaERC_fyQOHWU060IksZJkQZbriRN_qTA6_MZH
 wng_QU58ezqbm7_CYnuzeWHwRzKig9AAzlqSP0nkT0yC9YSUPC.GMLKUhVDneNPzcomqYx0oyMyb
 oJUj6nUK0maqVyKuA2YhrfPtiPD8I5_JHzhGPLdVtUp7i5bSQItaWGXUrAddlqfgvos3zOravufg
 g8GLFPiqPjdS3EN4TBQk9ukuYedPyGPvY5.Q_rgJVwfAF0GQUrZlFYU14gDv5JIf9o615hvP.q1Z
 Tud.s1iPU3PnjHHKQ0OOwKqivYzUkiHy8d0irKlziqJ5msejs1vC6y_Ed3RHDFUP7gs5wcGrum6K
 RJzrizGgo.vgSsHgTG1dcOx9fjYO611x_gP9thAo5IrC_eT9Y7lZqeTa.fw.TF1Ai25EU2.RHRPE
 ddQrEoWiEQOaTSjumlZF2Rw2ICM.8VGK3PsNDjjYcGnF4cKxJhW.V3YVTv3ECCaUomZUWlX8FH3K
 xl8ZPjEEJMTrEd5mGpEFhRDogv1jQkPjJNw1oV17HgKJMIRl.a7dO_gEPsWDTb97HeX.C7IW_mEM
 iL6Ok.pVtORWF6mLDqvl4fcmAjfmIGzV8ddLmIAZkAyEMoODOd_juR3B_uOWqqWa6Vp9BcrlYKZh
 FBNQVmE6n6fIF_EaZs4D7l8Xm6lYfE.eA_owtYUnGOj_X0WpADq7uZi.eleEIDlFXAx3Je9GobbL
 Nj3Xp67cgLjZTJuAxodObv679uJk5HoxsZjvOjWf_Cz.oLa0Ta85a7EPEYQ1rIxaJ5dm1xGWFaJD
 U9Y7R2OyQboOUtELjJJD7CxXoM9yqN.ktaeWjLQgBekVTE7Hu_Q1DcUcbJJyJK1YdqZJAFQLYyDd
 sKosZYV0V0XYUsNMgFugWTzRCmfV9QV7LiKJ1DxjAuE2V722udFZiNmw6ikppbjMy_.lDvUos0eE
 HpwmMZvWRP134bVoaNfGTTB86fA61PO4lqIurkBqjSaesGIeeadaE1SsQC8Z.8YCZ.cXdv_HeZPY
 emJxuYUOgsfbImPe3CxKmY4lXpBt2tgz2_z6Vz_NiPZVOvshAXCglYyNBwBcgZBTQqQP1QtclNGl
 blWrqwBMbDVrll8VuLi042hsj4x1HE3yk_W.m7FSgtxLK98h7.TAMZ27wcS11vEdLlljiJ_fljgH
 kq4YOJfHAUnVqm5dLnB02a46m8iQqpmmufdno40H1yK7TvJc8GLMxVe51FCFr_FtFEmFA5nmVMwp
 adfBzs86yYPf.LiXICwMJfAB5C8r1O2HS9vaUvh2BnuPr.HP7Swh2QAQK95m6q7ZP9IStM6bi2zJ
 0gqQGJPZ1qinTo0JrEvdBUSKpiVO5oMxBuGkRqRD3FjLIzRQ8k3VvYQOe.eUTjFw2OQd0WOoPT9b
 WoVDYOuxyKVSnsa4rRTwIjGZwLzkcUmN6LH37NrJ8g3p3O29Xoq7H7jL.0gddbGHaDVaIe9ZV4mM
 edX7qhfh.I9vWNeOb93opLIltcxlaTuqrGMxej.4ndJ2UQyvYUcoEKxfVLkXZBcnckvmHA0aFJiM
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f4170662-dc9b-4b34-bcae-b330ac052bb8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Oct 2023 15:19:37 +0000
Received: by hermes--production-ne1-68668bc7f7-j2rhn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2801747aa7b49229e5d98b03566bac8;
          Wed, 25 Oct 2023 15:19:33 +0000 (UTC)
Message-ID: <5df43557-7261-47a1-9066-b7ba42145af0@schaufler-ca.com>
Date:   Wed, 25 Oct 2023 08:19:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] lsm: cleanup the size counters in
 security_getselfattr()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-5-paul@paul-moore.com>
 <8fcaab11-6340-4056-b9e0-4650be05b270@schaufler-ca.com>
 <CAHC9VhR_Mm0aZKafhhaQHnasU_30Uvy9zUvEMs9COzh22QSNWw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR_Mm0aZKafhhaQHnasU_30Uvy9zUvEMs9COzh22QSNWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/2023 6:43 PM, Paul Moore wrote:
> On Tue, Oct 24, 2023 at 6:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/24/2023 2:35 PM, Paul Moore wrote:
>>> Zero out all of the size counters in the -E2BIG case (buffer too
>>> small) to help make the current code a bit more robust in the face of
>>> future code changes.
>> I don't see how this change would have the described effect.
>> What it looks like it would do is change the return from -E2BIG
>> to 0, which would not have the desired result.
> When @toobig is true, which it will be when one of the individual LSMs
> return -E2BIG, the return value of security_getselfattr() is fixed to
> -E2BIG (check the if-statements at the end of the function).  Setting
> @rc to zero as in this patch simply preserves some sanity in the
> @count variable as we are no longer subtracting the E2BIG errno from
> the @count value.  Granted, in the @toobig case, @count doesn't do
> anything meaningful, but I believe this does harden the code against
> future changes.
>
> Look at the discussion between Mickaël and I in the v15 04/11 patch
> for more background.
>
> https://lore.kernel.org/linux-security-module/20230912205658.3432-5-casey@schaufler-ca.com

OK. My bad for not looking beyond the patch.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  security/security.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 988483fcf153..9c63acded4ee 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -3951,8 +3951,9 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>>>                       continue;
>>>               }
>>>               if (rc == -E2BIG) {
>>> -                     toobig = true;
>>> +                     rc = 0;
>>>                       left = 0;
>>> +                     toobig = true;
>>>               } else if (rc < 0)
>>>                       return rc;
>>>               else
