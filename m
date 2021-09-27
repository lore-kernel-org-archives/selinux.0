Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A4C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3FB603E8
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhI0J3G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233587AbhI0J3F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 05:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632734847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3I+WdSUisg3oFUvAySZtnZKdJtK6PhckibDqMpD5iU=;
        b=UbsRlF+KtLq5C0gFpmisLSyKQHSxs5n3lbi31OmzJX4Pf7WSjTfv6cHwlwHTMH0n4B08sm
        aHYoUTaT/3GCZCqQtKRG2WXXlvhuuaX71OFRDplu/tsqIVNTGUqMKjrxCgL8oOEk8iROsF
        Y3U7AGnoLThPaoAbMjJAspRwLDTt4o4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-4JkbGPxPMO2NRmf5B5O0cw-1; Mon, 27 Sep 2021 05:27:26 -0400
X-MC-Unique: 4JkbGPxPMO2NRmf5B5O0cw-1
Received: by mail-yb1-f197.google.com with SMTP id b5-20020a251b05000000b005b575f23711so14960446ybb.4
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 02:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3I+WdSUisg3oFUvAySZtnZKdJtK6PhckibDqMpD5iU=;
        b=0zncSKPQ/5gKU9uTDlQ4jLxELl5CDFRmx9nukqR4JL+4PsAi0E/OasXU9X6jkRPEjs
         Nv/cE/u9NyBxzd0L/+98+G7XdTXGLJJJzFQ5HM/RL1bnEXIkJvF/R8DA58Xxeu/zC/xY
         8QjEQAlZhIm72yLRLpmTTAQCHgQcsMUV/Z6UgtHcFWjfO6Sh1TxSznquYEgXPN6x4TgL
         qKH9N37ScHVF3fw9FNP56NnaphWfJPAFCHwcn+O5BJnFH6FK/iYEZrBaBBr9QxJVMtCE
         KXFgrOkQLT10Hu7l6HVrWEyNz2YPw9Qmj2bXFQaUR3ffTeQo89Bp1xJXELPUhOywcmYJ
         Dumw==
X-Gm-Message-State: AOAM5310Z68ZADRsTpjEBC+tqZLG7eriWIucoI/ecdRFv9UX93AxLof3
        /Ms8dk6ihuMkYdO6mO0KdrrMjVutPE3EMlhM8JPHZk84jvdjAzoUr8nKvOPzZyFw2r0+720Yugu
        ToK5fZ1rzubgoY8WHSuFywP9hh+loe1S+2w==
X-Received: by 2002:a25:51c2:: with SMTP id f185mr27015734ybb.479.1632734845887;
        Mon, 27 Sep 2021 02:27:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5ceClFdSx7IRWN4FXl3uRuUQ+bQB6UEGRCj2F1nd9vRB7s6rKVm9u1VhCY8rdo2JRPl6nw7KgBZ5up8rEIG8=
X-Received: by 2002:a25:51c2:: with SMTP id f185mr27015720ybb.479.1632734845699;
 Mon, 27 Sep 2021 02:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210927080634.4668-1-nicolas.iooss@m4x.org> <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
 <CAJfZ7=mDLP1HxXk=HsquzR0g2S7-0XMhXcd=EXcMOVgz+7fz5g@mail.gmail.com>
In-Reply-To: <CAJfZ7=mDLP1HxXk=HsquzR0g2S7-0XMhXcd=EXcMOVgz+7fz5g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Sep 2021 11:27:14 +0200
Message-ID: <CAFqZXNtu7=nBoFE10rZF4hwXLPfs3a8RB8d3N9a7wQGen7DPXQ@mail.gmail.com>
Subject: Re: [PATCH userspace] GitHub Actions: do not use macOS latest runner
 for now
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 11:21 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Mon, Sep 27, 2021 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Mon, Sep 27, 2021 at 10:06 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > GitHub is currently migrating its macos-latest runner to macOS 11:
> > > https://github.com/actions/virtual-environments/issues/4060
> > >
> > > Unfortunately, installing VirtualBox and Vagrant on this new version of
> > > macOS is not easy, and the current macos-11 runner does not support
> > > running virtual machines using Vagrant. This issue is being fixed on
> > > https://github.com/actions/virtual-environments/pull/4010 .
> > >
> > > Until this Pull Request is merged, use macos-10.15 runner instead of
> > > macos-latest, to continue using Vagrant to run the SELinux testsuite in
> > > a virtual machine.
> > >
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > It seems to me there is a decent chance that the PR will be merged
> > before the migration takes effect, but I guess it's better to be safe
> > than sorry :)
>
> In fact, I got hit by the migration in my clone of the project, which
> I am using to test things: the job
> https://github.com/fishilico/selinux/runs/3708721148?check_suite_focus=true
> ran on macOS 11, and failed with:
>
>     /Users/runner/work/_temp/b65b7c49-de57-4461-9491-3d074d375d2a.sh:
> line 2: vagrant: command not found
>
> So the migration is already being rolled out, as described in
> https://github.com/actions/virtual-environments/issues/4060#issue-993165185
> :
>
>     This change will be rolled out over a period of several weeks
> beginning on September, 15. We plan to complete the migration by
> November, 3.

I see. On selinux-testsuite the runners were still running on the old
macOS, so I assumed it hadn't started yet.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

