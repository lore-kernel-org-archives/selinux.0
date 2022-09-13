Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2CC54EE9
	for <selinux@archiver.kernel.org>; Tue, 13 Sep 2022 15:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiIMPmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Sep 2022 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiIMPmd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Sep 2022 11:42:33 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862384EFD
        for <selinux@vger.kernel.org>; Tue, 13 Sep 2022 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663080330; bh=xX0n8aMxcKLVrzNVutssZDYEiwyWWqVsdzBkM3hViSQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gYvhLSvm7+5zdsZpf2fslzlBtB6SDypbNtjkRnT2UgZDi+ddZWr7iBTOSv1Uo/jmfUaotN/fxfMOVDCARqxpBkYlYFceoWWoqs0usPK4xq3QKQ6Mix8XDwXtUp2bnd16N0jOUmrJsY8uD6J57vz/SL3y/5RGesHKVLjGbsVvsfmNsa+In60sw3O27bgudP/eCP6WVigkWG9X6lyb8zI053mp7VXkVSydSc+YfwC3fZdj3GPZLXzh353zbRR1CeFn59Osd9L+KwoAS9GXQHHp12x4vogEndXK2YZakfciuI2PlZp8DFLvSwgbe9bE+B502VMMH+mZ3+qewM87LoNsMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663080330; bh=LBNy3KO71VIsEmP96lKp1K/Dw002mFiomysExQPHfMA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LoclnxdTZGG4GfAT4ulxlAgJhARvJBU1wEc4q6nV8CZ62afWJ3TZ3Y7RXWgHuEnXBlGFYyyR/jVGTaMLY7VskUJkPocxzlv2kIF/9kwDGzcoXAawAHSsp4HifePmu4dUzg5fbND4LvNa9w3cyHhfWu8Aqe+fLH0/vW4uxi2By9UKfS4+6ORazOb/m/AvezeW4558vVndlhF1dw0fmEC8pEENq5dei6y9/O8KnNXRjI5sGCgdDq6JRq6hyFdcsmBAZagyh1pMyl2xyjkRzcxfsx2CU5KD/RhtR3dcnCwDhbhAiSRWJg4IPa1mvkQ5BR437/0gdELby9vmfjZQSKP2SA==
