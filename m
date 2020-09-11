Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8EC433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0DB221E7
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lSGGTTm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgIKRT0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIKO6U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 10:58:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A6C0612F1
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:57:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t16so10264996edw.7
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKC+gNwgspIfV1+PRn/iKXM/L+3ttNO2iqRjPIJ/Rmk=;
        b=lSGGTTm3IiuSp2zb5iB8uB9L+W2r28UxyljwBoU9xWOsoI6LGuwQTWC1t9yomQMK+P
         blr65CBG0/03eLdzR1EnYxJI6I6daj1fIeGYz4Fw/jKvhT6OLp26weFOFF76ISw3KiOy
         nSDMNklAv0iKTZJzGsqFhm9J7D5Kb26t7AG82rjaXGHxUoa/WdU04JncJkMzYyBglnso
         NnlozLUxM9+AIGnC6tQIuifM0HFOk6NjSKsFJCC2BDb/ZO9yBKiU4EarwUGFAuUDEbY1
         8sdFL1FjDY4NfV/G9n50qFt7K73zDvIJxiZXWjJmWEb/ZQxlNRiPggSgJTJVjhygDX+y
         wyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKC+gNwgspIfV1+PRn/iKXM/L+3ttNO2iqRjPIJ/Rmk=;
        b=OzQQtCUazEEHK+bSQr0u0JQRslcUSo8v00YeM4r4oUNhfk2SdL2B7KmJzHP3oouzC/
         G5DPzXHXk9kF7H4nyhGLmILH9edeWvbmYumww8VmB2ZyvQNQZEbJrxxZYwVdEw96Wivk
         OXv3iwaHUayxcnARLHZ4773wcgRZsnS5qANFUpM4Ew5SSkG+CWQI9MHk6jP9ZAX0VZ+T
         WSM/X7+AXAzb7maT1HhA4dfyp8i6JmHVg9/qSDJFKObEkwvL7S0QOXimvn49bFnD1rRW
         ZI0Njags39YJ1Xt3+OLB/qaRE81jOJnmUvtzzByLvLFW7O+W1aWqTgANcJCWFJYAxSbQ
         SFmg==
X-Gm-Message-State: AOAM532SP7eudNQmCICSkbbJw+rOs/NxgKGBbb1cIncpVP8cLo+VcUz5
        df5jx4hr/zT5OKmzIMIKvksevXWVZT+5ivfi8E7+p0iWNg==
X-Google-Smtp-Source: ABdhPJyb2CalVwe/LqSZK9fHIayLaqqaKw3hOQ+LG0XTxUR1PLv/3VbElwAM6fb8k59fDrBZ7dSZLcsDrWDrvGUqLBE=
X-Received: by 2002:a50:fc0b:: with SMTP id i11mr2398891edr.164.1599836239378;
 Fri, 11 Sep 2020 07:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 10:57:08 -0400
Message-ID: <CAHC9VhRaCC4Cn2GcgqeXDML6Lgxpwn5JahffPD1dmFLz0_VB0w@mail.gmail.com>
Subject: Re: [PATCH 00/22] SELinux Notebook: Convert batch 3 to markdown/tidy up
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 9:30 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Converted to Markdown or just tidy up formatting. Added TOC to aid
> navigation where required.
> No text changes.
>
> This is the final batch of basic changes that should bring the sections to
> a standard markdown format. The reference_policy.md update to tidy up the
> formatting is large so I'll send patch direct to Paul (no text changes).
>
> The only two sections left are: lsm_selinux.md and mls_mcs.md - These
> require moving and updating text to convert to markdown, will send
> each separately.
>
> Richard Haines (22):
>   kernel_policy_language: Tidy up formatting
>   mls_statements: Convert to markdown
>   object_classes_permissions: : Tidy up formatting
>   policy_config_files: Tidy up formatting
>   policy_validation_example: Tidy up formatting
>   postgresql: Tidy up formatting
>   security_context: Convert to markdown
>   selinux_cmds: Convert to markdown
>   selinux_overview: Convert to markdown
>   sid_statement: Convert to markdown
>   subjects: Convert to markdown
>   toc: Tidy up formatting
>   type_enforcement: Convert to markdown
>   type_statements: Convert to markdown
>   types_of_policy: Convert to markdown
>   user_statements:: Tidy up formatting
>   users: Tidy up formatting
>   userspace_libraries: Tidy up formatting, add toc
>   vm_support: Tidy up formatting
>   x_windows: Tidy up formatting
>   xen_statements: Tidy up formatting
>   xperm_rules: Tidy up formatting
>
>  src/kernel_policy_language.md     | 106 +++----
>  src/mls_statements.md             | 461 +++++++++++-------------------
>  src/object_classes_permissions.md | 299 +++++++++----------
>  src/policy_config_files.md        | 442 ++++++++++++++--------------
>  src/policy_validation_example.md  |   3 +-
>  src/postgresql.md                 |  19 +-
>  src/security_context.md           |  83 +++---
>  src/selinux_cmds.md               | 256 ++++++++---------
>  src/selinux_overview.md           |  33 +--
>  src/sid_statement.md              | 119 +++-----
>  src/subjects.md                   |  21 +-
>  src/toc.md                        | 120 ++++----
>  src/type_enforcement.md           |   9 +-
>  src/type_statements.md            |  33 ++-
>  src/types_of_policy.md            | 359 +++++++++++------------
>  src/user_statements.md            |  10 +-
>  src/users.md                      |   2 +-
>  src/userspace_libraries.md        |  58 ++--
>  src/vm_support.md                 |  84 +++---
>  src/x_windows.md                  |  52 ++--
>  src/xen_statements.md             |  16 +-
>  src/xperm_rules.md                |  28 +-
>  22 files changed, 1223 insertions(+), 1390 deletions(-)

Merged, thanks Richard!

-- 
paul moore
www.paul-moore.com
