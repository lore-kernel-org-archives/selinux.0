Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F6ECAAD3
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 23:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGXxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIGXxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 19:53:21 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F7CEB2B
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662594799; bh=CblgxEXE83tSpCEJRjGwb4aZxi77ohu0+GiA4Y7JAhc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oneI+3JTW8t0tXcljTv8bL1iCYKQ1jAp5r53fmxh/Eor+dSWTXr97K6hrDnnOF2mSiaYiRDvTpOc8HAZ59e6wN0Yd/1b1OFVN8uYRijsgpUUqFk6IRWnhCiS4o2Oj0k+qql/eB5Jwym9b5Rjv0Es/l5rwG9XddiYVIPifb/l8w2pLb4c29H8QETHBqaBI6IvqZkLLb/iaO/GmODwMe74eob97/vaYFZ2ktElUWo3y7YD6hvhArPaK+eUQYhehiGckuxYzr1d5JUYEopv8o2OiEZ7iw7a58uHxq0/pK4uSa4cY/eiewg5MH6q7vr6DB2aQOqL0FSI6Cq2LVRq4sc5ZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662594799; bh=yY9kahMEqmSqhlF7z1vz34RU4QScyeiuOLWJo59E373=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RrjYPKvyQFrtihB6cTbCgOkzqzH55MumEydDLvJeeCYp4CpYVg3B1VnQpCvfUosINOJ5Gbl1PU3lKsxqyExdW+MYkOLleBOBExsbtTR0qIMm49poPqtvDk/cJHYBokkkztSsQ5L54GW5SSaar7uHzCP9YpIqA763InZ6ZhjDz9KEStyxeDdu7r+KvGL0suzRpFQ9/6EcI34daSWzjxCqka4RaHJkvRenMUvRt9BXh765YTPAaJEWS3oRStn7Ubb9OLvDkSIq7ZBDUXlpojDSpfJgnJYGw8HDZ96FeVEcUoMEy0V+5MxxSDMTflb9po1BegRULcyUJlHaFzfQ2V1qYA==
X-YMail-OSG: iYWIsyEVM1nQvtMoeQK639KJH8VfSZfEvK883I.JIATb8r90tntMIQOGYlml95_
 DHNxHbqLVZ_1ng6XL93C3wzandDZ6GCx8BIU5v6HZDx.cLz98mU6vdG03LFNfNeRM5o1.hSCXFwh
 nL0cLYAw7uFTxeweanV62X0H5cyKNalM7gJBM3s5iRg8VnnaN4uyoesXxVMtEMLO9IqYS4c67fxU
 rXZWTgCBn084yJ2Py9sicpxv52NWP_hVKISpWoRbWF838J.r7AxR38qpacZgDZm3EgKleunK1R.1
 FiD76Y31GrL2y7LsdgJsoGkNf5sZgQEl9qIdWmtcUEeHZTh_fz5dIKzXWAoPuUegoBZ_FZV34p03
 K3GAsqWaOrzAuZxo4HWAN09s1jti_cBULbIf4NH6kNbZp2Hg6fDf6N4c4KkK1kmUV4ZQCe4ys50R
 lYBiGbic_3dISmY0SuZsJ1.RdDdFWzMnWACGsD73VwbvbYQ66JDusQJz2x5oAmbeYM5mdxB0pU5R
 RlqdEkPH_Moxh6KdvDD8mWcCJmpftpxhTQmX_DhPxROVsoOkQXwYl_NED_vPcbYdQSaomTXaX11U
 YZnJQsQucZrFhKeyh.mQxleSPqfDXPJmI0B1gl8g992uhw_iXSuLyWcI65fP3z77dl7KzIpFXnkR
 aFsLX5HDDAOZs.6kC_eB1Yrc.PnPYH3Hu8V9wDUfJWhNpiduMTYolq9umQVnpHRqPQqSS.jN6KlD
 _MHjbP92V3R6Dx12111KIUsl_ncmf7a0svKQfjqAu70OUtYaWnIqBKveP5xPA4N2EAFwSmOV.3w5
 WQaNwp.pvMjIdapcZMGCm0p7GsjElSkReGWXtuJXXSQePEljl1uXwe94ErqU8F7yrfrZfn0xpLZT
 UCv9U.26HPuOx2peOrclIGhrGdEDtt57hR0hAOv6dmlVssuMRdrsxfwWXb6CH_lXTjDjdgA2sSl1
 MMU58LTHAAlmV3QVVA0hzDknpXbZvcMd.wIYpVKop_T_8F3rOUuhZbAwOmDcT.WyzYCQiS7Annuq
 gLSXYwpImUfOqXlfPYguoWMWdQqupd2y3pblqUrk922fulhBVzNAbsXokGRzibGBylPdMwhVRZGi
 t3fNAJHFbHKLk5t74ePIdDr3myZqcXoLf.FJ_YMmYd8TORfoc0Ks4oxIvHk.VxtSCMxtQgU61YsW
 6SvzCmPGln27A6G4G74Dyxe8ukqX57nuDpochfR.e0_SouQWZmW_t5YlnPYkL59rm8lRHFXgvzbi
 KPLWpqfPGvEXAtehxWUPs9Dha9_VWfbuNjqIajghbDgLoCpu4_WlEfAhFtdy4N34Pws4B0TcaHHa
 JnCgCwBQGGwVcwHAbNNucn4etgH0OvQo60IpMqG9.NesYu25jijmnybSoKnkPaoZ.Mz77TcaT7a6
 M6kUy7FI1VR8AfVtG5i5D_2xqppI4zLwUKPOjJ2rYiTpq6iMHWlMWqXj09jJhtkfDCK1PjRNqBbo
 obn03nHpA4ah_acKyTiLANUPZEJNDJJrzQfWS06x_5K.bRCMyK0Fyezgr9YMz9QrihWxD2ZJq1kf
 lT1d9y1utD0Q1hQCkvvE70ohJVuhDGmS47QhBA58tIegKShLjF5h64CklbQAaRnOkDADXD_zUupJ
 1coh6yCJ4zvC.WgCcr.FFYwxFLTbJVHoJz5Vm2ZVEsO6JFtiIojOO0qxsSdKTPx3NZ_SI7wimJrN
 QZIh0._xILbeXD_aLxOFJLAjzJmw5mpW_DAqV8ccV.nl3_BXslraA7.TRbv2nyFt_b6bcsKtEl.F
 4ewbEXj_zwpctzQNSBgJzzoJx5bxh.EO1z8PAiXhT_gzOmso5DdF8iZ5mOBBLnGcnxQG_Iz0VOjE
 3xwzg8CZSdF7kNLHLjFRw4SE05pjhk0.sADyBBijBynYGl9tiMckVs3VKzIe9qjDV_n.oRHLYl0P
 dpPryXW.QPReaIYMmbmvYieAv.Np5o5UZ4v6ZMVfV_XlPnZnLcwPfobHuQV293BWyNDRus_XzPNd
 9vMTfBMy0wHgx9Tkrrp3Gaurw76UO5i312ltHzU4.urD1.lYVZ6ui1HKrzHnCz1KtgOA2k84VNwi
 gl_OIOMFoMHRJKvj2xi_PfV1Aq4IJ7xyTGDUscv_zp9LGtYuKU2SzU5CwaMzKLr9vmStr7qppPCW
 YfFjyPbZWNS7jDqfPOreb2cXn9jowCL.yCh.qMUpfrvyiut9LENRzTRYOsWaiGVQLNcejThtuABk
 .OcHGFhensXi3IffdMx.xuSTBRo2I3KU9
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 23:53:19 +0000
Received: by hermes--production-bf1-64b498bbdd-z8jtb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7b062fc6d94318abfd96b1e54d92ff80;
          Wed, 07 Sep 2022 23:53:14 +0000 (UTC)
