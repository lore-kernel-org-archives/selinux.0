Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97442C76186
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 19:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92420C01
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BEpl3zKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfG2TWn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:22:43 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:35045
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbfG2TWm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 15:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564428160; bh=kB85wvxn3U6v/IdlRhzaEgUy9PpjjD12bXFOs2s0i5E=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BEpl3zKc/pKa7wmrXFTt3Pa7VHnd3YKys1EzuZPOk2oeHMMcdXS4Yl4sDQFvfA9jJJnZXFAB4blqhJf2Fpuumk53oVIuzNeOZqvdxLa4KuwNnhlkTHyzvIIJzdT/zcAEFB5MBSmpFO9cq/W52/YvpFt2b092Q7eWIaH+CDv9VaCrqHUCmX6VfzChClGa1PrpbA9xf/kFDBNyxZgWakDATxscReuuc5y6fXDy5QfVjw9xe6FHCQOrbdpR2191BFO/2rpm493nFLVAn2N/ccYJfCCg+rzEGnJKCH/9BUAjMghxdOfnIzljUCkGOdhIeMJ9GWflozcPqmdLONDTvkaPxA==
X-YMail-OSG: FJRw1b4VM1k8eAtIjzc0PUHoPgKbp2dxoAZzois_JB2OWOborDqbRGaU9CDgwuT
 XWZtWnhiYWE.OaeSF31cUWOVfQoZgu83WDY1pc4Ej.iYEuWyycsGvGlHQnE2PZG_QRZRaH5zk7U6
 nNdxrc0L4z69ZUfc6C.lZw4p1MVL7j3uY0rc0hZfaqqxiteVFN55cVoXOAGWVz6Eu2TAwkybEp7f
 KoFiuDq_EF.ts3RNoQmgJsLQx5lAQ6mmnXeVyOIKIw0p7tIfs0MTev4YR5hOEvBiKOCKqscUFHfE
 Y7APrmK6NAkUFmkwBFbGlk3Yo_gV0XrccsVX28Jxj7_UqIrfpV.S3wBM7pTPVBPYAPapDr5_lh2f
 s2sA9PzIomZO5lYAh7ooqurLNkwtWyleC6v.55s7NXxwdNsA8kaLw7wU0aj682AifPF7fYZpgUPt
 9C3Wk5oQvJawltnEmB1EE_v71WggUJ_xLvWrSvy8WVvoLY_xq0Ll6vHUkY1EX14_YegFD2ULsMu7
 arsmKDmQBZRWrY.EUQkliZsTEFjPyThZB0DrzGNMIyUE1h1FkztDcCyLhq0hGIWoNFCdy2bCDD2W
 eozFJExd3Hk4GHw_BaUUAsd.PTIBh3INoJUybQ.PVbU8L9M2za_q.OTvvQPjPNflA2YqNDsLzl2J
 K.8opZaENVtFoP5.EU76atVPlvngaS_jqUd_1nUq_nqSPwEWKC.xteuYo8INbtmB4HznlSdOvxjh
 764PKpCDQhC18Mh9d1.ZwwPgO9T4OZl6mIZHbIo2FdBtY7TZ98wnb2ZzTD.RfZ9yI9.caJCfv2Rl
 .6XLXLRUjMpiPtShXVUNnWXTQMo07avzg64yPF6b0RCJfReT0jUGXFhQnd1U3VT2OKdrmnVE0UNx
 MkBQjediqWrb.lL8.YjKPbc6yfOhcRVV5q2JSlusTSlQnVdQqjhDWbcOBOr11ruAJgfpsKBcVrty
 2bwt9gboCGXtt7SilOZn_tKaSc1p0wUXk47_E.16Pyge61lHGVd6txP6jtZMFMyVQF1tallw0pZh
 65Uimh2VzMei8irYh8A9KqQbeR6lPTnE1swSvJVhDyANP4RWr4lZwqMKTKrWurwoiyDWGyGyYJcn
 r1NH8XZvHo3ViCuNu_J6hdBwrehp95SDedzSQ.QBa85XZUawezMewu6mfzPhOczGaCJmirMJnqig
 H6Dj9_ZviKnUnqpf.l_8ZesdREAFagcCH1DryPlB5kR2YLaIUHshQFUHjR3dI8hVU1bBTuKP6Iue
 vHTpL9erp1t8u0AiHVP.S6oOmI0vj1Ivt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jul 2019 19:22:40 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a76210e6dcaf8721bf07996970245aa5;
          Mon, 29 Jul 2019 19:22:37 +0000 (UTC)
