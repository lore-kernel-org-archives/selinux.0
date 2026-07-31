Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843729DB9A
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538881; cv=none; b=P1xMnbXArm3vnJTVnJJEv6OaN67LRyIvYKSKgdcommajx6kYPSV8IQkZl/uq2ntD/uMibpvCAGfAAjvuvhKSMOhlza70US0rQMcZ3oN/qFKEZ3FusgF+At2tPdOO7qRL6sD492jbJMl75aeIgT79+5vexyZUYNZicfemQBq7xls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538881; c=relaxed/simple;
	bh=v8IrvUSBK/tb7So/oYB3Jwrpq8RTn6YGZPkMBlse4zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arch7meIQfuRraebxQkooWOnaCHuoJPf42WCwiqYYIfw3NU9bTvj4y72ovIp1TUrdx3JL4rtbrna4nonHPZNRwT49JeeYG6V+pkU+bCC4naQChX/ICRHfq5XCb10TJ0KEPja5cCJVUvAEHeoR+wCP57iBqthbnhQdG4tlXRKMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EkpkwbJQ; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EkpkwbJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785538878; bh=v8IrvUSBK/tb7So/oYB3Jwrpq8RTn6YGZPkMBlse4zw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EkpkwbJQvXXx+1ehfeTKqbZNuLZWaj+auxVQo9Hj6jba8pEUOxCg7jZj1uQWlTx2vvkbgw3xu3TARjjI9gVf2XRXXX9F1CvLUlAaz/bEJhFPL5TXVvLgSqQCEqzUG7ELY6+WJMfQKw4GwsblsVP6Pi5BmPsUWfjpCtZth5/SZTmxFjeOv5oRMqXKGFQcXBwm6nI1ijQ0JJNo4wmOR30HjOubqzoMikhu78VvsKmFGLr3UgLr7q5rWhSne5RB+dYLYfBAgVq/2E7OPrGQt5qEOV6+HcY+/iCDRrwsc6Zqy0Ns3s3ttIGkAJWQkNvicxDSZ8nH8skioe7+1h7pJ/QWEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785538878; bh=ZEtVhP2UTzyhq8dq43lf+Ah1y2Q4FK7EW2e4v1OOWai=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aOBRhnlt131PN0/fleZZnJlVaG6eyJMD7I+7zArWL9k51TrEV35pYCgfpNI2H5j94bEA51fVitwzOJ6Ck3joI1RNKAjqN+n6nB+HmSjq9oXP4lj3EtXNYnpHVHj7zX5q6Bw5hiYObZEiGXi//rlIbpFHzqmxukjY8mrS8H41w8BgSBb7QecLhx+oxD67/flvr/m92UpA7I3VAwSbtWbQMlkcH7RsHBliJqtJ1IU06oBTUTJaUMzMmpHEMvWr2f5ic8NlIgH5w4nw/UOFwAGJ/ewOPRmxUK5eOCt+JJo2e+nUoeSDDKWa9a8tFpRk3X7LYHO2bY8MC6j4TeHi9QKBFw==
