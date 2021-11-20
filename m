Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803BDC433F5
	for <selinux@archiver.kernel.org>; Sat, 20 Nov 2021 17:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhKTR5c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Nov 2021 12:57:32 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:38050
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhKTR5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Nov 2021 12:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637430868; bh=fsH//VC91Gv8GLwa09KYc3kqHEHP3Ok5WHdVTElDS24=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sMETS02za3Q6CWdz8Cxb/vi9Kd9+U9nZCHD0TftsXyCSmNvWjI7TdDZwE72cNB3If7zSqNSofO7yyRFtYJoB9YiuK3iDUwyN1SBbR7QCDXI8+cdE/xW4mNMWWoB85B1klKsmVaLHg6MtOkPUi/BSXqfyg8XOSA67oJ78nCx3bATDbOCCkMsHeHk+eeznvK4RDXsjwFODTirG5F7o5IiNcdsJJ4yGjo8JE/av+jAmjO/CEUWCnvOfZXG9gd8DzVpYtl6+eam03o27997hBMgZ3QiBkm5AdVh8wasN7Sse5f8KS5aw6MOWbErXjk865YwaJ8Vka6O6NA49O9Da+yGArQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637430868; bh=lHhEwZ5JEIqzmZbdOxto1puOa5TI9qKXn/o3PmMEY33=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=n3dmylKvwNbmezPgszqhu9lVXVcO/Tk9SdGZd/KCN+1n1OpkoQ3pYxmKaSfFBpn1/zaoZLN+sDqC6sl3V8wKZRNfclaWL55xOvzHzE7g/XeTtlM8/2VSqv/r0BUdLb1fGIXIXsCYtRkEG7cJg/Y82H/FSx50MS545UoA89MsK9hgx3X3NAGoFpB+qRWZTAnxmNif2c0wTjdo417TnoSvku2ePKlmdRefs5ocYxXdSMJ8YKRj4vAWa2K0QrWf4O7vmu+soIToX2BvLa5K7Gwlro/Q8JcW+AWsMmzLMkvMRvmON4NsGVfujieXOxQ1iJEpBz0OnPohpqopSSa263WRFw==
X-YMail-OSG: XQI0W1IVM1lawkCwR2wGjsF0Pu_zH6XTTyZ0UTVaZOYfNkIbPIrb8bdMPgpLNz2
 zVXqgnr_IXQ4Wb5FF8NaWHOU4CkYHL_BVkDYYRLZepohISXAmgCqE7XlcTATs8kHIM.2EXJakUQ_
 Jf1kVKq5VZm_wPyMzsYiW7qa96hFnlghtzdd0XBVs2Y6JW6LmKDznnOFU9y5KYBY3Em7nqh29Vmb
 B5AR96rlxkxty6znUT7XMAXwIBXohRadI4ZjRoyL3Cqyqm32btKu63j_uRqgOFOeRAXjrlKAJz7g
 8FSCss9XueTVOc3sLxnnqe19gZfE0V.vOfLniqzMePAo3s.rEZNlzDPpeIosXCsY7BsHNzfk66SA
 5441ejpWbZFSby2kdKebGcFBsJ9cNdWgHEhAR.h1Ocpg8L8sUY9KZlU6d2_C8c6LYwsQu4I5W9aJ
 ds.ljvDzy0fnTRbyPVi5c0JXvwndE6fsmW_N26.ExXoLYn7Z4CxzLaIbZkQ8ZGum_4okXrUmPlIO
 1Pa.kso19KOexSVj37S9PrT9jogdpuvILPr.IxKiH9gOHOpQ5VOZCAUxEELqD_i2r6NcoikXSyhh
 EIdif5MFXlXmtVCzNocn0tSGO20Iua2r31ZsqAk_ZZJzmunDTJNtXqrJwXyGZsX6fIORb9yY.Wyj
 JOBH7oR12z68lk4H5b45NM2MMxRaBzEl4wzoh2biq74_PWHBTLJTJUsvW0casgynG5Qnfggw3fjF
 .Obar8vPM2WiIpxUaQQRu6_Y2vqZ9k0IaOGJ577Ym8rUqP6zCcEwTG10R.BPV8n57AVKC.ysIB29
 ZLpnp5s5jh6nK.JjVf5Ls_l3rB6qd_oPMRywRzxs3dJzgBwUv6fMgSuUW7ipYVqINMagP6hTiwFS
 ipQngJdWwbKQQoGzQz36Ms4p6SWY4ggEMLSblIBXASalF5m5CEU6XluWtFtbSSzkTZSPU063ClRV
 BjKEWqApmUnf.1TcTsDSR64oVsR5Eax._pLaqPnb4vyXBFz_4ciKNEBqOWIq6n0EAkBFiTtCfqML
 NaCMon.5iihf82C9X0Kax31OrEgY7bDLAjJZaBoS6BsyNoZut5DFWicx133olg6z0xLZ38ODPYmR
 k.KuC.lba7G5HtqknqND2sE_iTh93.Yp2Zc9vMdwpUaVKV2oA95b2WxI8WiZ5Jt.FrH3dIE04cwL
 95zU3Te8roVeKhgOyW0fkkQkZqeNVKNDp1lmXmRG5wJ6NDtYjn2xMpSN5lEIfZIylAAMlCNvsMxy
 xZ8w81tGhi3J2b3QRKKJ6sS9pImhbVsAqjrQRqzm1Hl4TX1S4iuxeR9AwSZMsnKZQK0ISDgedON5
 AlaYQH9FM7UG_DVny7i12An8bjjUB4vardAE_HIjmJ83pEIvKZtC90OcExXoQUdEc7waSJrvVD2Q
 fI6.RjEvmDKTE.clLUjGrSG1AMo3JwIDAs0.w5Yo.qWWxYBFox0riRLhrvjGf._rizsP9Bbci1Jn
 Ttp0FdSrpz6myunr9i_mwnK904i.sJWYPbZNOaXWjrQ3jwSVKbVV9ngsCJyQLMw_k7Y2k_npv3eU
 d6J6xZ4Vq1Bhc1pTV.R0UTLcE9PLiip.8Ipqf_2KmUJz34jWkcakkv8wgdttu._k4OYG1SlX8kOA
 cxVm7MihOQA9IBVIhsilS8unpHQKMj3ip06wK_FxLmlQHI4_lW1lkO2ZnXgVeIgCqjN5_JqZlsz2
 8Ivlu6Btf1aFge56l977LbkWYvTCQY0neUvFhonPO4PYSmip_fy5JeXl25b7zZf8W6a9Mucp0WaZ
 IDMNJIoGYA968XiYQGKEjPy17IblD6CmQUmHC9I5U575.I7lOQLS0QPRxXgR5Zc8B7gVNSW8kGJw
 q7Gu4ns92UfMoE3ttYAziXVT3BGTUyJdsDFqqDwOe.D1j4kyoskjVgexSltVhoSV3omCxybuHePC
 0oxoOffb_egIDiJOwmCHHBEQBYEkXqEaW93TuzqbBDQDqOtr01LuYVa.9uTx1VrV3bMWRaxRTsjm
 p4NVfEnFW0JKWLI.zc1gzF4TKgrjU6EsF.EGuEY8tHRHWJoNyvHTRvrH2ZXnkSrAb6SHJ28gi6hM
 MSXWmjMSvlsuFnrwO.tLfQArrTqRpziYgF9mPWatZTiZWMPXNNbhbYZF3plpcS5_YFbRO2n6AJbH
 vCeB35XWfuE_7tOsJ_LtaoguJtiaEQ_X3YH1fvuaV.ZWnqj4aGZZ0CBPqnRzsfpRvsRMEJdfeKZr
 XpgnvppijJV_bE.Yc
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sat, 20 Nov 2021 17:54:28 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8a351f179c4d82eb64ac6b6d08e27bbb;
          Sat, 20 Nov 2021 17:54:24 +0000 (UTC)
