Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3AC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CD72177B
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8cP/sBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgHZNoB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgHZNnO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:43:14 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBF0C061757
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:43:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j18so1543661oig.5
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPf797q/OX5S3T912Bb33dqkjGSU8G2/a6Y3Tc2W6EA=;
        b=K8cP/sBlYC+KSqY6k0k+G8DGq9sxZs02RCkM8mLsVVDmI0cfMofi4GGKUyD9eIImNC
         SQRzWoXcDBvcc467mpizyCww5NOpdmsn8I860HuO6qjvg7fdBUESOf2CnTEKW6FwEBg+
         feYTJf+OvqO9SPZXefMlUuT/SLE8rRt6m0q6NY2YwdLUDw/FZh4W9kALulPdBMKyhR7i
         r9aWqI9t/d0e6KanBsAQb65SXWe9gdw/HtDdE2jFKrN/nwo9efamHyeinhcP+ZatAD6S
         mrCBBzrperjYDVTM/bszGTBpN49z3unjzaQPcl4sjMHvsnAw77tOau9mhGkZ9Ffa8BAl
         QQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPf797q/OX5S3T912Bb33dqkjGSU8G2/a6Y3Tc2W6EA=;
        b=XcMHk7hOFd8Pfg1EeWGA51dsPL5JOA0QLpTu1I8jcqZ+453sD0BMudAzLM1wZ7EoVV
         BUrXpq/2X0x63o71uJr4p5a/xclT8MYHr282vn6eK/6vU2zBUSDLadqFVcNwlF+qW+qT
         frOBV8cO9/anZ3xYuc5h/H7c7NyqtjuBSHIC+pTQQVM08VVylbwNsjIMESJzs3iDqyBb
         GPqRVC2QcKvGjn9vwDKLyhK20CO81SJmWoqxptCZtdSBWr5yS+yydPzFGU1R/toc5/ff
         tFKhTCxgTvt43SlM3uhm5cZm2v7p5pKWvR30SxuGQNHtHWjBLRXSdOC7jNDRq1LG3sZV
         yvBg==
X-Gm-Message-State: AOAM532+ch/rVsq4lsAxiIaz52WJIqGk/yrdAtZlwXSGiy6JTq/KJjVy
        DK5qgi+zSmmWUzD1bRAwA3eS/LZEhbe0NNQfMHc5i4WE
X-Google-Smtp-Source: ABdhPJzaNfcsDR40pWXvYTM2mjwkYDZjJMKUoDahsIdqsfZk/Bk2OvOBTJ5qCQO0IASuL6+tKpwsytBLWXBzUb6dBU4=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr3766330oic.92.1598449378212;
 Wed, 26 Aug 2020 06:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
In-Reply-To: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 09:42:47 -0400
Message-ID: <CAEjxPJ7vQNwY3adO38tp0_PvmusbmeDX=s02vrJzyT+Epa46Wg@mail.gmail.com>
Subject: Re: Userspace AVC auditing on policy load
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:26 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> I was looking into this dbus-broker audit message, which has the wrong audit type:
>
> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295
> subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice
> (seqno=2)
>
> This is due to dbus-broker setting their avc log callback to send USER_AVC audit
> messages for everything that comes to the libselinux log callback. I think the
> right thing to do there is to change it to emit USER_SELINUX_ERR audit messages
> if the log message is SELINUX_ERROR, otherwise log the message using their
> regular method (stderr I think).
>
> But the question became, why is the userspace AVC not simply emitting its own
> USER_MAC_POLICY_LOAD audit message instead of sending a message to the log callback?

IIRC, the original userspace AVC support predates audit and the intent
was for the application to deal with dispatching messages as desired
from its callback, whether via libaudit or via syslog or whatever.
Not opposed to revisiting that but it would require some care, e.g.
not sure you'd want both libselinux and the application calling
audit_open().
