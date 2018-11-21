Return-Path: <SRS0=ZtKf=OA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EE1C43441
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC06A21479
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 12:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC06A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKUXPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:15:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38562 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbeKUXPq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 18:15:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so495654otl.5
        for <selinux@vger.kernel.org>; Wed, 21 Nov 2018 04:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF4/nToczH7B0/JHVacN57od8Dqm54vt/EoCiQX4OUI=;
        b=orYHQK3YIgtBTHB14/jrcDAxRXsx+ycpH2wieA+SQKGoQ9gqhOP/8WOqLIOgt2qljn
         3GovICOh8NdoegMnrnvP9VA96NfPm/MR5JosnUp1vmhbQGzNESqvu3sY/PW/dTCutGHz
         7TGdBAyD+TwsaKvG3fh/kob/TOIxMCT8hRqOiKIQ+U8EeFjTFQwI0U908TWzeYZTu0xl
         KybQ5g8HxffOJgs+sCqlDdNyWS5zvFASiIKiyPIejDFDsL+WOJixRFbMocrsQ7o3GpPV
         tmEcmwXftzR9nShpMJVK2myL3c/wlHI5HYQx0ZPaV8dHQiHTf2XuECBiHrxn7x8ewAUp
         PyCA==
X-Gm-Message-State: AA+aEWYkUeVR3QW/KSfq1kvlcPajQ5CLpnUFYCSEewhZ8Rr7/P14CYNW
        l/eXA6nCO/c5RbiCXLIn6MKNf2nayl82CQBtSBsprw==
X-Google-Smtp-Source: AFSGD/Usv3wqu0FRWiZatN6UQGEwkZLWyReAp7j7icpxoqxq0TEn9a4bASoClXEE3HXZcTJ9yK4mmpFkOMibM242ltk=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr3522214otk.144.1542804092501;
 Wed, 21 Nov 2018 04:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com> <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
In-Reply-To: <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 21 Nov 2018 13:41:21 +0100
Message-ID: <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 20, 2018 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > If a superblock has the MS_SUBMOUNT flag set, we should always allow
> > mounting it. These mounts are done automatically by the kernel either as
> > part of mounting some parent mount (e.g. debugfs always mounts tracefs
> > under "tracing" for compatibility) or they are mounted automatically as
> > needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
> > automounts are either an implicit consequence of the parent mount (which
> > is already checked) or they can happen during regular accesses (where it
> > doesn't make sense to check against the current task's context), the
> > mount permission check should be skipped for them.
> >
> > Without this patch, attempts to access contents of an automounted
> > directory can cause unexpected SELinux denials.
> >
> > In the current kernel tree, the MS_SUBMOUNT flag is set only via
> > vfs_submount(), which is called only from the following places:
> >  - AFS, when automounting special "symlinks" referencing other cells
> >  - CIFS, when automounting "referrals"
> >  - NFS, when automounting subtrees
> >  - debugfs, when automounting tracefs
> >
> > In all cases the submounts are meant to be transparent to the user and
> > it makes sense that if mounting the master is allowed, then so should be
> > the automounts. Note that CAP_SYS_ADMIN capability checking is already
> > skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
> >  - sget_userns() in fs/super.c:
> >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
> >             !(type->fs_flags & FS_USERNS_MOUNT) &&
> >             !capable(CAP_SYS_ADMIN))
> >                 return ERR_PTR(-EPERM);
> >  - sget() in fs/super.c:
> >         /* Ensure the requestor has permissions over the target filesystem */
> >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
> >                 return ERR_PTR(-EPERM);
> >
> > Verified internally on patched RHEL 7.6 with a reproducer using
> > NFS+httpd and selinux-tesuite.
>
> I think this all sounds reasonable, but please verify this with an
> upstream kernel.  Upstream our focus is on the upstream kernel
> (surprise!), downstream RHEL is your responsibility, not ours :)

I tested on RHEL because that's what I can do most conveniently. I
don't have a very good workflow/environment for complex testing on
upstream right now. I don't expect the results to be any different on
the upstream kernel, but I understand your concern. I have been
thinking about some patch testing automation using Fedora Rawhide (I
hope that's close enough to upstream at least :), so I guess it's time
to get scriptin'...

I was hoping to get some independent testing after porting the test to
the selinux-testsuite... (But I get it, the burden of proof is on my
side...)

>
> > Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7ce683259357..7ce012d9ec51 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2934,7 +2934,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
> >                 return rc;
> >
> >         /* Allow all mounts performed by the kernel */
> > -       if (flags & MS_KERNMOUNT)
> > +       if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
> >                 return 0;
> >
> >         ad.type = LSM_AUDIT_DATA_DENTRY;
>
> --
> paul moore
> www.paul-moore.com
--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
