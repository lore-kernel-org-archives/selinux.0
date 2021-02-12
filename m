Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BDC433DB
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3440D64E13
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 07:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBLHzk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 02:55:40 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:55388 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBLHzi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 12 Feb 2021 02:55:38 -0500
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 7DC992A124E;
        Fri, 12 Feb 2021 08:54:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 7DC992A124E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613116495;
        bh=IE10FwMoCZRVPVId3vmwEVPww59nkIaPcDvP/FE245M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=si8cwr35PlrnsAm8JqHtkmzIMdC/3gEyRvD06l2QKSaMuox9b3w3smpNnjjJ6udEc
         R0oyC6pkFHHeNZ4cziYxwrlVlxQApGW4X36dbA42Vw15F+cORKXOAy/PGNlsN7fsLA
         T5651T+U/j7N7gMOJPwv+T8269AQ2Jyu4KJWFdlo=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl>
Date:   Fri, 12 Feb 2021 08:54:53 +0100
In-Reply-To: <ypjlblcppx6o.fsf@defensec.nl> (Dominick Grift's message of "Fri,
        12 Feb 2021 08:22:39 +0100")
Message-ID: <ypjl7dndpvoy.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>
>> Good afternoon,
>>
>>     BLUF: Logging in via SSH or directly at the console results
>>     in "Unable to get valid context...". Help! Much info included.
>>
>> I'm working on a software diode implementing a linear assured pipeline
>> which is secured with SELinux. As part of this, I am defining a number
>> of SELinux users, with the goal being that Linux users belonging to a
>> specific Linux group will, at login, be assigned to the applicable
>> SELinux user, then role, then type, etc.
>>
>> However. When I log in as my test user, icmc01, via the console or via
>> SSH, I get the message "Unable to get valid context for icmc01". A
>> check with "id -Z" shows that my test user has the following context:
>>
>>     system_u:system_r:unconfined_t:s0-s0:c0.c1023
>>
>> I really want them to have the context:
>>
>>     CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0-s0:c0.c1023
>>
>> (In fact, I don't care about the MLS/MCS portion, I am more than happy
>> to accept system defaults; I'm really only going for the MAC.)
>>
>> What follows is everything I could think to include, from their passwd
>> entry and the group file to semanage settings, from the contexts and
>> content of various SELinux configuration files to the relevant snips
>> of the TE file itself.
>
> A few things that I could find but that are needed for computing
> contexts are:
>
> the login programs need to be allowed to manual transition to the user
> type. So for example if you want to login with sshd_t:
> allow sshd_t xferHigh2Local_t:process transition;

In relation to the above, ensure that the xferHigh2Local_t type is
associated with the process_user_target typeattribute:
typeattribute xferHigh2Local_t process_user_target;

>
> The user type needs to be a bin and shell entry type:
> allow xferHigh2Local_t { bin_t shell_exec_t }:file entrypoint;
>
> There is probably more that i am overlooking but these, i think, are
> important part for computation of contexts
>
> See where those get you.
>
>>
>> NOTE: This is all under permissive mode, targeted policy.
>>
>> Any insight or direction will be much appreciated, I am tearing out
>> my hair. Thank you!
>>
>>     % grep icmc01 /etc/passwd
>>     icmc01:x:2105:2105::/home/icmc01:/bin/bash
>>
>>     % grep 2105 /etc/group
>>     CDTml_high2local:x:2105:
>>
>>     % semanage login -l |grep CDTml_high2local_u
>>     %CDTml_high2local    CDTml_high2local_u   s0-s0:c0.c1023       *
>>
>>     % semanage user -l |grep CDTml_high2local_u
>>     CDTml_high2local_u user       s0         s0-s0:c0.c1023
>>      CDTml_high2local_r
>>
>>     % ls -lZ /etc/selinux/targeted/contexts/users/CDTml_high2local_u
>>     -rw-r--r--. root root system_u:object_r:default_context_t:s0
>> /etc/selinux/targeted/contexts/users/CDTml_high2local_u
>>
>>     % cat /etc/selinux/targeted/contexts/users/CDTml_high2local_u
>>     system_r:crond_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:initrc_su_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:local_login_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:remote_login_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:sshd_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     CDTml_high2local_r:xferHigh2Local_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>
>>     % ls -lZ /etc/selinux/targeted/contexts/default_*
>>     -rw-r--r--. root root system_u:object_r:default_context_t:s0
>> /etc/selinux/targeted/contexts/default_contexts
>>     -rw-r--r--. root root system_u:object_r:default_context_t:s0
>> /etc/selinux/targeted/contexts/default_type
>>
>>     % cat /etc/selinux/targeted/contexts/default_contexts
>>     system_r:crond_t:s0 system_r:system_cronjob_t:s0
>>     system_r:local_login_t:s0 user_r:user_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:remote_login_t:s0 user_r:user_t:s0
>> CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:sshd_t:s0 user_r:user_t:s0 CDTml_high2local_r:xferHigh2Local_t:s0
>>     system_r:sulogin_t:s0 sysadm_r:sysadm_t:s0
>>     system_r:xdm_t:s0 user_r:user_t:s0
>>
>>     % uname -a
>>     Linux localhost.localdomain 3.10.0-1160.6.1.el7.x86_64 #1 SMP Wed
>> Oct 21 13:44:38 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>
>>     % more /etc/redhat-release
>>     Red Hat Enterprise Linux Server release 7.9 (Maipo)
>>
>>     % yum info installed \*selinux\*|grep -A3 '^Name'
>>     Name        : libselinux
>>     Arch        : x86_64
>>     Version     : 2.5
>>     Release     : 15.el7
>>     --
>>     Name        : libselinux-python
>>     Arch        : x86_64
>>     Version     : 2.5
>>     Release     : 15.el7
>>     --
>>     Name        : libselinux-utils
>>     Arch        : x86_64
>>     Version     : 2.5
>>     Release     : 15.el7
>>     --
>>     Name        : selinux-policy
>>     Arch        : noarch
>>     Version     : 3.13.1
>>     Release     : 268.el7_9.2
>>     --
>>     Name        : selinux-policy-devel
>>     Arch        : noarch
>>     Version     : 3.13.1
>>     Release     : 268.el7_9.2
>>     --
>>     Name        : selinux-policy-targeted
>>     Arch        : noarch
>>     Version     : 3.13.1
>>     Release     : 268.el7_9.2
>>
>>     % grep -C3 CDTml_high2local_r CDTml.te
>>     # and grant them access to our types
>>     role CDTml_low2local_r;
>>     role CDTml_local2high_r;
>>     role CDTml_high2local_r;
>>     role CDTml_local2low_r;
>>     role CDTml_auditor_r;
>>
>>     allow system_r {
>>         CDTml_low2local_r
>>         CDTml_local2high_r
>>         CDTml_high2local_r
>>         CDTml_local2low_r
>>         CDTml_auditor_r
>>     };
>>     allow unconfined_r {
>>         CDTml_low2local_r
>>         CDTml_local2high_r
>>         CDTml_high2local_r
>>         CDTml_local2low_r
>>         CDTml_auditor_r
>>     };
>>     --
>>         xferLocal2High_t
>>         xferLocal2High_exec_t
>>     };
>>     role CDTml_high2local_r types {
>>         xferHigh2Local_t
>>         xferHigh2Local_exec_t
>>     };
>>
>>     % tail -f /var/log/secure
>>     Feb 11 14:57:44 localhost login: pam_selinux(login:session): Open Session
>>     Feb 11 14:57:44 localhost login: pam_selinux(login:session): Open Session
>>     Feb 11 14:57:44 localhost login: pam_selinux(login:session):
>> Username= icmc01 SELinux User= CDTml_high2local_u Level=
>> s0-s0:c0.c1023
>>     Feb 11 14:57:44 localhost login: pam_selinux(login:session):
>> Unable to get valid context for icmc01
>>     Feb 11 14:57:44 localhost login: pam_unix(login:session): session
>> opened for user icmc01 by LOGIN(uid=0)
>>     Feb 11 14:57:44 localhost login: LOGIN ON tty2 BY icmc01
>>
>>
>> Peter Whittaker
>> Director, Business Development
>> www.SphyrnaSecurity.com
>> +1 613 864 5337

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
