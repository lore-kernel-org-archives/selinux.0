Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE1C432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2826160F4C
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 15:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhHZPJw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:09:52 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:33649
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242882AbhHZPJw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 11:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629990545; bh=CmD218vqTaggpp6oYYeGxsttyEa1UPClxxxg7K8JKBE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dzEqQqbhZA4gFZFlIWYkqcc0YHz5BqCguMZms3/YjL2TFxBse2hwGuarpTRE+lFs4ZW1jaqRGoItAFjhKlxykXrtik0j7FSgjVQwCUEpz6AGLxntTZXqidDIaoNfjU+TBnlveoXjn3ZG+ynCFtCEoJi1tM/cMaB1bmkIhXBiOnRekfTbfPSMiCLeqeslHw4UF/AqeR+y+2syR00mNpRCY4Y6nZLwTASsjOv5n4IJS9Ubk04PiNdN2Rms6Vf4UOaE6E0jf3TwHWyCJ6zII6LUmIXZIML62sAqS2totb9Y9zsI2I29PQ3O9Mfr58Fe6njKlMYLP3Ab72JarlS+qDm54w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629990545; bh=qnzc/A3uRcGn8rFMXoOkxSFfeYJFrT9uhuXBhg4EnPU=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=k3yNcLniravWgwuK2mKhUYB6w9dplOeI7jVADr2ytnYGMor/2DW29klmiiptFmSPkKFkxlTwNeMKw/+I3YNapW7wrWNUtbXQirV/Wz686CHM82jKOFS5z3ZPGE+y/VPg4mR/p6lp4BA/U19Nqt5Y6YiznQOpvnEqQLTNAaJBpvHGVW/1F7r+bLH3mnQi55tUtwFcjo9YWoKUYQl3s31PpH9vZX0U50zIb3xzjZFG4P7bscAc/wV+csbtrqU2JCYYNH7VLNu8YyjfKLRfzr7X6TO1Eplmncvl5L4MGnSQ7XOKmRP8Y+5AbMJigX+6AECMIDi/KjQ+vFSPuKszMSPzeA==
X-YMail-OSG: ZKxj3ZEVM1ngLl3E3SQBbO8NqXxc_67vyH1snKTDb2blkjO0uv.ycAxMNsn9K60
 W0m9e5AKeGV8xspw1gP5BzYCBeEiPqg3NAd.T8ZLKA9pI_cPxV8VQZRjlIy4Sch1PAcLOQwXtOEv
 DnUQ95lEhJcmH_q.lBfnufKtcFybxiuv0K3cCGqK6rW5BYRVrklRtDi4Jtiw6tpsGF1QReexWp0L
 vet.IyqXPKjWNDMKfPisoAws9ds9lALLyz6z8wkZMcbtXZSQbNbYH56bBwEEUB3PM4E3IBedTsw2
 Gre4kYPyezZHINJqAawDOex9YZfPmNoZ.niqy6FSz_OXec7sMoksD76FrUpm5iNASSTkDbuI.JkG
 fAI2cHd8ojO8e5ndzy127pSMPlkUG.ZAIqlu8vHmkSdzX46lhGLlcVHDgJaE8hQxHz.aHnZ7cA4t
 JDljdRnOR2EMZ1zaHuUJmtTvj1mDIbRYbRaLSde2sm6x38PlaWq7MFVUdUffq6GA4Fn62dTz0l_z
 7I_Wc.LZDR7CCjM8h1R8dsY9jaSF2dp0zGGfIYeu1tDbiMEmhiRlzfBGn6gFTTYwSP8BnD.h1hnu
 Tn64jePMYNOoyRanTZTfnGSOj5uyym8DyveO4zIhJDLtWtRBrdfgE5AMHt7LIXJPUqnYsz_0b3V9
 0m_ZYUOgRciRhsSGM0ptRu0qYWtRNJ5CIHH.tIlS3lHIGQ2HSw54LZ1Pb1dev5ESGrlEpQQoHdqK
 lhLh8cNFVLEtlkTnaUhGCj42eMRhc2Th6NdmmgLqNoS.srgvQZwGsP6SnGosesDyiyJx7avN6Mzq
 iF3Z7hdY119ClxmaGATBeRAuvpiEK4aS4dGthIbPSQwbqL8Rz7GmCPvCoiXMo01zegzW6kwoLysn
 uc1qr91SJVAXh0klK9oheuYhiDyTGqQDrZuqvwqxdWS5ewYzMwGMiVF3AOfr5CO_MtPN0x94ScBa
 tK_68HcfOpRKvv2K2p855YCUS1oCiwX1IV6ups9KI3uSH8WTz4UiM2CH55TKycRPtUPeUIUDP1Qz
 oH32TjslijQanSLewCN0Wpmb8U2zWsG.uL_dnJboNkLxnpQkVQ1Mo0X_w12diSc._CO9iRSu_.1c
 XNUWT5cZUXDj55I8Xbd8qzOYXyTG2dk0EZfU3ywXC5C0._7CEVrazp4dhjLNW9AB3zdzrixMHzVA
 Knt8rM1G8Yr0Dd6OsCpIC.KoOn2mUT0SWMfnUMSmJGN.eVo8FMJtk5dJqPeJ7K7gU9POUrWjXK4F
 49l402egvLmR.nSWXqHqfZoWMxRIDKZ_3x47244vllwG91Gu4rL0KOme5bD1C6k4VnyylKwc.6hF
 e223uIeaT_Mh.joJAGnE8aUzJUfvysjNpWwAhTzwNMfVzX8flgEViXBMwKNkbORyPRup2oUBc2qa
 DSBdP2fQ4zJjP5PJkqtpBl5CWMHyj6J3yA15TWYCutWePjeQnNMZo65k3u6M7T.DVix79JfO1bGv
 23ZCbTQetirKgYQDHHMsdLQ7fTZiR2GqI7T7e5iPn_WiuCtdpWni5_lhplRgaSCWiFeAMeD71cvK
 HSBDGuaYbW2PPu7L6npPT.FrEAzxHfLrQGYO_W9Yo8b4dIcjQui6Ngfuq6V0o4enmUthFaYU_qaO
 7vjSw8cNB.U4SHwUKVND4Ci2Jt9dqvxQ1INXVZg2H42zLWItzK2Uks9AjAE_7yrKxR_Ub6yd1fY5
 DUdLIIDz6juQP30pi9IVJ9o0UmmBIpB.cYLJLO0OgYbKFVPjBNVXzZz5VxIrQE4PRd9iks6sVlPq
 Yi4G2CyiPaLDizOyCzZSrrqYi5FtdJC7P_roQUiAgr3_q0h67CMixEj_6yB..9luP4FSF7k3Hfbj
 8mUKyk3U9jymt99IyG.x0H7KnFIhzcDP0jTqMpwLJ9ufpuqbd7zuboFsbS_NewMXLjaKwL3FouOD
 5uc.toGJTgu1YfYF5F3tKAu_YeP2L79XA1bU5okurCJdInwTBQRYhAF5pmCqwU3tsnt23VthGVn5
 Rk4VbvhAbrSs6_NtOgf_QgZa606DYp9f8sfxZGSyTniUSgIRT3rbC479ccRYWXGQKZVcblzfgwtG
 vFqFC9NGwo6bJGZphTCGZkTNoo71j4YCATwbiOlv2XgT9BN8YWeX4V04G.VMZULEnxgmvxDgXeA_
 uBC73n2tilu5oP.6AFvlWeZMPtpA7FLqthNIpL.N7Ob3GWG.8OBDcV9ov28ybxZpTvL1g6BGUvkZ
 dkD6zSr8WioX7oFor.Ao1KTASN7XHK740KSS0zY2_UqdUmz7oQxwyomMpjNL7LS9FkPpfofmB3XU
 .0Q9Q
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 26 Aug 2021 15:09:05 +0000
Received: by kubenode549.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 620b58aae5775266aca9c710215618d8;
          Thu, 26 Aug 2021 15:09:00 +0000 (UTC)
