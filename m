Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282BC433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DAA22BEA
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz+QKKma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgH0H3N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgH0H3L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 03:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598513350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XypXWW4qnP5dcgVRUj04HisoZ5jG/ZpKSpwA6C09LzM=;
        b=Nz+QKKmalUdj52SAtbP3NGbOaSY+N7msnPLKlKsNJ3jUIyp6DUKM8cklE4/LlBsT9Y2GCL
        ZJV7V2zbojLMumopIJhYvhHdjiHxoDLMk5B5hrUxrtEN5LvfZMB9neBQgMq1WxBeGhav8Z
        nfrFf9ibYWRr5hp+NMZYHqHzr7+lshs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-g4DVvVJ6NXWG44ZtxXix_g-1; Thu, 27 Aug 2020 03:29:08 -0400
X-MC-Unique: g4DVvVJ6NXWG44ZtxXix_g-1
Received: by mail-lj1-f200.google.com with SMTP id a12so457060ljn.12
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XypXWW4qnP5dcgVRUj04HisoZ5jG/ZpKSpwA6C09LzM=;
        b=A0OsbeMpnclPDKpmCKrGWd5qpmAU/F2Yz3nR8mK66zgD2MYPUY1uZoj9yePsVrXOnS
         bAEOaRlwDhtX4aDJLuvufuuGfDr8ikBVlXwApPQErlH4zKc20D9Sh19CKbEimrgHKKSx
         hDn7kfxrLNnOlgwIUXYlGwilYzMhpr4fEd5rLz26uIUjqSCezT86WWxI8752lW0I/WmG
         Yv09C8V8yA2JB+2TD5HclDLm+V3Lu6IrnlUfREYqt1VJbzHHEyRMJKZKQzRK/Zp7REA1
         PKh+sdFutz9P0aVvrd9VikZAzqq5EDoTeYDNEkeDrvuLxZ4VvWYrNBSPp2UL6CqY5/HO
         howQ==
X-Gm-Message-State: AOAM532lj6OuwpRZ2jhPSP8FjWQz3itS03dipZ/d8UOV+JQn20leIKfz
        fDlxJ0uCHJvAQCA3pLlMhZzWi5qEiB39+XIUY3lh8Nv31gJtpAgqA/LnCO2CqdTptqF3n/D0LWJ
        DF7rXaLKKt4Pm5A4qx/32s1Dqi0vyZ/TUYA==
X-Received: by 2002:a05:6512:3206:: with SMTP id d6mr5034442lfe.87.1598513347055;
        Thu, 27 Aug 2020 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy34jZtQEwKPu3gZrrR/Uo88ZBEEiQJAGO1TJ1HowfhPchfnzttqkZyx3MLFU6QG/pT9RsIw2ZiwkoIXUTO6jQ=
X-Received: by 2002:a05:6512:3206:: with SMTP id d6mr5034434lfe.87.1598513346756;
 Thu, 27 Aug 2020 00:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200826172853.49426-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200826172853.49426-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Aug 2020 09:28:55 +0200
Message-ID: <CAFqZXNsBE=PAwfyE3=D35VG+yDdg2UXhNUq_vF_4f8yojoZSdg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: move policy mutex to selinux_state, use in
 lockdep checks
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 7:29 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Move the mutex used to synchronize policy changes (reloads and setting
> of booleans) from selinux_fs_info to selinux_state and use it in
> lockdep checks for rcu_dereference_protected() calls in the security
> server functions.  This makes the dependency on the mutex explicit
> in the code rather than relying on comments.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches selinuxfs from using &selinux_state.policy_mutex to using
> fsi->state->policy_mutex.  selinuxfs operates on fsi->state->policy
> for all policy reading or modifying operations.  It only acts on
> &selinux_state for checking permissions in the current context.
> At present, fsi->state is always &selinux_state; this will change
> when selinux namespaces are introduced.
>
>  security/selinux/hooks.c            |  1 +
>  security/selinux/include/security.h |  1 +
>  security/selinux/selinuxfs.c        | 26 ++++++++++----------
>  security/selinux/ss/services.c      | 37 +++++++----------------------
>  4 files changed, 22 insertions(+), 43 deletions(-)

Seeing this is in an actual patch, it now looks logical to me. *thumbsup*

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

