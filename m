Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B49C433ED
	for <selinux@archiver.kernel.org>; Wed,  5 May 2021 10:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F587613C7
	for <selinux@archiver.kernel.org>; Wed,  5 May 2021 10:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEEK7f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 May 2021 06:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhEEK7f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 May 2021 06:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620212318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eVZxETJuG4ix7xHFzjgnIz8Efp0aN5fvWnhjs+O0we4=;
        b=eJCKQU+QofxKtMgLl5V9XI9P7hkEZ1Z05v7G0UxXVvpSYeiwTK41kiC6CSSV3l6t2KgdDu
        /3zAHKMvXlelPaLmlTTH6oALgABihdQNtknhuAYnlS6bx1/839OtB3gnqGUeBkEBW2dZRG
        YL6rCGNz5ctdRWOnnSTjAXmY9VB/rmI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-FAp4QcNFOL-78rxqMtjGhQ-1; Wed, 05 May 2021 06:58:37 -0400
X-MC-Unique: FAp4QcNFOL-78rxqMtjGhQ-1
Received: by mail-yb1-f197.google.com with SMTP id j63-20020a25d2420000b02904d9818b80e8so1830789ybg.14
        for <selinux@vger.kernel.org>; Wed, 05 May 2021 03:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eVZxETJuG4ix7xHFzjgnIz8Efp0aN5fvWnhjs+O0we4=;
        b=S3P40n0tJfgNSAz+8ayRJbO6nfegfds7E0wDpTVRHALVSj+fSpBQ08h1mxBY8oPnGZ
         zlDT3XLQvbW9GMOw6Nh3LxBBYvaw7APbHJCKkUe5K+1IVBzAe87ZplxWcBDo4wMNheGv
         3noFi67iBBpO+heiwJ0IXtZTPN6ZjcOmaUXSWlI3myEeBhbwULTeyWXgRMDKC4L3S+q1
         GYtnHYNoS+1MTkTi47cN0gWFpzpH/BHVew7iEP3R25qMLPcp6dl/CG/DQ2D6lNtGa5vG
         J/sp65+h/FJgUgtv/v4yWoWbHnKMvxg8JftkYwbQNsRtmVGJiQNVLBXoipCkCU64Tfsl
         O3ZQ==
X-Gm-Message-State: AOAM533O3seABXBzoaOH9E1lAhtEa9WQBviwbXjWCXbFVEhzTvo8M2kz
        uU3SMcvk2CQYEw5e3QzoBASiMBjeyDF7QZDSWqnHLfYBWYbvgSHdSsum47iQ3qI96wH6vJIEnXb
        vRtW2FIaLXZ//lzfV/pnn/AwbguaefiK8UQ==
X-Received: by 2002:a25:6983:: with SMTP id e125mr32445011ybc.81.1620212316679;
        Wed, 05 May 2021 03:58:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXIY0ZJN0SM+xk24P20iM3/ySkzqOpDoii2yKz0bwuiZlKDJfgHhLNy3eOMJm8/1fDtijuxQ68c4t8NHZtr/E=
X-Received: by 2002:a25:6983:: with SMTP id e125mr32445001ybc.81.1620212316544;
 Wed, 05 May 2021 03:58:36 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 5 May 2021 12:58:24 +0200
Message-ID: <CAFqZXNvt-ezC2hwLC1zOVfgkRwd4483=dXw3k2ALkuRYfR4okA@mail.gmail.com>
Subject: Stable backport request - perf/core: Fix unconditional
 security_locked_down() call
To:     Linux Stable maillist <stable@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

please consider backporting commit 08ef1af4de5f ("perf/core: Fix
unconditional security_locked_down() call") to stable kernels, as
without it SELinux requires an extraneous permission for
perf_event_open(2) calls with PERF_SAMPLE_REGS_INTR unset.

The range of target kernel versions is implied by the Fixes: tag.

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

