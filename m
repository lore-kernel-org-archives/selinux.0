Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFFEC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D696464DF0
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 15:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhBPP1W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:27:22 -0500
Received: from sonic306-20.consmr.mail.gq1.yahoo.com ([98.137.68.83]:42311
        "EHLO sonic306-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhBPP1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 10:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613489194; bh=W62lh1FNDIGTqfOoKPg3fLtILjHzYCf5zKTQ678bnVY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=fjtq68O77kXy8UhkgCGmsyJa86KoTpMtIwC8UNjXRksYuLn3kOd7K3uDf9Vs9HnaCBqJMBrgBYuJWILC1JFavg4KcfeGBLL/2cOa4c4kMyqhzA6XiLVyme91sckGaZ/vwexoQRcSVW94A30Glj9xcVYHKBnyVNFa4LPXjQyJ8WDNqRXRt5ad2uR6KZ0FmNATXpMekGjRRy61v7lV5Rn29SPNJPDODCO34pGATTLiSAw+w4EraxMn+Pd3vJazhdFLzXSGdPyf9IHT+XH2roCgAD1vxVxms1kkhOa/f21KTKbDKsh7VRpvHiDs35mbepw0Sbc/VaQcf/iiei003fl3Dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613489194; bh=9fcmK848gRdrSo0CtJht6cTIcysIkqcULNO5DR2Srji=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=iq6QL1VhbMcbHuv7hOznssEjlxRjHypKpdp1QnWRE5HkDQjzzk3y/OKqOFPHqjk+0vUlgPjYDre7rGFnbzh1bm8p3nj2ovVlDV6SjA/LvohzWmZ+MB1tyjyZbwkyQ7qN+ZGrjdw7gteuXuH25HqnrE2yiLXNQSyMxsO1/h5GcbJORpfIf13yOXRfopLSLZ1K8Dq5klzOTvCOMUqYP+OtYpIYRqMNPkPFkUhCsWg0hUpenLvIsa5QhC+H2tCBN2BqixzgmtcmkrZwcA/8XkCoAPhLY3ew9d46txUaspQQlQtOoA5tQcnTahayLlp/6HW5mD6nvjRnAR32t0Y16tKunw==
X-YMail-OSG: ZCNfqqkVM1lPukTTjpbByVKoh.k1QKLvNZ_EkZj_CZLTg6jrLyhwrQ5H28S1jaG
 9Cc6vNBVR6.NqaHrPlk2FmSJ.vhVXuUy3RrubPqgnjuu56iVJVxcOtd1x58ozmafrwXe4fgp8I7L
 AXOmVdF6.kSvMZZA5PJ60rOofNLHcTTsdb1HkqBX_aAY7zorwFTPfBRvOHFrmwtVTjT2L4Dz2tZT
 GAYKatqzXC_0SE0p90C_5MmYKMPD9sVrZs.b5tmyhRH6OJp4k9Xnk2cCzOfrTdF5J0qipqsyW46C
 WmYotAiIo2YAomr9JonfMmKyvNKfZsocbw94J8FuIo3A2QJpHrHhsPgzTpeplJoEuaTJKmt3_z5B
 7WDRvNLE0SmkgKar7RV.VArTmgOa.L81IobGhUFjKch4wJ9cRagNEscLi00MMRDSbWUN6L3WJ_rF
 vb4zc4dPL95Qkr7pFc7U5X8pxwesC4wEOz._EcuALUkZOCObdrnhNFTb4XOU.ddrDdO_aCPmO98m
 RGp40tcpnUR7vjLNNReBNTFk9TetrfnE4N4IVV8rKWP5JskDJvjy3jHyYoyvLJo1_lABbuwyn1m5
 G42Ck.2JV0uWCqhMMVPSUs0IRnOPjCiDkLtg0gln5ksRmoXhPw_iCboGAczGznuLtpKuvKSEoePQ
 Lem8oRq7F.vEa7WCKy3DCvb8hVB5sQvlMwdRS_dJTJZJRakWiuWPuKTL8gLfhkv0e9PZbcP7qAxi
 IJ9P06KzWYFIfmnbFxKdq9X0yR113B9_Tu4w..g4_sib8__mG1dvJESsUy885zk__lTxwnbQHyhn
 hRYOOIsesf1LQSa27qVespp_jJLSNrm7T59SyNRJR_X0XyAIMkXCkQ.tAO_ZKNWtcpO_qNXDLenG
 m.S7EfDWpiKPYn4FvbMbJd7n6m5BCl1WJ6V9tkLUfhJAzh9DFww0suBZLb2YOsUg_GEg4qGoAXO7
 T6xqNhPLlByBP7wkXYITQDhBUFT9iIkjfuQWFiHhhzjxdTozdzDV80LNvnUS0DUOkvCiQtnVp1E1
 YcfKweea2u7QRMX5j4pPPJvZyjWAlWnIo2SBLbfYhXeFDStRBULRPh9euMeeEI4tYU0exBRIFBvL
 kTpa640qMN0kelXw8QQc_gsFXReA6M2vB1GSTzeIgUKEkIFZC4_6mwDzLmfzrERy3xJCt07JEyYi
 Mvo9I.H9LqTOl7fq8oF_Jz3ShnuS6tk17z8lC1eew7Pk34VFnCmx.yXlYztBZ8AA0R_CRazLzWmf
 GuKu8SMS8buQSLahGwBV2g4yE4Ph91K9W73mDArS6e1iq4_mTDbaIOf2GS2sdKe70Gq1XVqtpPdK
 nMsiEb2GBvaJZ8FHnXDov1CivtG2.hzOU4FBFYMTH2dTyX5ZuEp0eb.KesjJXpeVEmSG1PrM8Dfi
 RkcSiLGs6fE3bt_rH3lxk5FLEo.LqMXwRHDNu2avxBZEEANu3.jPRNiZ9Ax_xem7abO6reABSTtJ
 ix9stwIXGmG6zkjb.s0kC_hOl7QtXJxuGleP9b.lsU9H24P1Mbt.B1G10ptd1dAI2jf4qN4oCLJT
 7udYOzZt3DtSJj3CuHJtTvfZJnbIrEXl96imL.hNMINDzXDbGhHZ7oYoPuQy1YvJIwdN9_aA66tC
 5c01UfNjoTbDjsGHkwLPLW4rUQfgTnoq5ZyZLn0kD71c.qCWiLI3LKr7NY_mgRlNJ3ex87ee0lyH
 FdOtTZzjvI3UKxadCCl3gjfUtJuOctDv7qjuIytK9oe_wki_n7BFhQHLmtrN1wSq1z8y0pehYR4W
 OI_OjvELZp0t_UicTWfio8KbKwph0vwhGaZ0XHa2UTcgXAOGECdv.EBQGYP_R27ykYjd4PRhjrSu
 rTHJhsy3SrpOjwcqMjoaYeoppdUpNfhUGZ8bUktEHs12xGh9rQTjWC4xdV38tv_koS2gStuSHvNZ
 tz.mjdkgFvmxB9p7Yd8xwFK7M9U.9mUXpi0MIzmsrCBKjo6kwydkDY4BU.AOZ4gYk0d8TNygZVXn
 r9L0227Rl3rLf_MPV.OnYjGhewMi0lZ_X3V9wDEaughsolORV.ZVqhRN4a5NB_L0BEK6c4kC34dM
 uk0e55oBODY7.IRv0hxZbE.HGFfu4GmRE1fOCFYHTxbZybF.YEMiZaV6M2WZogBwicbt2FONBWbe
 nVxhtqo_W0rxCzcyWRIoqSbVvcY8vL0Za2D.8VHZG6qzeuO01ckSy.xklseQ1Bg.Aw_00xf5o2jc
 _bZma2dh4CuF7IeoGOg.ZWQCHG6cmd96EN6MWOgZuA6Ep1yzRrgD5MpvKdzr_rvE9VqDwFhceQVV
 88qTE.5.G7N4Ji6HO8UVQb2mJDo7TsJkrhwTC6cL8T0TvCYyBBynHj3IZdmvuyA5I2rIS_0Jkddz
 xdOierW.NOEBTdfK7TbOBb7bf75oPfZjlMdJGq37I3UNqNkS.k7K.UMsulnRr0n39L8paWc9OCE8
 WoyST.5BnoliiOOkjoH5RtjvTvGVNlzqDzK2I1j2qfneScRsJXGSOJxNnoaCo5GpqX2wfjDMjffp
 CqGDOi7oynTK3uKtYddTKGEunmk29NvbkKKeyyphWyD4cimhHF8__PbslIF4N4bLobM_GlRPjso3
 2ZNu8IKbovSVeNybbGCj6CITQIU5ZyPKBjx.obUMR8IIXf.p0UZuhBp_2Tlk0f3eMpbml.kCai_L
 3XGj.6mGxg2LQN8MaSrg6jdRC1t75WplTGG91SisB1lneQq6sce5mDbkBfpmxNe3f56NtdRvv.sm
 _EqV3CK9ASwgn.UYa4ECDDnL1lEvovv1GFlscsIhB9Xuul2xd1e9s2TcsMr0povCi5U0mw.xWgsD
 Ba7PyuUYeQ.hfIu.e6pqdCcylORE266SMiih8MIvQxMMt8J1BH0gzTruPuaxZz4s4NJ0D0f8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Feb 2021 15:26:34 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6f5b7ba32cd2d33c874cd26015b33c2b;
          Tue, 16 Feb 2021 15:26:31 +0000 (UTC)
Subject: Re: [PATCH v24 04/25] IMA: avoid label collisions with stacked LSMs
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
 <20210126164108.1958-5-casey@schaufler-ca.com>
 <693f81d9d2f50a920cafbbc8d1d634598b99081a.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae6dcadf-57d5-cb29-a361-d020f6333f59@schaufler-ca.com>
Date:   Tue, 16 Feb 2021 07:26:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <693f81d9d2f50a920cafbbc8d1d634598b99081a.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/2021 10:21 AM, Mimi Zohar wrote:
> Hi Casey,
>
> On Tue, 2021-01-26 at 08:40 -0800, Casey Schaufler wrote:
>> Integrity measurement may filter on security module information
>> and needs to be clear in the case of multiple active security
>> modules which applies. Provide a boot option ima_rules_lsm= to
>> allow the user to specify an active securty module to apply
>> filters to. If not specified, use the first registered module
>> that supports the audit_rule_match() LSM hook. Allow the user
>> to specify in the IMA policy an lsm= option to specify the
>> security module to use for a particular rule.
> Thanks, Casey.
>
> (This patch description line length seems short.)
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> To: linux-integrity@vger.kernel.org
>> ---
>>  Documentation/ABI/testing/ima_policy |  8 +++-
>>  security/integrity/ima/ima_policy.c  | 64 ++++++++++++++++++++++------
>>  2 files changed, 57 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>> index e35263f97fc1..a7943d40466f 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -25,7 +25,7 @@ Description:
>>  			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
>>  				[euid=] [fowner=] [fsname=]]
>>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>> -				 [obj_user=] [obj_role=] [obj_type=]]
>> +				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
> "[lsm=]" either requires all LSM rules types (e.g. {subj/obj}_user,
> role, type) to be exactly the same for multiple LSMs or all of the LSM
> rule types are applicable to only a single LSM.  Supporting multiple
> LSMs with exactly the same LSM labels doesn't seem worth the effort.  
> Keep it simple - a single rule, containing any LSM rule types, is
> applicable to a single LSM.

