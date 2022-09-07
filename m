Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71118C54EE9
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiIGRIz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIGRIx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 13:08:53 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DAEBB917
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662570531; bh=p8geViBUQgHjxbBHxKlAJZFl5Oyzo+TzWHwV80+ZUww=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DCO6C6J87t+PWQGTweFDAaf7KPlzsHn4b5axIfJa3JNEYBdj2KypuKcP+OoLiLzPt2mSq6xgMtEYCscIgJBAX0kDFFh/ZodOa8GQ3oQ/2GwtUYbqVa/bOgP4SbV9jsez9L10HNrzvfhMuLdkHNh391l0PuwN1bpkUzFyhIQMpvZOyRAg0iZlLwYTxYyVHfQ7xhADbyVn0Md3kUcg/E47d66707bEAiBoFPwQ6fvuUH3HpP8WS+OBOtXF5mVlATWbPh4i+gp3RmXifrGmjN1E1/U5gVftzrz7XrzhFNdoJY/IVsm5LS0Wt0tGCbzMIRWzxEtiznL62kPCyjFyorvKrg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662570531; bh=7fN3aWzuke5nB7jWccihJrftpFOac5foJ/ex7Yf6k8s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=s9X6H410i4cEpubTs0i7FXEA9Bwy6i3GMNTsqBg+I8CQn8dHJt5otkY/e1o6feX6gfDIVmU3ri5oGZLuZl3mYEIGsIKlxLApA3L/TZNZ0P97TJIRJ6xti8gNFslu3h19m4kQQxAiN5vUVQa6SXQuyJsE7OaeA5W2XnjTOLM7RgOeyqv0FjsPDKrZrNWYWTCRhCWHzJlrIJ1s3AzkXAUrZy1PyQA2lDJvammz7SZUx5pYm9dfDMEO0oHaPh/oaHS/Jy+Wk1I2XlY/rgRnj9eSMBFWWsnQAcGbcazAgeGWI8oUF+5RpLQRgp6GoqVobJIZsU6N9G5zyKQLbOPz0xwSTQ==
X-YMail-OSG: zxMqVv0VM1lpWQV5ETzV1KvhhB3EJV31fSsjR2PaKUrqtyhHhn0LJVwGV8HWtV2
 tSqJsJ.PPUswqcuBqOTHBtvlSv1.gdBGEVuBvwB_uCBl1UCsSi.hQn_YMYSvTHsvW46Ubvrl2ZsZ
 cNf.dvBG.HmOMxeLSDBgaPY7WNYvpujW3KSSDS8pW24zXA6rldlfF1BiRLvFCwH4sWg3U5_UOR.u
 e45X2zzaduYsQZPwc4vSq0PIfOhYgbKIEbTymF7TOX8ztO.YI5vumPImh6I7n3dg7YYGevvXoros
 E4A4So9k5IhaMkT8fkS5rZLeOju1OQunSDObEu5nw2_P5fMH.vbZ699tPlu_UD2cRQbu5ymUWrWG
 Sjoz_il9nRUDvSHd4SnKfp83PN63sz60wNVzg_s1ysxEPV565_8pcG35OQpD975UDKpuI_oGd_nk
 hbzxXrAgGbIo.i8l3cJg0idwdwI_laFBsAdZhAmNAEYCClOWs9GShpv74jsMCoLjCoo9RK6UMivS
 bw6nAy53APBdT6V62Wc6XqaeU3Q64K_TGG7cUsTB.mX0OmP4OUwEQbo_NygLwadZEamF7V7X7u0d
 jTHa9bXhpixMTHutvGPksDNaebkOdjq0zTvkk7sl4PCBSK0wfmZQgVfrwa9rqI2ToA9TCanHkKOq
 d5SrQ1VteHqY.G03gRiAjh4O35wQnsf1vXjqX8B9JC2rceeWhdV.OOgNs5h1GdlqOVRaHTL9hwxs
 QY.KneZfZstBbBZT1.6cgeVsRn3PpfY15nfCv18SOdszxzSuL4xpGpo6UG7BdA0fkCNBCD__IFjy
 I8om521im4Jq4wQOU.yMcZ0Pnv7rorceJ1iJDt0weWpNyX_u6vTkvPWvWKqGoq.I5IPezHCPpA3K
 4SD2Gd6ZHRuFPku5JODKn0hRm3TbSmYUXnpET3WoGYuO1UGY35CZYcpvC1xqFNptPvJhxJHLQPAs
 q4.hTjQY7Wxq.tsx83vZ5CS2e2JAYkE.KiJbhoJugorDCZZbpatOM5R2bromoK4WIBC9boeAn_3f
 iE2M8qm7y7jZJDmFCLXORIs94iRdHTwuC6ra1OWIQGsXYc4q7qujdBGOtMBt3EBgRkzIaETlBlCH
 nR3URzddmcqUo7MB.dhK.5hnWky8ktKq6_UDo.YGjq4JeksMZPGYkMfAsE22KDTgX8mgxvgVzPsE
 NNnhQ0p.Q79mPM23fkkUQ1RN3OJlxxwUVlzFEYgWbcMuPuyWklvs9vITMouC_MAPMsbRtNlZY9wZ
 HDS1wRoNTQr__Q.fikItWtz3npxlIDjJyWfop9_vP84265VxkrdfnO4tw05HB.YxT82HdBXZr2Ip
 AxWGTPtm3go0FoeJzBjOTdrV._SQJwZ_3DgS.hwhdLSrFzw1ZXHzgsWajgV9o9XXDQetHhgTiZfA
 qNDu5duRAHedp6hinkvAy4BXQ8NZhCjX4ovNm5VzBhW.vcOO9VGpkX8Lqe2l8L_F2LsiRPxkrUha
 y2KeR0BJOL6xEVDTKfhfBWLj3NVgYm9vtcxI24jTTmdSv4gKgFnjvYixWWLz_nLlvTw1orP.HJ1L
 ebdPOYwRAg7eJWgbqS8J925KmJ0UmO1uIJc7PaAkblJlqb7TXKOvcneIo5AdzjIl.kWKto6.OwUx
 kGaOdCWb9lJynlc2Wm3Au2BjYqYMrUcL1hJw7.DoN_any6l8dzvtmXzKr1893xj45ndvO5eBYMBb
 V.kS3tBY1jOgZmmjWJusK.jcnGGeHKadGDIsGxp7.J44bklhomPQew718_4YOTO4rDBsdYn.PiZl
 dLxdKegMWc.FF5frsMvLex826hZ.iWWXWc.Op_nWNw6w2aZKsJypSIN._z3MlPdDfX8DO3LsntSl
 x31gOIgT0NfknQCUC99OhcS4nJhbIP8GRiXAK0k7Z3LB6wue3KJFZN4b9Ie9.D.9WwI8aDcY3ZRh
 gBKGnNqAroJfnMqW6jiissFclq5bt.LxW9AKuZGXRO9lie6m.QXbd8EDekbmOoWulYF9vgQe1oyk
 s6CfZvebiTND3eRTDY8BFFcQXvNlSgPcaHDbTMOV5sLKKFqcKGtobfJ8Skv2VvSfq3YeBz1U2F3p
 BFICFSHh7Vl55.8xaFExiUvlHyaZMG9FFuYBJxsRrWSxP0_DcZBm6aArcaXsUY2FiibfIz2GjTKy
 xnEAlRrpzCn.YdjYt9R77HUYraNEFU9pT6GpH1kEIy.hnexcf5mrUZ27AdmjrGaFjJIp2uzfvWlz
 IppTbvmqqrkiVGoXmXH3SgbbMEAPXaLvEYevKQdFRL04bO41j4X9o2h7GkTNFxj_hyRC.HjgoKoY
 wWybjwZX6BVgQdw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 17:08:51 +0000
