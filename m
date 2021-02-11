Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC6C433E9
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A3C64E6C
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBKUXB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 15:23:01 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:52112
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhBKUWy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 15:22:54 -0500
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 15:22:54 EST
Received: from mail-wr1-f43.google.com ([209.85.221.43])
        by :SMTPAUTH: with ESMTPA
        id AIL3ltrPRJxCKAIL5lHytX; Thu, 11 Feb 2021 13:13:23 -0700
X-CMAE-Analysis: v=2.4 cv=ZcrYiuZA c=1 sm=1 tr=0 ts=60258fe3
 a=dFnnagVfVWeg+/bq/M6kfQ==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=oSqZqoiyAAAA:8 a=JzQy7C8ADFe5TzdhByEA:9 a=QEXdDO2ut3YA:10 a=DRj6J5qQIhcA:10
 a=fw9lIXHl4l3rR_lUHM3T:22 a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f43.google.com with SMTP id l12so5440427wry.2
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 12:13:23 -0800 (PST)
X-Gm-Message-State: AOAM531tF8dLIDKdxuyUodNmY+05gfe3ABydcJbJCXS9bFQc6fNQIyWG
        LCc/ZLzjfa+Wij9lmBQnTfefEWms0+HVNsAyrpuvCw==
X-Google-Smtp-Source: ABdhPJwbJFKgbhww3i4j6UTvt+Ogk2WRZ7TPf0ttBC/nF+C2m5inBLZQDaSITWcHzYHRWUoMZ//Xxq9Ur+AiErtP1E8=
X-Received: by 2002:a05:6000:1362:: with SMTP id q2mr7278392wrz.31.1613074400651;
 Thu, 11 Feb 2021 12:13:20 -0800 (PST)
MIME-Version: 1.0
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Thu, 11 Feb 2021 15:12:54 -0500
X-Gmail-Original-Message-ID: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
Message-ID: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
Subject: Defining SELinux users, "Unable to get valid context...". Help!
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfJxmuHYgeY+/izQTwqjhSUSgkHs7r6GinKpTUUMdmsVReS7SAqI1sfJ6/EAKyNbSL2kahpIbLUrZwB/V5Fw8XyynVnXdEwtRoZebmORdeirsbcczS7yc
 okXrc9tuv0QDcqEX9uM0SZpYG+XSRHXTijQbTgzR+Zjf3Hm1UFBYk26svKbe7mtTrzXcATVTZl34KYiVzr7ONtYslYghMLwKa9UTlc0XIZ7f1ogMtdhe/Gdv
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Good afternoon,

    BLUF: Logging in via SSH or directly at the console results
    in "Unable to get valid context...". Help! Much info included.

I'm working on a software diode implementing a linear assured pipeline
which is secured with SELinux. As part of this, I am defining a number
of SELinux users, with the goal being that Linux users belonging to a
specific Linux group will, at login, be assigned to the applicable
SELinux user, then role, then type, etc.

However. When I log in as my test user, icmc01, via the console or via
SSH, I get the message "Unable to get valid context for icmc01". A
check with "id -Z" shows that my test user has the following context:

    system_u:system_r:unconfined_t:s0-s0:c0.c1023

I really want them to have the context:

    CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0-s0:c0.c1023

