Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA56C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE31F2075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kGz04hp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHZP1H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:27:07 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:40035
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbgHZP1H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598455626; bh=5Y1Avt2lYh1VGgnMFZIY8U8V0ORICnB+F3ZB/kSXHoM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kGz04hp8+jvfPSNe8xtmUL1eh+Rj8XGk6HvlDSh1uuJ8U7X0BhOPaUQlcmoxpFOWju+qZcUTF/VTFIBkdWLovAkncOGZRveLdyc+IR3QoTlFZLqLSxPORg2It+BYWlGFqNF6Du+nJ2wGGLWrwppAL016Ii/bWbKRRiTc0/1LSbTMyt3tRtfpM6mXfQDQOme036SoyRjdULZYgUCryyicZ0ZLnbRNekzHtYVfS82tEd9HMxQ6yMN3G/r6X/1aFTmSgiNO8h3fcz88V3RyFe3QIruR14zRjDXqk9htuSyJDgLiQiJRmpPsCwXVHV6EheYNt/5jRT5FEAXWOq1k6qgJwA==
X-YMail-OSG: _pJE7_sVM1meXA56Bcfg0IRYuoeU8IJfqss204jAi6XC3SF_q191.SFiNAxrpXB
 Zzc.gA5rTCGN.jemSXx4gI.LSrqxJuIk_vjAfn5tmJPOyTkXZ5g.WQiSmlKhT4QStmxhntwy5ZJ0
 NWIRQZpjLfnvTU4m4qjYgDy35IXyPPqr.5TlSd86C2USJLBP7kUH857fC8E_C3hpha1SWXiCu8Kh
 x0byvjMXuJiD6t4Plr4CLXYWPa8_8FvGX7ChMvKRPZDoa3vz_i3eJsdRrCGi1n.zACrpHimqj1O5
 i3CHPQK6M2w2_KNPTASde9fblfshj1xPK0en9_XEuFo6H2ngi_UdlrgdcZpFvuVwZGhAxBdkfVcf
 hYTwv4VJkXH0jIKXiLenlVGImmI2dBY2mSCRk8WjIXX4QLtmK5QmVQyB8Ngzd0279cmqyTDBAhEX
 uajQdgoX4kqYMwxrPICgdV2wntoxB.GdboySV48.Crac5vNRJucJcNlbHK7a6zXJY39tAkPOC8sK
 f0h_sMmqdDf5dNkghNtJehwAxXdXzmH7_cxAoA2mOQIimoGmtT3zdMozEqWRskNAghoqF8y2WzA_
 I9ZyQTrfx_jZxKgQClHi1p353yh3QYIo5Knb1njt6bwhMUv5OLC9YW7Xewbjbg2SlC0V1DKxgccf
 PwlMyQUOdBFs0Kc4dk5j72ZYRfBsK_iOF9D01AmkHB9oTquCCk8JkYGMFjroexU1znnqjCVrt8K1
 qs52tkltqnaRpg0rqV2D6vqDWj_m8gG_GogRCUb2vtOy6pZEjkGCR3mimMT2jsD.vKPq6J2iiCae
 i2QtT2hItiFatGXBujwDYUJqQOpSpkUURPo2FLdBQUG0FwhuXXmLrB4k4s7jNPFToQnzukSNhe6k
 iBCRRp77atw8yjLy3lQPDRrYFVr_y2RhWII0_y4HN_sBQsZOO6rf8cESYN0zKH0r6.f2A8IHduIA
 KZqa4PZcq67Ix1unR0yit360dAC6cV2.x7HrW4r4gq4YSpKRbvxnVQlB8pwcXbaqfKRS2rFRHJqv
 vbR1M.ESsfk0m1z.1LL6DX7sxUmb1yZuHCXm0lKqEoYvcps114OMxQ11s1Pn50ANfWSGslelkDWJ
 byGU_I9QtmGNGrk4OXFVTj5ol1Ct0iGXV01PP6OJdtxel0.HGGjSyTXOUDhzdvokwC.dTaIITaX2
 PbsaAESUwCVQ5lY_dS.EABdVvGFeWoGVwZ8FrQ8.opszNqZenUb9sNZ75C8syaLMBFMftV1NqJFQ
 AIX6ovvFjCrEIvk8z4WnV7ocADyEWvcxp0QLJlTJ.OLU_Brj2C8X1gFnCVfG_km.yXsmIh1FXouT
 W1eQ7ROig4ltNHNC6PLuA_A4wHv1kKhussqWbWJI1IID9EVJ245zdLTXZyQO8pdkD9DZFRY8e4RT
 ipkRh5GQ58po.IUwViwy2FzNSBR3uKDp7ltsVc2JWEZMVH6K_ehp_Ys4qo731PW4QUjtDhrVgpKl
 o95aeNB2qdHE56de_Bj1tFIsUfvIqySPAfLHPjREhSg.PvtbCRwewFQN6NcapDKwXkxCXhL9jUaK
 7ZUSW7Hg6nJEtI7YbctwJtA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:27:06 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b5b563c2696ac3f378a8a1ac18efa795;
          Wed, 26 Aug 2020 15:27:03 +0000 (UTC)
Subject: Re: [PATCH v20 00/23] LSM: Module stacking for AppArmor
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey.ref@schaufler-ca.com>
 <20200826145247.10029-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a4c67f8e-66d4-2c35-0640-9a75fa15cc4c@schaufler-ca.com>
Date:   Wed, 26 Aug 2020 08:27:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/2020 7:52 AM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
>
> v20: Rebase to 5.9-rc1
>      Change the BPF security module to use the lsmblob data. (patch 0002)
>      Repair length logic in subject label processing (patch 0015)
>      Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
>      Correct length processing in append_ctx() (patch 0022)
> ...
>
> https://github.com/cschaufler/lsm-stacking.git#stack-5.8-rc6-a-v19

https://github.com/cschaufler/lsm-stacking.git#stack-5.9-rc1-v20

Sorry about the old URL.