X-YMail-OSG: VVrdZMMVM1mwTm8PPy2VzpTRjPBo0siiWgL4aYH22NF1RxYNICSOXoP9HEJCXOS
 tt.1b44kZLKx5WspLe7B.6BKWcs09a6wTpFkOfir45x4SwJsyiDcRl9fWg13T4.2vIusuEaQ5VPL
 3.wi9hUZGqRry6UX5bcWfH7OXARnNhJzjGcIxG9VxSd4tRc3HECJBm9PLKKeNwC222N2ZaWw5n4T
 94J.HmUgEjZC30iiCz1IZ6sQfXvrDiPJWUYoSLyu9mZrastOBOo7.j5xV8QBELJs6ysdSTxn3izv
 KyZrSiKv5CssTfsrenNKCSDJH4.cD.Ebfb.bYf2yKpMqIFoq2449FVKb8SOAJj1ZerViSfL7JCrj
 eO_Z0eojY02YBGTybaZmYmpE1VsJtff4WMhzTVs.zSpNf294pcVaEXDvxl5DVtYpBtPQ3UjClvTU
 H5vmjk9abr3JfLNktwlpkG_wGfVXsfBTCxO8KWUR..X4GxaFOnxQq6mSVNjstBkL4tx8hPWGulQV
 S2jUduv2z8fBa6DGWRBFAhLITR0vXRgFb.EwjNijYCU.v.9a696xkTuhxMlnFEnffuVKwdCstGg0
 BrzNIZ2nuyz1X6DmdlF1ELmjOOLHm9Fja96aHoy__FJ_dGGnsM2IaWBDywc6OLxlmjbWe__FW768
 JUvKTe8vJaBLnX3oJkdlwM5rV3Rc.G77nkaeEE.j8v.B6IXXXJG0vNfDZEb3IT7F_Slmb.XSUBGi
 gSmuTw1ET_Y694dDb9YCB69XiFpJcAfLkq5gWQ1Eko0mjBdgLyb.VXSKrr1IHH9U8orI3r.44guA
 kgYp7tCoZ1I1anPO12JrC7zMHMtROR3prTp6WTxUtIiP54zRm5fwa6T.DoznkumHIx.eGWUY7vzc
 BW6LBcIhhccGlH1rbqTklQYqsdnyaN.T4Rem1IKmdxKqa8zkKT2IH2q7CtP0gTbwpJSHCaQG9c5T
 58rIxqEJj8LSej1sKHFwWokQvzzbbct0m4hHE8jhuNZ96YBJJEiCYdjlUhcC4GjIgJCiwcrhRftf
 U4bReVESvbrBBEQQP65F2EFfChJqY2E4xJUfqvY9oQFh0WSj.FnaDlnXQsc5bNNF0I8JJeOLNSk_
 hzkByBqkqkEdlDpztZvpZH_lW9MMMVQCIgRS7i8.Xvzi9bhrABTvrsj8Kn0ycdg7wcfNgxIFRZ6i
 BIJ9UQq_BF79Lq6dfxd7FgTr28iCdqq.aFgicx2FuKKhK7Al1n47sPM6rbPHQwDi5drcxJTOTKoG
 Ztq7Ecbn4o08MWv9Hx4XQ7w.y0EB6SHlYOa9wvR9HP.lBfKXLOFdoEaf.No8pFBqFjujgWsjKTW0
 Y_C1Miqdox.sAlVLvMB41.K6pHJUxhUHIou15UNGE0mqaLIQ9JOrlQppdxdLj9d05GkeL7Irp4ke
 90MLs0TnvVCUuxRfGeCNjx2DLp60tgMMWIocVbDkFKaJQCv5N5hoGzM_WQR5LU0Ru6PMeq_aV1to
 nc78EgXUl1ow5MXG3.r8cdNJBA2jhRwA6LRAUYRxe9JUkcD8ECb0WrLkQNhq_WYM9SB2IbEeoQGb
 SbCt_yZUZm3xhgeE1By1hAkkf3bhGX5OPqTgmoyWaxI0ndFoQxI0rT558UUAzKn1Otyu6dN3xTfw
 hKJq7m2hD2QmDvNB1JfeBzXaW82INSGLmgTvXi5UJWsmN6pLovrZyTvepEdR_EAYeXzDH8XavygE
 cj5L0FZhSz.i8BMCox7L8XHuHs7HJVgb0RtM7KYAjW0T3FoeC1PzCAqXO0yZEp3IRFrQQMcmJlMN
 hNNHsBBhyj6dbs8cI483g4Wy0DP8hVngrEjS6SyFT_uUQ4P.stk12wQ4Pu0eVlr4XBvsWDle_iuJ
 MJMkJVYMYjGD7kMyEP.rCla3JyjpbAgv_2Pf2HMCKMBGAg_QuI.8mIMEeDLInaQbmEphxYYyZVlN
 OnNiDEy1EIvv21WOlEmSqfr1qWer6aX_3UkrbxnIwczC1tCpOxSj0PgTSh5TYwnifTNq89rP6J0w
 6NtcsTtENoZ7g3_kxcG3tQsGls06LqWX_9fUcTDUxopwGtWi4kjsyCvPtZMXsXy96.mN9UXB3N8M
 4cnm3ZVGU2.PhXUXZEuMepgEi8EMzue6mgPfhjdqyCtHuHb1hygB2AE0clv9d6Y5qwxvhan6bGYb
 pARXCZrI8unuu5WV4eOGDVYAzWDsy81VqhEwmFFTISzNaEqiC37gz68JzRQpcXCg1G7tsaz2GHkI
 .i3gNLMB64pHihwe9RiaC917wJK5Pqf_AdmIcmdgkwKRa_Pt_ZJtO
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Sep 2022 14:45:30 +0000
Received: by hermes--production-gq1-5499fdd576-hr7xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 65e171da19301c2efe59f691c4d9a003;
          Tue, 13 Sep 2022 14:45:25 +0000 (UTC)
