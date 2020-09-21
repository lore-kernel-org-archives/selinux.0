Return-Path: <SRS0=+hMc=C6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B92C43466
	for <selinux@archiver.kernel.org>; Mon, 21 Sep 2020 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E872396D
	for <selinux@archiver.kernel.org>; Mon, 21 Sep 2020 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgIUQaS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgIUQaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Sep 2020 12:30:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673BBC061755;
        Mon, 21 Sep 2020 09:30:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKOhf-003EJQ-10; Mon, 21 Sep 2020 16:30:11 +0000
Date:   Mon, 21 Sep 2020 17:30:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Message-ID: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921160922.GA23870@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> [adding Linus and Al]
> 
> On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > Hi folks,
> > 
> > It seems that after commit 13c164b1a186 ("autofs: switch to
> > kernel_write") there is now an extra LSM permission required (for the
> > current task to write to the automount pipe) for processes accessing
> > some yet-to-to-be mounted directory on which an autofs mount is set
> > up. The call chain is:
> > [...]
> > autofs_wait() ->
> > autofs_notify_daemon() ->
> > autofs_write() ->
> > kernel_write() ->
> > rw_verify_area() ->
> > security_file_permission()
> > 
> > The bug report that led me to this commit is at [1].
> > 
> > Technically, this is a regression for LSM users, since this is a
> > kernel-internal operation and an LSM permission for the current task
> > shouldn't be required. Can this patch be reverted? Perhaps
> > __kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
> > so that the name is more descriptive?
> 
> So we obviously should not break existing user space and need to fix
> this ASAP.  The trivial "fix" would be to export __kernel_write again
> and switch autofs to use it.  The other option would be a FMODE flag
> to bypass security checks, only to be set if the callers ensures
> they've been valided (i.e. in autofs_prepare_pipe).
> 
> Any opinions?

Reexport for now.  Incidentally, what is LSM doing rejecting writes
into a pipe?
