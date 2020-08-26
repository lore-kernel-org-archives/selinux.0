Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DDDC433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BBE21741
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kOWQoU7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHZO3G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHZO3F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:29:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9768EC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:29:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so3100317ejt.13
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHkkfIoFF1qw+kwo2ruPxNnTiHN3WOfKe7UGzAyln1k=;
        b=kOWQoU7Ay4c1P1IT5S6AyQxG36RBYoigUqVBJs/fKeOUVipA5B5F5lCg1JFJuGd8vg
         wdkQYw8PFvDGNxt1H/dXwgJnmB1F6+qlfQDcnlEENwBMjYWq7rbI7UDi7v+oSz3uIYze
         NcyTRND3lKidIgD+JsyqNPo/a2m4q6LofANzpdZL+detmIOnRtT22+0ykPFC8W8pv2KB
         jxoQJlV6pLu+NBWsmz+i9+uF9L2h7TDGl9VPJia3sTeDktpDQIfQjnqkF6U1TTv5mhAY
         fCt6u0AkeL3nZji90G8TBeDmt4CYgnfhbFnrtKVdb4PeBH6ULrIQLY4+FXFW141AUc43
         xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHkkfIoFF1qw+kwo2ruPxNnTiHN3WOfKe7UGzAyln1k=;
        b=LuI/CyaTLMgGjUzrUGyA02PmpRIcn0ay+NcvU8RXUA/CYf1e68/RLXiPhkxdW2tHl+
         tyTiLfO9QRu+xkm0dTkSUiPBtLx2WoFb93379M2jqu9OlYEtVy8TTcYP4yLM+9SWPM6r
         RTjwDrwD3sVJgURTcN5Pvc8LjGvnZbKRv9QO/DE0Wi10A39aiJGfjNPu5U74RJK66V++
         fG18muMUMtwrBgtk8KaTZBWOm9x0HjuId1h562x8EgEI6+MF9RDTxLLUdvfXXJSru3TU
         9pnNg2PCDPqzw3UUo5HacUM2otC2vW1nKAM3u7bB5z3stpe5f7qfkWJEeJvXVdxWkZsl
         7PgA==
X-Gm-Message-State: AOAM530zyqsMPn3wcb+x+h1czK0/8qsy29yVmjBWmItRKqgd2MtqX0da
        yru8KyBYMOzYV8LA8Z79mmZyGIY4UlsLhPeGEv8U
X-Google-Smtp-Source: ABdhPJw+tUqD+1jhZx2zdVePui2vzvFVaokz23EiZW0A9DFcMFeRESbIDRe3eisDb6C6XDgiASySnQ35LLW5GRUU0XY=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr15543443ejp.178.1598452143149;
 Wed, 26 Aug 2020 07:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
 <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
 <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com>
 <CAHC9VhSBsTU++65fPqZvdvdT_Ja+zaj-toUSa6iVLBCt8vQOBw@mail.gmail.com> <CAFqZXNuvciwq4ApXWxR14nqezDZEJSunTONXy-dmfYmu84Mq6g@mail.gmail.com>
In-Reply-To: <CAFqZXNuvciwq4ApXWxR14nqezDZEJSunTONXy-dmfYmu84Mq6g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 10:28:51 -0400
Message-ID: <CAHC9VhSS9vq-6pNJDzFnWmPOOPPSC4GNifQ=eR7KKA7eT=ZOXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Aug 26, 2020 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Aug 26, 2020 at 9:02 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Generally the core SELinux permission checking code assumes it can be
> > > called from any context (including hardirq) and under any locking
> > > conditions, and hooks that are for permission checking (not security
> > > blob allocation/management) do the same.  This allows permission
> > > checks to be performed while locks are held by the caller. and from
> > > arbitrary contexts  I'd be inclined to just leave selinux_lockdown
> > > unchanged given that it might be called anywhere much like capable().
> >
> > Agreed.  The code paths relating to policy load, etc. are good
> > candidates for an ATOMIC->KERNEL conversion, assuming no other
> > constraints, but I'm somewhat nervous of converting stuff in hook.c
> > that doesn't have a hard sleep-ability defined.
>
> OK, I can drop the selinux_lockdown() hunk then. The other hooks.c
> hunks both have an existing GFP_KERNEL allocation in the same
> function, so I'd tend to keep them for consistency. Or do you want me
> to rather convert the GFP_KERNELs to GFP_ATOMICs there?

I was speaking generically in that I'm not comfortable converting
ATOMIC allocations to KERNEL allocations in the hooks.c layer without
some guarantee/constraint.  In the case of both _setxattr and
_setprocattr we are already doing KERNEL allocations in those
functions so switching the audit allocations to KERNEL isn't
necessarily changing the behavior of the SELinux hook, it can sleep
now regardless.

> > The other question about this patchset is motivation: were you seeing
> > problem reports relating to SELinux memory failures when the system
> > was under pressure, or is this preemptive?
>
> No, I just went over the GFP_* usage in security/selinux/ when scoping
> how many GFP_ATOMIC ones could be changed to GFP_KERNEL after the
> refcount patch and found these that could be switched right away.

Okay, thanks.

-- 
paul moore
www.paul-moore.com
