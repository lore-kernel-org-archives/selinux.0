Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C73C432BE
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 22:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3A61076
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 22:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHYWNA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:13:00 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42313
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhHYWNA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 18:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629929533; bh=TxOx52bfLMkHVoGs/qks6zv91/jXOu+STWsy1olG+PU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=IQmC/LTM+ZaAEfNop3JdHgbzjJ+LxXXfVUQjUeqlJVSIdYWqNsb5NTuvkF8+fsOicI11HQqlocwLRieWLSM1W3Iw8oGJ9xcsy1nRu//xOpQo0omF4CqHXbWz8OMloUFU12EYImEPmdpt+yiF14c1a8ngdM1AK642AzThglSC8cV7pj3AJT3RswJJCi3Gr9YpfwGL5s4R0u0rxhr61jlFtAxJdGxnKjB9CcaIoLs6UZ02T4F7UESCs2s3ccX13oGudY66YvQy/+dFhEMvG3aCfY0fIW9YSohdKHsUZwO+cGuzKN3UP2eCXXMPlafHPtnebYZs9SFv/pYePPRf62mb0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629929533; bh=/TLooV2kiRok+zSzDWpxqvr4XpQOLyvk4I3Xnj3q60N=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=krdTZZNlR/63aTZz6x/LNxgcaY1rc1ecV7XtKA1UvzJG/f3VxCxLn21t5HZxatO+Ye+8Ak/1rRKLBk0axyu2T5g2eaZM7lk7Ea6MWI2RjeVMj2CdiF7VA9s0XEzHrzTa6tbT0uV0UBvGgQzahlTfHZuJnlKCPnl5HI03Irj9oQ3storC6XekzdIIfatFIieMa+sBIncH4qgSrT7IL6CqCTjaQjpzW1oacAHYuppvmnyjcntwcKQihZPWWqaGxmill6HTS88IokubMpWdwnJ3zWmIP7fRrLFcPmqvK/IE27SlHti2TbMcehKcTnnTjsZSc2lK4At/to4gP4DPzwjcEw==
X-YMail-OSG: LElOXZAVM1llEpgQQe9K8lU_CMnkaYGxUU4f2aq6Ja603G3fVSRArnIZJzns2ET
 arbqujEbHxCJEaygAszT9oGBjbb9.1Msrh8RCkGfhV1daYFfnJtiUvhn_Afu0ORtiP2FpU2zOa_D
 gMS_8FfG9cHKxZdbaBYSjmFRKnU3t0Kp33sqTb_ijWAB9oxcaI1lLhxG3gZVN2Il1DzDfXYGvGPV
 00sgTsBeZweDHXrOoItvv_WYdeOCSg1CIFyqtVUBj964aSz01f9BXWcrga9PQqn7FIRO.KuPS0Pn
 sr1F9T2CjgkxKSlcuu9SbiCAfNfQDAXVVdPXH9e.sdzbLdDaOXxjgNGqq3uS1XdWGE_V7I9DsyQy
 pO3wM.hgyRTCNkIbvE_peGH9NwUgN3Ut.F6RDeN7w8RzrPMlD5nE7EezpvCb8fHwiK1bjZh9HLf8
 8btcdAV_k1_t6TcWDg3r00uggV_xdtUzajCevAov4.kYhQmyjJ1f29Xjld8hOxdwdUCoIJ9mA_C8
 YXF5aH6xkLypRNRfc3dWWnIvzSv_lJkweI2Ot0BLQbQG8ExcwXh5gRuX_Rlx7wpZAjnw8HQWRuBp
 zQ74xDGMkHIEbOZaeTNttDatVjOUOs8rECrzYT2jXA1CXsu4AwSmD.AjywkcbEFi44zrmoXjUFob
 lRG4FLmTnDEr9obvUNfDx0M1mdki8mSOGqtTtRJgGKPjAA2BOwZkR928VqkJf2mMJi1Qm53IfEGB
 D6e8pUJvUFplFVZ_4Wcm7ybv.wKyTNBC7CseVIicECvOuiinZ9glX4DXhZSIsP7MDg6CmxDC4DmH
 O8j2nk.qF5qaxatF3mTecFLnMJtwEcxYqr3IGTI8NTaqy7oJFUSEbCR1.ZhAXizczYzdgCexU6cN
 MwX0iZ0D1k7i._ERK5vljZ4a4Cb99U2pXv2_5rwJVeCrdWg88EiTTC24Q7pXrVk0CCxG0bzVrHTR
 OWUFVuyHByAvJeLF0k4aKTTgOiHBN89ai9qfVgaVqPYqSoGFwJE71OZrWcqfLoGt4LpTQ0XpEFTr
 IcwaKW0Zzmb6YA72yfRoD97_j5uhW0pm5EzLrzAP6hG1Lrf7OkiAbB0p8w9g58dsgfW_T1pr1P3_
 swmfRr2m9cMpwO9C62hW076klbI6cBT_xa2pNjKoCyfLh6.obNAT.bVS12vKkD9mLLE2zd92v6ws
 BlNPtn8LOgXv9bVn186Lehha1UwdnNd0r70eK_U1INQeVuPcWaYCraDxeHoayQLxsiHHWmwnjCNW
 QoQoaLslg.sMVvbKeWZpVCEiNhYFsS_ZhVfZKIobRVxVEl.Lo0qzNLVVh8DVtpx6pcNg6o__plHb
 fPupRwJkI1wBXhk8Q055KS2DWzcocCALqI1cHHuQlM6Z6ubZgn8hptJY2UFYlsrWFLVLe3iA3qKr
 ozLqd8RyV416b0527U4Cv0XYxwImLA1W4rXEBqWDlbdoHOQ8LqCDMLDAXPpLyAw4I7PXfcYvL11X
 Q1Nyg1ghsQUOH8s6nCEvXd2N3Fu1texwvOc8XZGHb0YJISToBRh.tZcDRaai1OOZvjokG0cCTkAS
 7qdHWJh3YYr_bEbDMCwGQHIp7yUg89AV6NsKX9h1mtSbXRYXVGT3jH33B259prj9yK8u47xpLkvk
 xcKmo8EL0UW6dfAVZ6_dyivF53QhI5qXw6fXxkxvqgGWHBwOevgLOhe4yxU0XagIhMZXh6V67cI2
 nmy1detSuEQxMtFIB7Esi8ZooMD71RDFyne0POHOvhdhFep0j9Rbdl1iXR1MhS.yBTos7aAVLX8N
 HWJ5Onv8oJhtzMUO4MX6nrN9EtwsEdWHro7TBP0mjEwj3jPnSQiwVmqtuJDNFy7J285YyF7ByGee
 6U6IqxmhJKHNOk3BdnZj_Y_PNfHRoaniM5GJUI2tChKAX6BsmofRKQFYjBSqgnHih_A7wS2KkvLK
 dA50M5E5Sun6l9ChMroOxTbcvIrWHMAjGRq4g1EVFmI_D7cn8hrmBrDTPXhqeO1IDu7ZACy6uiyk
 h_bleFbcRRQF_eJmZhVzVEdMDS9qZiR1GzOd0uTzAr0VSC2eNEpJextMrZf3d89IHg6Ke8Pv97MQ
 NLJrTaHTrk4WCVn9RDWFIEbl_9yEr5akHGJyUJxbBk1UPbGxu.jcRMwqH2uSSUQXAoDJjduclm_X
 w5omPo2n181ucpxcrKv34GXZt_2tmlLKHW8cvR4Hf2LtHytJXQ.Vg1pXKwYozpcK.T3NXp1MPB69
 YKqis_J.jPxE_TJiWPD3yL0cp8FDIEaxTk0MRu02IwiT9scNP_Kh3Lq_Xo6TfWUfh1MYDoPiDZgU
 t7byQRJ5wCPjPVUBiJ_FoYEix0_JL5W.OR.Y5r1UC3.2kqTp06bfGcLZGfC4ciWBh6aSij4v4UUm
 u7ELlDlkMohVTkGvT7VFX4huQafWS4v782ImFCmrtmmSpCLx5ZSn3g3k9QA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Aug 2021 22:12:13 +0000
