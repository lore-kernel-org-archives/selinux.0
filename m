Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C427C43381
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A396508E
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 14:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhCPOtG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:49:06 -0400
Received: from casper.infradead.org ([90.155.50.34]:35706 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbhCPOsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 10:48:39 -0400
X-Greylist: delayed 1050 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 10:48:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I83FUX8REQnGGM5/pjTJyS9wyrS41rYMBqxzXfh8ivs=; b=Ryq2S/TCnJe/6qxTbp2Pv+nD43
        Svhcv9AsmtreQyXy+cwpkLiuVfs+GZZcAM/wkick+giUJ6YA+EYDURY9jcyZiLZnqfz/NFzH0R9np
        3darK4QSLHeIn5OXlBBPCP1VKbDWHx2HzDboiiy+hLUu/Dd431GOeK0EpzfyCYVlC2BBVLBrvm4kU
        C4RBvJZjFHKibjAYEozTrisNtU3zxZqiUGD6ZGfAom96dfSy7qPYyo/H9O3enKHyKmZSyD4inmsoE
        jH2NaVKykdggfGBizY4EIZBLpAVanJgxZP/wtosDiwQDb4dq3BwgY0HETFW1LdS53hEuMEcnsm5aJ
        /C4lphKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMAid-000BDy-HS; Tue, 16 Mar 2021 14:30:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85D353012DF;
        Tue, 16 Mar 2021 15:30:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E48F2CE947F3; Tue, 16 Mar 2021 15:30:46 +0100 (CET)
Date:   Tue, 16 Mar 2021 15:30:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Moore <paul@paul-moore.com>
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
Subject: Re: [PATCH] perf/core: fix unconditional security_locked_down() call
Message-ID: <YFDBFuABYwhKliU9@hirez.programming.kicks-ass.net>
References: <20210224215628.192519-1-omosnace@redhat.com>
 <CAHC9VhQHrmKHxYuTBOy-JHTXHjGTU9UX-AWk3jbiaNfSkZ+N1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQHrmKHxYuTBOy-JHTXHjGTU9UX-AWk3jbiaNfSkZ+N1A@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 09:53:21AM -0400, Paul Moore wrote:
> On Wed, Feb 24, 2021 at 4:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Currently, the lockdown state is queried unconditionally, even though
> > its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
> > attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
> > it causes trouble with the SELinux's lockdown hook implementation.
> >
> > SELinux implements the locked_down hook with a check whether the current
> > task's type has the corresponding "lockdown" class permission
> > ("integrity" or "confidentiality") allowed in the policy. This means
> > that calling the hook when the access control decision would be ignored
> > generates a bogus permission check and audit record.
> >
> > Fix this by checking sample_type first and only calling the hook when
> > its result would be honored.
> >
> > Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  kernel/events/core.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Perf/core folks, do you want to pull this in via your tree?  If I
> don't hear anything in the next day I'll pull this in via the
> selinux/next tree.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Ah, fell in the cracks... I've no idea what Changelog is trying to tell
me. It is pure gibberish to me. But the patch seems harmless enough to me.

Let me queue it then.