Subject: Re: There is an interesting conversation going on about virtiofsd and
 SELinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     dwalsh@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
 <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com>
 <5001fd3a-7abc-9163-c912-c7d975c2fab3@schaufler-ca.com>
 <CAEjxPJ6dVT5XDh7jJrtcXTA4sfJwcJtvj2LOvXYRWKAz86xGyg@mail.gmail.com>
 <74d0e554-1c22-75ba-e427-1ea3501ec8e8@schaufler-ca.com>
 <CAEjxPJ6LZ9MATpEoWcARDQgmAVJ222RcRk=ri6O61fviSqrKcA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d47062d7-eeab-3094-80dd-a50cd7e626e6@schaufler-ca.com>
Date:   Thu, 26 Aug 2021 08:08:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6LZ9MATpEoWcARDQgmAVJ222RcRk=ri6O61fviSqrKcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18906 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/2021 6:46 AM, Stephen Smalley wrote:
> On Wed, Aug 25, 2021 at 6:12 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 8/25/2021 2:24 PM, Stephen Smalley wrote:
>>> On Wed, Aug 25, 2021 at 5:06 PM Casey Schaufler <casey@schaufler-ca.c=
om> wrote:
>>>> On 8/25/2021 1:26 PM, Stephen Smalley wrote:
>>>>> On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wr=
ote:
>>>>>> The problem is how do we handle a VM with SELinux enabled and the =
rootfs
>>>>>> handled by virtiofsd? Or if the SELinux inside of the VM wanted to=
 write
