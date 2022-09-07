Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17430C38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 23:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIGX0s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGX0q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 19:26:46 -0400
Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE78D3D4
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662593204; bh=KWop53vG/sLBS0nsAgbAz6nRcJjbS2yOSuGZrrVTAhI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MHtsI3p5+lzNwNvvgA7u9WYVw0a6URnK+y/XhJtvrZnFMjVVHPO08LeGVch40BN71DdB6oUgAz7aQAPDgi3vgyGfs8kTLe270ZvVaEDJT65WcIN7cWgbCaKBe4SSIDXuHyjUZSWHY4D47TQqrCxgjBnuGQhW5C3OiT3nusYde8UmqgWUwziOKxv9W29sXtkyQk5/1gielIX3i0qZkCj9Emcpy2HmBYDf0Wng6v3ojz1+uH6mJV/UO5bbLZReCU4VeCMtLLjbNq9lnDOyqWDlvLe9BGxiRDueZKfumxXjWMI1tl5BempVnmQPeUYWkYlHfSwi6ly+BloMs6p0WPCluw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662593204; bh=TbicouqwPFit54ZldbfbtkaGwDqBLXxFpOKsFhoXaEU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=p3bsFrrz0ym16gCU5a1El3xgBXu8XWOY4rESl4PQQC9clJYvIt5o8uOSue1fVd8Hi0t5MgBrzb2PX+CbKKlfQfkw2IJ2YQreuNFWYZFN8ssyhCCmwfNwzMWuCaNS3n4do5enjPJLXHNBWJsZd5UXBy6dz0TlpFXSJqiHjMV26pGLWUt9UheDXbkaqK5hTO/Jf8/6n1UOMOqpa55h4ceuAwnScgJlItHCrdPoMDz+BOzIYswLyJFv7kqOwo7vOynNIu3SLWLU8wx1IfxXXL9KVJasKC4dJGMd97cxrWBJdbYrABVKW6QNOs3vKmVsjxwFFC3piH3F0mcHwLNpBeRgbw==
X-YMail-OSG: kIL9HSwVM1nFyDiXBtQAxki6xm_LNt.r.nn1qqJbrQeROEEBoXmpOX7QDRhG4Yc
 4J8c1u6XcpW77yIIfcK7N1flm39ISvngo2Kj2RmnEpMvXzpPst5_D35vnQXSCqhbdcEVjmgTnJS1
 c.4vkyliPxtqUVtC8ruqsiLdMTWN1R0dRuGcY6mw.PK0T44A9HB6pWAgDn1Sjl_Idz.LVjaAhqTg
 5zKFkV_IWjVBvSqBZls0_Fv0EGh89CcPZ3jhqEuNboNEmCTF6YnazPDscvyjOcV4zLLPtwlPs7nm
 o8UXKSh30mzB_jy1Z2UB8QMvFbaYTzh9LUcSrbaD669Fh9w7V6XONNq0PsparTWBshpiWao8CsK6
 2c2zQ9FfIYK6yMk70nDykEgsyP0paZcTL1z8tGBy3ASZiOZWoYcxUjCwcsNjiuG_JLU1kJW8.5XI
 7HQqMrQODF3Emjt4moZWeLGEUbt39gBUjxHmw6EA2I9ZbZLAMYRlyeLWn.C2eMBm32gnoipw7Ft6
 L9h3FIp5yjaYJtASwmrWcwUD2.BuhrGuCSjkOPsxTx9nl9sbWXq07iKIyW.I.DxDTVF8Xli65rAK
 IHySkyJbkoqUpdD8IVVgNEyPOC__AT7fbTFtc_veRNSXmEQqOTLbwDjvAF0IYvHmpRZyziRFe4Yn
 SY1voGckn9i2OHFLn0Zj7RzSvWumwnQ2.CEsnk_SFWpwclGv01ihRaijLVLiZPKIyRbzUIoaDxyO
 b75I97pK5XqMaqk0PBxmMSYhYPHqeI8bg75ErqwsEnPZ37jym6YqSQoC0r8LmB6ESNQdjuC0Q2BJ
 iUcFBjqTKBpPdf6cM.vRwZXSRi7i0g6zlxGnWExi.cI.C0pXaoswVQ1P2i.prkarvZK155Yp9Z72
 CekFAzpD_TRVD0c_EIyPsAqMQip7zILS36IneiaMiiP.V4YfkFSMNcSrGmEKb7LzzpXg4swREjPY
 XIu7i2aGNMeNHrsf00PMozKVkxUPQNN7bG7p2eKBymXmXOEGBvdf3miwP.XNZipzlvuV3LuUo1mR
 GpRJfpChW0Aqfx1LJUASrZbEtW_AkPAzvUMsqjbjCVvnCPs0d7jd02obtomr79gIJySelPKvR1cg
 8CCaubfEurckXemYNG49CrXmgJPc0I4lRRWSwugyQyBvyWGJ6ZQ5uukMd8Eu9f0DNs67rlKMGDYl
 Hnv72smDYFoD0.Hb.e4DJuSU6hYSc1.oLZWQhsGtJLZJ7Z3dI1Lvzi2QKnrRhg0tvaAYnvQbAFgq
 5p50c9isFDSbnXM7MztXrXsPT3Zrlbqe7D4cQbVxOg_tlrtA6igjjmH749X9E32m.KNK.wFmVJ.6
 nNV0Zy_HZ8PQo2W0U6B4DlGgtyWrsjc8aTsUXoWBAS6s7Kq0JS4wvz9zukrQr.iEjdBZjt5ol8XS
 QUNyAM5W0offL4k8naxa_RxqLi9kL._a023kmctOa40DHhKMGuVNDJNKZYdqsKmQrUS.mwacn54k
 vYUVbujTyO_l7ksfbLuZLZutXwDcXbDwWToUC6k2XSq05MFR6lIOWtoUzObp_ZTkSU61p7reOMQc
 fmeYwH9degPEAicQzk7KOHKhz5pnOh0kRAoKgmNdOOh0_czqhgDmkoKi5s0aNNKguymuOMbcns_2
 _bgr_xN9.yZAZxn2115EeeE5wmXsNP25Td8YcqdruQzgDOEeq.cTzioU4G9X.4bROnj8mb_3.c3i
 GIleppEPZdvYvIrk8rMxjfxRLPHxIqIxIlsmHWHme44AUkwvBdHFkeqZQC8.aEH6NKENV1bBi9wL
 MMmnM1YP5RGwh6MRk6n_aAKu6C2m77KKRb0Bs5UPk3R2n0_qkG3nfD2Y8uT.hQrDgYxYcErhBJjE
 _1FEtadyigmbP1DP8mdXF4J07Jf5S9zuiyxXU1UO89e9JNff54ZFiDLEuun0b6kuIrNIt2aSNszt
 x7X5_6WSeG5Tp8ZR7_ygiEI53NYM0O6BUYPnWUMrm01Pp8mcl1A9Y3co9cs2XRqHPPo8lnB2E4dV
 D1tgDxuCIRWuZdVc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 23:26:44 +0000
