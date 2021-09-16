Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B35C433F5
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 14:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B360238
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhIPOIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbhIPOIp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 10:08:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A1C061574
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 07:07:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so17324015edt.7
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqKjw9wQXgOAIHdR23lI/gjq+FKkcG9gMYu8YLG7JPo=;
        b=X8R38bilPb9UJMFbGupYovxfZQ59V7GYJYem0Rm6E/MC31/9X4JSXIwW02Q4QoWM2H
         MobuveVE9qxcHXBwN+rPoBw5XFOTHaJqgBUuIVd2688tRzORtfvxkgcg1Hd4tdc67D28
         BWNNtdjt8iUdyzjZbBEHuX6/tSyVvmDWUS3UQnRu7RBLXl29TcMjlilVpy2bfE5mktEG
         gtO4YPJGdhnN+69LC3SVeW7WAK2wrsdzGWKM8SIrfUzozPW706CaS3HwTmj0t7nSU4QT
         /0d31cj79ttgUkDTMf6oTeNwfFbNTzuj6/6PFSv9CzPY0mDJnuKxNlGxnvhulkFObS5H
         tD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqKjw9wQXgOAIHdR23lI/gjq+FKkcG9gMYu8YLG7JPo=;
        b=ReHA1A3Xm2sSyWEb1iKqTmWuUxn9QGtBs1U6ZqGImiuBJH2LDgtqHlsFpwURrKhjgk
         HPjhV1aHRneEBvAZpjeUTSQ+xcbL466vphqVggBkLJh5f6jkMeQD3vyh/Q9JVNvGKlVW
         8YUbaOq0vDrGGk6VhezTEOQ3mX5l+z2iJuJ0dT3qrp/UST52lsy/gSbpMWajssXdMNzF
         wXcLqL3/A0UOd5PDnFvA0qlKYoAJgVIcyv0ybOvr3s4HjSjAIKVdzjHpGtDGfPjQ+mq0
         AXWkOZSuzvLS4pluHpqBUeHSoLz4e9sv36m/dIQ5dE1siS3Z3RUBDw3hiVDY3ig6VRHG
         /23g==
X-Gm-Message-State: AOAM530HO7wLcDC+qWvE7qxcjuEjM4jx/c7S97iBPsslMnQKVNNpiKeE
        yGHVLq3BIdqb6fCNyZgKNm4gRYVXDT/VcSSxly67TpQqyw==
X-Google-Smtp-Source: ABdhPJzMVBexbRBg40V8GTmT/lN49AtdZX2PykTy5ob+r1wEDKnMJiRjhvAPFEUDdw7k+IRm3iy8H44n+qJYCFCPpcY=
X-Received: by 2002:a17:907:16ab:: with SMTP id hc43mr6454575ejc.195.1631801243482;
 Thu, 16 Sep 2021 07:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <202109162036.zghQuRrY-lkp@intel.com> <CAFqZXNuv-d4WFvaVVa1WqzkrP6Wepu6QEKcUH=VejnP2OZz66A@mail.gmail.com>
In-Reply-To: <CAFqZXNuv-d4WFvaVVa1WqzkrP6Wepu6QEKcUH=VejnP2OZz66A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Sep 2021 10:07:12 -0400
Message-ID: <CAHC9VhQUBPVhzEUZCO2jTZWcB1bxdoY8xTs99vRdfzqTx3u5Rw@mail.gmail.com>
Subject: Re: [selinuxproject-selinux:stable-5.15 1/1] include/linux/rcupdate.h:395:2:
 warning: passing argument 1 of 'security_locked_down' discards 'const'
 qualifier from pointer target type
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 16, 2021 at 8:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Sep 16, 2021 at 2:08 PM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://github.com/SELinuxProject/selinux-kernel stable-5.15
> > head:   c491f0a471580712a4254adece400c3ebb3d8e44
> > commit: c491f0a471580712a4254adece400c3ebb3d8e44 [1/1] lockdown,selinux: fix wrong subject in some SELinux lockdown checks
> > config: um-x86_64_defconfig (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/SELinuxProject/selinux-kernel/commit/c491f0a471580712a4254adece400c3ebb3d8e44
> >         git remote add selinuxproject-selinux https://github.com/SELinuxProject/selinux-kernel
> >         git fetch --no-tags selinuxproject-selinux stable-5.15
> >         git checkout c491f0a471580712a4254adece400c3ebb3d8e44
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=um SUBARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/rbtree.h:24,
> >                     from include/linux/mm_types.h:10,
> >                     from include/linux/mmzone.h:21,
> >                     from include/linux/gfp.h:6,
> >                     from include/linux/mm.h:10,
> >                     from drivers/char/mem.c:12:
> >    drivers/char/mem.c: In function 'open_port':
> > >> include/linux/rcupdate.h:395:2: warning: passing argument 1 of 'security_locked_down' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >      395 | ({ \
> >          | ~^~~
> >      396 |  RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
> >          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      397 |  rcu_check_sparse(p, space); \
> >          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      398 |  ((typeof(*p) __force __kernel *)(p)); \
> >          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      399 | })
> >          | ~~
> >    include/linux/rcupdate.h:587:2: note: in expansion of macro '__rcu_dereference_protected'
> >      587 |  __rcu_dereference_protected((p), (c), __rcu)
> >          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/cred.h:299:2: note: in expansion of macro 'rcu_dereference_protected'
> >      299 |  rcu_dereference_protected(current->cred, 1)
> >          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/char/mem.c:620:28: note: in expansion of macro 'current_cred'
> >      620 |  rc = security_locked_down(current_cred(), LOCKDOWN_DEV_MEM);
> >          |                            ^~~~~~~~~~~~
> >    In file included from include/linux/fs_context.h:14,
> >                     from include/linux/fs_parser.h:11,
> >                     from include/linux/shmem_fs.h:11,
> >                     from drivers/char/mem.c:25:
> >    include/linux/security.h:1347:53: note: expected 'struct cred *' but argument is of type 'const struct cred *'
> >     1347 | static inline int security_locked_down(struct cred *cred, enum lockdown_reason what)
> >          |                                        ~~~~~~~~~~~~~^~~~
>
> Ah, I forgot to add the const qualifier to the function definition in
> the CONFIG_SECURITY=n branch... Paul, will you amend the commit or
> should I send an updated patch?

This patch is cursed.  I had to hack up a fixup patch to test this in
my Rawhide test automation last night too; evidently Rawhide carries
an out-of-tree lockdown patch which results in some merge rejects.

Sigh.

Yes, the quickest path is for me to just fix up the dummy function and
do a force-push (grrrrrr) back on top of selinux/stable-5.15.

-- 
paul moore
www.paul-moore.com
