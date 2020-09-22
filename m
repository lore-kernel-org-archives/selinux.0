Return-Path: <SRS0=6DiJ=C7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A8C2D0E2
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6007220B1F
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 12:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMtqG3An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIVM3V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIVM3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Sep 2020 08:29:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87652C061755;
        Tue, 22 Sep 2020 05:29:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w16so20800229oia.2;
        Tue, 22 Sep 2020 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw8l2XF27GiXIs5D2LDmdbIHtbPV/9IzZuH5gha+dXU=;
        b=hMtqG3AnIdzhd8FhSJgasZRgxKX1BljRAI3iQ76ON6vFjNvk6LxCNISVCaxXPse8i4
         ft813JH+9Sm/PFyoejP7USwNGwwkoZ35rNf3OETQy8Mgl+ybxX8pp0NAZuvQqi64mZkN
         48N08Anmat/0Y9DOCODiO5gqh228M8QaRLVkuxf8agrXMsZ4C8WnpeL/260Hqh0z6rtO
         OXgfVoIk5m03bCrWR8Q1j+XdX+nvMhbOvQhnDljSMpXLd0HjQIn8pXWQIyWBK7d/V3df
         2BYvDj49sJRHwb3JtyJo4ctAPiPrKPp/iYP5xW/kGBc3FBzCNyvE8c4J0602KcD/DoP+
         WnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw8l2XF27GiXIs5D2LDmdbIHtbPV/9IzZuH5gha+dXU=;
        b=VxEAiAqyM1nyeovkGLGWm45rFATeBSGeqO/z/wl4Y5GwZ5QBPaEj25SrSDgrCg1u+B
         N7ha7oIJfzx+CjdBmcY9wVkX/Eux0ibV2m0DUSU3+41KyEZ5TRxqKWKHsfJTdDqxZn8G
         DON5UnCAWTGzWaM3gs3FDZdVVGLjyal2lI49mzHAL1dTVXV/X9EowhxS6Mgt5IDADPus
         mm8kk07cU086AQHdMFUaWXbBTPGck24pvkQA252qpQ+NhsOAbexMNIBWHhiGSQR3on6s
         0H7lih4obEfOdCc/GGCllWJfy+Xk7YkJ7X5ol37vJZyd5hA/IyLpveGJvkhmKifJwVis
         d+MQ==
X-Gm-Message-State: AOAM531CzEUJqMnBs9lAew1WZp2+VaoDKYnOO/xY76IkeCW905GiQMfF
        uh1VErCE4GE6JN8KYvbc1V+2wGXx2IG1ErmKWwpQ/FyC
X-Google-Smtp-Source: ABdhPJwXjzZtghSQAOmQh6XXAPH+VTjj0QVlpHN8OBZNnzLzgvtJqOiAnWnrQ0OmZRNMZE8kLL3LauL7kJ3Ovs6g9UI=
X-Received: by 2002:aca:4007:: with SMTP id n7mr2319303oia.160.1600777760931;
 Tue, 22 Sep 2020 05:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk> <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
In-Reply-To: <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 22 Sep 2020 08:29:10 -0400
Message-ID: <CAEjxPJ5zjZLP0LoGy-VGRdhO+hCa=+nPNx3f_AJ-+iVSOaO_-g@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 22, 2020 at 3:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > > [adding Linus and Al]
> > >
> > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > > Hi folks,
> > > >
> > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > kernel_write") there is now an extra LSM permission required (for the
> > > > current task to write to the automount pipe) for processes accessing
> > > > some yet-to-to-be mounted directory on which an autofs mount is set
> > > > up. The call chain is:
> > > > [...]
> > > > autofs_wait() ->
> > > > autofs_notify_daemon() ->
> > > > autofs_write() ->
> > > > kernel_write() ->
> > > > rw_verify_area() ->
> > > > security_file_permission()
> > > >
> > > > The bug report that led me to this commit is at [1].
> > > >
> > > > Technically, this is a regression for LSM users, since this is a
> > > > kernel-internal operation and an LSM permission for the current task
> > > > shouldn't be required. Can this patch be reverted? Perhaps
> > > > __kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
> > > > so that the name is more descriptive?
> > >
> > > So we obviously should not break existing user space and need to fix
> > > this ASAP.  The trivial "fix" would be to export __kernel_write again
> > > and switch autofs to use it.  The other option would be a FMODE flag
> > > to bypass security checks, only to be set if the callers ensures
> > > they've been valided (i.e. in autofs_prepare_pipe).
>
> IMHO that sounds like an overkill in this scenario. I don't think it
> makes sense to do the LSM check here (or at least not against the
> current task's creds), because it is not the current task that wants
> to communicate with the daemon, it just wants to to access some
> directory on the system that just happens to be special to the kernel,
> which needs to do some communication on the side to service this
> request. So if we do want to do any LSM check here, there should at
> least be some "bool internal" flag passed to the LSM, signalizing that
> this is an internal read/write operation that wasn't directly
> initiated/requested by the current process. SELinux could then either
> use the kernel secid instead of the current task's secid or skip the
> check completely in such case.
>
> I'd like Stephen to weigh in on this, but it looks he might be on
> vacation right now...

No, just wasn't cc'd previously.  I don't think we want any LSM check
here.  As the long term fix, I would suggest moving the
security_file_permission() call up from rw_verify_area() to the
callers (and not call it from kernel_write() at all).

>
> > >
> > > Any opinions?
> >
> > Reexport for now.  Incidentally, what is LSM doing rejecting writes
> > into a pipe?
>
> With SELinux at least, what is allowed or denied is defined in the
> policy. And the policy usually defaults to everything denied and then
> you add rules to allow what needs (and makes sense) to be allowed.
> Since until kernel 5.8 random processes didn't need to write to pipes
> created by the automount daemon, it has never been explicitly allowed
> and so the automounting now fails. It is in no way obvious that all
> processes should have the permission to talk to the automount daemon
> just to traverse the filesystem...

Yes, controlling pipe writes is just one part of controlling
information flow between processes but the intent here is to control
userspace actions, not kernel-internal operations.
