Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA4FC43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4C3214C6
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="stPbXBkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAKCIg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:08:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43478 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfAKCIf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 21:08:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so9702026lff.10
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 18:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhZdovnTgZKkkGT1/pMtCVtaCubiTiMFRVFWsnY7Gw0=;
        b=stPbXBktrgsNiIJ52M/09WNwi6qNW6wM/BAEF8tZncufjtzSgYBXOxaCEiTMWsQD5O
         CVjonijW5IaxYOYFo43/n5mbA/eYdcgpoHGM4knBZZn0hAybt2cDDlblShf/2SlTZ19C
         raew/ZWRzBVsTt+ZTT5N3L7kTuDqeE6AsRg9IgE7Y0zFI7xkX9ofnS36Otbg981Op9Kr
         mMGMrrP81FPlxapzS0hbMCIIcohiW+V0gAt1UFZcIz4wY1FtufURPTWGoymc2Apmzs3X
         n11Dj5wTvpcrCwqmJ3OzSxLIauIt+QDW9DsL5k0SmoAuaynpNSCJSMthcJP0MXHChMYn
         ovNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhZdovnTgZKkkGT1/pMtCVtaCubiTiMFRVFWsnY7Gw0=;
        b=L6OaJZI/8Ym4lLelwUbtNv99h44Q58wIwTXXs7s1auOsAjKw3pU9tSxfRgLcuTS8CI
         8o9IkKazyBM2i7926taKEWhwjJTHMMmcSqtAeV48GbaVXJ+JksJ7NfsOWkithd8abLkP
         IJrmGUImonmuxtPPbROowD/e05tANs49yIJN05iQgnBryDD7D+nFZTBib1/31Jkl41Pc
         DbzloUug3/a5MHVQoSMGtRqbShHA+2ABKgAf6CklvEetzK8IkKm/1iCX3Jef506o+RyR
         u/rk2X9jU72YO/YqATk4Uu65B6it3QiAxSUWCsKDC964ylrsl6OfoAVgA/5kzIwDLKVq
         YQSQ==
X-Gm-Message-State: AJcUukfdf9dGfBw/cFDJRDYL6Z1V/K6lcmvBeuVij2MjFUO171wiVbHe
        cT1bPy0pI6BUThU3PVHyU0wYy8O9Yi3L+HMM81Lt
X-Google-Smtp-Source: ALg8bN7zjOtDgZLRVzLYjT8r7lFbXMPGUmJyNkCAbgSRQc7DdfZ77/9dZN3QakhHyk5pLlRIbv6fOkgBD+jR0n7Ftq0=
X-Received: by 2002:a19:f115:: with SMTP id p21mr6809533lfh.20.1547172512466;
 Thu, 10 Jan 2019 18:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20190109091028.24485-1-omosnace@redhat.com> <20190109091028.24485-4-omosnace@redhat.com>
 <ea48be7a-1319-36ca-adfb-89c00f822a4b@tycho.nsa.gov>
In-Reply-To: <ea48be7a-1319-36ca-adfb-89c00f822a4b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 21:08:21 -0500
Message-ID: <CAHC9VhQ860x2Qf4QA=kvLSRj6Cooi5RT5Usc6CRDDaQrDVE9fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kernfs: Initialize security of newly created nodes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 10:42 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
> > Use the new security_object_init_security() hook to allow LSMs to
> > possibly assign a non-default security context to newly created nodes
> > based on the context of their parent node.
> >
> > This fixes an issue with cgroupfs under SELinux, where newly created
> > cgroup subdirectories would not inherit its parent's context if it had
> > been set explicitly to a non-default value (other than the genfs context
> > specified by the policy). This can be reproduced as follows:
> >
> >      # mkdir /sys/fs/cgroup/unified/test
> >      # chcon -R system_u:object_r:cgroup_t:s0:c123 /sys/fs/cgroup/unified/test
> >      # ls -lZ /sys/fs/cgroup/unified
> >      total 0
> >      -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.controllers
> >      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.depth
> >      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.descendants
> >      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.procs
> >      -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.stat
> >      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.subtree_control
> >      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.threads
> >      drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 init.scope
> >      drwxr-xr-x. 25 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 system.slice
> >      drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0:c123 0 Jan  8 04:59 test
> >      drwxr-xr-x.  3 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:55 user.slice
> >      # mkdir /sys/fs/cgroup/unified/test/subdir
> >
> > Actual result:
> >
> >      # ls -ldZ /sys/fs/cgroup/unified/test/subdir
> >      drwxr-xr-x. 2 root root system_u:object_r:cgroup_t:s0 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir
> >
> > Expected result:
> >
> >      # ls -ldZ /sys/fs/cgroup/unified/test/subdir
> >      drwxr-xr-x. 2 root root unconfined_u:object_r:cgroup_t:s0:c123 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir
> >
> > Link: https://github.com/SELinuxProject/selinux-kernel/issues/39
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks okay to me as well.

