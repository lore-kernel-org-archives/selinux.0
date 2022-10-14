Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94BC4332F
	for <selinux@archiver.kernel.org>; Fri, 14 Oct 2022 14:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJNOh6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Oct 2022 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJNOh4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Oct 2022 10:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4D26AF1
        for <selinux@vger.kernel.org>; Fri, 14 Oct 2022 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZW/tzWd0/zuFme/oi+A+t4vJqNv23YrV9r94mLtsHY=;
        b=PNUJTiywtkxn9GMXQtnhPUAt3e8y312xoTieQ6oQ8cHhUDsSA7jo83w52ciLjBY+hI060L
        47ml9KLLa51B3xNcMcRC+mkHlkvoVQ1QCZdypxSZvdwYisw4ehz1wbPAImM/cHdcCcN6ST
        uc2rPNYPl4AKzYceJkNHrEB541HANhQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-agqIMg1aMPyuhSHnZbYs8w-1; Fri, 14 Oct 2022 10:37:51 -0400
X-MC-Unique: agqIMg1aMPyuhSHnZbYs8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AFCA857D0F;
        Fri, 14 Oct 2022 14:37:50 +0000 (UTC)
Received: from localhost (ovpn-194-85.brq.redhat.com [10.40.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DCD22144B2D;
        Fri, 14 Oct 2022 14:37:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
In-Reply-To: <3e5a0cb1-73e5-6268-2c0b-4f470080073e@linux.microsoft.com>
References: <20221011112733.194079-1-plautrba@redhat.com>
 <877d12sn5v.fsf@redhat.com>
 <3e5a0cb1-73e5-6268-2c0b-4f470080073e@linux.microsoft.com>
Date:   Fri, 14 Oct 2022 16:37:49 +0200
Message-ID: <87wn92qxmq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Daniel Burgener <dburgener@linux.microsoft.com> writes:

> On 10/14/2022 6:41 AM, Petr Lautrbach wrote:
>> Petr Lautrbach <plautrba@redhat.com> writes:
>> 
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>> ---
>>>   libselinux/src/avc.c          | 2 +-
>>>   libselinux/src/avc_internal.c | 4 ++--
>>>   libselinux/src/checkAccess.c  | 4 ++--
>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
>>> index 8d5983a2fe0c..98a3fcae41c8 100644
>>> --- a/libselinux/src/avc.c
>>> +++ b/libselinux/src/avc.c
>>> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
>>>   	if (denied)
>>>   		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
>>>   
>>> -	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
>>> +	avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
>> 
>> 
>> There is a conflict between this change and commit 142372522c7e ("libselinux: avoid
>> newline in avc message").
>> 
>> I'll send another version without it.
>
> Now that you've pointed out Christian's patch, this feels like 
> potentially the wrong level to solve this.
>
> As I understand it, the issue Christian was trying to solve is that 
> audit doesn't parse as we intend if there is a newline in the middle of 
> the message, and userspace object managers append additional material to 
> USER_AVC messages.  Hence his removal of newline above.
>
> The problem this patch is trying to solve is that when SELinux aware 
> applications call logging functions in libselinux, they get printed 
> directly to standard error, and in that case really should end in a newline.
>
> Secondarily, this patch solves the fact that previously the messages 
> logged by SELinux were just inconsistent with regards to final newlines.
>
> It happens that in the current state of things, userspace object 
> managers append to AVCs above, and rpm had issues with setenforce and 
> policyload, so segregating newlines based on message type as this patch 
> with the above hunk dropped would do addresses all the issues.
>
> I feel like that's sort of a happenstance that this is the current state 
> of the code though, and if a future change results in SELinux aware 
> applications dumping AVCs directly to standard error for example, then 
> there won't be a good solution in the current approach.
>
> Would it be perhaps a cleaner solution to standardize all libselinux 
> messages on no newline and then changing default_selinux_log() to append 
> a newline since that's writing directly to stderr and relying on callers 
> into libselinux to add a newline if needed?

This is exactly my thoughts and reason why I haven't sent the new patch
yet.

If we do this we would need to check all main consumers whether they
depend on the new line or not.

Or given the number of avc_log() with "\n" vs those without, we could
revert Christian's patch, document that messages are always ended with
"\n" and let consumers strip it.


Petr



>
> -Daniel
>
>> 
>> 
>>>   
>>>   	avc_release_lock(avc_log_lock);
>>>   }
>>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
>>> index 71a1357bc564..c550e5788527 100644
>>> --- a/libselinux/src/avc_internal.c
>>> +++ b/libselinux/src/avc_internal.c
>>> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>>>   	int rc = 0;
>>>   
>>>   	avc_log(SELINUX_SETENFORCE,
>>> -		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
>>> +		"%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
>>>   		avc_prefix, enforcing);
>>>   	if (avc_setenforce)
>>>   		goto out;
>>> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>>>   	int rc = 0;
>>>   
>>>   	avc_log(SELINUX_POLICYLOAD,
>>> -		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
>>> +		"%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
>>>   		avc_prefix, seqno);
>>>   	rc = avc_ss_reset(seqno);
>>>   	if (rc < 0) {
>>> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
>>> index 022cd6b5ecab..319af267c6a7 100644
>>> --- a/libselinux/src/checkAccess.c
>>> +++ b/libselinux/src/checkAccess.c
>>> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>>>          sclass = string_to_security_class(class);
>>>          if (sclass == 0) {
>>>   	       rc = errno;
>>> -	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
>>> +	       avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
>>>   	       if (security_deny_unknown() == 0)
>>>   		       return 0;
>>>   	       errno = rc;
>>> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>>>          av = string_to_av_perm(sclass, perm);
>>>          if (av == 0) {
>>>   	       rc = errno;
>>> -	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
>>> +	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
>>>   	       if (security_deny_unknown() == 0)
>>>   		       return 0;
>>>   	       errno = rc;
>>> -- 
>>> 2.37.3

