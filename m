Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A3C38A2D
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 14:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiJYOM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiJYOM4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 10:12:56 -0400
Received: from sonic301-37.consmr.mail.ne1.yahoo.com (sonic301-37.consmr.mail.ne1.yahoo.com [66.163.184.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C67C9B868
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666707174; bh=2dZ/1rxUrkU/jW1nMSr++n/wr/TZUs+jHT4qeDrH3Lk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gBzlpZNTMu7WXw2v7+5BW/nLnQ0QFw1UEE0EEsVEbYEAjjx2oy1+xOs9E2jyXJ4eOe+HADCtAYIc3krSD5LmRUmKlkW9TSyiPzywzp5aptGGb481eoO0ZU7VYMtCRg606slvqGGE/yZ563yF66ZYA73NFJZPyitCu3D80KTWJUi/15eJGIoMer63iA6qa56tkJxwA56zniuwqyVvnsqdejZHPOVE5qyKcHZJ+R5HcoVjc/tj1JjRx5XNpZsarIgFt2F6ra7j3H2sXr33fuPQmJ/11436CTc1d0qJuhSqjq48oW+e23HxO/wcWfpy6GomVdZ8lkGkoPOSu3xsVHPptw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666707174; bh=ZuLxdnI7dIHrDdaH+AF9R+GcZn7tyg56OTuIhhYIy50=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Som/NBVr1SpvGOqwyweDJpVVi3KJ3TGtyetdkNnBYnmvglCcHRqWdk8hMlTx2FW4QhLV6wn4JQrpUCEtdgipb7vk6T8s4met1QP6jDrAKmVg+NIj1oJkZdjkhGJyPY/kPHv3TFvLuPPz4MQgzc5FxS+LTta/iATWrMQfSMIKo6/H0lKrSS0u2+ZuNNXPSqv4AB4qrwN4SgFipORwkKH/mhY4s7b78olxmkNOShmCkWGQwoP5imGpm+6MJkhNofoJzkpeLLQlqK9xciQSpQCvn/8k9CnROFOgMvpOEjxft94A/Vz4H8zZZEzpXqnpaiittnt1OfRmS6yDwqHnbeGJ/A==
X-YMail-OSG: 1UGMiccVM1kqGFEohkhtbrsun8bJ5LaoK3jIZzLXyxGn.vUGBfdQZ3cp7lQXgTj
 kVfXB2PguvZkFI64xXG3zARWRLmTsYTq_d43kFauf6E6KPsLl0duUuApW3ZEx3Vmc7lIXKP6C4yW
 rnzru5XzaNqKbL45yG2HuDSgd6FcQSTGTDpBFq1ivxqYuMD6oCCJ.W.I5sG6I_si2_71g_e6GkFj
 6nknGeuWaxq_O62BRMX_MhSRXHOVto.zu8DGmx_zM9AT9lM1fS4RfvUZmtxpBYDAH7vwwI9jATmf
 OEIsKNhWwzZkiDHVG97noJchLdQPJgYfPKqkccAnSZWROIbpfRPJ5vG8g1E5xpuW0D6k1g3aD6lv
 iOihczkhEYYPXj.HMT6PGwPYbb7W2RVwO1y6hjXAsPgt6EYPeSSHsqtxI2IeHM7VrDW60CEdjSW.
 GJ8UelLck1SAFF4FCfYR8BmFa_5TQA.3yOQIZlOk78jxp19b6OvW8o9NYuGK1wgq.ZesY84bMTX1
 CY2YzTkuGHAAe3zOggwnFbgfuZfCqWoWBqD48w9BT6_V6O8nFkP9twEBiMYu7aQOUW_jn6WHnqWC
 EcP0cSJIv0M.AOGRq3jnFO9unii_4Eu6bT4vP.H7fWUDmu2mGmK4jgHK0fnv12WgovSrsE0WZZ5H
 ayUrY6xeT7am3kFZlqVhGkSmjkIuViQEPA7PdG_kB_iVHyeHN._miQTPqlYIQWR9hSa6Z5kWkxjm
 ZHJUqYIzQdr5AGY5ZrQuS5bWN8ArWfK7FrhFmz5zpJJtEL7Yu7AxvnYd.96ftSvhErFuiZfG4KmB
 .p5I19l7c7mmJxcPBOUiLgqmERAb59Lkla7Znmg9g7XRhebdbmjgzWgCEb9mpRQz5bSvrz.z8_6L
 wRzdQ.Wbv7ERvmBjK8gaR4M.ArveY3L3TYfP98MI1g8d0ZxiGqWAGib5ojEFsWILafzJ8MIQkav8
 eUTFZE6J.fhN.KLj8ExTlKn4ZD1yczbMUjEvml.XbrlwYC5.wtLjFISXrpakyXV_LOoErz8Y5YA8
 4MTHG21dYiEGx1bxGoyEDKKMPHXuBdghdC9XdvApTJjnaGBhm1DqekfLXjZ5BzksNXVY.IiEZMGS
 oxm1Ap6a6NoYSGDFpUUa_fMRzksRUmeLc7f8SC6Su0X6u_xMhzwHYKH32VtX30de6PFZXvil3rl1
 p6pM6lcigVZ.TIF5ITrfJ9woPTAq.mN4OkUkMUBq375p20rR.RlZ1j64sWwp_X2IDdZTlLG_WORQ
 gCWGiSkZfYzDdpHSG4EfcQ7uG8J1zXrbJr5dS_Px_W364WS_9bPUTa2vsjb5ZIe__EKJmCnlL_9K
 vPWkK.nVgAYFfwUhteTm_4zNCanYbN3a4U7V8jvqUbVZySSblBUgw02nMHKQ1fDwx8QOdZ6bd_v5
 mB3sZ2UCzqzT.J3GKIQVsFMDihbTEtqLQzsVpoDrEQ6Wq5G94tDU1ojwV6ZnsSqktMq9nW3LDFFb
 ICFaiKJnUfapdkAFwUNlKYJGwLFRT2xyKpiiNILPXACmg7BBNB50FrIfEM3LfxD9qBtrtNPorIWY
 hcAicTaAVlLqtvQngLC8BSY6syC0VCKNHqrUYoXpgrNp1.K4yLso2BO3RJF7ZOSCFERV4OkoDfED
 Sw6cVXxQDHdg5DD.VxkOA_bNiswWWyB4uneApJuagj3mZy83ORpNkCH3BHMH6MQJngoEuEbGfQhs
 ovTq.HiEA8Pp2b0vRV_zCbjANi728Yb2pyO04Xehm3RHi9Q1hAwXD0Kq8wRraUdXHah8.YkGaOmK
 TVpYkLqvU_fUJ3_RbNijAd6s0oUFJNJfXzU8_NkBSNCgugIAw7KEovjGi8Y1QdARn53iZ9ZAD3jg
 WRAg5W834ZPHLbg7Ie55tRVeF6f9dF6Y6oqb8hL8.vV2ty4uhPhY1wUVPSfycY7RuIS18UrkPSss
 i4rhRQDUeohl3QOmGKGszszSaMFlZCcg.1uh25JTAWf3dCrnvv.GdWpMrN8k9ieKvoi1oYi5Vx2Z
 y6bqQK0tw80wWylHfHSoOnXcxSoe3v2MuGWdq3g63rqLzww.mJOvkmqwUnkOSply8q_rWjSBqUtX
 _BWQc7rDXfjGpokCCYAHvEYFdKbjOPpT4ZFPcnuQXPSNqTty.1SW3oly8FIOUYwby3xkFu8kvBTB
 QN63mSVyWjtEZhD_fvhZueXgympb9ox0BjLb2Y5FqbglfugHVCuVN8nPSc4GYE5cOTuTciXWdSUI
 xOGCIH1ExpBj0LyML_Es1FfGnE5StRJ4qDBtnfTY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 14:12:54 +0000
Received: by hermes--production-gq1-754cb59848-dxw7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7385069bd8f4d56b8886cf3153f058bb;
          Tue, 25 Oct 2022 14:12:50 +0000 (UTC)
Message-ID: <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
Date:   Tue, 25 Oct 2022 07:12:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
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
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/25/2022 4:20 AM, Tetsuo Handa wrote:
> On 2022/10/25 19:26, John Johansen wrote:
>> no, Casey is not. He is trying to find a path forward to get LSM
>> stacking upstream sooner than later. He has made proposals that
>> admittedly you have not liked, but he has at least tried to propose
>> ideas that could work within the insane set of constraints.
> I'm OK with getting LSM stacking upstream. But changes made based on
> only built-in modules are bad. If LSM id cannot be assigned to loadable
> LSM modules at runtime because not all loadable LSM modules will be
> in-tree in order to get an LSM id assigned, loadable LSM modules won't
> be able to utilize e.g. lsm_module_list system call (or whatever
> changes made while trying to unshare resources/interfaces currently
> shared among SELinux/Smack/AppArmor).
>
> It will be a complete reinvention of Linux security framework which is
> merely borrowing hooks provided by LSM. That is no different from
> duplicating existing LSM hooks and managing via completely different
> set of interfaces (e.g. /proc/$pid/attr2/$lsmname/$filename ,
> /sys/kernel/security2/$lsmname/$filename ). Such implementation is
> no longer loadable LSM. It is LSM version 2. And I don't think that
> such implementation will be accepted unless you agree to kill current
> LSM (say, LSM version 1).

The counter argument to this statement is that BPF has been accepted
upstream. eBPF programs are different from built-in security modules.
There is no reason that a well implemented LSM that accepts loadable
modules *that are different* from built-in modules couldn't be created.
I seriously doubt that it would get upstream for all the reasons
usually cited. But there is nothing about the implementation I've proposed
that would prevent it.

