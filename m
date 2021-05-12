Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18855C433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE854611CE
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhELNXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 09:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhELNW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 09:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620825711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtvrIv0gd9IsJeuZT9VIJXOOFa9yzPvKusGPJfLQ7f4=;
        b=A9HOWi9KmzFFBTNqyY4ed5tNzt6Z/G0TAo1zXJQ+9ORQz1SNXSd6gmCqma9xc6OSYNDqmh
        9QWsaMp1odA6cfPYSDGeRB3et+tqYOA0Ql6EFRefzo9/O0Ge/5sDJ8igY2qZ3+vNqXLV+F
        YeaGoGlJv7AFYoY30h7ZGxBft5bGNvY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-nFUfW8zANwWhgVwalY1W5w-1; Wed, 12 May 2021 09:21:49 -0400
X-MC-Unique: nFUfW8zANwWhgVwalY1W5w-1
Received: by mail-yb1-f200.google.com with SMTP id d63-20020a254f420000b02904f91ef33453so6873299ybb.12
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 06:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtvrIv0gd9IsJeuZT9VIJXOOFa9yzPvKusGPJfLQ7f4=;
        b=OXeVmfJmP5/yDNhH4+cSDApVYPkwiCzFJteau3pY9V5bdIyx5t++eAZlHKhe2tFV6c
         IlYT6Pwgv2U1uoCDMYUHJBaOBAA4bw8xRhJ9ovCla6A/k+1PpV7nuDzxcVjrCbxyAAnb
         IaTK3nGl17kq/2Yy7mEmXj8RFl2IqrcNz18iWtre/PV3v8gICos7cZDzsXlbE6yM7Sil
         XX/JnrK/lVxhg25yLUVW+sn7rECY1gp+jzSaTucUggsUGMAABWaq0bCfjruTif0gX2u6
         TFoaxC8ZqNe36Og5fLIjth8AMgXclgoYsfi6fES+gXK087YS+8omx/Zxl1/Cruct+gtI
         8RSw==
X-Gm-Message-State: AOAM531ap+uMxncRNOKb5GgMQDiFwAQwrXJSoBwjkwy8vfxt6R1DWuUP
        8mg1n7ZkGqpUTVEmMywU2rec/F3wvis318vgJsioav4csHcnJFh1D5/ayhfbXpNnRkKYxnZxd+w
        hCeUSZCASPstX2qjRmlRaYFi1VzKKQAwxSw==
X-Received: by 2002:a25:6983:: with SMTP id e125mr46782757ybc.81.1620825709171;
        Wed, 12 May 2021 06:21:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmv2Qjn6VYEo9c/oXPEmu6i04CA+M1aunHQiWM6u48mJ31LcpQnTbka787MtlSpRVc8GFLI9xcdcVeHkvyMsg=
X-Received: by 2002:a25:6983:: with SMTP id e125mr46782731ybc.81.1620825708981;
 Wed, 12 May 2021 06:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114048.138933-1-omosnace@redhat.com> <a8d138a6-1d34-1457-9266-4abeddb6fdba@schaufler-ca.com>
In-Reply-To: <a8d138a6-1d34-1457-9266-4abeddb6fdba@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 May 2021 15:21:37 +0200
Message-ID: <CAFqZXNtr1YjzRg7fTm+j=0oZF+7C5xEu5J0mCZynP-dgEzvyUg@mail.gmail.com>
Subject: Re: [PATCH] lockdown,selinux: fix bogus SELinux lockdown permission checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 8, 2021 at 12:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/7/2021 4:40 AM, Ondrej Mosnacek wrote:
> > Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> > lockdown") added an implementation of the locked_down LSM hook to
> > SELinux, with the aim to restrict which domains are allowed to perform
> > operations that would breach lockdown.
> >
> > However, in several places the security_locked_down() hook is called in
> > situations where the current task isn't doing any action that would
> > directly breach lockdown, leading to SELinux checks that are basically
> > bogus.
> >
> > Since in most of these situations converting the callers such that
> > security_locked_down() is called in a context where the current task
> > would be meaningful for SELinux is impossible or very non-trivial (and
> > could lead to TOCTOU issues for the classic Lockdown LSM
> > implementation), fix this by adding a separate hook
> > security_locked_down_globally()
>
> This is a poor solution to the stated problem. Rather than adding
> a new hook you should add the task as a parameter to the existing hook
> and let the security modules do as they will based on its value.
> If the caller does not have an appropriate task it should pass NULL.
> The lockdown LSM can ignore the task value and SELinux can make its
> own decision based on the task value passed.

The problem with that approach is that all callers would then need to
be updated and I intended to keep the patch small as I'd like it to go
to stable kernels as well.

But it does seem to be a better long-term solution - would it work for
you (and whichever maintainer would be taking the patch(es)) if I just
added another patch that refactors it to use the task parameter?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

