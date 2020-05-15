Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374DC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9E20709
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhUiIv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOUUb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOUUb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 16:20:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D847C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:20:31 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x21so2231415otp.13
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwrQPA2egR6mNtwuPN7rvAZumbPL2I4DdivudoCm280=;
        b=lqhUiIv8OcplOqTcuJrEq2mmlQh7KnE/ArhtgM1NlczZbSt0zdFjmtc9dG2GEUMSq6
         qkMdDKNvAcJ5AftDR1gYG/y37uBPkED1df0zEAXX8Yxkc93wqGqHFFhJmz+oBXydgK3v
         uz0zoIiLqmDi2zOKLNuyLkH4vGT98zyiQUYCdLw2koEYwNvoggTRnZ9I41oIgwXi0i3G
         27UDWxW509fdp0kGz50XL6YkoQ5vs8TSJ00mTEDzJ47TltOwwn00wyc8PG4iG8JWZB2R
         xr7C5hOvt9n/RweDMwU3Hb2F24l/SL+Q2/LUIpRSi1E0b9u0siW2SnrLOhpnEDjV9oDM
         T+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwrQPA2egR6mNtwuPN7rvAZumbPL2I4DdivudoCm280=;
        b=IwGxhlYpjj5REsk9qYkZRtaBn2SafsM68aWL69czVI4m1uU6nRHoIft2Z8bOZFEY1W
         JzN2JX2skVQm5qL88FnDTqASm9+z3UOIXakadwwc2Wy/gadEVgxtr283+NQzkOfgvhqw
         QtlXlThEXoIz5x7jJBMvGpJMKNrgJZnnYb7kceqiIIjYHie6W1tRqY+WBfgOO0kdpVni
         OoVO04ZDHiiASFySUxr8tMfWv9qM9KBWXZ2Fbi/T/JnRuBBI2I3P2NXNVYHg6WFD2EgS
         GDCQgR34h88wNoTe+8h73Uve+lUQH8gvIe98ujR34YAq2g1TeRgevg4P5646tLILhj4v
         MpHg==
X-Gm-Message-State: AOAM532mqXrhP/cJCEnrMaZ4Gm7RKfnnKNdEBq3ZnPvlS3ED5jV72Gkx
        CaR5DGPRB2tkh21NLYaZUYdJ8RwTwWI3IHq1rRrJ6qFq
X-Google-Smtp-Source: ABdhPJyY4fJIMcEgy+MSp4V3aVdja7fd6IZ2om77PCmgUnplyV2imAqcTlngCw4F9FF25Lj2LpQ/YY2AhTqX1nbzf0c=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr3692810ota.162.1589574030252;
 Fri, 15 May 2020 13:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
In-Reply-To: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 15 May 2020 16:20:19 -0400
Message-ID: <CAEjxPJ7FQyme=udYKRJ9_gSmaF0Jz_4kk2SSo7S0HkMELg0D3g@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 4:02 PM Peter Whittaker <pww@edgekeep.com> wrote:
>
> Folks, with whom I can verify whether there are errors on the SELinux
> Project Wiki?

As noted on the front page, selinuxproject.org isn't being updated and
is just historical at this point.  Anything new should go into the
GitHub SELinuxProject wiki(s) instead.

> Details: It looks like MCS information is missing from a few security
> contexts on https://selinuxproject.org/page/NB_SQL_9.3

I think that particular page was derived from the SELinux Notebook,
which was written by Richard Haines.
Not sure if he is still updating it but he frequents the list.

> The schema row has
>
>    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s10'
>
> which should likely be
>
>    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s0:c10'

Those are two different contexts, both valid (if using MLS policy).
Under MLS policy, there are multiple sensitivity levels (s0, s1, ...).
The category set is optional and can be omitted if empty.

> Likewise, the database row has
>
>     context = 'unconfined_u:object_r:postgresql_db_t:s0'
>
> but I'm unsure whether this should be as is or whether it should also
> have MCS info.

That's also a valid context.

> With whom can I verify this? (Not using PostgreSQL, just noticing
> errors as I crawl through my hardcopy of the handbook.)
