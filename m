Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52AC282C3
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CA22084C
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfAVItM convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:49:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41237 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAVItM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 03:49:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so16744635oii.8
        for <selinux@vger.kernel.org>; Tue, 22 Jan 2019 00:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7s7qNyiJXTKmSzwi/lTvEMRuzR/r3j0DmiFM0tXsm8o=;
        b=It9GBjAJKIxdyddq4cZWV0v0Edm1da65otMrdmbZ/Eu5QgOzBcY3tfi71fls74FpQy
         Riu7Q8Xv+IubJckpYeGUAr89ythRepqQ5GmQr/8N9aHUCuJ2Kf2gXnd7+PzDm+EJDle1
         Bkq12zFCB/ezwSMlGEX9MrZqZDYfiXXwkN2sgKfBO6F8pVoeKb4W4DRh67Er6YGUVyVR
         ieQk7F43k0qtuTOAgn7Siwhj25hFUpnJJLoK/ovRMD+E7EFdCbXki/uDyG1unhtOI3fQ
         CazADHhoXces59iCT2qNkEV48rLrthwOKaPUiwJS6cy/nLTbWuL/68HiakTI36BuO+e+
         AXQw==
X-Gm-Message-State: AJcUukcltXxPVlxzNcPMGCYwA2Ur5yHONhoHXTXSks3oVj42bPXkZ7sL
        DWy806SrXY/ce+HvAcW94rCX2VkufkZWTssIZAgAgg==
X-Google-Smtp-Source: ALg8bN7wavOuxerF8r0MAjQurGa3dMgMIsxFq65tEauqm6OUco17Bd/w/2mz4WM7dXmbVYGP18upJZBLJ2XtWXtQ53I=
X-Received: by 2002:aca:3b43:: with SMTP id i64mr7945440oia.156.1548146951424;
 Tue, 22 Jan 2019 00:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov> <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov> <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com>
In-Reply-To: <CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 22 Jan 2019 09:49:01 +0100
Message-ID: <CAFqZXNsm2+79gMTqhxoZuPgibxfhSjJXu8742o7Ho7Yrf=2QCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 14, 2019 at 10:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jan 10, 2019 at 6:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > Resending after email configuration repair.
> >
> > On 1/10/2019 6:15 AM, Stephen Smalley wrote:
> > > On 1/9/19 5:03 PM, Casey Schaufler wrote:
> > >> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
> > >>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
> > >>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> > >>>>> Changes in v2:
> > >>>>> - add docstring for the new hook in union security_list_options
> > >>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
> > >>>>>     implemented
> > >>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
> > >>>>>
> > >>>>> This series adds a new security hook that allows to initialize the security
> > >>>>> context of kernfs properly, taking into account the parent context. Kernfs
> > >>>>> nodes require special handling here, since they are not bound to specific
> > >>>>> inodes/superblocks, but instead represent the backing tree structure that
> > >>>>> is used to build the VFS tree when the kernfs tree is mounted.
> > >>>>>
> > >>>>> The kernfs nodes initially do not store any security context and rely on
> > >>>>> the LSM to assign some default context to inodes created over them.
> > >>>>
> > >>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
> > >>>> and expected filesystem behavior?
> > >>>
> > >>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
> > >>>
> > >>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
> > >>
> > >> OK, so as I said, this seems like a bug in kernfs.
> > >>
> > >>>
> > >>>>
> > >>>>> Kernfs
> > >>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
> > >>>>> syscalls, in which case the context is stored inside the kernfs node's
> > >>>>> metadata.
> > >>>>>
> > >>>>> SELinux (and possibly other LSMs) initialize the context of newly created
> > >>>>> FS objects based on the parent object's context (usually the child inherits
> > >>>>> the parent's context, unless the policy dictates otherwise).
> > >>>>
> > >>>> An LSM might use information about the parent other than the "context".
> > >>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
> > >>>> to determine whether the Smack label of the new object should be taken
> > >>>> from the parent or the process. Passing the "context" of the parent is
> > >>>> insufficient for Smack.
> > >>>
> > >>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
>
> I actually had a patch to do just that at one point because I thought
> for a while that it would be required to call
> security_inode_init_security() (which I had tried to somehow force
> into the kernfs node creation at some point), but then I realized it
> is not actually needed (although would make thing a bit nicer) and put
> it away... I will try to dig it out and reuse here.

Okay, now that I tried to do this with full xattr support I ran into a
problem. Along with converting kernfs to use simple_xattrs for
security attributes, I removed the call to
security_inode_notifysecctx() from kernfs_refresh_inode(), as it no
longer makes sense (kernfs doesn't know which attribute contains the
context; the LSM should now be able to pull it out via
vfs_getxattr()). However, SELinux now doesn't set the right security
context in the selinux_d_instantiate() hook, because the policy tells
it to use genfs, not xattr.

So... I'm not sure how to fix this. Setting fs_use_xattr for cgroupfs
in the policy won't work, because then all nodes will be unlabeled_t
by default. Maybe we could patch the genfs case in
inode_doinit_with_dentry() to try fetching the xattr first? I'm not
very confident about touching that part of the code, so I would
welcome some advice here.

This is the code I have so far, in case it helps:
https://gitlab.com/omos/linux-public/compare/selinux-next...selinux-fix-cgroupfs-v8

Thanks,

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
