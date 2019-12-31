Return-Path: <SRS0=uw/3=2V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB0C2D0C2
	for <selinux@archiver.kernel.org>; Tue, 31 Dec 2019 17:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB17205ED
	for <selinux@archiver.kernel.org>; Tue, 31 Dec 2019 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q7ufa5De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLaRgc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:36:32 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:33870
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbfLaRgc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Dec 2019 12:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577813790; bh=497EbiHGNUUytTnTLQhGOIGfDs9EOUWtC0vsnXdLjjw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=q7ufa5Deyn20P+6KINpM5dYVz3wuh2EJNDVTTzyEsRyecO7c+H4Z0+Jiy/Vw6mnTIwikRZw/D56TzsWBWmMfXHDjev5mBwmitkwJTupax6tfsnf6NiGkk+t/taZ4kahqNr3ocsEub3VaBl2k4aor26qWA6HZNtUlAIqp86UUzAFm1oNol2yyMzKNR0yAu47LpYIt/8Esrfha/ONAC4CYTNRoY1T0B5kO4VzHlpYL6ULuF7Ij6TNGTOayX+8tu58yoBZ4cZRKQ4d9Y8wAjW4sqemB/+1Zd1xQ4FlbySiOghBeGGtQrzS2/IVCbQhGVHRAg9p5JJC6O6TP83UxrJU8sg==
X-YMail-OSG: YYTJqx4VM1mtc51m5v_hNIDPzV_e5C7pZBYitoMyT3oeHaI04GeMX028PlmsEe8
 stFN7kGn1s1GfhORKc5xGYQFHa5ZRO2jmUcp0Q4.nnqtxnqH4nIjqVS1gMm5S.4oYZl_BAqH2rgo
 _wOXC.AJ1qcM_JY00crgiNl3RrsX5EBaHopujEr3QKndiEndYR7ctZ98pU3kD6DooIFPqEEl3kc9
 JBwxcSYEjjExJ1Y9snQ6Mor9fgFGe_C4m2X_0Fmz9IPunf_PzkhjU8EO54FBXv4M4_0fZR6LGYFy
 EsrSRslKtqrv94epP8rUNrT31IHXslCqBI.XfPUf.04hyCeUK7GKnS.290prRTzjDiV8LMpH3qW0
 ACqfMrgNRMIy4OOoJ.mCVpekUStFVu_XHndcwQdSQPHWtA_A1SzrKKj9DlAHQFfPvFXUqKTTqVJ4
 5893dzUpPsZqUts9JRNzT8O8cY938ipF1UhITHp2VltBpolQEqkyZw4wvGrQFEi6OJgd9Z_sKBDO
 BrPALyiYha4o9PUqPWL2GzmI9Q8oSAfqtFjyszLfWVmszfZthNZjYtHeHUptqgsl8TlqZiHd1luE
 f2999vT2IYNBDaYLwQ.sEp7PJr.bbH6WRBs9cHxXL4rR8pMWiOUE1aqC.Um5RfNM0NhjxN5ac78v
 _VW8Jjzvoq4YDajmNSr5_7M4m0bFwGEBdhlJaO5WlVlspirYySqkHmgzx8_fdQScOmv1WtQCxsEh
 JNasakW2LdXVwASW5ETAS2K04be41kPUa2g7a3P6hWtZXQ6d27DSap6Vb3RmIDD33tOorwxsVV9H
 .mZMyPQdKLV6_coig1gZzSYt.YWB1QuRyiy.XeCn7WTMElrwvbM0EAn0rbLOpcPzSLxdJ7aQ5HJ7
 70NOxvjerfAP3dp_j.znAYqM76WED_vniZ0SivdEPuP_HEmiSvBVgFrQufg4rzAaAw5cau09XAPu
 KgtqF9hA8zsls7P32vIU5p0I31Dz3VkAZcN6oeOASsgGu74WbPBl2SDPxCe3635BkMXuRMX01w.4
 BO24fdBbzH1w6DM8DvWdgZjeu_gW76espZTl4c4uaYSHvUCK1Pm0Lhf.FRv3MvKi8wbwaDcJmXLR
 qtkHw2.GEvH.uZIMLHICpW8tG60SM2lZnQ6HKLiU9ciIC16k878yS6N0X6Ba6EiTbXyj1AMFiD6n
 31gGm7nplQ9vwq6xZnJqj26o5j6z3FgA4jgrHQAHzcB7AivMx3ljdBtiSECocoox0Tie7_4nFUI3
 .t84TqrcZdQrulplJl3IAvSjQvHvbmTFZPtlU0c9D1Ofh0NpTN_hkaLtAt4qVf4GblbyebrJ.5sV
 BYTqPPLxKIkXpORXsBFYIKtJl3XLejaEEWhYldo7vygFmhsMgU23iVk9Ool1v0.ROwjZJWJ5tXJC
 HM9Dbyx.2PFWNQ_LFp2YoCLIsmCVn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 31 Dec 2019 17:36:30 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 14fac84e7423617dce0c2ec3077326bd;
          Tue, 31 Dec 2019 17:36:27 +0000 (UTC)
