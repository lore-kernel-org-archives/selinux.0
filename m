Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D5C432BE
	for <selinux@archiver.kernel.org>; Fri, 20 Aug 2021 23:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D524B61186
	for <selinux@archiver.kernel.org>; Fri, 20 Aug 2021 23:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhHTXtS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Aug 2021 19:49:18 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:44181
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240334AbhHTXtR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Aug 2021 19:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629503318; bh=mQ+fFlANdMZw0BHp5H/3Z5ATOpMi6G209RL/ihBma3k=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=pGZXrZhCZ+ymPycwmAHybbmghx6H6kiNceLzaGlydu4Kc4FjZiNC5eA9S9COUaa3MW1/SVCIAgSjADw0ZRcjb0Oeu7AL0cL+6zXd8wBCGEIXPGOwlZDlohOgsPaR00b5VHJtXNbk1/BBJfNCRzwrBJxvRDhQHqhg4jvq+Iqnqcmcpax9le/tQAeKsubwJhagJpFK/fFi+vJUX7Y7Lu8y8/PiK0L178IR3U5pWKZ0nFJJ+PhbgAgtOsZc/4NA1DFFNtHtTaFKf8nP8KB4d46Au9dDPggz8qg7xJCafaBe2B/z5uLWMeOjryg9DcxEQ08YmdXOnmLXfs9i127EE2/deg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629503318; bh=VhEqJ7bhPxejGMOeycnqUMW1pbnLstX6znl9HYOcx5D=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=aG88CV+43MrnGR4pOGkDBjVjCJOajehN4XJzLnFDPLMkqg2SoJG7Grhmydyl1pOWzlaXry4K7ZMOaheGqAkdqWrknBtLWSNO+te4esfo1I/EqOSy/qhqfHduODoTSeOmOwZUk1Ibho9/VnfV4wqAj9xON9Wa1c2YXtc9n9ZVcZzq/OyCUwJlX9lmNXQrWPkcnalrCgO3S564E5AHSlLyEb/FscxcUEC2FpIpC97bwaiZ7Olz7nPTnnhIv1K03GsptdLQi1QJDQFrnDcgzldXJG3PBjOUi7DwvWetytHcZfbpuX7W4xRaFjlGXatrIb9F8LvXzDWb0i/hIUuEDYpvvg==
X-YMail-OSG: 1oPsnWgVM1mN7RHdGHOkByHcrPliZl1e9z7fpkpF.iyENZ8rilNENw4pPrjFGjB
 v0bXgcvXI1itn0O66jXZ1m3_vFq5StBLMe9eAGeL1rtgdnQ0XHN.JRlFwTYo2Gvl_DvD9McC264r
 FabhOyzZmJgMcN2ad3RKfHVyT7yAKNO4KCiwsyT.ilGGPBaOS.hzfcbctEy.NpAMsPbvlNNPCpQw
 IU0Eq8trnD0pDUSpcVoW1sk_py3d8iIXvwYJne9LHEPWDehHlBwZU1w04Kn6hovblrxowy1RAkax
 4npL2X_m4sLS0usr_ugMKXyuH.zKM5Qtw42tOwcTp9pqWFMNzdj5qx7FkZcoNZiyxW4chhHGhkNL
 rshfLlkK1Vj4VadCL01NwPdEeBOa6bNnvTG2nGLoJSBm6GWmTKKqslDnG.214EdBtFMc2IJmlkvH
 4cACByq.PDZeFSXeB0ENp2RAbWa307jHxVNF430Yt3qeRlPb5ckErsDzSQ1_3NSVwJ0fsQB3qgAB
 XLrFwD8LIqB0xjb4oJXDNqQIxkGIFTQLJMpuH4fM6OVSUWbcphWZinPu.qS66niEZ6t70iUoBhLr
 F9TftaL7.Y5yVuv0p9ufP4VYKebgcVlhEUFL53eEpEVqyb7I7_F9gDbPaTxVvqJhbPDr2wZ.T.5I
 PPGkeZJb5kUSSGd5wH9_zDoh6bWf7JhOcFrMVxsOAGOrnwSlnlEoyqJ5fMsgH3k_vPsC6h4lR7dy
 g9uihdHDgqAfWc6yOqZWz8vDYXwPO9xCQW7gTVmpm_Gvcv8lergczphKZuTeNOHpjvaa4JoR9Ja1
 3.fMn7tcaQT3t535aBaJbhRzQSQF7mhu.NyMqTiKNksepolJ5doakcBjtT97mqzm_94Cy3p0VSuS
 IN1o5tqju0gD726vlClpu0BGOqEoGCbSfLlLjiUVpanxDBCL.5quaHs_6zCIiYP2gPeWMot8fVnO
 NEEc5WCFjyxc70jqbs0KiY0VzYUKyogK0yI4nkZNXh9h2cWZ986Zt3XES1LGPci.rrKZxrcS8KHN
 grBqrEUpi4VKFpOBNRt7u2PRATu6DnZKt5QhFIMtifzn.E.lMTzZshSjjSO1sdiwqdF8myoeqIVt
 zFcfdZFKiyLZ847KNU7Sfm0CE79JSUoeDevAlb1W4ARYvO7f6oxbB5YRfKEbofE3D861FGFRmBm8
 c8sBZoIcj7Rvp3uQRuNJtv_gl0qt5Q9h0QxasbXIXUFhLhNTkxQmslub.sEvYhoa_BMO9nztM84U
 5TiOv4ODrpd2c_xlVj5_hs7AuGrWm7GThjdkR.sDjLh43WAA8TCxd1l5eMvYAXcpQAG.YZlbfI1y
 6j1fjQWDrhPKdVrh199jdrENa56e8fe3jkX3SqZUbaYGMtjx6eaCqjyPKh0K3gR75cAUDNPL72KV
 s8lchwKIhWRnIGUALGRqd2Bf8op0W1B.HaNAGhpEhJiUo0pcgakgcJ1wQGrmF6tEQcGex5.jPZ3g
 X7.4J3WF0w7sUA8IFaLR21gP3fM6FQVgc692BiYjP6wWyqSKsIXICr5Ku6wrxTPHjDPa5U2aE.9k
 f02JPZcNoB4HWnfnEdeMQSRSnWBmQLN8CT8PDUxIMRPrSNnU8X9_SH6vuQ27H11iPoZAAugntg9g
 pss0dM3IuxxK1WolLa0iDW17D2U_Tg7UjBEpw.OlwbapgKzuKwgU9nJGGADzkF_bzx9AfijBQA6L
 gF3E1vVhrtfIbEVa0AG_3I.nFwQseKOmZKN7yAZqx5igttlD5Um9WqJUe1tXTdQEnFOax5Ngzc_2
 XDcufa8jyENY_F4ZzJMFSJQSn18kKDowex0zWTZccFP1zFHBFrtsYsnQn.DrOyL3IXEZvOEPg9wF
 GnSx0TRW4BByQDKIOCH2qUWLWPWLJhboGwwoPpEwgW.hrB_q8EcLRA71gWy4gXOmIdev7nBAV.Jy
 9BcCsEt1sfV8Z.XznGxgoPE8wyfP1MQfWl_2YU3UG9AavJAXPfYJgyw51W8KuhxjAWXrTc7OxshN
 digHwJXwRM6jOAlZXR20KVoWw0fCRygwRcePIngegJeed2tYDsZn7dQpaDeqPFpnK1RevXrvWLr6
 UPi048vIpbIni7VDRo0Bc3YP2DPwnwqhe9gTbeAisn83lIFhOFvL_dxNSOAUL5jjBRJF4ejdwfiC
 SXeQPwVk2CQVSJ.MVOsFedsF3a7inTPOVA6K_P7BClKXvxzzIV.H2ZY0LYBjE46NxTni5aLM.L1G
 26NAnk_EH7TY83N8M3DR_u5M2OBFNXLaLMCOqbMLL95LMKAtvSZCwJzN5JvG7d7TdZZX14M4SXJW
 e91ut9W6xk6q3q4S8X0ozi.spkE1bGPZlaCFeWL9_I44bde_lbMK3x.O0XFqjqQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Aug 2021 23:48:38 +0000
