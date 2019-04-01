Return-Path: <SRS0=DZBp=SD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FDBC43381
	for <selinux@archiver.kernel.org>; Mon,  1 Apr 2019 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8F120896
	for <selinux@archiver.kernel.org>; Mon,  1 Apr 2019 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfDAJrT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:47:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36253 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDAJrT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Apr 2019 05:47:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so6054162oia.3
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2019 02:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeoYiGRUmmuZTwB0EobntDLWtQ5dx2dsa4bH2rQ1OFM=;
        b=KN5fXMRxou4GiGdHTp4nK4wRdVDS3woZNbRBxf6d4HdZSzchyvKvSiMgZwVfYTdn0m
         pkzjc5MCaHp8QPGUm5LaOGoof9RPCcXxHIYiDC0eK8plZJ0C1v4AghW4S/DMHFiawFcG
         wV7hBg5ucFt7c2et6kw5q8y8DW85XWCN4EpgUQSgizLxsvOPJVg/zA8tKgzuDtZQtl+L
         m4nLKdjmBbxsVWe/eXP964et6edXwV82oGvT0Dn7o2SRqDEgDEiqS2u8BBREWQI+FxUY
         ORnTZuvDIpFSS49HcA88acjKdFOGdx6gzOCP2UBgVHq7hOCkelQO3Fu9ePvlbRVcDmFj
         0xNA==
X-Gm-Message-State: APjAAAXN1PfmKs3in3tqXMa11qYk3uCXOWMmri0wfNytQ44mHBNfKG1C
        H0bp8YxIPFgC9vZ6vQXYS3qOVeoZZLTEl7YDJxVoXA==
X-Google-Smtp-Source: APXvYqy4OjtQCT/lgLDjGkfpglDoq6w1izbB3EdflDgUelTgYJPLEtG2j5aZqZyUjk9Klk2aDr+umVsb6aMfkPYeXXs=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr6266551oia.156.1554112038143;
 Mon, 01 Apr 2019 02:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190326121210.17414-1-omosnace@redhat.com>
 <CAHC9VhQsi-gf2BQOcNLzF=JDZ=0Noj3DQH3iA+7FC3ThwN4BAg@mail.gmail.com>
In-Reply-To: <CAHC9VhQsi-gf2BQOcNLzF=JDZ=0Noj3DQH3iA+7FC3ThwN4BAg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Apr 2019 11:47:07 +0200
Message-ID: <CAFqZXNud0Q4ANgkGBjnzxJfbZ2+hP5iHyT8BGuvL8EaM7AQDxw@mail.gmail.com>
Subject: Re: [PATCH v2] kernfs: fix xattr name handling in LSM helpers
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 29, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 26, 2019 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > The implementation of kernfs_security_xattr_*() helpers reuses the
> > kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> > and extract full xattr name from it using xattr_full_name(). However,
> > this function relies on the fact that the suffix passed to xattr
> > handlers from VFS is always constructed from the full name by just
> > incerementing the pointer. This doesn't necessarily hold for the callers
> > of kernfs_security_xattr_*(), so their usage will easily lead to
> > out-of-bounds access.
> >
> > Fix this by converting the helpers to take the full xattr name instead
> > of just the suffix and moving the reconstruction to the xattr handlers.
> > We now need to check if the prefix is correct in the helpers, but it
> > saves us the difficulty of reconstructing the full name from just the
> > plain suffix.
> >
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> > Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2: Rebase on current selinux/next.
> >
> >  fs/kernfs/inode.c        | 38 ++++++++++++++++++--------------------
> >  include/linux/kernfs.h   |  8 ++++----
> >  security/selinux/hooks.c |  6 +++---
> >  3 files changed, 25 insertions(+), 27 deletions(-)
>
> Thanks for diagnosing this and providing a patch.  I haven't seen any
> objections, but I do have some questions (below).
>
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index 673ef598d97d..1daa8aa9ec96 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -288,28 +288,20 @@ int kernfs_iop_permission(struct inode *inode, int mask)
> >         return generic_permission(inode, mask);
> >  }
> >
> > -static int kernfs_node_xattr_get(const struct xattr_handler *handler,
> > -                                struct kernfs_node *kn, const char *suffix,
> > +static int kernfs_node_xattr_get(struct kernfs_node *kn, const char *name,
> >                                  void *value, size_t size)
> >  {
> > -       const char *name = xattr_full_name(handler, suffix);
> > -       struct kernfs_iattrs *attrs;
> > -
> > -       attrs = kernfs_iattrs_noalloc(kn);
> > +       struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
> >         if (!attrs)
> >                 return -ENODATA;
> >
> >         return simple_xattr_get(&attrs->xattrs, name, value, size);
> >  }
> >
> > -static int kernfs_node_xattr_set(const struct xattr_handler *handler,
> > -                                struct kernfs_node *kn, const char *suffix,
> > +static int kernfs_node_xattr_set(struct kernfs_node *kn, const char *name,
> >                                  const void *value, size_t size, int flags)
> >  {
> > -       const char *name = xattr_full_name(handler, suffix);
> > -       struct kernfs_iattrs *attrs;
> > -
> > -       attrs = kernfs_iattrs(kn);
> > +       struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
> >         if (!attrs)
> >                 return -ENOMEM;
> >
>
> ...
>
> > -int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
> > +int kernfs_security_xattr_get(struct kernfs_node *kn, const char *name,
> >                               void *value, size_t size)
> >  {
> > -       return kernfs_node_xattr_get(&kernfs_security_xattr_handler,
> > -                                    kn, suffix, value, size);
> > +       if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
> > +               return -EINVAL;
> > +
> > +       return kernfs_node_xattr_get(kn, name, value, size);
> >  }
> >
> > -int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
> > +int kernfs_security_xattr_set(struct kernfs_node *kn, const char *name,
> >                               void *value, size_t size, int flags)
> >  {
> > -       return kernfs_node_xattr_set(&kernfs_security_xattr_handler,
> > -                                    kn, suffix, value, size, flags);
> > +       if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
> > +               return -EINVAL;
> > +
> > +       return kernfs_node_xattr_set(kn, name, value, size, flags);
> >  }
>
> I think it is reasonable to ask if we even need
> kernfs_security_xattr_{set|get}()?  Can we just call the respective
> kernfs_node_xattr*() functions instead?  I can't imagine the
> WARN_ON_ONCE check being that important.

Indeed, it is now much more natural to just expose all xattrs in those
helpers... I concur that the encapsulation doesn't seem to be worth it
any more. Let me do a simplified respin...


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
