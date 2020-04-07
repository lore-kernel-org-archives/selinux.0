Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01B7C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF120730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNFqQ/Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGUrQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:47:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42554 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGUrQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 16:47:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id z5so4597054oth.9
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/fRYZ7+K6ZvXdIVa0LXCLUTgtwNnyNp2mF/iJtekOY=;
        b=lNFqQ/Fc4GYvq2/sKimd/KbI8Wz6ukiEAZawPTSxVJDeZmKkDjWPswk3c0T9BLJHLF
         DVzPMbg/IRZGbLp2Cr82eJralRd16t3pRXacEWVXp8FnjtjYdxWWXzDNW3+tFv7ViXv3
         GnSXB06WQVUBdiZNVuK/JPH/WBoi9M2EHy79VF2pZDcuXu6wfMY7+XulwBMYaVKp4sua
         oFVCZ0Um1JhOuFpdgG0230+3nrB0YC7FNpshWPJy63inIHmc1qXy9kNIcXzyLN+j93kG
         dIGYOJ+SfWAhW01ey/GSyv0++soGBfY01BV5aAynfSuFseNEpHXXBPtnI/txmI545w1N
         qmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/fRYZ7+K6ZvXdIVa0LXCLUTgtwNnyNp2mF/iJtekOY=;
        b=RSyo34w8JAY520HMtpasjFvdpmGu/PeGS7SoeCw5aApnaZVflhKSouJUimS+MB2Hl1
         3ZYhl+mvKMSYIST7oBvVw75mK/RjbsKzpfeNquC8iZWniZRAhhuuqyZJQGWSo6jxEilO
         WWPvTlC17y1f1ejJ8gXbX+C5lcqIHYoltwYszi6ohGp1fWc/glLCG7gOHvjxsD8MTU/h
         sHCjl4g5UObUiFGYGyQrUQAox4OzhFWoWZcLpHie6Up+OXXZ4Inp/jBTR0Nvv6pNVwbq
         /AxPil6xBqFIDsP/46Qpj8YbAG/PezFOgTH7/Ndy+M0RttvR4ELIPuZddaLOAaW7OAub
         CNBw==
X-Gm-Message-State: AGi0PuZgEKEoKpvhvXQ5fGgerEuIl0MESwurwR/fHGoQ9f/hpaMZ9W1n
        g/eBK3hcXaUJ7ddMSvJG32+QHYLz/FYk2zSrZJ8=
X-Google-Smtp-Source: APiQypJrEiKyRqvB0TwZXZ0F0idc4j1tZZ9AnT00SvIzNSYLiSwCtElDf/Ugyu/ahV552YWqfgkeZk0ZVg5MtKdD0X8=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr3172061otc.236.1586292434088;
 Tue, 07 Apr 2020 13:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184239.2700998-1-aduskett@gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
From:   Adam Duskett <aduskett@gmail.com>
Date:   Tue, 7 Apr 2020 13:47:03 -0700
Message-ID: <CAFSsvmpmhuRD2gWj8ZaRkmZ42DoUM0evfb4tfJTgm8yu=qf2Jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fix building against musl and uClibc libc libraries.
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I did that just now!

On Tue, Apr 7, 2020 at 1:27 PM Roberts, William C
<william.c.roberts@intel.com> wrote:
>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of aduskett@gmail.com
> > Sent: Tuesday, April 7, 2020 1:43 PM
> > To: selinux@vger.kernel.org
> > Cc: Adam Duskett <Aduskett@gmail.com>
> > Subject: [PATCH 1/1] fix building against musl and uClibc libc libraries.
> >
> > From: Adam Duskett <Aduskett@gmail.com>
> >
> > Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
> > or uClibc. However, this is missing from utils/Makefile, which causes linking to fail.
> >
> > Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
> > compiling against uClibc and musl.
> >
> > Signed-off-by: Adam Duskett <Aduskett@gmail.com>
> > ---
> >  libselinux/utils/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> > 36150638..a5632b7c 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -45,7 +45,7 @@ endif
> >
> >  override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS)
> > $(PCRE_CFLAGS)  override LDFLAGS += -L../src -override LDLIBS += -lselinux
> > +override LDLIBS += -lselinux $(FTS_LDLIBS)
> >  PCRE_LDLIBS ?= -lpcre
> >
> >  ifeq ($(ANDROID_HOST),y)
> > --
> > 2.25.1
>
> If you want me to use the PR you have open, force push your branch to update the commit
> message. Else I'll have to create a new-pr and close your old one.
>
> Your open PR is here:
> https://github.com/SELinuxProject/selinux/pull/193
>
> Something like:
> git pull --rebase origin master
> git push aduskett HEAD:fix-musl-and-uclibc-builds
>
> would be ideal.
>
> Acked-by: William Roberts <william.c.roberts@intel.com>
