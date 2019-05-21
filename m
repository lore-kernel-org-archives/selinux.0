Return-Path: <SRS0=L5Vm=TV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A9C04AAC
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 01:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AC92171F
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 01:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="esCYX9+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfEUBuU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 May 2019 21:50:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42515 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUBuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 May 2019 21:50:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so11725282lfh.9
        for <selinux@vger.kernel.org>; Mon, 20 May 2019 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nM4bvSM4KQ7O9ME7EsQl77lTp6mmTf73ABuoDRxDNMA=;
        b=esCYX9+X9aG7vdrvClRxmcvpjgAij7cj5twk6Ggbwem88gOqiGe7UeKzlmdNjcOLEl
         OVZFMR8NyuJBO1fQJ8ZDJVEbt9Qp7bJVEE4ikvMnwFjGOtt2MLqNfnChQasjIFfeBikR
         8NEhkELBZs6aY/TcfaMlFWnFpivflpbGORvMfoUwAL26UjEqeCrhc+tDjZIBD6YV/AhA
         t9F7qCTA77iBuO0oouyelny0W8kumRVME1sMjdIcunRrCh8wGUEeGGhYbc8hk6xvkT91
         vs7QHA9JVscEgqr+MHOMYbqToJmA7GWYRYlhWHz5bWVIIppMJlhw+vC0sdvIY/VUpTgS
         CsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nM4bvSM4KQ7O9ME7EsQl77lTp6mmTf73ABuoDRxDNMA=;
        b=E7cJTywG6G09ol6/gv9bP5uNBTYEY8ULWfeJgSKE7o5A2AWgRrWOW5Cscfw80uHk/6
         VymTK65gknDPfCVyfFU6XSPceD6uqG9cMmYtmlzY2NCCHZ1lBBqCDC8saW1s3zfqlvgf
         /W60sZqQ6LKMSiuVDRWXR/BPNlCheW+hLkpnm4nEwlKJtAL2Ww+GcqQNehvBBLqF6rm2
         KZ7UEHCiV9a5mNsxhcnG7ZDIbaVGU/OVJ5A/vAJdlfEFo7Wp8ax1hauvRJSm6BPe4H7W
         oVEBAxl4lKoHiYhIuCi/DI/2Xbdx2C0AkTGzab3s0M4/G4aA6LVdcyTI0leRoVqudOJx
         BVkw==
X-Gm-Message-State: APjAAAX2zLbZ/qZyRKyAx6IjjeJ11kUlrtT3ya9BbXpLjWLSQM4N//jH
        NNuD07wHdP/rQyYCxy9LuEC7jKss9aCfBTtyOpZI
X-Google-Smtp-Source: APXvYqyYP+SY0Zqv+2z5mM9Vq8V6EBAROuc9DiQfeQM6EZa3A07dzm8upUUDUfXwcensg9C9WO6kaq43eJLQN2rS9U4=
X-Received: by 2002:a19:cd82:: with SMTP id d124mr26740016lfg.8.1558403417822;
 Mon, 20 May 2019 18:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <73b14b25ad7741c9ddcef061ab65a9b7ea8811bc.1557506063.git.pabeni@redhat.com>
 <CAHC9VhQU-f82h+2QTGMspVY9sqAog6iNfGqYn00JP_sgsoF5mA@mail.gmail.com>
In-Reply-To: <CAHC9VhQU-f82h+2QTGMspVY9sqAog6iNfGqYn00JP_sgsoF5mA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 May 2019 21:50:06 -0400
Message-ID: <CAHC9VhR5gBxa_gQW-hjm3kzqE4EPR=QHef7AJxH3XxnRQaHkRQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: do not report error on connect(AF_UNSPEC)
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 13, 2019 at 6:50 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, May 10, 2019 at 1:13 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > calling connect(AF_UNSPEC) on an already connected TCP socket is an
> > established way to disconnect() such socket. After commit 68741a8adab9
> > ("selinux: Fix ltp test connect-syscall failure") it no longer works
> > and, in the above scenario connect() fails with EAFNOSUPPORT.
> >
> > Fix the above explicitly early checking for AF_UNSPEC family, and
> > returning success in that case.
> >
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
> > Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> >  - do the check for AF_UNSPEC at the begining, as suggested by Paul
> > v1 -> v2:
> >  - avoid validation for AF_UNSPEC
> > ---
> >  security/selinux/hooks.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Thanks Paolo, this looks good.  It sounded like DaveM wanted this to
> go to -stable so I'll merge it and mark it as such; I think I will
> wait until the end of this week just to see if there are any other
> things which crop up during the merge window.

Just a quick follow-up, I just merged this into selinux/stable-5.2 and
assuming the build/test runs clean overnight I'll send this to Linus
tomorrow.  Thanks again for the report and the fix.

-- 
paul moore
www.paul-moore.com
