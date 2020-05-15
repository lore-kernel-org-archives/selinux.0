Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA37BC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D4520727
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QROuLZ/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOR4S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbgEOR4S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 13:56:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95DAC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:56:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 17so3442351ilj.3
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOHnJGvgb0lrTGuH3voOnBtzcLmzZoikRHR5ATqskRo=;
        b=QROuLZ/eccybc8I25UzTKTDhoImOMnqDp93rqGVNuouLL+1d2JaPGx2Dol0Tb6GEJ0
         Nn8LyAK2C0Oe6p2gCjEZfZ3FTCs4t8lmwgtFKL36v8Ybd12wmV6+0ALz/EpjxBOXx8jY
         CknNxS/wHKIlCcr5A9BQ9lbQBxlzALGeAPCTJhVSKbcPooEupnNG2q3kVNGKLDiDiH7W
         8faAISA8tmgnas6QJDzgqUlJvBGLD+dIKwsLLz+IHBm1UMj8KlagudlDnOSzCiJQAhjk
         yHPi63Q9Axp1841JnTJP1OSmKh5BEB/ggE8VY2fWgCCPM/VGqfTfVRSknb11Q86strbg
         fkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOHnJGvgb0lrTGuH3voOnBtzcLmzZoikRHR5ATqskRo=;
        b=uZhtwkUS6qYnhl6wXCq/TvfRISsbAiD+o7yEQHRa/hWoqx2E1UKzInTKNPsZBFxMbr
         p5vVWb5K08OB+Wvxyez605OIadS4mSkENFsL7CLZNb87OrUi8JE5VTnby9SWcGrFU39C
         7OYd/HFYi+12R1gMv43F75i3P7B4YjB4hn85sR9nteBVYbwIdjR5YV3Pf5HfUKWnp/BM
         mPBzRCmcX8/nLdc54JaXxOk1phWvXD+jsBk7Aiu+0+A9YBg/83fahFvPeb5tL8R+JGDr
         C0Cl9Dk+ZZbtfKCZVuacGNCbZw/0CAf8emS3hot+e7tCyNYFKuV0HxIYwJzQA46ZDr0V
         L8dQ==
X-Gm-Message-State: AOAM533KOnZz+B0skYFIHzZ2AXkUjcKzdqXjxXQVAnky8t/THKJ8z+Zf
        55AgnBOZcxRGJA66Z0WJUZ8WD+5oAqDpChAbuCc=
X-Google-Smtp-Source: ABdhPJzs5Trf//D7N8C262JZoyPL5QP8GJGM/i80SYtChum7tRJi5aQgFKWMW2OXrUyDko7HgIQs+7t4ozPtiEOYGNo=
X-Received: by 2002:a92:c704:: with SMTP id a4mr3198796ilp.163.1589565377113;
 Fri, 15 May 2020 10:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com> <CAHC9VhQ-MHqzRtJvLfCY7_PLtLE3Tjq6+AmKAZDs7NOx4XWXPg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-MHqzRtJvLfCY7_PLtLE3Tjq6+AmKAZDs7NOx4XWXPg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 12:56:06 -0500
Message-ID: <CAFftDdr-sPKkSrhBC5b30t1HnAapwG9w5pW71cwk-iUrSw3xmA@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     Paul Moore <paul@paul-moore.com>
Cc:     William Roberts <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 12:51 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, May 15, 2020 at 1:30 PM <william.c.roberts@intel.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The text above states that kernel-devel is needed, but it's missing from
> > the dnf command.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  README.md | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> It's not clear from the subject, diffstat, or your comments, but I'm
> assuming this is for selinux-testsuite, yes?

Yes, that is correct.

>
> > diff --git a/README.md b/README.md
> > index 1f7e5d92a100..a73e9cc0c06d 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -77,7 +77,8 @@ following command:
> >                 kernel-devel \
> >                 quota \
> >                 xfsprogs-devel \
> > -               libuuid-devel
> > +               libuuid-devel \
> > +               kernel-devel-$(uname -r)
> >
> >  #### Debian
> >
> > --
> > 2.17.1
> >
>
>
> --
> paul moore
> www.paul-moore.com
