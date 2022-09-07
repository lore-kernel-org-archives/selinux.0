Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99EC6FA86
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIGQmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiIGQmP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 12:42:15 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18159D10A
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662568924; bh=9dnxKbxzS08mlPE2816z4GziaI1cowYJON3zywBCxWA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ISQiQNoB4OtnIcOpHqJMDwcPB+7vmqsiEuYu59db2tSUH3guO8Q5T+mI0yoTeKT7qd6F9j+qMhlLV6lbiKDFEcARA8bafrR0j3KwvEtnMeZ2JtHKiT4cJd117xCo9ywdV1gfgqBHaSLaXdZTRF9tLn0a4wlSNAlPCvRlGyq69MCyxePV7MF/vVSQ2S11t4iaHYmdeRT+eEw6YXqrE+nJIIOlNxhMrlbIh6eoj6bIhBcu/wuAcJYUnRSjIzZ43K6kV1SbTzeLRKkIYxzyHybrg98+tOt34uKRRUE7/guQeFOmMHGCAGDHnxjqhkN/tBWxs0bXvmu7amwc95fXbx4oEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662568924; bh=mzkqDfVU294SuDn9y0ZpCDhDzYricprzJ5ALZobgACG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=L/rGk6YPPrXH2YEcTZZ0otBwXALuCCD8lwoaGcdyeWCPB5vFDEjTC6KSqhoGbvILlD+ubryGqrKAog9KmIYmWm4pPB9meMXnM/Frio8/fdjKzMrsR1qzjbz4a6W7Wi9V4SG3mIGHlGBxwKLN6VJDn8i3qwEqOGFHaOEwdYlDa4fwjmsFOVhdq8Das218VUZE+gzl7gV/j5jMcqNdBJCXLgIrfN1kF385ZThk3uG6pUG6HmeZ090FrMi/ipRJPViC0k9zgvhsSWUuFhJRSAbAd726kkVs3rJdMB3V18JNOCAw9Sa5ZiQUEFdzhqX4j1pV0yDPU5cKUeKQ/VoaGda1vw==
X-YMail-OSG: Htj_gYsVM1kkaoDyjL_Yo4Wd9tOT5GMZf0Zx7rfJ5GcimR_jHe0XHplowYga46z
 FU52cMLNCiEyvX5dDA47JmmQGSECmKJf_Z66x15e7gxxTIzICXBkxAeMZmWfDPGzhpyLYQ3wa981
 ULf2bcySUK6WMcOAmQqsU9EhBoEFeITDsY1.sCMMCZjlyxTsgdkIBbKIYq74JYbrKsrrJPwkQ55x
 974X6XK1du1KfmgaUHJXSfC7dj.jg_iiKZyjrgfCb1WFJXAX.QpvBOLeBg9qmeAxKPi_tjKaQoz6
 xe0jLNZFfw1PAhq3ORFU9FPNlRiDy0YKLCDSLLCEUrc1zbKYmH44aveHCkZahdaiwa1fuZ79Juu3
 PCXNKud0v7WTeR4hW5W2QL95DCI2cYm2H9N0EzLoz.pou5_CCkGko38Kw.MuphXZG9iGUt9BJnpa
 HIa2eauIH7_ebJPCM3ThCShysNMpBjx1zHL5L9YtZEFss3usyQfZFz8jlCzw7F5tNOe5cyiUlCq0
 dZk_X8fy.vIuWmZUBb261NUkvHqaPSq94l3DsKKf2Obe06PAW1u3YgvK7fD9OSs7U8IqlHX8WiQF
 0GzVsECA3.e4chzsK8AwyRZb58FMeTmCQnnkhmP5JKh9xb1VAKa9OVCfpznV4qiTpql_zUienjj1
 tgmI9nGt8S8zz.qdIzDJzKpQfAm86apuNr0lz6SVs3UqUj_fVtLBlxVDFTAPpO9ANSGR8kMtTAAo
 RVnWD7jRFyD4W2LBX1nj0yUOUDks8nA1K.XXEelZiNdR3Y6WtObkA_Pc7VLuAjN6mxDTArcPMAns
 W21z4gxvtuMvOfzKL7Wz.QkBeyJRHu6qcGgEh2BdgT2tGvoZhyc.taKCdcdoz1J4mdBAMWcncaDE
 sVPhm8V5DWXzosjGC4h4zeagg2CNOx3jQZgjeyDD9uvHpI9hmgdr2DopVCiXQsSktZI1sLkX9SBA
 _2PXneK_9B49W.uCqlb4n19AXwrD9Mm6pOMnJLD2pAdbXW6qBAXkXftyA..XeI.ynjLI4oZEt9CK
 0TWFwByefe7iBpHrTkjdJikdFxR9gcwdLifP.q35yc7gOa8RvXL_YRyWwH2ELdTd__z2QjnMBxB5
 M.FAGs6jMdYUeU0uKTv22F6P7EWrgl2u_0t_Vd1QLbOz1X6osnudT9nNkL9UqaPTrGouLfOJ7J05
 ykFW8O1cFYpKcWvZC_upD55.Fw4_xiyvvoF1Gpr8LP.aHI3opIdFnI2VHTQ1HbHxQbS5i1Xu.DcL
 0PvgZM0374Cwx_wVBnz0VxAOhk0PHCbKVVrN_CoOCfZYG2HSlrKGFdmu_3gQsdYJByWvMh2O9Uo0
 tY8CMI57MysOP9gh7JMhL32HLf0JagOeLYkHbO5dhtr163Jg1mdBfN1EX4DwF7K8QtyMl4WkjFwQ
 LkA6qaXJQ68ClWZvIny8xoUJyksOE4imdUsNttSUfcCf996JrGd6w.LKa1FkML9yFPnaNl.nxUGw
 mliEckTMV_5nMsomKrTd3gOtYBmnadcs3DqpzxqglWL15w3r8trqfs8lgMt42X92_gQW9Oby2zYi
 nia3B2u9BRwEdLmoGrcEtJq4KCRBKmyk0VVfKAteSB2D0bJ4jw0ffcPvrgdmWWn2q31qWlWfmGnl
 ZqNHNNEiJiOwAVJb7bpMomGaZ0bAaIOjVcUKb2zETXHpPiX7SQUU8pvjAHUpsNoTRCaajcO3QEi.
 VniKWH_hKSXNpnTc8gQxyaiGSNWckwC0vCG9rbsrP6Mo8nCNJHEsqwNtE.4wwjYTHpqQo41Ch7XA
 eStm4JKLzHWCx.p.MDfgrBOL34NNK8TOwy3q1nSRkoFkTwf0TC0VZ4WU7LT24O3iFnt9ZK.r.uwD
 r8LYzRvA4OSqP0eO2Bpz0Mb3Ou0mrqkO2f3Bg3jV4Ha5JUIcr7q4m_OYgxXSd5yxBREHm8ML6xj8
 N457pl7LizkQ_E9KlIoBcRLbEzd8YUHtdwOfJLUhqvlyqQD9Dbq.R64CuleqtWlc51wiSf1HCUbY
 ydOANod0GUmIRQWPxGj6mH6efAYhoRddkyh_2thyLFljf7_OZJ0iSe86d0Z8P1wXgaPeWE4EpP0j
 BhgwJ1EUv1HI8PwhIr_mmXy2adHMqixj2Du66Mf.xMYoyh210qOQLxZ.zH9o_eeMBVd6pEVte9_v
 X2XJnuBC0.jQNZEgcV2VeO_S0MtbMSwg03.RYc65NLxdi.DcGGfNYYNVN87wm5WVzb5y8jboLdvS
 NP2EkdHA2UDX6u8vVgL2cMdSI_uXEA5G1vdpTfuI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 16:42:04 +0000
