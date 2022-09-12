Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9228BC6FA83
	for <selinux@archiver.kernel.org>; Mon, 12 Sep 2022 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILRhJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Sep 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILRhI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Sep 2022 13:37:08 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BB2B192
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663004226; bh=KLKNmViMi7f/hzibKDRfXD0x7YGVVUq3hfLJgyk5rJg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lgZnw6pJAYb1PELUDNKUm1C+OSR5rylRV0MYR1gVdCvvzkEz+mJu1eMKOPTaYW//2H2mv40tA4mvogsBYiKeL5+Fx6KS9obo6OGqZxiVCrPfIbGUmSXDUMINe3NYjoySTLpxqp+HkhZ7X4Og8PGYSpQVHCWfz4CaLK4BpOBsC+BnWboZoODquT9Q3yTq6LVztg6MwVxKw3R0+MUzYYJEb4yU5VuByjXkMWytXoHYBAbme2KmkRxw2iStlUx8KOQ4rQmy220GeLx7Gn9WSGLuBkyttLsbNiysPSeMGi/2sxNq8Q7EET8cmcTILFea9e/tm/6LohiS6uKZDGnNKmeUDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663004226; bh=CCRHfKgdepgNRfF7+M7nOiFifgtrerIzgdMW2pLDMCG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Mg+EjUB+LJUJzOdtqYDssdLPaCeGmbkI4sBqP4lOcOJ6XVEno9AIXOzimsoIPf5EBXXt8D8EtuWqZVs4NaAxfxWawA4ogegqTv9AhGPlTBAJZx0w0ICiIC9q7IHoCfPtmTD3ryucVRrkdJudVepB6I+0rF4FQmBlreqFA2eGJ8RqqqN3O/NnlhrNhGsynAfQaMk0oExTTiOK+m7Ts4kFi6fVWIoPNdMjV++2itxjTLoIwmscFGQcJZ0sBsONQYXrQ2wo5XjKKTTEdpgY1/tEe92+6o+SF0HXItIhqKfZbKioVPEtbps4Vjo8YYvRChzXZ47GTQ5IlchvrMeY2cSBrQ==
X-YMail-OSG: 9VT2bpEVM1lnWlboqelA4Ik2zUJtINoLL.YV0BmdTQNrvOzQpb43tEVwRygQqIP
 YnmYaXESf9iGpmZlsXJQFFgbFWYttTNz_unWiG1TFuLzn.EuYDgI5CKmkMX16BuKryP_ysGh0o8v
 50GsVTSxNdkzUCzVGL7XjYBLEDOaVfOLPi8f_5PUG..ktunUU..RBqFBgATi4jnPdsZsLvCbc_v4
 _X7i8Mu3bQekGXpj7Mgwonpc9deGKQYo6FfGnn20IxaZIcEQHe_U35vtwYWBUwatRDniEkPX8dq9
 VyEzPL0j_9zJ7N3yWdxyL33SXKTd560Kw8AvBnB.wUsDkE4LI9EmEZlZsZcPXh0J8xh.JwVQO1gh
 VxOJcT4GgGhJPd.5GRA5LVM_j0aHKOfAWcragIXMtRnBqdEJaEsg1AmPQaVmzmi03jwgm80w3typ
 vz2MfUQQQIrkx9ou9lTPUg6IHU7gVF44r.qU_WQ6Uc26CJRGZkna7qNricAgbX8j7O4gbpGQMYYE
 aoRpEuFfOmrpCiWL5uJXswiNI4WyP8nXGBX5BoIwCY0bPBlQGegypZfzGvHXnmttVJGZ6eZ5u7zq
 z.szxp7K11Ca3KHc3EfSUgWnvusdu6GococPGidSPfwcZJOprirZcUgabOvTR7VD6GbG.ZraUEyN
 P0ujatB8vdmAbp0CVvoO4kimdeg89ES9UiugVeP1wjtWw5ruIknuHxs3ylSDWZ2GMWOSFFw.6YnC
 BTS0xHGRIaocNb9PPRRg2HPsxeuG5l5kxg6m1kyGbz8OoZo01BCGExl5.qVhzdAGz.TmvjskoER4
 MozPu1LfVeEvOG59RB2EEpcQ7vnEtB8y4GabxgELFwLbdM4Blu0QIesfRjH5S.dxQpDnyr3zmDEe
 0Cm5BCM8R4Jwc2ms7SzsF5BcsmZwhPZEVo2Gf8W4F.yDvPh6q4x25JLDWrPbZTxB1nX9F58U4Lyc
 1nFfLpZkwogOEV0mwnDmbESA1qXPqpDy.AeeW113oAk3xOBh8Oor4v1A6ghqHi_xN1QHdnXa4LFC
 L3b6DfN4EiPFBflDKsNuAsXTbUpudpN0N19SSGIHGnWga8EG1GplBWkd8e.jH8C60mcyGiYwbI5h
 pIndr1kVvJcmP6fq_y5hSO1huYFSxd4DTdnQrJVICzeNznzxDMsEiVtNiv50ayUuG3B2BU1XkX7a
 JCRLn1NVstWKzFkkaA3BQVnM9etNzAI.TWoETKyu9o.yxt08Ypc0n3QU3Yjb64gE1_XWcbKLVfwM
 iMOMvqFVurDUaA8hVDtpSLYL5iL0RNAiJt43j2PuG5v8ySpFO_J2HhIszazPVI8xmMlee0P_e.dV
 TpIBJ0V7SEYT_PTp72iAKXYSFctR4DDgwHnOES9WtSJB_bQjkr_17Jv2bkK8wu7Wrz64jN9QKLnf
 c35tJXB7OPGFVKhs9gEk8MyvwpE1N0VcbaWZCMAilVzYEFffKCmw0hvci_NX7_PbSsz9CamNaxAb
 MJRtxlVySvxRxZ0Ii.4AU3CRqDoeiFHs_pPgeyAQFptfBOmSgIhMogNn7Hcx5mrugWiA9NSO_Edb
 rY5kABQTFWOIUOyGwKtTjjjhIhdoy284roIrVTYCDxgi5RLelnyOJelWpD6ExCycOuCTQDm47gED
 M91mUp2TO4lbGgEdWdpa2Y9fAOBib4vNdF_P50vjYovYPYqIcPWhHiKTFwXgJO5p5lP18SllIeIe
 8Ov4ObHlFAB7PEnCGnf1MOlqed4G9KwPVLZ1HHodFGgiPqRyq1PLvBqn2bxT3l2MGYiVNOGEAmOz
 _Nd5toS0own6ZjUFW5VVhXW4dCP3Xv5IDnS6DDDTiZuh3zCjK1PSBZ9LOo9o7qEkfesYFqRyE3M8
 OmwpGoYCo3UcM4I.KL8I7ehXVv8OOnXsurjM4nCvFEK1sfBtFcwqkvW.cubsZAMlA2mc3g9591ih
 waOoQwKmpVFjhgN75t.e9jd4vAfnUKoMP7MBl8hPOi8Kdv3zbdD3MwfCWsysQ6OHA8YjP26sxOyr
 JwT4vvtQ8TbZUIlp5pQ_VcYYEm_oLvMytyiKxvosgGlsMXUW9M2TgNjpOwh_oOPcwiEGyUQD4Uk5
 qAvPwE5fuls2AcnBa3ryhAR4ADOGi4_rPuBjzndp5XZGMhEbLixIsPv9wwCMP6NgKwP3b8Wsuvmf
 cUF3J8UdFFErO_H8tckzJp0B035dQHQtVwZfpRCBeSE6EdAFUp1BfJblP.khWIK1kClEDMjZcmdA
 77ozz4bj0yoHXydUpFYCXq8feRzNZKZ2fZUge4usx2jH1pwCfp5YqHw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Sep 2022 17:37:06 +0000
