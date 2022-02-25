Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BCBC433F5
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 10:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiBYKCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiBYKCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Feb 2022 05:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582D9190C26
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645783327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPiioyU+PPrylysQ98ZdM61Y+d5JwpmZJvQ03oQLxPg=;
        b=WUvjBzwQmBQIycLAnC13iSU0Blh9SoFBkQpquwXSrgfAYqNOYUfFH1AKtbyQZNwIbQKzMv
        AtbgT7BOdv8YuGmJ11ZY+TCzZKusMgTv+lG0AdKsSJYrGb5BMv0UElnNb0jqhHeJC+KJWA
        6EjaCnEglTFyGhGjzn/tzo8gKoRh5UY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-3zBJAtJ_Mx2PFCRo0-3HgA-1; Fri, 25 Feb 2022 05:02:03 -0500
X-MC-Unique: 3zBJAtJ_Mx2PFCRo0-3HgA-1
Received: by mail-yb1-f197.google.com with SMTP id l3-20020a25ad43000000b0062462e2af34so2731414ybe.17
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 02:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPiioyU+PPrylysQ98ZdM61Y+d5JwpmZJvQ03oQLxPg=;
        b=chsGy+j4Du4p4fJn+rAYqRxHv7YFSzub+8YJn9FYb4Jj4bJQBRyeVqNdPxaQAEpzjH
         kgqMJs+aPMh640F4qwZ43aGlbXj2TMlCg+sFTXRR7V2+utgzjsF/ofhrbNojnwnm53N+
         OlGyAz5JFJ0PtBlQlEkTLfXVZ9wtfaXBsDwNupbamy1j97WmLKg3ObKAiQ7Wq9Aqx/RV
         VZirwetVizHecaEZ6VAUak/zi7SK641yeVEpS4XyexrPLhTOp5Aj8NTKCeeaPAjC462k
         22Jc8j3N/TVGjAXya1VCD0Y23HeBx9TenK2bbK2t0L78Jqqbtedl1bFWTL1cs3DnM9hH
         Xx0w==
X-Gm-Message-State: AOAM530ZwP4YMq19qmIxpQaB1I+WmSQo5WJ/rVbLUUD/qrtGs7jciG28
        qTjyRVWRL740nN7B6EE09dum+WABbEpWAqOda5YxEft/EBvLeE+p3q5+4/vwYlDGiBki+z7ir1W
        hFLCpFgvPhh2YHaN1Cc8wCOMAU0lKMnkMSQ==
X-Received: by 2002:a0d:d756:0:b0:2d6:250c:1def with SMTP id z83-20020a0dd756000000b002d6250c1defmr6607231ywd.12.1645783322895;
        Fri, 25 Feb 2022 02:02:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXxqxCxvcQXC3dvHhcqU+4X5NxIT8b1HSMukcKqPuYjc7/gIkbxelb/a6SzRt6AkYw0j65vTqLW1a32m2MM1E=
X-Received: by 2002:a0d:d756:0:b0:2d6:250c:1def with SMTP id
 z83-20020a0dd756000000b002d6250c1defmr6607209ywd.12.1645783322694; Fri, 25
 Feb 2022 02:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20220224102417.42268-1-richard_c_haines@btinternet.com> <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com>
In-Reply-To: <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 25 Feb 2022 11:01:52 +0100
Message-ID: <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
Subject: Re: [PATCH V3] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 25, 2022 at 1:34 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Feb 24, 2022 at 5:24 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> > always allows too.  Furthermore, a failed FIOCLEX could result in a file
> > descriptor being leaked to a process that should not have access to it.
> >
> > As this patch removes access controls, a policy capability needs to be
> > enabled in policy to always allow these ioctls.
> >
> > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change: Control via a policy capability.
> > V3 Change: Update switch check.
> >
> >  security/selinux/hooks.c                   | 6 ++++++
> >  security/selinux/include/policycap.h       | 1 +
> >  security/selinux/include/policycap_names.h | 3 ++-
> >  security/selinux/include/security.h        | 7 +++++++
> >  4 files changed, 16 insertions(+), 1 deletion(-)
>
> This looks good to me, but before I merge this are the SELinux
> userspace folks okay with the policy capability's name and enum value?

Since you mention it... I would suggest naming the enum
POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC to match the display name. Yes,
it becomes awkwardly long, but e.g.
POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS is already longer than
that, so I'd prefer more descriptiveness over brevity.

(IMHO the POLICYDB_CAPABILITY_ prefix is ridiculously long for no
reason and we should simply shorten it (just POLCAP_ would be
perfectly fine, IMHO) instead of trying to abbreviate the rest. Of
course, this doesn't have to be done now - I'm taking a note to myself
to splice in such rename next time I add a new capability, if not
earlier.)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

