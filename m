Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BEC4338F
	for <selinux@archiver.kernel.org>; Wed, 18 Aug 2021 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849BB610FF
	for <selinux@archiver.kernel.org>; Wed, 18 Aug 2021 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhHRWAL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:00:11 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:35685
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234106AbhHRWAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Aug 2021 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629323975; bh=lnmedOGXtnaTue3pxG43s+zb9gQCzOS0h/0CPflLdOs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=SZPGj2+XUYJr/mcOJe0pqt+uULH18lX9SVsub85EzSNanCqt8cooOc6b1f2lXXrhNe4ZhLhGEYsD2Zdith9MagwqVWVDXew4ZDV7dYfHPTty2hhL6BcqXk++Eqzy+ffshrD8onZLrwWzL766w/rCvf2b5lHr3a6NkSMAz08hMNykC7SmHchOejHOsQTZ/TBaLbGE4dFs66pbsDdVwzT4nA1bfnswZi+ZGlac+1FLKtT5BH05HROK1waHwpGtER4hNIkOK1MBBeRnr4StzWPgWKh/4KaARCaROkLPSOf+hFFKheVF0txuNZIROPFAGx5WHNjCrcMguRV2zAb33Y+wAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629323975; bh=PPUkspLdV4rsG5XczA0CxsIibcnza0vLeB3MfL05NKY=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=PMbk5Vd1mHL1/9NR8tThjI5oDOkkp+G51EC7PjR6Y+rXsastzbBUVyiATLA4hHkThIygeD5uyNjFWh4N24Xly3MFb0H8pxOUDZuuyhTKiqh+D91I9vBFo2d1u/8Y6FSXNPNIqLKqWkyOl1a3XZOyw262/xyvO9LJQ6FOMVihG6pzM8xxcfzjY5VZ5K1bdbOQ2lVmlo5NhjccjN34pXsQK+Arm9paf0Ww/5shherT58m8kJUDtcQmftYxHFnfgi/4QDHWywBjyYxsXd9AEZVKSutW9uNqxbzJooHtB9RNSKYm5ZEKzwdozvxdNHJPLoXGefOTbFuLxU2pdrDElSrqjg==
X-YMail-OSG: CYzPlzYVM1mqumdfHiUEKOjHeZuld4xAJebnywy4157IDApYdBbaZM5HdNK1_fP
 YoTaKiVmblOuG.KqmVJhzOK599fBKEs4uLnjc641bVYNuH0CwpmTaICWv..GEn43__8GZC10Yr3e
 mraB1IfiKDwSotkaIoTBjo4v.3QwdB00D_NrbRi8ypkIxJNRnCiqRJAsvr8TX8qnM9XTeA_eEQbC
 q1hAi8DsdIemKAhuRn.XXa3fh9RCfndQ7Cbd8CSFdoQVMzJ2zQvScJJpheE4._usG9x3sda2lbbq
 DaKBATJ.3CYcnGHzxdt6jiqxJZeScvNdefyRMJNlKaTrJgR.6jngAoSv0zgNah3gOoESr3FCvxpo
 2L3abdoKF8PD7UKbORiuRl1R_S8TLh3OkHcHX279VsSOilHfwKHX_0mPrW1MXU_dBEM42wiftchP
 zUPBgF8l9gLd6Un6hxiseEHS088pwF7tYP777Xe0shEQq050JwLlfJ9S6MvT9g5.5sSDgNrmwtXz
 bT_Ksu1hVCmD.OM9ewAqdVPHaAwnMUCmitTt2mZwYMy9kOseNPCv0BGDf9zonWq8eVV7Rd.OPDqy
 TXe0rQpzGKEcHKLGuR_A7OKdJCGlgAQYj5Nx_CueIx38CjLyfe1vGoYxKZ0KQBrEBkKJD1ZT5nci
 .Eck_Kp.nGc7qJlGDMytpuS2L02.JQD0kVTYwzsafzflFDlQlyMxazSbRKZQBrSFLPDhKYl1iKI.
 Vptba50f7j6myo2NWKqVRzpahD.79S8rvvBXKPckdcyecXsryLMh_Nb8xIdRZWGJjfP45KG3SSJH
 JdbIrBv337Y.IOUrk.6_9t9mHe.n50o7tckaCVpgnb2nfIcwjCEc8hGTo9.yYr2o5FVeA06Tkgeq
 lcW_u2eA57OpR41Nld5i1kbJNTxD9_GKJfQiN.nt5G9X7FQAOHS1IvGqdC2JNMkVxcs4m8_iNQu1
 BiESt36BjcjWVgLiJp1..7mv.kx8ZQcMQ78Z.jiSJiQJwsKgwCD9Qnfp4BPuz2X22sGuwjOF5xYY
 6dRSJKxK8GRnelaLGGmVNbH2.Hr8LTHqFnlVezg9TJJiK_Tz84nCzxrAVKLpOj823Vqi2in9t9UW
 7f2c15YMlxs8KWXK51uVsTf0Wjv5WBCU3RsLuFZ_BNsRGIwR_KDKYe3I8WEl9CR7OWjL3a0auqRC
 e0TZLR5FTZbNXqZA4PPaCdzTGIDwWc5VMJAjLWeXLOCQFFUy7MtRD9UizrVjwL7GdtYCSnJ6Bc03
 La6xCl8phRZNlEv4rEwz7ALjpnXUjDCSkdsFsUek.zSMfSifjg_gTYjtuYjo9OT9CGFgIUcqjzcG
 jFkj2gYzUMdEpNPGrWPw_wU7XxcxD3LomxajqLxp.AUSjd81nxHHuQtYWXKvDp2HWu8.1Ua9BcuQ
 7NdG57bK7uWOBJhCeorMSNoHddhGG.hRugEoB4iaOTs_.EyzehdAgtWuUAjeu_vUtWbLgUm6wzen
 bWbKuSeHXKBK7mv3yplPCHt6nfqEgrca3oMInMsNLMFA3iME1jo7ZEUkpR.XH2TWN81ls0dxBY1R
 tq0k6WoVktaNliV10OCmMdr_ZD89_TCetKV1gT2EEJ82v.lIpGzUmkcRr2BtGwHLXZgoD4Q7_lT_
 tQSpCC_L1m0Ms1jtjy4n7WFyY3QmYcOz65XNTfD5eOg18RuEvlD2fKUb3aFsco.tWFy5MYiyLSLU
 xMzYzbggu7kZ1tnORKNDLN4xOKow_GGoLNajGA9LH31kkBrTuTdN0gZ9_uaPppVrHU9VNJ.fuK08
 Be1ZhueH0pKTPn3x0YyfNBv2JsGnPhNU3fSWHt5Rf8yuVTYh9JMJ0v0hL.Ooy9vtXh9dV29khB3y
 iHzbbwuZ8kM0czLfGUOUv1aYqp2FeicJ90.YI5.ovv7oMecBNjOoPmn4Euey0IsEyUGOppzuyI7U
 0hLfQbgZJfB5utG4I2ek_oZAcWOYrkPvs3BDWKqqWOkVg5MSPZ5PMeBOFfhxn8THqH_UvA1w3uxl
 q0es2IMS7Hn5hUrbo3QTO6kX93fmZhQB5jScu0IwV4lLK7QQWlBt4S.S.8fQddYbxNBWaU.GYNgk
 jRX_5NPSr_AT2jtHvd8..LaeulFxpsdyNZu6t0X3.v36N4Hp5OcPoGItdQs.gRC31xBa87W8yI5j
 xzfW8PiNI3jBnXxhUeRCkDRKIliil5lDTFh6fiqFETyukGj.Mv0TNRAIPxCZxJOA8VDVzrjA54Zj
 O7xBkS0kc6LR1heWHnxxV8Jct0fIXhP3p7LCIzRH5EGk98nTlK2LSK8aMnPRvavjfp1PgmoBpaN4
 iPJ6E.5uw.AfVO_KKnKb6e9NVZm1wSJO04GL.pDVETrQi2D4r6j_aRw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Aug 2021 21:59:35 +0000
