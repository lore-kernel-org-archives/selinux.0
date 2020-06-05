Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C0C433DF
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778AE207F7
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 06:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXDi6aYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEGVm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGVl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 02:21:41 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE318C08C5C2
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 23:21:41 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id j202so3006414ybg.6
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=800/9YG8i2X/pTxHRfITBzZGfjMdWxM6aKOTpK0YNCs=;
        b=mXDi6aYarMMQiHTd0B5AYe7IR236veBgpi1bMHy/yGeQtRbvGpNW1SkveUmn/7cSKr
         yRsMJ/P+oobZ3LK9NZITvAfajpLAQ59cuDt+aWIngGR2Gd1MNJC4NoxY4ugOGifZq+lF
         qO2tlYQKIZ/0oDy42aJ7I4ZduTNxXbScKLllc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=800/9YG8i2X/pTxHRfITBzZGfjMdWxM6aKOTpK0YNCs=;
        b=Rc3W/31o5UDN1GeeHJIJPESQG8rHyjDTa/GJq2DtFJASfGUr3I1qoExYhx7G7qABp0
         CgAk4nNQw43J5x0iusF03dgFrHfcmc3DCDvaQZtqmoZu6MjnPqaGhJ4WkwoKmc7shT8V
         W/s1z1n3guJUiLpYXVYJbqgCtGqDZHOx6RRI0WvYeNESu/CzF13ZIb26/3pPI7s+F/EA
         IR8bAaPX0A5D4AsVoK1flS0biy8zzE30QAEV2wQJPLKHkHaV58kRJ+xWu1MFyeu6nGjv
         qIPRBfvNBeUDd2ttcvyty4BocreYdiXkuN+5tAORiIemj95kTA1PJLhdfJuadw8NYLTl
         +0TQ==
X-Gm-Message-State: AOAM5326LbvoBP53jNbkfx9YIG51qI3xw/o/xCYsovZYUCZ1UkHz7fBN
        RAWPr54dNR4bwXUif65gOwsyxKQSWCW4mLYxdrs8fQ==
X-Google-Smtp-Source: ABdhPJyUCDbYUQ0WNc3w6krqbfCQAtbIff1j8IzBUmTYrJsMWyAsPiQW8RmlEBVdXNvuY6mvysGMJvCsTH88bJKpr5w=
X-Received: by 2002:a25:a0c7:: with SMTP id i7mr13174748ybm.169.1591338100683;
 Thu, 04 Jun 2020 23:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200601072916.219197-1-chirantan@chromium.org> <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 5 Jun 2020 15:21:29 +0900
Message-ID: <CAJFHJrp6pM1EUcBWFL4bKQUA4wZT4N5_0QutXv5vXr7TNAvqVg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow file owner to set "security.sehash"
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Mon, Jun 1, 2020 at 9:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 1, 2020 at 3:29 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > Normally a process needs CAP_SYS_ADMIN in the namespace that mounted a
> > particular filesystem in order to set a security xattr. However, this
> > restriction is relaxed for the security.selinux xattr: the file owner
> > or a process with CAP_FOWNER in its namespace may set this attribute.
> >
> > Apply this relaxed restriction to the security.sehash xattr as well.
> > Since this xattr is mainly a performance optimization when labeling
> > files recursively it shouldn't have stricter requirements than setting
> > the selinux xattr in the first place.
>
> First, setting either security.<non-selinux> or security.selinux has
> an additional MAC check beyond the DAC/capability check; in the former
> case there is the FILE__SETATTR check and in the latter there are the
> FILE__RELABELFROM/TO checks.  We need to preserve some kind of SELinux
> permission check here.
>

So I understand correctly, what you're asking for is to change this section:

    if (is_sehash)
        return 0;

to this instead:

    if (is_sehash)
        return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);

Is that correct?

> Second, security.sehash logic in userspace was introduced by Android
> in its libselinux fork and then copied in upstream logic.  I'm not
> sure Android wants to relax the current requirement for CAP_SYS_ADMIN
> - I have copied them above.  A possible concern is that an
> unprivileged process could disable the relabeling of a part of the
> tree that it owns upon an upgrade, which could have unexpected
> consequences.

That's a good point.  Is this not an issue for the selinux xattr
because the selinux check could prevent a process from changing the
label of a file it owns?


The background for this patch is that I have a fuse server that runs
in a user namespace.  It runs as root in that namespace and keeps all
the file system caps so that it can set selinux xattrs.  However, it
cannot set the sehash xattr as that needs CAP_SYS_ADMIN in the parent
namespace.  Looking at the code I thought that might have just been an
oversight but if it's intentional then do you have any suggestions for
how to make this work?  I'd rather not weaken the sandbox for this
process just so that it can set this one xattr.

Thanks,
Chirantan
