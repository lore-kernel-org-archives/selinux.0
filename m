Return-Path: <SRS0=QxhH=2Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25EC32767
	for <selinux@archiver.kernel.org>; Fri,  3 Jan 2020 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AC221835
	for <selinux@archiver.kernel.org>; Fri,  3 Jan 2020 09:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjXxqb43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgACJcz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:32:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgACJcz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jan 2020 04:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578043974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hG5Q9vhcZG5Wd6ocJI6dU3GALHIbQ+VzDS0McYQNwxQ=;
        b=JjXxqb43NLXJEg1cnDPxAgpwVURTQXSzsI5oAk32oj/6LUKHor4iIh6nf3sA+2QfLo7ZOS
        WVk19fQBgRgYarKN43HqF6X+jdk1kUhiyTGnwkeI+dZIi0sWWexvDdXGCavPlvwtoKQRV1
        TtMGlPOTvA81wVSnsSxlBo+QS021HMc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-pDVlsBTxPU2udT_JNenPWA-1; Fri, 03 Jan 2020 04:32:51 -0500
X-MC-Unique: pDVlsBTxPU2udT_JNenPWA-1
Received: by mail-oi1-f197.google.com with SMTP id c4so1443911oiy.0
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2020 01:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG5Q9vhcZG5Wd6ocJI6dU3GALHIbQ+VzDS0McYQNwxQ=;
        b=FqeZvHQPJBBjMltnC1+KoKhDo6C2cojtfyzA6nQOQpp7aMo+Vo98HkC2L4RkeeNt0M
         G1FExttrTusxkett9zmAdEustcULMYxkSzwiooMg4+Njw7ur4O0i3uKGKXxjhwSKtqOX
         WS4bRu+mM4Jg9JS+pgMEkaXpxYrfeZrJMdyoiRrsFnI+vHc+ZB5js6g/57JE065IhMiB
         8z4VpG9CbMSjWUAbAQcAXuUWQQgW0MdAdkXsX15cIFNdRX0r6jxWVDEh1knBex4nZAN4
         HEO1Pq0cB7gTbWlGn99AS8FzO7UqEX8usGmdv2H1f4pHU/RjvwpsvS+68kZAu7XZAXR6
         3rqA==
X-Gm-Message-State: APjAAAXrTBxkzSUUL8L7kbk/JcJvRg2ABvk13C+nFnchUrMF8fRQ5LWj
        mKzhHko0Ne1VNvm8Ej8rCz4Ejg+BMRiFeegQrYdIvMIJ9Mhr3lh8sKimw7gBAJt13UsnWzXYFfm
        QZ6JFMeCFu11cxenL02UuNkwgGSVq+Xs0dQ==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr80060859oto.367.1578043970747;
        Fri, 03 Jan 2020 01:32:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqytjxQEJPalZMGDnik9IRoxtCxyOMSp3eFv1NtMz+TbTI3pmpfamRWNYnoNosMnG3Dk+6fGK3es/mWhhNRcLFY=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr80060840oto.367.1578043970454;
 Fri, 03 Jan 2020 01:32:50 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester>
 <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com> <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com>
In-Reply-To: <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 3 Jan 2020 10:32:39 +0100
Message-ID: <CAFqZXNubaXZtF-yN6tMBuM+AGmSy=1nTcTimFfXaok32GY3aYA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 2, 2020 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jan 2, 2020 at 4:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Dec 19, 2019 at 8:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> > > code was originally developed to make it easier for Linux
> > > distributions to support architectures where adding parameters to the
> > > kernel command line was difficult.  Unfortunately, supporting runtime
> > > disable meant we had to make some security trade-offs when it came to
> > > the LSM hooks, as documented in the Kconfig help text:
> > >
> > >   NOTE: selecting this option will disable the '__ro_after_init'
> > >   kernel hardening feature for security hooks.   Please consider
> > >   using the selinux=0 boot parameter instead of enabling this
> > >   option.
> > >
> > > Fortunately it looks as if that the original motivation for the
> > > runtime disable functionality is gone, and Fedora/RHEL appears to be
> > > the only major distribution enabling this capability at build time
> > > so we are now taking steps to remove it entirely from the kernel.
> > > The first step is to mark the functionality as deprecated and print
> > > an error when it is used (what this patch is doing).  As Fedora/RHEL
> > > makes progress in transitioning the distribution away from runtime
> > > disable, we will introduce follow-up patches over several kernel
> > > releases which will block for increasing periods of time when the
> > > runtime disable is used.  Finally we will remove the option entirely
> > > once we believe all users have moved to the kernel cmdline approach.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Looks reasonable, informal ACK from me.
>
> Thanks.  You want to make that a formal ACK? ;)

Sure, if you find it useful :)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

