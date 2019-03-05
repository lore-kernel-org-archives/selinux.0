Return-Path: <SRS0=RVlB=RI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B787C43381
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4337C2082C
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 09:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfCEJMM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:12:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfCEJMM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 Mar 2019 04:12:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45FA04E908;
        Tue,  5 Mar 2019 09:12:12 +0000 (UTC)
Received: from localhost (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE56526FCD;
        Tue,  5 Mar 2019 09:12:11 +0000 (UTC)
References: <20190304163735.29563-1-plautrba@redhat.com> <1a98677c-7e70-b965-04fb-7ac01fa6c5d6@tycho.nsa.gov>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: Add security_reject_unknown(3) man page
In-reply-to: <1a98677c-7e70-b965-04fb-7ac01fa6c5d6@tycho.nsa.gov>
Date:   Tue, 05 Mar 2019 10:12:10 +0100
Message-ID: <pjdzhq9n0r9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 05 Mar 2019 09:12:12 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 3/4/19 11:37 AM, Petr Lautrbach wrote:
>> Commit c19395d7 added a new interface security_reject_unknown() 
>> which needs to
>> be documented.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libselinux/man/man3/security_getenforce.3     | 9 ++++++++-
>>   libselinux/man/man3/security_reject_unknown.3 | 1 +
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>   create mode 100644 
>>   libselinux/man/man3/security_reject_unknown.3
>>
>> diff --git a/libselinux/man/man3/security_getenforce.3 
>> b/libselinux/man/man3/security_getenforce.3
>> index 29cf3de7..8d72afb6 100644
>> --- a/libselinux/man/man3/security_getenforce.3
>> +++ b/libselinux/man/man3/security_getenforce.3
>> @@ -1,6 +1,7 @@
>>   .TH "security_getenforce" "3" "1 January 2004" 
>>   "russell@coker.com.au" "SELinux API documentation"
>>   .SH "NAME"
>> -security_getenforce, security_setenforce, 
>> security_deny_unknown, security_get_checkreqprot\- get or set 
>> the enforcing state of SELinux
>> +security_getenforce, security_setenforce, 
>> security_deny_unknown, security_reject_unknown,
>> +security_get_checkreqprot\- get or set the enforcing state of 
>> SELinux
>>   .
>>   .SH "SYNOPSIS"
>>   .B #include <selinux/selinux.h>
>> @@ -11,6 +12,8 @@ security_getenforce, security_setenforce, 
>> security_deny_unknown, security_get_ch
>>   .sp
>>   .B int security_deny_unknown(void);
>>   .sp
>> +.B int security_reject_unknown(void);
>> +.sp
>>   .B int security_get_checkreqprot(void);
>>   .
>>   .SH "DESCRIPTION"
>> @@ -27,6 +30,10 @@ returned.
>>   returns 0 if SELinux treats policy queries on undefined 
>>   object classes or
>>   permissions as being allowed, 1 if such queries are denied, 
>>   and \-1 on error.
>>   +.BR security_reject_unknown ()
>> +returns 0 if SELinux allows to load a policy which doesn't 
>> define all object
>> +classes and permissions, 1 if loading such policy is rejected, 
>> and \-1 on error.
>
> s/all object classes and permissions/all kernel object classes 
> and permissions/
>
> A policy can still be loaded if it is missing userspace object 
> classes and
> permissions regardless of security_reject_unknown(), although 
> the object manager
> may later encounter a failure upon selinux_set_mapping(), which 
> internally calls
> security_reject_unknown() to decide how to proceed, or direct 
> attempts to lookup
> the class or permission via string_to_security_class() or 
> string_to_av_perm().

I'll update the text.

> I don't know of anyone building policies with handle_unknown == 
> reject so it is
> unlikely that anyone is testing this case.  deny is the default. 
> allow is set
> in Fedora/RHEL.  Android uses deny.

We're considering to use handle_unknown = reject for nightly 
builds
to detect whether there's a new kernel class or permission defined 
in
kernel which is not covered by policy.



>> +
>>   .BR security_get_checkreqprot ()
>>   can be used to determine whether SELinux is configured to 
>>   check the
>>   protection requested by the application or the actual 
>>   protection that will
>> diff --git a/libselinux/man/man3/security_reject_unknown.3 
>> b/libselinux/man/man3/security_reject_unknown.3
>> new file mode 100644
>> index 00000000..d59e5c2c
>> --- /dev/null
>> +++ b/libselinux/man/man3/security_reject_unknown.3
>> @@ -0,0 +1 @@
>> +.so man3/security_getenforce.3
>>

