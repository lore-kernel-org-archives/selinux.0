Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ACC433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C0610D1
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 21:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhDHVe0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhDHVeZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 17:34:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA6C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 14:34:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so6423983lfh.1
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DFUMBm74akct0btoGst1iCmQ2GYkx7dVKwPq9e9RUAA=;
        b=DY/Mgk8LK5mfus8jy25w4rkj4+fmomrcCZvMxlCxXA9ALJg9bbgj/ueM7Vja0WF5rR
         2RlGM5gct3n/Fqmp1u7knn4R6MYA4uMB62hyvdFMxywtQuAJRAcwM7FS93xCWbC7kQXl
         Ft7M44w6mNwrSOH2YOvFNxvGUOm67KoyVlYH8DGHH1yOpscWgKRT/edeBqVT7NlnaNBn
         rclYJrn9uAP1yPXNZH84zb0YgnLv3upvzsUeNwmK/VXilU8KhUG6X/2D0JHBkUogkrOS
         04oo5PKNN8haAeG/myXaFZ69H9xqUYmbsY3wWyzszh7MFFHy2uLRqeyxi0N+QHqrlXTK
         HX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DFUMBm74akct0btoGst1iCmQ2GYkx7dVKwPq9e9RUAA=;
        b=qmTcTa7oxnQKjyFLFVP9VlrJNlRy9DF0mUJYFB9VZsFp0XLaMMi56M3UUzGhEbYFaJ
         3U4FlQexS2Kl6GtxcmuF/N9Eu3OlyWnybB28gl/jglCBwmZBqSFc1OIaawr7TN3Yo/JS
         ++zlk6n/FOmK7wuARnJm2LlzaZAMOPnLgN7oAy2HkQxVURgJ9491MYH3VbOmieF/AJ2A
         l958fBRY+8gRXryGdVFlkQGeVb9nZJzrpeiZy4ocuApJYUpiSjhXPY3AWe/YTj8fBpVR
         h/t3IUnWsw3E7xxlZvtv2eqoj0tVXo6EDXB/iquTxEsyFcKfvvMifw+LitSG94oUmJ7f
         hfXA==
X-Gm-Message-State: AOAM531p1fmK/VqsHwCiTddTIPyfLuOnAFZlfsouZB48WnKdbRsxubLG
        kQIasNp5u7B7y07c/9vd/AgDVas4hNZegbloB1cWPMlwMsICdg==
X-Google-Smtp-Source: ABdhPJyGoWCSdpsLqHhGuHGv/snUc5NLgfa7mTDRtyv2Z6Lm3TeIg9rlzUEe73MxZafzbq2P/W4NPEMW069YDfJqEko=
X-Received: by 2002:ac2:41c4:: with SMTP id d4mr7701744lfi.334.1617917652178;
 Thu, 08 Apr 2021 14:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAL6HQvHN+9pp8+h0kqf9mJAtYS6_ZQvVE2JNkk3QqqUveXiTzg@mail.gmail.com>
In-Reply-To: <CAL6HQvHN+9pp8+h0kqf9mJAtYS6_ZQvVE2JNkk3QqqUveXiTzg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 8 Apr 2021 17:34:01 -0400
Message-ID: <CAEjxPJ4gsSGNO2BBJ27Oogf=dFGrABvvLrNbgmrN_2UNCJzxpg@mail.gmail.com>
Subject: Re: Detect SELinux by checking if policy is loaded
To:     =?UTF-8?B?S2FpIEzDvGtl?= <kai@kinvolk.io>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 8, 2021 at 2:17 PM Kai L=C3=BCke <kai@kinvolk.io> wrote:
>
> Hello,
>
> to detect if SELinux is disabled, in version 2.4 there was a check for
> /proc/PID/attr/current to have something else than "kernel" as value.
> This allowed to distinguish between "Disabled" and "Permissive" when
> the filesystem is mounted and the /enforce file has the value 0.
>
> That check got removed in later versions and a check was added based
> on whether /etc/selinux/config exists.

These were commits 685f4aeeadc0b60f3770404d4f149610d656e3c8 and
c08c4eacab8d55598b9e5caaef8a871a7a476cab respectively;
the commit descriptions provide the rationale for the changes and the
associated bugs.

> This leads to two problems. The first one is that older versions which
> have SELinux disabled in the config file still have the filesystem
> mounted (unless selinux=3D0 is passed as kernel param) which causes the
> newer behavior to think SELinux is "Permissive" instead of disabled.

That shouldn't be the case; selinuxfs is unmounted by
selinux_init_load_policy() if SELinux is disabled in the config file
too.

> The second problem is that the existence of the config file is only
> loosely related to whether SELinux is disabled or not. On one hand a
> recent change of the config file (creation/removal) is not valid now
> but only after it got applied, e.g., by a reboot, on the second hand
> the check does not work from containers.=C2=B9

It is true that the existence of the config file is a weak indicator;
that check was only added to address a particular bug where systems
had no /etc/selinux/config and expected SELinux to be treated as
disabled.
With respect to containers, the Fedora / Red Hat approach in general
has always been to treat SELinux as disabled within the container so
that userspace within the container doesn't try to load policy or set
labels.
The entire container is run with a single security context.

> I suggest to drop the config file check and replace it by a
> /proc/PID/attr/current check which is more reliable because it tells
> something about the current state and works from containers.
> What do you think?

This would essentially be a revert of the prior two commits which
would seem to re-introduce the original issue that was being fixed.
