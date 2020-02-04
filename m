Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA40C35247
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768E2084E
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 17:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ShmKIUH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBDROw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:14:52 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38832
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgBDROw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 12:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580836490; bh=B3pWg7wFR2gR8/KuQNCSOT02AyMV+tggSbmOljHhI1M=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ShmKIUH2xtCYRBpj7nwzzor3FP+ycjKGB7QMepaRAP85889+OX2OEtVsWCOYfo5E8h058HXgbL8HoS5k6pHsIVEmdGCQXYXP+TNskT9bz0JTa91m6Nxp9Pz53movHEdAXhYuYTdZaCDyxkq7ktizx5FuEFTJKKZ9sU5fSkW1g3XZxkzKySGYVSHtJ7377MAz8w1nCD0WjG3JpcfFZEJFSzwuEVSgt4v4zssvB6R6K1jlH8H/ouC8+mFnfznx0tEgvR28i1Vk/H/vxpaBQo8L5cNpPbD5+dcE0dSe8UtIQP0KqikttE/cr78XwAVb/27giUq8PitTizz9hQGeJi6cBw==
X-YMail-OSG: i_Ls9QIVM1lQbZ5hqz.JR2ut88dWBdFDNoZsxIC5Z7TjiRqIbMlv70s5HNlmnkv
 JxDEExebpn68ep3geAGIN5h5VSrYB4XnDn1LLPdqBs6riVtJtiE8nERfwTzPIv0bzmG_ULYAl3da
 b1a1tLVLWglofzruxoX8mjKx.mewOfjVjEj1d5WtI6rLe9qpYiC.2abONprmruxBM5sroNn.lc_c
 bvbWWrE_V9W3mn8VSbSmNBiQiQbCQtBfm4a_mbBqHfG3W3uxZW9u8rX1hNAtf5TTItNTeedC0Q7Z
 jl5ITGd9I55PO7.u1ACH7R1Dq1nwS9W1W6ExxC7cZ8OEqwf_PRXcKNpk9I5V0MXeTajGevP4hovq
 WWoTazE4VrPb9Xy_zbD7BEib9kenRzGgisGktVXNqgoV_VUGpGjpHXzReox3dUcfi5.gMyNimq7a
 XbmlgXp2FgOzXh4v5N_6guAwnsJlTK01m61JMG1RyiBKsLtovamp2pxeUT17vED2Ltx2Vd.iDjkK
 oC81IjFrlNihi.PwtGNkG9jEpJ.MQI0pzus.wQ5NdDYZ1US_yW79_0dG5TwWtFoXAnil3p13U54P
 xoH5uhBEmH4FhyhdHj4MlDmx1KP1.wM7.RUvV.yk0bprRlmgLaogNnH8ZnGuiXyXBYL6zmmaM.rL
 78_lvTAtc3LI68vS_QnIRPAnMR2pMF1T8SxwUSq6EhXTQRixP7y7miY2VQu37ae6k6_hNlHXWGsT
 uZ_jbOV47JT2IpCr1z81IjC2ri.OgArrPKw.ON1Csgyapg3aNlGYfuDoBP06beLodCj1cQGAS6Ei
 mFdxVo4sW3hV.OmR.1TclnKspSzGE41cLAktFYGiaW_GRRBk5BNs1jOoMpVYucRRNoNdxCHSllxB
 hyQnus70vfALcy7nxdbO.zU1bNmsG59zc3F2Lca.PNVZBd38m3wATtxjXdeAzlkng4WEPzm2eTVJ
 cAkzzwGPKeDB.v2FKAj5Ff.TdTdH87BAozy4XUMKr_SjwaUPfsDAq5Bn6kxez4W0tHpIamhr.Qub
 vbWz.wgok0.KR9o498yEt.Mc3Qoj.RZRuxSf6LUfWGoUS6PusvPMvr0U.Xa1CCMNF20sFoAa_1e5
 tZWL2XFbNYbL3mGo_9x7OdiG_3OeboRnyB3csGmhHSywDZ6oPh25qrQdhV_KqtIwkbsNaha2n3Hj
 nDHqekBSbjs4TKfwi_m2NBLCEe2woGkGArRpv08LxI63Ait9XGKcMGPd9HtvUFuy0OmJ1IvqNdl8
 CIlzEe8JBmJcE0_J8QUJWfvvwVo2bR97LzUEiq349vHTVh3bNU8A_kj1cDwhyWkPMtc_BWn.lWH_
 RXjVbuyC51iHwvg.4.fyA3m9NIWPm1jb6oQFhwlWYumGFjvusEAMYi64z1qODtVmUqVhzqtR_o.F
 PVAaOz2_IJdfeLb6MN4IvmudUYgLvD9I-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Feb 2020 17:14:50 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 26caaa4df940cfe3c62d5a7f9873f224;
          Tue, 04 Feb 2020 17:14:46 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <cdb0ba7f-2863-d721-7ec2-1e01464e2b41@tycho.nsa.gov>
 <7ac0fa7d-225a-a554-bc1f-78d4d07b8adc@schaufler-ca.com>
 <9a07bf65-c0a8-6295-a3a5-ac1817385891@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <913132fa-7318-bc6b-1ebb-5463291dd916@schaufler-ca.com>