Received: by hermes--production-gq1-5499fdd576-g4rmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a109b2dcaf2570c87d0d1765d874225;
          Mon, 12 Sep 2022 17:37:00 +0000 (UTC)
Message-ID: <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
Date:   Mon, 12 Sep 2022 10:37:00 -0700
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
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/9/2022 9:17 PM, Tetsuo Handa wrote:
> On 2022/09/09 7:56, Casey Schaufler wrote:
>> Good idea. I'm reading the official how-to-write-a-syscall documentation.
> Can't we use prctl() syscall? We can assign an LSM ID when an (built-in or loadable) LSM
> is loaded, and pass that LSM ID as one of arguments for prctl().

I'm not the fan of an LSM ID that Paul is, but if we're going to use them I much
prefer a static value to a dynamic one. Libraries/programs that have to query the
system to get the ID ( int selinuxid = lsm_get_id("selinux"); ) are harder to
maintain. It would really push us toward requiring a liblsm, which I think we're
still trying to avoid.

That doesn't give us a good answer for loadable modules. The last time I looked
seriously at loadable modules I was considering that we'd need a security module
that manages them, very much like BPF manages the eBPF programs. Loadable modules
could use prctl, or some other mechanism, but they would have to be different
from built-in modules. You can't require built-in modules to conform to the
restrictions you'd have to impose on loadable ones. The Loadable Module Security
Module would have a static ID and somehow multiplex what lsm_self_attr() reports.
I think it could be made to work. I can't say that it is something I am likely to
get to soon.

>
> Since we have security_task_prctl(option, arg2, arg3, arg4, arg5) inside prctl(), an LSM 
> which was assigned that LSM ID upon load checks arguments (including PID argument).
> That will be something like ioctl() without open("/proc/pid/*/attr/*").
>
