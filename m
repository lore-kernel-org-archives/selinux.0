Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABECC6FA8A
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 15:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiINPub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiINPu3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 11:50:29 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516D45F4F
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663170626; bh=dSiO8AcQeSEJKc32/ycn3OsbitPtGHhNVFiDZzAoPKw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=R0hF17SafV9y4/VJG8SNyxWyPhmaE+jb0S4hz0KQg595gcfFVod9MmHEBOBN6tsEaRKhgejKp3R6skoeljyEqxD3e3A7Tf4VBWhMtEqjKWt9qDbC6nZaVJgcpJ+9lXoHFBrTYyHtA0zi58HUi+sbftQ+HLmcmplAZBQyOpGvYJg9bhZMOKLHpr/Z9zTng0Qwr02Pug+Y8sXERCozH1yZk2Ovl3IjT14LF0ZAanwQC0HVuVVZ3kSDemLNv6h8wB6WcsuKATH9gduBUcANpuH5EAi5lIadO5yV9uDHdX6oF6uM5dgT6VD391f9L+yH0JsoZHhI0TMUkHkX9V5kMbAzpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663170626; bh=aeuSb2vU2GRUnoRCHYpBOCOEHEkfBXKfre+M2qIoFag=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hKce3OMghqGslVDIRcf2U3hEdkBb+UrBOfPwNyJNsB1wCT5S06NeWOkwGxgMrKOSGDThkA3ywIRHSTtUbqM2Vtz4o8WIWJuJdfykKu1wOD6bWH2XMTC06RqMsRkX1lAeLvEPzAEZ+o95+jNfOgnR/7LMDOd7YDwnHHYhzHJF1+HgFgXRKywQZg2zq8D1i1qoRIBKEwVCGL8oRq4lU8r82YXd/0Lws8V7ttY05BqEAa/85OKE7D92PPQ/2d4n9mmfb6oNy3Ox5BMNbr2h5yyKbsseCm+FsiebrXfNNnICw6JxhGx5hEk7dTWUAwPZoMYeN3mj4HrjbtpJ+5xmb76BSQ==
X-YMail-OSG: 0.Q27iEVM1mK.GwQTG8y1C2oX4S03bx8gD974GgQFbV70JhCnjrTyst1L0Taj3Y
 fn2Eu1gvvvCziF_DUapC0Paab9QmsKeP5Dmk_x6iTmeOWOiCRzg2goRY8jrYSpBP5gk_vuJIKwiN
 x2yqVHovhIY1eVo0KqHaASUd7oczRRl6xfrtrQOmuroowLtiYAaLUnTVTwdeMcbt8GW27YKSp1Iq
 _W3rUQWbcNFFcQy3Y111fzHSz8R7FPF6pUBZLCuW4sLkXWcLvN6eIN09Uq4A8STfBFALW0P3g_rC
 SgioqH_gaG6O7.OZQDMwGNCkq_vpgmMMDf5Z.CCrpZqEm4UZHIrUXACYc7BC_ZBfW7WBKYgMkHJz
 rtSJI2K_8.6b7R9r0Rs3YDyw_ZN25OTDBpFlDbTA2zHn9m4nGclJ6QGxyvVsTcWy1OUpKgqy6Gsm
 IMkM5uqf5YD.BJrzom7Y08O0on1soShMoI01yzCNRV0PcqYBWBjvUS_Eokap5hY5aa5UzhnK1jvU
 mY5_YU6HxT1.Db0m_5tn5tCTVucWOQJ0iCNGtrpZhbMgAm9PuQdEfr9mYdAahycBLKrrlHyzUVB.
 Pf4C2veUu0t4MO92KKQD5UHg6Dr1U0vs4pcqab0Ogd.tICaBjwaHxmavk8dRJYPE4Uf.Wf2pZVZI
 tcYGxO8kBcslCSVgGyAGoszDGl2H40uwqKQVo2kkNiouwAc7iH4Dp4baGIkcYJMRPx7isUBwCWwI
 xJAy_qfxCQ8.d50nZol4TR7uSrPprcbD0G61U6C1JhvkNAafPCRXuQs29Ye1Lk48vXuNQyOLw7Vj
 c2Y3qTP5AGzgF50LdTV2BWFPijRTwoKz_L8RhFoSwjUNbPasiCAd4KaWtwKNNH0_.Tr0OZQq3.5T
 JBSeDpRpieo7O7.yYgAbIv86imqbHbB7s4zGKWgP.CAhwFvMV9BhHCQ0iuMpfnOejVDbLJoechwr
 MtXM5uF52EmRXYeIcEM0KXHiwDlZJojtuQU87FWZru5gvDT6YtIgKmLNPzUfulQHI_w3r3H5m_an
 tuv3g7l2oVJDXInxGL6PSJOqsekHEfkhLhrq2D_E9zb8I.EkYSA3.u2PEumUo9e7Yj3cHHol7e0D
 HUOU0Kade5BHT1jd8fuP4x34jtJBHEt759Dfk0eKx5na_dENCwNGiRWjIdKB.0cLoBCALwwFFdPx
 iwqwaADa4xsfVoigrnR6LUnU..Q91WgEOb5oOIMwNd2SHWzxs.Z96GGnCI_w6YqRM3sMjNndPEAj
 LO75P5gvfYu.4FS3T7Hr_S6NUJN9bHgvvlqmZgOoC.J73t0_dzWlH19z89LBlW.IJPaNgCp9MyY6
 XoTkBTqNH2xWJPnuJRNf5cuwi_QuoY7KlG6FLybbCXS46NkxLlXA0LWbaj6eY87yo9TgONIRwkqM
 PSEH24J3Q1OThk1KAj5mMZVS0oPLCK8oWdpP61paxp.GOg3L0HZFhTbGEGGQZkDO2Sp3VOLDgGK4
 IPjn7COsG0U31yENhKke5sXCvZXXoye9TPa38hlepfTpWJeuvEWYsYVWaojdbLmuvfh5Q98Zj3JX
 e9QgcBYBqFtT5b4.xpDfff_WSR04w5LAtwMxy.PKP9GM9ujK2OMFnl30bG36KVrHFniF_qw34Gj7
 cbRtqTZdDCgT4WRUx.GQrj1FF14hs7t1XTdN70rOs1Erj_11izECJAMlnDw5qtTv99wJz93EwuwP
 7GnoLAjjMmzEbl7wqW6Mqwk6GvxH91MgQT79UJ1M_r2tSMdwdFLEm79Jj0romQMoe6LACM.PkiRR
 mxjTZOQOR0jhmVIKZSuKX1JZMbwoZKPtUaqyOdnjsWeQezMOYYNdOzu5iNVSqNW1To0rSuSPicPB
 r2EgVsxlFlUQ4l0.gA6TsCjxpJnLWpOKM828tSyRI9F5NqfonwZ9GmYq1iRG5NA2ucaPdJiu4ned
 828bkWYAcIYKFc1weW0zJbAuPy81kWj.uur1EZsJIQBVVt6lxa48r3YNX_OFNQv0K4O7NV_FI6bT
 9etAbYp9_tASr9jiAvu_cXR28RsptupPaIIiLRZtx7ZA_1w4sYLhLSpTSkgiomTJvCvJcCTAmOVZ
 aA5tpNRIFIKOR.__DmNqH4aGgr0NZIUsoLJ0vrJ43KaInAl_ZcezKS5m7qw4G0KX04idZXL5aIeE
 QYXRCJdhgY5CJ5F5cvkOgtNDtF15epR6HqZMF8E02pMINiqSO7brDR9t4ck0g8sJPPdbZCQ_Jno9
 QQPF3hdEop7oSWSUtY5f6I14q7cOb1m0XD.aJJpSHy2su
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Sep 2022 15:50:26 +0000
Received: by hermes--production-gq1-5499fdd576-hr7xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 28f340b7d83488a4fb70db540ec753b1;
          Wed, 14 Sep 2022 15:50:21 +0000 (UTC)
