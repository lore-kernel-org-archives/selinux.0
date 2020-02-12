Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4816C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8462A2082F
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+UvlnLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLRXs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:23:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRXs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 12:23:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so3230486ljo.7
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZr1nc2MMJDzpqB9JOfpyRPCxbAR505Ej70RCsv/wk4=;
        b=G+UvlnLLVKjVlxxQvVi0scUUGngqNXOY34KbUJIyu++IE35cnORnKL7btXkIijKnSL
         4JfAk5l1RFVHrPGt/pp+YrlCgJACSq8iJ68bmL5V9shtQP0FVy6BhTxGMYik1JdG0tzY
         uDeFuHil6xDU3BRA1IzMEd/x79VwYuCluHbVEaZVVQYOeFmAf4TU5uQ7VSamrYUo4GuX
         74q5XQwOdXVBc+OLWgUMeMf+H05QWxFbjzn2TAkiL3TnPEx0wEYVp7NLleXEZnTu0i4v
         j9jnUOd4e4PKjsvGRLmmeEWwkPPdky3mtcYbt8XQI7/pzEmitJM7o4bn5WYEwNiz7eUh
         9G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZr1nc2MMJDzpqB9JOfpyRPCxbAR505Ej70RCsv/wk4=;
        b=VepEZ7I8NNR4TYUrdMuT+VmuPhOmF9lDmaVT9I7yzgiOZzqh13ghzJ4KRJHf+pb/pQ
         KDX+4NLI5ZycVMDQR4aWwihm8krNK64iMAyLM2TLtzBo9mR4y2VMCjXzz5lOnHeo3GjN
         Fvt1IqYfuKHBozOWh2rHPRzlSxKdRyaj2DUOawh8Vi0b3FYvvVCjhiH75Ml3trOrfYHR
         X6Vl9Cj7hwEr/p7oJVHaesGq81uoHK4W7vCqHEBZpb4V8Bemj3v/gFCi/WAy9d/5lzVf
         okaIRXAtRVV8oKyzzXhArFgs1I+kQa+l6ez4uhJ4PlYiVOwDGuAUHktnLYy61Ssun1ba
         l/yg==
X-Gm-Message-State: APjAAAUFRaGCkhi1r/5fwQzSP3A5r0LXQF7a2Cg3q4fvvJUtc46uMCAU
        WJ8cPuilM9uf8PwZePrvO4A+ED9VzXTaOheUgFSfjQ==
X-Google-Smtp-Source: APXvYqwV70oqrBIrF4HWfDsbPKou2uKu/ooe53tS/zQEVjVVTCcmq11lzjZ/7aas9gqyLAgb66ocUKHFUHUYl6KcrYk=
X-Received: by 2002:a05:651c:297:: with SMTP id b23mr8476854ljo.260.1581528225757;
 Wed, 12 Feb 2020 09:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200211225547.235083-2-dancol@google.com>
 <88ea16bd-38be-b4f9-dfb3-e0626f5b6aaf@tycho.nsa.gov>
In-Reply-To: <88ea16bd-38be-b4f9-dfb3-e0626f5b6aaf@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 09:23:09 -0800
Message-ID: <CAKOZuet1vcDwkqoJgqmDjg7pjLGfvh11ZdUZpoyoXXWdz9Y4CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add a new flags-accepting interface for anonymous inodes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks again for the review.

On Wed, Feb 12, 2020 at 8:36 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/11/20 5:55 PM, Daniel Colascione wrote:
> > Add functions forwarding from the old names to the new ones so we
> > don't need to change any callers.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
>
> (please add linux-fsdevel, viro to cc on future versions of this patch
> since this is a VFS change)
>
> > ---
> >   fs/anon_inodes.c            | 62 ++++++++++++++++++++++---------------
> >   include/linux/anon_inodes.h | 27 +++++++++++++---
> >   2 files changed, 59 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 89714308c25b..caa36019afca 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -56,60 +56,71 @@ static struct file_system_type anon_inode_fs_type = {
> >   };
> >
> >   /**
> > - * anon_inode_getfile - creates a new file instance by hooking it up to an
> > - *                      anonymous inode, and a dentry that describe the "class"
> > - *                      of the file
> > + * anon_inode_getfile2 - creates a new file instance by hooking it up to
> > + *                       an anonymous inode, and a dentry that describe
> > + *                       the "class" of the file
>
> Not going to bikeshed on names but anon_inode_getfile_flags or _secure
> or something would be more descriptive.

_flags is fine, but I think _secure is overfitting.

> >    *
> >    * @name:    [in]    name of the "class" of the new file
> >    * @fops:    [in]    file operations for the new file
> >    * @priv:    [in]    private data for the new file (will be file's private_data)
> > - * @flags:   [in]    flags
> > + * @flags:   [in]    flags for the file
> > + * @anon_inode_flags: [in] flags for anon_inode*
>
> Do we really envision ever needing more than one new flag here?  If not,
> then making it a bool secure parameter or encoding it as an
> unused/ignored flag bit in the existing flags argument would seem
> preferable.

A bool and a flag is the same as far as the machine is concerned with
respect to argument passing, and I find the flag much more descriptive
than a bare "true" or a "false" scattered at call sites. Besides, a
flags argument could lead to less churn later.

> In some cases, we actually want the "anon inode" to inherit the security
> context of a related inode (e.g. ioctls on /dev/kvm can create anon
> inodes representing VMs, vCPUs, etc and further ioctls are performed on
> those inodes), in which case we may need the caller to pass in the
> related inode as well.

See my other reply on this subject. Passing an optional related inode
seems like a decent approach here.

> >    *
> > - * Creates a new file by hooking it on a single inode. This is useful for files
> > + * Creates a new file by hooking it on an unspecified inode. This is useful for files
> >    * that do not need to have a full-fledged inode in order to operate correctly.
> >    * All the files created with anon_inode_getfile() will share a single inode,
> >    * hence saving memory and avoiding code duplication for the file/inode/dentry
> >    * setup.  Returns the newly created file* or an error pointer.
> > + *
> > + * anon_inode_flags must be zero.
> >    */
> > -struct file *anon_inode_getfile(const char *name,
> > -                             const struct file_operations *fops,
> > -                             void *priv, int flags)
> > +struct file *anon_inode_getfile2(const char *name,
> > +                              const struct file_operations *fops,
> > +                              void *priv, int flags, int anon_inode_flags)
> >   {
> > +     struct inode *inode;
> >       struct file *file;
> >
> > -     if (IS_ERR(anon_inode_inode))
> > -             return ERR_PTR(-ENODEV);
> > -
> > -     if (fops->owner && !try_module_get(fops->owner))
> > -             return ERR_PTR(-ENOENT);
> > +     if (anon_inode_flags)
> > +             return ERR_PTR(-EINVAL);
>
> Not sure this is how it is normally done (i.e. one patch to just
> introduce an extended interface but disallow all use of it, then a
> separate patch to introduce the first use).  Would recommend combining;
> otherwise reviewers can't see how it will be used without looking at both.

All things being equal, finer-grained patches are better: they allow
for easier bisection. But I don't feel strongly one way or the other
here, so let's see what other reviewers say.