Thank you. I will add this.

>
>>  			option:	[[appraise_type=]] [template=] [permit_directio]
>>  				[appraise_flag=] [keyrings=]
>>  		  base:
>> @@ -114,6 +114,12 @@ Description:
>>
>>  			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
>>
>> +		It is possible to explicitly specify which security
>> +		module a rule applies to using lsm=.  If the security
>> +		modules specified is not active on the system the rule
>> +		will be rejected.  If lsm= is not specified the first
>> +		security module registered on the system will be assumed.
>> +
>>  		Example of measure rules using alternate PCRs::
>>
>>  			measure func=KEXEC_KERNEL_CHECK pcr=4
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 8002683003e6..de72b719c90c 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -82,6 +82,7 @@ struct ima_rule_entry {
>>  		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
>>  		char *args_p;	/* audit value */
>>  		int type;	/* audit type */
>> +		int which_lsm; /* which of the rules to use */
>>  	} lsm[MAX_LSM_RULES];
> Even if we wanted to support multiple LSMs within the same rule having
> both "rules[LSMBLOB_ENTRIES]" and "which_lsm" shouldn't be necessary.  
> The LSMBLOB_ENTRIES should already identify the LSM.
>
> To support a single LSM per policy rule, "which_lsm" should be defined
> outside of lsm[MAX_LSM_RULES].  This will simplify the rest of the code
> (e.g. matching/freeing rules).
>
> 	int which_lsm;          /* which of the rules to use */
> 	struct {
>                 void *rule;        /* LSM file metadata specific */
>                 char *args_p;   /* audit value */
>                 int type;       /* audit type */
>         } lsm[MAX_LSM_RULES];

