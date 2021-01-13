Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4EDC433E6
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B64D217BA
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 19:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbhAMTUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbhAMTUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 14:20:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464ABC061786
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 11:19:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t16so4629371ejf.13
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/PHuWHTpBgQdNKFQVbdGCQEXvy7VZiLuqAEx0fTPmc=;
        b=tL+6Yn+IUsR2YEh35/aL3jXmHoQrvV8UasLgKQs0l8QTPelm18MXU0i3P5X+q4QWyq
         IhkiuKLuRQY4K2Bm+4ujxq41d+pjIeAoE7mCKTalqgNt447l7cBLfHL7p7cWpN6fvHsf
         MkfuWSXLj+eD22GOZPqCKgArFwovqD9oCbHS+/cDZVlW3quSi0wTe4iSNl4juLeRW3dP
         tZs7fPTeHCn3YCA5FgzY+0GRtINk3h4JiQd8M25jLQQoNIwHojUVEo3rFd4aIINQc7KR
         O94AirXCPjk3ria+0IeigE7amaEwrI5r79qJdIqrwqBuRbpYNY/1F+9qOtfE0tmo+l2Z
         N2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/PHuWHTpBgQdNKFQVbdGCQEXvy7VZiLuqAEx0fTPmc=;
        b=pnWdK9s0QJksE1gA1pCPfh/BpHEaJ+fsu4JXNjZHrXG7Kyq/RZudwB4Vx6jkzgS4l2
         S77rf27NityHh2e0i+xZdFOi5CbuVJ5Ll9j9coLe68lBS6TkUBIbGr89vsjcoAoKdlPC
         1JmaZJWz3G1lc6WXJ5u2lOcM06x2cYZuWLXvoFZTn9ZxKjIxV9RF7Q/cLtRD4mBi2/uh
         ODPvF422E0Y+muiw/Xbre1/KPPHkwHKakf/3pfTdAb6na2t9mP6mBMo71NITX/8RB8R7
         6ahfTzpKgYwFp6E61vAjSenhc/6iSnrD5gnc9fTL2pMHLDnmX0JjSfA3Bu7CVFfV3v6z
         SryA==
X-Gm-Message-State: AOAM531soADZ+LvjuJ00JrdWZI2/kCpyG4siP6+lAQxMwSg3XALWXUpM
        KYrMQBENAGGGMoCwxhj+juYhfTtrfrCcz1jy93Fd
X-Google-Smtp-Source: ABdhPJzpy46FnrM89yDbgKYDTI8w6gf3C22HrHYgT3GZAYPhAuzSu+VXCuKNthgyqqXgSQ08rYGZHUwVDEZ9CXerKRc=
X-Received: by 2002:a17:907:4126:: with SMTP id mx6mr2618600ejb.91.1610565575830;
 Wed, 13 Jan 2021 11:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com> <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
 <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
In-Reply-To: <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jan 2021 14:19:24 -0500
Message-ID: <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 2:13 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> > On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> > <tusharsu@linux.microsoft.com> wrote:
> > > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > >
> > > SELinux stores the active policy in memory, so the changes to this data
> > > at runtime would have an impact on the security guarantees provided
> > > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > > provides a secure way for the attestation service to remotely validate
> > > the policy contents at runtime.
> > >
> > > Measure the hash of the loaded policy by calling the IMA hook
> > > ima_measure_critical_data().  Since the size of the loaded policy
> > > can be large (several MB), measure the hash of the policy instead of
> > > the entire policy to avoid bloating the IMA log entry.
> > >
> > > To enable SELinux data measurement, the following steps are required:
> > >
> > > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> > >    to enable measuring SELinux data at boot time.
> > > For example,
> > >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> > >
> > > 2, Add the following rule to /etc/ima/ima-policy
> > >    measure func=CRITICAL_DATA label=selinux
> > >
> > > Sample measurement of the hash of SELinux policy:
> > >
> > > To verify the measured data with the current SELinux policy run
> > > the following commands and verify the output hash values match.
> > >
> > >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> > >
> > >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> > >
> > > Note that the actual verification of SELinux policy would require loading
> > > the expected policy into an identical kernel on a pristine/known-safe
> > > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > > the expected hash.
> > >
> > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > >  Documentation/ABI/testing/ima_policy |  3 +-
> > >  security/selinux/Makefile            |  2 +
> > >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> > >  security/selinux/include/ima.h       | 24 +++++++++++
> > >  security/selinux/include/security.h  |  3 +-
> > >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> > >  6 files changed, 149 insertions(+), 11 deletions(-)
> > >  create mode 100644 security/selinux/ima.c
> > >  create mode 100644 security/selinux/include/ima.h
> >
> > I remain concerned about the possibility of bypassing a measurement by
> > tampering with the time, but I appear to be the only one who is
> > worried about this so I'm not going to block this patch on those
> > grounds.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> Thanks, Paul.
>
> Including any unique string would cause the buffer hash to change,
> forcing a new measurement.  Perhaps they were concerned with
> overflowing a counter.

My understanding is that Lakshmi wanted to force a new measurement
each time and felt using a timestamp would be the best way to do that.
A counter, even if it wraps, would have a different value each time
whereas a timestamp is vulnerable to time adjustments.  While a
properly controlled and audited system could be configured and
monitored to detect such an event (I *think*), why rely on that if it
isn't necessary?

-- 
paul moore
www.paul-moore.com
