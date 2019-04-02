Return-Path: <SRS0=LBM0=SE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996FAC4360F
	for <selinux@archiver.kernel.org>; Tue,  2 Apr 2019 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690FC207E0
	for <selinux@archiver.kernel.org>; Tue,  2 Apr 2019 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EkauTH8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDBXLH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:11:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXLH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Apr 2019 19:11:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so8444902lje.9
        for <selinux@vger.kernel.org>; Tue, 02 Apr 2019 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC/bAbaXjoogDVdh3a6r+cETVS6f+eS73GbY7KfNWso=;
        b=EkauTH8CkHd7oU7+qE9YBONLzSPXQiIVxNR8OjKBVj2NHGNBrtbELjR4pBojy+hAZn
         T3OMbLSb4YJ64HLilM7km4kpxXmAD4mHEaNCl4Rft/UAA0QX1wa602rCe7XJFaq0S2fn
         zu5ew3fKKySBa7NEfCW6Ywv90242OJOoXxoeIy1JC3Wp/uPjsOFlIryKFgnEBr2GUBdB
         XX+ElXnGjvv2Hi6siTq+PgHUeTliJ6EGiAWz8+Hw1nSeo/vNtLHCFOPVTe2Chz/LXnfs
         osw0lD2097H6WOSdXqC7o6ioxmDuEvnhVhl9wu71UBvMTlCbEGtGXm1sQU7mfZ6ArhKT
         yzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC/bAbaXjoogDVdh3a6r+cETVS6f+eS73GbY7KfNWso=;
        b=Xl8BTLznZU17UrIBdlGuA71tURXEWaItU2QLj+DGPY7bIvcwOIxKVG5lp/Nl4QkaQB
         DHAja4Ygrb4mmCevzIS+JvelEmShPsEHbZS7MSS598xQPMgHfk9/qrA+jpkRLPG47KY3
         9lIdGeBybINAbU4BJjhkEd/8Pn6kmF3LiYgr1C+kq7d17peSBzVjkobbntfQHZaCwS30
         Ho8nd/UeLRjt3PmLgYLpSneFJCREGjrq8zGCIccsb3Qlnhir6wli+drpVIl7vUaT4h2U
         mDK+TBXJfGhhMxvLFbK+S4+h922O+6dbQ4xi/CfvgwSY+1MtTP9wPhDv9eS1bZ8GB17h
         VQ1w==
X-Gm-Message-State: APjAAAVE4928meUDGIRFAXRR5hglK2IMLUOtHbGB07BMMZTj+J10CP+Q
        XMqnKSVc9Kqbx4F0+SBlCPl4cKVD78YV8IxKvnUa
X-Google-Smtp-Source: APXvYqwNIdEgXo2R+/nHosJPYyV8MikWqrFRmvFnkJBRYR7gajsKburTOjfDYqRRy++cpzdcTJXR/yNjyoBAphEvS7s=
X-Received: by 2002:a2e:9649:: with SMTP id z9mr4339935ljh.92.1554246665298;
 Tue, 02 Apr 2019 16:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190401103403.14130-1-omosnace@redhat.com>
In-Reply-To: <20190401103403.14130-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Apr 2019 19:10:54 -0400
Message-ID: <CAHC9VhSpHHeXHd3winROvmto5RULQYnfQB30nO_FcQ35WLxFfA@mail.gmail.com>
Subject: Re: [PATCH v3] kernfs: fix xattr name handling in LSM helpers
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

On Mon, Apr 1, 2019 at 6:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The implementation of kernfs_security_xattr_*() helpers reuses the
> kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> and extract full xattr name from it using xattr_full_name(). However,
> this function relies on the fact that the suffix passed to xattr
> handlers from VFS is always constructed from the full name by just
> incerementing the pointer. This doesn't necessarily hold for the callers
> of kernfs_security_xattr_*(), so their usage will easily lead to
> out-of-bounds access.
>
> Fix this by moving the xattr name reconstruction to the VFS xattr
> handlers and replacing the kernfs_security_xattr_*() helpers with more
> general kernfs_xattr_*() helpers that take full xattr name and allow
> accessing all kernfs node's xattrs.
>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v3: simplify kernfs xattr helpers as per Paul's suggestion
> v2: just rebase to update diff context
>
>  fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
>  include/linux/kernfs.h   | 18 ++++++------
>  security/selinux/hooks.c |  9 +++---
>  3 files changed, 33 insertions(+), 56 deletions(-)

This is better, thanks.  Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
