Return-Path: <SRS0=r71v=SA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8AC10F05
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB614217F5
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 13:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="leA0Q9uR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfC2Nby (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:31:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfC2Nby (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Mar 2019 09:31:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so1465585lfn.3
        for <selinux@vger.kernel.org>; Fri, 29 Mar 2019 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2356nEa1IQz9PWJfmQZF0VPKIJHhBMQTILqXkfrpMzo=;
        b=leA0Q9uRttndHh3xeXXkF+XycLRwtDS/ltwdElZ+onnOyLO/H/g3AtTHH50yIG3uUs
         zMMsKNCY437Q4nThSzp32p8EN/OuevzAtLcogQ+PnfPHZgrDfC0rhuZ4NFe2PE8bikFt
         y11oV71TpNlONjaUbkDDxn2SQ22TStHRIGgn62/mXHJ39gbGnSLlWpEXcoo0a9vkgaWi
         tYd2e5Wv+G7iqa52HwrVRWW52NivE/4a7jnQ0Gk+tg5E/c9bxhlKQv1CG2JIATMtg93S
         bZ2NMk4NJPTxLP5mVzjWDCYaicmO+Ng0Yz9q3m++RlgCEjVqFUbqh3uc32bEQlRP9Dge
         CpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2356nEa1IQz9PWJfmQZF0VPKIJHhBMQTILqXkfrpMzo=;
        b=rCVAEq104NaGWCevEaDbdENkZvJ6gAnI7KwacPHPgDrd7FDWCQ64+nPT+qBGkZVOKS
         6pTedWcvMjoRNIYPsOdAZY9Q8iZIszgYo5UwAn+6IpNmR1s2U05vO56lIfL8y+BaEK+N
         rspXLlxERvnSeGl3EH/0Hos0S48zPKvP1L0dYx1Z7pM/PoXNMvnqzqmHpkUpk7Y+OjNV
         w8ZnOwZAX+sdem8kqvjqJ+tkJo7IbZqmoGVoqqIbRfyYHGexVSnmgN5Pr/KNBtVS3Ugv
         w3nTZ8189j/gh8TYQJ/+pXuKeCaN+8TigKHopXHntL3QQBCmGyfGktQxjYgkGudubGNU
         XNmQ==
X-Gm-Message-State: APjAAAUe5gg1x5QxlFO4q1Wh1jdgNst4r94yquj1BL5DrYZb7fsKBY/A
        6xV201cNGt5It/6qKiji+z/2s7xcOZxnGv5otxrsVPE=
X-Google-Smtp-Source: APXvYqzuMXI24upZyfMgTQsbEEhrc3DkX4AuLGZKerOxl9G93Jl/T/zxHrBLyx/23+Mln/fXt+ZzwuukD4vhELtInYU=
X-Received: by 2002:ac2:5921:: with SMTP id v1mr12844332lfi.135.1553866311507;
 Fri, 29 Mar 2019 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190326121210.17414-1-omosnace@redhat.com>
In-Reply-To: <20190326121210.17414-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 29 Mar 2019 09:31:40 -0400
Message-ID: <CAHC9VhQsi-gf2BQOcNLzF=JDZ=0Noj3DQH3iA+7FC3ThwN4BAg@mail.gmail.com>
Subject: Re: [PATCH v2] kernfs: fix xattr name handling in LSM helpers
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 26, 2019 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The implementation of kernfs_security_xattr_*() helpers reuses the
> kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> and extract full xattr name from it using xattr_full_name(). However,
> this function relies on the fact that the suffix passed to xattr
> handlers from VFS is always constructed from the full name by just
> incerementing the pointer. This doesn't necessarily hold for the callers
> of kernfs_security_xattr_*(), so their usage will easily lead to
> out-of-bounds access.
>
> Fix this by converting the helpers to take the full xattr name instead
> of just the suffix and moving the reconstruction to the xattr handlers.
> We now need to check if the prefix is correct in the helpers, but it
> saves us the difficulty of reconstructing the full name from just the
> plain suffix.
>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: Rebase on current selinux/next.
>
>  fs/kernfs/inode.c        | 38 ++++++++++++++++++--------------------
>  include/linux/kernfs.h   |  8 ++++----
>  security/selinux/hooks.c |  6 +++---
>  3 files changed, 25 insertions(+), 27 deletions(-)

Thanks for diagnosing this and providing a patch.  I haven't seen any
objections, but I do have some questions (below).

> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 673ef598d97d..1daa8aa9ec96 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -288,28 +288,20 @@ int kernfs_iop_permission(struct inode *inode, int mask)
>         return generic_permission(inode, mask);
>  }
>
> -static int kernfs_node_xattr_get(const struct xattr_handler *handler,
> -                                struct kernfs_node *kn, const char *suffix,
> +static int kernfs_node_xattr_get(struct kernfs_node *kn, const char *name,
>                                  void *value, size_t size)
>  {
> -       const char *name = xattr_full_name(handler, suffix);
> -       struct kernfs_iattrs *attrs;
> -
> -       attrs = kernfs_iattrs_noalloc(kn);
> +       struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
>         if (!attrs)
>                 return -ENODATA;
>
>         return simple_xattr_get(&attrs->xattrs, name, value, size);
>  }
>
> -static int kernfs_node_xattr_set(const struct xattr_handler *handler,
> -                                struct kernfs_node *kn, const char *suffix,
> +static int kernfs_node_xattr_set(struct kernfs_node *kn, const char *name,
>                                  const void *value, size_t size, int flags)
>  {
> -       const char *name = xattr_full_name(handler, suffix);
> -       struct kernfs_iattrs *attrs;
> -
> -       attrs = kernfs_iattrs(kn);
> +       struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
>         if (!attrs)
>                 return -ENOMEM;
>

...

> -int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
> +int kernfs_security_xattr_get(struct kernfs_node *kn, const char *name,
>                               void *value, size_t size)
>  {
> -       return kernfs_node_xattr_get(&kernfs_security_xattr_handler,
> -                                    kn, suffix, value, size);
> +       if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
> +               return -EINVAL;
> +
> +       return kernfs_node_xattr_get(kn, name, value, size);
>  }
>
> -int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
> +int kernfs_security_xattr_set(struct kernfs_node *kn, const char *name,
>                               void *value, size_t size, int flags)
>  {
> -       return kernfs_node_xattr_set(&kernfs_security_xattr_handler,
> -                                    kn, suffix, value, size, flags);
> +       if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
> +               return -EINVAL;
> +
> +       return kernfs_node_xattr_set(kn, name, value, size, flags);
>  }

I think it is reasonable to ask if we even need
kernfs_security_xattr_{set|get}()?  Can we just call the respective
kernfs_node_xattr*() functions instead?  I can't imagine the
WARN_ON_ONCE check being that important.

-- 
paul moore
www.paul-moore.com
