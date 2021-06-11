Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E026C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2DA6124C
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFKRVg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:21:36 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:42587 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhFKRV0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jun 2021 13:21:26 -0400
Received: by mail-ej1-f51.google.com with SMTP id k25so5600984eja.9
        for <selinux@vger.kernel.org>; Fri, 11 Jun 2021 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjkbfRDd5y6haW2CAy0yl/YnQg0P4lJjhfdgaYwKNIY=;
        b=ZeTFWC7N28RDLG3f3H5uOzNcZClOrAyYXio0/oUvaVFETFjK7ughF2WCXrQm0H0oGE
         FCCJl25haHMcUnrZ3eCH4nsjhWQmE1GnyKToFWY1qf6k0p9TvGgoZZzk6Xf2PC36+OV0
         NMwejzHbVxItDxKTj3YJ5J6qZDyHJVCE9HqXNqL5Ktnbn9WYW5QBF+N+t/dFkSL63gaW
         QHMrpvKu0QdhnW7w6O2H2SrPUqeiUiLbIAvfFYjtKehTholbk38qdz9JJB3s6ff6a+dT
         /sT0yXjX+AlsZrDyAce5tuD9JnkZEyhru5oG9zwQrE9hPWL7PlNu51qMmq25Ie21L495
         JQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjkbfRDd5y6haW2CAy0yl/YnQg0P4lJjhfdgaYwKNIY=;
        b=KvKYuovnrz4trRCByUq7efO3KnJmxPeHp6RV9nJ9NX4zq96hKeADmtg0pBFn6ZjYC2
         o9lvuM5velmOTMwlgoK650SJc9mXQYbarOOS9za/dRN1goluh/8XvmXwGXImWj2IiDN4
         tdHdHVj6r3b4FtriV/kS6RtdLrYpWGlho7EWgql+aSyUFJnvOi/Bu/XvYYodA77HtJu+
         ysLOYJaACkKY5b2EG8jqUgx7et/8N0Xs9SzTvFB8L/K9lkRZu4af/zrA73+QAhEZUyJh
         85q2U/8qQb55hnTeI40V4CfxW9uR490JrzyRaMPohG+fAhBUcf/tQ/GxwntQ5z7gxpNx
         lkgQ==
X-Gm-Message-State: AOAM531cjiwTLuJXok4HfF3a7J5C4UC13I1SlJvKGgAZF91gCjKsIP3l
        foJnbCl2bpJ0CYvoa86AnD7WcN54BDQm8c7Oy29z
X-Google-Smtp-Source: ABdhPJycXLWSFAsWvD2XOygB5HzxWmdforZOrwTSDYRwQV6AXcpsfLpP2QgqIUzCqxMz6h+Jl+6CcTeaYmfgw5oqkAI=
X-Received: by 2002:a17:907:2bd6:: with SMTP id gv22mr4507670ejc.431.1623431907387;
 Fri, 11 Jun 2021 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk> <CAHC9VhSo5wPdqyZ2i9rWgZJhRCw3jv7aNuUFZBwJysFpAW7Drg@mail.gmail.com>
 <YMLAHTAtjdgcvOl4@zeniv-ca.linux.org.uk> <CAHC9VhQuUA5hgv3ELwDReSe-43rtng8phBDuYoB4+8bJqtxqSA@mail.gmail.com>
In-Reply-To: <CAHC9VhQuUA5hgv3ELwDReSe-43rtng8phBDuYoB4+8bJqtxqSA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:18:16 -0400
Message-ID: <CAHC9VhRpLf1A2AxpEYg=nU1PgZoCOF053=PhfqtyQQzb3Ly=CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 9:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 10, 2021 at 9:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Thu, Jun 10, 2021 at 07:12:15PM -0400, Paul Moore wrote:
> > > On Thu, Jun 10, 2021 at 11:51 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > [followup to dump_common_audit_data() changes from this winter; in vfs.git#work.audit]
> > > > Does anybody have objections to the below?
> > > >
> > > > From 663a40ab49308b5acaba8a335190fce66e17d969 Mon Sep 17 00:00:00 2001
> > > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > > Date: Sat, 16 Jan 2021 15:40:54 -0500
> > > > Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
> > > >
> > > > dump_common_audit_data() is safe to use under rcu_read_lock() now;
> > > > no need for AVC_NONBLOCKING and games around it
> > > >
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > ---
> > > >  security/selinux/avc.c         | 28 ++++++++--------------------
> > > >  security/selinux/hooks.c       | 13 ++-----------
> > > >  security/selinux/include/avc.h |  4 ----
> > > >  3 files changed, 10 insertions(+), 35 deletions(-)
> > >
> > > This looks okay to me, thanks Al.  If you want to fix patch 2/2 I can
> > > pull both into selinux/next.
> >
> > Done and force-pushed into the same branch...  Do you want a formal pull request?
>
> Thanks for the offer, but I can just pull those top two patches from
> work.audit.  However, this mail came in just as I was shutting down
> for the evening so I'll take care of it tomorrow.

Both are now in selinux/next, thanks Al.

-- 
paul moore
www.paul-moore.com