Subject: Re: [PATCH 26/27] LSM: Add /proc attr entry for full LSM context
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-27-casey@schaufler-ca.com>
 <201907291018.CD249AD02@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ea34ed4b-1f34-d896-7c1b-a7a5a304594c@schaufler-ca.com>
Date:   Mon, 29 Jul 2019 12:22:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907291018.CD249AD02@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/29/2019 10:19 AM, Kees Cook wrote:
> On Fri, Jul 26, 2019 at 04:39:22PM -0700, Casey Schaufler wrote:
>> Add an entry /proc/.../attr/context which displays the full
>> process security "context" in compound format:'
>> 	lsm1\0value\0lsm2\0value\0...
>> This entry is not writable.
> As this is a new API, would it make sense to make this a bit more
> human readable (i.e. newlines not %NUL)?

With the far reaching discussion about what format would be
acceptable in mind I went with Simon McVittie's suggestion.
Also note that AppArmor includes newline in attr/current,
and this way we can preserve the existing value.
It's compatible with /proc/.../cmdline and easily keesized:

	cat /proc/self/attr/context | tr '\0' '\n'

>  (And if not, please justify the
> reasoning in the commit log).

Good idea.

>
> -Kees
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  fs/proc/base.c      |  1 +
>>  security/security.c | 45 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 7bf70e041315..79600df5f7a2 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] =3D=
 {
>>  	ATTR(NULL, "keycreate",		0666),
>>  	ATTR(NULL, "sockcreate",	0666),
>>  	ATTR(NULL, "display",		0666),
>> +	ATTR(NULL, "context",		0666),
>>  #ifdef CONFIG_SECURITY_SMACK
>>  	DIR("smack",			0555,
>>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/security/security.c b/security/security.c
>> index 5551c146c035..6a89a6b90cce 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2057,6 +2057,14 @@ int security_getprocattr(struct task_struct *p,=
 const char *lsm, char *name,
>>  				char **value)
>>  {
>>  	struct security_hook_list *hp;
>> +	char *final =3D NULL;
>> +	char *cp;
>> +	char *tp;
>> +	int rc =3D 0;
>> +	int finallen =3D 0;
>> +	int llen;
>> +	int clen;
>> +	int tlen;
>>  	int display =3D lsm_task_display(current);
>>  	int slot =3D 0;
>> =20
>> @@ -2074,6 +2082,43 @@ int security_getprocattr(struct task_struct *p,=
 const char *lsm, char *name,
>>  		return -ENOMEM;
>>  	}
>> =20
>> +	if (!strcmp(name, "context")) {
>> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>> +				     list) {
>> +			rc =3D hp->hook.getprocattr(p, "current", &cp);
>> +			if (rc =3D=3D -EINVAL || rc =3D=3D -ENOPROTOOPT)
>> +				continue;
>> +			if (rc < 0) {
>> +				kfree(final);
>> +				return rc;
>> +			}
>> +			llen =3D strlen(hp->lsmid->lsm) + 1;
>> +			clen =3D strlen(cp) + 1;
>> +			tlen =3D llen + clen;
>> +			if (final)
>> +				tlen +=3D finallen;
>> +			tp =3D kzalloc(tlen, GFP_KERNEL);
>> +			if (tp =3D=3D NULL) {
>> +				kfree(cp);
>> +				kfree(final);
>> +				return -ENOMEM;
>> +			}
>> +			if (final)
>> +				memcpy(tp, final, finallen);
>> +			memcpy(tp + finallen, hp->lsmid->lsm, llen);
>> +			memcpy(tp + finallen + llen, cp, clen);
>> +			kfree(cp);
>> +			if (final)
>> +				kfree(final);
>> +			final =3D tp;
>> +			finallen =3D tlen;
>> +		}
>> +		if (final =3D=3D NULL)
>> +			return -EINVAL;
>> +		*value =3D final;
>> +		return finallen;
>> +	}
>> +
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> --=20
>> 2.20.1
>>