Received: by hermes--production-ne1-544744cc75-w2cfm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f816f2cd4eac9e781c0624ddecbf8e5b;
          Wed, 07 Sep 2022 16:41:59 +0000 (UTC)
Message-ID: <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
Date:   Wed, 7 Sep 2022 09:41:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/2022 7:41 AM, Paul Moore wrote:
> On Tue, Sep 6, 2022 at 8:10 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 9/6/22 16:24, Paul Moore wrote:
>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> ..
>
>>> If you are running AppArmor on the host system and SELinux in a
>>> container you are likely going to have some *very* bizarre behavior as
>>> the SELinux policy you load in the container will apply to the entire
>>> system, including processes which started *before* the SELinux policy
>>> was loaded.  While I understand the point you are trying to make, I
>>> don't believe the example you chose is going to work without a lot of
>>> other changes.
>> correct but the reverse does work ...
> Sure, that doesn't surprise me, but that isn't the example Casey brought up.

I said that I'm not sure how they go about doing Android on Ubuntu.
I brought it up because I've seen it.


>>>>> I think it's time to think about a proper set of LSM syscalls.
>>>> At the very least we need a liblsm that preforms a number of useful
>>>> functions, like identifying what security modules are available,
>>>> validating "contexts", fetching "contexts" from files and processes
>>>> and that sort of thing. Whether it is built on syscalls or /proc and
>>>> getxattr() is a matter of debate and taste.
>>> Why is it a forgone conclusion that a library would be necessary for
>>> basic operations?  If the kernel/userspace API is sane to begin with
>>> we could probably either significantly reduce or eliminate the need
>>> for additional libraries.  I really want us to attempt to come up with
>>> a decent kernel/userspace API to begin with as opposed to using the
>>> excuse of a userspace library to hide API sins that never should have
>>> been committed.
>> I don't think its a foregone conclusion, its just that it has been
>> discussed several times, and all the interfaces have been nasty and
>> prebaked userspace code would be really nice to have.
>>
>> There are other reasons to use a lib as well. Libs can help apps
>> pickup fixes/changes automatically.
> Fair point.
>
>>> The LSM stacking work presents us with a unique opportunity to
>>> modify/update/whatever the LSM kernel/userspace API, I don't want to
>>> see us squander this chance on a hack.
>> I do wish we had a better API from the beginning. I just hope it isn't
>> going to take another 10 years to get the API portion done.
> This really should surprise no one at this point, but I care very
> little about how long something might take, or how difficult it might
> be if it is something we are going to have to live with
> <dramatic_voice>forever</dramatic_voice>.

