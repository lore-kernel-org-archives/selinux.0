Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6CC433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320CD2078A
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKU+f12C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHZSvz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZSvy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 14:51:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78886C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:51:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l13so2373331otp.10
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IEwhvKAuGi0S5I5oG7N/TWrvTLqaXwjCh/Byspqu7U=;
        b=SKU+f12CgrdxbhgrKp/2WOJzSJ1vwb4q9D7J9GNrhZ3fM17JBg4dHP7c1UJYP8lUcx
         Kg2jIS4MGReAQHNZl3pkP0KvN+JeCqUgdS2FPa3jPqF8mC48/wWTs0WxHF3mmrRMLBkf
         4P/ZhdO0q8sAYaH/hzGNHT6snZKoQ/0vPfEn2dRxWkwfZDdDuR7pkPEqVV1m1jHCeB2q
         Y9FPJh28GS0mtRFk8xPA3iKZ2F0BO9SfFThBBw3CykMYn6W4ZNwLnHPrPvE1l1fhF5f3
         qQhlGw+E6GzUT2KPomY4Hdc0U7UjdG+Q0C5tpqnwQzZSPT68Ne14icVZazeaSQ0dtBau
         pSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IEwhvKAuGi0S5I5oG7N/TWrvTLqaXwjCh/Byspqu7U=;
        b=SKhsfAq7jKuIJjxgoKuhH7NPSHwDtFlopghDV57ABbBYEVtn7GF8smLOtkf+KBlYy9
         GLA9CSX9rS+JBdF0G9kIeA7MI0/GMudZrz93pXU91JhTiSpMTozgZNjsN9KX0OQ3CveZ
         zHGQQ+W8WkU6V0l47ydpqLvYZ2BQQuJUyRSuMp4oT66OD4nqxpQOPDJFOIcJ68u75OrA
         yc3Zf8WEIaV9dalnpwjNcY+aNNa1VT74fRY0nx8k4WnaL5Jf+H2oRrvL+vninESvly+C
         vnlxp1v6wj8iUK/gGbIPRSQMfFC2zDzwj39M44xN6L0vr0oPIU8yW/decBKQJo43Ewdq
         oUpw==
X-Gm-Message-State: AOAM530jTc5yI4OQIO8TyWjVO61EvBWbV+SFlpBctoZFc1R2/+opg9ZB
        FXljjHACfkU4nF22cWKAJs53+Yf54neck7hsOMM=
X-Google-Smtp-Source: ABdhPJz1uV846qYwJ0134vOKX0UCAz7t2HTzN1lS/UFGFKdkHDCr/oVobVFfPBBcEPJ6VX8hdJVmKuhOzHZeanOAZws=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr10340492otr.89.1598467912482;
 Wed, 26 Aug 2020 11:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
 <e4cdec2a-8c01-fbe4-cba3-3468b4ebea2e@linux.microsoft.com>
 <CAEjxPJ7xrzm6GQUxckRgVot082xZtabV-RZzv0E-Orfq7y_riQ@mail.gmail.com> <2b50e8f1-08ef-0868-4a2e-dfdbb61ed5ea@linux.microsoft.com>
In-Reply-To: <2b50e8f1-08ef-0868-4a2e-dfdbb61ed5ea@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 14:51:41 -0400
Message-ID: <CAEjxPJ40vOC+608GEBAij5UpkD8xJw2FBZk-2OkvKpKiEEkz6Q@mail.gmail.com>
Subject: Re: Userspace AVC auditing on policy load
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 2:28 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> On 8/26/20 10:46 AM, Stephen Smalley wrote:
> > On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
> > <chpebeni@linux.microsoft.com> wrote:
> >>
> >> On 8/26/20 9:25 AM, Chris PeBenito wrote:
> >>> I was looking into this dbus-broker audit message, which has the wrong audit type:
> >>>
> >>> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295
> >>> subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice
> >>> (seqno=2)
> >>>
> >>> This is due to dbus-broker setting their avc log callback to send USER_AVC audit
> >>> messages for everything that comes to the libselinux log callback. I think the
> >>> right thing to do there is to change it to emit USER_SELINUX_ERR audit messages
> >>> if the log message is SELINUX_ERROR, otherwise log the message using their
> >>> regular method (stderr I think).
> >>>
> >>> But the question became, why is the userspace AVC not simply emitting its own
> >>> USER_MAC_POLICY_LOAD audit message instead of sending a message to the log
> >>> callback?
> >>
> >> Ok, I missed that there is a SELINUX_AVC log type and that's how the userspace
> >> denial messages are sent out. How about adding SELINUX_POLICYLOAD and
> >> SELINUX_ENFORCE log types so that callers can emit appropriate audit messages?
> >
> > Do we need two different new types or just one?  Otherwise, I don't
> > have a problem with adding new ones as long as it doesn't break
> > existing applications.
>
> Regarding the risk of breaking existing applications, I did some checking on
> some userspace AVC users and what they do in their log callback:
>
> * systemd only audits SELINUX_AVC and SELINUX_ERROR messages and ignores
> others(as Petr noted)
> * xorg-server audits SELINUX_AVC correctly but audits SELINUX_INFO as
> USER_MAC_POLICY_LOAD and everything else it ignores the type and audits as
> AUDIT_USER_SELINUX_ERR
> * dbus-broker ignores type and audits everything as USER_AVC
> * dbus-service ignores type and audits everything as USER AVC
> * pam: pam_rootok ignores type and audits everything as USER_AVC
> * sepgsql custom AVC implementation (this was news to me)
> * shadow-utils only audits SELINUX_AVC and SELINUX_ERROR messages and others go
> to syslog
> * cronie: no callback set
>
> That's all the ones I could think of.  Which ones am I missing?

Short of searching for everything that calls avc_init() or
selinux_set_callback(), I don't know.  Android defines a common log
callback via https://android.googlesource.com/platform/external/selinux/+/refs/heads/master/libselinux/src/android/android.c#236
that funnels everything except for INFO and WARNING to its error stream.

Sounds like introducing new types will do no harm with the possible
exception of XSELinux and that's rarely used.
Certainly won't break anything.