Message-ID: <7f9ffd77-a329-ab13-857b-f8e34b2bfc77@schaufler-ca.com>
Date:   Wed, 14 Sep 2022 08:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/14/2022 6:57 AM, Tetsuo Handa wrote:
> On 2022/09/13 23:45, Casey Schaufler wrote:
>>> . A security module that manages loadable LSM modules cannot give us a good answer
>>> if there is a kernel config option to disable the manager security module.
>> The community that is absolutely opposed to loadable modules will disagree.
> Who are members of that community?
>
> Hiding security_hook_heads from /proc/kallsyms has no value from security
> perspective, for malicious loadable kernel modules can calculate the address
> of security_hook_heads based on addresses of relevant functions and byte-code
> in the relevant functions.
>
> Keeping __lsm_ro_after_init might have a little value, but at the same time
> it might make kernel less secure (or more prone to memory corruption) due to
> the need to pass rodata=0 kernel command line option when a loadable module
> LSM is loaded.
>
>
>
>>> The kernel config option and distribution's policy are preventing users from using
>>> non-builtin LSMs in distributor's kernels. It is a trivial task to make TOMOYO work
>>> in distributor's kernels if above-mentioned changes are accepted.
>> You should be able to use TOMOYO as a built-in along side other security modules
>> today. Aside from getting the distribution to include it in their kernel
>> configuration, which is admittedly no mean feat, and getting any user-space you
>> need included, you should already have what you need.
> That's a chicken-and-egg problem.
>
> Yes, we can use TOMOYO as a built-in along side other security modules for
> _user-built_ kernels. But no, we can't use TOMOYO for _distributor-built_ kernels
> (namely, Fedora/CentOS Stream/RHEL kernels).
>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=542986
>> Ten years ago they said "Don't want to, aren't going to". Sadly, I doubt
>> there would be a different attitude today. The decision to support a security
>> module in a distribution is serious. I can definitely see how Redhat would
>> have their hands full supporting SELinux.
> Please distinguish the difference between "enable" and "support" at
> https://bugzilla.redhat.com/show_bug.cgi?id=542986#c7 . (By the way,
> I hate the word "support", for nobody can share agreed definition.)
>
> "enable" is something like "available", "allow to exist".
>
> "support" is something like "guaranteed", "provide efforts for fixing bugs".
>
> However, in the Red Hat's world, "enable" == "support". The kernel config options
> enabled by Red Hat is supported by Red Hat, and the kernel config options Red Hat
> cannot support cannot be enabled by Red Hat.

