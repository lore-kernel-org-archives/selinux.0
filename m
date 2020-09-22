Return-Path: <SRS0=6DiJ=C7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70769C4727D
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 07:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5731238D6
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU7NOCbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgIVHeI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729855AbgIVHeH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Sep 2020 03:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600760045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLNLNqxOlhhIUOsZLkynKysFiUo4YS4/xLJlG3EgM6o=;
        b=LU7NOCbfeaZdGhstszFsvV2zEeOBW+lC0x7W8+HqdI4+MjjT2lzLT7m5ABM5FHy4oLZZXM
        QgDJy0XlvG3ZQILtCtm9Er84ygccZnDlx6s1kbqO+i/9ep4om5n2bwA9ztml3BppGwR1/M
        4GlQ0RW8PRkk0LqLa4qZgyae5sBpuiU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-OBAeKpOoMGeJHFfLvp622A-1; Tue, 22 Sep 2020 03:34:03 -0400
X-MC-Unique: OBAeKpOoMGeJHFfLvp622A-1
Received: by mail-lf1-f70.google.com with SMTP id w22so3373589lfl.13
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2020 00:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLNLNqxOlhhIUOsZLkynKysFiUo4YS4/xLJlG3EgM6o=;
        b=cBEIgRJA+JjQByfcGAA5TaNCr7ExCljqHyxOzovt8msvJliJW96HAWeiK7Mm24JfwI
         REVqhwVNZ/JZb/FCq6eGORoWtVoeXHcXue3cst2BRFwaqNkTwb2Y3FZhAWlOgpnF5m3G
         Mqe/CStshrr3TgplywndOI5Rgh2hoVkykumdg9x398gTR/M1+4dqZpWX8GMHdPwNGJXn
         6JkXjAr8lDaa7BQHx1PNA2cVn1qxdr81DVMlSNcXVcBtCzfdep95BR+FWsGHmZpgIpzr
         Des0YS9q1NmI8J+EPSWfXoTrh1ASjNQHAASuJtTZqNV7VJDq6xQUP2gf0IRfaLs3H9L0
         FE6w==
X-Gm-Message-State: AOAM530F2Ino+Vhu6zuG4tWmLo+YDGgz5itLSw6EhDpGRNo8VnxgwIlF
        eZbC0y5ZqVwvxQEB2zGZD6xHhEfWKcd3DoxdyKH03O78C+ns1UwSzBCehzEj+GsCfqNsSb+WGL6
        uxOO2i5EuljApNqDDCs575/nmyQxq0DR42g==
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1332268lfa.354.1600760041912;
        Tue, 22 Sep 2020 00:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCfXmaAZWxU7YIAHBIcnL0eyOz6zI51uNtK6P4KKpZL1/XDLvA/HS8pMkl2LjNPXCWFmx+KnBdDuK48LAKasQ=
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1332258lfa.354.1600760041617;
 Tue, 22 Sep 2020 00:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 22 Sep 2020 09:33:50 +0200
Message-ID: <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > [adding Linus and Al]
> >
> > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > Hi folks,
> > >
> > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > kernel_write") there is now an extra LSM permission required (for the
> > > current task to write to the automount pipe) for processes accessing
> > > some yet-to-to-be mounted directory on which an autofs mount is set
> > > up. The call chain is:
> > > [...]
> > > autofs_wait() ->
> > > autofs_notify_daemon() ->
> > > autofs_write() ->
> > > kernel_write() ->
> > > rw_verify_area() ->
> > > security_file_permission()
> > >
> > > The bug report that led me to this commit is at [1].
> > >
> > > Technically, this is a regression for LSM users, since this is a
> > > kernel-internal operation and an LSM permission for the current task
> > > shouldn't be required. Can this patch be reverted? Perhaps
> > > __kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
> > > so that the name is more descriptive?
> >
> > So we obviously should not break existing user space and need to fix
> > this ASAP.  The trivial "fix" would be to export __kernel_write again
> > and switch autofs to use it.  The other option would be a FMODE flag
> > to bypass security checks, only to be set if the callers ensures
> > they've been valided (i.e. in autofs_prepare_pipe).

IMHO that sounds like an overkill in this scenario. I don't think it
makes sense to do the LSM check here (or at least not against the
current task's creds), because it is not the current task that wants
to communicate with the daemon, it just wants to to access some
directory on the system that just happens to be special to the kernel,
which needs to do some communication on the side to service this
request. So if we do want to do any LSM check here, there should at
least be some "bool internal" flag passed to the LSM, signalizing that
this is an internal read/write operation that wasn't directly
initiated/requested by the current process. SELinux could then either
use the kernel secid instead of the current task's secid or skip the
check completely in such case.

I'd like Stephen to weigh in on this, but it looks he might be on
vacation right now...

> >
> > Any opinions?
>
> Reexport for now.  Incidentally, what is LSM doing rejecting writes
> into a pipe?

With SELinux at least, what is allowed or denied is defined in the
policy. And the policy usually defaults to everything denied and then
you add rules to allow what needs (and makes sense) to be allowed.
Since until kernel 5.8 random processes didn't need to write to pipes
created by the automount daemon, it has never been explicitly allowed
and so the automounting now fails. It is in no way obvious that all
processes should have the permission to talk to the automount daemon
just to traverse the filesystem...

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

