Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F80C10F00
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FED2146E
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfBSOKn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:10:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38161 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfBSOKn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 09:10:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so34338898otf.5
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 06:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7OY1MUUFiChd6QOVeGQ3pNXAw1nC9J+HbhfFly+PWU=;
        b=TyXU/omFVN7lA0bcFpsTObeUna03mga1ui2oyrSJQ9KWXaNlNcX3UArvSJPg2Vl7SP
         kGenHe/9fgIoEA4gsV4bAERtXdVqaXYmH6RRiQmTH4h7Oz2gTKtTQtZIfBQeAj1ZzGuN
         HCi7EMCyt3K+RnhrcU2m5kWxBsqf8KcJfTJqIbDYcmIBbq20cVBa7i3pQPf6c4q3UlhJ
         SP2U9DklQys2m40XN5bHUCtphuY+3k308m4OO4shmUCaTZbulzrs0ntK/7FIYFfJDDr+
         PL52IXkOwISa4aQlmBEnDFBoKxnPGcpFcgjqPwbmpocw1gtKZK6iShA+fDA+z+ypPwYf
         Tn4w==
X-Gm-Message-State: AHQUAubrtI2ZTPFtNnfse9XSN0si4ugb1x0STxtPoq+NW5EMlORLQGJ3
        nwLMsfdNkvWA2o+BwwBc99cPLGGa3b1tNbjDNNZnaA==
X-Google-Smtp-Source: AHgI3IZ2gGd+VUK9De3pQuAP48/HOyND1gNTvh6TMiphy4BcQCx24RTLvITpaonjZJ/R23ocscm9ON9Ax9b4H1tXqd0=
X-Received: by 2002:aca:b354:: with SMTP id c81mr2711771oif.26.1550585442002;
 Tue, 19 Feb 2019 06:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com> <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com> <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
 <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com>
In-Reply-To: <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Feb 2019 15:10:30 +0100
Message-ID: <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tejun Heo <tj@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 19, 2019 at 1:28 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/18/2019 2:03 AM, Ondrej Mosnacek wrote:
> > On Fri, Feb 15, 2019 at 4:50 PM Tejun Heo <tj@kernel.org> wrote:
> >> On Fri, Feb 15, 2019 at 04:45:44PM +0100, Ondrej Mosnacek wrote:
> >>> On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> >>>> On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> >>>>> +static int kernfs_node_init_security(struct kernfs_node *parent,
> >>>>> +                                  struct kernfs_node *kn)
> >>>> Can we skip the whole thing if security is not enabled?
> >>> Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
> >>> is easy to do and I can add it in the next respin (although the
> >>> compiler should be able to optimize most of it out in that case).
> >> So the goal is allowing folks who don't use this to not pay.  It'd be
> >> better the evaulation can be as late as possible but obviously there's
> >> a point where that'd be too complicated.  Maybe "ever enabled in this
> >> boot" is a good and simple enough at the same time?
> > I don't think there is a way currently to check whether some LSM has
> > been enabled at boot or not. I suppose we could add such function for
> > this kind of heuristics, but I'm not sure how it would interplay with
> > the plans to allow multiple LSM to be enabled simultaneously...
> > Perhaps it would be better/easier to just add a
> > security_kernfs_needs_init() function, which would simply check if the
> > list of registered kernfs_init_security hooks is empty.
> >
> > I propose something like the patch below (the whitespace is mangled -
> > intended just for visual review). I plan to fold it into the next
> > respin if there are no objections to this approach.
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 735a6d382d9d..5b99205da919 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -625,6 +625,9 @@ static int kernfs_node_init_security(struct
> > kernfs_node *parent,
> >          struct qstr q;
> >          int ret;
> >
> > +       if (!security_kernfs_needs_init() || !parent)
> > +               return 0;
> > +
> >          if (!parent->iattr) {
> >                  kernfs_iattr_init(&iattr_parent, parent);
> >                  simple_xattrs_init(&xattr_parent);
> > @@ -720,11 +723,9 @@ static struct kernfs_node
> > *__kernfs_new_node(struct kernfs_root *root,
> >                          goto err_out3;
> >          }
> >
> > -       if (parent) {
> > -               ret = kernfs_node_init_security(parent, kn);
> > -               if (ret)
> > -                       goto err_out3;
> > -       }
> > +       ret = kernfs_node_init_security(parent, kn);
> > +       if (ret)
> > +               goto err_out3;
> >
> >          return kn;
> >
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 581944d1e61e..49a083dbc464 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -292,6 +292,7 @@ int security_inode_listsecurity(struct inode
> > *inode, char *buffer, size_t buffer
> >   void security_inode_getsecid(struct inode *inode, u32 *secid);
> >   int security_inode_copy_up(struct dentry *src, struct cred **new);
> >   int security_inode_copy_up_xattr(const char *name);
> > +int security_kernfs_needs_init(void);
> >   int security_kernfs_init_security(const struct qstr *qstr,
> >                                    const struct iattr *dir_iattr,
> >                                    struct simple_xattrs *dir_secattr,
> > @@ -789,6 +790,11 @@ static inline int security_inode_copy_up(struct
> > dentry *src, struct cred **new)
> >          return 0;
> >   }
> >
> > +static inline int security_kernfs_needs_init(void)
> > +{
> > +       return 0;
> > +}
> > +
> >   static inline int security_kernfs_init_security(
> >                  const struct qstr *qstr, const struct iattr *dir_iattr,
> >                  struct simple_xattrs *dir_secattr, const struct iattr *iattr,
> > diff --git a/security/security.c b/security/security.c
> > index 836e0822874a..3c8b9b5baabc 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -892,6 +892,11 @@ int security_inode_copy_up_xattr(const char *name)
> >   }
> >   EXPORT_SYMBOL(security_inode_copy_up_xattr);
> >
> > +int security_kernfs_needs_init(void)
> > +{
> > +       return !hlist_empty(&security_hook_heads.kernfs_init_security);
> > +}
> > +
>
> Yuck. That's an awful lot of infrastructure just to track
> that state. May I suggest that instead you have the
> security_kernfs_init_security() hook return -EOPNOTSUPP
> in the no-LSM case (2nd argument to call_in_hook). You could
> then have a state flag in kernfs that you can set to indicate
> you don't need to call security_kernfs_init_security() again.

Well, maintaining a global variable sounds even more yucky to me...
And I don't understand why you'd consider a simple one-line function
to be "an awful lot of infrastructure" :) But at the end of the day it
is up to the maintainers - Greg/Tejun and James/Serge (who I forgot to
Cc on these patches, sorry) - what works better for them.

>
> >   int security_kernfs_init_security(const struct qstr *qstr,
> >                                    const struct iattr *dir_iattr,
> >                                    struct simple_xattrs *dir_secattr,
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Associate Software Engineer, Security Technologies
> > Red Hat, Inc.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
