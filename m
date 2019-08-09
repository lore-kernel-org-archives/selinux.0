Return-Path: <SRS0=nXDU=WF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC523C433FF
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E16208C3
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pTp4KlKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404864AbfHIAXa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:23:30 -0400
Received: from sonic307-14.consmr.mail.gq1.yahoo.com ([98.137.64.38]:43277
        "EHLO sonic307-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732796AbfHIAX3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 20:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565310208; bh=TxaIzTTOINzBfu/ZfDmenWprGsW3n5SWJYXFfMGXGL4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pTp4KlKtcJRKMsZkdNGDO8KD304DVe55upxvaKH2RYU1SGOYpgPe1+s4hfQ8NMKE8IPax32u/kUIjfFoc34Mz7+HV4Zy3B+jLBrhi/vs+IRX0UaIYBgAl3jDRIoY2fn/awbofE0cZZuZgZ1Mo5za+Ji7n7Zb79WfLUzMZwAx4ZgkoAMvhtS7P7yGw4+0RXVdymqXRW66GK7EEWP2OMsi1goNhnvCzFaG1b0ljmgbpmelNy9ld0DxMUvaFyt02n07AWRbm3/ITmx7k+XOKck7YIc2buvcOktnoDXkfWWhD8wZjXbemSsrnlPVe99KYXju6LNcJXIFMQIQKfojDXsq1Q==
X-YMail-OSG: kodAWQkVM1lPNwuRLgO4ezDJkfbSghWkS8OheOgFpsHqnuGQSAr0tlXPlDdtuve
 heXhT_yGKSBa9keH4bE0SukA34wAv9hBWJdyfWx9mJ7FAWHaK4TUlRMxU5lQSHAW1owbHwDYkP_n
 g9nYuxGYDyePb6QXROYtpSLdFGJDlpUfwAvgTtckiHoLQIwGrV99nhftX9QMwqiOl5HUCMSZ9M05
 4Q2tyxOn9B1VcfxXwt6SXOXL5biq2pY26yRQKlynWsU8Bu0hBAkG8EH5_GnmcGDY7yurMR6PrfTM
 B2ZDxIUo7vMdUk9dpSyqYQdcxOiEGgGUjDqdJ8rQk0gDgtYg.skevrwDywhLF78lLnHkEB59Vwgm
 J..a615xC0NBQshnLEr2j5EMT5J9AbGb3JMMHZGD07C7mzWuMOMxyZ4XmWZoCNbL4OSdimqtncD3
 GBUBD9ZF5MDC48dO6glT.jO7HZrI3Wukk0QW8zpbAK3bYmBTIdF0ySIY38eg6yswX6G4jJzAyT4P
 5eaMnzfPOaFxLO_ghINwdRrup5OtG1tGnW6g3AhXDzuJBJ.mGgV7.FLOnnXf_u4p1zB281RdpSWl
 7M2N3Q3mLGvuYACT4eivPhC_.CPz6EXi2QuSHp0pU8uEVjvnJXLfGXAg0nStEEc8AkuaP17gkDvY
 nEwBqUWouREsXQQiPeuyEcZJSICnpQ5..LPkAbxknyqjdUsYAJRAhUjUUKbXa9xZsmHaditB9knm
 C9dW63_pptDRhSTQauCEyCPK_WZAcTfNmXhInnt1s4M__bJ6VTkDqHAceVGTtTC5EJFsDd4PE2mj
 eMOgJemR8EJcTl1_TwRRfHGuf9ldS14brA_i8XcthfV2hk8WshpcQuAfNtkTeqMkLawGwZJa_nze
 8Ce0W3OysWjZmauQL690kTLVUctDxKb8bJD42SB6XZcdB8SWyt83joCxYSaqnx8w4BTJW41nCnR7
 wqJmd0zZmWM66qoW10JjvnmAVMZDGmk5JRkFY.XRLQnAqi4xL8kJs_gSOnTRGAuoGh5bAk5wnM9W
 xf_A.BJVsNXskUfEKzv1CJLn0DFJ1ZgWq6BucYNIZriLSn4Uk0KuA5TtYUVMoBkh7R6oV4crnrb5
 am.oXniF.nAT.mlz9nyBFTP6FDoorzxteX7ZZ8RcBgKdDmQCRB9IJOZxkZqQsK8lVax3WgwbaH0N
 8VUZY49AGGWarDF74YfAlCHGkP80s18tghrhfiZYXDbp60NJwmc4aB1tUM90CP6jmf9HSR141DDy
 fOngjIS5kmT9.EdmZG7HqRNXUQMrx7yxTchIvzL3PG7NXtOwBw9VILeDKdq478MzIM820
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Fri, 9 Aug 2019 00:23:28 +0000
Received: by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 71b6034a051e31f8e2e3e0de02712cf0;
          Fri, 09 Aug 2019 00:23:25 +0000 (UTC)
Subject: Re: [PATCH v7 27/28] LSM: Add /proc attr entry for full LSM context
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-28-casey@schaufler-ca.com>
 <201908081521.E0E7CC8F6@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <8783e3b5-0f44-61b6-5bfd-fe7b8ec524b6@schaufler-ca.com>
Date:   Thu, 8 Aug 2019 17:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908081521.E0E7CC8F6@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2019 3:22 PM, Kees Cook wrote:
> On Wed, Aug 07, 2019 at 12:44:09PM -0700, Casey Schaufler wrote:
>> Add an entry /proc/.../attr/context which displays the full
>> process security "context" in compound format:'
>> 	lsm1\0value\0lsm2\0value\0...
>> This entry is not writable.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  fs/proc/base.c      |  1 +
>>  security/security.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 7bf70e041315..79600df5f7a2 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>>  	ATTR(NULL, "keycreate",		0666),
>>  	ATTR(NULL, "sockcreate",	0666),
>>  	ATTR(NULL, "display",		0666),
>> +	ATTR(NULL, "context",		0666),
>>  #ifdef CONFIG_SECURITY_SMACK
>>  	DIR("smack",			0555,
>>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/security/security.c b/security/security.c
>> index 0ea7ee27e331..e9f579483d12 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2046,6 +2046,14 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>  				char **value)
>>  {
>>  	struct security_hook_list *hp;
>> +	char *final = NULL;
>> +	char *cp;
>> +	char *tp;
>> +	int rc = 0;
>> +	int finallen = 0;
>> +	int llen;
>> +	int clen;
>> +	int tlen;
>>  	int display = lsm_task_display(current);
>>  	int slot = 0;
>>  
>> @@ -2063,6 +2071,43 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>  		return -ENOMEM;
>>  	}
>>  
>> +	if (!strcmp(name, "context")) {
>> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>> +				     list) {
>> +			rc = hp->hook.getprocattr(p, "current", &cp);
>> +			if (rc == -EINVAL || rc == -ENOPROTOOPT)
>> +				continue;
>> +			if (rc < 0) {
>> +				kfree(final);
>> +				return rc;
>> +			}
>> +			llen = strlen(hp->lsmid->lsm) + 1;
>> +			clen = strlen(cp) + 1;
>> +			tlen = llen + clen;
>> +			if (final)
>> +				tlen += finallen;
>> +			tp = kzalloc(tlen, GFP_KERNEL);
>> +			if (tp == NULL) {
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
>> +			final = tp;
>> +			finallen = tlen;
>> +		}
>> +		if (final == NULL)
>> +			return -EINVAL;
>> +		*value = final;
>> +		return finallen;
>> +	}
> Instead of a copy-paste here, please add a helper for use in both
> places...

I added an append_ctx() helper in the "full" series. I can pull it
back to here.

>
>> +
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> -- 
>> 2.20.1
>>
