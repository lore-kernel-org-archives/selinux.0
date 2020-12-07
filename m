Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F3C4361B
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C812A23884
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLGRSh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgLGRSh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 12:18:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0002EC061749
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 09:17:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h19so13188985otr.1
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kE0B2ZBE+JZDSyEUmU1UhaEL4A/w3nsiEpX243u6J7o=;
        b=bHIYlxhXQcU/MxqV4nbSIbHMj+5ygptYB6d7JYo2ja52yejs2jmgUriCA/W566HNdM
         IJ5cQU29ijN1XqmmY/v01iJMC2vSsaFPzT0M4jqp0xJvrb74YVow8CiNgVtpevXnUEnv
         UnTPVjL5qMgnlwLzVcxpbJjrw5guw+FE/d3b+WK4hF5ywGPu71WalX3TUrm9GjJwVNIR
         qxPMlC96hYWrkVtfQPwdezJRGL/PjtOq7g5YTjfSxsDTxQZcotOj3wBtx3JATRAG3nZN
         fuHXxtlcmqtFJiBDyb6/HAm2pHt1lsdd5qVBruw3uWFctkVl4wyUXALu5RF/OWnY/d5w
         ZqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kE0B2ZBE+JZDSyEUmU1UhaEL4A/w3nsiEpX243u6J7o=;
        b=fyK64TlPS9eLT3F4FkZbnKME+LQciNL+EO3zx4OvCVjxkxe+/2LwpbN+rhddVjcpUj
         8jDbyMvz6UFVHWFSv0hcwwsTRTThJyYOiaSnKTQvlqHg7hUcNjpTHaV5Kk3LohHi1Z8T
         SH8FeOyxjA3U9GiKa+A0bGhYf8u/9zpkIcZqF4y4A1Xt7+9+ojraPYXXEzLtpMNihwT/
         JSgN9jfiduNT2OMkQgrVOo71Ulxy4kFJIApIQW7QuhXpEW1jZtXY+0vp/B7pPKFGYtKX
         famQ8s+1gnm/ee2Tk1hr6VP4ICI01Nej+Uyr8RrC2RyUVMuNPQpcREgaWTp5ZnXHU7hu
         Jf1g==
X-Gm-Message-State: AOAM532ryPq2U2vsHstqMvIZ2pWGGztvzG+xnFKPBbly1nc3sP/DqevY
        sAhCu7MRlyXyTqheDnuMdi2zcOsWlBkRxQOMEQJgRDGL
X-Google-Smtp-Source: ABdhPJxjHlzfeEPdfdRM5FDqI77svxeAIp6sVbP3ih/KQRuURAc/EG3pS0QatyrLe2iVevZvjoTKe7aetXsBC2Pji8A=
X-Received: by 2002:a9d:d01:: with SMTP id 1mr13474430oti.295.1607361476413;
 Mon, 07 Dec 2020 09:17:56 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Dec 2020 12:17:45 -0500
Message-ID: <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hi everyone,
>
> In [1] we ran into a problem with the current handling of filesystem
> labeling rules. Basically, it is only possible to specify either
> genfscon or fs_use_xattr for a given filesystem, but in the case of
> virtiofs, certain mounts may support security xattrs, while other ones
> may not.
>
> So we can't use the xattr support by adding fs_use_xattr virtiofs
> (...); to the policy, because then a non-xattr mount will fail
> (SELinux does a mount-time check on the root inode to make sure that
> the xattr handler works), but we also don't want to stay on genfscon,
> because then we can't relabel files.
>
> So my question is how to best address this? One option is to use a
> similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> labeling, but that's ugly and requires hard-coding another FS name in
> the selinux code. The only other alternative I could come up with is
> to add a new FS labeling statement that would specify some kind of
> mixed genfscon / fs_use_xattr behavior. That would be a better
> long-term solution, but leads to more questions on how such statement
> should actually work... Should it work the cgroupfs way, giving a
> default label to everything and allowing to set/change labels via
> xattrs? Or should it rather just detect xattrs support and switch
> between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> on that? In the latter case, should the statement specify two contexts
> (one for fs_use_xattr and another one for genfscon) or just one for
> both behaviors?
>

I don't think adding a new statement is necessary. It seems like
allowing both fs_use_xattr and genfscon rules for the filesystem in
policy and then using the fs_use_xattr rule if xattrs are supported
while falling back to the genfscon rule if they are not would do what
you need.

Jim

> Any thoughts/pointers welcome.
>
> [1] https://github.com/fedora-selinux/selinux-policy/pull/478
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
