Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E9C43332
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0BA2242A
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbhANCLn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbhAMWLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 17:11:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7ACC061786
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 14:10:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 6so5319651ejz.5
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHpWTw6lcPxz7z8H8yQJbwdU01y9cP5VFlHIAcOYlIE=;
        b=B2jvRWZJURQ5oLNMwvJfonm7dSdUz89Ple+ZJuYOXcXZ7dhHpGH7Q7+w3X36ZBWmKC
         SZVY4kP8zTNT+/eQZiiqp5eK+9C6x1UFd4NdwG8nWK0baXnQTowRKcF6x3D5gHX0yQcF
         sfgeCszX8SGM2ryM3QdOT+nct7lR9nxs0DCnMjPMr4wOp7Lk/zuDSxlnHLC4M0d3KB1V
         ExMz9YrKyBAlaH3WiDJZkFL6Usft206o7TZMgfl2/anU6vg/vQUQ3YUElFP3jasCt8PG
         Di8oWLX2naDdKMFQpSipQdpaWBSpYJ41I7KJ+HQLM0ttURYXt111lDa6pMOpcLdOH5yD
         jMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHpWTw6lcPxz7z8H8yQJbwdU01y9cP5VFlHIAcOYlIE=;
        b=VIQKgNF2I+9bQych1askCCVv9WpSB8VCcb21H2bPI7iyds7s8ATTpe/UnEvhB4q6sB
         610/PHuaTNHEy+nKQcr1loLrKn1P+X7kqWa9S3egMUlRO39ACe/QIeNqPCrXA5HuNtym
         y6Oc97VbTIt3RSxiYtCTik2hPfCMTCTXugEvHszaK3zNif52O5q0noXIifWskYq0j8TG
         5u0o4R8rNuY052HqQgMBtJ+SZMLMvdGwnRQbv1N3Q2DUPvBwCaZNfpfjFReLYXqSbYB4
         M5/2LVCD1i9QwbQ8mvFDxXuKp1TwSp2NwaM0hK9k8OpaOWsTTCajy4szT8PKuFnC7Zv/
         bxgQ==
X-Gm-Message-State: AOAM532smgRh9/XwDEIul59oEi87mTPY/2dM3A7GpTGdKvkCglMVhuPM
        8auCYyt5/PWX7QUrKpPat2Mx7qXKgAkUwFa5/1qq
X-Google-Smtp-Source: ABdhPJyQ+Tv7FzDHXgquLSuHzkUCDHhbnr+LMfzfd+uUbDk6LddmjJQuH97q0w+D3HgxnXmUDLfKkBaytbA3dCAnK58=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr3206433ejc.178.1610575829813;
 Wed, 13 Jan 2021 14:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com> <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
 <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
 <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com> <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
In-Reply-To: <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jan 2021 17:10:18 -0500
Message-ID: <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Wed, 2021-01-13 at 14:19 -0500, Paul Moore wrote:
> > On Wed, Jan 13, 2021 at 2:13 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> > > > On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> > > > <tusharsu@linux.microsoft.com> wrote:
> > > > > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > >
> > > > > SELinux stores the active policy in memory, so the changes to this data
> > > > > at runtime would have an impact on the security guarantees provided
> > > > > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > > > > provides a secure way for the attestation service to remotely validate
> > > > > the policy contents at runtime.
> > > > >
> > > > > Measure the hash of the loaded policy by calling the IMA hook
> > > > > ima_measure_critical_data().  Since the size of the loaded policy
> > > > > can be large (several MB), measure the hash of the policy instead of
> > > > > the entire policy to avoid bloating the IMA log entry.
> > > > >
> > > > > To enable SELinux data measurement, the following steps are required:
> > > > >
> > > > > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> > > > >    to enable measuring SELinux data at boot time.
> > > > > For example,
> > > > >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> > > > >
> > > > > 2, Add the following rule to /etc/ima/ima-policy
> > > > >    measure func=CRITICAL_DATA label=selinux
> > > > >
> > > > > Sample measurement of the hash of SELinux policy:
> > > > >
> > > > > To verify the measured data with the current SELinux policy run
> > > > > the following commands and verify the output hash values match.
> > > > >
> > > > >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> > > > >
> > > > >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> > > > >
> > > > > Note that the actual verification of SELinux policy would require loading
> > > > > the expected policy into an identical kernel on a pristine/known-safe
> > > > > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > > > > the expected hash.
> > > > >
> > > > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/ima_policy |  3 +-
> > > > >  security/selinux/Makefile            |  2 +
> > > > >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> > > > >  security/selinux/include/ima.h       | 24 +++++++++++
> > > > >  security/selinux/include/security.h  |  3 +-
> > > > >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> > > > >  6 files changed, 149 insertions(+), 11 deletions(-)
> > > > >  create mode 100644 security/selinux/ima.c
> > > > >  create mode 100644 security/selinux/include/ima.h
> > > >
> > > > I remain concerned about the possibility of bypassing a measurement by
> > > > tampering with the time, but I appear to be the only one who is
> > > > worried about this so I'm not going to block this patch on those
> > > > grounds.
> > > >
> > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Thanks, Paul.
> > >
> > > Including any unique string would cause the buffer hash to change,
> > > forcing a new measurement.  Perhaps they were concerned with
> > > overflowing a counter.
> >
> > My understanding is that Lakshmi wanted to force a new measurement
> > each time and felt using a timestamp would be the best way to do that.
> > A counter, even if it wraps, would have a different value each time
> > whereas a timestamp is vulnerable to time adjustments.  While a
> > properly controlled and audited system could be configured and
> > monitored to detect such an event (I *think*), why rely on that if it
> > isn't necessary?
>
> Why are you saying that even if the counter wraps a new measurement is
> guaranteed.   I agree with the rest of what you said.

I was assuming that the IMA code simply compares the passed
"policy_event_name" value to the previous value, if they are different
a new measurement is taken, if they are the same the measurement
request is ignored.  If this is the case the counter value is only
important in as much as that it is different from the previous value,
even simply toggling a single bit back and forth would suffice in this
case.  IMA doesn't keep a record of every previous "policy_event_name"
value does it?  Am I misunderstanding how
ima_measure_critical_data(...) works?

-- 
paul moore
www.paul-moore.com
