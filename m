Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43BC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7742120735
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz1pKXts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHUVAt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUVAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 17:00:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E55C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:00:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k12so2663502otr.1
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKnwbxCvi23Nc3hLW3+oHiSgfGrHkV/sa+O0aG1uzGY=;
        b=kz1pKXts/2tzvYX2HJogJ0y+jN1xTFYmjtyrH2sPA5hT+Fv1l3nNWEeHV8K38ZFe5I
         JhdnWFg7AutflKc3+na5GcGZ/XMzXdXeCbM0aVPUgGGdaqtLZxs+A7bc8lUQPjJl0maM
         ZfZfpS1Zi8EmE12B/YqHaR2oWGSxGZNl7WeS4rwssSNYfquOOPS25rJQa8IXznC9nYY3
         SZh6TSLj0HalxibhQFKfuQCt8HTU+HOnQMyjfAnWpdgtSf0hBYidjoOrlRJHz608QZmY
         ywGlUOEAqzak/ch3n/bynDG36mBnlyFBBCxzzwlLOH5LExQicWBwo7IwMgwC7CmSY9GX
         AGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKnwbxCvi23Nc3hLW3+oHiSgfGrHkV/sa+O0aG1uzGY=;
        b=oqyw1HXMFj583QB0G9ZGlmaQl23HJc+gEMdkUiaObPn2PMPPQ87DusSX7r42eosapB
         mO7HhPKMoFb1ZnYa91wMuYY1uJlz4JNgyutsOyPGqfo3TF0eIG4pGEJQrOIoYLlvIbO9
         8IlmnpoRMCiPUiNl/6byMWrPL2QS9PZ+cPY3VBCKke8tusklXjpcHUs0v14c7F2Mv8n6
         ue8TjsI7NF1z0uEFi10PhVeQovA8CRuZSq1EnoTzu5SWLUpQKy+OyPQ4j8cADkmMI/b/
         TeU07MbB/FuKJZvCAEHJqMVMnYLn5hTeL95k4w9tFujjf6N91EGct0WEeEdJZa/KCvgb
         mV9Q==
X-Gm-Message-State: AOAM530GnOluaIOcp2B67zzucj9rYPL/HQn+AlBPQjM5q/WA5UFvjzvk
        4TeJlIYeVyansrgVq+NJLU0wFvc5CqfMaaXDHI2Q3OgmxDs=
X-Google-Smtp-Source: ABdhPJwtwzkOqV9CBCvNczIB7gSBRO2zFVOdi1N0If5lPzel7mVqH1+9omu8hi/lsFwXye1V2+bZZLCmlNen3hTJYpI=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr3371224otq.135.1598043642635;
 Fri, 21 Aug 2020 14:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
 <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com> <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 17:00:31 -0400
Message-ID: <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 9:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 20, 2020 at 8:10 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Unfortunately I need to re-base it again and manually fix conflicts
> > with my patch to avoid deferencing the policy prior to initialization.
> > And I'll need to do it again when/if the patch to convert the policy
> > rwlock to rcu lands.  So you might want to wait. I'm starting to
> > wonder if the first patch in the series to rename selinux_state/state
> > to selinux_ns/ns throughout is a mistake because it produces a lot of
> > unnecessary conflicts.  Originally I did it because that was the
> > original naming since the encapsulation started to support namespacing
> > and then I did a mass rename to selinux_state/state for upstreaming
> > since I wasn't yet upstreaming the actual namespace support. Renaming
> > it back again reduces conflicts in the later patches but makes the
> > first one a pain.  But if I just do a mass rename on all the later
> > patches then I can drop the first one and avoid these unnecessary
> > conflicts.  Thoughts?
>
> I agree, the first patch is the one that always causes me the most
> pain; considering the work-in-progress state of the patches I think it
> would make the most sense to drop that initial cosmetic patch for now
> and we can always reinstate it at the end when this work finally
> lands.

I've made a pass at this and force-pushed it to my
working-selinuxns-rebase branch.
It turned out that the first patch did two things: it renamed state to
ns and it changed all direct references to &selinux_state to use a new
current_selinux_state pointer to a static init_selinux_state variable
(in preparation for multiple states/namespaces).  I had to retain the
latter so I just dropped the renaming part of it, rewrote the
description, and did a mass rename in all the subsequent patches back
to state. So the first patch may still produce some conflicts but
there should be fewer of them.  This is relative to your current next
branch but it will need to be manually re-based again when/if the
policy rcu patches land, so feel free to wait if you want.  Since
every patch required modification and many of them required manual
fixups, I dropped all of your Signed-off-by lines and rewrote all of
mine with my current preferred email address.
