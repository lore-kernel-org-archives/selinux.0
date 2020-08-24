Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E6DC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5AB207D3
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Y2+B7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgHXMk1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMk0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 08:40:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DEC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:40:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z18so7125709otk.6
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fw466gh/Xf5p8bFSerpyRUqFKQgYuQRzGeVb1YqGSc=;
        b=k2Y2+B7yN6JFT6IATjqo+plzXSxdv+RqhOLZ5+BzzkNQRJKW1Ghsy1h9f1nNuSdcCX
         A9BUe3+TIT7s2FAHN/ccYVvuoK/QcE+WMoN8ytVluclDQrGYQZMJFqQfRk4W1pGM5MkS
         g7BJdMpMMLmtDfJ1xF+7eb3ODOPxKASnAp3WpW6NsDi+1JbV1ifk5LhzKVSq7OtrsSaE
         smJ4o4ulf7O3Y8/ohvYgAr8JAMN4C4bc/2/FHI1YYMz3/N1XDtEC6KWh88uCToWGFoyb
         UvmL7mYcI9ocyeIE/lcwXdCWl/xLBR0kcrDaA+X6NLsxhNtUYuQEFSs/X9wmgzeIO46Q
         eXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fw466gh/Xf5p8bFSerpyRUqFKQgYuQRzGeVb1YqGSc=;
        b=YNJUvqy7tL4PeXZX2GdIVv8ZHuolrknuxpg6ffb7udcXEAxs2nDcB9m36XqIJsliQ+
         ZParoFlwViMcEzfDemAG9ZVhieNtqE2fllYLdTL9Px6uDnqtiy2AyjBQ2wo/QHDuvxoR
         /FtpPwj04H8z4yPZyPE1rAvI0aoYXXcqi0F1SGWz/f+58LU8kpMMzQqCPw59Ae3Y5swn
         w0FEOOJFhg98y/xR+lx+jp495LIrnTJkDVlXCGK85SEHgqgA3d2lRaMLSgLH+EnJ5Egl
         8GTzJWjXkhPFdXpDkuaY4gZI437yW+KQrYj88S1nXRsPaR4Jh0qdxNf8/wYvjgvbk4h1
         laGw==
X-Gm-Message-State: AOAM533ArpfQEa/aDWHhXiZwJzTNMe/JBhmVkEvYsmyjFZdbLElOXfLW
        J4Yqdg1IDzPnkFnWpqopooI68PEfgNQjOiqoa+s=
X-Google-Smtp-Source: ABdhPJwXS6i7RPNxUa0ckuuwY0jG8ju1A/k5jOaZgqzLaK4DVS9wr/38IWNqcc6+GZSCKgRFD7E01iT0+6X3RvrOMVI=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr3431645otn.162.1598272825233;
 Mon, 24 Aug 2020 05:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154704.1214330-1-omosnace@redhat.com> <CAEjxPJ5gZhE2RB7A4LQyBOi5FQF5PLw_vs6gHeiwsiB1-j6Rog@mail.gmail.com>
 <CAFqZXNvdtpxveqesYMz3ZxoWGd_vi5euqy6c9gzhmdkKgbU-Fg@mail.gmail.com>
In-Reply-To: <CAFqZXNvdtpxveqesYMz3ZxoWGd_vi5euqy6c9gzhmdkKgbU-Fg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 08:40:14 -0400
Message-ID: <CAEjxPJ5zFv7wDccDP2+0Z=B9-03g03H3wgy5pgu-DHjE3CGU5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a race condition in security_read_policy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Aug 21, 2020 at 7:39 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 21, 2020 at 11:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > In security_read_policy(), the policy length is computed using
> > > security_policydb_len(), which does a separate transaction, and then
> > > another transaction is done to write the policydb into a buffer of this
> > > length.
> > >
> > > The bug is that the policy might be re-loaded in between the two
> > > transactions and so the length can be wrong. In case the new length is
> > > lower than the old length, the length is corrected at the end of the
> > > function. In case the new length is higher than the old one, an error is
> > > returned.
> > >
> > > Fix it by doing everything in a single transaction and getting the
> > > length directly from policydb instead of calling
> > > security_policydb_len().
> > >
> > > Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/services.c | 19 +++++++++++--------
> > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index a48fc1b337ba9..ab4de2a01634a 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -3842,22 +3842,25 @@ int security_read_policy(struct selinux_state *state,
> > >                          void **data, size_t *len)
> > >  {
> > >         int rc;
> > > +       struct policydb *policydb;
> > >         struct policy_file fp;
> > >
> > >         if (!selinux_initialized(state))
> > >                 return -EINVAL;
> > >
> > > -       *len = security_policydb_len(state);
> > > +       read_lock(&state->ss->policy_rwlock);
> > > +       policydb = &state->ss->policy->policydb;
> > >
> > > +       *len = policydb->len;
> > >         *data = vmalloc_user(*len);
> >
> > I don't believe you can hold a read_lock() across a vmalloc.  That's
> > why this is done the way it is now.
>
> Fair point. Then I guess the only option is to keep retrying the
> allocation until the allocated size is >= the size we are about to
> write. I'll send a revised patch soon.

Wondering if this is worthwhile/necessary versus just having userspace
retry if needed. Reading /sys/fs/selinux/policy is not a common or
frequent operation.  By the way, if you have CONFIG_DEBUG_ATOMIC_SLEEP
enabled, it should catch things like this for you.  I have
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
