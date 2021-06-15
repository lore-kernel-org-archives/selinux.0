Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A4C48BE8
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77450613F1
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 09:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhFOJhv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhFOJhm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 05:37:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F9C061283
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 02:35:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nb6so1284240ejc.10
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wUc2OfdjdbqnjL6W8FMiwr8yZ9/oxUaW69sqUYNuKM=;
        b=kNFfY93yyM1OSr4ACCCk1RSsFVhJXWC1MfeZ/3ASEmu5JYM6r+oD/0AT8FYuuOZp3e
         Z8qLnCYtJiNwPTuT0ipSTL6GWLVciFocanwPijZfqyIaD+yTIrGlutD0qmKWNsTosETJ
         ZXWxRR+HfQ9bd2jRuElwI9C5LQ8cDz/1J/fAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wUc2OfdjdbqnjL6W8FMiwr8yZ9/oxUaW69sqUYNuKM=;
        b=qbsHCCGgA9g9i2wiGaqzPg7qdOkgCZf5+4smg8WtGmCKslTGfHNADflWi7NunDLUyx
         WhIomkbXmFHWgViGLgkiron/detlZacsjxsK41FolJPuAak23pe9wPF/mn8+2suKGq+m
         9fRkOYSzdETOWpU+kewfw9enHaZtQ/VrCwgNWeCT8L6PoD9qQp4GipBsmHo+vhdIJVx3
         70ra09iqA5XQNwOITuh3hmwH/c8l/jwQ1kypBdJNl8wMyu35MWszJLo/ZVpfA6oUiSB9
         Gqzzio0vohbWsaXoxxcNn8SGPRNrtB4dEvuIceXTFTBVhZRrt4OMeteh0a29Lc4fZVLS
         RWBw==
X-Gm-Message-State: AOAM5339247B8Y6nYKVYMScZkdh066bv9Lr8lOz9fzNCCOsyjDOExWEs
        PN4xN0BqJu2IfOSlPapxEiaIAn29YBvk2QQoM7Qw7w==
X-Google-Smtp-Source: ABdhPJx7fh9LOmwCnFieYYThc9zENem+W4yQBvIwptCjcrQ/iz53nv9g6de5F6QmUpPuE4r+whaklEr/9RvGVhPC8Ao=
X-Received: by 2002:a17:907:20ee:: with SMTP id rh14mr19926420ejb.461.1623749732894;
 Tue, 15 Jun 2021 02:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200722090758.3221812-1-chirantan@chromium.org> <20210614212808.GD869400@redhat.com>
In-Reply-To: <20210614212808.GD869400@redhat.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Tue, 15 Jun 2021 18:35:21 +0900
Message-ID: <CAJFHJrpu9vewcD2er6oB_xwtF4Pc-njkRaA7rfJwsTvw5Fi2og@mail.gmail.com>
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Vivek,

On Tue, Jun 15, 2021 at 6:28 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jul 22, 2020 at 06:07:57PM +0900, Chirantan Ekbote wrote:
> > Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> > fuse_init_out struct.  When this flag is set the kernel will append the
> > security context for a newly created inode to the request (create,
> > mkdir, mknod, and symlink).  The server is responsible for ensuring that
> > the inode appears atomically with the requested security context.
> >
> > For example, if the server is backed by a "real" linux file system then
> > it can write the security context value to
> > /proc/thread-self/attr/fscreate before making the syscall to create the
> > inode.
> >
> > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
>
> Hi Chirantan,
>
> I am wondering what's the status of this work now. Looks like it
> was not merged.
>
> We also need the capability to set selinux security xattrs on newly
> created files in virtiofs.
>
> Will you be interested in reviving this work and send patches again
> and copy the selinux as well as linux security module list
> (linux-security-module@vger.kernel.org) as suggested by casey.
>

Not really.  We have our own local solution for this (see below) so if
you or someone else wants to pick it up, please go ahead.

> How are you managing in the meantime. Carrying patches in your own
> kernel?
>

Kind of. This patch series changes the protocol and the feature bit we
were using was claimed by FUSE_SUBMOUNTS instead so carrying it
locally is not really viable long term.  Instead we're carrying a
patch similar to the original RFC patch that doesn't change the
protocol [1].

Chirantan

[1]: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2581172
