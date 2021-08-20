Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C0AC4338F
	for <selinux@archiver.kernel.org>; Fri, 20 Aug 2021 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E11461004
	for <selinux@archiver.kernel.org>; Fri, 20 Aug 2021 19:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHTTSG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:18:06 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:33472
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhHTTSF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Aug 2021 15:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629487047; bh=1fWpdU2CPrqbAaK2PNOscQqjqoYvb8KXohSh605eg0I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Y6wozYH4vVxEVD9CmY/HrXb4GrKCuFm2dRdif9i2IMHFemG+hfWprVlnrXBmQ/LRpSFJDHZklb2OgIbMVSS/cHRjiTyTf2MJ38Em3NLPNqq+zVwsvHSr3akPMraVJCOtoxb5Sft/Jwy3coE3D/srV2wnQhJC13iW5NjKA3+Bj/rvUgj7CGfz5BjuL0hRGvf2OwB+Z/96WM/TaxL/jluMzdA30NMo5RkAO2X1emt+mxUoEigkJj4jqDC9y8KxxUWKPHLTPA6rfhzovoaiuWQ340K6BE6+KAebZ9uQza4OoH6qjjFnbPehmUCEI87pIbO20cEZr2FNgtHYsahsB6Fmjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629487047; bh=gC3JD4Jy6EsHzx1dZfhaOh7UQBtJXYB3UERMRaF+2gP=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=PVFaMFAta8RYf4HYmyEWaACIJFm9b7ODzg5yEK6lQoYSM3qIYAZZqJKJdQChxZEw8+6Fw4rvgq45BrQG/VORicXsspm6nCfN88o69DGf0O9wtkAsNWUW2MxTQMLsNHtY1g+bcrap5GLNyZzWpChuFWjjvMqoEWSmJcuaHSEfI03lZwxmMQQGD213w1ucQXmabe8nKqnl+Nat+Djj713GpjCrzFx9XvLW9lAUMb3Uugw/GbfloUg26zTktdauhkl5rHEgFecLUL+/9IsE5XhdlA8CgkXoMxfYeizeoOOD1IQPOn/0RFq0G6bYOIlZiXDc61oKwLxMlaHLwho35+pEPA==
X-YMail-OSG: hnN6PD4VM1mr09KKpedtL9GjzIyxwOB7jgriTMvep2GmgiVZHhK6bJQKzI0eFN1
 vN4GlKjezpWjFRq27_lk3bJZpUeMR3CZnvV3kImAL9zbGCso0pwSZbMpwr1ttNGeLfjTDq1Gbask
 eOMRNGZ33lg4eRnNPwfyg0Dia8WaCtaAxmq2KoxTFWqcLlgI2o5suDueElJaFng8yEFVlhez6fj6
 vxL5bSYnJmcJ1urGso67ossRmMGh5a_DFNBH3j4.l2KRF3rHSSdMZnxgvKEbJALHlSAxPx.2r5Xg
 v9ui6X8smEPL4V7JVEwJF_5jO.9qtN_7IToMysAAL1VR4QqW6Kr8iJq.FpfTmHPvfYZfJBbpxlaB
 C0BvnUKiaxQhwl7R2yIwpPTlWWGgIPO0JpSQyNU7bhQvezPnhlR741EUyUMp93M0E8KkmM3iUsGD
 MSFsjaJ0ZwrAKdOusrRcdN5gVFyAp44wpdl4KRWCpJc1GEMe8JP_NPCWQfk4BIuYeg2cQatYtGDv
 BvnCikQ0KIxrD3NaXBMPI6bFb2KtwaviVPq0U1SvCoi63dYJVc17VoGqY4CP.SU_Os6gsyKb.hEO
 AShMhsUvfHsrzCyZirirAYEwYuUVq00dERs2gxy42VQ0WpChKx8mc9K6My2H9noVgbbJY28lzc6i
 4d4GSpbtfj2.436Rs8kiKOpMo_YbK1j6XqYx955ud36zhs5GLSxG.ukP0J4Z7_ggmPEiNAJq.llp
 fmMZ0C8WMy69GprYkFN8Sv6kruATDwZWkLmy_m1c9r44dljCHFRDdGRoiG21nsj_uQ8lxp0BlpWE
 .D2peEQoBHQg618XMb3ByEYYKyoAWEiJyIIIXq_qzBNbNe2pJKlbvehNbn3MLVwwoRUuXpQ_Qckh
 n837jxIYpoT3vM12swXPr07uflni.ApNjTNjxPSmEdLNE2b0dTHg0XOSbY4HckjIkb4199.DvXvo
 VANCpSKRd8RDgdx85_dpSQ2EJTYYq5sh6MlOPAVYBdhTyZlTObDAxgfIv8xtcBTAEhPCjUgsm_mV
 l.IaYP6iSUwmyQB1AbSExOVomM3MnykRnBFnNYaUkxkV5z_gLy3rdj.s9wyHxBIzdbixXuqvuDS8
 1UFSs0qCvMEteh3QsnD6lLiSY0QIwP5IODiNbHdBlxbbHEZoH3MmHh8BTOMmYghIx._raGLBiXFu
 78d1R68Qc39OuG2wZkc2.x_xddYuFrbCErK96xBWdHOiaOPDAFlXumip_gxpQg2gUIXPhc99N6Mv
 R6O4QsaC73ZJAHbDEFuZX0wDGLaGigde5GkDTnJE5Zsh942a5krSTWvqD4cehdCbIgejMX7.UDDE
 BvlFZv9rJdZteQQOiBXiPFCa0fR5qBYRSq91.l7qEMZ5UIwuhalg5uecJpFLykbSSsjg4OGf5XcN
 BsQfzY5M_lHehow1cps352I_VEANZRag42K.u.RSihNyJp2Fk61CuiX0ef5uiqfrIKy4nDyXieOU
 NPIOD5XFlAVJn7NnAtjNPyuJ7NQVcYNUwUpzhLcdJfmcuCi7O6SqN6MBsWjTOu9mOjpmJ43pJ2SZ
 Pc5XDsctjJ9RjXbcEpKzAXUd.c2YYB8zgDwfdFaA7ZcR56YNCPPJbv129.Hc9itXLKBsqj6t_QbD
 slrvCwVXKyNfjcT3jiEIFWMyWaB6S9JPhXphilq.GkWLmQqMmD.ToiWxvRLFHCZI2ETtjBtF3xXr
 cNpuVD3bWN0fkwFmvMdqeZ67._hO7h4EG.byjG8Mr.frOPK7gEjNqHLwXHnQNJorez4uQbsOjQvG
 5lBkmiKzOr1YBagLX.oZ.q.HNQzDs92GrGHEWE.VFOMrQifv.gKOsjTDX3q6pRnbcjDKZSrymf3N
 HabX1_sTD6Vk02okr1LN9xWogXtyMs7m9ol7.KdP3dfoGuznIenhqwBy4HHDV8wFHo3aMHnB1zLW
 PV0w8IBGEkuz.oovXOeHIU0EgPIfBMwI9WKURiP91p9KsFcp.imbP_y41zY48walLQEJIVDbSzVT
 _WoQkPvYWd067VIAvjJgi4ft3KrkU.waqGfmFSmtK9SovGrlPCMzKrPsW12G_b26gQo8Uw_9AZn9
 YoMmvtCiB5e5MzWFPFY_RmZQoYGihlTcHu6RQ4ApsPuhwDLFdGD46ufbXkLFylIR47D1Yht0bFBH
 aUoEn_JV8w.rM_1iCyATHqumDp2UBL61bnJiqxF_1SnqvBSVcvs0JoDHcJE6j25UpJozgVeJ4Vk4
 kIZs.NHEnyTHK1P8a_qyfUnYNMLgx8.aU.IoUtKGjKPJ5k4fXEFN7Dmsj6upiafDGEtqE4fk6bux
 ZduacGQjUv5PUtNt1fcZfH2XM1Qswhx9LcDCzaVhZ6ghqqLGUBeww
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Aug 2021 19:17:27 +0000
Received: by kubenode521.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e2566f7fc6d27aefb1842d4ed1044ccd;
          Fri, 20 Aug 2021 19:17:25 +0000 (UTC)
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM
 attributes
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <20210722004758.12371-23-casey@schaufler-ca.com>
 <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com>
 <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com>
 <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com>
 <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
 <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com>
 <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
 <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com>
