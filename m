Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927CDC4332F
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7435861A0A
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354643AbhJAOqu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354645AbhJAOqt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Oct 2021 10:46:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BDC06177C
        for <selinux@vger.kernel.org>; Fri,  1 Oct 2021 07:45:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v10so35982878edj.10
        for <selinux@vger.kernel.org>; Fri, 01 Oct 2021 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H4joMu0i9PRc5y/5IfyO1O3DFiCiHeAFXYOy9MybLU=;
        b=Sqtq3HVEmFqyq/iZGy3bAUBBvoIIgqDCQe03hPij1pHQ+afGQ+qW4oxzfc6+IQYFAk
         8sdQMlTfSDwM/Vdd1CJBkNXlYzqUIs7kjIrH/2t+zg3ttq27VO3sQ43AlcBfvpXxKTvl
         LJ3PlZ6m4VGH2MQRjDVCng2EuhT9h0wVEaeNU4baqn2jFjdOfQHFiF2yKOb9Jj/nE2WT
         +c/MWFqDTQ0Mz7EPjLT8UhMOzISMjhG8DhpniuDVQDNev5vXymJFaLiemoBg6FM8YkNB
         qKOz2aScbgR3tKjPuAU54oJVPgg5Bzspd8vBSSjyF4fyOuUspQHrydXkPUbbOutVmVuA
         y+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H4joMu0i9PRc5y/5IfyO1O3DFiCiHeAFXYOy9MybLU=;
        b=cG3JVBxVFvCNtguRbsz6AKm/AY9qNEPndVFy2uKUljHV4x1MHjTcFeo/cumskdsgvy
         U+DUiIq+uasn+z2Zb1iJEqtGW3zBh6IRJDl3q0LrDktUzYolZpTsZSLa1KyKK5DpVluC
         4R7rOaYhx+XV+/Ier5YKasp+rKyl2yJo7GtI7Q9VatmJoHr0CAvCKFY3lN6gTOHWonoK
         z24nrBIpU3kz5Bi7qemZA0ffuljWVi7CtvEiziWpnDH+4FPi+BfXUVO6euAly6RkEKUu
         szxN3MZaBg+21+UVrgOcCDfDPATuQ+S29BbDxJhskRBF7Nrn/1AWDNA/uucM1PMepehP
         FiEA==
X-Gm-Message-State: AOAM533liAj0/xodyzoFodSDrQtROM+jsTH6plKNwVPGmNfbDUkDoLhv
        qk00SiI8xMw9FbtbqrX8tsz6o0vDHQvbjhDto7XT
X-Google-Smtp-Source: ABdhPJzS4Iw/cDlHH6KS55tisJ+ktQs+SukEzIuiCOuC5dk2GUdyTS52lv4qmMGUFGDGNBh9PabWSBxWmsNBGr46Xdw=
X-Received: by 2002:a50:9b06:: with SMTP id o6mr14719691edi.284.1633099502606;
 Fri, 01 Oct 2021 07:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024506.3762647-1-tkjos@google.com> <CAHC9VhQ-uziaYRYWaah=RMmz7HUVvxGs+4F=g2sizVXR0ZSWVw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-uziaYRYWaah=RMmz7HUVvxGs+4F=g2sizVXR0ZSWVw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Oct 2021 10:44:51 -0400
Message-ID: <CAHC9VhSet40x697Of5GJhpuWo-AH4TzEu_SgfBDMmANSzByQEw@mail.gmail.com>
Subject: Re: [PATCH] binder: use cred instead of task for selinux checks
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 1, 2021 at 10:38 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 30, 2021 at 10:45 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > Save the struct cred associated with a binder process
> > at initial open to avoid potential race conditions
> > when converting to a security ID.
> >
> > Since binder was integrated with selinux, it has passed
> > 'struct task_struct' associated with the binder_proc
> > to represent the source and target of transactions.
> > The conversion of task to SID was then done in the hook
> > implementations. It turns out that there are race conditions
> > which can result in an incorrect security context being used.
> >
> > Fix by saving the 'struct cred' during binder_open and pass
> > it to the selinux subsystem.
> >
> > Fixes: 79af73079d75 ("Add security hooks to binder and implement the
> > hooks for SELinux.")
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Cc: stable@vger.kernel.org # 5.14 (need backport for earlier stables)
> > ---
> >  drivers/android/binder.c          | 14 +++++----
> >  drivers/android/binder_internal.h |  3 ++
> >  include/linux/lsm_hook_defs.h     | 14 ++++-----
> >  include/linux/security.h          | 28 +++++++++---------
> >  security/security.c               | 14 ++++-----
> >  security/selinux/hooks.c          | 48 +++++++++----------------------
> >  6 files changed, 52 insertions(+), 69 deletions(-)
>
> Thanks Todd, I'm happy to see someone with a better understanding of
> binder than me pitch in to clean this up :)  A couple of quick
> comments/questions below ...

Ooops, I was a little over zealous when trimming my response and I
accidentally cut off my comment that the associated comment blocks in
include/linux/lsm_hooks.h should also be updated to reflect the binder
LSM hook changes.

-- 
paul moore
www.paul-moore.com
