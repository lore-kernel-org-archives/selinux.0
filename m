Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC070C433E6
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C542664E3F
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBVX7z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:59:55 -0500
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:39021
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhBVX7t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 18:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614038343; bh=T75VPcyokGz0HlBJHQDlOC3YIk7POLJdCCP3n8ODooY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=s+2aupO6nimcVMtq97MAJFDYRavpUD7fq5SRbMl3P4Kf1DiJXV/4eZNb6PXCSdbXVGUYqCtBZgNd5XmhnkPnTn8DYMh5R0mtjbBH/nh9IuFCakM5UbxKP9LRJs8wakjUurChG51+WwDQ6ed6ahJH+lu4kyyveer3PhWcevPqg1v5cNjTuTl8RI7enGYRdkuohbtSV8MK0EwRdbtmsffassSRR91SVXTFzx7cp1h5FUvvQCPYyNM1sz5lssH4XHy+K0jNqE0Sd2ZHBRFi5ZiAbkNWaqSZdlJEWTzKCOufi2F9B+VOcbsHDv/9Svjhtptf4MIMDUOZPQSTR4Zps0DujQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614038343; bh=pVezM45G4SO/5L3Ix0Lk/QGlrgnMjoNrh0H4S+kLQYa=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=QbLmg9d0ONiI01s51prii4loAdYdz6ywj8kkM7Sj+Hu1tDtWRx6Zu86B7fS4GnWRFDMzP5Uf4N0Z+GLr18xl1jwz0QJLOtrRsWsg669/fniNM4S1iSJqlCnsH1T2Ee4A1ezBq385bs/+jIrTd6/eX2/ydPeUMLO++aFyfaiV9JmsATJ8bzZHToZFzNnGBhcKWD/24nSpyweec/Ie3mZGGp/LPNvsWiR7ppTgV3DOyzX3ix/x52eulOpZfkAbyzVQJh4IPaZ0l3K+l+FfjsBKk3lbiKQr3pcYfpNv8N5AiiBcNiKsFraaa/fX46C9XGqu1g7Vx9Ggep6ag0nlc9Jfkw==
X-YMail-OSG: kCVFfXQVM1mlIrnOkJoN2sRCPWwv5TtOBDQQX.T4MOFWJdPXrhpI23cykQfC0ie
 FecyVG.39LkvpS3tPqkAvEhl9i.K8F_tyZW4WG7Ih..KGe6gOV.FAvDC4MxcXCb_PuEQfPcdpV_T
 ap1VxP4fLxKF2gG3LjNoI7T6l_RsmGg9LqdJIoMJ5j4OrtX6HQYJfiqA1WmbMM9ZVypqvdlnNiej
 4mnIk1oMGInTmpX555NEDlTiNxNLsG6BD8wZv1c4b8_1SG7BnDNYqc2Du2pjEhdUPJQka3NC.824
 .nFB.dafvsIa9MMl8KdaGXHYLjAoOIPWZGa2T01r5JgTiqJGkdJMEoFI75FR3ZoXKJ78NuPqHLFP
 if_Paz12114OMfoKsg7cJaXaJo3J80q2MsVEb7znuSmAYePIVFVKJ_3k14XQFmfNhNJ2IrZtz_CT
 Vk9RDihdkWtDrX_ZKlnPbZCV6FMwwxKY7GRS0QBoV9MGRjc34Jhrb.boxsgid1.BlgeaAmkdE2Tu
 tQ54joZEkiXoSn1sO_IoEZ5S8Hf3Aow10y8k4VnH6L4GSBlQkN8.JrsdiM9DpXGJI1MuXY0h1NyC
 _.oh2Bg8EsQ6RmLKpv2ncYYoiBfpieYN5QM7_og1ZGz.QtwVGdXRnF4ncXkGG.8eipmJfq6ZTUS2
 Tm.MyyMnYg3imldwmVEsVQrZkrtiLEy0w9oZhy2bDnTFaZEGZxB1QutcFgIk.fnlcGerNRESpBJ8
 eUCF7pTjXy0IAqpRRvTpXLaaaXr3hRywxDEAGtr7CC_26OP_tcSDVE8JEz5OtvrKvZ6wNQQ6drqx
 UUY_NFiHLv_5wvyPfx964nzQe3dd3onoeMZXjn74oEbWLd4Bda4CEIYixPJtexdH7A1hslQqfANy
 QYItQ0xTPVkwTWX15rgUM2duibTUgm_YM2WJccio1khvJf8espuY4CnGph90MXhV63E9T.TQSCtj
 l7uP6Wf0brrVt7B0K7KSEPRDYHrLpGNoOyr_8rRrXxsXwmYJFFsiyYGHALJFen6Vo4U8frY0FrHG
 DVewApw6etAdqa7s60npyjUR9NS2c9RBrg4npmT3j1C.Gja_1QUhPRS03dDNPYf8FT_R4W4H9Vo0
 6gDP2N8x8DwayGa9_V.25Y0yjBYOORiiIrzKmArh7kriNJyjnHnsG5NX59SFWEh9x39LP59iThY5
 CXw6iUgT.ZiGg4eSrbcDbCtTSoKL_wnvYyBnQ6Wq1mv_yW17jFSpzm8KAJwRgn8Hck3CqQaDQI_0
 Nf7q.k_H0stOrHBUxVQ5vjfzaekZrcn5.gO0Iq1D8UWv__it2ZV_kwNt3aZkYv0I0Qvb0dHM0F6m
 kwupLPAyECt_iR8dFLW9AgmkbJFpENZdKWqFKku4WNe99K_A3cCjcw6lMKq87e_xpZTcoPBKbw75
 n0HDV2usDe8nWS06PjWlqqrBGbBCaioVzk5Zr7ab1kuwssnjtMbKqDtLjuqb5R2OFPXPFgrZZ2d6
 h8BN1xHiv_2_j_Xl3PlRFlJjXs5r3lYJjiz4upbDxc2sIGCwiQYO9rB5OOYrAby5J3RzopHG7j9b
 afmO7XWCzu32bih4OzOmXzftbSZylSVTx.8q4yAKEff4OYpqtZnTVqrH3cIeU5.SilVCQf6TYG3Q
 EqJ53Xaf_ulHlx4r6Ng8_j2AzYSVqsS_yEVsjPcAb8oDXkH2a4gHhhdo0RXDXjnhut.gA7qsl.Uq
 B2RbEXyV7IiAV5zUKpj.grHyRMuXQY4rDbgz2R5Guwjvxg4MW5yLwS0iMsnPARudoLW7gN9Ds.EW
 _Chd.0kWJGAfefD74EspBfn85CJUIWMo61vGApSmYbDB5fThoiGLuhKllU20VPXynoimiU_tg_UM
 LJCYrLE0GCgZPBZxwkVR2dK0fVAUTDDrZqPknM6pB0xdg9ISehSV5MU99muJPLMO4DuXMGkl4UMN
 4Af6SJn23..8AiRlCT9FFJ6gxjWGCy5KN6yc.23NNVaVIMgSu9ZoKXjpKiBvpbc_PTmft6O.U7P0
 XFRYXAhSrQkIsXVvMSz3eDF5Cf4wxIxT0a6UJ2oWdAGDuQqOVlfOb8CP3ZY9zAphekZhmGeHG47I
 fm7scD6p0ZSe47kaRMu3E_oaTG4v54Q0_59UP1kxsMPIjRrFu4tug01XZIC_5Oi8Kv810SZZSwr9
 zslAbElBzYi_pW7P4JUuAWk1ln57qTk3y.vGlDd05xRdlMTzbiDa0zHLfVaCUSdQmsNx.uuKJYaz
 v6fm2nBwDFPbRkgSlgif_2B0.WQPOfN6Tmsn9_CVXBVoLSSDwk1TuCoAgnnsy7AX2Wx09jdQ7.oA
 Z_ev7__.jOvlZ0VFt1FNxjhbj1iPP58yL2olNh_2bnfVNDnkR_AeV.KukXt5KARTyBVpSzrtafjr
 7FgORjszlPadLvC2gmHIvEJLu5njgnFznGmLBvuvl8fpJgF.X4X9.zEBuJYO0fjpf1danzS4x9Bi
 rI6ttGDOhWxQWWXmEZFBIUioyKGykJjE6KZYYOve2R.kS2ylhx0zAUtMXkHE0rDIZjJtQ3kAKuPQ
 AjTDibsJoGKBgqJp3wM.38lOcRXUTj1vXLIQLzSgCys44x.u0MqimODkOL5w.ajE7XxRtN.bPDG7
 VD274xbaOuX1LJKB43zqihwi05x9_klvXEJYcGDWsXh8kt0_zuGvm9.prPICtNb15eZMSHQNSeNV
 ahjcqLcOaZJp4EjAm.XiJxmKmBZmIJKASdQSo_KDedpCWhT__KhMXonXZZ1AcGEyWkB8r6Oh.5cM
 Ip3KcxRqlMB5sU4ltE5mu4kHARiidrlFCC4BqYD2BjDIc2SDv4U4j3XR6UYR83nS93hWfaua_ltY
 dAiDeR96rhMwNRr0fqbUzOK1vOHIj_mFswEoFfR4msVrnqoIa4sD8g_MQ4_8klQ1vRPNkR5lblVT
 acrP3E6KoVsuRLEKIvXkBF1TL
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Feb 2021 23:59:03 +0000
Received: by smtp423.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0186dc1b6d786f91c9d5935a59c4542d;
          Mon, 22 Feb 2021 23:59:01 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj
 variants
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
 <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
