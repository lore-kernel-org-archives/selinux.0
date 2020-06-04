Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C7C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924EC207F5
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PEJJPLte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgFDP2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:28:07 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:41700
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729424AbgFDP2G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591284485; bh=fvHnScDF/SGevGb22V5BKvq1r1BLb+gsziLKK3GNqWk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PEJJPLteRCOsU6+L+0kTMYd9RHS0j6CwJa86beqE99/dcyqJ5syhk2Qn6zpIZOIfHgkQdhsxda3cWB6155l/3PxEy0j/XT7kOKTHkI+H9c60Qrbb/CLU2uDFfrDzHCYCcFBv4FD0hgcQcKNoWUWA8C7w9auaBhXnHYk4bOJ6UI5ZhVzxxOgp0VI1w0pyzpBVmoHbgbzBVza4ZIFnSqwt2l01oT8DfuLcoi0WfxBha06RDza74S5zoVfos4qCgBtzWM80M7XYae2qE0MIBbcapTK/8RhlZNbu8wSY5Du6Qdj8I5t/jADN0kmjVBeh05CDvG+ZJKE/nN/PUzp3dHyTjQ==
X-YMail-OSG: Z5a4b.gVM1k31C6PLu0q3dtbS9xMdjdold62Qm1PiX0EWbdffyKO_xZVa4cCHhy
 0GITTMHsBVz1GHMG.Y.wA9izLOuapOd70oWCLSn7gUV3q7D4ztDdJY4yxOEQoY72VZmW9a7rw94a
 yiuqBKfRdFmEl4VmH1yH2AjsZ2NpUyI9_QGVWA8yUUReUvTudGwmKZfnwdwEsgUkiEoBVb_EqjFC
 J1A5D6tzNtA7QzLZoLxQwI6hLbuGZKpl_l0450CGtZPGAjyHxnvdLK2rhFSFqMWezcHaUK39R4EY
 6.fK0ejJfFrDBwNkslcpQsPPxvi_2LuoRf1IZZifuOY75RJ971DdxcnXkBEb3eNmqXLfS.DJ_pjm
 vavuS6LCujtrig7JIF9H3ZH2K_BUxf0SpeyVYcdA3uhQT2YTKCtHAaXi5.VHqbh5dfWxM4cMCLJw
 I_vvyh4t.3yaVm3.0Xzi_nUW2S8Tz.6Y08DcRLE.Re0uDWNq3Z2aMME7YXpqYwvVhTJymf6gnXZI
 0NFukxsaZalEdAXVgJ7NVZCxM.GejdAKipvUqGadcw7StsMKWVOhk0gBdkKSrllLJmwyJIz6IGLQ
 DOpZS9HsC4KyQ01LJZbJo.C.i7V5gd87ZuGjlU_Z9jg4CXeTGmJpElfAK8XH4WOQa7MhvFSF0LJB
 73ensEA2KUcVv._0PP_CHJ3tHl.ntuq1T_8HL2j0mSoJjRjMW2QSn4KC5KpoyyFYC2gEmoVLxnPB
 hqPrjQo7iiU.wFCNHXDcoOS48GZPf3DTJEn9wXzM0VNpaDOxg_U3OTG7UZq8njRbqPNcKy88VcTj
 3I_nRDYnskxCAgjNofVf4qcGRwDSNCEBEflV3WmEGfKjMrrD_vuF4OzfySYsjDExZX.5.n7HQ0ih
 OQI_rcJXScOFb57qKskJzq1_d9olgB3FkAr5r44iBO7QgcAf4ebhnPap4VPeO7TIWB_LNWutnuSw
 9UXTFM8J7x73hyoBYJELLIg1zXGaCdI9r4WD3_9UYahKRpdXRi5hEwKmxwTP3WkJAdQ1F2KjgZKV
 7qEhFaKHmZoseA4vp2MxoP.D6qqADH.y5R_D3o7sMZwB6HwKXWcHd4lA58aDif4O6QuR7qo6zml_
 Q_unXPQOpjHvZ38DAZuQHfriesII02hSWoh1FHmYx9bHmt9peZV68T2eQyi2bhTx6S7XBO2r25V2
 unaCp3QUelWtjKzd8QZH0FoPz3426FAuASdJk4CSocyu9SaiZXAJ7Qyc4A0dPJ2rCGe8nCSLb9qE
 VAoO9xcigtFnQ6BLQog.1EPRB2heFtIAoxvAMsQB0aRRPy5o2U0Mt73r_bO4iw8wf2JwqWDIKJT9
 B25xL66EYQWTPMO9UdS0hA1QhRDXGO60NbLL69CcSkn4YLRiTGxRy.YAH6QvsiicIYHjVAuGYQ9b
 _FmQKjOzOUHojzHsrVm7Z_WCsz94m
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Jun 2020 15:28:05 +0000
Received: by smtp415.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 537fff879221c29b348228cad7a8a976;
          Thu, 04 Jun 2020 15:28:01 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <alpine.LRH.2.21.2006040809280.6050@namei.org>
 <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
 <CAEjxPJ49ownvc=3OnvkaMD-oYm-aUta98kKs4LDTJTnm65RD=Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <86bd50bd-b5b2-e4a1-d62f-e5eaa0764585@schaufler-ca.com>
Date:   Thu, 4 Jun 2020 08:28:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ49ownvc=3OnvkaMD-oYm-aUta98kKs4LDTJTnm65RD=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/4/2020 5:45 AM, Stephen Smalley wrote:
> On Wed, Jun 3, 2020 at 6:39 PM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>> On 6/3/2020 3:12 PM, James Morris wrote:
>>> On Wed, 3 Jun 2020, Casey Schaufler wrote:
>>>
>>>> The use of security modules was expected to be rare.
>>> This is not correct. Capabilities were ported to LSM and stacked from=
 the
>>> beginning, and several major distros worked on LSM so they could ship=

>>> their own security modules.
>> Capabilities has always been a special case.
>> Until Android adopted SELinux the actual use of LSMs was rare.
> I don't think that is correct.  Fedora/RHEL were enabling SELinux by
> default since around 2004/2005 and for a while Fedora was tracking
> SELinux status as part of their "smolt" hardware profiling project and
> SELinux enablement was trending above 80% IIRC before they
> de-commissioned smolt. SuSE/SLES and Ubuntu were enabling AppArmor by
> default for quite some time too prior to SE Android.

POSIX ACLs have been enabled just as long. Their use is still
incredibly rare.

>   It is certainly
> true that Android's adoption of SELinux massively increased the size
> of the SELinux install base (and was the first to make SELinux usage
> mandatory, not just default-enabled) but I don't think it is accurate
> to say that LSM usage was rare prior to that.

That will depend on whether you consider presence to be usage.
That gets into the whole "transparent security" argument.
Sorry I brought this up. I don't mean to disrespect the achievement
of SELinux. My experience of the Orange Book and early Common
Criteria era, including the Unix to Linux transition, seems to
have differed somewhat from that others.