You're right, that is better. I'll incorporate the change.

>
>
>>  	char *fsname;
>>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>> @@ -90,17 +91,15 @@ struct ima_rule_entry {
>>
>>  /**
>>   * ima_lsm_isset - Is a rule set for any of the active security modules
>> - * @rules: The set of IMA rules to check
>> + * @entry: the rule entry to examine
>> + * @lsm_rule: the specific rule type in question
>>   *
>> - * If a rule is set for any LSM return true, otherwise return false.
>> + * If a rule is set return true, otherwise return false.
>>   */
>> -static inline bool ima_lsm_isset(void *rules[])
>> +static inline bool ima_lsm_isset(struct ima_rule_entry *entry, int lsm_rule)
>>  {
>> -	int i;
>> -
>> -	for (i = 0; i < LSMBLOB_ENTRIES; i++)
>> -		if (rules[i])
>> -			return true;
>> +	if (entry->lsm[lsm_rule].rules[entry->lsm[lsm_rule].which_lsm])
>> +		return true;
> If each IMA policy rule is limited to a specific LSM, then the test
> would be "entry->which_lsm".

Which would be an improvement.

>
>>  	return false;
>>  }
>>
>> @@ -273,6 +272,20 @@ static int __init default_appraise_policy_setup(char *str)
>>  }
>>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
>>
>> +static int ima_rule_lsm __ro_after_init;
>> +
>> +static int __init ima_rule_lsm_init(char *str)
>> +{
>> +	ima_rule_lsm = lsm_name_to_slot(str);
>> +	if (ima_rule_lsm < 0) {
>> +		ima_rule_lsm = 0;
>> +		pr_err("rule lsm \"%s\" not registered", str);
>> +	}
>> +
>> +	return 1;
>> +}
>> +__setup("ima_rule_lsm=", ima_rule_lsm_init);
> The patch description refers to "ima_rules_lsm=".  Please update one or
> the other.

ima_rules_lsm seem to be more accurate. I'll fix it.

>
> thanks,
>
> Mimi

Thanks for the review and recommendations.

