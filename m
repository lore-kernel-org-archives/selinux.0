Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE1C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D320872
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUJ/oeZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCSQvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:51:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39078 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfCSQvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 12:51:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so12278059qke.6
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BbOXYfE6r8FX4v1JB0yCYZduhiaDW6dHP7LU5+ZJNM=;
        b=jUJ/oeZOWAkPKdR2y0apbEsFzNThTPJRmgUSbmsQWcXWxL+T+IZI+KRrczNMmfRVc/
         bcl5nmuJOx0sPLv/gzewlHUu08tA42Z7hFEfR/Z0Cc1WFDLb4redKrKtXu90oW9k9RzT
         JudMd2ap48ruOIFvCHS+9FGUiz+j/OerKGwxEbivOoV4hTQO3chi4+dwJDqmMibpF0C4
         s8pBH04zqoYNPTxVufp5cglb6HLWxjQGqo9PsDWHnh09QdB+3OTV4hHFBygNmkQDR+CS
         hJ9tcBYHHp59+fiHA4MzNHxVUUQWRVF729j0A1GXjZ3plElv6XQNwIGL56Rfj9AXD61n
         Boqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BbOXYfE6r8FX4v1JB0yCYZduhiaDW6dHP7LU5+ZJNM=;
        b=mYoN4Ey9TzOIPxNWRAvjMqFkKqxaR94FZU7max7HCucOEDSnrwKLOUrd+0VXOP3O+a
         rhRUAMYiBGlRKiHwxyKcBpr0wqY+YEVXHouepe0u4Q/aXClh18Z8mZSy/YEpgWbLIEN0
         keiP1BmjythmISks4aJJLiDDYkcmLgoJej53Rj73I9leu72cmE5mLERWooeVZkJ3qFMp
         pPiOt5gYVRf3huQcSAlA9x0e75/EtKjCIHImB92y3ESZOSMUPZmMXWr32rICX5irRrc0
         UjZkoCHwcea6t9oRUy8h34/QQQN9CGCCKxqsY4GPREfOq1qYalmzZH1FB1TuJ51OJ3HZ
         kM2A==
X-Gm-Message-State: APjAAAUj9itR78JDrzpRthHZAs8tuoyKzmUwbI/82O8jvD5KvRsM6QXu
        WA/jcuNk0VOmAHCqgA2z3SRU3yNUOxbyfDvQ8DG/fzlIhJU=
X-Google-Smtp-Source: APXvYqxwQi6JKGFV3tyH3RRmUhlDKLTJJAsCwnOKh9coLqU7lyWS7GfEv/3Pah2S/QK2wlJ6PvrS+0Ro9eXf1iB3An4=
X-Received: by 2002:a37:5dc7:: with SMTP id r190mr2715249qkb.170.1553014259273;
 Tue, 19 Mar 2019 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com> <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Mar 2019 09:50:47 -0700
Message-ID: <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul,

I think this patch will fix it... can you run the selinux-testsuite
with the patch to verify? (the conditional assumed that size_t can go
negative)

Thanks,

-Todd


diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9a7c431469b3..bb9a661ffecc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2240,7 +2240,8 @@ static size_t binder_get_object(struct binder_proc *proc,
        size_t object_size = 0;

        read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-       if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
+       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+                       !IS_ALIGNED(offset, sizeof(u32)))
                return 0;
        binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
                                      offset, read_size);

On Mon, Mar 18, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> > On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Hello all.
> > >
> > > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > > below).  I'm hoping this is a known issue with a fix already in the
> > > works?
> >
> >
> > Sadly, this is the first report of this, so no fix in flight. I'll try
> > to get a fix up in the next few days.
>
> No problem, thanks for letting me know.  If you need some testing
> help, let me know.
>
> --
> paul moore
> www.paul-moore.com
