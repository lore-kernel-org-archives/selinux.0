Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F91C4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 13:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55A52171F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 13:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IF25Qxbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDDNKS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:10:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43692 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDNKS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 09:10:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id g7so1719895lfh.10
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLyk1kV2vmc7mJPEAZ5smYeQGe+1ETJlaApvUF3o79M=;
        b=IF25Qxbg0kpF48wrtrl7tsDN3IPhhZN+MWTqNGQDLlE97aQpZd70iXoyiPkBHa/2d8
         hpZkKkJnmHwdqrTZwnFfRi4TWNfHO0QKW+88OzxlxIS4On/0vXM+HqQrbZZ2xEWOsoNa
         oALwR1XM3AFDWHOSXGKowcNYXtPKIlfhsJ/wcZAZfVkgV8BC9fj3DC15GQVa6Qm1eMeq
         ApPqgfettopyaYUbTMx742QzeFErxOXkZqpQhGyB/pWMyZi564/sZwHuLt6H6xE1/++F
         3FXtQaDzGY+3mrWAfOG6ZnE57dSikBOiPdO7PB03WKf1hytcNOLgp1+S91J9TIdunqRI
         WU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLyk1kV2vmc7mJPEAZ5smYeQGe+1ETJlaApvUF3o79M=;
        b=SyW1+hLr00wq6TUG2/usBZ1mmgJyCLqovwymR9C8YF/uoVt/17LJl+euYbEGBzKPY8
         hpbqD06Gp2c60q/b18a1JhwrFtdBdQTdKNheE8la3YafTVtSU+YzPBmXV4ZUXuKETCub
         22lU2E+iQAL/Whhq0l0BCdECAsKx9OAtsXpUeFRpqaKFKGWJtzMy9BEoOjgwWkkFEyXa
         10auVBYfqLIhDUqbdzwH36EaguX4+piYn3to24bC/8sgdCL2vVl1STr1Bq+2ORsajggR
         OOQT88+G8EOpfZIO63oXx+cgEliAp+gweVLT7Aci74DrKcnn7JOsnfyc08AEkxPUMLz8
         wihw==
X-Gm-Message-State: APjAAAXhUZiFw2s8g1BKO7eKYC0W3cr3fu/pQ6pb2popv0g51kK1LJH2
        EvdVrzl22Qn3MtrD6uZalFaOJ//XbM2/sIx+pmNt
X-Google-Smtp-Source: APXvYqzjCdcVJdYje+PbxyG60NplzpQiQxGhPjNwOIVivGtRcqlkBqiUYiSUIr2rUERnMLHTLjrfxpDV/h3mW0DXLKA=
X-Received: by 2002:ac2:592f:: with SMTP id v15mr3251269lfi.133.1554383415703;
 Thu, 04 Apr 2019 06:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190403072941.26520-1-omosnace@redhat.com>
In-Reply-To: <20190403072941.26520-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Apr 2019 09:10:04 -0400
Message-ID: <CAHC9VhReUG0Hm+BmH_rpaMm4WAOsiDw6BmbE2w+WvkVmMmyjog@mail.gmail.com>
Subject: Re: [PATCH v4] kernfs: fix xattr name handling in LSM helpers
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

On Wed, Apr 3, 2019 at 3:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> v4: fix function names and types to make it build...
> v3: simplify kernfs xattr helpers as per Paul's suggestion
> v2: just rebase to update diff context
>
>  fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
>  include/linux/kernfs.h   | 18 ++++++------
>  security/selinux/hooks.c |  9 +++---
>  3 files changed, 33 insertions(+), 56 deletions(-)

Merged.

-- 
paul moore
www.paul-moore.com
