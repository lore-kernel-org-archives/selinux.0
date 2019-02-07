Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E90C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 09:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA4218B0
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 09:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBGJJ5 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 7 Feb 2019 04:09:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfBGJJ5 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Feb 2019 04:09:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E52C7E9C5;
        Thu,  7 Feb 2019 09:09:57 +0000 (UTC)
Received: from localhost (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 768CC6155B;
        Thu,  7 Feb 2019 09:09:56 +0000 (UTC)
References: <20190131194208.3855-1-plautrba@redhat.com> <CAJfZ7=kYgvh3QeXBzWbMcjMuSKt1VaGkaxj=xiJ_0PFsihhPMQ@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Dan Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] dbus: Fix name of polkit function
In-reply-to: <CAJfZ7=kYgvh3QeXBzWbMcjMuSKt1VaGkaxj=xiJ_0PFsihhPMQ@mail.gmail.com>
Date:   Thu, 07 Feb 2019 10:09:54 +0100
Message-ID: <pjdmun8x8v1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 07 Feb 2019 09:09:57 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Jan 31, 2019 at 8:42 PM Petr Lautrbach 
> <plautrba@redhat.com> wrote:
>>
>> From: Dan Walsh <dwalsh@redhat.com>
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Hi,
> As I am unfamiliar with D-Bus code, I try to understand what is 
> the
> nature of this change (is-it a bugfix, an improvement, something
> else?). Here are the facts:
>
> - Currently, dbus/selinux_server.py uses «
> @slip.dbus.polkit.require_auth("org.selinux.change_default_mode") 
> »
> for function « change_default_mode ».
> - "org.selinux.change_default_mode" does not exist, and I do not 
> know
> whether that means that some kind of default policykit policy 
> gets
> applied.
> - "org.selinux.change_policy_type" is defined in
> dbus/org.selinux.policy, without any user.
> - The commit that introduced dbus/selinux_server.py (commit
> e6a1298e5421 ("These are massive changes involved in building 
> new
> GUI.")) added a function named « change_default_mode », without 
> any
> specific policykit access checking.
> - Commit e8718ef51463 ("Make sure we do the polkit check on all 
> dbus
> interfaces.") added «
> @slip.dbus.polkit.require_auth("org.selinux.change_default_mode") 
> » in
> policycoreutils/sepolicy/selinux_server.py.
>
> If I understand correctly, this last commit is buggy and should 
> have
> added "org.selinux.change_default_mode" to
> policycoreutils/sepolicy/org.selinux.policy. Therefore this new 
> patch
> fixes a bug and removes an unused policykit action. Is this 
> right? If
> yes, I suggest adding this to the commit description:
>
>     Add missing action org.selinux.change_default_mode for
> change_default_mode() and remove unused action
> org.selinux.change_policy_type.
>
>     Fixes: e8718ef51463 ("Make sure we do the polkit check on 
>     all dbus
> interfaces.")
>
> Would this be acceptable?

You are completely right and the new message makes sense. I'll 
resend
the patch with updated commit message.

Thanks!

>
>> ---
>>  dbus/org.selinux.policy | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/dbus/org.selinux.policy b/dbus/org.selinux.policy
>> index 01266102..9772127b 100644
>> --- a/dbus/org.selinux.policy
>> +++ b/dbus/org.selinux.policy
>> @@ -70,9 +70,9 @@
>>           <allow_active>auth_admin_keep</allow_active>
>>          </defaults>
>>      </action>
>> -    <action id="org.selinux.change_policy_type">
>> -        <description>SELinux write access</description>
>> -        <message>System policy prevents change_policy_type 
>> access to SELinux</message>
>> +    <action id="org.selinux.change_default_mode">
>> +        <description>Change SELinux default enforcing 
>> mode</description>
>> +        <message>System policy prevents change_default_policy 
>> access to SELinux</message>
>>          <defaults>
>>            <allow_any>no</allow_any>
>>            <allow_inactive>no</allow_inactive>
>> --
>> 2.20.1
>>

