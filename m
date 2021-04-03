Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BBC433B4
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F996124B
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 16:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDCQJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Apr 2021 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhDCQJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Apr 2021 12:09:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A8FC0613E6
        for <selinux@vger.kernel.org>; Sat,  3 Apr 2021 09:09:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dm8so8294053edb.2
        for <selinux@vger.kernel.org>; Sat, 03 Apr 2021 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhg8iWx5EuotOjw+AANL2MrLOvNjMkZMWFCX/mESM94=;
        b=bRDZvs0WFj2Jlcf87Tfbcs5eBBHthxIPo0dCekCLmbudPTW5c08px+SYIikz7YwWWr
         z/p28H+lSWwRrD1k3LKXLeXzB1Fa8qjgvtBecaJRXIa5QTi/pxI9Rl6iBGx5dBt312Kd
         pfhp5vpPIQ/z/K1DkC0lYBhUO/7O60yZ9Tc23+PpucKCb/AA6KDfHRZHyao1qDJfTGjb
         n38WrtiQUT9qfJbYB3jaw/zbrPI1w9rNaYvrpKWy7C2yaLs5n7NGqZjEajUhNNrWKXyl
         VskXMJONNkhO7XR+5xTvgwUNOY///DQYhXJD3mbNzgawxXlr5IshFWGX+WQFQWlocH5t
         /pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhg8iWx5EuotOjw+AANL2MrLOvNjMkZMWFCX/mESM94=;
        b=jv9gG5dyLd1YihQMYF03g+ZQzsYbGhzaCjdyK2RgeT0fKP3ZOJo0MixS84yr01wW0f
         5AnMLVFCryAlRrKFF6FJFtggF2wktRcY3N1lUTu9Qh8R3Cz6DWywNT2MZ0OUjiOleIMd
         6sYdQ8NQZZZrWPfv+PrhdC1L4/WIwmcohSSvTa8TBY/YD7blnT1Ku0KbrC9qid6hCyI5
         J636pKduFv2RCLSsx0AXg/xhfEix0mr5jrGfq6Zi1oVUOSYBHvl3TA32qUS6sCdwemLC
         MuvwxePqoi3fm+9UqbD4pUnaDElaDJ5HkfVp3JZlP7Gt1HhXInITYnFyt36Gf/f1LC5b
         LjgQ==
X-Gm-Message-State: AOAM532MmJI5X79vRldB+beoMxVgcK7YJK0sVsKsbgrl97DOxUSMYFEB
        brEhLIrP2kyBbkayN+Y0j3RKQ5jvnUiCha/A8UJY
X-Google-Smtp-Source: ABdhPJztif72esYry9x6VAvneWY6Abw6duPiwCZaBpJwYYzDZUFG56Mh0IKvIQdBoF7HmmMtfknlT4yuoB2EXtzFn1Q=
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr21872755edu.164.1617466159221;
 Sat, 03 Apr 2021 09:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
 <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com> <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
In-Reply-To: <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 3 Apr 2021 12:09:08 -0400
Message-ID: <CAHC9VhSfOfJ2kN3yqJBWzwT4=FhmSfoOQLd9MYSu7GYdE3C8hQ@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 3, 2021 at 11:21 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Apr 3, 2021 at 4:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
> > <vijayb@linux.microsoft.com> wrote:
> > >
> > > Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
> > >
> > > https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
> > >
> > > Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.
> >
> > I'm guessing this may be the problem that Tyler reported earlier and
> > which appeared to be fixed by the patch below:
> >
> > https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com
>
> Nope, if that's really 5.4.83 with no extra backports, then it can't
> be this issue as it has been introduced only in v5.10.

Of course, good catch.

-- 
paul moore
www.paul-moore.com
