Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE3CC433DB
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 01:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E9264E24
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 01:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTBtz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 20:49:55 -0500
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44176
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229762AbhBTBtz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 20:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613785748; bh=QoNB0AaLI3KS+VvbMbq1a92ZEf7ngOmZW1MLlgChSdM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=AKg4jWCoiChwuqI+1f3rSr/uNPKy3zxUb4ibRKVCBDPPShUEfozLAY7Mfkunk7CjOAWp39Ae0NuAE1IOtXkDYm6UK2qim37QKIpLWrUbUK47fKsDtNNAkDmkZjOirgGnL6WpcwWbfgEyreLbhy0roZr22OJmiNw+nq51VA/JMZrt1s8wnjPRfn+O3S5Mbq/dpMFB0b1vUVHGlSK6avJQIVYw3/AJq6LcAZLXA/hBPJPYP2LWKtBF8FVqKLs1PVpiPy3eDyew4vOFcIb3wH6lR9Pj9Bn8A2/rXrOrJdCYHX5HfOAjiPWPGCT7OSucm/QPJIfNztYVj9iryc9GO2F4Ow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613785748; bh=elhN1nSjkXyTjvRYYjUY+lQedCVKnKtPuDLTptnXWGm=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=j+uuavXy8UNv7KO48+mlvHgI7qgxzFxhu7K68wKQRO0SXuuGo5hT9ITfx0f/p/bxPKXc0B7m9ppi7ES0rp6sFxnOZK7dky+hp5SAG+qVcVOhKSjExie47YQl0aRKCnS5S3nmnK4KxAMBUJFc24d37ZGFKX2FZynHCoqLMdN9XlCtS5C3YiRUUOMTmToZYJKILpLlUGo7YqV23UJ2xQdP44X79OUurfWtDII4F0lOepjBmWJTdkRcjAEY1bjfixCrX1KjE/CSEqKqoqwZuxRFRinIc73LdmAi7kRRomqam0sNKZ8hPizEfRbI8kMUn9bjYJF90dx0fFhg7b71anQf5A==
X-YMail-OSG: qfuNFM8VM1nOcKxHGoiwPRYp7S7sqBIfMVaYVCFU0JLwW8GuvGaCmoP53du6wjL
 h6HrCBaqU1Pi94HyHvRx1CaaSo6noBCm6Sa2iSFzEiTcp3HnsILuQeG0KwhgjRgFhsqFivVdb3AQ
 mySFA.VrHr4SeUcYkqSS2137IUgPHt8jB9gcFE3FpJH5gVLpf4HOOB.JWmw7z.Pv6nDzr_h5VnJR
 5qCg.D0nZOTEhwEZqxMgte4greedIvLHTuIIPrVrppKzAeJ0NeiXAuMO6ZmLF2E2QgOB7jVY6GVD
 6ZYfBlsQIZk_aS5a45k7_8DY1svUGv_8DKOeOTzXFkvmSysL0rFX1RupZgIlPhP9DWq96neh2HV7
 wk.MwszugcVezbpekzYRKbwhmurYrXD.j7tX4Su_k_HDgNSNKBXwDbg4fL4l0ZIizEaSxfTNiFmC
 iwBACteBf6nmj.k.OkjT.q9rS4aodYx2.5RrwsCmvlIhEsyHKBlVfDi7wuGM5iZ7iGt6wMYPhCJk
 XrPF4hFnquOju2WQQnZ5iovzWgMcFfFETsPxIjWdXiE_objvaGO67iqOcCTZefFLM_7fs_fZSsuz
 _rm4ltsD4DpsXtR8ZidCPDEKY1Rk3qXKx0d1sH5c0l0v5bPMK8fCZLTqBZuLP5.2CpwNbC_kp4c5
 iBjc0xwFoIZyeC.6piT8USw0iYXXgPfm8ZA_NnvoD_VUMRFBgejVMWBFGNGXb4VruUx0p7JfE5ix
 3yYd1BdfVzYIzNvRJKvV_6HDYy06G_FGSbEhdTgGhSPnihg.Kl4N4AEHrtGwnIriGbt4STZY4xyg
 PzUfgt2DUeWURxvkqsdW.rL6xXi5C2HoDZdU3DYkOE5EykqZgh_r_u4QZrfBGB2qSnb5E379DsX4
 ePCg8CKtW.hernPaogB1nfhGdoXBiLhppJrLZEjj38XG_fcC8s0Mzjfha7uwYCJYu3UXUKQQkY3y
 PFwOkjOPB26MekEydyctXO5D11J.DJ8rqPyFqO_eEjsTNoRUIfwtnzs.ic8MIdWNWi3C8UD.Sj6g
 SW9euyqgtBJiKd9ucrpvgBUD3NgIIB.Eph3iCpZD2cxkeV7v6XSkciljAHTjBFiIxkTjBOE1tgoU
 kNY844m_JEzrzzseTQ5AWAjq5I5bMNaKgWAJsHl0Nr5fu_VMmtoLH86sRdMRpCK9Nn9JzpqzVlf1
 WQjv4V.sQQti3PpYZ38KMW5ZmtoBNdgFFqxctxwxm_0ivQENeXZz0lI2VoBCnY9gcVoS4tECeiGp
 eQIUQX9yR4_vDo2rYf8l_9KvSvCxtapTy_qS8RqRBgcSkt5yJmJCjgHCNKUo29fsZEiF45laH7i4
 hNPMiopGcXzC3WpDtjFHNGT53gPLEyyKMvw0FO_IWF3Ziaw.zbLEJzEt9QEb_IbjbXJDyPem0ayJ
 5kftti7KB5ep7oRCqX.wipIvN87Wtq7NQeH7TvniW4WNWhuR3P3EFlWWJN474jLBoeIq3LI5h4OT
 Yv98BHtlYXBLbfztTzndYhfkJrSrB6oKT2noLX.Lw0XLzeYMYVl760R9.Xp76gzdu5UihwUdgz9C
 HS.KivGuTOe_pTDNO4oXq9RxwlhgQwk3LqQJOiVxpvk_Hl43xfQh.9bipX0EzF1iKlrutEmNNQeL
 NUKWbEGsIIYRaOI9X.hngs2xwW06tWRq9_0KuDb9mms7_Qb6C2Ko2phS3YNHqqd.Zhpil94kuUsA
 7fepX8cCvVE.ngqzczn1vc0n4pWXWViOOxsMfzsMTzS4WaiQ9HJWhgB2L7o7fkZpR7Uouh.iDr8H
 oCohUehNCRsmKk37aZGkA74whDG.49wPSzPh7K8YfeqnaYo8czM6D1CJlv50PumLLqR3J60VIkNr
 YqeJweWnm5wEv57KV5Ch0FGtYPPpcDaJFRVXRTptfD_T6ybCeNeF96ULLawX5Gyd4o2dkCGE4r83
 i1VUbF1TrIzBiVkN6L4i0Vb3hqMfxo1fwu89s_CodKmriNMvfSJpyc7Y3nx2jT7P_sc892O2Zcn8
 wtXL7s3JxwDA5jgTYecgUTgsWEOl6YFJ8WSk.ZKyPcTYz9UTOuWsM78SEvvDeEApbezbv7F8m.qp
 1uzC96LjEREkovZwRfKVvhbPuhXnCWB6qHbkiTvejs06AujtVmbiDpcdYaJ.wqH2Gdrp5AzbdwrC
 eQMzCUtkF5nWVb8C553fI6KQ.8tvWef0lVTsnPid123eBGWpXHw_pyCYSGlZ3EEP4Cm7et0.nTO5
 Nzxo8veI7l6FLGBBI7CMn3owHaiw3369mEgvLtrcmikzyQcaH249hVGZykqTNERVw9AjrCdsZ3ZX
 beR.LYr.n9Jf1znQnAFuh3ItRlIXaBsdqXU71vIgakjJAmLi6WNN1_TJC7noa6likxHEzOVmubqN
 Zytotmtsp2I_kRxFbBxn4O7muvIsn5JBbgJ.oALlyu2m.c_TMXRi_6YGsbC.7czePL_jfaZLLUHj
 nkQsl0J7qX_4zZQsxrnV4_LyDMMKs8i0Y8MFfwV4RPN1UWiiD0srFD581tJuOIXcyYHFNaq8kwx4
 8B4AOngyM3NpcaxUjvaN7PvkX6P4qWftH2SaPlEPoBu8A7gR1cXsAIkTMiPk5wyCc9IwZEyMIpkH
 kGFJA.5qD8t9Y5IhqUHsD06bNVSWxd5O6Ah88w1EZtVk8is7pXcrqtCikiif_YHNIF3F6K9NACgh
 eO6OkUkEeOiR5cAXHMWbwE.V0myc7xv4orL1LlIyjyR7L2FfkXkpykBCjrPoQ2_UXLBQZVfpm2Qp
 5Emsf54uh1o9ckFBOSUeikuOllYYNoWyWAbW5SGG1jZYrWR6Z9.uX
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 20 Feb 2021 01:49:08 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7c718438330df6e660d1cb7690d492bc;
          Sat, 20 Feb 2021 01:49:03 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj
 variants
To:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, Casey Schaufler <casey@schaufler-ca.com>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
Date:   Fri, 19 Feb 2021 17:49:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161377712068.87807.12246856567527156637.stgit@sifl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/2021 3:28 PM, Paul Moore wrote:
> As discussed briefly on the list (lore link below), we are a little
> sloppy when it comes to using task credentials, mixing both the
> subjective and object credentials.  This patch set attempts to fix
> this by replacing security_task_getsecid() with two new hooks that
> return either the subjective (_subj) or objective (_obj) credentials.
>
> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
>
> Casey and John, I made a quick pass through the Smack and AppArmor
> code in an effort to try and do the right thing, but I will admit
> that I haven't tested those changes, just the SELinux code.  I
> would really appreciate your help in reviewing those changes.  If
> you find it easier, feel free to wholesale replace my Smack/AppArmor
> patch with one of your own.

A quick test pass didn't show up anything obviously
amiss with the Smack changes. I have will do some more
through inspection, but they look fine so far. 

>
> ---
>
> Paul Moore (4):
>       lsm: separate security_task_getsecid() into subjective and objective variants
>       selinux: clarify task subjective and objective credentials
>       smack: differentiate between subjective and objective task credentials
>       apparmor: differentiate between subjective and objective task credentials
>
>
>  security/apparmor/domain.c       |  2 +-
>  security/apparmor/include/cred.h | 19 +++++--
>  security/apparmor/include/task.h |  3 +-
>  security/apparmor/lsm.c          | 23 ++++++---
>  security/apparmor/task.c         | 23 +++++++--
>  security/selinux/hooks.c         | 85 ++++++++++++++++++--------------
>  security/smack/smack.h           | 18 ++++++-
>  security/smack/smack_lsm.c       | 40 ++++++++++-----
>  8 files changed, 147 insertions(+), 66 deletions(-)
>
> --
> Signature
