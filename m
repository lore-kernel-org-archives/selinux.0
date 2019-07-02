Return-Path: <SRS0=labB=U7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF5C5B578
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 01:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70CE20881
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 01:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s3/Cnucs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBBU0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:20:26 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:33485
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfGBBU0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jul 2019 21:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562030424; bh=LNzaRmwkd4m3BF5hhhViPC5gXJtwhIetNyK7P25Cnqs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=s3/CnucsP0uTTaZSYjUuBeo9asxPQl9en1R91bp2kFYgCNkNDcVMFwZmCFklw3uUoIYi8F9Yt0fxJnVvRAfCKgHYXs7JQCDDDWgZF6omGTGy7g5dDoPAL4SL00BczmOfsFkUE9/ivWurED5uHVM6YmsFWGL5gZT68czAkfIuj6X6Si5pmSkukyqEEqenrEHo2dlSvJyiSGgFEH7SovoEaGnC6hksX2C9LPMUPnEJvvifUpaqReze+7GsTYrSpTR9lMb1VnxjeVCrBQRT+1txtIDfXNnP5FlIcR4XAVZKgoULfsC7o/FCNuavDSsbYf3D/fqmkzOXNmB1I3gtoEgyuw==
X-YMail-OSG: _f.h9IMVM1k1cy_.CMUqhVywJIeKbW0GHk5pQt4UEHDKF9Wd3wTr1D1tFyzt0rT
 SWvoFDnYM0pl1fBYDFno0Vp6ABDUeu7HoYOPisGlx0UOODOYAQ3ONFQEiRzoXm_cKFmex.b8e_Dm
 5.ViYqDZtcAdxPK0GxR28yl2tjUnMZarQ_cV.fVcLjjKwBhIJk4OZ1gtc6i.y74BDauw1d2Tv.ei
 upcfyKoUUoVxYexRVfpZeuuAf7SIqeMq6VrAXsaMKCvUrCeSgiT7IvdxJlP6g3Hsib.QwENetELz
 2UKtCn6wiY_8NYQI.vFjDafnlLsfi0DbVJ9UuJAqrXcpGokyJwatlbvgpaExahoPVc2P9OfyzQGI
 1NIemq1RQ3rqQHjd1dkPeSWnuSQaFXYx5jmvHOfJU3tvhpv_dOK4W7nQ9PDAZhRvQyPYOZyHVx4i
 3424KDX.G7ls7AMlbrsf9AX95h3DE4PVp8vA4kJqmeuNC6L466J1Rj.FfTVi8.gtYuag0HlArvOf
 P.mv3B1krTnOr0KIQG3i87UkumL9HeWEIUzrpyTWmGxpB6P2QsUS9hALowfmpCm75p1lAw6c2ThT
 IrslmQeVRalXVYfP_wvTCwp2STI2No1tOXGCcSio.npDeaGZ9m0NSWIAcCJ4aB1DGMomC58fWykJ
 59pefZTBx4kiDqizZswor2glFdSGD_uwlp5bmGHO5FO5AKS2k_SI3IKia3LVQco4f1e3q9oSC29b
 n3GIRe.V8fXt69uLs9TUDVRPXF6Ego8EvqpTcJi0AabCCRO9qFxKV16M5_jc6.a.ckX3gIU9RQ23
 20QBTuEQ_pzrVz3JDqOuOMkaBBlXkZXoGYdtxVSNEwQKyCYtj1H1U4u1X.A3A_8ntbC8rafIU3HU
 sCG_6KmmpU0ejyDEEFmruKeFdy4fAX5C636vEQL3QpQlWNo4Xh2bnFfI9yMFIoXuZtgArBrWoi8t
 jJU4ASOUUGn17ySU40.L2qwZ50yabo7dboWIIbyVQ9U7cGSImiKIibq8mu3DBHvVB3tOmThP5wan
 v36M7.hE_vsiTZONr_amoyyzoXVO116o_X2zZknKDkdXNsRuw_KO2BjWnN_PBrntYfzCclZBtHlj
 sGM.xgGgc4VNq6WC2qPYrd2BW.HaBRFQwtyWiJf0w92Irlr_McQaI1MvYiTIOnmSPElhjDsoab33
 PO6nKcIeR9qykrfSxMeHzNj98Uyod.izRpq4jbuHKgaQMsc6k.38FbC_LP1Us7gJwyhmtXSLiiFO
 irAPYk6nlUqgwSzalyKNvrwM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 2 Jul 2019 01:20:24 +0000
Received: by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d4851a05906f252b518981b178ef2e5;
          Tue, 02 Jul 2019 01:20:22 +0000 (UTC)
Subject: Re: Fwd: [PATCH v4 15/23] LSM: Specify which LSM to display
To:     James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, keescook@chromium.org,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com>
 <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov>
 <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com>
 <CAB9W1A1nwE7WBZqTe-GV8xNb83_B2ybV7cco++nfMjtDz9NJrg@mail.gmail.com>
 <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
 <alpine.LRH.2.21.1907011745480.13468@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <8f860da5-6323-88d8-8b72-14ffaeac6a83@schaufler-ca.com>
Date:   Mon, 1 Jul 2019 18:20:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907011745480.13468@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/1/2019 5:49 PM, James Morris wrote:
> On Fri, 28 Jun 2019, Stephen Smalley wrote:
>
>>> Balancing backward compatibility with new behavior is hard!
>>> What would you suggest for audit logs? Should we put all LSM
>>> data in every record? Is NFS a concern for anyone not using
>>> SELinux?
>> Yes to all on audit if stacking is going to be real.  And yes, I think=

>> other security modules will care about NFS if they are serious.
> Agreed.
>
> There must better way to approach this, somehow...

It not like I haven't proposed a number of mechanisms!
The "display" mechanism has the best backward compatibility
story, at the cost of being awkward/dangerous in the face of
sophisticated user space environments. A combined string
(smack=3D'System",AppArmor=3D'unconfined') sucks at compatibility,
but provides the best information.

Right now I'm looking at a way to prevent internal confusion.
I think that may be possible.

I'll point out that lib<lsm> has the option of verifying
the display before doing scary writes, but that's a lot of
work that no one is looking forward to.