Fair point.

>   I'm sympathetic that this
> work has been going on for some time, but that is no reason to push
> through a bad design; look at the ACKs/reviews on the combined-label
> patches vs the others in the series, that's a pretty good indication
> that no one is really excited about that design.

The kernel developers aren't the consumers of these APIs. There
has been considerable feedback from system application developers
on the interfaces. This included dbus and systemd. Kernel developers
aren't interested in these APIs because they don't care one way or
the other. That, and as you are painfully aware, some of them are
really busy on their own projects.

Am I really happy with the "hideous" format? Yeah, because it makes
the end user happy. Am I happy with interface_lsm? Other than the
name, which was the result of feedback, yes, because it in the
simplest way to accomplish the goal.

I am curious about what you think is "bad" about the current design.
The interfaces aren't exciting. They don't need to be.

>>>> The /proc interfaces interface_lsm and context are really pretty simple.
>>> They are now, they are also a bit of a mess with legacy constraints
>>> and they only get more complicated and messy with the LSM stacking
>>> patches.  It is my opinion that a syscall-based API is cleaner and
>>> easier for applications to use.
>> potentially if we can get one
> Let me try and remove some ambiguity from that - I'm not going to
> merge any combined-label APIs.

Why? A combined-label API is what the application developers asked for.

>   I'm not sold on the syscall-based API,
> I'm open to other ideas, but it needs to support distinct per-LSM
> labels that allow applications to identify which LSMs are active and
> which labels belong to each.

??????? This is exactly what I've provided.

	"apparmor\0unconfined\0smack\0User\0"

You know exactly what LSMs are providing data and what that data is.
How could it be clearer or cleaner?

>   In addition, I do not want any changes
> to the existing procfs APIs as I want there to be zero chance we will
> break existing applications;

Are you saying that interface_lsm changes the /proc/.../attr/current API?
That API is already dependent on the active security module. You may get
an AppArmor, SELinux or Smack context from that API. It's been thus for a
long time. Creating the smack and apparmor subdirectories was done to help
make this cleaner. But those are new APIs. The existing applications either
allow for a variety of security modules (e.g. ps(1)) or need to check for
a particular one (e.g. id(1), which doesn't need to and would be better if
it didn't, but what the hay). If they don't they are flawed and should be
repaired.

>  if existing applications need to be made
> aware of a simul-multi-LSM world then they would need to change to the
> new API, whatever that may be.

Agreed. That's why the proposed APIs have been discussed with many
of those application communities.

>>>>> Further, I think we can add the new syscall API separately from the
>>>>> LSM stacking changes as they do have standalone value.
>> what I think Paul is saying is we can move the LSM stacking patches
>> forward by removing the combined label interface. They won't be as
>> useful but it would be a huge step forward, and the next step could
>> be the syscall API.
> Whatever new LSM API we decide on, I want to see that developed and
> merged first.  It obviously must be designed to support multiple,
> simultaneously active LSMs.

That's what I've been proposing all along. You don't like the APIs.
What don't you like about them? I believe they address the objections
you've raised. I know that I can be real obtuse from time to time,
but I don't see how they fail to meet your requirements.

