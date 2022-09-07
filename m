Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E561ECAAA1
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 00:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGAbf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Sep 2022 20:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGAbe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Sep 2022 20:31:34 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7238307B
        for <selinux@vger.kernel.org>; Tue,  6 Sep 2022 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662510691; bh=hXxCk5eaNlXgsFn7LXXVIzjxIw65yZoB9q7AelLqWvM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cJxhGkfqJiFJslssFl3TKSUQIGefX9sIwO3wabWXB2HSFi2n1gED7F+tHitkaz4GRtywLgxS/w489LsGlpJ4Elew6zCrwJld+yyY7hrAWZqaUqmVV6C0oRnbuNVbovKhVCfhlqS0AKtdCgxkKOU2SeLXIlpnhafjg4RVRZQBYlcNF4CS+4gW86dBqqmdzZTa7Tiy57TBwsOkA9N0RLTGxTcb69Kw1l0XC5++tTSgSKKEbCibQ2e41YB8D2Htt+BTxDtDf8b5Bt9HHS/6gNBGNEYuM+VgjJurYZuRY17c1ygnUyJ6p9OcThdD2wdozh3VMslwNlNwHT0b6FLtrnoSEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662510691; bh=ggo/HOp74MPEQIaPqo3SKtbDhvqOhwr7VqpuZFpCA5r=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J0nRjjHctDORoCcOdm84ud8cdNcWw9tWBO2vOZT0hEwEAec9a7IT3YaXz9GZJEMSowNHOCFsSCdPudXE4Uyzh5yyw9JWvNjzx69x4ImRxnNrLjNBP6kaf+rDr7tke9O0CB8OA2oGDlEmEHAneRjiE4zNrExpYX42/Ovau8GH96Oy5H/UvD+KevNcNkqlqIDT1P10FlxCI4x9LiGe6OrFPqcz58JjGzwmUBqNpoqFSVGlaQNsIExK5p8Z5AzV8wCuSsgzOsE1ri3Gp5VigrLaHudjFqoN5HVn6a+dv2QQu7b3YKFkCDKYKlrL9BqWBG1+JuVuIbwA2XpRKw7Xxw46WQ==
