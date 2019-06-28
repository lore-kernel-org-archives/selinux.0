Return-Path: <SRS0=x6Ba=U3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA3C4321A
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E449520665
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 10:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF1KHv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:07:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45381 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1KHv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jun 2019 06:07:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so5399014otq.12
        for <selinux@vger.kernel.org>; Fri, 28 Jun 2019 03:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QTzzZ1pGg2DNxVTH1owqL1jYH/Icsrcb9T9UIShn30=;
        b=iAof/0kAt0bO2x1rqQy4SbiaIKXk0kEkQuGtTXeukE6KnBfVXedPvH80niEEvOObc9
         EUBzetJQcV6JkgC+RmRhRo1lbC5F4lSY0iDJMhXxF2JeNLi+TKVX+DX44mqbqMCepHzh
         z9QlpZ423xG7q+e1RWRW158oUvgWNA3RQkor0LahLShaCVGR+1rfRzK7xgiuSEoxSrPX
         AJRGHzGJTys9emOsCV4AJIIKL1abXeVFxQ1lQMRo+APWP3PHGBeLPP04JQJehEdNsizv
         7StXWQdXoLp9o/CprEsum+qO0Em8rwrM8NYP1hyATBnpiPjO+KYY4cZOwEaOy6XBR9Mg
         CeNA==
X-Gm-Message-State: APjAAAWw5n+4OZB55kWvtxSG7NBxcV1SDDGPOH91E+uocO4aAWs637UL
        XT/HI/9fbsX2N+nf/otcs2CeSF/B4wo7zQd+lE7mTg==
X-Google-Smtp-Source: APXvYqw4+5sFaYXIZEM8UZIX8+8Br1Jar161dsAXk3VI1gSRXorubZEk2/GCQwERTxNC9xLrQ11cGPsqstJUvlZuhUQ=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr6917109otk.43.1561716469823;
 Fri, 28 Jun 2019 03:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190626192234.11725-1-casey@schaufler-ca.com> <20190626192234.11725-19-casey@schaufler-ca.com>
In-Reply-To: <20190626192234.11725-19-casey@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Jun 2019 12:07:38 +0200
Message-ID: <CAFqZXNteNpy0kLfB4hZZ6=5WxRCtzy-sqik1yoiq-+w+tzJo+w@mail.gmail.com>
Subject: Re: [PATCH v4 18/23] LSM: Use lsmcontext in security_dentry_init_security
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 9:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Change the security_dentry_init_security() interface to
> fill an lsmcontext structure instead of a void * data area
> and a length. The lone caller of this interface is NFS4,
> which may make copies of the data using its own mechanisms.
> A rework of the nfs4 code to use the lsmcontext properly
> is a significant project, so the coward's way out is taken,
> and the lsmcontext data from security_dentry_init_security()
> is copied, then released directly.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
>  include/linux/security.h |  7 +++----
>  security/security.c      | 19 +++++++++++++++----
>  3 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index af1c0db29c39..952f805965bb 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -113,6 +113,7 @@ static inline struct nfs4_label *
>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>         struct iattr *sattr, struct nfs4_label *label)
>  {
> +       struct lsmcontext context;
>         int err;
>
>         if (label == NULL)
> @@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>                 return NULL;
>
>         err = security_dentry_init_security(dentry, sattr->ia_mode,
> -                               &dentry->d_name, (void **)&label->label, &label->len);
> -       if (err == 0)
> -               return label;
> +                                           &dentry->d_name, &context);
> +
> +       if (err)
> +               return NULL;
> +
> +       label->label = kmemdup(context.context, context.len, GFP_KERNEL);
> +       if (label->label == NULL)
> +               label = NULL;
> +       else
> +               label->len = context.len;
> +
> +       security_release_secctx(&context);
> +
> +       return label;
>
> -       return NULL;
>  }
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -       struct lsmcontext scaff; /* scaffolding */
> -
> -       if (label) {
> -               lsmcontext_init(&scaff, label->label, label->len, 0);
> -               security_release_secctx(&scaff);
> -       }
> +       kfree(label->label);
>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>  {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7255825aa697..2674eb70c2d7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -352,8 +352,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  int security_add_mnt_opt(const char *option, const char *val,
>                                 int len, void **mnt_opts);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -                                       const struct qstr *name, void **ctx,
> -                                       u32 *ctxlen);
> +                                       const struct qstr *name,
> +                                       struct lsmcontext *ctx);
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>                                         struct qstr *name,
>                                         const struct cred *old,
> @@ -724,8 +724,7 @@ static inline void security_inode_free(struct inode *inode)
>  static inline int security_dentry_init_security(struct dentry *dentry,
>                                                  int mode,
>                                                  const struct qstr *name,
> -                                                void **ctx,
> -                                                u32 *ctxlen)
> +                                                struct lsmcontext *ctx)
>  {
>         return -EOPNOTSUPP;
>  }
> diff --git a/security/security.c b/security/security.c
> index 97b468f6e6a9..61cdc6bcd32e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1024,11 +1024,22 @@ void security_inode_free(struct inode *inode)
>  }
>
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -                                       const struct qstr *name, void **ctx,
> -                                       u32 *ctxlen)
> +                                 const struct qstr *name,
> +                                 struct lsmcontext *cp)
>  {
> -       return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> -                               name, ctx, ctxlen);
> +       int *display = current->security;
> +       struct security_hook_list *hp;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
> +                            list)
> +               if (*display == LSMBLOB_INVALID ||
> +                   *display == hp->lsmid->slot) {
> +                       cp->slot = hp->lsmid->slot;
> +                       return hp->hook.dentry_init_security(dentry, mode,
> +                                       name, (void **)&cp->context, &cp->len);
> +               }

Sorry for chiming in only now, but does it really make sense to select
the per-task display LSM here? I'm not sure what exactly NFS does with
the returned context, but if it sends it to the server (it looks like
it does), wouldn't this mean that the server would potentially get
context from different LSMs, depending on the setting of the task
which is creating the file/directory?

> +
> +       return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);
>
> --
> 2.20.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