Received: by hermes--production-bf1-64b498bbdd-gdn7j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f0a7e7268f756a03a4c3427a7d052d48;
          Wed, 07 Sep 2022 23:26:40 +0000 (UTC)
Message-ID: <7d8d6c93-4ced-3878-e4e3-99e0a6a36e31@schaufler-ca.com>
Date:   Wed, 7 Sep 2022 16:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <9f79faa7-0d6a-c023-4561-15a261d4c60d@schaufler-ca.com>
 <CAHC9VhQBHNmYf3vMSFrcw_=a=LaqoxVLqFirbMfSZeHqL5fxWQ@mail.gmail.com>
 <9c89b121-8dbd-dfa8-e427-8b90d1333e36@schaufler-ca.com>
 <CAHC9VhTLe4F3gXeNHZL8vCgEsz+m5-vbkihFcpzbB+F0M1TNbw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTLe4F3gXeNHZL8vCgEsz+m5-vbkihFcpzbB+F0M1TNbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/2022 4:04 PM, Paul Moore wrote:
> On Wed, Sep 7, 2022 at 1:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2022 8:13 AM, Paul Moore wrote:
>>> On Tue, Sep 6, 2022 at 8:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/6/2022 4:24 PM, Paul Moore wrote:
>>>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>>>>>>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
>>>>>>>>> up nicely and I believe that all comments on the integrity code have been
>>>>>>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>>>>>>>>> There are serious binder changes, but I think they address issues beyond
>>>>>>>>> the needs of stacking. Changes outside these areas are pretty well limited
>>>>>>>>> to LSM interface improvements.
>>>>>>>> The LSM stacking patches are near the very top of my list to review
>>>>>>>> once the merge window clears, the io_uring fixes are in (bug fix), and
>>>>>>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
>>>>>>>> and SCTP stuff can be finished up in the next week or two.
>>>>>>>>
>>>>>>>> Since I'm the designated first stuckee now for the stacking stuff I
>>>>>>>> want to go back through everything with fresh eyes, which probably
>>>>>>>> isn't a bad idea since it has been a while since I looked at the full
>>>>>>>> patchset from bottom to top.  I can tell you that I've never been
>>>>>>>> really excited about the /proc changes, and believe it or not I've
>>>>>>>> been thinking about those a fair amount since James asked me to start
>>>>>>>> maintaining the LSM.  I don't want to get into any detail until I've
>>>>>>>> had a chance to look over everything again, but just a heads-up that
>>>>>>>> I'm not too excited about those bits.
>>>>>>> As I mentioned above, I don't really like the stuff that one has to do
>>>>>>> to support LSM stacking on the existing /proc interfaces, the
>>>>>>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
>>>>>>> have for retrofitting multiple LSMs into those interfaces and I think
>>>>>>> we can all agree it's not a great API.  Considering that applications
>>>>>>> that wish to become simultaneous multi-LSM aware are going to need
>>>>>>> modification anyway, let's take a step back and see if we can do this
>>>>>>> with a more sensible API.
>>>>>> This is a compound problem. Some applications, including systemd and dbus,
>>>>>> will require modification to completely support multiple concurrent LSMs
>>>>>> in the long term. This will certainly be the case should someone be wild
>>>>>> and crazy enough to use Smack and SELinux together. Even with the (Smack or
>>>>>> SELinux) and AppArmor case the ps(1) command should be educated about the
>>>>>> possibility of multiple "current" values. However, in a container world,
>>>>>> where an Android container can run on an Ubuntu system, the presence of
>>>>>> AppArmor on the base system is completely uninteresting to the SELinux
>>>>>> aware applications in the container. This is a real use case.
>>>>> If you are running AppArmor on the host system and SELinux in a
>>>>> container you are likely going to have some *very* bizarre behavior as
>>>>> the SELinux policy you load in the container will apply to the entire
>>>>> system, including processes which started *before* the SELinux policy
>>>>> was loaded.  While I understand the point you are trying to make, I
>>>>> don't believe the example you chose is going to work without a lot of
>>>>> other changes.
>>>> I don't use it myself, but I know it's frighteningly popular.
>>> All right, I'm going to call your bluff here - who are these people
>>> running AppArmor on the host and SELinux in a container?  What policy
>>> are they using, it's surely not an unmodified Fedora/RHEL or upstream
>>> refpol policy?  Do they run in enforcing mode without massive
>>> permissions granted to kernel_t (I'm guessing all of the host
>>> applications would appear as kernel_t)?  How do you handle multiple
>>> SELinux containers?
>> Beats me. All that SELinux policy stuff is over my head. ;)
>>
>> Seriously, once they got the stacking patches applied they thanked
>> me for the help and disappeared until they decided to update the
>> kernel version and asked for help with the next round of patches.
>> They told me what they wanted to do, which was to run Android in
>> a container, but how they accomplished it was a set of details they
>> didn't share. I assume that you are right that they had to do
>> horrible things to either AppArmor or SELinux policy, or maybe both.
>> I also assume they wanted this as an environment to develop Android
>> applications, and may not have cared much about actual enforcement.
>> But they are happy users.
>>
>>> I'm aware of *one* use case where SELinux is run in a container and
>>> that required a number of careful constraints on the use case and a
>>> good deal of hacking to enable.  I'm sure there are definitely people
>>> that *want* this, especially in the context of Ubuntu, but I really
>>> doubt this is in widespread use today.
>> What I know is that there is a community out there using it. I think
>> you're right that the way they're using it would be displeasing to
>> most of us.
> Based on other comments in this thread it doesn't appear that there is
> anyone using it,

Let's just discard that use case then.

>  or at least not a significant percentage of users.

Sure.

>   I
> get that sometimes we need to interpolate/extrapolate a bit to
> understand what users are actually doing, especially with certain
> security-focused users, but I think you extrapolated (or assumed) a
> bit too much in this case.

Let's just assume that.

>   Please be more clear when you are
> speculating in the future, there may be folks reading these mailing
> lists that don't have the background or understanding to tell
> assumptions from actual truth.

I erred in siting an example for which I am not positioned to provide
backup detail. My bad.


