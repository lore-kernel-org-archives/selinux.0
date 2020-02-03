Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67754C3F68F
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A82087E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 21:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Jku13W1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgBCVkC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:40:02 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:38195
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgBCVkC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 16:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580766001; bh=uK35RQU6gpNWZaYMQHgk00C0nUpoDPH5iw6IukJG2RA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Jku13W1JaJuuvcW724Iu9pxImdC4SO0mAaK5dlPwSkdzqz89dtHlV1zPdDsNkzYhQz2p1TaykoCK5jfKOH1vVdJxNeztS9kwhax+DOYZ4KdgXA6dRi+ioSAa6vUBPBTbltE3jh1qz0OwgXlihlxrCsiCJ+jDTt7NLF9QF0pKQ9XHCa9IRF4BOPbr88iDRfM6Ta1ku42TxX5tTyteFfTnzftUlMtLS2glPw8wr/JP7kyXMYoIhMAXF4a0q1ck1PK2lW7dYcjAlpYP5hZXMIZxCQ57zZM+nWyHTmN8im7tUdH0Zp6uwMqWVpNemwxAaj9s1Jjmbljw/aTYnrK3BM8KkA==
X-YMail-OSG: 3h_zMYAVM1nZ.a.VHxHwaJ3B6qcKLJEDCGhsXFltl8WlwjBPkaQrs1RgUWXT.q_
 qcjYMd6nXvbQAXyUno_21MuVlvEbYDNhef0S1qm28sSZVVfr2SbH.FYCUxASP8JnRNq7R4k3wrGK
 Hgh4jX19KczuIQdtxpbE2lfZ7s7csakY13yrM27j99JLbq01rxnxMt3ySFpXVY4cXNHLZq1lekfJ
 SYWJiqmd6VIy8dXW1myTz76yKAWr1OzGr8nDQQEo9v25AlmZdwwDSwDJ0pnJuBL9.AeF_IzIPhtY
 8jm86QrLnmIP20OLmh7.J0ZBhMkjoXJkmsA6fm0Ab4KipvSlhGuHYTTMgHsNVx13t6zZoI_5K4Xh
 3IZyf3p0H_8tSvi3K2z3hylRLpmm8MsnWHxcBftomzql1dy06WDvn7d87e7E0IaIfqWKi225fu.f
 Gy82V6PPDmjC2RS5SvCJg9HzssWJHhX.tAh7JFJB7Ugof3.RDzUnbEM.eHbzA1kOdiDa0BYa1GMy
 Y5wyUd6ghp_q30TtyTjFLExy1PLux_DLOg_tYYNfTjLIn8PR4wWtKHcUweaLb0loIS5QxW_YmFaT
 zNre_huYBrC9hTyWtqq0cTdvudEljW22gs7Vwgida1JmCsRRp2kYA4M0rwwltK1CFquecXtbnHDu
 JyPDUKXY2jD354nM5q4DX4WxlBKYu8bhRqMve027Uh0y6rf6uDSQtkKqE7nt.pwRkoh59LnTRCLy
 .4vlMWo1Rl0UHZQqhUCiEvaD9NNyH5Hjd7Hbgw6rOjoGj1ZoeCC0i_8p8Zi2HL11BXVPKslvXzBh
 .AycHxEojZjnvxKUqk9gDMAw7323KDCUP32v88TlMeq2EWGy.pYaykPKd8pbiy32bibnOs4wQf6R
 S2QwerBDKueAvp15nrrL357v_SxfB_8gKmEyCqWD18didnUE580E0qAO1BVrKZqYqLZjQaCwR43u
 Fw2.qEpOVlMbiQCjBM4GsrMFeisNF3WVHaussJe3bvvq8T4c3GQvDL2sQVYQpLUoKtE9N9bZlwkH
 kK.r7W2AB3M1W_sjGWZvVBU8.wmNVFO9Q7xFUULz.J9AyTJdNUFBEAW3rMq11l7p0oIL5AjYAzIy
 SjjlbI.1yR3mPNKI.8V5nd2Re8wfAVPfGXqI4CQ9lEVFpFsVa3anubkEG_cLhuIQkk_amKe5NfUq
 YdGIVDQyOyNzfv5uLWR8vxbjHg21MkBRzrhnkaYLzyXNN5WB2eQphWoAz2yyFr0Jg7zaEuL_E4sP
 rfTXPkwL1xjeoWBSwuQfqTtA86AXjXc7g7_GO4QKpuv3jt0qgSRriG2N3a7kgQJ52rbyjlYiCpSv
 OQdOwVI0AaYOQQChpe0wfP.iYZlr4iICsfp6hK_FTbbQGnLGE5DSwsvEuknT0IsmOBRGYhEu7UWl
 X_szXdu11BOWjy5b9H6hclG0iA4nO2xOD5B4t
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Feb 2020 21:40:01 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ff80b46f5bca8b2f9891a5ad90e9067c;
          Mon, 03 Feb 2020 21:39:56 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <cdb0ba7f-2863-d721-7ec2-1e01464e2b41@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7ac0fa7d-225a-a554-bc1f-78d4d07b8adc@schaufler-ca.com>
