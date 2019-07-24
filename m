Return-Path: <SRS0=rVyX=VV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D130DC7618B
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC0821841
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfGXQRh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:17:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36359 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfGXQRh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Jul 2019 12:17:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id q4so6256443oij.3
        for <selinux@vger.kernel.org>; Wed, 24 Jul 2019 09:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IbouPeb+7HfRursxOx2UKgv+yR+yHqFG70l+YmYjuE=;
        b=rOnj4axjOoDaJe8BvNbcxQU/60xvSrnCF9fnM341tbMkcvftWZtTEHIIO+0XWXEWqp
         I26HlREECWuScyBQBd/2NSZZv9Hy39a2VgEqn9G6ieei6BIGSwEnmrG2DKU/9dZUvJDV
         pqMejh1LNTvK5mofRcRkbObKHPxYXnPNQZd9ZQ/AdgWVMYhUlK7ybyV1pISaAlOT68P0
         9iKtOCNZvEFHzM70fxiTxXDW62dCST2ARO6JX7eFSqVb+YnY1EJdNl2GVICbmYDvNFeT
         tyoqGNx+YdqXCgxaRazbleJ6gIR7Qu+2PMZ6tvFfUfZ5XVrhYDSlgP0GSaZqgFz/QQ8h
         +J+A==
X-Gm-Message-State: APjAAAX8CnlqqX7RthaRrAZBAuz4BOQDULqapGdM8GBdmlAEagG9CPrm
        TVp00TYMG87JGGJTa7L7LVg9RLPpBIR5JHkYDR4f+nh2KuxbUg==
X-Google-Smtp-Source: APXvYqyE0yBH1VD25VM7IVPkkwvYgKvqlMt4PLcQpZA64vAsr+tIlLbieTu94VOj0YIC8J9BVSxYD4KsZheoVpUwems=
X-Received: by 2002:aca:1c02:: with SMTP id c2mr42243691oic.166.1563985056283;
 Wed, 24 Jul 2019 09:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
In-Reply-To: <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Jul 2019 18:17:27 +0200
Message-ID: <CAFqZXNuhRratpxMke=T4ZXW8e4WLit932iLWb6dR3w9-BYU9Kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Jann Horn <jannh@google.com>
Cc:     NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 23, 2019 at 4:54 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Jul 22, 2019 at 3:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > > refcount_t type and corresponding API should be
> > > used instead of atomic_t when the variable is used as
> > > a reference counter. This allows to avoid accidental
> > > refcounter overflows that might lead to use-after-free
> > > situations.
> > >
> > > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
> >
> > Nack.
> >
> > The 'count' variable is not used as a reference counter here. It
> > tracks the number of entries in sidtab, which is a very specific
> > lookup table that can only grow (the count never decreases). I only
> > made it atomic because the variable is read outside of the sidtab's
> > spin lock and thus the reads and writes to it need to be guaranteed to
> > be atomic. The counter is only updated under the spin lock, so
> > insertions do not race with each other.
>
> Probably shouldn't even be atomic_t... quoting Documentation/atomic_t.txt:
>
> | SEMANTICS
> | ---------
> |
> | Non-RMW ops:
> |
> | The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
> | implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> | smp_store_release() respectively. Therefore, if you find yourself only using
> | the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> | and are doing it wrong.
>
> So I think what you actually want here is a plain "int count", and then:
>  - for unlocked reads, either READ_ONCE()+smp_rmb() or smp_load_acquire()
>  - for writes, either smp_wmb()+WRITE_ONCE() or smp_store_release()
>
> smp_load_acquire() and smp_store_release() are probably the nicest
> here, since they are semantically clearer than smp_rmb()/smp_wmb().

Oh yes, I had a hunch that there would be a better way to do it... I
should have taken the time to read the documentation carefully :)

I am on PTO today, but I will be happy to send a patch to convert the
atomic_t usage to the smp_load_acquire()/smp_store_release() helpers
tomorrow. It will also allow us to just use u32 directly and to get
rid of the ugly casts and the INT_MAX limit.

Thanks a lot for the hint, Jann!

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
