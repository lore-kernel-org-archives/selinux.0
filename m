Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD59C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB08206B6
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfAIQGp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:06:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41445 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfAIQGp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 11:06:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so7119274otk.8
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 08:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocFFke436NF/bG+puZTfV9GrEoRJqM69xXOI7KQrI9I=;
        b=bNFrfwTt41pRqA9L7de5ey+m2fffaeESoytDGmB/ZuRoIWtyAjG/O6qtOjp3rYAGbY
         /v+fpG5RairhOuD9NhtMtZ1FKsMy4gCpFEqZ+bCD9ebvJMLS/hpEg/18YVKUlETbD0sz
         Dj1wV7jBJE9uvbO9i58NzDSsmYsBHF2hqPb0F50aho/YPZs6vMTUv0ID9LCzuMeX17yl
         Vwzwn5ZUxn+WZMrlgD/EIkoM/AMDiEVllaLekXNnPU/566YwKqnRu6O1Cb0zvpQO86lW
         /wpzHgq+AeMihapQwx61MRtXH9cR1+nNYV+7cB5KlRB75z6rfNyOreGKCXHcW7vPu0Fe
         BAZQ==
X-Gm-Message-State: AJcUuke7dhiw9TYKDiTuBfdCd5vXLWGpsBhp42tAK4IK9NbPseb9Mu5D
        RV274QjeGTOObGOSU9Be6pWMK9m2LuF5tNzyC9/PKQ==
X-Google-Smtp-Source: ALg8bN7293ImC2TFfgh8ihUnQYRWXx5W5711bwbd1x75ViJ8JNBnm6rLI/BDovzzp4bCL4vawEaCK8TdA+TL9I1i/O8=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr4269490otf.52.1547050003963;
 Wed, 09 Jan 2019 08:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20190109091028.24485-1-omosnace@redhat.com> <20190109091028.24485-2-omosnace@redhat.com>
 <34700932-359e-5b01-565c-0816dd4a1940@tycho.nsa.gov>
In-Reply-To: <34700932-359e-5b01-565c-0816dd4a1940@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Jan 2019 17:06:33 +0100
Message-ID: <CAFqZXNuicdDTxzO2k2jW43cg+xaLb-cAHjub0Hrr-YN8O84qjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] LSM: Add new hook for generic node initialization
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 3:33 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
> > This patch introduces a new security hook that is intended for
> > initializing the security data for newly created pseudo filesystem
> > objects (such as kernfs nodes) that provide a way of storing a
> > non-default security context, but need to operate independently from
> > mounts.
> >
> > The main motivation is to allow kernfs nodes to inherit the context of
> > the parent under SELinux, similar to the behavior of
> > security_inode_init_security(). Other LSMs may implement their own logic
> > for handling the creation of new nodes.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   include/linux/lsm_hooks.h |  5 +++++
> >   include/linux/security.h  | 12 ++++++++++++
> >   security/security.c       |  8 ++++++++
> >   3 files changed, 25 insertions(+)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index aaeb7fa24dc4..f2b4c0bf4a7b 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1556,6 +1556,10 @@ union security_list_options {
> >       int (*inode_copy_up)(struct dentry *src, struct cred **new);
> >       int (*inode_copy_up_xattr)(const char *name);
> >
> > +     int (*object_init_security)(void *parent_ctx, u32 parent_ctxlen,
> > +                                 const struct qstr *qstr, u16 mode,
> > +                                 void **ctx, u32 *ctxlen);
>
> You'll want to add a kerneldoc comment for the new hook; see the
> existing ones for the other hooks at the top of lsm_hooks.h.

Good point, will add that in v2, thanks.

>
> > +
> >       int (*file_permission)(struct file *file, int mask);
> >       int (*file_alloc_security)(struct file *file);
> >       void (*file_free_security)(struct file *file);
> > @@ -1855,6 +1859,7 @@ struct security_hook_heads {
> >       struct hlist_head inode_getsecid;
> >       struct hlist_head inode_copy_up;
> >       struct hlist_head inode_copy_up_xattr;
> > +     struct hlist_head object_init_security;
> >       struct hlist_head file_permission;
> >       struct hlist_head file_alloc_security;
> >       struct hlist_head file_free_security;
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index d170a5b031f3..e20d1f378ea4 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -315,6 +315,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
> >   void security_inode_getsecid(struct inode *inode, u32 *secid);
> >   int security_inode_copy_up(struct dentry *src, struct cred **new);
> >   int security_inode_copy_up_xattr(const char *name);
> > +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> > +                               const struct qstr *qstr, u16 mode,
> > +                               void **ctx, u32 *ctxlen);
> >   int security_file_permission(struct file *file, int mask);
> >   int security_file_alloc(struct file *file);
> >   void security_file_free(struct file *file);
> > @@ -815,6 +818,15 @@ static inline int security_inode_copy_up_xattr(const char *name)
> >       return -EOPNOTSUPP;
> >   }
> >
> > +static inline int security_object_init_security(void *parent_ctx,
> > +                                             u32 parent_ctxlen,
> > +                                             const struct qstr *qstr,
> > +                                             u16 mode, void **ctx,
> > +                                             u32 *ctxlen)
> > +{
> > +     return 0;

I just realized I will need to assign *ctx to NULL and *ctxlen to 0
here, since I chose to return 0 by default...

> > +}
> > +
> >   static inline int security_file_permission(struct file *file, int mask)
> >   {
> >       return 0;
> > diff --git a/security/security.c b/security/security.c
> > index 04d173eb93f6..56e77368b87f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -879,6 +879,14 @@ int security_inode_copy_up_xattr(const char *name)
> >   }
> >   EXPORT_SYMBOL(security_inode_copy_up_xattr);
> >
> > +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> > +                               const struct qstr *qstr, u16 mode,
> > +                               void **ctx, u32 *ctxlen)
> > +{
> > +     return call_int_hook(object_init_security, 0, parent_ctx, parent_ctxlen,
> > +                          qstr, mode, ctx, ctxlen);

Same here, in case there is no object_init_security hook provided by the LSM.

> > +}
> > +
> >   int security_file_permission(struct file *file, int mask)
> >   {
> >       int ret;
> >
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
