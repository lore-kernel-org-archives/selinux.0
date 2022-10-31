Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D8ECAAA1
	for <selinux@archiver.kernel.org>; Mon, 31 Oct 2022 15:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJaPsH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiJaPr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Oct 2022 11:47:56 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277C11C3D
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667231274; bh=4WaBE0DM7Yj3Ix5f8weRlFs/hCn1dHaeOu2P+BYZBwQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GZKiTP19nDrvemq9VsoTew5zyX4Ux0InShB1723EuonI0it4x0LRSccLOdgMsMh6tv8nagenTYAEeL+mwdwj8utxDuMQTQ8COmDWCr1jHYxfbvKRemV1MsJ382go+n7nfiM2a8ap58R44R4IY/vrICxXL9fOBNTnSX/fFA0fjTi3YreyQ6np9XMRdgAcNM+Dp3vArNsKk3mBtZumDp6i7XUyHGSqqPB2vKcxfLlO11Hlqw4or6mkrJe82/rB796/lFxtfphZHFbTlWFxUl/eO3dR6MReoqbA6qTDPLx7vftDC38U+sZD3zaaEi3aZ2TDgR1RC7BfcBQtTeikrh33hA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667231274; bh=rS+nroPJc1Ym3Q/5Bcn2++smfcgYzS+5i6p+LBnTAZu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VH538DSGwLtITK107w5fn3ipR5GYPB6UrptVkc14E2hcjsXTOpWZ4IGL9Jc7qWtYXoRigRvcWV0gH0G2EkzHi2dU3gp+3RaXbqmN9UbTQxPJUrvGzTMYr/ZtYc6g1wap7gqVZCxTaNFpO52hKfJfrH/nX9wELDgaV76rWIP+maRMOdygYF/plL02gxr+M9+n7IwbmPFOiFIEA2nEgrRY9vtlZz1gE6JQfjQ+yWFtDRZii76YX+QpMAKwTlWkDdjvjbP3napiAEtoXZ2y7bjD6MULnX28enBejVpuwIh/ionhJp1NzWGyubXV5gwU69Wk8mW1veUQwZwpjCbwtQDtxA==
X-YMail-OSG: yF8gabgVM1kSK4WgJpEg_phOhluwf7DVxl5Fn9Dk7tCOQFpXYs4QTiWcaugCQju
 r3X_AI6nPAYRO38Jf7E5j1nFO1cPGNgKtWkPkKTUfTeZMPwhoNbk8LMfW3Wo280afNN2XWvV5_UJ
 sM8pbxhMUPQO.IDKopsjVtVUHEQmQA7NB0ZY0sHaP.XpHArEfYZxKaUEKh7YWqFoz1d0D6R2DyTf
 Ltp7BL2w7h2oLRIRwU8ZUfbGqyRCeHOrDmqPejzAuhgecUr5PfH9gNGb4aeuvXy.8EHcbD7bfeVo
 M01QvY8RBccexW3DtYXUMCOdhUjFMXEvkgQ5gZ8lILFAXMOC78PiRRjDuyDxYtX7O4yHzBTeLwZd
 GRJ4HA1YT2jEnq5JjsM0HxDtqRGGqeMYnFBly77u6nUnpeXo8kHS3juRbkiQlEwvxqFMFwmiciHI
 iQ1YabW.XfM5RYiqL19TPSCS8QkpJ6oo1ISS8Iv9W2rJsvZY7zicLRCHPxqDIbu01auZtMD4e330
 wYfILjJRvTu6AeF67q3AZvXdJPop5UN0hgCcm5ufhRnUj698yyV0XI.0JWmoqpGoR9WcJK0ev2mn
 fZ9RBbqOzXXrSuBoMJpmMc2RL5vhEl1ox3FmQvExO78GfBIVbp._Sa70nBFFey3ec75PwUYW01o_
 RyQKOly9GRPuqXyYsTVAXEkPdkleam1FzOR7lp0VaZuP3ej1jG1k47U_ld0243yFOanpM_DFtPvs
 25fyTZq6tArYFsjS0gNphIfmYQUU_LZhr_EpyQIoiBXHukOVwyQIeOBFm_vPT_5CnwVapmRojS20
 n3EvS2gsgmenm.6IuES_UrBZh3hxeNXz3.krbESJ_kD0xLmiVR38oSjRYBfVHNUiokp5CaMp_yA0
 3EI6OFqdwzy2uXy9cfP38WGkYjxu3vsXFj1qvFy2w9.jHNjjYtEl28GCjI8c95O2lzcybwur2zon
 cX8BGVYdvlainBmHVLfQFd6oxwbk5xUEElYbwIMhj7qW2pTSuNcQ7UGlAKdY4kkYFslI2Ez.zL6u
 mCCwTTijIRp18BYT097XNu45JnrrTLnwet1obF91MQ7nWQobE8QoZf13GH7Ss9fL8EyNuJkDofw7
 lJVRN43rVuxdabIPW9EmUORQNqPh.tpqlxel4f1bkfC6Y4JW.CZ9W.c_7zx4erp6zd8eL2KQQxVp
 NQA7RiHPCqissbgs.a.Unze_LHu_0q9ICaidB5JDGMw1PZQjzBVj4Dv4o77RTmoKMRiqOpZtx09p
 BIWCpWZJseLyjPKsvRlNBg.Pn0NS_l8oPJRw2s1DvJX9MxtFipEM0g8DPSsa8XDQLz0gTtveagTO
 zjY8iakcM9hOMJc7qW.iSGVX9Ttiu1hxgt.4KBPmDoHj1emINPKRTNJXBfr_ZONtI.vTfU7e3N3V
 Z3aUjlexhJawchg7a6GyldgiGpNqz3Yo8e.Q7yRnVJHOn695A2NN7VTUHagNzJJ2iLzMQ5CiqRnj
 LJl0fCfWr.g0eJ3J8VQpsS_KEmDs.NHGuAijJyG4FLTbkAc80xPXcNS0oYUnz5pkTxm.nIcaDqw9
 HvevyGa4VJIji65N30PkE94JyCFc6q1LwggWsa2SLRhP3IwWpi.qKkeD..C5VdLvxNMokfrQbWbD
 6jnIi4A6aGhY8momsgvFzG4rBQNpsayT.SHIIgxXa0bekWEs.BqJsm88ZQSl0.xdzYp2Bj0VKLLt
 kcNaF23sU6BaaJZNsKEm5MW2FFNC1dsk6BADcsB2WcWDukg1CrhBGsTLSC3eIcJ2JFgHO_B2pjGA
 pmwkb7pqKaqgi7SF_feWQUE8U6enWqvyvRjIAOS.DLE5W6I4GEflcwPxThp3BBg8XOc9HUqfaEGE
 fty0M0xv9WUS673wbCnEWPbA9JTKG7z20zeaummKTXdcHbnWabaxIHf2.TGz6Bn.S1p.j9MQfj0S
 Ncbgc.yol.455RneWUqMro4mgFJ1Io3s86Q3VxDCN7yVqa3lXoxq4HOFHRwZU83zeT3z8QOPzfhk
 bjtwkn8m3FedX7mGlP3SB_hRTQQxzKOO32D1wSHQ06lyou.lO556Hh7ZX1kP3awdi10w90UvTQ3z
 .pYgLJH1R_o0hFzcy_c4XV77BKEX6XOXV1OGqVwfiR7a_0U9b.ZiHRiLlPAO2IbTz84qRQ4Kymk.
 LYMCSOrkKnx5mLxEDCiacloLDr2w5fjkdbMoN1O2n6yVZf8vMMnqTAJTMcfrznAQEFVEyB7tDUjp
 RPI1Utnr5wrDC2j6NQuuxm1jRZKDhy9jnp8FsKZ3bksiHU1IIlxHKNfJ4dxPfczxLRbZH9M3qnxq
 hTHwyynUYt8R60bVIn9w-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 31 Oct 2022 15:47:54 +0000
