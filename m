Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E7C4332F
	for <selinux@archiver.kernel.org>; Thu, 20 Oct 2022 15:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJTPKU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJTPKT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Oct 2022 11:10:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0528DBE60
        for <selinux@vger.kernel.org>; Thu, 20 Oct 2022 08:10:16 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t186so24963256yba.12
        for <selinux@vger.kernel.org>; Thu, 20 Oct 2022 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxP+rdM/oYjqVi5iFPWwICgX+HbH0I69qg9sDr0K1LE=;
        b=KR6cpyzAxPl+7U3Py5QWHOEQQDLxxgZdiJldjiB0XC93zlWcM9n6YQOVPYPnw9oZ1Z
         GPPhCqBd+xNwTj3Ts+b8KiI8NuiklKCJcQXp4p0jocUfNLQ4dhAFNaFs940aUmZ3pt/T
         b3mEq4KGTdfqGAaA1Xa/BFKWKCA8siEtzt5CYoWkcPTEVtwffZr8qUJcRlRuXLlKqbul
         zd9H9aQg5UdGWrjZkBnnzw83O00AlZltUKaXbZBHJ6uLJlhprofGUMJfyR4UElLsDOcV
         I77+Nv5agtB+VHeOADIxrjy/vlBjcqbIvpGI2HXL1AOIB8l4//roECtSDFosB9T/I8L8
         JOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxP+rdM/oYjqVi5iFPWwICgX+HbH0I69qg9sDr0K1LE=;
        b=gjwwl8Mj/qW+rDH7vHAXGGqCwvKKmrN+tZ1PAhm2+cWtaOgGONvjanC82tGEBmTy+4
         AYRQ50pfiDMe2AFewSSp71BKTkkNFxkXIJfDSvZkzVt2L3jWVrwweg++iG9/ow3ByPb5
         JZMl5ZxZRep7OxoTtR65cTuxxy1Uk5gZ4Mnte0YS8VrRcQEob2RSi3t9SYf63PeF94ef
         vprnsKG09HLX1uu4baHnZUoBurIK3jc1ZvC9SzAKVrWkI1O3tp7Z9gwz0NSh3d5dIKV1
         pAMSF99ha5IM484CMaKtYLdCR1+m4aVf37y18APwOFH6XoEMbpvqVOJQtfXzo7f55jDq
         lZuQ==
X-Gm-Message-State: ACrzQf3dHpLtp/cKdoreFsgCldFTn9HzRHVtfLF1u6zYbzVvqYhqDBz4
        Bu+dka4bN/NKrBt8NSWDu6MhwZhAeF8ea1pQ8sDF
X-Google-Smtp-Source: AMsMyM5Rs4oDq+vd5+gdAF1kNXM80oLU8Nh4dNPrK2chva8EHptH9aoAz5t5/3W+hZ2lZSpSV9E5RhiJ/YAMRGa1Bfk=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr11826786ybt.15.1666278615883; Thu, 20
 Oct 2022 08:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <166543910984.474337.2779830480340611497.stgit@olly> <68decac7-f8f7-1569-be84-8419a0e78417@schaufler-ca.com>
In-Reply-To: <68decac7-f8f7-1569-be84-8419a0e78417@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:10:03 -0400
Message-ID: <CAHC9VhQr_deuGRCien23zso+gi0VHUHK8ayYK6sBxmK3DyBOjg@mail.gmail.com>
Subject: Re: [PATCH] lsm: make security_socket_getpeersec_stream() sockptr_t safe
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 20, 2022 at 9:16 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/10/2022 2:58 PM, Paul Moore wrote:
> > Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > sockptr_t argument") made it possible to call sk_getsockopt()
> > with both user and kernel address space buffers through the use of
> > the sockptr_t type.  Unfortunately at the time of conversion the
> > security_socket_getpeersec_stream() LSM hook was written to only
> > accept userspace buffers, and in a desire to avoid having to change
> > the LSM hook the commit author simply passed the sockptr_t's
> > userspace buffer pointer.  Since the only sk_getsockopt() callers
> > at the time of conversion which used kernel sockptr_t buffers did
> > not allow SO_PEERSEC, and hence the
> > security_socket_getpeersec_stream() hook, this was acceptable but
> > also very fragile as future changes presented the possibility of
> > silently passing kernel space pointers to the LSM hook.
> >
> > There are several ways to protect against this, including careful
> > code review of future commits, but since relying on code review to
> > catch bugs is a recipe for disaster and the upstream eBPF maintainer
> > is "strongly against defensive programming", this patch updates the
> > LSM hook, and all of the implementations to support sockptr_t and
> > safely handle both user and kernel space buffers.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Smack part looks ok, I haven't had the opportunity to test it.
> Will do so as I crunch through the backlog.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

John, how do the AppArmor parts look?

> > ---
> >  include/linux/lsm_hook_defs.h |    2 +-
> >  include/linux/lsm_hooks.h     |    4 ++--
> >  include/linux/security.h      |   11 +++++++----
> >  net/core/sock.c               |    3 ++-
> >  security/apparmor/lsm.c       |   29 +++++++++++++----------------
> >  security/security.c           |    6 +++---
> >  security/selinux/hooks.c      |   13 ++++++-------
> >  security/smack/smack_lsm.c    |   19 ++++++++++---------
> >  8 files changed, 44 insertions(+), 43 deletions(-)

-- 
paul-moore.com
