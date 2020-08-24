Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F8C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0419D2074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PuPOlDaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgHXNHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHXNHt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:07:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5266C061575
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:07:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b2so7975457edw.5
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++wVUAAL3FCIdU3Q7RBNPjfei0JC7QKDqs3d4gqLkD8=;
        b=PuPOlDaS3kto3atocjIDkePSCIXXIRpoKpPyuqY5As+lkPNxkYEIQAP9a/Nn2cf/ec
         zaFf5NNaSgVhzUZzGa4jT0EjXhrn3xTBWwhYneS2DFlEwstp+iof/WuOGObTgk2w8lW+
         cljb0Y9Qi3MmisyXxw2zwe8hcu0J00jevDGQsZ5Vec6b3SmGNOhiu0mujwKUpkoDGR87
         Sl5LHDc7XtsFWO/JUWqiA0gGgJ3A7tljnA1y0ltBpKiAg22PHAD56l8cejbAXvw9RAOK
         dwRkIuhsCAcYD0Rjth+QWS9fNGlDwFJlPb3RtgULuRw46wLEZ5oJELovinbtoaNvIcT4
         xZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++wVUAAL3FCIdU3Q7RBNPjfei0JC7QKDqs3d4gqLkD8=;
        b=taaW+jlUeWVsHCcYQ7jLWjOtkCNj4mmVvFDcu3SPXsZEoPTvEg+Ge9RfFECxiMmINL
         3aCQeJJwK+e5Yg6E/dnkhKZrgLKr/TRDKNmz/IZy0aE54usEYkLpK4B4raOniAnm96Ti
         Pb/adOzGilnbTspl5WtkZ/Iv8gP4TJs1e4PyI9pgXLws4J/fvO7EjUQ7rmpn71wH7U2w
         WrENmNCarZQm1xLgMpe5jRnTYj3OUOlbcx6c4a9XTt+UrJirENyA9fqgHwHOUbltjLiL
         dcmzCO7/Vq2Cq1UqCX8e8SUAuquHrhG2vnXMsufWqDuf4RtL43w2NnVKgGHyYC1kLsDI
         o9Fg==
X-Gm-Message-State: AOAM533K5UPpewAv79pqb/4+VodXFUDdMIvrv5JNe/Z/jn0iqiSk0hme
        bf1TbeK7krYd9YmQE56z/vKc6IKGOSswsd/33wHH
X-Google-Smtp-Source: ABdhPJwvkn1F/xNYp0KGduUPe7dAvQCo8OrTtHv27xZTH9XHSiNh4240+VtyTkIu/D5pi9/aoxporbUNR2gCrGL2wZ4=
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr2684340edt.128.1598274467311;
 Mon, 24 Aug 2020 06:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200807165134.3913-1-rdunlap@infradead.org> <CAHC9VhQW-8pem59QHQctx9UNhMNLEAjNwDiOU1ODz9wX5B_tdQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQW-8pem59QHQctx9UNhMNLEAjNwDiOU1ODz9wX5B_tdQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:07:36 -0400
Message-ID: <CAHC9VhT4EG3qs76=nfQ7sLW9t9V-jXymmczV9Ygq+9T+Qz4Pfg@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: delete repeated words in comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 2:09 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Aug 7, 2020 at 12:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Drop a repeated word in comments.
> > {open, is, then}
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: selinux@vger.kernel.org
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  security/selinux/hooks.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This obviously looks fine, but it will need to wait until after the
> merge window closes.  I'll send another reply once it is merged.

Hi Randy, this got buried a bit due to vacations and other patches but
I just merged it into selinux/next.  Thanks for your patience.

-- 
paul moore
www.paul-moore.com
