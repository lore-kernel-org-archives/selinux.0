Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7521C10F03
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385E20857
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ad7a096y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfCAQqQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:46:16 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:33638
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728489AbfCAQqP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551458774; bh=fsCFDC7oH/jolHZgyKXKJUsqBhFaOXISMQ0ecfsBrrQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ad7a096ywCM6e1l/BTlxRUfL4/Am4O2v4nk4Ceov2ATB9zQOKFgAvrw0Kdv60WQmgxK9xsZy9t0pP+NcfNq3WNHbb4W+89dWJ9VH/UYt4mahZWyyYEMqDO7w/mOe0V30iJngSTdYDDoF8k+/66fL21azfb8p3o28EHUkM0HMVdBMLUpi4jrEOSwvtCNArXYL49B03w89eahv0lEis76vsQBe9SEIGqZUrHortdZEqxu4UgTOcZ/w+U8Qs1jjsq7uKQx3hKtE//0069ccbkjb5oYK/mAELv1FX4IyylJZrPbinpl1zG9Yb/OomRv93qDC4IOzt1+bn+el5oTCxrsYKw==
X-YMail-OSG: ACjYE6wVM1k__hjYwnqD2R2jSAhIEl9FljzNvymSr60Vx1lRSsS.XmanpZ5.kFK
 r1K6vPRdziAxpmhCZCFBDP3Bh4fEasnVJIuhzR_atUMKqXE.yhzZ6_ZyWvrFtzjt8DVSqgo8ALx8
 bl59zbw1VIUyGMB.ncq0KdJ8O.A2NKSLZK2.OEbtEKwAKYRKNMcEr3Uk2EBb78d35i3PhajHZWgE
 P3Gv10Ubxw2Mq5X3L84zSyFrblsVZ5MG5r9e_1t1E7lskZJuB9_iYWwsJ5.gzYpr918UDmE2rVw9
 18q.kdt8ZpqVN56QBe_AAasGaFlvvitclQ54b4kbD7qpBK79VLY.GfPPE6JbW0wJ4K0l6t7Y8dMe
 cLjcXkf1brn5Xl8C6jawQe9G5HEDNkrJXMkACbkziVreHYaY5mxzeuQgTUFIct1EcqDdYowJQm.c
 5XFeo7EQtAcPvUnRX1dNabnpQiJp_qo54MCL2OiUR7unA_rdp_d6.ejFZCm3NsEWXH2Brv_8cqxd
 8pRrO2dhz9v1_2qUpV.gs3V_7KUhVSSFYK.OSlVRe0tkvdhklNLx_zqmW.aDfuxJOj8bRkP6u86j
 a5.HrGnQT73VfBXg8ZPRVEqda16RWNLlixtnjddf9jF3lE0AmnfB2_Bjzku7qQwHblZYo8aHxzjP
 Rto9AdeyvwCSc0Ju0Od13OrmSEAxxgPajz9byRVAEF_qsYZneotfso3q1pr.NxrMlzp0FM58wc9a
 KKB30PaPCmPRoxLMdBcGniA2C_2IsuqY8tTL4mewImsOjM.JVhDBU4qxMJX6H8JzvTOsYNnabUST
 jDRHkCUe3mH.tZmyVuDtyJ6m9cSfdzn4Vbt0Os4ZB_TavxjlIWKXDs4aaFYr_on7SJm1DphXwouo
 R6awYCQp1LeuN7DzNQCswg_a5hGx00vvCDfOWuM0w6H99sQMmDL8DPyNTtfIXhfjR5crsGjiSry6
 YI31xF8uN6LgjKrW0YV9OnBTfmkUIVBH4KCPbabKL.l62J7vvfljZqP7NvifYENif40E8qxbuMXf
 jkwumXv.EcubgnGERlS4ukoKlbnnQJ.ZMZWsggalaK43M16ds8Kn1HzAhytsu067hSdTuAs0HgQM
 jnifFowLAsh5YltZHX_lGAdEhKds6P_xd6jtP.A4oJa199HCt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Mar 2019 16:46:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e66031772aab68bdcfa692e1cdfabe4f;
          Fri, 01 Mar 2019 16:46:13 +0000 (UTC)
Subject: Re: [PATCH 05/97] LSM: Create an lsm_export data structure.
To:     Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
 <20190228221933.2551-6-casey@schaufler-ca.com>
 <7199670f-a38a-bf5e-4c3b-d340caa35071@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <321ff8f3-785e-280e-2675-ec298a520b0b@schaufler-ca.com>
Date:   Fri, 1 Mar 2019 08:46:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <7199670f-a38a-bf5e-4c3b-d340caa35071@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/1/2019 6:00 AM, Stephen Smalley wrote:
> On 2/28/19 5:18 PM, Casey Schaufler wrote:
>> When more than one security module is exporting data to
>> audit and networking sub-systems a single 32 bit integer
>> is no longer sufficient to represent the data. Add a
>> structure to be used instead.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   include/linux/security.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 13537a49ae97..a79fe8ef9d84 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -73,6 +73,18 @@ enum lsm_event {
>>       LSM_POLICY_CHANGE,
>>   };
>>   +/* Data exported by the security modules */
>> +struct lsm_export {
>> +    u32    selinux;
>> +    u32    smack;
>> +    u32    apparmor;
>> +    u32    flags;
>> +};
>> +#define LSM_EXPORT_NONE        0x00
>> +#define LSM_EXPORT_SELINUX    0x01
>> +#define LSM_EXPORT_SMACK    0x02
>> +#define LSM_EXPORT_APPARMOR    0x04
>
> Can this be generalized to avoid hardcoding the names of specific 
> security modules in the field and symbol names?  Possibly just an 
> array of secids with the indices dynamically assigned by the 
> infrastructure at registration time?

Yes, it can. I considered doing so very seriously. The reason
not to do it is data lifecycle management. In today's code secids
are often allocated on the stack and passed to code that holds the
value indefinitely. If every assignment became an allocate and copy
operation there would have to be reference counting and a lot more
intelligence.

The other advantage to the scheme used here is that an lsm_export
can include something other than a secid should a security module
so choose. It's not in this set, but I plan to change the Smack
entry from a u32 to a struct smack_known *, making several operations
much more efficient. Of course, that could be done using blob
management, but the complexity increases yet again.

> We don't really want to have to patch this structure every time 
> someone adds a new security module that needs audit and/or network 
> facilities, right?

It's not a design that is being proposed without consideration.
I seem to recall hearing the lifecycle arguments as a primary
rationale for secids more than once.

>
>> +
>>   /* These functions are in security/commoncap.c */
>>   extern int cap_capable(const struct cred *cred, struct 
>> user_namespace *ns,
>>                  int cap, unsigned int opts);
>>
>
