Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B2C00140
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 00:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiHCABP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHCABN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 20:01:13 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882311459
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659484871; bh=Fmmb1T407I+Z+5mku6EJlxdLRExN6tNTFbuBzGirmoE=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=RCNkJjDjZ93mjLlNQBvj6GREHHmWWmClV24sLgEwF5lfv+DDtATwGPoXA94hn46jfLJsMAW1/N7gI0pu2mezMuB1zhbKXX8Nu3JcBPvIco8UCX357DOQKPmRwaow+EiSbzUo0VHBkwcj4fpG1ln3f3TF1mzW+yEl4+2g96keU96HIC3tIx0N5y4VTPSvUxrUUit6HTtSOtuXzjZEFW1yzyIQbsupyD2ToVeW5XS8xKDHw+inyRU1XN2MyxxCZ/KyQg+bGx03mQ91S6ReR8Qt/3RaiohrQlxBN1NVVZ4aDY5dozS+L5lMlSAi/9TnwB3eDPb5XJeeWgUjwNbc+ideIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659484871; bh=TaGLHNTFDpR9HRssMdmFeTkUE/Rotyo/GoVQMmantUK=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=h4RBd0cHXFlGxIF6409G2ZiDmJZeRTOG+xmGjDzDIYrkbeoSFLbPHqYJOIEY6Ml5l3Pm/Ah/SvdLR/dwBdYcQoeuidO3/1JkOBYsT+TRwgIvvnQ9Zn5Y8d1qUO/d7MlMsuH/NZFeeaSLFM4VvoQAVw+JR5EAa53bMiv6kYJxlOkr4Md5SZh+6//lotVha54kMrcwiChT7m/63e7aQtu3ztf1OzZGLSOwDEghCdKttf6t7PBUWtVolOys24UFI4+kzfafjaj+ZVZ8MKJRvGgE3zGUFGs2F9/rNZdiWIvYXkWYByaFeh7hClfjcmlPWLl1kbeubV5xGEX4H/GHBnr/Ew==
X-YMail-OSG: TKUKXDcVM1l_VbJ0PHb0iVAMzLUZjIhjusuOVnDygQC7q9eyZ18VD.wFdyzfMoh
 jSAcqOEaVt4RwxKicqe6JyQy8noGOFCevB2VwCdZQ6OIEM06CwP_7bZUd7gR_Mocw5_hBySi__V7
 GRX4WgHV5pMxKESCyzHgwwrHZp4MKkDQg_C2vocIOoraWPCIhyT6Lq.Yuz4DmbJxD7EKWTe9UrCB
 7yQ9AhA2dMay4_Jb.a78hs5MPVnsWtS.MCQnPjoUA_FQCOBxWU5x9ByaL7ZlzRvCa1tb6QvysJfb
 kurfPsFloliIF0xmnyugY5C9s29WtDqMOV706YkeetFjGWEJUwmSiAsj0YfOq2jF8NciRw3feszx
 1gFb7xzxcH_jz_01BokycxmFE6Ux3UGwGQPDlqHoImADYlNnOWtORKdqg937lz9Eq3bMuGkJFj4.
 I0COUmFyPz2pzK0hcG6UWFpOvt2HvsFCAsd8xUiaao_HivywbZQkqr7wyoHm9meO8h92OgaQbmFz
 vLDLHeQwweqFwqRLqThJWghwG__Bx9i.c96KxoJdRbFZKQSSRJ8A8sy.viEyd0YkEi8aHhFWpmdI
 CWiyV1Bgee1OzI9xJa.ScMZIS9mo7WuZzORzKt.8gvplSk6lnGvqSjQArtURjlIwe5w9oYvOy8aB
 VOEraO7AhykOHuc0DbNJSF.ljr5v7TVzYj2HC2aJyZxWyM8dFSZGP_zSu1C421zSsR014unKzvJJ
 aV.QL0sL4kZff0S29n7rHQys4mhMZt8P8gcphxShv33FqwKg0PFcEoF3kjof4vQ6xepGsIKn_a8e
 t5Z8jCtDDzIWC3nSyma1zcPNxSxOPOm.VYv_QqqLD8OsvOZVRAPJ2hHqTq6_rZMaJlOB3H_jNJgT
 5mpoyN6a8Ns16C2Hp6ZER_JbX32fByTSOymwWY5qiRwxH7pe.KSCWHnvUiiY8hIVfJMPuZGox.eB
 hlNhs_6dSRYYLRVPnR3PSLRkxY.WJai_hpKlLSRnbav8RUt_GP9Blo8Y.HmCmARExpMCl0VKgVq6
 FrIKgPQivd5FkskSFXYlIeacief8UJKjEx7xGQHe7fiEH7GYZB_TQ_KSojmDndhTuBiXTsFt78Ix
 9jlSmOmoFYx2cS1xiRFh6uOpdP.DbDAI3.WLkifA.2sJDm705Rhn1_b7YNnc0DbK771gAhTPw3aD
 iaAHhiiGNGawLUZ36byxxZ7qBMw2BX3gsVREvw1NDNxXpymzF8TdxF8AGeH_U.1BjijXGucrqxUg
 2AQWjNllYW.lgOAqkf.uvis3bNxlRePMgJewW0fjiCof73RdseoYSeYj0cx4sXu_1HZKZT0x.tQo
 tKlHgAw_dTwenp1MURZ4qD_4YDoycnPXGtFcPUCL7UGE6Eayd9ZmjI.3PSe.dK03.ZfxtHxxF5sY
 tdMc8qoRXFWAyVazdUtq5FqDp6PYylfIn7VyL6eaOUwAnebuVJ5Gwnbqx9y8M5cBX3r4fLo33HT1
 itOd5x4gDhXHjVydpqDPuH7PB9IMqsMGPH2m0Np8pT6.B9d0S2JqqIpIUwGrMP_A_oDk8ahYDbJo
 Ac8w48xi19tyjScufVcau0p72LoJ.4Q0cB38ShxVd2LKHIvk_tEidS5x4iWChy0_ggr89lujKu2L
 FtuIDw1PTKPmEnz41Vb9ZcNTEFuVVlvsOl4DKm_SK6I9YxQxusPSxtO.Bz4NuYhLRTDq4ukY_3XL
 SsuzZZVpj4YWPQ8rDpZiCRQuCwAv36yG_IW9.lkSHagwko4Oooa6UgJSU6_NaamcHcDGZO391j6c
 qBTbFm3XcZIlBN79R0xuF.kpuyEn4Efz3Bov.IdCextfV5dcnVvX5dnm0AxcLsbYJZDopnESXvEJ
 NF14puuiTKbVXXG0PdI5XBA8FyrCtXjhlzsHTrPwuYM7ElAYc0pT1plB5sGS2aJRPjATdW_aA1Fj
 lTXFsWoPdbM5Bubpb.hWDcIrgho9UpKBHi8z293CCucGaGkPlvFGi3v0t7TOz65u_ISF09YQopPs
 sjPBVRCm3pXTgbAupi9FcaY95MD1X.Gd8SOwuR9F9fnJRv1L7GpORYeC8NzN_nJ2N5ucaE_fgHdj
 alyYTpwDULxZ4wOHtQXnoktuGOOoM5p45xh_LwK_3D1T4PNW325E7ouwddhKsA5QAjQ1PznD.02B
 gXQJcOALi4I3U94cJ.89aPRyEfHtXr2JzUDF1iQ76n4lX43TPOCmGygtfnyM45Jh495Z6Fjn41Uj
 9CDdBQmrt712vmtl1hG9432YcCGPDLb8ozGME9zBAlZbdro1AH2ejW92vTKGJUJ_8Kwl5WnHvRwT
 gVdLtnDioz3NpA9Jc_Rs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Aug 2022 00:01:11 +0000
Received: by hermes--production-bf1-99ddd9c9c-p79bn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26b4f8ff1c9dce2f77eab2e4f6e99468;
          Wed, 03 Aug 2022 00:01:07 +0000 (UTC)
Message-ID: <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
Date:   Tue, 2 Aug 2022 17:01:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: LSM stacking in next for 6.1?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I would like very much to get v38 or v39 of the LSM stacking for Apparmor
patch set in the LSM next branch for 6.1. The audit changes have polished
up nicely and I believe that all comments on the integrity code have been
addressed. The interface_lsm mechanism has been beaten to a frothy peak.
There are serious binder changes, but I think they address issues beyond
the needs of stacking. Changes outside these areas are pretty well limited
to LSM interface improvements.