Received: by hermes--production-bf1-64dccd5d47-nqrxc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 029f6b6cde7252c779b63f2fb8fb1760;
          Mon, 31 Oct 2022 15:47:52 +0000 (UTC)
Message-ID: <0d12ed29-ec1d-027a-5a87-f8a6687a04fe@schaufler-ca.com>
Date:   Mon, 31 Oct 2022 08:47:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <kees@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
 <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
 <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
 <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com>
 <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp>
 <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com>
 <2c48a481-391f-85c7-be4f-13bbc1553aac@I-love.SAKURA.ne.jp>
 <AB202AC7-9C8D-4109-B4EA-87A7BC1BADF8@kernel.org>
 <feaa5cbc-342e-3863-e761-e7ac8b08d314@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <feaa5cbc-342e-3863-e761-e7ac8b08d314@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/31/2022 3:26 AM, Tetsuo Handa wrote:
> On 2022/10/31 1:37, Kees Cook wrote:
>>> You have only three choices:
>>>
>>>  (1) allow assigning LSM ID integer value to all LSM modules (regardless of
>>>      whether that module was merged into upstream kernel)
>> We are not hardware manufacturers.
>>
> Excuse me? We are not talking about whether we are hardware manufacturers.
> We are talking about the policy for assigning identifier.
>
> I don't like how LSM IDs are assigned, for Casey said
>
>   >> If the upstream kernel assigns an LSM id for all LSM modules including out-of-tree
>   >> and/or private LSM modules (that's why I described that the upstream kernel behaves
>   >> as if a DNS registerer), we can assign LSM id = 100 to "belllapadula" from A and
>   >> LSM id = 101 to "belllapadula" from B, and both "belllapadula" modules can work
>   >> without conflicts by using LSM id. Of course, this implies that we need to preserve
>   >> unused space in lsm_idlist[LSMID_ENTRIES] etc. for such LSM modules (if we use
>   >> fixed-sized array rather than a linked list).
>   > 
>   > Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
>   > security modules. That's one of many reasons loadable modules are going to
>   > have to be treated differently from built-in modules, if they're allowed
>   > at all.
>
> at https://lkml.kernel.org/r/7263e155-9024-0508-370c-72692901b326@schaufler-ca.com and
> Paul confirmed
>
>   >> Currently anyone can start writing new LSM modules using name as identifier. But
>   >> you are trying to forbid using name as identifier, and trying to force using integer
>   >> as identifier, but that integer will not be provided unless new LSM modules get
>   >> upstream.
>   > 
>   > That is correct.  In order to have a LSM identifier token the LSM must
>   > be upstream.
>
> at https://lkml.kernel.org/r/CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com .
>
> If we can agree that the upstream kernel never refuse to assign LSM IDs to whatever
> LSM modules, I'm OK that we introduce LSM ID integer value itself.
>
>
>
> My next concern is that we are trying to use fixed sized capacity as LSMID_ENTRIES,
> commented
>
>   On 2022/10/13 19:04, Tetsuo Handa wrote:
>   > On 2022/09/28 4:53, Casey Schaufler wrote:
>   >> +	if (lsm_id > LSMID_ENTRIES)
>   >> +		panic("%s Too many LSMs registered.\n", __func__);
>   > 
>   > I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.
>
> at https://lkml.kernel.org/r/9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp , for
>
>   struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
>
> may cause out-of-tree LSM modules to fail to use the slot.
>
> It is a strange hack that users have to enable in-tree LSM modules or rewrite the
> definition of LSMID_ENTRIES in order to use out-of-tree (either built-in or loadable)
> LSM modules, for LSMID_ENTRIES is defined based on only in-tree LSM modules.
>
>   #define LSMID_ENTRIES ( \
>         1 + /* capabilities */ \
>         (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>
> Although built-in out-of-tree LSM modules would be able to rewrite LSMID_ENTRIES definition
> because users will rebuild the whole kernel, loadable out-of-tree LSM modules would not be
> able to rewrite LSMID_ENTRIES definition because users will not rebuild the whole kernel.
> It is still effectively a lock out for loadable out-of-tree LSM modules even if the problem
> of assigning LSM ID integer value is solved.

Propose an implementation of security module loading. If LSMID_ENTRIES is a problem
I will help you resolve the issue. My bet is that there will be an easy solution. It
may be as simple as adding (IS_ENABLED(CONFIG_SECURITY_LOADABLE) ? 1 : 0) + \ to the
code referenced above. But I can't say until I see how you're going to address all
of the real issues.

