Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44114C433E6
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0753064E00
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBVXqG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:46:06 -0500
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:36253
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhBVXqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 18:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614037514; bh=Ww3Fqc8OXYtYnDQcF8XjW6EH6ovj294mxfpZJPsfi9k=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=spBK0cZHkJ1GDXDS0bEvR5XvYfyfmME529fEbUJxCR3ZAcpQystUMtoi5oGUizOqlrbnGlHypIaFyviMK6JmMxfISKhrEujeZeu6T0lHDn5X/H6YJvfk40jQvzuAuaaaMdmHf7YU7UI5Z2on8jJJadTNdIUMlXFauU0+v1nbSEbrkB9zDhrV7sGVSPGAnEELadHTF2XLfmdwQk3CPgpJ1Tx5EhY/qFE/dq8nUuiw2Oe+RWG9tROWzA5g5oWAWz5xV7hI74at03lCSMwq8+ZHVOyQJUb66uuIUd3NzmdpjPn+jSLPAMkyQ/cblVYk3w/NLQB0JpzFw2XtKHOTxK4hhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614037514; bh=1ALd+j//h2glHIA2k++dTxonXB3FzmuvQfr9r/P7KB7=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=kCQ3oy1Km8Q2DOQtfQkp+aF26CEqJdaD3QhupjgWFBiXruQklMbCV5NnG6yQRU3F8Rge3eXHYoTpSx5yO/PGWp4pDeJ9NNCEIBa4Ff/165JugQdDn9WsaJ0SHexNuK2iZ1SLbV312pz+/Wwfd9ysj310losmsVxmPMq43L996vHG9ev3e4XH2n0Qt+EVrkAgUgw3LD5AMHUbnzlNR6uxY+qRyZRf3q3DHJQjcnkH+4VllXp6yY6Kbvs81vB5cCkAkk+Rtb1Wp0NRWv6XhATG5wJTeNoPws4Ij/JE0U27jf5Cfr9cQFe2o4DLiD+QO8y9Qd1j9+p2xLpQobBSrdt9bg==
X-YMail-OSG: HxnT32wVM1nl8_mnp4GcH1QjD1QrNJHSbVs2i2E3LoOlTtwyvCzADpXhItvNmmW
 29gBraDTD76qHfuyL7EvaUB6h2MQG86kFdHSzPkw4cWbbObyngRdcfIwIysDZrnFLzdmxuLgAij0
 nxPX6drv_ZgwmZwUKbIVoJ52JOarzIDF9nwzzkVNXxUGEzwFLKxZyGOZQ1xgRdPASWDM5J_iP5Yo
 x4mfUqjQJr_pVxg26t08.jcUpw852OcM6sc_wozZiPhNb3Js3KG9MOOa0iL0X166YxNWzTLbu_pJ
 Zcix8gpWDu65FTQpO6KvSRtul1hIQ54wTyIef7rLx7rIl5B_2dQ1vUkgtYOnRr6uKx6wE7DSmTlH
 YS2KRzDp6qtddNVuMF_fgmK_vfDlMB9i5jMmLeSHquB8RUISjiUF_f7lPj7QzHc9or6sOCYVUbCD
 Rr.9gEOB1GpM1C813mgJUFvVbuQh7AgimfvpEYUjBhjlwKM9pmO2ynx2QoZCKIL4Py6U8RzW.jgz
 p.O7t_81tMDUyJehAgjx2vD1AXqmbKjwvfp2a2.rDXXN7kz.i3_L.rpqmEXHauKaknRNbksB7Txg
 hHJJK1U6JYpn904Ws09Ju6.vytB6BDqnbi_GtJchtSwQxnMkge4hb6J2l56lzl.QlHzCtEqLbxT5
 2_BmxKq5yGFF1tna2_R5creR7fya2bpFWlSABVfkfi0Ecec_pJRwms7hKLNqXz.epZF74iFcbYyO
 4V3wni_Io77RXOQ69neIs6sIU2FokCXpxYqala6uPkReKJC0hJqozODKJyQ6MzZoVv_7dbQJtbgJ
 PFPPvAQsYw.68jX5rPbhmbqHPK63sfzYMqCbDaQBgzi8xSBTK1.C40VEWcK.hqvq.uNUlP4hihtl
 gxMkG0Dj2PoFEPViUOxqi66d6aBCZ8D2qOWmlTunwXSKvtBD.18omuFDvn.oVETk3YgapM_KK_f7
 yWiHTlnOGKK0kYxLimIA47YiTkvOudNnH1TOvtDc6BacKK5rAIzymLwi_K8PFM2.hvqkPen0h9OH
 J2THTTYZPyGnn_ExDAKH5XAioPwqVy3iYz6GpiPH4AQUFLObYFsToype7JV4X9g8gwb7KsTJCs.B
 8QCo70yZ7ruXlDKwa5gzczelByVXIO00VJmdGqoVZfVDD2AzckATZ6dtFrIsiP9E2cj13xns0lme
 1kiGSvt6tnaUgn2dpTOVVMdph3F7heVf1QhsupcFVl3iM3c.R3_vXCOljQICddkmTF_e4KZQ1lsT
 H1Rxu8Q33h9OCnZCjhf1iV.KhoZhviyqO0SnjvHgxy4vt0gM8I44_5b5I5fpeqzRvHsnp.Jj6Hnr
 OREl9vLFNlQEeOWQ5eVltLQ2lgJdwMqFmfC.dSJzLb5wVX83HDbifx7Lu5fHkwYiaHB31GVXLN9L
 PtaxxVB8hLabIKJ__41.qGMgIPJFRkEG0rCVU24Hx9wyV3QTr1in5z0phaTjz1nVgPM6QHUEYQwY
 esbj6Wmga.McbXmwodHs_HEDFrN4iWLQfx3yHjXpkvfWR2AmfViOS7lbejB1GUWIv1SETuBrKNfG
 2PdhyLEKzhq5j0e1U3nZVwEHkknB7KrOcYiELJH10MdDGhOFovcnLfOLQBmVQITuR6MWpCsiIVcJ
 xnashFntkCWe8rDon6.tt_vGxi_Frtu0WTtLDcta2Hk9dgSuUqYGcxy.4B65S3lpYME6cF40c1tQ
 kglvIWQgSyt4QOD1FYW0GknirimjGnWZkuqNQb7KwyHg77rV4k.NMtOSXqHgoJ7JBgvY2agqbsUt
 bsncGE8q4TwVx12uNFslVTVqGF_WlbY9iD8V4t7xAlmglmOG.gznoRhttK4Y8RNNptR8YKJKJKUN
 EzfI9e26lV_0tyH3ie8ewtDu3VyV6mrmDFX1jsWXU2uATamcCAnacBNS4n3bDL9ZtWQIxdMWFqaS
 rgRd5fbwj1RENFhwmLqf._PTmXzb9CqGM8IeJ88xke.wkNkYNGZQmBgvj8r8CzDs82KiVxV9JbAU
 2UGcCnSb.yyM57TRDoxsPUe8ms.VoraUQzzMWDFQbPAsP7TnHy26ETVs06Rgv9WsXdexZ8uA3Cjn
 W9ht8uwpjAkV6wM.z0bgtqL6MYdNmVdTSaL0sNoOtctojpyCdQ6QCxXZR35nwwBHH7ynQ6wuis7H
 3ItzsvSwvij60v.SKMttx9v.0czzIzQLi5n91_Jd05dncWLcH1R4jmPBHmelg8GKAH4TmGTgzhZr
 I9bi5OPPUDKcZwCn3YookuUv0Tkrv63UIWHeHsZROTEvKuwTxQ_yN1gvz.P0vmhHHh2kwSMc9pTv
 dpTIgaBCEA6xQxXNY83XDa.Hlup0I11k3n_o6xPvi8tlQNKtNqt9zu1qu3rFBTCT8ZRTZ1ep33HU
 zBGMOhKjiGcbTAqM9rl1Iq1cktnWZFCAnCcK0oEOpfahP3xPUVYC7KDxo5AfCiUuE_lmr7B6WQXy
 XMHKzLBDLMX6FTvWzIUqyCkfipu4HHijlHj0I.hHqlJW5z97wbOHoIzhuwDxDpz3gQiBbJw6DrAS
 G21kULA0vSBien.HBREg_t5r.77xUfG1r5hRw7CKuk1xy2NvjC3VdnHB3u1me4qphI9WNSyv2Aru
 BAzqDLxoDRsmHspqO8fT7.vyIczhPTOupU1QTnLsjrR_hV1qo7KV0mH7w4D7qrgmlksHpKDcRv.r
 yoaNXajBIr6xhqhsC5.0kEyFpCbSQXEYjb7Llum7DmAb98fFP_6oyggD48nlnY71IU1du0C0H2K6
 N8SQEwG93pd9IeqPcSkyBamsMsbSzZvGJed_2sGqd8ZdHl7E5MYdLLHnyVs3DonI3kP9z2gQ7jIX
 _aD9KqBL0lOH7vmGjdLfsKZI8Y5HrAyA22JcSgaY4ixr68q6bAD9b1J3v6s6CbjySig7abOqsCax
 B.Dmr3WS7Iovy9SECjAoV7dmPktDQLPuGC9JF9f8rLUIGssqjUdi1B79HnBqL18VorJ7kz3Op3YL
 4j4R6hUFA98Vlht2viYe488RMnX.6gIy6BOCDZQ_3cCQoAQwozrOehBmJfNbABhMrcao17suZWLa
 iY5mfgCej3ABDAIecu1kyoRFw0nABO_1zxqsjjDx9gyRfLPFW8HGbaJpJrPzgHuJ.p8r6q5_4XPD
 g_A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Feb 2021 23:45:14 +0000
