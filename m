Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521EAC433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBBB2078B
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SAkO13XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHRAzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgHRAzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 20:55:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18017C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:55:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so20022243eje.7
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZ0Y9NvxMp7SpC9p4quARAmjVIJgUpCFDwosmJjdC2k=;
        b=SAkO13XUOhhH83B7aKnqxeeByAuulef9kZ6GCTRP5bT1q/hBbFp5SIMJXZ7Ob7YTlQ
         t7rEUQNd6kplp3n01FNQnX6BBj2sBk0oyrNYBUEY4GvWSqCQmXyJLrnt+MXlPl+UUs15
         mWkBEClcDTVfEnMDQ+XdrOXP54HDqlwX0ZlahPFmmjXm49ib/ufo/ZjrWeTyt5ofdy9J
         P3+yMx1Tm30G5eZ1Rrtq838pOktCjRwxE9S/BHC1JllENUz4aEvsq8STHUMaN2PcYZGQ
         5cJh+8FIj0ebtS3djkQ33CtEuGw1zfCDZrA32LiTqXi7II+f8BB2VRIlyqKn2CmqrrQc
         /CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZ0Y9NvxMp7SpC9p4quARAmjVIJgUpCFDwosmJjdC2k=;
        b=Kk6nirV6JhmsVkRXbmNTmBT8D557xyst+a75c3rBZdmgpnwJcBGs4sqVahY7K0LnRp
         POyOuCkppMLmV7NUFrmUriRQ1fFQtCJl9YGhlhmdAWIGG+ari2xf/Ak1QNQSJSs3dIYs
         GGRrpeBH0TcPOtzjbPR36VqYgYSQfK4G2dRR4UhOyM8QboHufiuTMIflduHprGQ28yaj
         7bEzUIHLaVosX5oXONWsImDfSUnuVQe6JGKDtXdFMyWN3SH3g4xKP+2Uak53kQuGtXcW
         dj9Jiz24yTs4j+adryrKzmcFxx0z9Lh4sgrMQ/XLUvJmZVl69mPWIhwi13Bb4jb4BZwl
         2I0g==
X-Gm-Message-State: AOAM533aNO7Rxl/2wyWtjW6jr21S8OzVkkrlB5ZTEGBO6G/vxBO9D+hI
        Cg7AKlXLBy8lkQdfogBHiP5DPwgwGkISnCik5ci1
X-Google-Smtp-Source: ABdhPJxjsafBteos2yOkgreWfxmwbbgO76lEdvn5am+qPJglaE+DhWGZBLtM9bXEycj8MzVYEF+Pz6dE8p/Kn+Nm1TA=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr17427023ejo.178.1597712149620;
 Mon, 17 Aug 2020 17:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132934.61002-1-stephen.smalley.work@gmail.com> <20200807132934.61002-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20200807132934.61002-2-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 20:55:38 -0400
Message-ID: <CAHC9VhQCdKb4sPCq7628uFudiMZr87K5sZBR+RzBC58YgwYaWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] selinux: move policy commit after updating selinuxfs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 9:30 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> With the refactoring of the policy load logic in the security
> server from the previous change, it is now possible to split out
> the committing of the new policy from security_load_policy() and
> perform it only after successful updating of selinuxfs.  Change
> security_load_policy() to return the newly populated policy
> data structures to the caller, export selinux_policy_commit()
> for external callers, and introduce selinux_policy_cancel() to
> provide a way to cancel the policy load in the event of an error
> during updating of the selinuxfs directory tree.  Further, rework
> the interfaces used by selinuxfs to get information from the policy
> when creating the new directory tree to take and act upon the
> new policy data structure rather than the current/active policy.
> Update selinuxfs to use these updated and new interfaces.  While
> we are here, stop re-creating the policy_capabilities directory
> on each policy load since it does not depend on the policy, and
> stop trying to create the booleans and classes directories during
> the initial creation of selinuxfs since no information is available
> until first policy load.
>
> After this change, a failure while updating the booleans and class
> directories will cause the entire policy load to be canceled, leaving
> the original policy intact, and policy load notifications to userspace
> will only happen after a successful completion of updating those
> directories.  This does not (yet) provide full atomicity with respect
> to the updating of the directory trees themselves.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This is technically v3 of this patch but I marked it v5 to match the version
> of the first patch since I am posting them as a series.  In any event,
> the only change here is re-basing on top of the updated first patch
> and dropping use of load_mutex.
>
>  security/selinux/include/conditional.h |  2 +-
>  security/selinux/include/security.h    | 16 ++++-
>  security/selinux/selinuxfs.c           | 69 +++++++++++----------
>  security/selinux/ss/services.c         | 85 +++++++++++++-------------
>  security/selinux/ss/sidtab.c           | 10 +++
>  security/selinux/ss/sidtab.h           |  2 +
>  6 files changed, 104 insertions(+), 80 deletions(-)

Also merged into selinux/next.

-- 
paul moore
www.paul-moore.com
