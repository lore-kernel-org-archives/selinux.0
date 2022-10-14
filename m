Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA8C4332F
	for <selinux@archiver.kernel.org>; Fri, 14 Oct 2022 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJNOZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Oct 2022 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJNOZn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Oct 2022 10:25:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7C811A965
        for <selinux@vger.kernel.org>; Fri, 14 Oct 2022 07:25:41 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0500820FB19D;
        Fri, 14 Oct 2022 07:25:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0500820FB19D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665757541;
        bh=eewV3x8VaSWky63pWNHRzmed6MxGxJGQXqrRTtq0+9o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=BugQqiZ69T7QkBPI7SqdThE6CEMfowG7dqT5a38WFYdEsG0YzrKvJnJeut8k9sXu8
         sPD/Pql/Ftf/boiWXHB/pn3DR/l6L+QnKBQhvVd+vfA28FWzjp0TPRzUYa4XI2TCf/
         TjLpsuvv2aRns0H0PzSitbKZUTVkVoLidrLBov/M=
Message-ID: <3e5a0cb1-73e5-6268-2c0b-4f470080073e@linux.microsoft.com>
Date:   Fri, 14 Oct 2022 10:25:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20221011112733.194079-1-plautrba@redhat.com>
 <877d12sn5v.fsf@redhat.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <877d12sn5v.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/14/2022 6:41 AM, Petr Lautrbach wrote:
> Petr Lautrbach <plautrba@redhat.com> writes:
> 
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libselinux/src/avc.c          | 2 +-
>>   libselinux/src/avc_internal.c | 4 ++--
>>   libselinux/src/checkAccess.c  | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
>> index 8d5983a2fe0c..98a3fcae41c8 100644
>> --- a/libselinux/src/avc.c
>> +++ b/libselinux/src/avc.c
>> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
>>   	if (denied)
>>   		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
>>   
>> -	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
>> +	avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
> 
> 
> There is a conflict between this change and commit 142372522c7e ("libselinux: avoid
> newline in avc message").
> 
> I'll send another version without it.

Now that you've pointed out Christian's patch, this feels like 
potentially the wrong level to solve this.

As I understand it, the issue Christian was trying to solve is that 
audit doesn't parse as we intend if there is a newline in the middle of 
the message, and userspace object managers append additional material to 
USER_AVC messages.  Hence his removal of newline above.

The problem this patch is trying to solve is that when SELinux aware 
applications call logging functions in libselinux, they get printed 
directly to standard error, and in that case really should end in a newline.

Secondarily, this patch solves the fact that previously the messages 
logged by SELinux were just inconsistent with regards to final newlines.

It happens that in the current state of things, userspace object 
managers append to AVCs above, and rpm had issues with setenforce and 
policyload, so segregating newlines based on message type as this patch 
with the above hunk dropped would do addresses all the issues.

I feel like that's sort of a happenstance that this is the current state 
of the code though, and if a future change results in SELinux aware 
applications dumping AVCs directly to standard error for example, then 
there won't be a good solution in the current approach.

Would it be perhaps a cleaner solution to standardize all libselinux 
messages on no newline and then changing default_selinux_log() to append 
a newline since that's writing directly to stderr and relying on callers 
into libselinux to add a newline if needed?

-Daniel

> 
> 
>>   
>>   	avc_release_lock(avc_log_lock);
>>   }
>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
>> index 71a1357bc564..c550e5788527 100644
>> --- a/libselinux/src/avc_internal.c
>> +++ b/libselinux/src/avc_internal.c
>> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>>   	int rc = 0;
>>   
>>   	avc_log(SELINUX_SETENFORCE,
>> -		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
>> +		"%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
>>   		avc_prefix, enforcing);
>>   	if (avc_setenforce)
>>   		goto out;
>> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>>   	int rc = 0;
>>   
>>   	avc_log(SELINUX_POLICYLOAD,
>> -		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
>> +		"%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
>>   		avc_prefix, seqno);
>>   	rc = avc_ss_reset(seqno);
>>   	if (rc < 0) {
>> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
>> index 022cd6b5ecab..319af267c6a7 100644
>> --- a/libselinux/src/checkAccess.c
>> +++ b/libselinux/src/checkAccess.c
>> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>>          sclass = string_to_security_class(class);
>>          if (sclass == 0) {
>>   	       rc = errno;
>> -	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
>> +	       avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
>>   	       if (security_deny_unknown() == 0)
>>   		       return 0;
>>   	       errno = rc;
>> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>>          av = string_to_av_perm(sclass, perm);
>>          if (av == 0) {
>>   	       rc = errno;
>> -	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
>> +	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
>>   	       if (security_deny_unknown() == 0)
>>   		       return 0;
>>   	       errno = rc;
>> -- 
>> 2.37.3

