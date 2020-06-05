Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D415FC433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01A82070B
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsT0kP6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgFEMbv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFEMbu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 08:31:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5894C08C5C2
        for <selinux@vger.kernel.org>; Fri,  5 Jun 2020 05:31:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so7428763otr.12
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2020 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylkSqMhky7LRYRFiqTtuGonz2eOWpBGHfwYtKYpyfv0=;
        b=QsT0kP6ddRTaTQwGkjvU26ZvuuKoObll2lEEm1wLvmuSTV4YaTqpy+jHg5u3OfXDbe
         cJW5M2TuIMDryTAc5C9zmK2ID5zEff8QZ+fn7+BA2fwmjOxBs+OCLjnzG8tVdT1J+JxD
         53XEEMN+YZJTS5rrG+2M2yZfsdXWzsLbUeWOKtbEC9nU/w2eOT4lP5UXHZHUzdf6K4W6
         E0gAhuattSrVbfFqlRHzR4uYtDUM+CMuaK+IfZrxP6G6ecYF5Vmuh3m7zhX2zOcR3zit
         pxYwkRuXE0wNn7ped3+fCGH8xJFYLWaMAMGfwx45B7yxdPRu4GwjEq18jOYMvUawzQm5
         PBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylkSqMhky7LRYRFiqTtuGonz2eOWpBGHfwYtKYpyfv0=;
        b=Nk+LX3mWX9/YmxmCMN13XflCQclfx8rBtHPV+ADtn6i45ASdcyxmWwuDgIX/0NQ7cU
         vxXKrRXhssfV+NL3msmAI3W3Fi8Bh+USwiVJof8TojCuKFAvi6OJ+QFEKGzwJ1/xnL52
         eMt4XXlva8SUvaVDqkOeQ+/cIM8wY+JHIkAs8Fkq5bYqIux5BqdxjQEbsxM20JvyDKmu
         lwtvneyC33z75bwTohef5UgZ343uv8spG7m6SdneHcn+0yE8CE49D8wUsOcRTXDoVqLC
         oaq3NrgQtzm5krmD8DytTH2Bb+DscVXGRtxKUI41MnlrDz3LjoZcf81Suh92ZJwBiKY8
         LLJA==
X-Gm-Message-State: AOAM532evtYngqqho8mUe1Rsa6wBgEZTxVJg+HjYzvF3UE6P2KN/n9pv
        TXSmemOGTZQQES2rpbGt67pnXxDZzKKzw5ft4eQ=
X-Google-Smtp-Source: ABdhPJxbSXnCCYW9sy8aL3VKU7donmaxeI8NTYF21ISwA9FUhjD46sOi0easWSi3rlkGzF68/snfrFOcBn0E9EpNMJs=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr7609816otl.162.1591360309239;
 Fri, 05 Jun 2020 05:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200601072916.219197-1-chirantan@chromium.org>
 <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com>
 <CAJFHJrp6pM1EUcBWFL4bKQUA4wZT4N5_0QutXv5vXr7TNAvqVg@mail.gmail.com> <CAEjxPJ7QD-zPyytQ6-VpuoAqnuS91fzA3nj-711OsK_9cy-kWQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7QD-zPyytQ6-VpuoAqnuS91fzA3nj-711OsK_9cy-kWQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 5 Jun 2020 08:31:38 -0400
Message-ID: <CAEjxPJ7GiYbVXQ0YnezT_LsLPVoGQa_ONt1B5duY+W+58V-bbw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow file owner to set "security.sehash"
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 8:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2020 at 2:21 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > On Mon, Jun 1, 2020 at 9:42 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, Jun 1, 2020 at 3:29 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> > > >
> > > > Normally a process needs CAP_SYS_ADMIN in the namespace that mounted a
> > > > particular filesystem in order to set a security xattr. However, this
> > > > restriction is relaxed for the security.selinux xattr: the file owner
> > > > or a process with CAP_FOWNER in its namespace may set this attribute.
> > > >
> > > > Apply this relaxed restriction to the security.sehash xattr as well.
> > > > Since this xattr is mainly a performance optimization when labeling
> > > > files recursively it shouldn't have stricter requirements than setting
> > > > the selinux xattr in the first place.
> > >
> > > First, setting either security.<non-selinux> or security.selinux has
> > > an additional MAC check beyond the DAC/capability check; in the former
> > > case there is the FILE__SETATTR check and in the latter there are the
> > > FILE__RELABELFROM/TO checks.  We need to preserve some kind of SELinux
> > > permission check here.
> > >
> >
> > So I understand correctly, what you're asking for is to change this section:
> >
> >     if (is_sehash)
> >         return 0;
> >
> > to this instead:
> >
> >     if (is_sehash)
> >         return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> >
> > Is that correct?
>
> I would suggest using FILE__RELABELFROM instead, under the raionale
> that a process that is allowed to set security.sehash would also be
> allowed to set security.selinux.  In contrast, a process might be
> alowed to set another attribute (FILE__SETATTR) but not
> security.selinux or security.sehash.
>
> > > Second, security.sehash logic in userspace was introduced by Android
> > > in its libselinux fork and then copied in upstream logic.  I'm not
> > > sure Android wants to relax the current requirement for CAP_SYS_ADMIN
> > > - I have copied them above.  A possible concern is that an
> > > unprivileged process could disable the relabeling of a part of the
> > > tree that it owns upon an upgrade, which could have unexpected
> > > consequences.
> >
> > That's a good point.  Is this not an issue for the selinux xattr
> > because the selinux check could prevent a process from changing the
> > label of a file it owns?
>
> Correct.
>
> > The background for this patch is that I have a fuse server that runs
> > in a user namespace.  It runs as root in that namespace and keeps all
> > the file system caps so that it can set selinux xattrs.  However, it
> > cannot set the sehash xattr as that needs CAP_SYS_ADMIN in the parent
> > namespace.  Looking at the code I thought that might have just been an
> > oversight but if it's intentional then do you have any suggestions for
> > how to make this work?  I'd rather not weaken the sandbox for this
> > process just so that it can set this one xattr.
>
> I'd be willing to move from requiring CAP_SYS_ADMIN to performing a
> SELinux permission check (either FILE__RELABELFROM or a new one), but
> I'd like the Android folks to chime in here.  Maybe you can ping them
> through other channels since they haven't responded yet.

One thing to note however is that setting of security.sehash is just
an optimization to avoid unnecessarily walking the tree again.
Not sure if that matters for your use case.