Received: by kubenode534.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a5c7f9da00d3aa0016b48f9364e6fb8f;
          Fri, 20 Aug 2021 23:48:37 +0000 (UTC)
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
 <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
 <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
 <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <be20e3c8-a068-4aa2-be52-8601cf2d30a6@schaufler-ca.com>
Date:   Fri, 20 Aug 2021 16:48:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18906 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/20/2021 12:17 PM, Casey Schaufler wrote:
> On 8/20/2021 12:06 PM, Paul Moore wrote:
>> On Thu, Aug 19, 2021 at 6:41 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>>> On 8/18/2021 5:56 PM, Casey Schaufler wrote:
>>>> On 8/18/2021 5:47 PM, Paul Moore wrote:
>>>>> ...
>>>>> I just spent a few minutes tracing the code paths up from audit
>>>>> through netlink and then through the socket layer and I'm not seein=
g
>>>>> anything obvious where the path differs from any other syscall;
>>>>> current->audit_context *should* be valid just like any other syscal=
l.
>>>>> However, I do have to ask, are you only seeing these audit records
>>>>> with a current->audit_context equal to NULL during early boot?
>>>> Nope. Sorry.
>>> It looks as if all of the NULL audit_context cases are for either
>>> auditd or systemd. Given what the events are, this isn't especially
>>> surprising.
>> I think we may be back to the "early boot" theory.
>>
>> Unless you explicitly enable audit on the kernel cmdline, e.g.
>> "audit=3D1", processes started before userspace enables audit will not=

>> have a properly allocated audit_context; see the "if
>> (likely(!audit_ever_enabled))" check at the top of audit_alloc() for
>> the reason why.

I found a hack-around that no one will like. I changed that check to be

(likely(!audit_ever_enabled) && !lsm_multiple_contexts())

It probably introduces a memory leak and/or performance degradation,
but it has the desired affect.


>>
>> I could be wrong here, but I suspect if you add "audit=3D1" to your
>> kernel command line those remaining cases of NULL audit_contexts will
>> resolve themselves.  If not, we still have work to do ... well, I mean=

>> we still have (different) work to do even if this solves the mystery,
>> it's just that we can now explain what you are seeing :)
> Yup, adding "audit=3D1" to the command line appears to have gotten
> systemd an audit context. It looks like user space enabling audit
> doesn't assign an audit context to the existing systemd process.
>

