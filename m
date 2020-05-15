Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376EC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 18:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916C620657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 18:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKFd5P4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEOSJN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSJM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 14:09:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFFFC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 11:09:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h10so3651974iob.10
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoP23J27R3QIT3WBbMSImgioDIlKaoZWfgdknL4uumo=;
        b=CKFd5P4KtOjzlFDeDztZbL5B84kxbEuhv3IfY2eY4mVqAr0lEC0VfO9OCwd5i40HBs
         Kczx9k3lU82Xk2Cs7gQgBoPdxXws3XAUuZCn2kQ4yULc/nVN1cGvxQhFLn6l6FLSUm1O
         88hLw+mNJEdpiY3vbi8tpepDtQ/3D4wveDJxJ8XTgaPl6iAzeGGYY6NRwhzrGDRwbHGS
         lqr0/JhkvCEB5phO2KEMHnCnBZg4dy5rTrc2fQzcU7R0WT/myYgREXEu60Gl/vf6kpwq
         ERV/ACFUhVRbjsKi4n4UOWQQYyfQjyI7/J5gVtlbnK6/eL81qp/WkQIIeuajtkgs3vM3
         W52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoP23J27R3QIT3WBbMSImgioDIlKaoZWfgdknL4uumo=;
        b=oSY56M2mggIeJE+rk1GLT0BTumEy38u9Dh6HWVwaj663629fPEZdUDPbfpnlQpESvC
         FJv3PSUBdsOw9QS1CqgXWE957sJKWJl0ZrYv2ZeQ1ciccG4+7bk/acM8Fja19Qh29Qhi
         7iZlaxYZr+3uRqJWvbtd9A8dZws2zUbhyZjYhzl+RGE9QUf4ld+bW7TZ1DjOSWv2taJA
         SQZpeQ4Yf+T2V4Z0o1ing8NmBc7CDhKy2FWrjVtsq66oUAmtyCIu24fsI01IoTb1lfyA
         WCpDH9C2wI86QfkJ3FSfZtdPWYkYLGCPuenMcQjwl+d2O4yp+jfd7CCLRdAGX4vc3fqp
         TEmQ==
X-Gm-Message-State: AOAM533KSybjj+ETxuEMZhfx/xKUnq9YkGxfbsL41WKZvAZJSngHZUEa
        Nu+aPzDQzPxqNDOY6ItUJp30S66ZBqL3E7Dlxno=
X-Google-Smtp-Source: ABdhPJw/DV5Apn31DCeJ21m4fioDZ2l15Xe+OVLJVb6q9gXiwOMR7MolvXd22IczQ7jJfG1300iV/nloBzRhGICs2Do=
X-Received: by 2002:a5e:cb4d:: with SMTP id h13mr2132953iok.141.1589566148721;
 Fri, 15 May 2020 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com> <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
In-Reply-To: <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 13:08:57 -0500
Message-ID: <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The text above states that kernel-devel is needed, but it's missing from
> > the dnf command.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  README.md | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index 1f7e5d92a100..a73e9cc0c06d 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -77,7 +77,8 @@ following command:
> >                 kernel-devel \
>
> It's actually right there already ^^

Yeah that's the foot cannon, I thought I was good, but you need the
specific ones
as Ondrej pointed out to me.

>
> >                 quota \
> >                 xfsprogs-devel \
> > -               libuuid-devel
> > +               libuuid-devel \
> > +               kernel-devel-$(uname -r)
>
> I proposed adding the -$(uname -r) before, but there were some valid
> counterarguments. See the discussion here:
> https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
>

Arguments for why the dnf command should have it with uname:
1. We tried to add it twice, it's bit people twice.
2. The README states "On a modern Fedora system you can install these
dependencies with the following command:"
    - which is wrong, you need the specific package
    - If you're going to provide a "dnf install" or a apt-get install,
it should just work
    - the apt-get example has uname -r in it.
    - so the precludes building your own kernel, if you do that as
Paul stated, you're on your own. (lore comment)

> >
> >  #### Debian
> >
> > --
> > 2.17.1
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
