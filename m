Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A9C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB155206E6
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3M9sN/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgFDTZG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgFDTZG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 15:25:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C2C08C5C1
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 12:25:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e11so2126157ilr.4
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbRk0Np2RyEeRH9dbEqIpL8yNJC/z12gVw4fgEEaAMo=;
        b=u3M9sN/IXt2i7f51ms44wcx6VueK56R5jjDi1EhydAqd363IGhxfzmeL0NaaS0VDKZ
         LT3tpByq66dNFY2IfXpAvX+pUorSPfIjGsVB1859eLQdxjM/VlmM+e6CWuL30UGQhC7K
         YQKEksG3uOkNi41rgdJ85kME1PIvIEb4BRzrRRfQ8pNpUmhGI0VKYt8BnHnBwPZFuTmA
         288Voau9XPcStXZ99IiGx9aGt7TmfOx88Wcu73nVl90rLmJS6BucaU4U8JytXmEebCWr
         v1W1Kjv5Pl5f9LBg8XH+2ZKC0GCarljHbOfzGXa/Vs0ag78JzyHR1/0N06Z9xg9rzSbJ
         WBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbRk0Np2RyEeRH9dbEqIpL8yNJC/z12gVw4fgEEaAMo=;
        b=jzkpXjpQPO7lseQAS3hCLoZsjgsB+uNcb9cPyEbNer5xi4ZEs9f9WYXJ1Kk0jet64/
         OHVIrvHTyvwUh+AohqRyr21surl8lqSt+D+Tq2Je2MJNFrt8ESkd6YNB3FTZSWgLpMZA
         tjdYFWJMupq8Q/DQaZeIyl2wIIc4JFTUYc+iGI5c06H3bWjz7OsOAh9bNV1P/ztNA9j9
         py6+exmjrLuDV1DjcxHmXK0rsLGjX0eRnNSm3cv0J4rmEYfpXfhL/BTlklWCsc8gNkoG
         q2YIHfhCVYhKtcRebOHitYy3ruWeAjZEELY3HChyiu0kPFRw7vo7+rW8zFDcFtxuoNQE
         pd2A==
X-Gm-Message-State: AOAM5307Gd5O3Mtn+xok9Ph8xGethki4hNiD2iYONgWdbXVmNitvD1tG
        UQUWTyby3hehNMk+0//4kZRqId/kur3Ff1mX8jvzuA==
X-Google-Smtp-Source: ABdhPJwKoN5r5L9R54HbykuC0DorU7y/W2B3N9E1pyD/bJ0BVDTWE/MGa2wTOsc6+Qu1lN6eOLHr9/7eCovbejyU7M0=
X-Received: by 2002:a92:c048:: with SMTP id o8mr5413126ilf.202.1591298704710;
 Thu, 04 Jun 2020 12:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
 <alpine.LRH.2.21.2006041354381.1812@namei.org> <CAEjxPJ4GvTXQY_BzLugnrXrPnehqwnmqxn21mjVDhpk4kYV3Aw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4GvTXQY_BzLugnrXrPnehqwnmqxn21mjVDhpk4kYV3Aw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 4 Jun 2020 12:24:53 -0700
Message-ID: <CA+EESO5GZtSNEyXkmLGS6vNQDDGqrwhmzEpcueQydr99=n+apQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Adding a colleague from the Android kernel team.

On Thu, Jun 4, 2020 at 11:52 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 3, 2020 at 11:59 PM James Morris <jmorris@namei.org> wrote:
> >
> > On Wed, 1 Apr 2020, Daniel Colascione wrote:
> >
> > > Daniel Colascione (3):
> > >   Add a new LSM-supporting anonymous inode interface
> > >   Teach SELinux about anonymous inodes
> > >   Wire UFFD up to SELinux
> > >
> > >  fs/anon_inodes.c                    | 191 ++++++++++++++++++++++------
> > >  fs/userfaultfd.c                    |  30 ++++-
> > >  include/linux/anon_inodes.h         |  13 ++
> > >  include/linux/lsm_hooks.h           |  11 ++
> > >  include/linux/security.h            |   3 +
> > >  security/security.c                 |   9 ++
> > >  security/selinux/hooks.c            |  53 ++++++++
> > >  security/selinux/include/classmap.h |   2 +
> > >  8 files changed, 267 insertions(+), 45 deletions(-)
> >
> > Applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git secure_uffd_v5.9
> > and next-testing.
> >
> > This will provide test coverage in linux-next, as we aim to get this
> > upstream for v5.9.
> >
> > I had to make some minor fixups, please review.
>
> LGTM and my userfaultfd test case worked.
