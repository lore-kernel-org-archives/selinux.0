Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7767C54EBC
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjAKPwP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjAKPvu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:51:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73B1D4
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:51:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j16so22922059edw.11
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPJzi2CBgI85Y02NmiGC5ooh0N3AxQFIZseC3SNRPt4=;
        b=Mo5djqoJJ/FnA0fV3IazapCi6/7jU0eT+IN46G+B/jEfUR89qwGHkLbVoq/nikk2Gh
         s15qkMFdJLq7GMPR5gvlhDPHYTPwnopx1Gr8mmN0vwh1yWYJSHQCtrnh7A8d+yVkn4IA
         AXwiJ+aAAoyKX0mQJPqVbh0tFBfxlhS8O190dvt0t+sSF/tLEdVLBYgYDXwGg7DwmvsB
         PbWYgIc0e3TTGtuVJR50tYJsTAUVuHBKz0rMnyNQ+r39qBdu4YJ8gf9DVnCdNWUqCtyj
         q3VixvMZEhcfpi02UySwGUMKRDMAFctLqqpXIpluxrfI4tFYvdGlLA43b1uSARPIY89Z
         V89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPJzi2CBgI85Y02NmiGC5ooh0N3AxQFIZseC3SNRPt4=;
        b=e+50x5dgoARE/eUlMAB4JwDUMqc9ABdb3jSP3z56r8jau8FUTLhA+7vBt4P7Ncm++v
         yNkC7KqWA5vY2TaCw5tV4ODUBdwZNnnNb+6AE0rQ9jr9I2hH93Fd04DOuHK/JGkh7nN+
         cTBptL8r7pJF9vv7Lq7Pn8Wg9j1kdopBVUHyjeqx/PHbi5BCDpn1QbZOcYggP0mIl/UZ
         6aheppjh3Wo3tzfMmeBIvSptg5IFV57AUDW8pBkS7F5UxzYQq0AFCetw+KZrRq0l/Tme
         7bFcy2eG8KH7iwQ5yM2a8fRZ3T0CKvnJMYn4Uc6gjsVQ6atXcFUCXV37I0vakFfwAGRw
         IE5Q==
X-Gm-Message-State: AFqh2krKyzZM34HncQ1R+h2yLHQyr6Z3xFZ4Tjn4VS3IerFBG44z3Ele
        Zg0xtuFBUHUdzptqTQAWwqBsfrvlluyvDTCg3fk=
X-Google-Smtp-Source: AMrXdXtnnkW0TlPREPy0BDnhhTXDnHlx5nUTSxIosJjJc9LUoK9IYCymYa6G/jQ97EIlO1E1Y3lxsar/HGdCXVE/dn8=
X-Received: by 2002:aa7:d645:0:b0:47d:868e:3a0e with SMTP id
 v5-20020aa7d645000000b0047d868e3a0emr9111918edr.36.1673452307612; Wed, 11 Jan
 2023 07:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20221205093644.703107-1-lujie54@huawei.com> <20221205093644.703107-3-lujie54@huawei.com>
 <CAP+JOzSEFRrejgab331mG8dFgv2YwR=WYjC7Qv42XMkoOnDw9g@mail.gmail.com>
In-Reply-To: <CAP+JOzSEFRrejgab331mG8dFgv2YwR=WYjC7Qv42XMkoOnDw9g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:51:36 -0500
Message-ID: <CAP+JOzQyVh+VdG=HJHrW=9e5_+poJyi4x9Va6Qo3yj-UQV6yyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] policycoreutils: fix potential NULL reference in load_checks
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 11:07 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 7:13 AM Jie Lu <lujie54@huawei.com> wrote:
> >
> > In load_checks(), add return check for malloc() to avoid NULL reference.
> >
> > Signed-off-by: Jie Lu <lujie54@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

This patch, but not the other two, has been merged.
Thanks,
Jim

>
> > ---
> >  policycoreutils/sestatus/sestatus.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> > index 7dcc9944..6c95828e 100644
> > --- a/policycoreutils/sestatus/sestatus.c
> > +++ b/policycoreutils/sestatus/sestatus.c
> > @@ -140,6 +140,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
> >                                         pc[*npc] =
> >                                             (char *)malloc((buf_len) *
> >                                                            sizeof(char));
> > +                                       if (!pc[*npc])
> > +                                               break;
> >                                         memcpy(pc[*npc], bufp, buf_len);
> >                                         (*npc)++;
> >                                         bufp = NULL;
> > @@ -150,6 +152,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
> >                                         fc[*nfc] =
> >                                             (char *)malloc((buf_len) *
> >                                                            sizeof(char));
> > +                                       if (!fc[*nfc])
> > +                                               break;
> >                                         memcpy(fc[*nfc], bufp, buf_len);
> >                                         (*nfc)++;
> >                                         bufp = NULL;
> > --
> > 2.27.0
> >