Message-ID: <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
Date:   Wed, 7 Sep 2022 16:53:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
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
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/2022 4:27 PM, Paul Moore wrote:
> On Wed, Sep 7, 2022 at 12:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2022 7:41 AM, Paul Moore wrote:
>>> On Tue, Sep 6, 2022 at 8:10 PM John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 9/6/22 16:24, Paul Moore wrote:
>>>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> ..
>>>
>>>>> If you are running AppArmor on the host system and SELinux in a
>>>>> container you are likely going to have some *very* bizarre behavior as
>>>>> the SELinux policy you load in the container will apply to the entire
>>>>> system, including processes which started *before* the SELinux policy
>>>>> was loaded.  While I understand the point you are trying to make, I
>>>>> don't believe the example you chose is going to work without a lot of
>>>>> other changes.
>>>> correct but the reverse does work ...
>>> Sure, that doesn't surprise me, but that isn't the example Casey brought up.
>> I said that I'm not sure how they go about doing Android on Ubuntu.
>> I brought it up because I've seen it.
> Addressed in the other portion of this thread, but the quick response
> here is: No, you were mistaken, that was not proper Android, SELinux
> was disabled.
>
>>> I'm sympathetic that this
>>> work has been going on for some time, but that is no reason to push
>>> through a bad design; look at the ACKs/reviews on the combined-label
>>> patches vs the others in the series, that's a pretty good indication
>>> that no one is really excited about that design.
>> The kernel developers aren't the consumers of these APIs. There
>> has been considerable feedback from system application developers
>> on the interfaces. This included dbus and systemd. Kernel developers
>> aren't interested in these APIs because they don't care one way or
>> the other. That, and as you are painfully aware, some of them are
>> really busy on their own projects.
> Yes, everyone is busy yet they found time to ACK/review the other
> patches in the patchset.  I'm not buying the "busy" argument here.
>
> Yes, you are also correct in that the kernel devs are not likely to be
> the main consumers of any kernel/userspace API, but we do have to
> support these APIs and find ways to handle the inevitable misuse and
> abuse of these APIs.  Further, while I do believe that you've talked
> to some application developers about the current proposed API, I'm
> reasonably confident that it isn't the only API they would be happy
> supporting in their applications.
>
> As far as kernel developers not being interested in these APIs, I
> think the recent conversation in this thread proves the exact opposite
> ;)
>
>> Am I really happy with the "hideous" format? Yeah, because it makes
>> the end user happy. Am I happy with interface_lsm? Other than the
>> name, which was the result of feedback, yes, because it in the
>> simplest way to accomplish the goal.
>>
>> I am curious about what you think is "bad" about the current design.
>> The interfaces aren't exciting. They don't need to be.
> I don't even know what an exciting interface would look like ... ?

