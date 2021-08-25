Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95BC4320E
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 19:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D183610A7
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 19:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhHYTmX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhHYTmX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 15:42:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63BC0613CF
        for <selinux@vger.kernel.org>; Wed, 25 Aug 2021 12:41:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bt14so821488ejb.3
        for <selinux@vger.kernel.org>; Wed, 25 Aug 2021 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBVskMaUIVDs4HS+hyH9+QzivYsdZb5+81X6Kp6nbqA=;
        b=wpsfR5q5tePN80NgpQqbp421hM8TDiCvCTTwB1JkcEmAvAtp6ZrK1p2rQe2/Yu79HH
         0S+ppvqMdpB16ip556YNxs39E4gt3FPJPdzJ94g1Fl76f55k5RTGOwgZ0XR5aSgYpUCz
         PPLFKNbOM2yJU7S1M6rBJnVDKPFg6YDnQvl8fC4eYYIjPnKwcpgeGdVAmPrL2b+yD1FU
         gzNnKCPreHAyI7Q0PIGKGZ2O3Iit9mu8uyShULHJS1XXrBvd4wClZV6UCOP84vEKHP8i
         BGzWieL8PoLFLRk/LfL6NDusPTM0MD7PEwfgb5goTc51LYpYwr+rxbJ8dNTaJUpGSLiR
         iNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBVskMaUIVDs4HS+hyH9+QzivYsdZb5+81X6Kp6nbqA=;
        b=msxKJIUZXMn/kLSur1Cl2aV2qYCD6sh28sLpzBLWACJhPl/Di7+dgW3gxKdkI7uiDV
         xwMh28GratzvmPTkPx47NJQ/oIHMVtkG2XvnJScRfY4fHykZHV5Cub4D5NUDL2CQxnBg
         vDyRUbTFkiTAwqGpegHGXCH2gUU2lHKTI4yNdLwrJX0Vp9YIbQW4nkqW8FjLZI+WCpLt
         sVfB9T9xp4UQmYTqI5dwC1UflNxJTeKgiJc2D8lrD/l8cz3M2GluvWEBEtQYzxNkkufO
         mzOKVFt1pU4AQmVOKlSxs/hiKEIVXiscWZUg9Pa11UqSlAFLTLReumCzXzxHWZ+y1cvZ
         RMzA==
X-Gm-Message-State: AOAM533DOSKlb7Ao4/GKuHKxbX0x+1nr3mTsyOL/QUh1N+2gtY/R6hE0
        gESqFOe5Gxai256aw12LRVUyLXJ73VC8IFWiI2q4iphiLw==
X-Google-Smtp-Source: ABdhPJyvFsCKbYMAS8hVKgJcJEfi6swZHjePix9TNIzxa6quNsOL1W81ezTdFJUOAIEacZVvSAaXx84O2BGDkg2VI8c=
X-Received: by 2002:a17:906:f8c4:: with SMTP id lh4mr295852ejb.542.1629920495168;
 Wed, 25 Aug 2021 12:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163379461.8379.9691291608621179559.stgit@sifl> <20210602172924.GM447005@madcap2.tricolour.ca>
 <CAHC9VhS0sy_Y8yx4uiZeJhAf_a94ipt1EbE16BOVv6tXtWkgMg@mail.gmail.com> <20210825012102.GC490529@madcap2.tricolour.ca>
In-Reply-To: <20210825012102.GC490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Aug 2021 15:41:24 -0400
Message-ID: <CAHC9VhQtHDt_F_ah3EDRMYeMXkSB5dHDgcdXGEMF_tXV5idbpg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] audit, io_uring, io-wq: add some basic audit
 support to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 24, 2021 at 9:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2021-06-02 13:46, Paul Moore wrote:
> > On Wed, Jun 2, 2021 at 1:29 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2021-05-21 17:49, Paul Moore wrote:
> > > > WARNING - This is a work in progress and should not be merged
> > > > anywhere important.  It is almost surely not complete, and while it
> > > > probably compiles it likely hasn't been booted and will do terrible
> > > > things.  You have been warned.
> > > >
> > > > This patch adds basic auditing to io_uring operations, regardless of
> > > > their context.  This is accomplished by allocating audit_context
> > > > structures for the io-wq worker and io_uring SQPOLL kernel threads
> > > > as well as explicitly auditing the io_uring operations in
> > > > io_issue_sqe().  The io_uring operations are audited using a new
> > > > AUDIT_URINGOP record, an example is shown below:
> > > >
> > > >   % <TODO - insert AUDIT_URINGOP record example>
> > > >
> > > > Thanks to Richard Guy Briggs for review and feedback.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  fs/io-wq.c                 |    4 +
> > > >  fs/io_uring.c              |   11 +++
> > > >  include/linux/audit.h      |   17 ++++
> > > >  include/uapi/linux/audit.h |    1
> > > >  kernel/audit.h             |    2 +
> > > >  kernel/auditsc.c           |  173 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  6 files changed, 208 insertions(+)

...

> > > > +     if (ctx->return_valid != AUDITSC_INVALID)
> > > > +             audit_log_format(ab, " success=%s exit=%ld",
> > > > +                              (ctx->return_valid == AUDITSC_SUCCESS ?
> > > > +                               "yes" : "no"),
> > > > +                              ctx->return_code);
> > > > +     audit_log_format(ab,
> > > > +                      " items=%d"
> > > > +                      " ppid=%d pid=%d auid=%u uid=%u gid=%u"
> > > > +                      " euid=%u suid=%u fsuid=%u"
> > > > +                      " egid=%u sgid=%u fsgid=%u",
> > > > +                      ctx->name_count,
> > > > +                      task_ppid_nr(current),
> > > > +                      task_tgid_nr(current),
> > > > +                      from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > > +                      from_kuid(&init_user_ns, cred->uid),
> > > > +                      from_kgid(&init_user_ns, cred->gid),
> > > > +                      from_kuid(&init_user_ns, cred->euid),
> > > > +                      from_kuid(&init_user_ns, cred->suid),
> > > > +                      from_kuid(&init_user_ns, cred->fsuid),
> > > > +                      from_kgid(&init_user_ns, cred->egid),
> > > > +                      from_kgid(&init_user_ns, cred->sgid),
> > > > +                      from_kgid(&init_user_ns, cred->fsgid));
> > >
> > > The audit session ID is still important, relevant and qualifies auid.
> > > In keeping with the SYSCALL record format, I think we want to keep
> > > ses=audit_get_sessionid(current) in here.
> >
> > This might be another case of syscall/io_uring confusion.  An io_uring
> > op doesn't necessarily have an audit session ID or an audit UID in the
> > conventional sense; for example think about SQPOLL works, shared
> > rings, etc.
>
> Right, but those syscalls are what instigate io_uring operations, so
> whatever process starts that operation, or gets handed that handle
> should be tracked with auid and sessionid (the two work together to
> track) unless we can easily track io_uring ops to connect them to a
> previous setup syscall.  If we see a need to keep the auid, then the
> sessionid goes with it.

As a reminder, once the io_uring is created appropriately one can
issue io_uring operations without making a syscall.  Further, sharing
a io_uring across process boundaries means that both the audit session
ID and audit login UID used to create the io_uring might not be the
same as the subject which issues operations to the io_uring.

Any io_uring operations that happen synchronously as the result of a
syscall should be associated with the SYSCALL record so the session ID
and login UID will be part of the event.  Asynchronous operations will
not have that information because we don't have a way to get it.

-- 
paul moore
www.paul-moore.com
