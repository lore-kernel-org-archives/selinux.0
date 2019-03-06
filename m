Return-Path: <SRS0=Zlcp=RJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF7C43381
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78D220652
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfCFM4r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfCFM4r (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Mar 2019 07:56:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C2B33092645;
        Wed,  6 Mar 2019 12:56:46 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 416B160C1B;
        Wed,  6 Mar 2019 12:56:44 +0000 (UTC)
References: <pjdzhq9n0r9.fsf@redhat.com> <20190305093509.12760-1-plautrba@redhat.com> <bb4979d7-5e8c-7186-f8b6-e2d59057eee9@tycho.nsa.gov>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] libselinux: Add security_reject_unknown(3) man page
In-reply-to: <bb4979d7-5e8c-7186-f8b6-e2d59057eee9@tycho.nsa.gov>
Date:   Wed, 06 Mar 2019 13:56:42 +0100
Message-ID: <pjdy35sma9h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 06 Mar 2019 12:56:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 3/5/19 4:35 AM, Petr Lautrbach wrote:
>> Commit c19395d7 added a new interface security_reject_unknown() 
>> which needs to
>> be documented.
>
> For the kernel, checkpatch.pl requires that one specify at least 
> 12 characters
> of the sha1 followed by the one line summary log message quoted 
> within
> parentheses, ala:
> commit c19395d72295 ("libselinux: selinux_set_mapping: fix 
> handling of unknown
> classes/perms")
>
> selinux userspace obviously isn't bound by the kernel 
> checkpatch.pl requirements
> but this is probably a good practice to follow so that reviewers 
> don't
> necessarily have to look up the commit hash to have some idea as 
> to what the
> commit was and so that there is less risk of ambiguity.

This makes sense. I'll try to do better next time.

>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libselinux/man/man3/security_getenforce.3     | 15 
>>   ++++++++++++++-
>>   libselinux/man/man3/security_reject_unknown.3 |  1 +
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>   create mode 100644 
>>   libselinux/man/man3/security_reject_unknown.3
>>
>> diff --git a/libselinux/man/man3/security_getenforce.3 
>> b/libselinux/man/man3/security_getenforce.3
>> index 29cf3de7..7b0a069f 100644
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
>> +security_get_checkreqprot \- get or set the enforcing state of 
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
>> @@ -27,6 +30,16 @@ returned.
>>   returns 0 if SELinux treats policy queries on undefined 
>>   object classes or
>>   permissions as being allowed, 1 if such queries are denied, 
>>   and \-1 on error.
>>   +.BR security_reject_unknown ()
>> +returns 1 if SELinux rejects loading a policy which doesn't 
>> define all kernel
>> +object classes and permissions. In this state SELinux treats 
>> policy queries on
>> +undefined object classes or permissions as being denied.
>
> I'm not sure if the last part is quite correct.  If 
> handle_unknown=reject and
> the policy doesn't define all kernel classes/permissions, then 
> the policy load
> fails, which leaves the system without a policy at all (or with 
> its previously
> loaded policy if one was already loaded successfully). If the 
> system is
> enforcing and this is the initial policy load, then init should 
> halt the system
> due to the failed load.  Since no policy was ever loaded,
> security_reject_unknown() is still going to return 0 in that 
> case, but
> security_deny_unknown() should be 1.
>
> If handle_unknown=reject and the policy defines all kernel 
> classes/permissions
> but omits some userspace classes/permissions, then the policy 
> load succeeds and
> the behavior of the userspace object managers will vary 
> depending on what
> interfaces they use and how they handle error conditions. If 
> they use
> selinux_set_mapping() to map all of the classes/permissions up 
> front prior to
> using security_compute_av() or avc_has_perm(), then 
> selinux_set_mapping() will
> return an error and the object manager likely treats this as a 
> fatal error
> during startup (e.g. dbus-daemon appears to exit in this case; 
> XSELinux in
> contrast appears to just disable itself).  If they instead use
> selinux_check_access(), then it will return an error and the 
> object manager
> likely treats this like any other permission denial (but errno 
> will differ:
> EINVAL vs EACCES, so they could distinguish if they wanted). If 
> they directly
> call string_to_security_class() and string_to_av_perm() prior to 
> calling
> security_compute_av() or avc_has_perm(), then the string_*() 
> functions will
> return an error on the undefined class/perm and the object 
> manager likely treats
> that like any other permission denial.

There's also an inaccuracy that security_reject_unknown() is
related only to the current loaded policy. Even when a policy is
incomplete it could be still loaded if it's built using
handle-unknown=allow:

# checkpolicy -U reject -M -o /etc/selinux/dummy/policy/policy.31 
  policy.conf.complete 
# load_policy 
# cat /sys/fs/selinux/reject_unknown 
1
#checkpolicy -U reject -M -o /etc/selinux/dummy/policy/policy.31 
 policy.conf
# load_policy 
SELinux:  Could not load policy file 
/etc/selinux/dummy/policy/policy.31:  Invalid argument
load_policy:  Can't load policy:  Invalid argument
# checkpolicy -U allow -M -o /etc/selinux/dummy/policy/policy.31 
  policy.conf
# load_policy 
# cat /sys/fs/selinux/reject_unknown 
0


>> +
>> +It returns 0 if SELinux allows to load such policy and policy 
>> queries are
>> +treated according to
>> +.BR security_deny_unknown(),
>> +\-1 is returned on error.
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

