Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCF6C4320A
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 00:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C236610D2
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 00:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhHSA52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:57:28 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:44904
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232954AbhHSA5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Aug 2021 20:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629334606; bh=SfnLOs+vldwxKv1kTvgNMHz6BgnV6ALefQ3wBXiRAvY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Ca8iZBIBwxTAVZf98/4Gb9DfB4Q2hjdV6Nhie9FcIVbPYJQz1KWnV46p0pCA7otpNWXWcLwfywoXRCGGNlCAY68PkMou9k3EAG26Sd/D1Ic+oM50NDcpzdcgcepoZNiXXY5AlRjgU3ZhAZCSNokJc40FVoGTDMhNop/0tbDyasefQBOOt1IIjQODkzs0iL2pN8ZWY/f7wA5Vctz4sK9Eh+35/5yUbFl9K0/DcG/3qgtZnNOQLaiiLCwmsVu64T6diMaiDc7q6PzaKi89ZxCYkAWrSFqqq0onyo9R5m52ONZUoP/yk3PwK6+OuQQiTzHiefyOt5usIT0P1oBaVGRrxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629334606; bh=x2wzthF1649NF2uq/HBMbopToQeTdpdUiXab/3SjrjZ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=UuFAXw4Ie5ZKB7idAI0VF0jaJPGP36oeAaAIOQh45f1i8kBw3d8wvtP27z7aHf4C7RzW+7E/QHlQm1ScWUd+EJbmfv6EUVSb7NtUntxyd5TT3MskGMuaeNhrKlSWo2YE8s5TQgP8OmU+TNvz2QUHso88HJi0z8wZXmLfnVyQtukqKDoS2OwFcM5q7mGpI1eaxnUTkp3GtpkBbyhLb/U29SfPDNQ/7mz3nO2pYRzly3QH19kRO9bdGVtYm7Br94lfPrC7NoI7Sj3ZsOkem/pIC1S0QEX6+ELa/5AhxvWi//Dl1/JBCZYO/wILQch965nrbFwNqTTiImNBVRYaeATXxQ==
X-YMail-OSG: QLAfCaEVM1lrXJbNyeEHYmiE4YVMPKQ9lsfHZXqCoQJJdNyuNHOo8yLGe7ruc2Z
 Y6kfEKIdubVC4YDmgfXOQBH7FvcGk2f18vuTmuxg06G2AyfS080ukOnCPv4LRSivxFtUraYN7SyC
 vVTxI2yQvvVOeUr_obhvq9CrTM.kcMM5Q2_G1gP_UdFNRQ4r15lsMCGbaQLgvUmrWrbIPtzDjnHY
 nWdnVfrB_G4BqxS4pmVeLm8QXXERMVBsVCF7L3o23mOE2Kym.sy6iD5upYYVfC36pl_iFGmM7Yo.
 45e4cZeNvwHw0V7KUD0.6yWke9v7plRqO5iSQEhvDo.W.FoXlbmFfO4XHc5ZN.DfnM1wILny1rV7
 wDGgnCIjn08qRrFEhxCsh7sWAWyyTXxR8Ujb.U3LpfBGAbciIPRTX_FcMXeQX_hmOMZ3pd4JOOvp
 Ll1vRQj8MPiE2s2UwWwHVPsZNUyC0ecBXY12YcSK5hxKkPLnPP9emRt3aB2qYjFMzkv8bnXkg8nM
 lE20eav8tvRY9yBiZ1TnqotjEz9gPDXdC9dPW8oXuTvfa0rwS.AQIbO7sTmS7SG368HYCaD59DU2
 BpEkv7SOuH28b_T7srnZZMHkgt8VF87c7IsQA6jC1rPNVo3LFeMOiTlrAjjAjQKDs1nXNrbqXYEe
 UMo3hGugBIxMX3RcK6CIM.o3MD6IkxvHTN4wtnj6WgmslFv6OpILyfEvUc0CZ6Xga7IE0ERhuJ5z
 6um0LjrZ0A4eWX4UiMr6AjI6sXvMequrKMAtAg.GEpGV1fOrsmIOwn24CWUO.PFPZewR_TMiIGAF
 XCsxYg_nYTJVhzj.sRQWJiwxnOqkW2BnKqEkI_9gFMr9.GWYlYifKzLvoyE9Itl81f3eeI4LquUG
 a9qmV4j3aDcWBx17jP1YHg5.HtPzn_O4.vrLCLmN5ZgRNwtkdg6SVLOVdcEiWfz9AxbeBOGkYsEu
 Ibh07cAouuRyRQ5wUrtDyOmTPfM8f4QeKKJ.1JKYwLfZbyiufcCY3R9FZk3KcGa7leELsD5c5wlL
 WWyY2eGP0TO5WLrSeN0TY2sifM47p.if89eIVelS1kmODdMn9mtFBlLT8hW4uLhFobQ7JCbKiOHH
 iPt7J3YZqR.2wn3ZuUMEaOaIhh7dJJLxhBm0nPpv0M9f137KiISuHOqadtqEeagsG2dEOXrcOOIY
 0f2K2_vWhuAkk2JoSGe7cvFmMw.D5O3hqXVD7F2aKYlyreUXPKFommWIOEzrOiloSRwOOW3wFx3g
 iPpqQnxwadtOtHP1vJMbZZP1MT7FfKC2nF6c89RjSRwhBcSSmr9xRJpPmAlLwA26eidotn1_oBKk
 UoJLxfILnUiN6AJKun6iqtkPQgOFLYa6Mii0G4xl7qzWTc.C7WHIlOYnDoxp.r9KoceTdFMJh5hy
 GOn0gdVGQC4nX2o.4763FhcMMAezyY_vEs8RD7dT5kru.Iov6sqzchHad5t23Xnt0U6XRrrPZhu2
 HVNTvYaMnLvElMr4x3n5mFsW_qwddTUihNoex6PoGQENKE0SHD2W3Vihbl8ebHUgmnnk5lCRtm72
 6GBRpZ.7Id.6dEuNp_eWqnMyjQUpnck5Ea6FrV6aw_gLvO6hKEKabLon.a3hGsmXfZ6046MqT.Se
 BcdPve.s7mL0SumdjKTu_X.NtcVWqD1m.TdZIJK4qUc0gX8ao2rZ7QuIL5i.NZn3ZaYx5toCqCWC
 AXgyOWW9.wiT.eFi_Yl0uym8S6Qm0tAMFJwXsb8MfSSvD1e9cBe0tq8vI7_IaTKsHB9eAFqiMu.4
 stBdK.imRQO6Db7QP8mlDMtcfKPjI6wEuJ6ej_p4EoeN9FGFQHk8K._IWtIwLJ2zsxJrZHaIJ1EH
 TaErx5AFEsEXczLDg8PV68NFYxQ8pCgP0h.1asLJDBzIbnKwqskHT6zsjvnXFT1kbfpzMrc0NDbG
 7G61jzaes53tsEFRYapSr3M_VFRB9eiLNkYwZlOsoEG3Z32HWPpBo4OzaFM0Xuuu31g_CYzZmGgO
 1mIosty_T7b.sQ2l8WHaQcasWimq2ufJzHhM685.OILrB1z1VvHuYvWW.r9QpY_qZxqENhZ.XoKt
 G4IJGYcBpHPuplSTIzkISbUHIsOD54GkOAClj2VM2k.bl5_wyhz9skVd8ocfWzvqJ6gxOHl1XXF_
 z7S0eFFUhfswON3KIlS7eZ4QUIxBO3VkyFz.wWyr0u87YWgyCKX4mb22O76236wDYBq7jefYLiEh
 3BVmlkZcnIqtfgfjxSuIKVZDI4iBKNGW3fzUJh2xTIkzIglY3oOUYMCgTE2MEr5TR1k9FOHIgOfT
 SD024FXQMmpPjKjTvLPKhqvXTWTiTX8kwJXqlBk9UMsuI3Rx.2N9ydJU6WaGrOw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Aug 2021 00:56:46 +0000
Received: by kubenode550.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1409c36ab02d6bd3bfe1692eee4d859b;
          Thu, 19 Aug 2021 00:56:44 +0000 (UTC)
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
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
 <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com>
Date:   Wed, 18 Aug 2021 17:56:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18850 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/18/2021 5:47 PM, Paul Moore wrote:
> ...
> I just spent a few minutes tracing the code paths up from audit
> through netlink and then through the socket layer and I'm not seeing
> anything obvious where the path differs from any other syscall;
> current->audit_context *should* be valid just like any other syscall.
> However, I do have to ask, are you only seeing these audit records
> with a current->audit_context equal to NULL during early boot?

Nope. Sorry.

