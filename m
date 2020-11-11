Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8214C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4868D20679
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 10:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBf7x/wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKKKTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbgKKKTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 05:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605089969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unrVS5XRWPMEfFyYeQcSu76sV2Fn9qqc3KUqZzmBsVg=;
        b=VBf7x/wp95nVpusjQVsD0ucEYE/Q2dok54Rrdg9jTrslNuloQsLDG/tew1WVwybcAn7PsS
        JW+24keqsjGDy1H38o+cc1FNuJnkhtnNeJtYapHsKp04CI0fYMdIgrMXYirOx0wNt9twQp
        IX2KA4RMRxXcbFA6h13Qpk1eW5ZKn+4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-dlY5E5P9OHSjtyHbbBUL2A-1; Wed, 11 Nov 2020 05:19:27 -0500
X-MC-Unique: dlY5E5P9OHSjtyHbbBUL2A-1
Received: by mail-lj1-f199.google.com with SMTP id o13so623291ljp.7
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 02:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unrVS5XRWPMEfFyYeQcSu76sV2Fn9qqc3KUqZzmBsVg=;
        b=Q2k+SJHqdYp82a17tMnTMpLZLO2FJjCKUJl1uFOErbU70MK53sRETeXO847JRLPn0L
         hTRuOB7/wpimVkqjkbmlpvqT9M3X/oR3cLizDEA1D8j+fiCUU5Z5leqEnscaMmOZuQXD
         PkxrCvA/n+VjJKGfemgwzSgA7W3Pc14td+Ux4briq0OHXMUlajWXOGH+ei9spNz0pACD
         9KNkbPulfnZZfdXls4DwndBZo15OSc+7B+Oq/vqW1PWF1SiFUaeKsbpwyYNIf/LuQj28
         nlqO8DYlXsLj4/NZGEAmipDsOcZOqDOhEYSjOkbjBvLK5HKRAC6pKrWdLdyiftqTcwLR
         T2WQ==
X-Gm-Message-State: AOAM531y+dLsoWr3pA3ej7csBhNBLdJoJ4qcKYej2m1jDOQd1q4etrSG
        wopG1NO20Wo++gb0GSp+Y88f8oIH0hgfXZCiGvcijDrtn9WVDAp3utipUfxZUHHnARTre+zdLyc
        pG6kLAx+1HdSAmOoR6v/IApvhB7HRmLxEEg==
X-Received: by 2002:a19:bd2:: with SMTP id 201mr7833709lfl.478.1605089965956;
        Wed, 11 Nov 2020 02:19:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHxB86RAqARGLYD8JLh3l4I344sngjrlhq1bPwLAxEVx7bJFrfPLKcnJRLRLO2i/rA+nnIRL7NwxFe7OkCGgM=
X-Received: by 2002:a19:bd2:: with SMTP id 201mr7833706lfl.478.1605089965776;
 Wed, 11 Nov 2020 02:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20201111095134.481658-1-omosnace@redhat.com> <20201111100735.GA213493@localhost.localdomain>
In-Reply-To: <20201111100735.GA213493@localhost.localdomain>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 11 Nov 2020 11:19:15 +0100
Message-ID: <CAFqZXNteFTp2o9-MOSwJSS601MjmjQEL-S9x7g5exyvy+oLhUA@mail.gmail.com>
Subject: Re: [PATCH userspace] selinux(8): explain that runtime disable is deprecated
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 11:07 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Wed, Nov 11, 2020 at 10:51:34AM +0100, Ondrej Mosnacek wrote:
> > Update the main SELinux manpage to explain that runtime disable (i.e.
> > disabling SELinux using SELINUX=Disabled) is deprecated and recommend
> > disabling SELinux only via the kernel boot parameter.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  libselinux/man/man8/selinux.8 | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> > index 31364271..721a65f4 100644
> > --- a/libselinux/man/man8/selinux.8
> > +++ b/libselinux/man/man8/selinux.8
> > @@ -19,12 +19,12 @@ enabled or disabled, and if enabled, whether SELinux operates in
> >  permissive mode or enforcing mode.  The
> >  .B SELINUX
> >  variable may be set to
> > -any one of disabled, permissive, or enforcing to select one of these
> > -options.  The disabled option completely disables the SELinux kernel
> > +any one of Disabled, Permissive, or Enforcing to select one of these
>
> Is there a reson for these changes?

Just for better readability. Although I should probably just mark them
up, as in selinux_config(5)...

> policycoreutils/man/man5/selinux_config.5 aka selinux_config(5) doesn't use
> capitals:
>
>     SELINUX = enforcing | permissive | disabled

Good point, it should be consistent. And also that page will need a
similar update. v2 coming soon...

>
> > +options.  The Disabled option completely disables the SELinux kernel
> >  and application code, leaving the system running without any SELinux
> > -protection.  The permissive option enables the SELinux code, but
> > +protection.  The Permissive option enables the SELinux code, but
> >  causes it to operate in a mode where accesses that would be denied by
> > -policy are permitted but audited.  The enforcing option enables the
> > +policy are permitted but audited.  The Enforcing option enables the
> >  SELinux code and causes it to enforce access denials as well as
> >  auditing them.  Permissive mode may yield a different set of denials
> >  than enforcing mode, both because enforcing mode will prevent an
> > @@ -32,6 +32,24 @@ operation from proceeding past the first denial and because some
> >  application code will fall back to a less privileged mode of operation
> >  if denied access.
> >
> > +.B NOTE:
> > +Disabling SELinux by setting
> > +.B SELINUX=Disabled
> > +in
> > +.I /etc/selinux/config
> > +is deprecated and depending on kernel version and configuration it might
> > +not lead to SELinux being completely disabled.  Specifically, the
> > +SELinux hooks will still be executed internally, but the SELinux policy
> > +will not be loaded and no operation will be denied.  In such state, the
> > +system will act as if SELinux was disabled, although some operations
> > +might behave slightly differently.  To properly disable SELinux, it is
> > +recommended to use the
> > +.B selinux=0
> > +kernel boot option instead.  In that case SELinux will be disabled
> > +regardless of what is set in the
> > +.I /etc/selinux/config
> > +file.
> > +
> >  The
> >  .I /etc/selinux/config
> >  configuration file also controls what policy
> > --
> > 2.26.2
> >

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

