Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEFC4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 22:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC2E60230
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 22:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhHSWlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:41:42 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:34598
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233488AbhHSWlm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 18:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629412865; bh=7jt0xWDMthlYPRW/uJp7XcVm5GRd0EBJR4RWRBOHQPw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=m8bEcAU3opGLh7B5TErD/J8sM34ZUn8c3uFloK3c69SRKb9tevtcjAqCGvYSKA74kSUdDX2EKMmDzwile0NP/D5SWTAdMDuH1uNJwR1TahbPOi2DdWvpmJ3qqnMIQdhk5FAXT0EU6I/cQU2H34fvnzH5DAFFr/7MFOigqD11XQTgXA+Ba6CqgTCnDqFTDExfCdhNLiQd/+7sYaUdqMzt71vmQvo5pCpa0vMZ0kwcD07Ti6Xs0HuHzzL4UArCzyLkUKq7RHTlhEU7aSd6YnjPoi3UrVp//HDgcxhzo/c6oKChNRV5VVhNmfgAnhZT8jRSkFCIIg9Fro37XMyWcls8LQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629412865; bh=XA8V7nvHBoL2lKIuZrbuSUNE84gzI5LEggzeoIKvBsc=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Ic0h/OmUFTRo02/xonXFjEQg6Vy14Rzwcz2vLVHPJxkoSkn22pOAkWXKnyaLRqwRNheznSDTkOMKvt+FHTV/gjFnUa5puhF4EfskcTx7jl6JoIOkTD7nCEVCvKgLdQbX/R0scYWivj1gLNdIZFEjaMaA5kAq2/C914tjD7Pg1TTSWM/sQG/ykVblAZK3kQXIGOWbqfOevn4zMZFPctV6PN7dMrhvgJlmKWnMCVqvlxsNXAW94e1CnQ4cFOtUDoZIlZpI2b3EHVwOdwCxhJle0GcuD23Ghc5FRimlNb2hvhzyNj0iRssoMrayH/1W06QE++MBDU40QABi7YLWBhNL6w==
X-YMail-OSG: FxVSaP8VM1lhA5u4uY_bmfAqZs4qM39hXjHnWxd4DtrFULL7D7TWAacPdQTZPk7
 Rd4NoOM6S9lZwW3YOFSRSj53.BO1WuMB0MbQwOw8nbvZXNtTF5SpkyK6bgPYnk7teUPz6aJm7HWn
 hrke3JpNVX6vRY.lvFyeuF1WvilLauMBzKnjEISHjnWspiu3iF2ylyFvPDE3ZNeCKJM1PzSWMwjY
 ljWJCAR_AonCvwZCrfULFCu4ZYdJOy1Bws1_HHa5z9Nw99kDNpHmxi4nn_xxF3ljjdil.8G72ahs
 a0n9WFntoURNVkk8jkGA4M5Ex9jM4pMcqU.eyvDQKydxBFcBsKJgVfq.b63SBT_owpX132SRTDPq
 FWQb63t4D2fhzW3Av6US7mPmuKwByZjWovXjp4YBnoh.68HsPPzBvGbYMOEdVgiADG7A8BTQd3Hn
 FufBeV8GSSQQMY2cyDagsNfl7LZcsiF2qw5UyPH09uyjvJ2_ujYYpMJCT0eMyHMjPPdTHLom4IpY
 pYOd5xNA9XpXwHWp_QpuULwKbpxHGqg1eNT16h40W8_W9QiA2cRBVDWVW7RSylEBR85jEq83E0Ph
 HmQajRu3NtMgBGrqASMkycFpl7TetKjVttann8_zjbnEDBAXYmhBdhbXn4PXhv3QIW9zjYRm1kqP
 lr9Z2oqnZZXwXs4gSseI.rOKKaz8SekGeMhCFYEtGXsM8ryARUBZ2o4UoU_4MIy3pQUDdtLG8S6X
 FOZ6EWeOB.tFVvNumFPZEZHr.xYA3xM9plhefElABLa.W8eulZXg1gTStcLWqSY9Rp.aDWn.aByy
 HxzYrYzNMmfCRVLNfWQ6aB7vTIgJoPdy6bp8xNzg_DHFXnq9lNcYYpQVVe04jWSTIliCIgdjdPuw
 7FGAhQngRMaAls81lFhJwNf4ALoRWUD.9Pk9uJlfJzuTbMfaqw0925qoz04X9o7ikHsXTKEpDY2_
 u5pme127n6oJPBa_B5U_bxALlHXgQBUAshNanD4bzLQoK7jMb8QoglX1LaZKd76UzkwHcnHUDPUm
 b3KDbzt2n8PSqgZ7VMXmbaLu_p9jN22TECq8IwKMN7SdCi48BRK0JF50rYuHncd31GabLsjqFbWu
 PfSgsumI6a2rgkkmnAvO1gsQSMxFaZudPDxBSs2bU0hcJr6kYwYttyigbZttMpPzZfPsf5g3gc86
 N8WSmYkQAezmuE7PX69dbRTySZZzVx3g_cZ4fM1_V9kev6YyEvbOXDuAbDQoKRzD1IFCyMvYq.my
 okxpgU6P4PpivsAQxuWbz0dVTQy0qUbGVwJiRKgJVbypOtj.qbgV_cPXM5bB8NT.dcTEdykKGt94
 iNA3WgvCLBP7EeiMLy3F2FlI09YfJwCT4Lgv1b..pwrMp6htzzA9MCsDPjLW_cV3gcuWxP_lMxX5
 3XzmFqd2A0ztdC6th1FnIOIRKrAcCiig0BW2TKBcfLdajfnzPEgmficGR38YR3y2Qdp7TLZqzjcS
 rnFrluU1mvHlap56fOEeBxC.ns5H3.e9_TVqYKBuGr2UzIiUwAeYd65mdFLNJXEPr6wbzl2Cnc8T
 w1OuaANjCZxy1ergq5gUOnmWiWainzgFU1i8nLMSbG9zH.qdnAVfHNdmYMi4NzWDdA2j55jy8Clf
 CKKaLW2hMC5naToSbuShpkQABWngSY8.mrYkW8XAsytHGB.7UAG4tnBOV1pYEWLL3U.5JdQK2n_d
 N50uBbUqNNLggdbIoB1DugtteBKfx0U8kEKTJd31FsvNa7jwEAktBICh8Fi.LG4gkBdVKkghdDnw
 omLo7I7F9NMS_fNtyFNANmuwh1OXkTTu9DaOytqh8mw696aUGCKyIt6Meg97zqSLGsxSAXBJigSv
 WBUa0QgR_nvE9ftmd9iSn7fWIbmniRshW3.jNM2B2EqsndBttgPYZQ86XfLSJDd98V0N6xbBuKvh
 Ip05tzDTcyqL4T6aSOJLmIfghQOg3ihfQyxxhqteltbynyEjmqM2PIKO9vjukSNgJ13noFs30cwP
 e1fDNW007Fe.zDf6jHtzwZHFLhrOR8HLAh61BfuE7hyPoRXgO4ayMtoUfqeCQTveQoWvoMpSfYDo
 awmm7sI9EmOgPTVtqPB1TW936ueD0ep2zgkOk8KnmL2RPmlk_hJIVfwLlNhAbgEZFY1xteEVkb.w
 XZUkz4NnBEr78gWhhY70NJ.8Cy0nI1rGG2ztUKFlyjqzxv5iUCaNbVi45WjUwxPABMv_LQYbY6pR
 QvhQF7_BVMG_Ay9Wm1mveznrvjdSMhGDXg.LdZH0tCtQNxZXs8TEspsuFNTF5_qIOYeTWE1yc2gA
 187Omovxll2N9w_HVPeB.bT7nVVI.gN20nbXl51Saf5Pkbj.ABJtz3g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Aug 2021 22:41:05 +0000
Received: by kubenode558.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID de3529738da60bdad851ca6afb1e6322;
          Thu, 19 Aug 2021 22:41:01 +0000 (UTC)
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
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
Date:   Thu, 19 Aug 2021 15:41:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18850 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 8/18/2021 5:56 PM, Casey Schaufler wrote:
> On 8/18/2021 5:47 PM, Paul Moore wrote:
>> ...
>> I just spent a few minutes tracing the code paths up from audit
>> through netlink and then through the socket layer and I'm not seeing
>> anything obvious where the path differs from any other syscall;
>> current->audit_context *should* be valid just like any other syscall.
>> However, I do have to ask, are you only seeing these audit records
>> with a current->audit_context equal to NULL during early boot?
> Nope. Sorry.

It looks as if all of the NULL audit_context cases are for either
auditd or systemd. Given what the events are, this isn't especially
surprising.