Received: by hermes--production-ne1-544744cc75-sp4gl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc460f6a045a6e44cd8e2f061fe81bfa;
          Wed, 07 Sep 2022 17:08:48 +0000 (UTC)
Message-ID: <9c89b121-8dbd-dfa8-e427-8b90d1333e36@schaufler-ca.com>
Date:   Wed, 7 Sep 2022 10:08:47 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQBHNmYf3vMSFrcw_=a=LaqoxVLqFirbMfSZeHqL5fxWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/2022 8:13 AM, Paul Moore wrote:
> On Tue, Sep 6, 2022 at 8:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/6/2022 4:24 PM, Paul Moore wrote:
>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>>>>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
>>>>>>> up nicely and I believe that all comments on the integrity code have been
>>>>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>>>>>>> There are serious binder changes, but I think they address issues beyond
>>>>>>> the needs of stacking. Changes outside these areas are pretty well limited
>>>>>>> to LSM interface improvements.
>>>>>> The LSM stacking patches are near the very top of my list to review
>>>>>> once the merge window clears, the io_uring fixes are in (bug fix), and
>>>>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
>>>>>> and SCTP stuff can be finished up in the next week or two.
>>>>>>
>>>>>> Since I'm the designated first stuckee now for the stacking stuff I
>>>>>> want to go back through everything with fresh eyes, which probably
>>>>>> isn't a bad idea since it has been a while since I looked at the full
>>>>>> patchset from bottom to top.  I can tell you that I've never been
>>>>>> really excited about the /proc changes, and believe it or not I've
>>>>>> been thinking about those a fair amount since James asked me to start
>>>>>> maintaining the LSM.  I don't want to get into any detail until I've
>>>>>> had a chance to look over everything again, but just a heads-up that
>>>>>> I'm not too excited about those bits.
>>>>> As I mentioned above, I don't really like the stuff that one has to do
>>>>> to support LSM stacking on the existing /proc interfaces, the
>>>>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
>>>>> have for retrofitting multiple LSMs into those interfaces and I think
>>>>> we can all agree it's not a great API.  Considering that applications
>>>>> that wish to become simultaneous multi-LSM aware are going to need
>>>>> modification anyway, let's take a step back and see if we can do this
>>>>> with a more sensible API.
>>>> This is a compound problem. Some applications, including systemd and dbus,
>>>> will require modification to completely support multiple concurrent LSMs
>>>> in the long term. This will certainly be the case should someone be wild
>>>> and crazy enough to use Smack and SELinux together. Even with the (Smack or
>>>> SELinux) and AppArmor case the ps(1) command should be educated about the
>>>> possibility of multiple "current" values. However, in a container world,
>>>> where an Android container can run on an Ubuntu system, the presence of
>>>> AppArmor on the base system is completely uninteresting to the SELinux
>>>> aware applications in the container. This is a real use case.
>>> If you are running AppArmor on the host system and SELinux in a
>>> container you are likely going to have some *very* bizarre behavior as
>>> the SELinux policy you load in the container will apply to the entire
>>> system, including processes which started *before* the SELinux policy
>>> was loaded.  While I understand the point you are trying to make, I
>>> don't believe the example you chose is going to work without a lot of
>>> other changes.
>> I don't use it myself, but I know it's frighteningly popular.
> All right, I'm going to call your bluff here - who are these people
> running AppArmor on the host and SELinux in a container?  What policy
> are they using, it's surely not an unmodified Fedora/RHEL or upstream
> refpol policy?  Do they run in enforcing mode without massive
> permissions granted to kernel_t (I'm guessing all of the host
> applications would appear as kernel_t)?  How do you handle multiple
> SELinux containers?

