Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5733C48BD1
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9609961376
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFJXOi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 19:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJXOi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 19:14:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F481C061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 16:12:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id og14so1624446ejc.5
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yh7YmIhhDhgO3FRd122dym3nUhDCuVy+timO61yumYY=;
        b=BadaaN4YWT86S73OGUJYIKf63c0B7l705SpU8NEYCmYoPLHkSVVS8d2dN2JZ8pk+NR
         z7fMqCxHdudF5q++sbV7e2WMBrIV/Te0L3+lrAilewak1cCfDI1t36WnuhOQ81UCSYFS
         0nuNt/gGSgi9x2Bunz7oizPH8TVzAixeJ1N0shL5SQAnEYOLPJUk7XkcwqnL5X6C/jYB
         d1gVC9tqeqHdzH8/NDkmn/bF2xclZIiVICH2ijZtzGD0q7ZoXAs8rxZO7oHC0w7EKyGt
         WgMIQXRDf1w35etkBPJf9+rb73IxS6Mj27gLKhRJxHflaH9vAOBqSCoNLU5NyENYUWS0
         hGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yh7YmIhhDhgO3FRd122dym3nUhDCuVy+timO61yumYY=;
        b=Ib8Bl0Nv6KaYnh31ltngio+MMPcP5t0gLrIP2mGkhPGd9jUyXTElGgFvE3UJyewAKi
         W6+4CJ6EhjtGf+uXZ/mWd28mdF/7KUcZyX7f/VnqmDB60O6yxvw3GbPW/XKyOfBKzxHR
         BYleKiLPhEhkX9ul7OOu0JuA2JOk5H89xYs0Kuq9nt26OB23uennRt948GIKsyKuUCm5
         bGWTwgwGQrIxVK9dyXP+SpH+m6rXnTHZVhZyYcNhHYHM1GVxN4inWctVNVllQTpvVZ+b
         AEtbTpOJg8rSAhjDYXlmkC2snZzIa1wW8qpolXAyv3TCfgc9bmGEHRY+aG5Boo20VGya
         M2fg==
X-Gm-Message-State: AOAM533A39y7HRY6DIl9nByaL9G3eVKOHSMlVLYiDsT3xE0WhBuwrfHX
        8DZ1+cOVihG1ski6nORIz+VXiAr8/kIfhPUu5sQ/
X-Google-Smtp-Source: ABdhPJwrNqmMgzKqV+GB+8a5CsDoNss5D9UgkTE0MxxMW6/s2ozD7v/VrNtJzCgD7p0vyv2zqGHxSiiBRIhXOSudy/g=
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr792018ejc.178.1623366746775;
 Thu, 10 Jun 2021 16:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
In-Reply-To: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 19:12:15 -0400
Message-ID: <CAHC9VhSo5wPdqyZ2i9rWgZJhRCw3jv7aNuUFZBwJysFpAW7Drg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 11:51 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [followup to dump_common_audit_data() changes from this winter; in vfs.git#work.audit]
> Does anybody have objections to the below?
>
> From 663a40ab49308b5acaba8a335190fce66e17d969 Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Sat, 16 Jan 2021 15:40:54 -0500
> Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
>
> dump_common_audit_data() is safe to use under rcu_read_lock() now;
> no need for AVC_NONBLOCKING and games around it
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/avc.c         | 28 ++++++++--------------------
>  security/selinux/hooks.c       | 13 ++-----------
>  security/selinux/include/avc.h |  4 ----
>  3 files changed, 10 insertions(+), 35 deletions(-)

This looks okay to me, thanks Al.  If you want to fix patch 2/2 I can
pull both into selinux/next.

-- 
paul moore
www.paul-moore.com