X-YMail-OSG: 4ZmCc84VM1kiVeo4LsqzH82HiFhHiRVefB3_yBPtXuuvdJSn6RCpIs4Am7pMDDi
 PnZnlPWOK_tWXg37o9LjQuWZjmyIYp6pOGY6Vu6tMQZeEi5oz2CucCP6Q0GRzaxr6wJt0GJm1e3k
 WBmqDXONsBrdQ7esh2lePfCwtsL0xblYSd7RwzM2rTgFykcIzqxWx2bndyZV3A51guzlgx5zGj8B
 lFjXf3wHGG97P6lP8C_jyUNAMweZlDCEuE6_T9HAo2i1HJbWM3azgB_zeCsdCDg3twcPnQFMBU.d
 Xtpr2WgJoladBAjJfNN.2k9u_uWUN7v3xfo2AuCF42q22xHHUO7ovempqo1gdbRqL_j7LfjuhBQq
 K5vU4OZ.ER_NUQ3ldj16R_E6VCRrdhIK71TPVHuR34oTBlHABxgwuWWkBeGDI6mi9WUECfCWXnah
 tlOx4DPDPM3aNpOAWIazHg64E4NjOY6V3VupN.x4.wU0emitH7gwguWKMscopiRRHqd4u0Vfavaz
 35WnCLcQPz03SnmhgHk06YI6_VanOS5P6oFi2uX6faDfD9yDtl16FLyuH.QQbi7AL5rqQ3ZdPGaK
 v.wb4CSVW.zvsMw2i8L0k7yPHCrRohplYrOSxaarnekWmOrHD0UIOIjxunP09LWd.U58YSjLe1fY
 R28ClnWXpFrfVmRp7T6ancAJQ_5yRTRgO158K_wCl6CHEpgyizeGn3.ARfB_jYhHsIw4ltqyLt3o
 SBa9igoKGg9gvyN_GlF8IbadkLoF9chLzGJKpVhalk3YpFwOXsdXoBW64zyNTXAlH.4ANcZfmzgx
 6aAE.A88dR1zd1EckmRT4j80gSDfWqaH8E.pmDK4n.dAo374Kp3qO8lHUUaxxXg8p4ObZpz0LGYF
 c1P4F5yN_t5F66TR7j0enuVdu9icdNBBIDmQgWI6CsnxBktv6tj6tgHJ5T0OUWFJrTXlKXVLTmxP
 QLjcD4OEBDvcVh_F.yUSVNCDfg54ZwWKsZTIXI.n7eMN0QuaMeSnQCCrN5tS5FX99uxUcQcDNSkK
 hUAD_l4ga_Pv3nPp2zK_n1quRBqy0M5gJrcH6o9KbPL_0TTjNUITCpDP6PeN1MM4f_pJWbyQlzGb
 a1LQm8NBkgwZE5mMoCxKS5rN7RqBmxyICkbTP_TItpmva4YGjAgRkG7_OmHODqBowU.P_4rKu2Xc
 dZOJAasgjRBbBmIU95G8gwXbxD9FE9SUuHYuvvGfDc0WI4i1LZYrb1jwFSHR5Mg7iPsejd_LNDc3
 2W7Ea5QqSPkLET5A7HvBypWd9NO_KBSL3WtI8qnjbGmVi.mmt_N7yJSSKXfNwTmafgUufnjT.Txr
 HUtlLl35UVdMpP2REq4EAsnBrscG2CcpxmfdHdkwOcNpZdoO5w2XGuLJ03mD9XuAfR1gUwtu1WnJ
 nDcE5NbDP0XGs4ET0IPOlQPc1hHheg3XU1al4JpQEmf4qCFe1FvUiGmXrBIc4G9MmAhGVzjEB9mR
 MYHIz_TurTaeoVVkKZCRY3cicusZFZvPwFfjQOBcE7XWJt6PLs_Vtl0zW7OVQBMBDUNIdCqeVg39
 ph_U1wuR4JLDu_iANoNFrL3wQ9DzxyS5cEsRFy1lu0ox9u1shwhWsi8rwwqIenXul12g_rrwoINm
 3rDF.TE0CWORqsXMK42tojexEdDYW2P1PiFqpNxiafYACHcPSM4vIuqlhy4CX3twpkWYtxQuL4Mv
 CsYJ6AF6TCrqZEF0_8FqK8x8ulB_y0sYjzukp9Sacbvkop0WiubJlSBu6wE0T1g9O4UwIeixxHCX
 zMJSBawqIpDGKprpKoc2..VVw6Fihv.iZd3oQrXU7AT531.rS1NL9izZtf_xlj73Nzr3j8NimJp4
 t9TRDN5Anl26oeZr7QUCKtHoig7hkFop1xvWXr3PN4DlOUr3.2IgKInIqhKbgHNUlq2hvE.1Q_G_
 R5hbCdbGgMmy9mfK6kNBIKY.dO8_qiggkHmpfZJPi.bvfSq1sWeI4VjIuQeWqT9K90munk.W5K4A
 qGkoSB9IQRgWxTb3vuOAD.q9fXW4OPf45_C2_swJoo86Yrb9jmcbISS6RrEfVdLR04aygw0Lt.g2
 ePgmOOV94faFDEv1kewPFqzqR0B.qftwXPpUWKPBaEByAxylnwCDlzKDfgxauME6d1t0IA1e8KH8
 9lOe3BTO.vna.iWPBXsci4Drzp40roweu7roTlWHbE.jshM9hz3i4xuL7hxbyPN.yWCNNizK3E00
 5AmBoAMwDgPWxun3TLMmEjzZVdH6y4ZVSxkUr.O72pRBMFgDP2LEGnW5HaqSzr3AwoBf99yBzc.6
 iIPOtLBQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9e3c6041-f268-492c-9fad-0786b1fb7757
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 Jul 2026 23:01:18 +0000
Received: by hermes--production-gq1-7749664df-9tl79 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f195f9b565c01b03e935f9ceced077b6;
          Fri, 31 Jul 2026 23:01:16 +0000 (UTC)
