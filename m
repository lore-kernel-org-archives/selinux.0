Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56238C433DB
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 20:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A02164DD5
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKUlS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 15:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBKUlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 15:41:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66106C061574
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 12:40:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w4so6679586wmi.4
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cmY1yp8k7Hfh2v9Gm4tHQeomgq8Gg1DiQGuzFqddXUQ=;
        b=bYGegSh+j9w7fLGvKWGyMmQdt4rtAILHByDR8P2mvuFmi8g/5vQ3CjMPaa+GumPFrU
         ZC+BkSw4byn26+LS/LT5gKFG9iWdwMGeBggzuylCx/ftnRDcCVkRp0chFd/0OaYD4lE0
         UGEcKBqyA5PK8xrV4L0de2RzDmSZN2hbDmlH68vyPG0S593cCL4wAyHfxidTcDhmOgQU
         yM3i/gUa6nY1Rf0ePws6MyBN8oIoR0xnDMEZQYv0YLL2u41FuMbfBV6/nm/zmkgQuVj1
         vtfZGAEp6D6QCGqFoBnQN9ZJKpdE9BCThr8j/xLFV9v4EvjGggMU6zacWSHVAtykxgI7
         LUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cmY1yp8k7Hfh2v9Gm4tHQeomgq8Gg1DiQGuzFqddXUQ=;
        b=POLZaPf95lEXYRXq7Vqt1guPLHWVGjgRUlPwLfMU7VFEVrE7zYc9Csh4Lc715D2hRk
         /fGcufYOFk+QbP0ddKLlQoVfXu19AnwurGauG8JdAETbsUTK/dg7yxwgTjY33ou5GdMe
         uNtFbG9xdYp+8fZO0CWq7Q7VnCIg+kTGdcIUPgBEYizmZlMBNOTtf168Kcnh5wN8ldH2
         FN0GKOrcQ+m1IZGpq4V4rQ/MsC7JrxJ9rin02wWcZg+torVIROoDu9T9Bk/8WPwXEL5L
         F4ELTTjyPeYJcxQvPfQI+OVw1LLzkKlWT4wQ75v0CYo3rC5GS0cD3/j5A0XssIcOp66x
         8bYQ==
X-Gm-Message-State: AOAM533Mt1ywuUDEDADAi8qUw1HLEP+q321z7ldjQgSnS5Ho1vODhmYR
        Cld/bHCklolaTU73G8/vO5HtROqrQ2ptdR9mJshe6xHgRvn/jQ==
X-Google-Smtp-Source: ABdhPJzCguGb0h0Nkktgv8NlPwbBgCkz0stDgWCWqjPWTHDIK/KKw6macKd8Kw3ZNDemFcMSOAq68iTDLh5213lW7yQ=
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr6727573wma.63.1613076035756;
 Thu, 11 Feb 2021 12:40:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
In-Reply-To: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Thu, 11 Feb 2021 15:40:10 -0500
Message-ID: <CAGeouKGuHrCVFDPoNECZUpxV_B0=Qynm28phM3AU9jAdMbM68A@mail.gmail.com>
Subject: Fwd: Defining SELinux users, "Unable to get valid context...". Help!
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
