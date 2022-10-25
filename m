Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EBC38A2D
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 22:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiJYWly (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJYWlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 18:41:52 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD92D0194
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666737711; bh=kK6PnqceseUoAaf9+ntmA4eCLSoZ2eSDolYlAkYup40=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EZAYS9JlpMDho4k0MPAHFXP42elRN4jeVy/EqsiCapUfaP1o0pXA58FOSESYrH5cEavhlP9VHucy51//3tetUj2a2tlM6LZx6ibrbcdQezQ+fCOrPWOP09sCZISuR/cY0jwHgoKU4ebPuoTUsu6HKLfIF0j6Ae4Xnkt+D7+vCB/6wtjjYIljk1lnVbFSG06d6E/3dG76kJI0ZeSvKBv/MFtVM7u3PKAnBY0CP3Mds3Hb6MTJz16RboVszGY9F1DEApuP8uZ0QYtyy5o5dulztrmBVB/IQ2j1zKkgTIokjo+MwBXqxCvNHZLopi5res9rHUvT+sK8/iWAroTu/Mxx4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666737711; bh=Rjw8+yCPHFLjHmyTJOgoHgIZ+qwUuTwkIfB10EhUcaI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QIX8oDibnPfHsUZcZYWokaB0D4/TZFfp+Uk9L6XY2RICFbhelD3nSLgYqYH8c6OjsEZa1ULnuPy0u/6Sua7FA3gC9BNwFOuhglmCI4gMLv44pmoQZMTupAeYTJquxexEbXfmv0wl2jZelI9AEx+ZyVfW5kALxVF5Zebk6tU4uFOzs251wXbBu2NLH62ZJVBDlPevFg4er8xSxvZQqIIkqo4U/K0A5NKzlRt7meNXS6YPJKG/FY9G1yp+7xAFb+DMvhR2K3QCQkxuGyEtcPaP69MTx2kWzLaPMfE+Z7lbSz2GGDlMqm8gxZLzOIQERk82wKQrM5EywIsRnOBMGTdmHg==
X-YMail-OSG: _XVz2CAVM1neWScmgrBZujRvephqhjTukj0oF0ulAtfxukik7ON3Md1EDc.kdwl
 b2sC2Gl9TpBmVdiUNZHP8NHBL1SL95I4sP3exWc.WHTqo5.fllfUrtLEjgXoP20g2LkYAxUoxGn8
 kvJxrbByPf2c_TlkUvVwSY_SKpcd0PRiAui6Lml04Oz0kKuqGce7QFghxulZtBvwdIibsU3nn_c.
 OsZWw45wWthirgx6HInMWid2F4qh6Pyx0QtEB.fKl1uFkZZhlXOZXSi_5afnR8fECUL2ZNSpBLQO
 CGTBTw6w_G1qtyzZrL9leuIkKb5SSfjld074Pt4ToZsdfMRjzV0MZELtHvwajXUL3HfYNpTLUTdP
 Jkwj03cYolTnLz89guRos.qv.0xkYBE5uIwWbcAx8BbANHU8bHZZybqMk90nOyk.dHG7XeuJWPW6
 fRVNd.S9swx2H69ZVEIaevG_rZL7mTNg9wsD7ViJZMFABe8tZvSxpKzrQ6Rgn.C57hfYdaE7MRNV
 qNai6Z2WLLSpLGh9I0BH7ENaikKRCsqgPk8NFiuBwWy2isMI4YyM6MuoAM5kz18Eogz9QuAJpBQU
 fhGTBjowcH0oxZ35FOardw6Yv.ijoI7MjEMJYOzg7FhHYLkSmT3n2U.P_uNseQ2C4ECVWz1kNXxs
 KtxWERxamFa9sgS.PWsPvr47EP8c2kaThXiThyx.DaPuvfSklOe9TSOaZKCXj6QyLsRHqUPd18sE
 nuXkvAe_4mvD1KGDjT8vCDIWNo_lKWczjzOxHoslEvSI.T7cYTMDcUqrRmWVU15YV0GDAMFsH7wZ
 WA6wuFAI1IoNUlQjI1M5AAUvTThtA9HigvfKI1f.41CA1brl0LE7upegFUEeoZGgbHLTdmb7rqw2
 T5goc0iIt89yVo7AcOXo1yXY725cbEi.mk7HBdJqFC1XnPAye.IcBjw8kPzvyUJM4uJrQro8aIEr
 ksCJGeG4UpqKIt2Fgf4DQIKtQTe.1eGcoJmNn1zSLlrD9dGHTc9.4DwX6rnkjbTMiugbqEAjyeLM
 ND2DQqhASej7ODZFyivYUb.LC0PxIEFbyIWWJzkjWKV3ZdMqS29.jR7ySW9lyRYkEjNQF8NoqWI8
 M.IDGxewX5f9.4CO9T4tUpcVm1rD.c6M7dD4U8XJuk9CpL0Hlg47GDUsx9HoZsBeGJwTq3UgH.7r
 WhOO8Ae0c3aIdxf9rtJbZWdMViCTBcjFL8sFwpecU.jk_5Qm01jIBHwuyECa7252KjYqKw8Rge6Q
 yJe7H85kiMHOwuLjdxStF6qMOwZlB0hShmcY2M5mLCfBdt_IXlUP32S62M7dkS4b1PGe27RfW0_A
 0CLXWu_c.QF7s3tRgFCkUhz5Se9I5UtsKpSjROv4llsdKJJBqytAUXPQfnk8HNI38rmeaxC6.5Tp
 ubAMbLgEfpWOmkM6W4yNFZ9cTinGsQIdYIjmZTl5qC6kPU2YTqts9N.1h7PnaL1wN.hq_wW3x0LK
 tqp97QX.yXEOm8lilF4.2Mza613cGPnEAvzCrgIiRdt4NEwgMi5kAOM31yFTQLcoPUy3Q_OP7c5b
 dEu8IdoQssLo0UItOsIBMKj_sa3yz65y7kdh8FyR1NeotVhZ.lO0qFs3SCNRf25y4FiCHwSPNejz
 GCMN2.5qTzBoAD8jSpupGLmL3i6phcSmPaWz4NmUcStJVKl3Dv8ITYR22FUFbxhITwXM9JOHnPxX
 QJyZerpjz4yS8g8ReDpwe.LMkOkSmpoL6OiUCXC6i.r6fwAWiucCKbGJmcvt30Wd5Jt4J6yyUqYl
 dZ9o4apmFbe63xXnmNkosG3p0sFJ5BAhPH4jjQ7y4b0_jRla3yu2iWtS5m0_2oOrgj.1qdp0cIKw
 1U.bDoDCdrQij1i.aszOjiyBFqD2BLuqMFlXuz20tM4E9R0ZATPmkn1C4m247V6GJm.lZPzovqHp
 p.5G3FW2PexrpsbvaBSDmiEmHRn.aJ_9Tl0yMauy7ezsMO7IWxCYpb1MC.QphjMePhqUaaY9WzWU
 oKMIbxIqp9HtC3XR4FkR5B_m7p4gfcAo_iU6plJn17LhS8v17CUNa8Y6vSCsyPCM9KId021q8d1Y
 ZvEobDEaCx8NBwLHDUtNuT9sXP.dY15CLo55IooB4TMiaRW5KiCB3u.ZkEXFoK7_.aCKDbDuMH0X
 eS_HZz_MNOaIbnHU54iUoYDxr4sN.D_.aIUpZU9HdzFr81EB3vpyO7BDyMpE_NneU15A7QrnheTe
 COcEPNf0cr6A3DQgdRuJhrsItQiKLmYizrRMXjpVWJgDE5ZMtI5ZXzfb4f184vTj.vO9gJGAJzr6
 5aKT6SAHWcJZ6jaRIaFlynoB2nit7qQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 22:41:51 +0000
Received: by hermes--production-gq1-754cb59848-zdkt4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4afb9de0bef7eb910cec93e212a5865a;
          Tue, 25 Oct 2022 22:41:46 +0000 (UTC)
Message-ID: <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
Date:   Tue, 25 Oct 2022 15:41:44 -0700
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
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/25/2022 3:12 PM, Tetsuo Handa wrote:
> On 2022/10/25 23:12, Casey Schaufler wrote:
>> On 10/25/2022 4:20 AM, Tetsuo Handa wrote:
>>> On 2022/10/25 19:26, John Johansen wrote:
>>>> no, Casey is not. He is trying to find a path forward to get LSM
>>>> stacking upstream sooner than later. He has made proposals that
>>>> admittedly you have not liked, but he has at least tried to propose
>>>> ideas that could work within the insane set of constraints.
>>> I'm OK with getting LSM stacking upstream. But changes made based on
>>> only built-in modules are bad. If LSM id cannot be assigned to loadable
>>> LSM modules at runtime because not all loadable LSM modules will be
>>> in-tree in order to get an LSM id assigned, loadable LSM modules won't
>>> be able to utilize e.g. lsm_module_list system call (or whatever
>>> changes made while trying to unshare resources/interfaces currently
>>> shared among SELinux/Smack/AppArmor).
>>>
>>> It will be a complete reinvention of Linux security framework which is
>>> merely borrowing hooks provided by LSM. That is no different from
>>> duplicating existing LSM hooks and managing via completely different
>>> set of interfaces (e.g. /proc/$pid/attr2/$lsmname/$filename ,
>>> /sys/kernel/security2/$lsmname/$filename ). Such implementation is
>>> no longer loadable LSM. It is LSM version 2. And I don't think that
>>> such implementation will be accepted unless you agree to kill current
>>> LSM (say, LSM version 1).
>> The counter argument to this statement is that BPF has been accepted
>> upstream. eBPF programs are different from built-in security modules.
>> There is no reason that a well implemented LSM that accepts loadable
>> modules *that are different* from built-in modules couldn't be created.
>> I seriously doubt that it would get upstream for all the reasons
>> usually cited. But there is nothing about the implementation I've proposed
>> that would prevent it.
>>
> As an easy example, please show me an eBPF program that allows restricting where
> to chroot to and allows configuring where to chroot to using /sys/kernel/security/
> interface.
>
> An loadable LSM consists of hooks (for filtering access requests) and interface
> (for configuring rules whether to filter access requests).
>
> Your LSM id approach makes it impossible to use interface (due to lack of LSM id
> for loadable LSM modules) by loadable LSM modules. LSM id must not be limited to
> built-in LSM modules.

I'm sorry that I am failing to communicate my understanding of why this
isn't true. You need a built-in LSM that loads and manages loadable
security modules. That LSM would have an LSM ID just like the BPF LSM
has a LSM ID. I have no doubt that there are multiple workable implementations,
as I have looked into many different ways to implement the stacking for
built-in modules. I am also sorry that I don't expect to have enough working
years left to even consider spending any more time on the problem. This is
a development effort for The Next Generation.

