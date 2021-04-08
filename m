Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6EC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 00:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57AB61184
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDHApm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Apr 2021 20:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhDHApl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Apr 2021 20:45:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65583C061760
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 17:45:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x4so298531edd.2
        for <selinux@vger.kernel.org>; Wed, 07 Apr 2021 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENqPj3UzYmU9dR4mCuT+q8bdDDEytSX+67H4C+FWSio=;
        b=nv5OsqZXDoPmRlb7I0UNEBW0vGO5mPPnzg6wpwbtg9voomN7/bA2A4d8HPwLIP2jms
         xXKzaYb4OI3a1loxf8QtmUOsM4q7GsqYyGAP4e5lUi02CzbSFXtU05QB0X8JAuu/n9LY
         5yAYlg9WYOm3iyM8B4HcRLviwLhDVAX36LO/9c+fTi2lgXdLR2rr/vBoegsMu2SOFWHV
         qv2QIe/8HHXhaJtbWbyGtbzFA2x/otdgJ6rzS07wl+riYMFux0O952uLtFWaqHRCwfVg
         0l5zvI+jmICzQzrX6iWmD7MCGsWEhseZEG8rLmh5nN0TFA3oPi9+lJ3RtlTeLm3uidoq
         BaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENqPj3UzYmU9dR4mCuT+q8bdDDEytSX+67H4C+FWSio=;
        b=gCvQqKlUGVX71h0bH0JPM/+4MrBbe/Gq+y/DuzsIO3yCTOKiTirU8wD/1YHWra1Z0r
         5Rd69jTWGq9gP77s9pLFujdjidecSuKcFHTvGjd+wb115Y6XBw5tbIX9RuWsBqkAJIbQ
         naiEl7aFsGJCOD/JkCFcg1HoQWk+sKfkCzLozGnihZdhdasrAZp1ybKMAO+Rjos9sLF/
         WhiiagVOsxW2K71Rh58bdDx8S8/byJhwFcgvyJoWVf5akG/MSMwCnGhfExRzutKwCnUa
         Z+OTd7UUnK4g+tQxZfJjqOaSnfDxd/CuChaIZfp748hhc5FpPut7EpXq5+9Wu8KAmQJs
         yd/A==
X-Gm-Message-State: AOAM5306+t53+KxKzaFPVRLA+fLaFv62Au+TGkbqmPgfZSEEscLakWs4
        qzc1anLIQESck/2gvEojiiM+vyKp5G+JMK1+5twK
X-Google-Smtp-Source: ABdhPJy/wSOjb1Mf1ayYp+rXHMqCqGbP6GFfvvhC+xHyOCkblyBJ/APCx9hMy/kSRIH5RqAFL9F6VUj1PDec4qBpTrI=
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr7788423eds.31.1617842729908;
 Wed, 07 Apr 2021 17:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210407072443.2698107-1-omosnace@redhat.com>
In-Reply-To: <20210407072443.2698107-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Apr 2021 20:45:18 -0400
Message-ID: <CAHC9VhQojuT_spsvE=Bfi1-4qWKRXyqVWnKOo1tvJNQzcXuJoQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: fix race between old and new sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 7, 2021 at 3:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since commit 1b8b31a2e612 ("selinux: convert policy read-write lock to
> RCU"), there is a small window during policy load where the new policy
> pointer has already been installed, but some threads may still be
> holding the old policy pointer in their read-side RCU critical sections.
> This means that there may be conflicting attempts to add a new SID entry
> to both tables via sidtab_context_to_sid().
>
> See also (and the rest of the thread):
> https://lore.kernel.org/selinux/CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com/
>
> Fix this by installing the new policy pointer under the old sidtab's
> spinlock along with marking the old sidtab as "frozen". Then, if an
> attempt to add new entry to a "frozen" sidtab is detected, make
> sidtab_context_to_sid() return -ESTALE to indicate that a new policy
> has been installed and that the caller will have to abort the policy
> transaction and try again after re-taking the policy pointer (which is
> guaranteed to be a newer policy). This requires adding a retry-on-ESTALE
> logic to all callers of sidtab_context_to_sid(), but fortunately these
> are easy to determine and aren't that many.
>
> This seems to be the simplest solution for this problem, even if it
> looks somewhat ugly. Note that other places in the kernel (e.g.
> do_mknodat() in fs/namei.c) use similar stale-retry patterns, so I think
> it's reasonable.
>
> Fixes: 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v3: correctly handle initial allocation in security_get_user_sids()
> v2: reset cladatum to NULL on retry in security_compute_sid()
>
>  security/selinux/ss/services.c | 157 +++++++++++++++++++++++++--------
>  security/selinux/ss/sidtab.c   |  21 +++++
>  security/selinux/ss/sidtab.h   |   4 +
>  3 files changed, 145 insertions(+), 37 deletions(-)

Third time's the charm :)  Thanks Ondrej, I've merged this into
selinux/stable-5.12 with the stable CC; assuming testing goes well
I'll send this up to Linus later this week.

-- 
paul moore
www.paul-moore.com