Beats me. All that SELinux policy stuff is over my head. ;)

Seriously, once they got the stacking patches applied they thanked
me for the help and disappeared until they decided to update the
kernel version and asked for help with the next round of patches.
They told me what they wanted to do, which was to run Android in
a container, but how they accomplished it was a set of details they
didn't share. I assume that you are right that they had to do
horrible things to either AppArmor or SELinux policy, or maybe both.
I also assume they wanted this as an environment to develop Android
applications, and may not have cared much about actual enforcement.
But they are happy users.

> I'm aware of *one* use case where SELinux is run in a container and
> that required a number of careful constraints on the use case and a
> good deal of hacking to enable.  I'm sure there are definitely people
> that *want* this, especially in the context of Ubuntu, but I really
> doubt this is in widespread use today.

What I know is that there is a community out there using it. I think
you're right that the way they're using it would be displeasing to
most of us.


>>>>> I think it's time to think about a proper set of LSM syscalls.
>>>> At the very least we need a liblsm that preforms a number of useful
>>>> functions, like identifying what security modules are available,
>>>> validating "contexts", fetching "contexts" from files and processes
>>>> and that sort of thing. Whether it is built on syscalls or /proc and
>>>> getxattr() is a matter of debate and taste.
>>> Why is it a forgone conclusion that a library would be necessary for
>>> basic operations?  If the kernel/userspace API is sane to begin with
>>> we could probably either significantly reduce or eliminate the need
>>> for additional libraries.
>> I'm using my experience with the "hideous" context format
>> ( "apparmor\0unconfined\0smack\0User\0" ) as a guide. Creating
>> a "sane" API for returning multiple lsm/context pairs is going
>> to be tricky. No one wants to require iterative calls to get a
>> collection of values for example. I've spent the past few years
>> trying to pound out APIs that are somewhat sane. I don't want to
>> spend another few years repeating the process for kernel APIs.
> See my earlier comment to John.  I care a lot about getting things
> right, and very little about how long it takes.  I'm sympathetic about
> the time and difficulty involved, but I see that as no reason to merge
> a not-good design.
>
>>>> The addition of multiple subject labels to audit would be the same regardless
>>>> of /proc or syscall interfaces.
>>> Yes, that's why I didn't bring up audit as it doesn't weigh on this
>>> decision.  If you really want to include audit for some reason, I'll
>>> simply remind you that I pushed back hard on overloading the existing
>>> subj/obj fields with a multiplexed label format, asking for individual
>>> subj/obj fields for each LSM.
>> Just pointing out that the stacking patches aren't that complicated.
> Ha!  Let's just agree to disagree on that point :)

OK, they're a teeny bit extensive. 