X-YMail-OSG: X0gsmQgVM1kJ8dfjkWC4xnmcEcPzAM2TWVZaDOkt.yjKSyI93Tiuxgu3BjPUukQ
 SPLDM57ovrAsEX8jiHObjRPiuc1bEx_p2sKcGBsBXXsLuY7uEKE1Z9qKhiM8kBVT24bOYp6LhvFD
 fE3JlbJ9MHWvWwjW2PAZUkT28_SR.3c2_b8F8ArnqHsKRta6KdvqZOJxjGXdScZgxYtkOJ7pV9xL
 gORuUfjAnC7.RpRf.XH3mQZsE2wVgh2fRL25KQrY1JPWqrp0.e8tO17yxMiKLxeH45crcAMpC0Dx
 535H.7cbBVt9fnSz0jjmkp2OtGL28PwM.U4flsT9M2V2Bw8rgXjp5n6ZcMWqbbyIbW57eephnBTH
 yqZuebAySPMOPttFD8V8OfkKhNxvAxBfUGZdW_SJrugT21L3oYb8lKqbtC0mvLbKUU_nJOH92yan
 ga7vsxvoNsRQj3lLX7gOshCSbjSPgCdw06WEm..cuwcPaasE661jIRr0CPm.NOc4DqoVksRpRh8y
 _dmYPp_eKTnBChuA5eZFuXJiMztWCMfm.Bw76Qx639MnaA8VPOEF7Uu51G7ZG6pjKSz9IuQosopN
 DfLuK6MTsQU7g7F4tMsiz3tPGnXkYWASV_ll8QqjwrSQ0_0ZGPPWiyQGuOAZUUEoPTAzaxLJpQ5t
 VwfUVlJ2cA6YANsT0Fj__VQ6LL_nIQ5XSmvJh0Rx.GUWuMJa55IB8LZhYNhUpDAZ5L0ueyIff3yU
 cXaW7xiJNVdE0Va.TXlIFNOVXGNeKMCzp.nMHEquPz6QYitoDqZRsWDhwPjHvyDIsK1kX_FD4ncn
 ivW.GhHTHcWrt3dgf8a.zGGLyDyXvW1SMZJBw.sWKSd6AtA716zqzJWCIfwaL__88XHuOgqG97.g
 xAAbLRfQjccT1wpSgWh1iRyDVF.9aGK9.N6Lw_dNTejJIAfPnMIgAE9NaoqIHtsEoaTYsm09wVSn
 3Qve4KhqVCO9b_9rtL3_AkbZH9SCFgut0QQ3XyoDpEVhuq4ftPxTxE6CIYBvUFGuUXUfHDWXjeBM
 scMDgY0AvAqQGmkFhOWBkGwh8qVGPcoWsuuNYSIW32TqDIFyoUD2idmGTFcXjXfm54GVvI5Spk_d
 Y6CM84glf6A0NzE7tv1gKy0R.108EJCeGA12rR43wV8aj4oIW_mRTLYlp96paCA3SP_SLtmFp_Hm
 J4RK17f7TC0sQSwgMPknEjnbzOFbgntlBnar4owOYm13RdWqHz.YbEwptCJnKioQJnxVHZ5P8Knn
 HL1KUFzHdyWW4OnG42Ks1MGvw.AHlnoIAAxpcLFQcpDh86em_dTn39vuPgdPQG6HwFLN4PfTLfB7
 stsz5eCEoROD9LsLck1nBvNjvfLHLYWfDqmH5wYEer0YoDGZW47jyAiWs5pBmUj5IvhcXKH.yVAr
 EBWBkgu9l_nIeTuVpvKjWkYC0PRYuQw_y.V2T89yoYd2oo0ekcf30HksVhhUa1dVk.lUyD0JI1.i
 YUsO_3Y.LX3apJ9SZQ1b6vNnrZrH3S6e80PFU4SHcnHtIEzQYHfPOI1u0J49cdSxO9gbLuUr_Ky1
 _5FiLU0.54Kh_G5lmredUky34.3UI4wHstrdPBC_LZA2Og9rCGrLnYPV0Jbh3ICU0aWV6Cicr97V
 xryzhyHIjIi09Xmlu0ExeNxnMkcfTMB5JQJQ9NqVzUUO48gzLirDpIRnlC615Ld8M4d7bji6yxo5
 RTR30I2C1tH.Sq3U0rwFFD8lVOiGDOzS7YiwPBSNTHSgi8J4GmVVy3StUbhvsllxgDArWkEc.C08
 ZDet5McesqcZ4QpnUU9w_JRQdXxni8kamm1WhZdxf1iLSF9jq5c.hXr7TLznJf.rxx1zZZJtuDN3
 S7d9gAU6ckTCJjZIQwFk6MjNGAMMUoN3ytkozoLj6iOEmaCunQh0jDNhB.Ga2d7NbyiNBBuXKmF1
 97dRbvQ.XgSgL4hKJZ8lRTEzHglrcYo5T_nN9P5d1v4dmW0kIcTbN1_zssn4pSUUdMQb_27eP2Zt
 ZV1_D_8Q0L3zuRh2ZQYDkzcvrwcy0OVc3ksJfiH4TENw9g5DySYjkMbLXOEg8JNR.gJMLtg3UkU9
 0G5B2izx0EUNu2i1nJc4NGGQlypNzRRO_Qb4Hw3A33WUHtLMMU.Uup9b74tZk9aNycBGlT1801RN
 384W.TjHlsHs7R28K6QFbpNvL6RCqCr3NOdERUb24zMdfGiv_B6p8cXj4_QKrD1p5nM4mgFtMkJx
 CgwoXAz9s70zF8C9A8.LT5uFQAkXYcdWo.IVrOQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 00:31:31 +0000
Received: by hermes--production-ne1-544744cc75-7vbr4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0387086c2b5fb55fc8441f7931e93f11;
          Wed, 07 Sep 2022 00:31:27 +0000 (UTC)