Date:   Mon, 22 Feb 2021 15:58:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/20/2021 6:41 AM, Paul Moore wrote:
> On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/19/2021 3:28 PM, Paul Moore wrote:
>>> As discussed briefly on the list (lore link below), we are a little
>>> sloppy when it comes to using task credentials, mixing both the
>>> subjective and object credentials.  This patch set attempts to fix
>>> this by replacing security_task_getsecid() with two new hooks that
>>> return either the subjective (_subj) or objective (_obj) credentials.
>>>
>>> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
>>>
>>> Casey and John, I made a quick pass through the Smack and AppArmor
>>> code in an effort to try and do the right thing, but I will admit
>>> that I haven't tested those changes, just the SELinux code.  I
>>> would really appreciate your help in reviewing those changes.  If
>>> you find it easier, feel free to wholesale replace my Smack/AppArmor
>>> patch with one of your own.
>> A quick test pass didn't show up anything obviously
>> amiss with the Smack changes. I have will do some more
>> through inspection, but they look fine so far.
> Thanks for testing it out and giving it a look.  Beyond the Smack
> specific changes, I'm also interested in making sure all the hook
> callers are correct; I believe I made the correct substitutions, but a
> second (or third (or fourth ...)) set of eyes is never a bad idea.

I'm still not seeing anything that looks wrong. I'd suggest that Mimi
have a look at the IMA bits.

