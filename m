Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB3C4320E
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1273D60E8B
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhHYVHL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:07:11 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:44644
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhHYVHK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 17:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629925584; bh=AePBvNLQfL5Se4UJUelgYz3yM6SQrf2UWDyIjjyodyw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=IJ2Nz4TAiC8wY93lGPQNgNcB7hAwYoaTPNSzm94g/CLEHXj2yU5E/KAbmqLCQTpFamDkY0t/spo6mk4aJ8Vb8ZZf2GmsfBeTsiMu7/yxOokKvCzj2gN28FlJ0K+scLfhRtfU5TMoxEuWdoema70IyzOqNPZXihU6s+aj9jSauwYIi/ik2Bjg3YBbloXl1FSCo54NkKz/BvUvGu5olRpIJZRUrlQZeRtzV1uPD47AtKF+j13EmtZdzSpn/Y+kHwvCtlpc2dwc5651i4mAH13w0JdHVa9kni/2RmdNDKGW46rC7yQYVEATInauKGHI8RyDMyERH7z+U8Mv5/kU0A3U5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629925584; bh=SvR1DPQDTZ3gvTA66lEYGy32hGBF7T8DHyMISWoYjya=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=a2JNNivyOO3Wrv+dYkfp4eMOy1BOCTLwXvCFetZW3fGQ9Cql37Dr1sLhMVV0boPUXUkAFXIP31ObWZD03KdLCQp4HP8LIW1h8eXVN8EN4qRtR0OAPWObw6eUNK4MbNJWfr3CERMKqEsTeO8PKob8+YxAVe/5josNCh76mLaqNs/LGL/2QTQBBbppf0fZIDMRF43NPE20vB9p3dw1p2qfAUCSH94wx5908wWZMY4HGejGVQaKSuUzSfl/A0jQNdXDPLjiJSpJgxKAdLmf3rl0uvVnLZVwNmmQfg6B/0I35EqZ6hk+NYGbSbOIrWKyZW7BjEE/Y4bPIMM7l5G3AzOYcA==
X-YMail-OSG: D4tKoTYVM1lFLfCXyW0M_XktLvaqsueEpfrRUHkeB_iQT7fnovpR_PZgft9yMl8
 FvddFFp5I26.vX9HfaxEGMxVD9GwhSGAue7eP6wJV4qB6qHA8dvlb2VVgoXhMnUviMybpmNRfe88
 1lpZt7.9J_aBm4j3nhyw3i9xdduQGxc1StbYaLjSDaA3jc4eIN.TlyKMKx3jblMGZUyu_U4Wi_3W
 ffFHsjIYtXTLLavkbR8SDa8mAgvF2wPj32XVk3_DxCJySWtUhr0MXNyHH.AXMuBbfRKZejsX2.Ao
 JBEP1iYVwbWgoD0eNh2DWkxEYbywZddz1u_fQQpTGxXqdhtNA.JAOviJJV5TUkzMlUz3e2WoEAYT
 jh1o1.9XUVPqhp6UkBC7yLiRn2TNwRYR1lzfPix1lxnsErmr6pNeTza9xJOCyMjTJMXHg3HR_1XS
 UROrl3E0.RVy9ls2M1jiE9oHz27VlS69hHUvck1CN07LVN_oczhLSCsOX9ak_gRo2Wqz1x8bPe4Q
 E6x6I.rzbXROP.3K9BPUt15KfUw7BDPfLJMSJ0ycut6cBsGQEGDQoUzkSLb5fL2cgSckIiJ6VGhV
 w5R3Zea0Kn1QwNh0NKmlrGptneOIlBSojWHLN0W27jMUgDpyGRX0beYLwCTx0ju54fXQMakJ6H7r
 3tinEcxvDq6nAyyQwyFF2LBbk2RWsPY_gQGm358SxyWSi.HTk4qSHyuDDXNNGA6hB4YeWYY5PMJb
 bGojFkzJsQheHpaE8o3e85fflAd_mVwh8sMDWFqv.wbQzOyE3oIEq2yqXwk_zlKvq6HdLiE0tsyw
 wJTZQWTlYk4EZUxjV.zZLjCv_fos7r0Ps0kg8QVvIBUzXE7m3vsCMUOZAzI4xV7bTywiosffm2dc
 DTDHIIMpujo9GjtoDkJ90NxaMXjji4pqwas6F4rPzfVoGzAwbLtEj1kBF3NrR82PN.oznkRzkxmU
 39F1XihaioNrgwoN3xVqlf6WmkrDBNVnx52rlp4WgCdBrl6Siqts4qs61n7ype.Jwiqb1ODcLXPF
 tyGD4HjsiHMXG_ofzE.CwYd74vLRwijdZ_YFfHtbBrdTlaS4RPuvZ39IWymHz1TQ5wFrmd4b_1V4
 BCthoaNw7qg2.m.MYhzvipHP8tQG_V_7vpz.s4XSdpSwjkCVBDZC_irN5lzswuMBgjFItovc4fDm
 8dvPD2LjDw.gH_AEVP6m_cDxekdWbgdyrwUNnyRu9YxI80zy60AzyoWW75mGHZDFYtM1HI0Rhu9_
 L53STJp3zmbhYz0JH5_VI1yRay59YugiPI0TaibKXGTjCgZza..TVaWiVyeRZ_socX8Wx6uE_C1d
 6DocDiKbz5XpQfJOaHUlcBBbFHIU80aBPpgLWYYJypjci1iPOWrj3RfVhqHa9837vjCqCdutn5Kw
 qmM9q_ElbGokYXikJ_Dukwob6t.bZakbOgqurreg48kzWZwm.vqYqG.KwFSwVz7VrtVSS9jk16vK
 0QCD5zTXSUHlHhWlYMwkheYEayt9o2H0Bt4oqi_wmZBcQv1leNJZ2e7EqC.EVUjFS.zQZbVOtdiN
 OfO9jr4stF5X1_.5qhMy4J2eEPmScH3Q_Pbt0WnLXN2stxKrr6TXeEaTs5VwehEzlMLLylgdlVWu
 CYAK_3Wh8TKmMYwg_Kd9IjIgQKDwbKToExNd3NM28.4Y7.E.gzsDy0aeOGKsu01WszhucG2grJVs
 OJ9..V_k9C9Ee3EIfRu0xe_1yKRDlmmo96HWLGCS.zyle2.AxaYA_LQTgWwiagHG5s2.iMIriILR
 5dFtckhI3sY.hiOiqExiKu5g_noSYtK2zgc8WoqU_GkSvKfi6bqKs8B0eDNV6g15eQGtU63VvtT9
 I7D9NmNYYLIzHO1hrubzs_T67AW25S0L_e5xKRWOXKTZeZ7f55cjo6k6div6K8vc5LZJzDvGsLUB
 wM8s9mlmlw8SQyuTTrYL_uuMQHTqifp.Fsw2ibPjRwlLXigp4u_0fUTaFlIavmvV9hg_YXFQ0ZoG
 4lgDhz4w6DInsLs_3UR1LCQDG6D.WLG_niaCDAPAB.rK33v3xUHHOJcZmkxLCcUhi_4f3csd0_Ux
 BzZQjh.8s_VV4C3tNvkVMGCxhA1U54yBPZSvolMxvbmSwZ5UU67QtCbCX4TgADID9l9F..4kSc9o
 NjqftD06tDVhilGzuY9GIpOCP4XTBZ00BmULt5EJac8ENFJplboq3gbCMC8fxzIpBquT83KzpGzN
 1CTKTKy0P6W9xrY0VMfWskSFdys7gMc155wBV7M5Y3nPh5OKqTibP8VzLWmL5LCEpXxB9ZLk4Bp3
 973B2pjPt1lCjx7Pcx_AKGI7K_vpt6gJkvFp73w_m_SHs2lpCbpKxILpJDIY0DUmHC9Mc.BMQYKc
 lZFYpxPnUx898JNgOCd_6O30W5E9zsmbg1Qce9kqmCWEmVnBZ0Tp.CWuW8T5SFLZ8DVCBgg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Aug 2021 21:06:24 +0000
