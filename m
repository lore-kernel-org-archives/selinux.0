Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FAFC54FCB
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 20:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E448F2071C
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Lq8DKIom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZUys (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgDZUys (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 16:54:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A2C061A0F
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 13:54:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j20so11969532edj.0
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoGcWhfLxRv3rw/NxSyYWleNdyC5vux0vQKMN/t9fO0=;
        b=Lq8DKIomsAzDmXIvOwLFySxRwhkjaiDaPVartBQ6uU7oIVwFV+O3IK5gQmRfjs/JwX
         LEVw8puoWRVvhkGb3o3ClO5MFfOhLORcI2tZ7+2QIsnphEwU3s3RAMq1jJ5cejgCJnsA
         po3dObrPLwniVSy13AhtJGAiY7zJyi13U1VtYzDhBGUrj5woDBiyQtZxZIViBu/GCFLz
         YKaNk6LGLzc3Frqcn6gy5gnjqnMjkbhoGPGiAaww+PqHDr9L9fVadodsvqQx5ayOboj5
         K0clQHpF6VymyGlqgQJYNrAFfDhtFLU6VhqEq9W+UrlNlRDGS5TuUuLzKy3J8eF9lOaL
         kRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoGcWhfLxRv3rw/NxSyYWleNdyC5vux0vQKMN/t9fO0=;
        b=hCht37/Na3ogm1LQhqfo98l3MNBwGOnHQ9Owfv81iO59t5ZECWUMPxEdfvqk9P4Hth
         XQODfxxgZumKDmTnZ3ZajLjmwLg9mino7s5IK9pJYe/b+jQi5h5jB0hxBWSIeUm3lTKW
         7dpBU/UiGS1yshD+EnC81hBMe0KAA4cXQoKw4C7xYF6NUQ1cyr5x0GXkjs5TByvJGXAT
         BOjqLKHdBbMywuIg23VzbnzQkaBZjskLCL5c/AtF2+jtVT/kVM6z7YG1eKSpra0v4Qgf
         Urac2IWCg6LApFFR+/TNHLe2+Ynr7cBHKWI4jQarq5pMPxBqB39LncJlBwZEfcYF4NMk
         3z5Q==
X-Gm-Message-State: AGi0PuYztfS7PHdYo4sNGPSDZLUeRmbM8Pqv3L+PqNpRK+xoTc/PGXti
        Sp/BCn/5FQeEpX4hjkpnberygs/u1jFAkwvfYf3N
X-Google-Smtp-Source: APiQypI0+zobqXpEfu0dguTnC5NdWJT3WQBUTdUY9unU1veV/Inek3ExQ1jPOLacGrRJ5KHjAVPaVUt+li4Uh20f1aA=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr16741321edw.128.1587934486697;
 Sun, 26 Apr 2020 13:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRe25+PkmjaM8GcFZzFgDM5F3S65rfR5LuCBkangOtjGw@mail.gmail.com>
 <20200423185449.223595-1-plautrba@redhat.com> <CAHC9VhQdgvihTJPLPAzZ7O0QPTtLehdGn18vs19+mOGTG_ev3g@mail.gmail.com>
 <CAJfZ7=mz0=QT_OdZHg_eZwOqS=7KZPBB1q=16Qsav7gZSoV97A@mail.gmail.com>
In-Reply-To: <CAJfZ7=mz0=QT_OdZHg_eZwOqS=7KZPBB1q=16Qsav7gZSoV97A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 26 Apr 2020 16:54:35 -0400
Message-ID: <CAHC9VhTBk0SEA9t-B6_Hkg70NqEt-L=6MN9oEb44gxbO=xZYNA@mail.gmail.com>
Subject: Re: [PATCH v2] Convert README to README.md
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 26, 2020 at 9:02 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Apr 23, 2020 at 9:29 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Apr 23, 2020 at 2:55 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > It should make the document readable for github users.
> > >
> > > Fixes: https://github.com/SELinuxProject/selinux/issues/225
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > ---
> > >
> > > - Fixed indentation in yum command
> > >
> > >  README    | 25 -------------------------
> > >  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 41 insertions(+), 25 deletions(-)
> > >  delete mode 100644 README
> > >  create mode 100644 README.md
> >
> > Thanks Petr.  For whatever it's worth, here is my ACK.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> Thanks :) I will improve the README a little bit more (adding a
> Travis-CI badge, listing Debian build dependencies, adding
> "install-rubywrap"...) and send a patch to be applied on top of this
> one.

I think those all sound like good improvements.  Thanks guys.

-- 
paul moore
www.paul-moore.com