Subject: Re: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
 <20191224231915.7208-4-casey@schaufler-ca.com>
 <1577812497.5874.97.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f0eae3ec-f13d-e660-8fb8-7a1e139f806b@schaufler-ca.com>
Date:   Tue, 31 Dec 2019 09:36:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1577812497.5874.97.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/31/2019 9:14 AM, Mimi Zohar wrote:
> [Cc'ing Matthew Garret based on the additional bprm call to
> process_measurement() - commit=C2=A0d906c10d8a31 ("IMA: Support using n=
ew
> creds in appraisal policy")]
>
> On Tue, 2019-12-24 at 15:18 -0800, Casey Schaufler wrote:
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/=
ima/ima_policy.c
>> index f19a895ad7cd..193ddd55420b 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry =
*rule, struct inode *inode,
>>  	for (i =3D 0; i < MAX_LSM_RULES; i++) {
>>  		int rc =3D 0;
>>  		u32 osid;
>> +		struct lsmblob blob;
>>
>>  		if (!rule->lsm[i].rule)
>>  			continue;
>> @@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry =
*rule, struct inode *inode,
>>  		case LSM_OBJ_ROLE:
>>  		case LSM_OBJ_TYPE:
>>  			security_inode_getsecid(inode, &osid);
>> -			rc =3D security_filter_rule_match(osid,
>> +			lsmblob_init(&blob, osid);
>> +			rc =3D security_filter_rule_match(&blob,
>>  							rule->lsm[i].type,
>>  							Audit_equal,
>>  							rule->lsm[i].rule);
>> @@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry =
*rule, struct inode *inode,
>>  		case LSM_SUBJ_USER:
>>  		case LSM_SUBJ_ROLE:
>>  		case LSM_SUBJ_TYPE:
>> -			rc =3D security_filter_rule_match(secid,
>> +			lsmblob_init(&blob, secid);
>> +			rc =3D security_filter_rule_match(&blob,
> On the bprm hook, IMA calls process_measurement() twice. =C2=A0The firs=
t
> time the secid is passed as an argument based on a call to
> security_task_getsecid(), while the second time it is based on
> security_cred_getsecid(). =C2=A0process_measurement() passes the correc=
t
> secid converted to a blob, but instead of using the passed variable,
> this code uses the locally defined blob field. =C2=A0A later patch remo=
ves
> the the lsmblob_init(), leaving the local blob uninitialized.
> =C2=A0Something is terribly wrong here.

I can see that there's significant work required on audit rule
filtering. security_audit_rule_init() isn't going to work correctly
the way it is.=20

I'll admit that the aliasing of audit_rule to filter_rule had me
very confused for some time.

>
> Mimi
>
>>  							rule->lsm[i].type,
>>  							Audit_equal,
>>  							rule->lsm[i].rule);
>
>

