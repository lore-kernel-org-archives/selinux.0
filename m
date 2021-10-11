Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54CBC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8261E60EB6
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhJKXmA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhJKXl7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 19:41:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8313C061749
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:39:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so80201505lfu.5
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=350Zyde5NHUyrWXKjoBMtH0Ka1p1k23ESLRD0Ny2AAk=;
        b=OzYbyPMYnoypTGzHb6++gJhPpX/aMvA8HTl2F/X1uqm83TU6mdlOMtYyLrm+yLnLuu
         1cdGNfZ39RhG9F9acYYLPUDo8JmnDkON0vpK1JGRF+enSzeuZj0Jw7O64QIMXa+H0ysR
         0vu5TZjN5yxhkJ+RSZKGr0qo7GVuyANYSeoum4yaz1LgfHsAmZWqFN2AJw7809ScHXjv
         DCc+KXKcaWFUHKOMH7bSAOve1qpc6GTzZfnIYGSDNp6oUVMJYa4X+BzfKMfKdaUV0EDc
         l85wZP7XwJzndPJzrXSHc/aoT9EGegSsQvoYHWFlbemlfX3+gbEqA/WiXVyHC9a+HLZz
         So5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=350Zyde5NHUyrWXKjoBMtH0Ka1p1k23ESLRD0Ny2AAk=;
        b=xJYRN/tgwXFU6U+LCp93UYtWR3/KOp6vvXlAKjoSh2IDEFcvrw0BnfkFHerCpjLZA2
         MsyloZdi7U7p9UDwDYOvHwH1WotK/3mFR/8w6xuCpqe7m1noS4cd67azG4gBb65jn3nl
         7BCdQ/85BW2PmbrE/aWsSQXEapkER0c+3owBGecfIqp4rAVXCCwCezYtRlKdJrFTgZUw
         KeNGCFjdJbjOd6dwAIRlCDWETLu9ff6CNP9g0exElA5zvr6GycRpJwgd2PiTxkJgZ+Hf
         fSPOpIzNF7pIeaSQ2uLMzzlAIUIEN4a3QLvBfwvPc2+R4K+CV9NDIapqK0rY5DdqvO5O
         Mb6A==
X-Gm-Message-State: AOAM532mxIBVWy/ggwoAmX3YZNBorXU/A63Xzrqtl/C8EIkzMmVo7ZJf
        5FZ57atUNNrCniLZLrXPXYI1JKOGQ29VfEYyK4IW8A==
X-Google-Smtp-Source: ABdhPJwRxHo++mt2ts2tuHKj97PgUfltXjxEpnNt1psrUBoyI5y1QyTnG4FDY6wOkqBZq8c4R9LztUvqCmZoPJ7PiEE=
X-Received: by 2002:a05:6512:1291:: with SMTP id u17mr29841307lfs.226.1633995596978;
 Mon, 11 Oct 2021 16:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211007004629.1113572-1-tkjos@google.com> <20211007004629.1113572-4-tkjos@google.com>
 <CAHC9VhTRTcZW9eyXXvAN7T=ZCQ_zwH5iBz+d0h2ntf7=XHE-Vw@mail.gmail.com>
 <CAHRSSEy=eC0rbHUzDmCo6Na7Ya=uCq7zJ6_cXysi0oWQB=19YQ@mail.gmail.com> <CAHC9VhQVKTxwUUP02U43=zVZrEFWc0hhmpaR1YSxe+KHjhnhbw@mail.gmail.com>
In-Reply-To: <CAHC9VhQVKTxwUUP02U43=zVZrEFWc0hhmpaR1YSxe+KHjhnhbw@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 11 Oct 2021 16:39:45 -0700
Message-ID: <CAHRSSEwYrqFum7gS0XOYG0p3F+0Hv8qvaZbWLUyXUm0oCWpX9w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] binder: use euid from cred instead of using task
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey@schaufler-ca.com, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, James Morris <jmorris@namei.org>,
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

On Mon, Oct 11, 2021 at 2:39 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Oct 8, 2021 at 5:24 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Fri, Oct 8, 2021 at 2:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Oct 6, 2021 at 8:46 PM Todd Kjos <tkjos@google.com> wrote:
> > > >
> > > > Set a transaction's sender_euid from the 'struct cred'
> > > > saved at binder_open() instead of looking up the euid
> > > > from the binder proc's 'struct task'. This ensures
> > > > the euid is associated with the security context that
> > > > of the task that opened binder.
> > > >
> > > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > > Signed-off-by: Todd Kjos <tkjos@google.com>
> > > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Cc: stable@vger.kernel.org # 4.4+
> > > > ---
> > > > v3: added this patch to series
> > > >
> > > >  drivers/android/binder.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > This is an interesting ordering of the patches.  Unless I'm missing
> > > something I would have expected patch 3/3 to come first, followed by
> > > 2/3, with patch 1/3 at the end; basically the reverse of what was
> > > posted here.
> >
> > 2/3 and 3/3 both depend on 1/3 (add "cred" member of struct
> > binder_proc). I kept that in 1/3 to keep that patch the same as what
> > had already been reviewed. I didn't think much about the ordering
> > between 2/3 and 3/3 -- but I agree that it would have been sensible to
> > reverse their order.
> >
> > >
> > > My reading of the previous thread was that Casey has made his peace
> > > with these changes so unless anyone has any objections I'll plan on
> > > merging 2/3 and 3/3 into selinux/stable-5.15 and merging 1/3 into
> > > selinux/next.
> >
> > Thanks Paul. I'm not familiar with the branch structure, but you need
> > 1/3 in selinux/stable-5.15 to resolve the dependency on proc->cred.
>
> Yep, thanks.  My eyes kinda skipped over that part when looking at the
> patchset but that would have fallen out as soon as I merged them.
>
> Unfortunately that pretty much defeats the purpose of splitting this
> into three patches.  While I suppose one could backport patches 2/3
> and 3/3 individually, both of them have a very small footprint
> especially considering their patch 1/3 dependency.  At the very least
> it looks like patch 2/3 needs to be respun to address the
> !CONFIG_SECURITY case and seeing the split patches now I think the
> smart thing is to just combine them into a single patch.  I apologize
> for the bad recommendation earlier, I should have followed that thread
> a bit closer after the discussion with Casey and Stephen.

I'm happy to submit a single patch for all of this. Another part of
the rationale
for splitting it into 3 patches was correctly identify the patch that introduced
the patch that introduced the issue -- so each of the 3 had a different
"Fixes:" tag. Should I cite the oldest (binder introduction) with the "Fixes"
tag and perhaps mention the other two in the commit message?

-Todd

>
> --
> paul moore
> www.paul-moore.com