Received: by kubenode550.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3e5ba8c8d32808fa2802f2d470004218;
          Wed, 25 Aug 2021 21:06:20 +0000 (UTC)
Subject: Re: There is an interesting conversation going on about virtiofsd and
 SELinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>, dwalsh@redhat.com
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
 <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5001fd3a-7abc-9163-c912-c7d975c2fab3@schaufler-ca.com>
Date:   Wed, 25 Aug 2021 14:06:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18906 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/25/2021 1:26 PM, Stephen Smalley wrote:
> On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wrote:=

>> The problem is how do we handle a VM with SELinux enabled and the root=
fs
>> handled by virtiofsd? Or if the SELinux inside of the VM wanted to wri=
te
>> multiple different labels on a volume mounted in via virtiofsd.
>>
>> Here is how Vivek defines it:
>>
>> ```
>> How do we manage SELinux host and guest policy with passthrough
>> filesystems like virtiofs. Both guest and host might have different
>> SELinux policies and can conflict with each other in various ways. And=

>> this problem exacerbates where there are nested VM guests. Now there
>> are 3 entities with possibly 3 different SELinux policies and still
>> all the real security.selinux xattr is created and stored on host
>> filesystem.
>>
>> One possible proposal is to remap guest SELinux xattrs to some other
>> name, say user.virtiofs.security.selinux. That way host will enforce
>> SELinux policy based on security.selinux xattr stored on file. Guest
>> will get labels stored in user.virtiofs.security.selinux and guest
>> kernel will enforce that. This in theory provides both guest and
>> host policies to co-exist and work. And this can be extended to
>> nested guest where its attrs are prefixed by one more level of
>> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
>> will be the xattr on host which will show up as security.selinux
>> xattr when nested guest does getxattr().
>>
>> Virtiofsd currently has capability to do this remapping. One problem
>> we have is that we are using "user" xattr namespace and one can
>> not use "user" xattr on symlinks and special files. So when guest
>> tries relabeling or chcon on these files, it fails. May be this is
>> fixable. I have done an RFC propsal upstream.
>>
>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@r=
edhat.com/
>>
>> Looking for thoughts how to fix the issue of SELinux with passthrough
>> filesystems. What's the best way to solve this issue.
>>
>> Thanks
>> Vivek
>>
>> ```
>>
>> We used to talk about this way back when, but never found a good solut=
ion. Theoretically
>> labeled NFS has the same issue, but I don't believe there are any NFS =
rootfs using SELinux.
> The early labeled NFS work included a notion of a label
> domain-of-interpretation (DOI) field and label translation as part of
> the infrastructure but I don't think that made it into mainline?
> It is however part of the NFSv4.2 spec I believe (called a label
> format specifier or LFS).
> At present I believe the assumption is that either the NFS server is
> just a "dumb" server that is not enforcing any SELinux policy at all
> (just storing the labels for use by clients) or is enforcing the same
> policy as the clients.
>
> A while ago James Morris proposed an approach to namespaced selinux
> xattrs to support selinux namespaces,
> https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.171121200=
9330.6297@localhost/
> .
> However, that keeps them in the security.* namespace which on the one
> hand better protects them from tampering but runs afoul of virtiofsd's
> goal of avoiding the need to run with capabilities.
>
> If we use the user. namespace we need a way to control which processes
> can change these attributes (or remove them) on the host; optimally we
> could limit it to only virtiofsd itself and no other processes not
> even
> root processes on the host. That presumably requires some kind of LSM
> hook or hook call; the current SELinux setxattr and removexattr hooks
> don't care about user.* beyond a general setattr permission check.

	"Wow, if only there was a round thing we could attach to this
	 wagon so it wouldn't be so hard to pull."

I must be missing something really obvious. User namespaces map uids
and gids to their parent namespace. An xattr namespace could do exactly
the same thing, mapping security.selinux=3Dfoo in the child namespace to
security.selinux=3Dbar in the parent namespace. We know how to do this fo=
r
uids, and have found and addressed a bunch of issues. Why do something
different? There's no reason to make this LSM specific, or even something=

that's only useful for security attributes. I know that we've got partial=

"solutions", including virtiofs and various LSM specific namespace scheme=
s.
Nothing I've seen wouldn't be better served by an xattr namespace.

Warning: I am not a fan of namespaces. I am less a fan of having dozens
of "solutions", none of which work with any of the others, all of which
have to be made to play nice together by user-space services.