Date:   Fri, 20 Aug 2021 12:17:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18850 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/20/2021 12:06 PM, Paul Moore wrote:
> On Thu, Aug 19, 2021 at 6:41 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 8/18/2021 5:56 PM, Casey Schaufler wrote:
>>> On 8/18/2021 5:47 PM, Paul Moore wrote:
>>>> ...
>>>> I just spent a few minutes tracing the code paths up from audit
>>>> through netlink and then through the socket layer and I'm not seeing=

>>>> anything obvious where the path differs from any other syscall;
>>>> current->audit_context *should* be valid just like any other syscall=
=2E
>>>> However, I do have to ask, are you only seeing these audit records
>>>> with a current->audit_context equal to NULL during early boot?
>>> Nope. Sorry.
>> It looks as if all of the NULL audit_context cases are for either
>> auditd or systemd. Given what the events are, this isn't especially
>> surprising.
> I think we may be back to the "early boot" theory.
>
> Unless you explicitly enable audit on the kernel cmdline, e.g.
> "audit=3D1", processes started before userspace enables audit will not
> have a properly allocated audit_context; see the "if
> (likely(!audit_ever_enabled))" check at the top of audit_alloc() for
> the reason why.
>
> I could be wrong here, but I suspect if you add "audit=3D1" to your
> kernel command line those remaining cases of NULL audit_contexts will
> resolve themselves.  If not, we still have work to do ... well, I mean
> we still have (different) work to do even if this solves the mystery,
> it's just that we can now explain what you are seeing :)

Yup, adding "audit=3D1" to the command line appears to have gotten
systemd an audit context. It looks like user space enabling audit
doesn't assign an audit context to the existing systemd process.


