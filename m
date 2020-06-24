Return-Path: <SRS0=RPjD=AF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16601C433DF
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E303D2078E
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H3ztvDQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbgFXAqg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgFXAqg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 20:46:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B3C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 17:46:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so180984edr.9
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRZtweYqZcGRhaO9Em07sFH5GSjLHMOuZjE8gUH2vzo=;
        b=H3ztvDQvRRouwBpKguszErbNHsYzybuPDOFN1QZR47nYRv1At4hRdcY74nSA05nucc
         vVLobkLBG1nHNfz9QhrHU+iq2Cms4kPRt4jsbC0Qzlf/A9nZwQO+G68uiRCcaasVLhQN
         QYCtpdGan8L1pO7OTHG1ywTX9jT0BbAXDyAWFZmKDzyJrRKUwJ+FtziZhEDZL0TghwNc
         EJotE4lZCWwvBrbqxWZMiIBnNQGVysvNd6VnzizDi3sEQBjcDoMBcxqqW5LQY21fFk8/
         XRKLu1dqTQ3HvbmP92F1ViybIA2jmon+k2w/zs+Pju046ukwR6jxa9zshdAMCRIrZRn2
         7YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRZtweYqZcGRhaO9Em07sFH5GSjLHMOuZjE8gUH2vzo=;
        b=tTi/9UsXSMuWHVqqvPv+bQ7XM2zQ6fUwcqrHLZDFqsemszb3D+AewAsKAKeWl6grJu
         /raSRm8R8Ml7VVFjRipEvBUshTrG7k7exDCNBVzu+QmDg1GD4TYJE07I/1kwM9Hb5whI
         1EARTwb7yAiNg5w0eKHV4dvglpkvBAfZbFWPj/0dpUpH5knbqVtWD5hP+imsoMaHZPrH
         lHt0u4oNKKxPj8FcT7NQroEj0HwUhnZ7wmBODgdrADA+zq/jPc4wfdgQ6pEQxEFqaqMe
         Wfzn09ySJhztw0AKHmEGTP5rzmss1cFcGGNvaXZhNlUqu5qmQXQSWW9b3sZwhP4rNPwQ
         5rFg==
X-Gm-Message-State: AOAM532P3N0L8Odrnh83U0S3SaTLcVUwLznnoBCunTyF9Ybm4KwzWfc9
        G8HAlN2Y9V8xaVeBeFsXY8pNPk/NZ4p4R9iuUfnO
X-Google-Smtp-Source: ABdhPJxgJVL2Dti0bx0fE8VejdfGMiCtGSzCUi8EPfm7tXGQnUn/2PkxaDqDsdGV0LV+Tbi7fLy0oGCFotIvu0JhLpU=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr18999942edw.196.1592959594405;
 Tue, 23 Jun 2020 17:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200528143938.209364-1-jlebon@redhat.com> <CAHC9VhRy6hYVYTgxDxek+2Xv6tDbJy4GOGC3h2m5-VYDLG2iSA@mail.gmail.com>
In-Reply-To: <CAHC9VhRy6hYVYTgxDxek+2Xv6tDbJy4GOGC3h2m5-VYDLG2iSA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Jun 2020 20:46:23 -0400
Message-ID: <CAHC9VhQs+PVbxMNh9s78yO_bGk_Feii4x=dVxZUcK=OoqP6sUw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 1, 2020 at 2:24 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, May 28, 2020 at 10:49 AM Jonathan Lebon <jlebon@redhat.com> wrote:
> >
> > This patch does for `getxattr` what commit 3e3e24b42043 ("selinux: allow
> > labeling before policy is loaded") did for `setxattr`; it allows
> > querying the current SELinux label on disk before the policy is loaded.
> >
> > One of the motivations described in that commit message also drives this
> > patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
> > able to move the root filesystem for example, from xfs to ext4 on RAID,
> > on first boot, at initrd time.[1]
> >
> > Because such an operation works at the filesystem level, we need to be
> > able to read the SELinux labels first from the original root, and apply
> > them to the files of the new root. The previous commit enabled the
> > second part of this process; this commit enables the first part.
> >
> > [1] https://github.com/coreos/fedora-coreos-tracker/issues/94
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
> > ---
> >  security/selinux/hooks.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Thanks.  This looks reasonable to me, but since it was posted only a
> few days before the merge window was opened it needs to wait until
> after the merge window closes.  I'll merge it into selinux/next then.

I just merged this into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
