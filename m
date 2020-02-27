Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07928C3F2C1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5049246A1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM5bgjHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgB0VTC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:19:02 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:41326 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgB0VTC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:19:02 -0500
Received: by mail-io1-f43.google.com with SMTP id m25so1068328ioo.8
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEl97KEKPtEOtkmNGDeJzEqluqeHlfFoKfFeFAco7dI=;
        b=GM5bgjHxCjN5ZTWkj0bBJ1GVZ0GbOQupJivXxnLjoplqF69/DZpzFiIPqxFq9kLSpn
         u0gO690GYUgSLcSn/IL3dsGcRli+uiAM/wkTfwck6rdg+tTM63998oYxDT9dmL+7qe+y
         ZZiYAZIfNbewY2Sy+9AAu0yCqdaseWa0i+C5e7eQQkNfug0NgF6TYkejBW0y3i+r+Yzc
         xvC69Z+l3r2zJ3Fc+zIhYn2zz6hdcT0vn5aoN0Suu4UXNhst7fyGP1EZHy21LMd87+A7
         sCbyF6iUXe8t7JalXSt8n1+ZT9jJdBjgAe7/crFefg/l/KDcP8nzxmB/ubYzGHZJmq5W
         lzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEl97KEKPtEOtkmNGDeJzEqluqeHlfFoKfFeFAco7dI=;
        b=nPq5HgJ9plvIGxXbUfhlapBQcc9v62j2iVigzf4ViRCH+HcO/qqjNgGDO6gCmfhys+
         vRAAfDAE7iw47xtlc5f2eoEKP8kYY0JBKqkvBN8R6OMRvgKTBhXm11/D4am/F0KEhD9w
         fKDLqRuzuzXu8Fdv8xy3R3mV5oXTOezeew5hV7jsSh5/7U38kCy5WZODmn5Ztg9Q8vaX
         LQIkHNu+UH84GfB3Nst6VlHqkFeHZA9iGTivU3jhDBbZXkk+wUz4joKN+dQP+OQaIrvO
         nqAvnixBh43THJKEY/5T6fenJ/GzHNt71ysd2LZOhCSuYeBm4lH0a4CvntnyBwtDn+GM
         iS3Q==
X-Gm-Message-State: APjAAAU2/+viixuMH4qnKwUcOY8NwbTUDsTvgL76WpmeQqfNTnI4ilrH
        QRqJOSLBPA9naEoGEV0YxNqJHeCExYHrLZttXz4=
X-Google-Smtp-Source: APXvYqz5ug3LnG3KLRP7Mj7cgS87UPPvdHrO85yRDY7yznzrdRhnz33d4Isfz2IQJ/vIm47SnesEvY1O5Hx/UG1Qfe4=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr971200ior.129.1582838341491;
 Thu, 27 Feb 2020 13:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
 <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com> <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
 <CAEjxPJ7=WO0CO3Wj=KLMzH56Fg=WMbjjJHN+qAh+e30juKdVgw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=WO0CO3Wj=KLMzH56Fg=WMbjjJHN+qAh+e30juKdVgw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 15:18:49 -0600
Message-ID: <CAFftDdpx7UsNqgSUwZsQBnTGHUTrOkT5d7n-rGCn1djTVTjvFQ@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 3:11 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 4:05 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 2:43 PM Ulrich Drepper <drepper@redhat.com> wrote:
> > > The use of the hidden infrastructure is not just a means to reduce
> > > overhead in the form of PLTs.  It also ensures that internals for the
> > > library don't leak out.
> >
> > Linker script? We just use a map file that has everything local except for what
> > we want to export.
>
> That just controls what is exported.  The hidden_proto/hidden_def
> stuff is to ensure that when libselinux calls one of its own exported
> symbols, that symbol resolves to the actual libselinux implementation
> and not something provided by some other DSO earlier in the search
> path, which is otherwise possible.

Sure, but do we actually care about that?

If we actually do care, we could throw a script in the build to make sure
anything in the linker script map is not used internally.

Right now, all this DSO hygiene and look up protection is opt-in, which
usually always results in missed cases. With the linker script, it's opt-out,
which is usually always how you want to do things.
