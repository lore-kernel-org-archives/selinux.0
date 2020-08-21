Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337EC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E87720578
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zoXS+GZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgHUNqp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgHUNoS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:44:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778EEC0617BA
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:43:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w2so1446309edv.7
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThqvJPVAt1k40pAXNs/4MJKb4e62gPXaTQ23UtAvrFU=;
        b=zoXS+GZHOSUhxBOaFtvSm0cRAQyQWOAk0zO78DhJxL4g7QbXnVliajOCWf6dc1d1bl
         x+oK2pRZ/VTVTZuSbWnFciazhGq+8ZgoNE04pdkiSIsozjkfWSmIgLn7/vZ5IOu3GjYf
         db7LJWCE36bApiJXHmhknJ0IKOhI5o4jT/EUK9uYZfCKfn5nmOwwFd70zjXtmakG91tl
         /p8dsffnqTwZAotrhotLd2mV6Yr/4twEKwTMaoXh03IlnvYl485e2qtoMkVlPXUNtXAb
         T9XvR9RWx3UVLTltIvce1tIopRFMtkpfC8vdo4gfEamXcHnv86IhgOqxQrpXry+aXaF3
         mMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThqvJPVAt1k40pAXNs/4MJKb4e62gPXaTQ23UtAvrFU=;
        b=PmgVGEJlW8dL+fp4z5MsNthdMuPlEq1W0WVbaphdvMjuXROVj2AqMHvkVigCrZ/ddt
         HLmCuwKqTcPfbQQg2EOvE5ktjEbBRSB6Yx3M4ukZVofEOe6PbcffISwYoNJIi9RNQIYG
         5szeEJ6NY7RXjGaAjEnFFpxxPMlh3T/nU+o+O5hWrEcFRrMibzWt8C9Hlze3EaHzDOtm
         pg1hhqNehs69md6s3l7h1IVfFNVSwGAMy4ZGsk0ZE7AvbcOfFAvMoDa6oa1CAog6OCsS
         B+SgCUVQvQmK0Vxa9ptduwoQdHaAAzvIKYUsdu+GdCf4lWL7yf9+vzUNESMsaMWZpWwW
         VgIQ==
X-Gm-Message-State: AOAM530u+bzE3Mzlsmjho4D9EetAKSb7sJE1ayXs4IFnVxHGMbcahsUG
        SQEskqRGy+nWNed/K4Ji8ztV2BrGnpp/4S+YDng8
X-Google-Smtp-Source: ABdhPJzfXGGBBlnrtjP+kIEMmpJM+BHFPNrRyhFTTHkds09zaAYZz0htWNuYUb0v7KEh1R7P4qnO6LqobkBFlB+IVFc=
X-Received: by 2002:a50:d809:: with SMTP id o9mr2799575edj.12.1598017437083;
 Fri, 21 Aug 2020 06:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-3-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-3-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:43:46 -0400
Message-ID: <CAHC9VhRR732OE7rkQ+QQe4J-z9ygfS=GD+U_5=9Pj2CykuAr1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] selinux: Refactor selinuxfs directory populating functions
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Make sel_make_bools and sel_make_classes take the specific elements of
> selinux_fs_info that they need rather than the entire struct.
>
> This will allow a future patch to pass temporary elements that are not in
> the selinux_fs_info struct to these functions so that the original elements
> can be preserved until we are ready to perform the switch over.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 45 ++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