Date:   Tue, 4 Feb 2020 09:14:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <9a07bf65-c0a8-6295-a3a5-ac1817385891@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15158 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/2020 5:37 AM, Stephen Smalley wrote:
> On 2/3/20 4:39 PM, Casey Schaufler wrote:
>> On 2/3/2020 11:37 AM, Stephen Smalley wrote:
>>> BTW, I think the above guarantees with the exception of no trailing w=
hitespace and whether the NUL byte is included or excluded from length ar=
e in reality also required for "current" (and SO_PEERSEC) or existing use=
rspace will break.
>>
>> The behavior of interfaces (e.g. "current", "exec") that are module de=
fined
>> is only of concern with respect to to "display" behavior. If a securit=
y module
>> wants to provide a variable size binary blob in "current" I would obje=
ct on
>> principle, but policy as I understand it has long been that if the aut=
hors want
>> to do that, it's their call.
>
> Doing so would break existing userspace (not just LSM-specific userspac=
e), so I think it would be a deal breaker even for new security modules t=
o move away from those guarantees for "current" at least. procps-ng (and =
I think procps before it) directly reads /proc/pid/attr/current and trunc=
ates at the first unprintable character.=20

An user-space that makes invalid assumptions about an interface
can't implicitly define the behavior of that interface. You can't
declare that "current" is defined to be a string just because a
developer looked at how one security module uses it and coded the
application accordingly. You can't declare that "current" will
always be a SELinux context. That horse left the barn in 2007,
and there are still people writing code assuming that is what
they're getting.

If the sub-system maintainer, James Morris, is willing to state that
"current" must have a particular format that would be different.

> systemd's sd-bus reads /proc/pid/attr/current directly and treats \n, \=
r, or \0 byte as terminators and truncated on first occurrence.=C2=A0 A v=
ariety of userspace code uses the value obtained from /proc/pid/attr/curr=
ent and/or SO_PEERSEC as something that it can pass to printf-like functi=
ons using a %s specifier for inclusion in logs and audit messages.

Yup. And so far no security module has been foolish enough to export
a binary blob in a /proc/.../attr interface. That doesn't mean that
the interface is defined as a string. It's certainly the convention,
but nowhere is it documented as a requirement.

That's why I'm putting in the effort to define the format for "context"
and SO_PEERCONTEXT. Interfaces at the LSM level need to be defined so as
to allow the underlying security modules to provide the information they
want in a way that is unambiguous and application non-hostile. The help
I've gotten from you and the rest of the reviewers over the life of this
effort has been extremely helpful, if not always easy to swallow.

>
>> The "context" has a defined format, and it would
>> be up to the authors to come up with a printable ASCII representation =
of the
>> binary blob. If they care. They're not required to provide a "context"=
=2E
>
>

