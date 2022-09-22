Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC0AC6FA91
	for <selinux@archiver.kernel.org>; Thu, 22 Sep 2022 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVRRX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiIVRRK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 13:17:10 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F44AD4F
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 10:17:09 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-127d10b4f19so14783609fac.9
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RXzIteJ6nCXeS/RjCm/dkwIz5GGoIJdYrPgw6IN0hFg=;
        b=B0sDS+XQgrVw5c7DEKqz0Xr2iGv9rxXbHgO38HfuYPLZKL1Ip0wBQUMgwbpd4nZhPL
         4bF+vXSeLQfjM1irwqmufxvHnb7jX2Zh6FXe/FylJ8xxdgLiGwb3lygCQhk+tpu2c9Ng
         YFxBldJiiDqitLqjDVvTQ9ZxCz2vTLesh/rs9kNGsLJkvVFWxg1tGbZRSg3RmaN3q9yC
         YaRLEYaf5CXpMpCWqcwDkZgh6LWCNKMfURchUCuXwUSd5RnftB3MCCNAeRZOa1bfyYGq
         h8skqxZSCuPrHuS4FeF/KYO/9vrVpcJmTIqNTeYz2wExb6YKRQfD/80s3GGNrQg1btEC
         FehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RXzIteJ6nCXeS/RjCm/dkwIz5GGoIJdYrPgw6IN0hFg=;
        b=Gv+po28ikIyi8nwsye3GGKgw8hRlF978Pmi9ws948raXHkfHzC5ml2kxtVSTpOODOG
         IDI6RAjcAiOhTLNn5p8rRVSTAgpEjd2dJ7EKbK13I6BMx1m7A8YWfwaCq71HixZpdUNo
         HQmDIhfGeIoAu6hnZ1vuuh/hn6XwXl08XrqIXkM8TlpOe7EtiorSH4Dfn00TO9ZG/pCR
         sTkDM2c+kwaOMDOCqiFyX1SS+xyf2QqEPwsMmswfX0swikdyWUF6TrLACXEV3Uf+d6bI
         Tlj2EW2Jqrkpk1U7jEydGfJYwjxQ60I+kDDCIovpalFpk4GssFo+qQMj2AwbePLInYfg
         85Dg==
X-Gm-Message-State: ACrzQf1xio540WWvHgI3/Dl/GvdzZMwE1hJWjpf8bzhrTJ54p9m1Uaga
        DiRI8iDeafpVzWAIvWfr7czZwrU3eYZCLzi94oUy
X-Google-Smtp-Source: AMsMyM6ZsIUYuP1LhazMzrCtrUZzgvpvQn66hg7MoSwjk4Bg2XK7pf5kADeo5MDERr61V9YyqA+X1JTPQwmgQjJ6A0A=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr2697885oaa.172.1663867027871; Thu, 22
 Sep 2022 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
In-Reply-To: <20220922151728.1557914-11-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 13:16:57 -0400
Message-ID: <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 11:18 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module infrastructure and
> audited all codepaths. SELinux has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> this all becomes a very simple hook for SELinux.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  security/selinux/hooks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79573504783b..bbc0ce3bde35 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,6 +3239,13 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
>                             &ad);
>  }
>
> +static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
> +                                struct dentry *dentry, const char *acl_name,
> +                                struct posix_acl *kacl)
> +{
> +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> +}
> +
>  static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>                                         const void *value, size_t size,
>                                         int flags)
> @@ -7063,6 +7070,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
>         LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
>         LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
> +       LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),

See my other reply about needing to see the full patchset in order to
properly review the changes, but one thing immediately jumped out at
me when looking at this: why is the LSM hook
"security_inode_set_acl()" when we are passing a dentry instead of an
inode?  We don't have a lot of them, but there are
`security_dentry_*()` LSM hooks in the existing kernel code.

-- 
paul-moore.com