Message-ID: <9f79faa7-0d6a-c023-4561-15a261d4c60d@schaufler-ca.com>
Date:   Tue, 6 Sep 2022 17:31:25 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/6/2022 4:24 PM, Paul Moore wrote:
> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
>>>>> up nicely and I believe that all comments on the integrity code have been
>>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>>>>> There are serious binder changes, but I think they address issues beyond
>>>>> the needs of stacking. Changes outside these areas are pretty well limited
>>>>> to LSM interface improvements.
>>>> The LSM stacking patches are near the very top of my list to review
>>>> once the merge window clears, the io_uring fixes are in (bug fix), and
>>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
>>>> and SCTP stuff can be finished up in the next week or two.
>>>>
>>>> Since I'm the designated first stuckee now for the stacking stuff I
>>>> want to go back through everything with fresh eyes, which probably
>>>> isn't a bad idea since it has been a while since I looked at the full
>>>> patchset from bottom to top.  I can tell you that I've never been
>>>> really excited about the /proc changes, and believe it or not I've
>>>> been thinking about those a fair amount since James asked me to start
>>>> maintaining the LSM.  I don't want to get into any detail until I've
>>>> had a chance to look over everything again, but just a heads-up that
>>>> I'm not too excited about those bits.
>>> As I mentioned above, I don't really like the stuff that one has to do
>>> to support LSM stacking on the existing /proc interfaces, the
>>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
>>> have for retrofitting multiple LSMs into those interfaces and I think
>>> we can all agree it's not a great API.  Considering that applications
>>> that wish to become simultaneous multi-LSM aware are going to need
>>> modification anyway, let's take a step back and see if we can do this
>>> with a more sensible API.
>> This is a compound problem. Some applications, including systemd and dbus,
>> will require modification to completely support multiple concurrent LSMs
>> in the long term. This will certainly be the case should someone be wild
>> and crazy enough to use Smack and SELinux together. Even with the (Smack or
>> SELinux) and AppArmor case the ps(1) command should be educated about the
>> possibility of multiple "current" values. However, in a container world,
>> where an Android container can run on an Ubuntu system, the presence of
>> AppArmor on the base system is completely uninteresting to the SELinux
>> aware applications in the container. This is a real use case.
> If you are running AppArmor on the host system and SELinux in a
> container you are likely going to have some *very* bizarre behavior as
> the SELinux policy you load in the container will apply to the entire
> system, including processes which started *before* the SELinux policy
> was loaded.  While I understand the point you are trying to make, I
> don't believe the example you chose is going to work without a lot of
> other changes.

I don't use it myself, but I know it's frighteningly popular.

> Regardless of the above example, I want to be clear that I'm not
> suggesting changes to the /proc interfaces.  Existing LSM aware
> applications that use procfs for information would continue to work as
> expected, it would just be the simul-multi-LSM aware applications that
> would need to transition to the new syscall API to get all of the LSM
> labels.

They're going to have to do something, true enough.

>>> I think it's time to think about a proper set of LSM syscalls.
>> At the very least we need a liblsm that preforms a number of useful
>> functions, like identifying what security modules are available,
>> validating "contexts", fetching "contexts" from files and processes
>> and that sort of thing. Whether it is built on syscalls or /proc and
>> getxattr() is a matter of debate and taste.
> Why is it a forgone conclusion that a library would be necessary for
> basic operations?  If the kernel/userspace API is sane to begin with
> we could probably either significantly reduce or eliminate the need
> for additional libraries.

I'm using my experience with the "hideous" context format
( "apparmor\0unconfined\0smack\0User\0" ) as a guide. Creating
a "sane" API for returning multiple lsm/context pairs is going
to be tricky. No one wants to require iterative calls to get a
collection of values for example. I've spent the past few years
trying to pound out APIs that are somewhat sane. I don't want to
spend another few years repeating the process for kernel APIs.

>   I really want us to attempt to come up with
> a decent kernel/userspace API to begin with

That's fine, except that the process here is nowhere near the
beginning. v1 was in June of 2019, and I had posted several unnumbered
versions before then. No one has ever - not once - proposed syscall
interfaces until now. I would be delighted to investigate and include
syscall interfaces for the Complete stacking (SELinux + Smack) work,
as I can see considerably greater need for them there.

>  as opposed to using the
> excuse of a userspace library to hide API sins that never should have
> been committed.

I confess to having committed many hideous API sins.

> The LSM stacking work presents us with a unique opportunity to
> modify/update/whatever the LSM kernel/userspace API, I don't want to
> see us squander this chance on a hack.

I'm listening ...

>
>>> While I realize syscalls are not the only kernel/userspace API option,
>>> but given the popularity of namespaces I believe a syscall based
>>> kernel/userspace LSM API has a number of advantages over the other
>>> options, e.g. procfs/sysfs, netlink, etc.
>> You can't script syscalls.
> True.  However I don't see that as a blocker, trivial helper
> applications can be written for those who wish to incorporate the new
> syscall-based API into their scripts.  We would not be the first (or
> the last) in this regard.