Message-ID: <332675a2-e9f1-4dab-551e-226418439abc@schaufler-ca.com>
Date:   Sat, 20 Nov 2021 09:54:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <e5f141ee-43fe-56e9-e47f-f9da518b3e73@schaufler-ca.com>
 <CAHC9VhRx4KSMunuijEF+Bf7GzmBr7zXKwwW2mhOgTg8DfOCsWw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRx4KSMunuijEF+Bf7GzmBr7zXKwwW2mhOgTg8DfOCsWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/20/2021 7:06 AM, Paul Moore wrote:
> On Fri, Nov 19, 2021 at 7:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 11/19/2021 2:52 PM, Paul Moore wrote:
>>> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
>>>> callers to specify a task even though the hook is only safe when the
>>>> current task is referenced.  Fix this by removing the task_struct
>>>> argument to the hook, requiring LSM implementations to use the
>>>> current task.  While we are changing the hook declaration we also
>>>> rename the function to security_current_getsecid_subj() in an effort
>>>> to reinforce that the hook captures the subjective credentials of the
>>>> current task and not an arbitrary task on the system.
>>>>
>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>> ---
>>>>    include/linux/lsm_hook_defs.h         |    3 +--
>>>>    include/linux/lsm_hooks.h             |    8 +++-----
>>>>    include/linux/security.h              |    4 ++--
>>>>    kernel/audit.c                        |    4 ++--
>>>>    kernel/auditfilter.c                  |    3 +--
>>>>    kernel/auditsc.c                      |   10 +++++++++-
>>>>    net/netlabel/netlabel_unlabeled.c     |    2 +-
>>>>    net/netlabel/netlabel_user.h          |    2 +-
>>>>    security/apparmor/lsm.c               |   13 ++++++++++---
>>>>    security/integrity/ima/ima_appraise.c |    2 +-
>>>>    security/integrity/ima/ima_main.c     |   14 +++++++-------
>>>>    security/security.c                   |    6 +++---
>>>>    security/selinux/hooks.c              |   19 +++----------------
>>>>    security/smack/smack.h                |   16 ----------------
>>>>    security/smack/smack_lsm.c            |    9 ++++-----
>>>>    15 files changed, 48 insertions(+), 67 deletions(-)
>>> I never saw any comments, positive or negative, on this patch so I'll
>>> plan on merging it early next week.  If you've got objections, now is
>>> the time to speak up.
>> It's OK by me.
>>
>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Thanks Casey.  Are you okay with the AppArmor tweak mentioned by Serge and John?

Yes.