Message-ID: <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
Date:   Tue, 13 Sep 2022 07:45:24 -0700
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
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 9/13/2022 3:47 AM, Tetsuo Handa wrote:
> On 2022/09/13 2:37, Casey Schaufler wrote:
>> That doesn't give us a good answer for loadable modules. The last time I looked
>> seriously at loadable modules I was considering that we'd need a security module
>> that manages them, very much like BPF manages the eBPF programs. Loadable modules
>> could use prctl, or some other mechanism, but they would have to be different
>> from built-in modules. You can't require built-in modules to conform to the
>> restrictions you'd have to impose on loadable ones.
> What I'm requesting (in other words, the biggest barrier I want to solve) is
>
>  security/security.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..ed34e25af22b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  };
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +EXPORT_SYMBOL_GPL(security_hook_heads);
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache; -- 
> 2.18.4
>
> and optionally (in other words, the second biggest barrier I want to solve is)
>
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index ed34e25af22b..4cc09e6cb32a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -72,7 +72,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +struct security_hook_heads security_hook_heads;
>  EXPORT_SYMBOL_GPL(security_hook_heads);
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);

I don't see either of these changes happening. I'm not the right person
to argue either side, but I understand the rationale for keeping them
private. That's why I think we need to have a different mechanism for
loadable modules, and why it needs to be optional.

>  
> -- 
> 2.18.4
>
> . A security module that manages loadable LSM modules cannot give us a good answer
> if there is a kernel config option to disable the manager security module.

The community that is absolutely opposed to loadable modules will disagree.

> As long as the death sentence remains, being able to disallow loadable LSMs
> is a very stupid decision. If a loadable kernel module were malicious, that
> module can do what AKARI/CaitSith are doing today using more disguised code.
> There should be a chance for ethical loadable LSM modules.

My understanding of the argument is that while an in-tree, built in module
will be subject to appropriate review, you can't say that about an out-of-tree,
loadable module.

> Kernels which seriously need security should be built with CONFIG_MODULES=n.
> Kernels which want to use loadable modules (not limited to LSM) but still need to
> remain secure should consider using e.g. CONFIG_MODULE_SIG=y.
>
> I consider that real bugs which may crash/compromise the kernel are reported by
> fuzz testing. Rather than disallowing loadable module LSMs, fixing real bugs
> should be the way to proceed.

A significant portion (maybe the majority) of security work being done
today is based on the notion that we can't fix all the bugs or exclude all
the malicious code, so we better protect specific bits of code from the
rest. Fuzz testing is a wonderful tool, but won't find everything.

> >                                                     The Loadable Module Security
> > Module would have a static ID and somehow multiplex what lsm_self_attr() reports.
>
> I don't think loadable module LSM have a static ID. TOMOYO/AKARI/CaitSith are already
> working without "struct lsm_blob_sizes blob_sizes", without /proc/pid/attr/ interface,
> without modification of userspace programs. TOMOYO/AKARI/CaitSith are designed to avoid
> interface/resource conflicts you are trying to solve.

A loadable module would have to be managed differently from a built-in one.
Hence the notion of a loadable module manager.

> > I think it could be made to work. I can't say that it is something I am likely to
> > get to soon.
>
> The kernel config option and distribution's policy are preventing users from using
> non-builtin LSMs in distributor's kernels. It is a trivial task to make TOMOYO work
> in distributor's kernels if above-mentioned changes are accepted.

You should be able to use TOMOYO as a built-in along side other security modules
today. Aside from getting the distribution to include it in their kernel
configuration, which is admittedly no mean feat, and getting any user-space you
need included, you should already have what you need.

> https://bugzilla.redhat.com/show_bug.cgi?id=542986

Ten years ago they said "Don't want to, aren't going to". Sadly, I doubt
there would be a different attitude today. The decision to support a security
module in a distribution is serious. I can definitely see how Redhat would
have their hands full supporting SELinux.