Trivial wrappers to set attributes aren't any cleaner than /proc interfaces.
And in any case, if you've hidden the syscall in a wrapper you can hide the
/proc interfaces in a wrapper as well.

>> A syscall interface is fine if you can also
>> update the entire system service application base for your distribution.
>> I don't see that as an option.
> Once again, I'm not talking about removing the existing procfs
> interface; existing applications would continue to work.  Only
> applications which wanted to be simul-multi-LSM aware would need to be
> modified, and those applications would need to be modified regardless
> of if the procfs or syscall-based API was used.

O..K.. then syscalls could be a completely separate project. 
The current work need not be dependent on whatever syscall work is done.


>>> Further, I think we can add the new syscall API separately from the
>>> LSM stacking changes as they do have standalone value.
>> I agree, but unless the new system calls take stacking into account
>> from their inception they're just going to be another interface that
>> makes stacking harder to accomplish.
> They obviously would Casey, not only is that the context of the
> discussion but my dummy example clearly had support for multiple LSMs.
>
>>>   This would
>>> help reduce the size and complexity of the stacking patchset, which I
>>> believe would be a very good thing.
>> The /proc interfaces interface_lsm and context are really pretty simple.
> They are now, they are also a bit of a mess with legacy constraints
> and they only get more complicated and messy with the LSM stacking
> patches.  It is my opinion that a syscall-based API is cleaner and
> easier for applications to use.

Yes. A syscall is easier for an application to use. A /proc interface
is much easier for a scripted system. The scripts are much more frequently
updated than the C coded services. Some of the services are so rarely and
cautiously updated that expecting them to be modernized is unreasonable.
How many system services use capabilities the way they were designed to
be used?

>
>> The addition of multiple subject labels to audit would be the same regardless
>> of /proc or syscall interfaces.
> Yes, that's why I didn't bring up audit as it doesn't weigh on this
> decision.  If you really want to include audit for some reason, I'll
> simply remind you that I pushed back hard on overloading the existing
> subj/obj fields with a multiplexed label format, asking for individual
> subj/obj fields for each LSM.

Just pointing out that the stacking patches aren't that complicated.

>
>> We'd still need multiple LSM data in most
>> security blobs. The conversion of LSM hook interfaces from secids to lsmblobs
>> would still be required. As would the conversion from string+len pairs to
>> lsmcontext structures.
> I'm not talking about kernel internal data structures Casey, I'm
> talking about the kernel/userspace API.

Again, just saying the the patches, while extensive, don't do very much
that's complicated.

>
>>> Introducing the syscall API
>>> sooner would also allow any applications wanting to make use of the
>>> crazy new stacked-LSM world a head start as they could be modified
>>> while the kernel patches were making their way through the
>>> review/update/merge/release process.
>> A liblsm based on the /proc interfaces would address that as well.
> Perhaps a liblsm library would be useful for other reasons beyond this
> discussion, but I don't want to use a userspace library as an excuse
> to support an awful kernel/userspace API.

What API are you saying is awful, and how would you improve it?
The sample APIs you proposed wouldn't work as syscalls.

>
>>> Thoughts?
>> I wish you'd suggested this three years ago, when I could have done
>> something with it. If stacking has to go on a two year redesign because
>> of this it is dead.
> I've never liked the combined label interfaces, see the mention of
> audit in this email above.  I'm sure if you wanted to dig through all
> of the mail archives I'm sure I've probably mentioned my dislike of
> the combined label interface in procfs too; if not on the mailing list
> then surely in-person at some point.  However, regardless of all that,
> the key difference is that prior to a few months ago I didn't have to
> worry about it quite as much as I do now.  Now I'm responsible for
> standing up for the code that goes into the LSM tree and that means
> both defending it as "good" and maintaining it long term; prior to a
> few months ago that was, politely, "not my problem" :)

Message received.

>
> I can't currently in good conscience defend the kernel/userspace
> combined label interfaces as "good", especially when we have a very
> rare opportunity to do better.

OK, so what interfaces need to be redone? I have been polishing what's
just become a turd for a %^&*(ing long time. I need to know whether it
is something I can address, or whether I just toss the entire thing in
the proverbial bit bucket.

Grumble grumble grumble.


 