Message-ID: <53a2d62c-fad0-438d-91de-a17b5921d61e@schaufler-ca.com>
Date: Fri, 31 Jul 2026 16:01:13 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
 <45d2738f-de04-43cb-b37f-4370e6232678@schaufler-ca.com>
 <DKD4DITNPLI4.3FIHRN0PC58RW@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <DKD4DITNPLI4.3FIHRN0PC58RW@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/31/2026 3:45 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 1, 2026 at 12:27 AM CEST, Casey Schaufler wrote:
>> On 7/31/2026 3:04 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>>>> On Fri, Jul 31, 2026 at 5:29 PM Kumar Kartikeya Dwivedi
>>>> <memxor@gmail.com> wrote:
>>>>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>>>>>> On Fri, Jul 31, 2026 at 4:16 PM Kumar Kartikeya Dwivedi
>>>>>> <memxor@gmail.com> wrote:
>>>>>>> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>>>>>>>> On Fri, Jul 31, 2026 at 3:20 PM Kumar Kartikeya Dwivedi
>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>>>>>>>>>> On Fri, Jul 31, 2026 at 2:50 PM Kumar Kartikeya Dwivedi
>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>>>>>>>>>>>> On Fri, Jul 31, 2026 at 2:18 PM Kumar Kartikeya Dwivedi
>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 12:32 PM Kumar Kartikeya Dwivedi
>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:44 AM Kumar Kartikeya Dwivedi
>>>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>>>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:17 AM Paul Moore <paul@paul-moore.com> wrote:
>>>> ...
>>>>
>>>>> I think you keep forgetting that you cannot unilaterally decide this. Both VFS
>>>>> and BPF people have told you that it does not make sense. What was clearly LSM
>>>>> specific code has been moved under security/ already.
>>>> I'm charged with doing the Right Thing for the LSM framework, and in
>>>> my opinion it is in the best interest of the LSM framework that the
>>>> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
>>>> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>>>>
>>> I think the "Right Thing" would be caring about your users and the project
>>> moving forward, who want this functionality, and figuring out the best way to
>>> make it happen while working collaboratively with others. Life is full of
>>> tradeoffs.
>> It certainly is. Paul has taken a stance that supports the ongoing maintenance
>> of the LSM subsystem. It does not have a stable API in support of the rapid
>> development of Linux kernel features *outside of* the LSM infrastructure. That is,
>> people like you. If LSM hook implementations were spread throughout the kernel
>> code it would be much more difficult for poor hobbyist LSM developers like me
>> to track them down when making changes. Changes like the ones you require.
> I would recommend reading the patches before commenting. All LSM code is under
> security/ (patch 2), as it should be.

Pa-lease. I have in fact read the patch. I disagree with you assessment.

>> This is about being able to continue supporting the latest and greatest additions
>> to the system. Like yours, io_uring and the network protocol d'jour.
>>
> I don't know what you're on about.
>
>> Please don't lecture us on collaboration and trade-offs. We live and breath that.
>>
> Paul is free to take a stance for LSM code, just like the BPF maintainers get to
> decide on where BPF related code should live. I'm sure you know that.
>
> Thus, please avoid justifying his overreach on where others maintainers should
> keep their code.

I have been developing kernel code since the 1970's (UNIX and Linux) and have
a fair bit of understanding about source code organization. Without rational
layering and co-location chaos ensues. The BPF developers are newbies relative
to the security maintainers, and would do well to pay some attention to the
wisdom of the aged.

