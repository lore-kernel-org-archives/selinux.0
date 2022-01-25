Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B26C433FE
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiAYWdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiAYWdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 17:33:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF26C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:33:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me13so34160117ejb.12
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeeJHO8TMWJMimBDwT2b+COdmax7x8vmymErPKX3jxc=;
        b=DzijtXi0FpfwwMBwStqu3UmmHy6WLI6KJjaJCTw5TVkmEqNdXft9MrLSeXBntoO7Mw
         fWSvmO7h/R5mQ/yU+34k8tfHIU5T7UxRE0tWGCE66lLTfaILezBkt/1UkJvP9pVH0Yzb
         HHNrjbdaOKT86FyOQ4Jf88N4t5t/R3zJhuJwDslag8fbYnvwj1+kSYMm+Az5xDFrSoYc
         knCjS+ili0zFQfE5Tfu8zpiesGviybOMiD+yOzaswnbUAmmPC8T35oz+wE4i8da9xo9A
         Cxn3uNaT3ALpZ+5PyJS8v8W9GaSLLCJqkiGKhzgIDTWBp7Qme5nzQ2I/BzjbPf8Vhkt1
         p03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeeJHO8TMWJMimBDwT2b+COdmax7x8vmymErPKX3jxc=;
        b=Jjkj1HX/igu+O/hwa8fA6UX0NRV5b4xyWcOzTjlYjZasyGgPGsHN9sKFMV3gJHDAyB
         Io3X0G5gZNc7ZwG7vV8wAuOcwqJbrBZxIPPmG7h//s5/fbvV3UnRmMuBo9f87YW8oxaH
         B20XSwX0+gSW3a3XmJmkneP6kUaNzbzjxM975iC5lOAhqCG6pp56WCqD3qYkwQ5eBwgU
         11nLbif6qHEB1GwJOvzEWrCXeZT/C/L78j88k5hoymaytKnuMhTFMcXnA+dHastwGEMU
         Uqy8bs4cReQYo1pAqLXFqrTowAGUbutZP7wR6rQDjp8dGvR8JzlzLO1WTv4uX+56VyuT
         JUkg==
X-Gm-Message-State: AOAM531htgVKO+WVhBr5MbJg2bMtpw6Vk5tcoJ43qI3hEOmbA+7HdRvc
        ctlnwECphfDB8faTJ8RJtUIwIQeki7BURnU4Om4+u06B8A==
X-Google-Smtp-Source: ABdhPJwzCS4uLiZK6VG/8/+4YA+LVnkgPcisQkj57oqNq+GSah4sXm1jFpQGtsy59McG8IOvdIVYqDfpF+TVv9/mvao=
X-Received: by 2002:a17:907:6d03:: with SMTP id sa3mr4722991ejc.517.1643149985174;
 Tue, 25 Jan 2022 14:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com> <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
 <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
In-Reply-To: <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 17:32:54 -0500
Message-ID: <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 1:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
> On Tue, 25 Jan 2022, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > >
> > > > > selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> > > > > shouldn't be performing any memory allocations.  Fix this by parsing the
> > > > > sids at the same time we're chopping up the security mount options
> > > > > string and then using the pre-parsed sids when doing the comparison.
> > > > >
> > > > > Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> > > > > Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> > > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > > ---
> > > > >  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
> > > > >  1 file changed, 76 insertions(+), 36 deletions(-)
> >
> > ...
> >
> > > > >         switch (token) {
> > > > >         case Opt_context:
> > > > >                 if (opts->context || opts->defcontext)
> > > > >                         goto err;
> > > > >                 opts->context = s;
> > > > > +               if (preparse_sid) {
> > > > > +                       rc = parse_sid(NULL, s, &sid);
> > > > > +                       if (rc == 0) {
> > > > > +                               opts->context_sid = sid;
> > > > > +                               opts->preparsed |= CONTEXT_MNT;
> > > > > +                       }
> > > > > +               }
> > > >
> > > > Is there a reason why we need a dedicated sid variable as opposed to
> > > > passing opt->context_sid as the parameter?  For example:
> > > >
> > > >   rc = parse_sid(NULL, s, &opts->context_sid);
> > >
> > > We don't need a dedicated sid variable.  Should I make similar changes
> > > in the second patch (get rid of the local sid variable in
> > > selinux_sb_remount() and the *context_sid variables in
> > > selinux_set_mnt_opts())?
> >
> > Yes please, I should have explicitly mentioned that.
>
> Actually, delayed_superblock_init() calls selinux_set_mnt_opts() with
> mnt_opts == NULL, so there would have to be a lot of checks like
>
>         if (opts && opts->fscontext_sid) {
>
> in the later parts of that function, which is kind of clunky.  I can
> still do it if you want though.

I might be misunderstanding your concern, but in
selinux_set_mnt_opts() all of the "opts->XXX" if-conditionals are
protected by being inside an if-statement that checks to ensure "opts"
is not NULL.  Am I missing something?

-- 
paul-moore.com
