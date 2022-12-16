Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD32DC4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 22:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLPWCS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLPWCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 17:02:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A082B216
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:02:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kw15so9199462ejc.10
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8leB9I7hBz65pppNf1flr9edX0R53jdFrpe6y02PHWc=;
        b=Sl35ilJ5ztjJyaP9CMwXx9V8XQEqyKZw+NNkmwXP/0fcO+C1bI0VUeS9coQgSvnXxL
         JUXlX6ZiNeEd8nDOK8hpDt+4y1Zh1UCAOUNC0yVTtSHWMvHwx1/fCkoX10yi8Pm2iUMx
         1H3RVkUd7luFeEzXDC0NvuC9s78BSRazzXXqyRa/RScd6jHj4cIB9XsxqrEcN1lc/rJK
         bAkRvXzqDg4LTkxEmAvcighjDfWIoDtnCPELv3kl/4p8/azoR6zmk2RdgJjPHX0IrPpo
         jqSOB8kXTgC19ETJJJCSIG+1rVLOCziHvJJpX+AXISTQKv6BMLoh5w7zVP6Rk8sgR4Pw
         WVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8leB9I7hBz65pppNf1flr9edX0R53jdFrpe6y02PHWc=;
        b=hCKsOOuDS/fCRhTLa8asQ9qKGlgODiFgCnNZJ/EoYZPxR5JQDQ+4sLPPcJe8WMJo2D
         a8pEgCoQyOhaJ/cpOkvEIqtQ59EsBr2EynT3RXESeZ3DWOljH7QfMmFMbk+dmNOsDYaj
         dfIRSxw6Ceg2rhXyfgogg8iLeWgNh5xjQfBajRefjcmNHg/WLs9JVdH8mBNdWXAYIx4x
         vf9Visql5UFTv8jyc+/N6TceQotX3d7gbFZROG25eM9Y21KXLf/WOgaSusmh83ad6kzC
         EGarsBq8tOt1V5X2NxLag8eUTY06bZyfLNccwW0WX0apINyguJsir41P8GKbL81ZwKdN
         BLEw==
X-Gm-Message-State: ANoB5plddqCeFUtM4jURZre8ZBBwBZnZYHNuwRUAQF8ngsaGGWg6NLpl
        oyPTA5SfP+Ytdbk7+ttKO+/+o6iulBj2NJ2Le6UbLVZ3
X-Google-Smtp-Source: AA0mqf6ygiCHa7FxzzWrntQXpro3s0V4w/X+lUOyo5ZxSagiTj4i2JC8jB8H1X94eqb2B/ZuHNJdPYzkBTGvHmUmTSY=
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id
 e10-20020a1709061e8a00b007b2b992694dmr75562631ejj.651.1671228135273; Fri, 16
 Dec 2022 14:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20221212174349.714152-1-lautrbach@redhat.com> <CAP+JOzRd2wei9QLPZU1Kzc9qJzb1NU1EwJ6FQt_iOUfKv2h2sA@mail.gmail.com>
In-Reply-To: <CAP+JOzRd2wei9QLPZU1Kzc9qJzb1NU1EwJ6FQt_iOUfKv2h2sA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 17:02:04 -0500
Message-ID: <CAP+JOzQwqjjeT3QcYzccp4NNXH6AYEF1QSbX03XhYB0G9LzHkQ@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: Call os.makedirs() with exist_ok=True
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 4:24 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 12, 2022 at 12:49 PM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Since commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> > man pages are generated in parallel and there's a race between
> > os.path.exists() and os.makedirs().
> >
> > The check os.path.exists() is not necessary when os.makedirs() is called
> > with exist_ok=True.
> >
> > Fixes:
> > /usr/bin/sepolicy manpage -a -p /__w/usr/share/man/man8/ -w -r /__w/
> > FileExistsError: [Errno 17] File exists: '/__w/usr/share/man/man8/'
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  python/sepolicy/sepolicy/manpage.py | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> > index edeb3b77e759..1bff8f9acb49 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -376,8 +376,7 @@ class ManPage:
> >
> >          self.fcdict = sepolicy.get_fcdict(self.fcpath)
> >
> > -        if not os.path.exists(path):
> > -            os.makedirs(path)
> > +        os.makedirs(path, exist_ok=True)
> >
> >          self.path = path
> >
> > --
> > 2.38.1
> >