>>>>>> multiple different labels on a volume mounted in via virtiofsd.
>>>>>>
>>>>>> Here is how Vivek defines it:
>>>>>>
>>>>>> ```
>>>>>> How do we manage SELinux host and guest policy with passthrough
>>>>>> filesystems like virtiofs. Both guest and host might have differen=
t
>>>>>> SELinux policies and can conflict with each other in various ways.=
 And
>>>>>> this problem exacerbates where there are nested VM guests. Now the=
re
>>>>>> are 3 entities with possibly 3 different SELinux policies and stil=
l
>>>>>> all the real security.selinux xattr is created and stored on host
>>>>>> filesystem.
>>>>>>
>>>>>> One possible proposal is to remap guest SELinux xattrs to some oth=
er
>>>>>> name, say user.virtiofs.security.selinux. That way host will enfor=
ce
>>>>>> SELinux policy based on security.selinux xattr stored on file. Gue=
st
>>>>>> will get labels stored in user.virtiofs.security.selinux and guest=

>>>>>> kernel will enforce that. This in theory provides both guest and
>>>>>> host policies to co-exist and work. And this can be extended to
>>>>>> nested guest where its attrs are prefixed by one more level of
>>>>>> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
>>>>>> will be the xattr on host which will show up as security.selinux
>>>>>> xattr when nested guest does getxattr().
>>>>>>
>>>>>> Virtiofsd currently has capability to do this remapping. One probl=
em
>>>>>> we have is that we are using "user" xattr namespace and one can
>>>>>> not use "user" xattr on symlinks and special files. So when guest
>>>>>> tries relabeling or chcon on these files, it fails. May be this is=

>>>>>> fixable. I have done an RFC propsal upstream.
>>>>>>
>>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoy=
al@redhat.com/
>>>>>>
>>>>>> Looking for thoughts how to fix the issue of SELinux with passthro=
ugh
>>>>>> filesystems. What's the best way to solve this issue.
>>>>>>
>>>>>> Thanks
>>>>>> Vivek
>>>>>>
>>>>>> ```
>>>>>>
>>>>>> We used to talk about this way back when, but never found a good s=
olution. Theoretically
>>>>>> labeled NFS has the same issue, but I don't believe there are any =
NFS rootfs using SELinux.
>>>>> The early labeled NFS work included a notion of a label
>>>>> domain-of-interpretation (DOI) field and label translation as part =
of
>>>>> the infrastructure but I don't think that made it into mainline?
>>>>> It is however part of the NFSv4.2 spec I believe (called a label
>>>>> format specifier or LFS).
>>>>> At present I believe the assumption is that either the NFS server i=
s
>>>>> just a "dumb" server that is not enforcing any SELinux policy at al=
l
>>>>> (just storing the labels for use by clients) or is enforcing the sa=
me
>>>>> policy as the clients.
>>>>>
>>>>> A while ago James Morris proposed an approach to namespaced selinux=

