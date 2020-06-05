Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21333C433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0105A206E6
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 12:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpWeCZ/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFEMXw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFEMXw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 08:23:52 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C20C08C5C2
        for <selinux@vger.kernel.org>; Fri,  5 Jun 2020 05:23:52 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 7so1922652oof.8
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2020 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtiqhoLEWE3I/+deR/k755lH/Gake73PqXT5xce5IUw=;
        b=PpWeCZ/L0NdMinOIIuT5VdrtmSldzxz2Xv2x2RV7srlqlW2Hjj/coODuNXgfkPxwH7
         mQiSpETW/e2SWtRsuiXV5zztcXNueejpijodVZkBJ34ueG3S96Fxo71HdawNPmpqLxRR
         La4PVr0+41nee/u5MSoWmGXQtu0J7agoEhwZkYuQukUFnIETTILVnJkFh9ziAB9JCfvQ
         xB8IZ4LrpBcK0hDRbj7wlTWhy4gqnTV1xb9F5XCiPg49XXh8Lk70DO7qTQgf0DghmpgS
         74iqeI8UGLlsJ4Chssq4B0tAIyYH6Xz81PDlW9hVfyXR9PV8Nrt3gadxf3j4Idm0xEmG
         H24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtiqhoLEWE3I/+deR/k755lH/Gake73PqXT5xce5IUw=;
        b=b2VBKCgUec1xufNJA07ozrkqcQPT9GnWNdsEF8pSm79ufDdgZtrTjLW5lzy1KHmGi5
         IYq6gK8kv0egobeUrn/OMMacTNmrRXqDHusgUq9/XjCi/ZID6JuQsUer3F0wibb5xYVe
         eH2jxqdWcBYCcV3/s3O3q0u7iZv1uMZIPfuip+6w9FKxCkcjX/dE53Tqt660mz1TR0Wd
         jMrS+odHnsGGqY8wkM1lGBaf2VSPX+D7mNPRe2nMoTRrd17RO7dAI4w5xtavzzD126bZ
         HTKnMtsKQjlLwHSZXtt63s+PByw0wMv/I6SqRLZ9xogiSy9Qiae+s0RqQbVayUY8p6z/
         um1w==
X-Gm-Message-State: AOAM531Xwm61QKHAwn4wGaAlowGmpFbAP62HeIhCX3Af6EItFGLVkvSJ
        l2+NJFvSuT0pr0sTkc4Vop798VshcUF+yC8HQE8=
X-Google-Smtp-Source: ABdhPJwgeBnJq66X1G3DVIMnBnlpneKwumczQxyaY+BgPmvwvkdc84eoJBR+o4/NrI5ME+OB4O1XubkmnRANcjOPMAU=
X-Received: by 2002:a4a:abcb:: with SMTP id o11mr4865015oon.58.1591359831681;
 Fri, 05 Jun 2020 05:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200601072916.219197-1-chirantan@chromium.org>
 <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com> <CAJFHJrp6pM1EUcBWFL4bKQUA4wZT4N5_0QutXv5vXr7TNAvqVg@mail.gmail.com>
In-Reply-To: <CAJFHJrp6pM1EUcBWFL4bKQUA4wZT4N5_0QutXv5vXr7TNAvqVg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 5 Jun 2020 08:23:40 -0400
Message-ID: <CAEjxPJ7QD-zPyytQ6-VpuoAqnuS91fzA3nj-711OsK_9cy-kWQ@mail.gmail.com>
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

On Fri, Jun 5, 2020 at 2:21 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> On Mon, Jun 1, 2020 at 9:42 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jun 1, 2020 at 3:29 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> > >
> > > Normally a process needs CAP_SYS_ADMIN in the namespace that mounted a
> > > particular filesystem in order to set a security xattr. However, this
> > > restriction is relaxed for the security.selinux xattr: the file owner
> > > or a process with CAP_FOWNER in its namespace may set this attribute.
> > >
> > > Apply this relaxed restriction to the security.sehash xattr as well.
> > > Since this xattr is mainly a performance optimization when labeling
> > > files recursively it shouldn't have stricter requirements than setting
> > > the selinux xattr in the first place.
> >
> > First, setting either security.<non-selinux> or security.selinux has
> > an additional MAC check beyond the DAC/capability check; in the former
> > case there is the FILE__SETATTR check and in the latter there are the
> > FILE__RELABELFROM/TO checks.  We need to preserve some kind of SELinux
> > permission check here.
> >
>
> So I understand correctly, what you're asking for is to change this section:
>
>     if (is_sehash)
>         return 0;
>
> to this instead:
>
>     if (is_sehash)
>         return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
>
> Is that correct?

I would suggest using FILE__RELABELFROM instead, under the raionale
that a process that is allowed to set security.sehash would also be
allowed to set security.selinux.  In contrast, a process might be
alowed to set another attribute (FILE__SETATTR) but not
security.selinux or security.sehash.

> > Second, security.sehash logic in userspace was introduced by Android
> > in its libselinux fork and then copied in upstream logic.  I'm not
> > sure Android wants to relax the current requirement for CAP_SYS_ADMIN
> > - I have copied them above.  A possible concern is that an
> > unprivileged process could disable the relabeling of a part of the
> > tree that it owns upon an upgrade, which could have unexpected
> > consequences.
>
> That's a good point.  Is this not an issue for the selinux xattr
> because the selinux check could prevent a process from changing the
> label of a file it owns?

Correct.

> The background for this patch is that I have a fuse server that runs
> in a user namespace.  It runs as root in that namespace and keeps all
> the file system caps so that it can set selinux xattrs.  However, it
> cannot set the sehash xattr as that needs CAP_SYS_ADMIN in the parent
> namespace.  Looking at the code I thought that might have just been an
> oversight but if it's intentional then do you have any suggestions for
> how to make this work?  I'd rather not weaken the sandbox for this
> process just so that it can set this one xattr.

I'd be willing to move from requiring CAP_SYS_ADMIN to performing a
SELinux permission check (either FILE__RELABELFROM or a new one), but
I'd like the Android folks to chime in here.  Maybe you can ping them
through other channels since they haven't responded yet.
