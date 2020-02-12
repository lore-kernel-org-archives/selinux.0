Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19872C352A4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB87021739
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZ1hvEGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLRT6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:19:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36326 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLRT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 12:19:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so2176581lfh.3
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rU6txhFTKspoGX/U60ruYSaeQNuMHsYzoocjIcC782c=;
        b=OZ1hvEGkFd12rHeAi8ci4EjhJ8sPzGLXm4kc5nQ6qyUcizK9ENQhNNUnvZNl6ipOwD
         X9/zMjh4tdfENQwQU0gI8zznCTzlp1lj2LCgDOVRQRX/FGEwV12zZJ1PDeaQ0DW2Ore/
         sCJkl+boumG/aT6Gpv4hmw5MMk5fqQyX6YT4+kpF9FUgWcp0LHmEGpmAF6UFfh5aQgp4
         Fz5d6HvzmwF7R6BLbzai/AiDoEmBkjRbsgIABWxHaBUR8wFnHAkNBOdECeovaSeS8yIt
         pD9sdydhVmJOz6uCU/xoZbmCQITmHKZjotwyNvLWBMyfKWoyNP02qX4ZHyDCEo7KJy+w
         3haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rU6txhFTKspoGX/U60ruYSaeQNuMHsYzoocjIcC782c=;
        b=ud3OjLHBUeheQZgW5rO8W+j+AN5phfWQwy6A0/SVGlnBKd2ZNk9N6WZuL8Oo8koz2x
         PpJ9C1ko/ByLG7V1eRfzeK/NZplC4pdOX/OUtCHjtR6G+MDiotwfGkvuFYB3VW33DdUP
         OfITjMOnB//Ov8tVSUf+grlIx+gQISFQSyAUboFYJ70hb5wgGzkFZ5RT8X1CYszDnf5R
         KH6lsNBGSfKLGsQiQUvigOsZ0/Fg8nokZmztTBGh3UVtJTtC/RykAsnk50BHHuove7xV
         Ig2RMpRohux/yshc8nOjRz2c+L/lprAnSSDM7SIVH3j7RETGL+7sRqP/BNf3A4qlxGRJ
         jugA==
X-Gm-Message-State: APjAAAU07gj0uH7H7mq8k8lffpdBrbmd+IYOaWEtJU2ugKuqEjCHlxwY
        X/gXkuwXaWJcn1lpzbkmbyPq5ypw1r1mMJelnI3Olg==
X-Google-Smtp-Source: APXvYqw9k3f7e9kNkAqI6YaXNA3yxCHADb9+dIrru9lZjroVzKlLAvIc7iQVCvQ3XTCCBSqw34OZAuqivhMsrW/2i4w=
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr7042133lfz.193.1581527992964;
 Wed, 12 Feb 2020 09:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200211225547.235083-4-dancol@google.com>
 <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
In-Reply-To: <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 09:19:16 -0800
Message-ID: <CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
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

Thanks for taking a look.

On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/11/20 5:55 PM, Daniel Colascione wrote:
> > Use the secure anonymous inode LSM hook we just added to let SELinux
> > policy place restrictions on userfaultfd use. The create operation
> > applies to processes creating new instances of these file objects;
> > transfer between processes is covered by restrictions on read, write,
> > and ioctl access already checked inside selinux_file_receive.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
>
> (please add linux-fsdevel and viro to the cc for future versions of this
> patch since it changes the VFS)
>
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1659b59fb5d7..e178f6f40e93 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >       return 0;
> >   }
> >
> > +static int selinux_inode_init_security_anon(struct inode *inode,
> > +                                         const char *name,
> > +                                         const struct file_operations *fops)
> > +{
> > +     const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +     struct common_audit_data ad;
> > +     struct inode_security_struct *isec;
> > +
> > +     if (unlikely(IS_PRIVATE(inode)))
> > +             return 0;
>
> Seems like this is precluded by the caller and would be a bug?  If
> needed at all, take it to the security_inode_init_security_anon() so it
> doesn't have to be repeated in each security module.
>
> > +
> > +     /*
> > +      * We shouldn't be creating secure anonymous inodes before LSM
> > +      * initialization completes.
> > +      */
> > +     if (unlikely(!selinux_state.initialized))
> > +             return -EBUSY;
>
> I don't think this is viable; any arbitrary actions are possible before
> policy is loaded, and a Linux distro can be brought up fully with
> SELinux enabled and no policy loaded.  You'll just need to have a
> default behavior prior to initialization.

We'd have to fail open then, I think, and return an S_PRIVATE inode
(the regular anon inode).

> > +
> > +     isec = selinux_inode(inode);
> > +
> > +     /*
> > +      * We only get here once per ephemeral inode.  The inode has
> > +      * been initialized via inode_alloc_security but is otherwise
> > +      * untouched, so check that the state is as
> > +      * inode_alloc_security left it.
> > +      */
> > +     BUG_ON(isec->initialized != LABEL_INVALID);
> > +     BUG_ON(isec->sclass != SECCLASS_FILE);
>
> I think the kernel discourages overuse of BUG_ON/BUG/...

I'm not sure what counts as overuse.

> > +
> > +#ifdef CONFIG_USERFAULTFD
> > +     if (fops == &userfaultfd_fops)
> > +             isec->sclass = SECCLASS_UFFD;
> > +#endif
>
> Not sure we want or need to introduce a new security class for each user
> of anonymous inodes since the permissions should be the same as for
> file.

The purpose of this change is to apply special policy to userfaultfd
FDs in particular. Isn't having a UFFD security class the best way to
go about that? (There's no path.) Am I missing something?

> Also not sure we want to be testing fops for each such case.

I was also thinking of just providing some kind of context string
(maybe the name), which might be friendlier to modules, but the loose
coupling kind of scares me, and for this particular application, since
UFFD is always in the core and never in a module, checking the fops
seems a bit more robust and doesn't hurt anything.

> We
> were looking at possibly leveraging the name as a key and using
> security_transition_sid() to generate a distinct SID/context/type for
> the inode via type_transition rules in policy.  We have some WIP along
> those lines.

Where? Any chance it would be ready soon? I'd rather not hold up this
work for a more general mechanism.

> > +
> > +     if (isec->sclass == SECCLASS_FILE) {
> > +             printk(KERN_WARNING "refusing to create secure anonymous inode "
> > +                    "of unknown type");
> > +             return -EOPNOTSUPP;
> > +     }
> > +     /*
> > +      * Always give secure anonymous inodes the sid of the
> > +      * creating task.
> > +      */
> > +
> > +     isec->sid = tsec->sid;
>
> This doesn't generalize for other users of anonymous inodes, e.g. the
> /dev/kvm case where we'd rather inherit the SID and class from the
> original /dev/kvm inode itself.

I think someone mentioned on the first version of this patch that we
could make it more flexible if the need arose. If we do want to do it
now, we could have the anon_inode security hook accept a "parent" or
"context" inode that modules could inspect for the purposes of forming
the new inode's SID. Does that make sense to you?