Date:   Mon, 3 Feb 2020 13:39:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <cdb0ba7f-2863-d721-7ec2-1e01464e2b41@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/2020 11:37 AM, Stephen Smalley wrote:
> On 2/3/20 1:54 PM, Stephen Smalley wrote:
>> I'd suggest something like the following instead:
>> * @getprocattr
>> *=C2=A0=C2=A0 Get the value of process attribute @name for task @p int=
o a buffer
>> *=C2=A0=C2=A0 allocated by the security module and returned via @value=
=2E=C2=A0 The
>> *=C2=A0=C2=A0 caller will free the returned buffer via kfree.=C2=A0 Th=
e set of
>> *=C2=A0=C2=A0 attribute names is fixed by proc but the format of @valu=
e is up
>> *=C2=A0=C2=A0 to the security module authors except for the "context" =
attribute,
>> *=C2=A0=C2=A0 whose value is required to be a NUL-terminated printable=
 ASCII
>> *=C2=A0=C2=A0 string without trailing whitespace.
>> *=C2=A0=C2=A0 @p the task whose attribute is being fetched
>> *=C2=A0=C2=A0 @name the name of the process attribute being fetched
>> *=C2=A0=C2=A0 @value set to point to the buffer containing the attribu=
te value
>> *=C2=A0=C2=A0 Return the length of @value including the NUL on success=
, or -errno on error.

I'm fine with either description, so I'll adopt yours.

>>
>> The printable ASCII bit is based on what the dbus maintainer requested=
 in previous discussions.=C2=A0 The question of whether the terminating N=
UL should be included in the returned length was otherwise left ambiguous=
 and inconsistent in your patch among the different security modules; if =
you prefer not including it in the length returned by the security module=
s, you'll need to adjust SELinux at least to not do so for "context".

append_ctx() is supposed to take the possibility that the module specific=
 context string
may or may not include a trailing '\0' into account. Alas, I see a proble=
m in the current
version for the "no trailing '\0'" case. On the other hand, with your pro=
posed description
the trailing '\0' is required, so it's a matter of verifying that all mod=
ules providing
a "context" provide one that includes a trailing '\0' and return strlen()=
+1.

>
> BTW, I think the above guarantees with the exception of no trailing whi=
tespace and whether the NUL byte is included or excluded from length are =
in reality also required for "current" (and SO_PEERSEC) or existing users=
pace will break.

The behavior of interfaces (e.g. "current", "exec") that are module defin=
ed
is only of concern with respect to to "display" behavior. If a security m=
odule
wants to provide a variable size binary blob in "current" I would object =
on
principle, but policy as I understand it has long been that if the author=
s want
to do that, it's their call. The "context" has a defined format, and it w=
ould
be up to the authors to come up with a printable ASCII representation of =
the
binary blob. If they care. They're not required to provide a "context".