Received: by kubenode528.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 217b5544d85edfe7e42d0af03f2f1fbd;
          Wed, 18 Aug 2021 21:59:32 +0000 (UTC)
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM
 attributes
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <20210722004758.12371-23-casey@schaufler-ca.com>
 <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com>
 <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com>
 <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com>
 <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
Date:   Wed, 18 Aug 2021 14:59:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18850 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/16/2021 11:57 AM, Paul Moore wrote:
> On Fri, Aug 13, 2021 at 5:47 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 8/13/2021 1:43 PM, Paul Moore wrote:
=2E..
> Yeah, the thought occurred to me, but we are clearly already in the
> maybe-the-assumptions-are-wrong stage so I'm not going to rely on that
> being 100%.  We definitely need to track this down before we start
> making to many more guesses about what is working and what is not.

I've been tracking down where the audit context isn't set where
we'd expect it to be, I've identified 5 cases:

	1000	AUDIT_GET 		- Get Status
	1001	AUDIT_SET 		- Set status enable/disable/auditd
	1010	AUDIT_SIGNAL_INFO
	1130	AUDIT_SERVICE_START
	1131	AUDIT_SEVICE_STOP

These are all events that relate to the audit system itself.
It seems plausible that these really aren't syscalls and hence
shouldn't be expected to have an audit_context. I will create a
patch that treats these as the special cases I believe them to be.


