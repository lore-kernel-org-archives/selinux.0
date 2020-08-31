Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28074C433E6
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFA620936
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Y0heAMXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaOEL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaOEL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:04:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9DC061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:04:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so7251648ejb.4
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dc7vjlumv0zlRiX4DwbfgwGPyHE6Y9M0btAHUipbgU=;
        b=Y0heAMXPkPlGGtKjjdkPQRLbI6g3GVSyjelaKta2TY5jPfu9j1tdh9UHNDNvE3dxsh
         0Y8Wl+N1jNq5pKkSTivrHNZAR4RzfBHAo/5BhE64R7TsAmV2b8Dxseq8Q0eKsRVjmzsj
         fl2pjyqJJouG/ncDCkbSfLwgK8KCydAu4VbxN9v909sNTcF3CZCof/BqawEjfBYvUDd7
         N/BVuk0tamqbGRaMlKKuKJ4volHcYLRc1fiorhVidyNfB0A6Eiz28Maxps8/vhIzYLjW
         0HgVepEIXG4mlFd4KNrI17GEGmzffaX6pRiC/XEuE32gVOOksz6h7P3i9t/TBIE2k/Hc
         gm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dc7vjlumv0zlRiX4DwbfgwGPyHE6Y9M0btAHUipbgU=;
        b=e90oQzxMciH6ZpuJN2E+O60jo5B0A84FMlfIoL8mO1wym7v2WST6yjYl2Jri5FCfKY
         pCA9WVtTLX+DYdfU1MXjOTu6bvnJEU4WJxnKDme4Tm32rByzleI+bxaTdftMoDQmxO7P
         3ZE2md/mMtowTBNQWZydcw+Y1HkPEKDqSzn/QDPVf1upTC8SlT9yEHh9FNlQjYANxav8
         p8cbDCwX+JIFkuMMGnnj6aVZQWasYY7HyFM5iRlw0PbabCLA+X8GtGPj9rlG8NO5v22M
         liy+8gFcCQweHyLC6Mmide7UzI5TieNEfzHezmQ2MKLl27kapR8ORXCGCH+U2jL7mGAz
         +b5A==
X-Gm-Message-State: AOAM533AE11md16fV6IdMzYZyfNiLQ+1IaV2EASv7xmFBB40D4aHtB7r
        DSthGVKL1Dd0eLVCIFqOOg9Wq8734G+ksC/Jn+Az
X-Google-Smtp-Source: ABdhPJyenx2/40a6pLqqVk/4av/ugfiPSmE1l4DVlOppXLuVeMdQzevrhMqYj0YI4xbNuwaHakWpKbHArhPQB6XnjVk=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr1291919ejb.91.1598882648852;
 Mon, 31 Aug 2020 07:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200827162753.2089782-1-omosnace@redhat.com>
In-Reply-To: <20200827162753.2089782-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Aug 2020 10:03:57 -0400
Message-ID: <CAHC9VhTkgZ65=xHtkpRWZkNp9vu512g9BoAa8VfEHsYsvDxtiA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify away security_policydb_len()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 12:28 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Remove the security_policydb_len() calls from sel_open_policy() and
> instead update the inode size from the size returned from
> security_read_policy().
>
> Since after this change security_policydb_len() is only called from
> security_load_policy(), remove it entirely and just open-code it there.
>
> Also, since security_load_policy() is always called with policy_mutex
> held, make it dereference the policy pointer directly and drop the
> unnecessary RCU locking.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v3: rebase on top of latest selinux/next
>
>  security/selinux/include/security.h |  1 -
>  security/selinux/selinuxfs.c        | 12 ++++++------
>  security/selinux/ss/services.c      | 27 ++++-----------------------
>  3 files changed, 10 insertions(+), 30 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
