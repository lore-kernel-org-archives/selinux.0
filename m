Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9AC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999F864EC4
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhBISrK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Feb 2021 13:47:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58564 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhBIS25 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Feb 2021 13:28:57 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0BF6520B6C40;
        Tue,  9 Feb 2021 10:26:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BF6520B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612895174;
        bh=dq6UOkKS3Xk68snOo38h4f+NxwXUE5NpF4jNJTq2thM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S9Kbsglb1v8e5ScsIUvmPLI/N4ikPFKsxwn+79ze1n8CaI9gzhaNSC+vBGmkocKvl
         hKkILnngm7VsuzGwaNTGTsNbSzQfMmX8NaT2E2nZzYevjjhDm9W+NFYzWjXV3M5pEv
         olZsV7ESuwzfiH9np1Oh5RQ5uO76EJBqiCQS45Qg=
Subject: Re: [PATCH 1/3] IMA: add policy condition to measure duplicate
 critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
 <20210130004519.25106-2-tusharsu@linux.microsoft.com>
 <059e77ffa861680ccac7fd94251fedc7cffe7a7e.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <0643d35b-b765-0c9f-ffc5-99fb8cd22eb4@linux.microsoft.com>
Date:   Tue, 9 Feb 2021 10:26:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <059e77ffa861680ccac7fd94251fedc7cffe7a7e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2021-02-08 12:45 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
>> IMA needs to support duplicate measurements of integrity
>> critical data to accurately determine the current state of that data
>> on the system.  Further, since measurement of duplicate data is not
>> required for all the use cases, it needs to be policy driven.
>>
>> Define "allow_dup", a new IMA policy condition, for the IMA func
>> CRITICAL_DATA to allow duplicate buffer measurement of integrity
>> critical data.
>>
>> Limit the ability to measure duplicate buffer data when action is
>> "measure" and func is CRITICAL_DATA.
> 
> Why?!
> 
I wasn't sure if it would break any use-case by supporting this for all 
the files / buffers.  That's why I only wanted to address the scenario 
that we discussed in the last series (critical data measurement).
But as you suggested in this series' cover letter response, I am happy 
to extend it to other scenarios (by disabling "htable" using new Kconfig 
(e.g. CONFIG_IMA_DISABLE_HTABLE)
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 9b45d064a87d..b89eb768dd05 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -35,6 +35,7 @@
>>   #define IMA_FSNAME	0x0200
>>   #define IMA_KEYRINGS	0x0400
>>   #define IMA_LABEL	0x0800
>> +#define IMA_ALLOW_DUP	0x1000
>>   
>>   #define UNKNOWN		0
>>   #define MEASURE		0x0001	/* same as IMA_MEASURE */
>> @@ -87,6 +88,7 @@ struct ima_rule_entry {
>>   	char *fsname;
>>   	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>>   	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
> 
> Defining a new boolean entry shouldn't be necessary.    The other
> boolean values are just stored in "flags".
> 
Thanks.  Will do the same here.
Thanks,
Tushar
>>   	struct ima_template_desc *template;
>>   };
> 
> thanks,
> 
> Mimi
> 
