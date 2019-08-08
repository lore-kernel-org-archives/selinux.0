Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E7C433FF
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D4218BA
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfHHH7x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:59:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45352 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfHHH7x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 03:59:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so21811763otq.12
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2019 00:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHKc1nqV6r+sye72Gbcul5qu7ivZjMnQlJDhy7guy84=;
        b=BZNYosIZImVwKJOQAX1Z/z/6qMLdpEwKcCVnof5+zWyJxljHUjgp4udRPdA3LNij7L
         kcHtUrF/nDyyQExbdLHnHqM2wriANpJAhW20h3KB6dIibG7i3hx5JD71oOmEB6pUvQfz
         zHXMxK9suzMzwbk50kZR2jMI1Ph/TMv8mqL9IHOUYgNwyN+L1hxKM3z+8WpIPnf2+HFX
         jylS+eQzLdXGLRnKF7ROuFbBJirXfGrvW9YtFnDA0bQCV5mWz/9pcJ5NmZlRDtk5gkCN
         Ql4ae4NRX3V8kqL7gu7aS6I0gmcpnc2LsJWTiA4ibITVLf1G+iHuU1U9wAQGbLw5zZX7
         uXuA==
X-Gm-Message-State: APjAAAWZ+sJqHDdKX3eKrz8F5NuBgiATgCLHG8Ne+vRgrbVKhxY4kXPP
        +FEmbT3UNbs1xNdfp8lYyi80cqkePnuH9mr1x+3/jQ==
X-Google-Smtp-Source: APXvYqzo1ASOcZyBInSR+hD3Aad0gC0HonCxDXa/g6l1dqbWRagMtLJFx/QpUURx8i6UxazoEheDYa6IZ6Vh82C3ZI8=
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr10823891otf.367.1565251192452;
 Thu, 08 Aug 2019 00:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190801140243.24080-1-omosnace@redhat.com> <20190801160910.GW1131@ZenIV.linux.org.uk>
In-Reply-To: <20190801160910.GW1131@ZenIV.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Aug 2019 09:59:41 +0200
Message-ID: <CAFqZXNs5igF_G8=EA+bD-JRorS6xeuCiXQr5vweaJFYNwEVKZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 1, 2019 at 6:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Aug 01, 2019 at 04:02:39PM +0200, Ondrej Mosnacek wrote:
> > After hours and hours of getting familiar with dcache and debugging,
> > I think I finally found a solution that works and hopefully stands a
> > chance of being committed.
> >
> > The series still doesn't address the lack of atomicity of the policy
> > reload transition, but this is part of a wider problem and can be
> > resolved later. Let's fix at least the userspace-triggered lockup
> > first.
>
> I don't think this is the right approach.  Consider the related problem:
> what happens if somebody has mounted something upon a selinuxfs file?
> That is the hard part here, and AFAICS your variant doesn't help it
> at all...

But that's another independent problem and it's not even fixed in
debugfs, which for now I'm treating as the baseline as I don't know of
any other filesystem that needs to remove its own directory trees in a
similar way.

I get that you don't want me to add a new function to the dcache API
that isn't bulletproof (and what I wrote here is apparently still far
from it), but you also previously said that I shouldn't open-code this
stuff in selinuxfs.c... I don't think I have the wits to write a
common function that handles all the possible issues, but I still want
to fix at least this one scenario (dcache_readdir() vs.
sel_remove_entries()).

Is there some way I could do this without getting a NACK from you? For
example, I thought of taking what is now debugfs_remove[_recursive]()
out of debugfs into, say, fs/libfs.c (providing some optional callback
to allow debugfs to do its __debugfs_file_removed() business) and use
this function(s) from both debugfs and selinuxfs. This way we could
later fix the leftover mount issue in one place and both filesystems
would (hopefully) immediately benefit from it. Would that be a
feasible way forward?

Thanks,
-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