Received: by kubenode558.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9a2eb63b32d83bb5a3f0d90e77ea668e;
          Wed, 25 Aug 2021 22:12:08 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <74d0e554-1c22-75ba-e427-1ea3501ec8e8@schaufler-ca.com>
Date:   Wed, 25 Aug 2021 15:12:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6dVT5XDh7jJrtcXTA4sfJwcJtvj2LOvXYRWKAz86xGyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18906 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/25/2021 2:24 PM, Stephen Smalley wrote:
> On Wed, Aug 25, 2021 at 5:06 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 8/25/2021 1:26 PM, Stephen Smalley wrote:
>>> On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wrot=
e:
>>>> The problem is how do we handle a VM with SELinux enabled and the ro=
otfs
>>>> handled by virtiofsd? Or if the SELinux inside of the VM wanted to w=
rite
>>>> multiple different labels on a volume mounted in via virtiofsd.
>>>>
>>>> Here is how Vivek defines it:
>>>>
>>>> ```
>>>> How do we manage SELinux host and guest policy with passthrough
>>>> filesystems like virtiofs. Both guest and host might have different
>>>> SELinux policies and can conflict with each other in various ways. A=
nd
>>>> this problem exacerbates where there are nested VM guests. Now there=

>>>> are 3 entities with possibly 3 different SELinux policies and still
>>>> all the real security.selinux xattr is created and stored on host
>>>> filesystem.
>>>>
>>>> One possible proposal is to remap guest SELinux xattrs to some other=

>>>> name, say user.virtiofs.security.selinux. That way host will enforce=

>>>> SELinux policy based on security.selinux xattr stored on file. Guest=

>>>> will get labels stored in user.virtiofs.security.selinux and guest
>>>> kernel will enforce that. This in theory provides both guest and
>>>> host policies to co-exist and work. And this can be extended to
>>>> nested guest where its attrs are prefixed by one more level of
>>>> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
>>>> will be the xattr on host which will show up as security.selinux
>>>> xattr when nested guest does getxattr().
>>>>
>>>> Virtiofsd currently has capability to do this remapping. One problem=

>>>> we have is that we are using "user" xattr namespace and one can
>>>> not use "user" xattr on symlinks and special files. So when guest
>>>> tries relabeling or chcon on these files, it fails. May be this is
>>>> fixable. I have done an RFC propsal upstream.
>>>>
>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal=
@redhat.com/
>>>>
>>>> Looking for thoughts how to fix the issue of SELinux with passthroug=
h
>>>> filesystems. What's the best way to solve this issue.
>>>>
>>>> Thanks
>>>> Vivek
>>>>
>>>> ```
>>>>
>>>> We used to talk about this way back when, but never found a good sol=
ution. Theoretically
>>>> labeled NFS has the same issue, but I don't believe there are any NF=
S rootfs using SELinux.
>>> The early labeled NFS work included a notion of a label
>>> domain-of-interpretation (DOI) field and label translation as part of=