io_uring? :)

>   I
> just want an interface that is clearly defined, has reasonable
> capacity to be extended in the future as needed, and is easy(ish) to
> use and support over extended periods of time (both from a kernel and
> userspace perspective).
>
> The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
> string interface is none of these things.

In this we disagree ....

>   It is not clearly defined
> as it requires other interfaces to associate the labels with the
> correct LSMs.

The label follows the lsm name directly. What other association is required?

>   It has no provision for extension beyond adding a new
> LSM.

I grant that. But the purpose of the format is to present LSM/context
pairs. What other information would make sense? We could add an "aux"
field, but that seems somewhat arbitrary.

>   The ease-of-use quality is a bit subjective, but it does need
> another interface to use properly and it requires string parsing which
> history has shown to be an issue time and time again (although it is
> relatively simple here).

There was a lot of discussion regarding that. My proposed
apparmor="unconfined",smack="User" format was panned for those same reasons.
The nil byte format has been used elsewhere and suggested for that reason.

>
> Once again, the syscall example I tossed out was a quick strawman, but
> it had clearly separated and defined labels conveyed in data
> structures that didn't require string parsing to find the label
> associated with an LSM.

True, but it uses pointers internally and you can't do that in memory
you're sending up from the system. What comes from the syscall has to
look something like the nil byte format. The strawman would have to do
the same sort of parsing in userspace that you are objecting to.

>   It was also self-contained in that no other
> interface was needed to interpret the results of the syscall (well,
> beyond the header file definitions I guess).  Finally, it made use of
> flags and "reserved for future use" token values to allow for
> additional data to be conveyed in the future.

Can you describe potential flags or additional data? Planning for the future
is a good idea, but throwing fields on "just in case" seems contrary to
what I'm used to hearing from you.

