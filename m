Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42347C433E2
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EBB206FA
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="upx0S07n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIARIU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgIARIS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Sep 2020 13:08:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B23C061244
        for <selinux@vger.kernel.org>; Tue,  1 Sep 2020 10:08:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p9so2728145ejf.6
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2020 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6cczcV+qYwYN/L1C8I9qcBQe5EFjY6WaywdUE68eFQ=;
        b=upx0S07nr2W143gE7vWUuUXhRp8qjGMk2SBqC+2svfij/lGN6pQwsA+SbRlY03vsEo
         jsth025nkWXiigbiwyuKP/v8TBy3+MzsPhzbR/d1bAV9lAyFR9W9WI12620iQNg4V1hs
         +D4tsKrUuM5DU3LfQspr4tWVNiJaza5r0me4dyVrbxF7IyBHraCou979A+JsjsiJZ4Qs
         koUgOrsWFYeXHWFJBF4eC7iGtN9cP9JK6u4zNuio4M37zM//qOJ0Xs054yQ/RyvBETI+
         jYavxCHJa4dYsEBqd8Djk1Np8lU9yrHVkXfy2wyMFcqjRJCewC1eez5QboWcHObOyzCr
         xB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6cczcV+qYwYN/L1C8I9qcBQe5EFjY6WaywdUE68eFQ=;
        b=AaHs9tuox9n0dFTWB2GCFSFPmH8QPPC9oG4LTOpq3n3t/aSorw4rBr/i8us2wE4JwN
         BzKuml10UTCp/Lmkbr6LJ2gq01+QUw+0n8XyV3sw2uoZiNUA/EcrnfEtwQDdIla9h9bz
         B2EE6+c8mog+a/YsP6g/UsPzQPIgYTzGXuw7m3vCfUe6GC7x/UL53Td8lwKmEzzJZfn9
         b3hURoT+JuxiIEUkToYlkGNhUFrpu2lyCSXCV1GTvVoKPPXhpRmy3Wu04an5wMEt5Oqu
         CZt79hrxLth1/d0/ILEuRyCn1Ra8YFhyAzW9JdQQ/Fq5nM5P+J5POCl5k6RTo4N6rA+u
         sHpw==
X-Gm-Message-State: AOAM531UUN1WMmPPOONOxJQ3VOpYAQ8dMmZFcKKi45ierEpsU46UrM61
        krb8Op+7RRqJtasXCn0rPqMR9eYreMv0cbSCUPkk
X-Google-Smtp-Source: ABdhPJynuACeqT7PVfe5w5y2cYG2i4LKCRcJ8ZpZ4D0tOJ/w4zkbXlMKpQfT37MZhJE6JzN7xcWHAjqk1fiZPgxIQDM=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr2375316ejb.91.1598980093863;
 Tue, 01 Sep 2020 10:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Sep 2020 13:08:02 -0400
Message-ID: <CAHC9VhSz2_0f9A+tWx_WC1H93aM_nU-eh97P5MVySa7k3FpP8A@mail.gmail.com>
Subject: Re: [PATCH 00/18] SELinux Notebook: Convert batch 1 to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 4:38 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Converted to Markdown. Added TOC to aid navigation where required.
> No text changes.
>
> Richard Haines (18):
>   apache_support: Convert to markdown
>   auditing: Convert to markdown
>   avc_rules: Convert to markdown
>   bounds_rules: Convert to markdown
>   cil_overview: Convert to markdown
>   class_permission_statements: Convert to markdown
>   computing_access_decisions: Convert to markdown
>   computing_security_contexts: Convert to markdown
>   conditional_statements: Convert to markdown
>   configuration_files: Convert to markdown
>   constraint_statements: Convert to markdown
>   core_components: Convert to markdown
>   default_rules: Convert to markdown
>   domain_object_transitions: Convert to markdown
>   file_labeling_statements: Convert to markdown
>   global_config_files: Convert to markdown
>   implementing_seaware_apps: Convert to markdown
>   infiniband_statements: Convert to markdown
>
>  src/apache_support.md              |  79 ++--
>  src/auditing.md                    | 300 ++++++-------
>  src/avc_rules.md                   | 115 +++--
>  src/bounds_rules.md                |  65 ++-
>  src/cil_overview.md                |  63 ++-
>  src/class_permission_statements.md | 231 ++++------
>  src/computing_access_decisions.md  |  82 ++--
>  src/computing_security_contexts.md | 662 +++++++++++++++--------------
>  src/conditional_statements.md      | 159 +++----
>  src/configuration_files.md         |  74 ++--
>  src/constraint_statements.md       | 562 +++++++++++-------------
>  src/core_components.md             | 211 +++++----
>  src/default_rules.md               | 293 ++++++-------
>  src/domain_object_transitions.md   | 121 +++---
>  src/file_labeling_statements.md    | 260 +++++------
>  src/global_config_files.md         | 389 +++++++++--------
>  src/implementing_seaware_apps.md   | 218 +++++-----
>  src/infiniband_statements.md       | 155 +++----
>  18 files changed, 1876 insertions(+), 2163 deletions(-)

 (!!)

All of the above patches are now merged - thanks Richard!

-- 
paul moore
www.paul-moore.com