(In fact, I don't care about the MLS/MCS portion, I am more than happy
to accept system defaults; I'm really only going for the MAC.)

What follows is everything I could think to include, from their passwd
entry and the group file to semanage settings, from the contexts and
content of various SELinux configuration files to the relevant snips
of the TE file itself.

NOTE: This is all under permissive mode, targeted policy.

Any insight or direction will be much appreciated, I am tearing out
my hair. Thank you!

    % grep icmc01 /etc/passwd
    icmc01:x:2105:2105::/home/icmc01:/bin/bash

    % grep 2105 /etc/group
    CDTml_high2local:x:2105:

    % semanage login -l |grep CDTml_high2local_u
    %CDTml_high2local    CDTml_high2local_u   s0-s0:c0.c1023       *

    % semanage user -l |grep CDTml_high2local_u
    CDTml_high2local_u user       s0         s0-s0:c0.c1023
     CDTml_high2local_r

    % ls -lZ /etc/selinux/targeted/contexts/users/CDTml_high2local_u
    -rw-r--r--. root root system_u:object_r:default_context_t:s0
/etc/selinux/targeted/contexts/users/CDTml_high2local_u

    % cat /etc/selinux/targeted/contexts/users/CDTml_high2local_u
    system_r:crond_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:initrc_su_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:local_login_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:remote_login_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:sshd_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    CDTml_high2local_r:xferHigh2Local_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0

    % ls -lZ /etc/selinux/targeted/contexts/default_*
    -rw-r--r--. root root system_u:object_r:default_context_t:s0
/etc/selinux/targeted/contexts/default_contexts
    -rw-r--r--. root root system_u:object_r:default_context_t:s0
/etc/selinux/targeted/contexts/default_type

    % cat /etc/selinux/targeted/contexts/default_contexts
    system_r:crond_t:s0 system_r:system_cronjob_t:s0
    system_r:local_login_t:s0 user_r:user_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:remote_login_t:s0 user_r:user_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:sshd_t:s0 user_r:user_t:s0 CDTml_high2local_r:xferHigh2Local_t:s0
    system_r:sulogin_t:s0 sysadm_r:sysadm_t:s0
    system_r:xdm_t:s0 user_r:user_t:s0

    % uname -a
    Linux localhost.localdomain 3.10.0-1160.6.1.el7.x86_64 #1 SMP Wed
Oct 21 13:44:38 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux

    % more /etc/redhat-release
    Red Hat Enterprise Linux Server release 7.9 (Maipo)

    % yum info installed \*selinux\*|grep -A3 '^Name'
    Name        : libselinux
    Arch        : x86_64
    Version     : 2.5
    Release     : 15.el7
    --
    Name        : libselinux-python
    Arch        : x86_64
    Version     : 2.5
    Release     : 15.el7
    --
    Name        : libselinux-utils
    Arch        : x86_64
    Version     : 2.5
    Release     : 15.el7
    --
    Name        : selinux-policy
    Arch        : noarch
    Version     : 3.13.1
    Release     : 268.el7_9.2
    --
    Name        : selinux-policy-devel
    Arch        : noarch
    Version     : 3.13.1
    Release     : 268.el7_9.2
    --
    Name        : selinux-policy-targeted
    Arch        : noarch
    Version     : 3.13.1
    Release     : 268.el7_9.2

    % grep -C3 CDTml_high2local_r CDTml.te
    # and grant them access to our types
    role CDTml_low2local_r;
    role CDTml_local2high_r;
    role CDTml_high2local_r;
    role CDTml_local2low_r;
    role CDTml_auditor_r;

    allow system_r {
        CDTml_low2local_r
        CDTml_local2high_r
        CDTml_high2local_r
        CDTml_local2low_r
        CDTml_auditor_r
    };
    allow unconfined_r {
        CDTml_low2local_r
        CDTml_local2high_r
        CDTml_high2local_r
        CDTml_local2low_r
        CDTml_auditor_r
    };
    --
        xferLocal2High_t
        xferLocal2High_exec_t
    };
    role CDTml_high2local_r types {
        xferHigh2Local_t
        xferHigh2Local_exec_t
    };

    % tail -f /var/log/secure
    Feb 11 14:57:44 localhost login: pam_selinux(login:session): Open Session
    Feb 11 14:57:44 localhost login: pam_selinux(login:session): Open Session
    Feb 11 14:57:44 localhost login: pam_selinux(login:session):
Username= icmc01 SELinux User= CDTml_high2local_u Level=
s0-s0:c0.c1023
    Feb 11 14:57:44 localhost login: pam_selinux(login:session):
Unable to get valid context for icmc01
    Feb 11 14:57:44 localhost login: pam_unix(login:session): session
opened for user icmc01 by LOGIN(uid=0)
    Feb 11 14:57:44 localhost login: LOGIN ON tty2 BY icmc01


Peter Whittaker
Director, Business Development
www.SphyrnaSecurity.com
+1 613 864 5337