Some part of me wonders if it might be smart to check for non-NULL
secdata being returned from kernfs_node_setsecdata and doing a WARN.
Maybe I'm overly pessimistic, but I'm pretty sure
kernfs_node_init_security() will get improperly used at some point.
At least we have a comment to *maybe* warn future abusers.

> > ---
> >   fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
> >   fs/kernfs/inode.c           |  9 +++----
> >   fs/kernfs/kernfs-internal.h |  4 +++
> >   3 files changed, 54 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 4ca0b5c18192..8a678a934f65 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/security.h>
> >   #include <linux/hash.h>
> > +#include <linux/stringhash.h>
> >
> >   #include "kernfs-internal.h"
> >
> > @@ -617,7 +618,43 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
> >       return NULL;
> >   }
> >
> > -static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > +                                  struct kernfs_node *kn, umode_t mode)
> > +{
> > +     struct kernfs_iattrs *attrs;
> > +     struct qstr q;
> > +     void *ctx;
> > +     u32 ctxlen;
> > +     int ret;
> > +
> > +     /* If parent has no explicit context set, leave child unset as well */
> > +     if (!parent->iattr)
> > +             return 0;
> > +     if (!parent->iattr->ia_secdata || !parent->iattr->ia_secdata_len)
> > +             return 0;
> > +
> > +     q.name = kn->name;
> > +     q.hash_len = hashlen_string(parent, kn->name);
> > +
> > +     ret = security_object_init_security(parent->iattr->ia_secdata,
> > +                                         parent->iattr->ia_secdata_len,
> > +                                         &q, (u16)mode, &ctx, &ctxlen);
> > +     if (ret)
> > +             return ret;
> > +
> > +     attrs = kernfs_iattrs(kn);
> > +     if (!attrs) {
> > +             security_release_secctx(ctx, ctxlen);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     kernfs_node_setsecdata(attrs, &ctx, &ctxlen);
> > +     /* The inode is fresh, so the returned ctx is always NULL. */
> > +     return 0;
> > +}
> > +
> > +static struct kernfs_node *__kernfs_new_node(struct kernfs_node *parent,
> > +                                          struct kernfs_root *root,
> >                                            const char *name, umode_t mode,
> >                                            kuid_t uid, kgid_t gid,
> >                                            unsigned flags)
> > @@ -674,6 +711,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >                       goto err_out3;
> >       }
> >
> > +     if (parent) {
> > +             ret = kernfs_node_init_security(parent, kn, mode);
> > +             if (ret)
> > +                     goto err_out3;
> > +     }
> > +
> >       return kn;
> >
> >    err_out3:
> > @@ -692,7 +735,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
> >   {
> >       struct kernfs_node *kn;
> >
> > -     kn = __kernfs_new_node(kernfs_root(parent),
> > +     kn = __kernfs_new_node(parent, kernfs_root(parent),
> >                              name, mode, uid, gid, flags);
> >       if (kn) {
> >               kernfs_get(parent);
> > @@ -962,7 +1005,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
> >       INIT_LIST_HEAD(&root->supers);
> >       root->next_generation = 1;
> >
> > -     kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
> > +     kn = __kernfs_new_node(NULL, root, "", S_IFDIR | S_IRUGO | S_IXUGO,
> >                              GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> >                              KERNFS_DIR);
> >       if (!kn) {
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index 80cebcd94c90..e6db8d23437b 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -31,7 +31,7 @@ static const struct inode_operations kernfs_iops = {
> >       .listxattr      = kernfs_iop_listxattr,
> >   };
> >
> > -static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
> > +struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
> >   {
> >       static DEFINE_MUTEX(iattr_mutex);
> >       struct kernfs_iattrs *ret;
> > @@ -135,8 +135,8 @@ out:
> >       return error;
> >   }
> >
> > -static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> > -                               u32 *secdata_len)
> > +void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> > +                         u32 *secdata_len)
> >   {
> >       void *old_secdata;
> >       size_t old_secdata_len;
> > @@ -149,7 +149,6 @@ static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> >
> >       *secdata = old_secdata;
> >       *secdata_len = old_secdata_len;
> > -     return 0;
> >   }
> >
> >   ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
> > @@ -365,7 +364,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
> >               return error;
> >
> >       mutex_lock(&kernfs_mutex);
> > -     error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
> > +     kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
> >       mutex_unlock(&kernfs_mutex);
> >
> >       if (secdata)
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index 3d83b114bb08..f6fb2df24c30 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -92,6 +92,10 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
> >   ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
> >   int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
> >
> > +struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn);
> > +void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> > +                         u32 *secdata_len);
> > +
> >   /*
> >    * dir.c
> >    */
> >
>


-- 
paul moore
www.paul-moore.com
