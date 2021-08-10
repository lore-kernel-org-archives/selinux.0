Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C33C4338F
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F284B60F02
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhHJQb7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhHJQb5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 12:31:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FF4C0613C1
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 09:31:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o185so29584687oih.13
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74vrRhncnm2hwzeGv/KKKkU7dOQo/A7en8+g6Kwwogk=;
        b=J5V/l5uvcyxYvrepUrwShrrc6Sp2P4nj4Mc2dlASAHth/YbTkxiMGvR/XKFL/0VVV0
         cZVVjfDSYoKVCKMDFzeo8RlUY5ggaOhDKxv/i+rF6hHXLBjA1I0yOGaZDc2eJS3NRTDX
         Oofr/5S5ilwQLtqpCPqb74gEk0OepndFZD8MDI9RXNXHBjpV6NhrryHXbKQGdP/7QKwQ
         JFVRdjpHPMG94SyeGT1IkYRj1EkjvSqhgL7ykniP4MSfaQ/hQPtpaQV+84kFgOVIcutc
         0UTyeO6mkc6oS8NHbvzCTcjl7TrnXS+B3IbR+yTfFqXKZwCc0qxuM2HeZrPBTDuwCIQ3
         3RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74vrRhncnm2hwzeGv/KKKkU7dOQo/A7en8+g6Kwwogk=;
        b=M+zq/1/95ThSn4r4Sa8Jr8+Vn80m/PGG8W9/oqTnW4ItaacXPSLCgupDozfs7piAIp
         6lnSf8TatG7CxzZIY4KNQyYq4pdmZn+6k18bp9TYDZWh3eR76EzwecB2ujHBMNqsIQtY
         Njk0KrBjTP/Y/QU1sowBL9VwzV+1Q7SYOgM2grhAE3JK2QKFIknsgerUeaHFVbB3tI93
         DG4jUwokjeX1uqi+Efq8rj0gep56mN5Lg8puIY+vgwmP4XR71jFUI/yAHTQwvsA79rtc
         urr3vlEXAXfvdQiQO+1Q3/ebJPoB5KzENw61aE/fjYr5DeSvTlWvnrkGENbpTAbqbr/N
         4ABw==
X-Gm-Message-State: AOAM531r8a/K79WVTkvYKGKEx5tPCIQMyfUCTvEE0tLcgO+ev1sbE/3N
        lE4vZHMkA7/fZo1822Knw0EUpmJHxH64p572vYU=
X-Google-Smtp-Source: ABdhPJznXEeeIepERhMWQuK+s/xy+TppTPuumJHi3y9VGA3I1qAxHfgJ+9k9kX3IM+BnA6auLvvc7CWnEufNmobr968=
X-Received: by 2002:a05:6808:13c7:: with SMTP id d7mr4229081oiw.138.1628613095017;
 Tue, 10 Aug 2021 09:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210805084550.810783-1-omosnace@redhat.com> <CAP+JOzS902PUNYq-5HG_-oNEZGnr+rA3TBVHFQnP-+c2XHYYHg@mail.gmail.com>
In-Reply-To: <CAP+JOzS902PUNYq-5HG_-oNEZGnr+rA3TBVHFQnP-+c2XHYYHg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Aug 2021 12:31:24 -0400
Message-ID: <CAP+JOzSCu_9SGLUEEL8ut4UAe8c3f0i0URfmWvEZByS1u8ka+A@mail.gmail.com>
Subject: Re: [PATCH userspace] libsepol/cil: remove obsolete comment
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 5, 2021 at 10:01 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Aug 5, 2021 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Commit a60343cabfc2 ("libsepol/cil: remove unnecessary hash tables")
> > removed FILENAME_TRANS_TABLE_SIZE macro that this comment was referring
> > to. Remove the comment as well to avoid confusion.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index 41105c12..2b65c622 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -55,9 +55,6 @@
> >  #include "cil_find.h"
> >  #include "cil_build_ast.h"
> >
> > -/* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
> > - * size of a hashtable. The next power of 2 of this is 2 ** 16.
> > - */
> >  #define ROLE_TRANS_TABLE_SIZE (1 << 10)
> >  #define AVRULEX_TABLE_SIZE (1 <<  10)
> >  #define PERMS_PER_CLASS 32
> > --
> > 2.31.1
> >