>>>>> xattrs to support selinux namespaces,
>>>>> https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.17112=
12009330.6297@localhost/
>>>>> .
>>>>> However, that keeps them in the security.* namespace which on the o=
ne
>>>>> hand better protects them from tampering but runs afoul of virtiofs=
d's
>>>>> goal of avoiding the need to run with capabilities.
>>>>>
>>>>> If we use the user. namespace we need a way to control which proces=
ses
>>>>> can change these attributes (or remove them) on the host; optimally=
 we
>>>>> could limit it to only virtiofsd itself and no other processes not
>>>>> even
>>>>> root processes on the host. That presumably requires some kind of L=
SM
>>>>> hook or hook call; the current SELinux setxattr and removexattr hoo=
ks
>>>>> don't care about user.* beyond a general setattr permission check.
>>>>         "Wow, if only there was a round thing we could attach to thi=
s
>>>>          wagon so it wouldn't be so hard to pull."
>>>>
>>>> I must be missing something really obvious. User namespaces map uids=

>>>> and gids to their parent namespace. An xattr namespace could do exac=
tly
>>>> the same thing, mapping security.selinux=3Dfoo in the child namespac=
e to
>>>> security.selinux=3Dbar in the parent namespace. We know how to do th=
is for
>>>> uids, and have found and addressed a bunch of issues. Why do somethi=
ng
>>>> different? There's no reason to make this LSM specific, or even some=
thing
>>>> that's only useful for security attributes. I know that we've got pa=
rtial
>>>> "solutions", including virtiofs and various LSM specific namespace s=
chemes.
>>>> Nothing I've seen wouldn't be better served by an xattr namespace.
>>>>
>>>> Warning: I am not a fan of namespaces. I am less a fan of having doz=
ens
>>>> of "solutions", none of which work with any of the others, all of wh=
ich
>>>> have to be made to play nice together by user-space services.
>>> The uid mappings for user namespaces are simplified by the fact that
>>> uids are totally ordered so you can express the mapping compactly
>>> using ranges.
>> True. A useful optimization.
>>
>>> Even for MLS/BLP, labels are only partially ordered and in TE, there
>>> is no order at all among types.
>> Ordering or the lack thereof is not critical to the issue.
>>
>>> Defining a complete mapping of all SELinux labels (to include all
>>> possible category sets with all possible sensitivities with all
>>> possible types...) would be huge.
>> Without question. But you really only need the labels identified in
>> the policy, right? SELinux has to be able to deal with a combination
>> of categories that it hasn't seen before already.
>>
>>> There may not even be any one label in any of the policies in questio=
n
>>> that can serve as the "ground truth" label that can be stored in the
>>> filesystem xattr and mapped to a label in every other policy.
>> That's true with UIDs and GIDs as well. Except for UID 0, of course,
>> but that's special in user namespaces. I'm also not convinced that
>> the policies in the child namespace are really going to deviate from
>> those in the parent that greatly. Writing a system level SELinux polic=
y
>> (or Smack rule set, for that matter) is *hard*. Sure, I can see runnin=
g
>> an Android policy in a container on a RHEL system, but the mapping has=

>> to be done once by someone in the community, not for every deployment.=

>> And at that, most of the policy will be common.
>>
>> I realize that the issues aren't trivial. But to dismiss a technology
>> because you can't apply a specific set of optimizations to it in a
>> specific case just ain't right.
> As a concrete example, an Android policy from a particular
> device/firmware has 565 file types defined while a CentOS 8.4 policy
> has 2990 file types defined.
> There are no types in common between them. Both policies make use of
> category sets for different purposes; Android encodes information
> about the
> user and app IDs into the category set associated with the app data
> files in order to enforce user/app isolation while CentOS encodes
> information about the
> container ID into the category set associated with all container files
> in order to enforce container isolation. On the host, all files
> associated with the container
> are labeled with a single type and a per-container category set.
> Within the Android container, the files use the full range of types in
> the Android policy and
> app data files are assigned a category set representing their user/app
> ID.  This is just one use case among many.

The virtiofs proposal has the same problem. Any "mapping" mechanism
has the same problem. The virtiofs mechanism puts guest MAC data into
attributes protected by DAC on the host. It has a number of other
issues that have been discussed on the thread. It's a clever hack,
but like most clever hacks some clever attacker(s) probably already
have exploits lined up.

If mapping labels and/or policy is too expensive and/or difficult,
what does make sense? I mean in general, not in just in a special
case like a VM host exporting a filesystem to its guest?