Received: by smtp413.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1544386b3b2542b82d02a3a1d16f95ff;
          Mon, 22 Feb 2021 23:45:10 +0000 (UTC)
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
Message-ID: <77ebed19-2912-d8f2-cb4d-3f782c8e7f18@schaufler-ca.com>
Date:   Mon, 22 Feb 2021 15:45:09 -0800
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
>
> thanks,
>
> Mimi

Would these changes match your suggestion?

 security/integrity/ima/ima_policy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9ac673472781..e80956548243 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -78,11 +78,11 @@ struct ima_rule_entry {
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
+	int which_lsm; /* which of the rules to use */
 	struct {
 		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
-		int which_lsm; /* which of the rules to use */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
@@ -98,7 +98,7 @@ struct ima_rule_entry {
  */
 static inline bool ima_lsm_isset(struct ima_rule_entry *entry, int lsm_rule)
 {
-	if (entry->lsm[lsm_rule].rules[entry->lsm[lsm_rule].which_lsm])
+	if (entry->lsm[lsm_rule].rules[entry->which_lsm])
 		return true;
 	return false;
 }
@@ -272,19 +272,19 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
-static int ima_rule_lsm __ro_after_init;
+static int ima_rules_lsm __ro_after_init;
 
-static int __init ima_rule_lsm_init(char *str)
+static int __init ima_rules_lsm_init(char *str)
 {
-	ima_rule_lsm = lsm_name_to_slot(str);
-	if (ima_rule_lsm < 0) {
-		ima_rule_lsm = 0;
+	ima_rules_lsm = lsm_name_to_slot(str);
+	if (ima_rules_lsm < 0) {
+		ima_rules_lsm = 0;
 		pr_err("rule lsm \"%s\" not registered", str);
 	}
 
 	return 1;
 }
-__setup("ima_rule_lsm=", ima_rule_lsm_init);
+__setup("ima_rules_lsm=", ima_rules_lsm_init);
 
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
@@ -1515,7 +1515,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				result = -EINVAL;
 				break;
 			}
-			entry->lsm->which_lsm = result;
+			entry->which_lsm = result;
 			result = 0;
 			break;
 		case Opt_err:
@@ -1573,7 +1573,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	INIT_LIST_HEAD(&entry->list);
 
 	for (i = 0; i < MAX_LSM_RULES; i++)
-		entry->lsm[i].which_lsm = ima_rule_lsm;
+		entry->which_lsm = ima_rules_lsm;
 
 	result = ima_parse_rule(p, entry);
 	if (result) {
@@ -1827,9 +1827,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
-	if (entry->lsm->which_lsm >= 0)
+	if (entry->which_lsm >= 0)
 		seq_printf(m, pt(Opt_lsm),
-			   lsm_slot_to_name(entry->lsm->which_lsm));
+			   lsm_slot_to_name(entry->which_lsm));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;