>>> the infrastructure but I don't think that made it into mainline?
>>> It is however part of the NFSv4.2 spec I believe (called a label
>>> format specifier or LFS).
>>> At present I believe the assumption is that either the NFS server is
>>> just a "dumb" server that is not enforcing any SELinux policy at all
>>> (just storing the labels for use by clients) or is enforcing the same=

>>> policy as the clients.
>>>
>>> A while ago James Morris proposed an approach to namespaced selinux
>>> xattrs to support selinux namespaces,
>>> https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.1711212=
009330.6297@localhost/
>>> .
>>> However, that keeps them in the security.* namespace which on the one=

>>> hand better protects them from tampering but runs afoul of virtiofsd'=
s
>>> goal of avoiding the need to run with capabilities.
>>>
>>> If we use the user. namespace we need a way to control which processe=
s
>>> can change these attributes (or remove them) on the host; optimally w=
e
>>> could limit it to only virtiofsd itself and no other processes not
>>> even
>>> root processes on the host. That presumably requires some kind of LSM=

>>> hook or hook call; the current SELinux setxattr and removexattr hooks=

>>> don't care about user.* beyond a general setattr permission check.
>>         "Wow, if only there was a round thing we could attach to this
>>          wagon so it wouldn't be so hard to pull."
>>
>> I must be missing something really obvious. User namespaces map uids
>> and gids to their parent namespace. An xattr namespace could do exactl=
y
>> the same thing, mapping security.selinux=3Dfoo in the child namespace =
to
>> security.selinux=3Dbar in the parent namespace. We know how to do this=
 for
>> uids, and have found and addressed a bunch of issues. Why do something=

>> different? There's no reason to make this LSM specific, or even someth=
ing
>> that's only useful for security attributes. I know that we've got part=
ial
>> "solutions", including virtiofs and various LSM specific namespace sch=
emes.
>> Nothing I've seen wouldn't be better served by an xattr namespace.
>>
>> Warning: I am not a fan of namespaces. I am less a fan of having dozen=
s
>> of "solutions", none of which work with any of the others, all of whic=
h
>> have to be made to play nice together by user-space services.
> The uid mappings for user namespaces are simplified by the fact that
> uids are totally ordered so you can express the mapping compactly
> using ranges.

True. A useful optimization.

> Even for MLS/BLP, labels are only partially ordered and in TE, there
> is no order at all among types.

Ordering or the lack thereof is not critical to the issue.

> Defining a complete mapping of all SELinux labels (to include all
> possible category sets with all possible sensitivities with all
> possible types...) would be huge.

Without question. But you really only need the labels identified in
the policy, right? SELinux has to be able to deal with a combination
of categories that it hasn't seen before already.=20

> There may not even be any one label in any of the policies in question
> that can serve as the "ground truth" label that can be stored in the
> filesystem xattr and mapped to a label in every other policy.

That's true with UIDs and GIDs as well. Except for UID 0, of course,
but that's special in user namespaces. I'm also not convinced that
the policies in the child namespace are really going to deviate from
those in the parent that greatly. Writing a system level SELinux policy
(or Smack rule set, for that matter) is *hard*. Sure, I can see running
an Android policy in a container on a RHEL system, but the mapping has
to be done once by someone in the community, not for every deployment.
And at that, most of the policy will be common.

I realize that the issues aren't trivial. But to dismiss a technology
because you can't apply a specific set of optimizations to it in a
specific case just ain't right.


