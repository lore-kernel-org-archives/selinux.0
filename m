Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7271C43333
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6C650FF
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhCPPNe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhCPPMh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 11:12:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494DC06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 08:12:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j3so21963600edp.11
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGbviYwXGLHE4MYF0ChNHBXUiMd3TQQ4yzCas5xcr8I=;
        b=Iv0h1EsZcVF13nLGcu/i5u8myttZ8nW0jW4FaV2UmOu8m1CkiLbzbrPRjAi7y8KlhJ
         dsG0A/itcyfxDqeHFbGp7wMs/lHzpR4nW80zZ3b9nP5mXtUgzbqaD21Mj61+J0lZIdWC
         5StyDiv9neA+dEm2IuXvKnf4pD0Kv6tM89AYJLX4u7vcskjbiNYiug0QIc3cLn0SaAiI
         jnCB2DNU2qwhPXOmepOcPRkyxDOsNzETWB4fR5NHMLQidEwdrjylXG0MegLF77jpD7vA
         nUmFGga1XiUi/pW+XxHzUdlzU5/H1QXwH4Riu8xJO14uXymeegXuQ/KgQmAGQUkI3FYU
         Senw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGbviYwXGLHE4MYF0ChNHBXUiMd3TQQ4yzCas5xcr8I=;
        b=mSPn6A5xLdYXs7H0RJEZbc/6A+AxuWXw34JqfrxtX9d6kyVwfDs7dj8XyyZtTvq2rB
         Q69LXH4eeLGv2fe7vokXaCz2iRIMxjf6/qZ9Zm3pkbdGa5ROSFiqm5tgsFJ35k57PrQD
         3ydm/ZzZsD1/EvF9AOKAslda5Ja286/cVdtZhXnoCElOzsiIro+ixd44Qu93XdUY3AlC
         q7EwwMbFlYzD8F8Uc7Rlp4uDsVaAGfoExxpRHN3qedryBu5qegAhwXNJu8PorgD9NCVj
         CaSlfB+tUPdFFKqG3x+JZYjKC7GVjjJL58JCjyCGzBch2n3x8JBUHaREeFt0SFU087WB
         +C/w==
X-Gm-Message-State: AOAM533tydMAPqBnf4Xi0oduFvrLAnhAydzgst9s8X/06cO9DDEUoldb
        eGtK269GcNudgBH+w5AAASGv8FUDigHameEEBoY9
X-Google-Smtp-Source: ABdhPJx+KAzGCNLdXciVgRe6xQgh0JSC4sLM2JEnI2GeBapxGlqLOAN52hdUeZGhdxr4qTkaMyUj7JLDzU+qgwpaoTE=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr36006172edb.135.1615907554745;
 Tue, 16 Mar 2021 08:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210224215628.192519-1-omosnace@redhat.com> <CAHC9VhQHrmKHxYuTBOy-JHTXHjGTU9UX-AWk3jbiaNfSkZ+N1A@mail.gmail.com>
 <YFDBFuABYwhKliU9@hirez.programming.kicks-ass.net>
In-Reply-To: <YFDBFuABYwhKliU9@hirez.programming.kicks-ass.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Mar 2021 11:12:23 -0400
Message-ID: <CAHC9VhQraYuPu-fu9YFvHOaCiz=6xi1nSbP_YJ+EcSRO0A760Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix unconditional security_locked_down() call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 16, 2021 at 09:53:21AM -0400, Paul Moore wrote:
> > On Wed, Feb 24, 2021 at 4:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Currently, the lockdown state is queried unconditionally, even though
> > > its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
> > > attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
> > > it causes trouble with the SELinux's lockdown hook implementation.
> > >
> > > SELinux implements the locked_down hook with a check whether the current
> > > task's type has the corresponding "lockdown" class permission
> > > ("integrity" or "confidentiality") allowed in the policy. This means
> > > that calling the hook when the access control decision would be ignored
> > > generates a bogus permission check and audit record.
> > >
> > > Fix this by checking sample_type first and only calling the hook when
> > > its result would be honored.
> > >
> > > Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  kernel/events/core.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > Perf/core folks, do you want to pull this in via your tree?  If I
> > don't hear anything in the next day I'll pull this in via the
> > selinux/next tree.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Ah, fell in the cracks... I've no idea what Changelog is trying to tell
> me. It is pure gibberish to me. But the patch seems harmless enough to me.
>
> Let me queue it then.

Great, thanks.

-- 
paul moore
www.paul-moore.com
