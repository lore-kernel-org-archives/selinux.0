Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34B9C4332B
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 02:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903C42246B
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 02:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAGCow (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbhAGCov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 21:44:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D9C0612F0
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 18:44:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cm17so6323578edb.4
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 18:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMOKHTGqmc8H/goueItvedsRqkw1V7cr/6m0zsCokxw=;
        b=gyKgWQMwx/fTejAGvT1hbN4rzR75Q1DifGuW0ra4ZEh5ftPL8zEY4t7NeUB5EqUJIP
         V0blI2KlAUL8JdQVW1/c+YtmoKvSecARmdppSAdJYwjqwe/NAn3+4wgklIhNTeyRgS2R
         w05YjLwZpGCyHcKUIJ/Q9oRznw0AcM1r6qF2WK8yj2Gz4MdsT0ZzuGaOFI76AfGJc2vB
         fRfb9WoD4qo932KS+okUkD744Ux7YW9MuYc+QPYgL2COSkrIEsAppNS2ztQqRuSfYtsG
         h2dl0xVbrXhvaYsJ5Q0MN+c2J+kcXRHWrwA8MSZaUbxeWccd8go9LR8zrFLnrFjcMQZ6
         aBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMOKHTGqmc8H/goueItvedsRqkw1V7cr/6m0zsCokxw=;
        b=AwdAfbjAggt1vHSdQkdPmdhbTqY1B/iAo+FuI8Jb23ngVdqyX2JRkHsze/QMb6MM5M
         m321X3JTaVjWyBw2FImXYsYLF6l7dobWLotKLeqr9potJ45ORWSYoJzMo4iXOuMWLBYk
         RNAI9hhT/X8sTJ9V8Xks1PfZKxRpUyOmn84GAtyB0unEpclXSQE2EAslihMO5h5/4d3E
         UJf5ol60k5JNGNuYBpRJkEwVdrzwxvZfaBy6hmTR4/8356T3OfimcKwVNVU+vzFnO8ZY
         OthAFealu7fMRD/0GbiHHazhUHREn1HSAqpDh/2w+S5MHakXKzqycHPJVhZvTc987I8g
         skVg==
X-Gm-Message-State: AOAM530wxEnLss9qFiq18EcwD0iZW42KBjY/pNta5kVa46xDA4Yvbse6
        zh7uOgYJa6y/UQpPCTU5sYmdKw/dRWcuxC0zrlInvw==
X-Google-Smtp-Source: ABdhPJxBb+RdnrsFN59ka23PplstQ6jdggXOAEPVHXXH8Ohp0tDlQq8TsnXKFSOgQicIgRKCKgy9RZ1egRVgU/h/DdQ=
X-Received: by 2002:a05:6402:1ad1:: with SMTP id ba17mr29013edb.51.1609987443025;
 Wed, 06 Jan 2021 18:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-3-lokeshgidra@google.com> <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
In-Reply-To: <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 6 Jan 2021 18:43:52 -0800
Message-ID: <CA+EESO7nFwaeSA2xC_FH=O6MtCuORcHPrihwRdt9ecWWLgkBsg@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 6:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > From: Daniel Colascione <dancol@google.com>
> >
> > This change adds a new function, anon_inode_getfd_secure, that creates
> > anonymous-node file with individual non-S_PRIVATE inode to which security
> > modules can apply policy. Existing callers continue using the original
> > singleton-inode kind of anonymous-inode file. We can transition anonymous
> > inode users to the new kind of anonymous inode in individual patches for
> > the sake of bisection and review.
> >
> > The new function accepts an optional context_inode parameter that callers
> > can use to provide additional contextual information to security modules.
> > For example, in case of userfaultfd, the created inode is a 'logical child'
> > of the context_inode (userfaultfd inode of the parent process) in the sense
> > that it provides the security context required during creation of the child
> > process' userfaultfd inode.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> >
> > [Delete obsolete comments to alloc_anon_inode()]
> > [Add context_inode description in comments to anon_inode_getfd_secure()]
> > [Remove definition of anon_inode_getfile_secure() as there are no callers]
> > [Make __anon_inode_getfile() static]
> > [Use correct error cast in __anon_inode_getfile()]
> > [Fix error handling in __anon_inode_getfile()]
>
> Lokesh, I'm assuming you made the changes in the brackets above?  If
> so they should include your initials or some other means of
> attributing them to you, e.g. "[LG: Fix error ...]".

Thanks for reviewing the patch. Sorry for missing this. If it's
critical then I can upload another version of the patches to fix this.
Kindly let me know.
>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/anon_inodes.c            | 150 ++++++++++++++++++++++++++----------
> >  fs/libfs.c                  |   5 --
> >  include/linux/anon_inodes.h |   5 ++
> >  3 files changed, 115 insertions(+), 45 deletions(-)
> >
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 89714308c25b..023337d65a03 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -55,61 +55,79 @@ static struct file_system_type anon_inode_fs_type = {
> >         .kill_sb        = kill_anon_super,
> >  };
> >
> > -/**
> > - * anon_inode_getfile - creates a new file instance by hooking it up to an
> > - *                      anonymous inode, and a dentry that describe the "class"
> > - *                      of the file
> > - *
> > - * @name:    [in]    name of the "class" of the new file
> > - * @fops:    [in]    file operations for the new file
> > - * @priv:    [in]    private data for the new file (will be file's private_data)
> > - * @flags:   [in]    flags
> > - *
> > - * Creates a new file by hooking it on a single inode. This is useful for files
> > - * that do not need to have a full-fledged inode in order to operate correctly.
> > - * All the files created with anon_inode_getfile() will share a single inode,
> > - * hence saving memory and avoiding code duplication for the file/inode/dentry
> > - * setup.  Returns the newly created file* or an error pointer.
> > - */
> > -struct file *anon_inode_getfile(const char *name,
> > -                               const struct file_operations *fops,
> > -                               void *priv, int flags)
> > +static struct inode *anon_inode_make_secure_inode(
> > +       const char *name,
> > +       const struct inode *context_inode)
> >  {
> > -       struct file *file;
> > +       struct inode *inode;
> > +       const struct qstr qname = QSTR_INIT(name, strlen(name));
> > +       int error;
> > +
> > +       inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> > +       if (IS_ERR(inode))
> > +               return inode;
> > +       inode->i_flags &= ~S_PRIVATE;
> > +       error = security_inode_init_security_anon(inode, &qname, context_inode);
> > +       if (error) {
> > +               iput(inode);
> > +               return ERR_PTR(error);
> > +       }
> > +       return inode;
> > +}
> >
> > -       if (IS_ERR(anon_inode_inode))
> > -               return ERR_PTR(-ENODEV);
> > +static struct file *__anon_inode_getfile(const char *name,
> > +                                        const struct file_operations *fops,
> > +                                        void *priv, int flags,
> > +                                        const struct inode *context_inode,
> > +                                        bool secure)
>
> Is it necessary to pass both the context_inode pointer and the secure
> boolean?  It seems like if context_inode is non-NULL then one could
> assume that a secure anonymous inode was requested; is there ever
> going to be a case where this is not true?

Yes, it is necessary as there are scenarios where a secure anon-inode
is to be created but there is no context_inode available. For
instance, in patch 4/4 of this series you'll see that when a secure
anon-inode is created in the userfaultfd syscall, context_inode isn't
available.
>
> > +{
> > +       struct inode *inode;
> > +       struct file *file;
> >
> >         if (fops->owner && !try_module_get(fops->owner))
> >                 return ERR_PTR(-ENOENT);
> >
> > -       /*
> > -        * We know the anon_inode inode count is always greater than zero,
> > -        * so ihold() is safe.
> > -        */
> > -       ihold(anon_inode_inode);
> > -       file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
> > +       if (secure) {
> > +               inode = anon_inode_make_secure_inode(name, context_inode);
> > +               if (IS_ERR(inode)) {
> > +                       file = ERR_CAST(inode);
> > +                       goto err;
> > +               }
> > +       } else {
> > +               inode = anon_inode_inode;
> > +               if (IS_ERR(inode)) {
> > +                       file = ERR_PTR(-ENODEV);
> > +                       goto err;
> > +               }
> > +               /*
> > +                * We know the anon_inode inode count is always
> > +                * greater than zero, so ihold() is safe.
> > +                */
> > +               ihold(inode);
> > +       }
> > +
> > +       file = alloc_file_pseudo(inode, anon_inode_mnt, name,
> >                                  flags & (O_ACCMODE | O_NONBLOCK), fops);
> >         if (IS_ERR(file))
> > -               goto err;
> > +               goto err_iput;
> >
> > -       file->f_mapping = anon_inode_inode->i_mapping;
> > +       file->f_mapping = inode->i_mapping;
> >
> >         file->private_data = priv;
> >
> >         return file;
> >
> > +err_iput:
> > +       iput(inode);
> >  err:
> > -       iput(anon_inode_inode);
> >         module_put(fops->owner);
> >         return file;
> >  }
> > -EXPORT_SYMBOL_GPL(anon_inode_getfile);
>
> --
> paul moore
> www.paul-moore.com