The "enable" == "support" model in consistent with the expectations of
paying customers. 

> On the contrary, in the vanilla kernel's world, the in-tree version of TOMOYO
> cannot be built as a loadable module LSM. And it is impossible to built TOMOYO
> as a loadable module LSM (so that TOMOYO can be used without the "support" by
> Red Hat). As a result, users cannot try LSMs (either in-tree or out-of-tree)
> other than SELinux.

That is correct. Redhat has chosen to support only SELinux. If you want
TOMOYO to be enabled in a distribution you need to sell the value to a
distributor (really, really hard) Or (not recommended) become one yourself.

> The negative effect is not limited to TOMOYO.
> Like Paul Moore said
>
>   However, I will caution that it is becoming increasingly difficult for people
>   to find time to review potential new LSMs so it may a while to attract sufficient
>   comments and feedback.
>
> , being unable to legally use loadable LSMs deprives of chances to develop/try
> new LSMs, and makes LSM interface more and more unattractive. The consequence
> would be "The LSM interface is dead. We will give up implementing as LSMs."
>
> It is exactly "only in-tree and supported by distributors is correct" crap.

That's not quite the position. "Only in-tree, and someone has to want to use it
in the real world" is more accurate. Android isn't a distribution, neither is
Tizen. Having a major distributor include the LSM is a big plus.

>
> I don't like closed-source kernel modules that rewrite syscall tables (e.g.
> used by AntiVirus), for I can't analyze problems when something went wrong.
> If LSMs were available to open-source out-of-tree kernel modules, this situation
> could be improved.
>
>
>
> I think that syzbot is the most aggressive tester of TOMOYO security module.
> But how many bugs did syzbot found in TOMOYO? How many distributors that
> enabled TOMOYO in their kernels got bug reports regarding TOMOYO?
>
> There might be reports like "When do you start providing ready-made policy
> configurations?", but what Josh Boyer worried at
> https://bugzilla.redhat.com/show_bug.cgi?id=542986#c8
>
>   Simply put, we do not have the time to deal with any potential kernel bug
>   reports that would come from enabling TOMOYO.  It would be a disservice to
>   our users to enable something we have no intention of attempting to fix
>   when it is broken.
>
> did not happen, and
>
>   Even if it was 100% perfect code and caused no bug reports for the kernel,
>   it is still bloat and while it might not seem like it we are actually
>   trying to cut down on the size of our installed kernels.
>
> can be solved by allowing loadable module LSMs.
>
> Loadable module LSM also breaks distributor's "enable" == "support" spell.

It sure does. I'm waiting to see what happens if eBPF security modules
become popular. I can easily see distributions turning the BPF LSM off.

>> A loadable module would have to be managed differently from a built-in one.
>> Hence the notion of a loadable module manager.
> We can make management up to module authors, like the comment of security_delete_hooks().
> (Well, I'm not proposing ability to unload. I'm proposing only ability to load LSMs
> as loadable kernel modules.)

Exactly. A module would have to chose between being built-in and being loadable.
Before I go any further, I think that the loadable module manager LSM would be
very hard to get upstream. Most of the arguments against general support for
loadable modules would still apply. It is possible that an acceptable module
could be created, but it would have to address a lot of issues. It is a challenge
I don't expect to accept in this lifetime.

