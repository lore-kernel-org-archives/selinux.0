Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84433C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiBRSm3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiBRSm3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 13:42:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F447043
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 10:42:12 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j2so4021138oie.7
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnGTWt0LQpPutsv3EH2zuL+m+lz9+okvM65fV93mqGE=;
        b=qoeu+m4Y4EZi4o9MkBeS44bUjU9IXBEHu2IgIa+K0vCYs548h6pY9+Sq6wkVmSIFSP
         6td7XjzIyU9fnscyAABEod1ixCkrwULT+AbXEVOJi7aIjjdI/K/NzBdwPu9u8DU1RHjQ
         lgMkf/9epWdumNpfyBBgoMRlVn9v49bLeph00NkBPkDHExltp+ShOjm8gXjZNspJovyt
         Hy84A/uSstrtVOrF9cXUYx6iutBfv5yatjYSR7SLFruMxlWGgj8z6CIHLlkJHo5C2JKO
         liWc3ybtMcH6cWBsn2RV2ubN+0oTvCP4k+n5EdPbbYHRep5LcS/GeB3MiL4LXfIFl6Aw
         IMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnGTWt0LQpPutsv3EH2zuL+m+lz9+okvM65fV93mqGE=;
        b=RRoJiE44L7Wv1pbyrAGrjpVAk9sjw2xN3HqS682HHsaBO6EsCxn5ZLgMDsIVBkYEgv
         lFE8EYDZ4NcqpVQELwCoQelFufICI0k5mV4XUKL4NBnMhviWPvwt68SEfuqLRnk1aWht
         n3QqZcdpBxwk3d7uoKTo/wr7GAeVZa8x8OkcJikEsvv1zGWcmnFDxMwyxi2+X9bEsh+N
         HeEC8HJozB1+KrZWpKQLCZBZt1soq4mWDaa/1hQpe0r2PjyX/eQeUVhShIg/IdL6IDUm
         UX6FySBh2wY1ImMZCkiAGLt0tOc0hXHKvVeOmn54fyg4zMXCpd7b1VkNzsArWRFJA8PT
         +Faw==
X-Gm-Message-State: AOAM532K5J0lYT8kK9/PVY0FHXbhe3y4Yc2oLeBdPNJDOQrybonU1c/Z
        tNGxofqJxDfLKXlsS/CSOielFrTclZYDxUqlulo=
X-Google-Smtp-Source: ABdhPJzW2YfsNzHNc76jt80EUjM12CFAHNm44snrXdOc9wWR1Qdfv71vThDQhOOwBuKpelqgg0fDKlxR+c624RUXf+s=
X-Received: by 2002:a05:6808:1642:b0:2d4:5a9a:c58b with SMTP id
 az2-20020a056808164200b002d45a9ac58bmr4038327oib.200.1645209731510; Fri, 18
 Feb 2022 10:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20220203165327.213601-1-omosnace@redhat.com> <20220203165327.213601-2-omosnace@redhat.com>
 <CAP+JOzSQA4+jjBboSmVOFKnc+r5m6TC3_rOrn=m1Tk_r0Bo7cA@mail.gmail.com>
In-Reply-To: <CAP+JOzSQA4+jjBboSmVOFKnc+r5m6TC3_rOrn=m1Tk_r0Bo7cA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 13:42:00 -0500
Message-ID: <CAP+JOzTxCQ7bB59HQadsW6Ubsbvegd91YdAD5hNVw31zpr0Wmw@mail.gmail.com>
Subject: Re: [PATCH userspace v2 1/6] libsemanage: add missing include to boolean_record.c
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 11, 2022 at 4:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Feb 4, 2022 at 3:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > It uses asprintf(3), but doesn't directly include <stdio.h> - fix it.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> For this series:
> Acked-by: James Carter <jwcart2@gmail.com>
>
This series has been merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/boolean_record.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
> > index 95f3a862..40dc6545 100644
> > --- a/libsemanage/src/boolean_record.c
> > +++ b/libsemanage/src/boolean_record.c
> > @@ -7,6 +7,9 @@
> >   */
> >
> >  #include <string.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> >  #include <sepol/boolean_record.h>
> >
> >  typedef sepol_bool_t semanage_bool_t;
> > @@ -20,7 +23,6 @@ typedef semanage_bool_key_t record_key_t;
> >  #include "boolean_internal.h"
> >  #include "handle.h"
> >  #include "database.h"
> > -#include <stdlib.h>
> >  #include <selinux/selinux.h>
> >
> >  /* Key */
> > --
> > 2.34.1
> >
