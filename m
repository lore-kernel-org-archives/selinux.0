Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A366C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2707E2074B
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UiLbIo2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLNbe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLNbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 09:31:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47964C08C5C1
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 06:31:06 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so6437791edf.5
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d01buqxZYdIU2y12ViZTn0UU3aSbuc7TBEB4RtzP2wo=;
        b=UiLbIo2MlUzW+ohtKAtNNoB1U6eRB79fOIzs+Q2Jgllzl6LcDbMdd5z429pVr39//N
         xIQPCQQbiZkqpsgEk/VatF3uEsLtmxF4g7HdeLSEXv7BkTq849GgFeS6tDjn5/nYeQGq
         wXh4cAvpDeyYjxTiUvKcCS+DWoz9sUT/CEWx6K17uy3L7QeSC/Ehz2nbG4Ges+S0zwv2
         ogFtyX0ClcI1EB8Dio4Yo+77XzvvGW2Cbajfrx94/cq5HDp6Pj4ciBct17r1oBozJ3HI
         y2v6POjwVITB8rYB2F1JMwbuJrlZF1Ivp/Oir19sh2WcoxC0oKzGFnab4i//KKcKLKmL
         hnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d01buqxZYdIU2y12ViZTn0UU3aSbuc7TBEB4RtzP2wo=;
        b=YjhdJUAWYehl3VH8wD/rQC5es+MWPE8BKoZFanrtnmRn/vK9ti/iOGbquWgdFYYdEz
         FT3zcNfx6EFpSBXZruOPs+4VdUWnE318k3ZOAi3ft5rGO07XX2tmQ1O3rgArIvgIysJc
         mwwo9+HkAutAavIbzTHPKiCrTDKeLNQd7ZLkYb1v13nbsoQ/UkkGKl9UayCajIs/o37D
         1YCIdiS+aKtqYVEXS4JDxtA394aLAaGFXBT+RtlPBmDFJW0XzmjsPOZq+pYw++dVr1md
         YJqJlv9LL9B/a87WraY+ewuhCA4M8DfpjHsYlFDRHooXkmgmXOtPWvPORqLc0kG74u4t
         Umpg==
X-Gm-Message-State: AOAM530LZvuP8hU5fh8t5eefGT1BJoC3r/pJdayetWQrmQr/iUft1qKC
        7TQI37UdxWm8yyGtUvkb4TWMFuwHuabux4Z7L3EY5Rc=
X-Google-Smtp-Source: ABdhPJxkS1P9eYZyRJ+nchncVypsdrnFPrRr9Tdk7r9VlHvGkcJPx7lPPnERUCGLUvWfWQv5iDPnmQThrEcKbqN89/I=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr11332863edv.164.1591968664063;
 Fri, 12 Jun 2020 06:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
 <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com> <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
 <CAFqZXNuVevzXLhCBujJKTPL+HBhOxkUv6a-J1NGY9BzTJ7aWCA@mail.gmail.com>
In-Reply-To: <CAFqZXNuVevzXLhCBujJKTPL+HBhOxkUv6a-J1NGY9BzTJ7aWCA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Jun 2020 09:30:53 -0400
Message-ID: <CAHC9VhRWcRbQi0z90_BHMSBzaCW+muD4Oy_hwNfuxyVjLJsA+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 12, 2020 at 4:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jun 12, 2020 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jun 11, 2020 at 6:41 PM Tom Rix <trix@redhat.com> wrote:
> > > On 6/11/20 3:30 PM, Paul Moore wrote:
> > > > On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
> > > >> From: Tom Rix <trix@redhat.com>
> > > >>
> > > >> Clang static analysis reports this double free error
> > > >>
> > > >> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
> > > >>         kfree(node->expr.nodes);
> > > >>         ^~~~~~~~~~~~~~~~~~~~~~~
> > > >>
> > > >> When cond_read_node fails, it calls cond_node_destroy which frees the
> > > >> node but does not poison the entry in the node list.  So when it
> > > >> returns to its caller cond_read_list, cond_read_list deletes the
> > > >> partial list.  The latest entry in the list will be deleted twice.
> > > >>
> > > >> So instead of freeing the node in cond_read_node, let list freeing in
> > > >> code_read_list handle the freeing the problem node along with all of the
> > > >> earlier nodes.
> > > >>
> > > >> Because cond_read_node no longer does any error handling, the goto's
> > > >> the error case are redundant.  Instead just return the error code.
> > > >>
> > > >> Fixes a problem was introduced by commit
> > > >>
> > > >>   selinux: convert cond_list to array
> > > >>
> > > >> Signed-off-by: Tom Rix <trix@redhat.com>
> > > >> ---
> > > >>  security/selinux/ss/conditional.c | 11 +++--------
> > > >>  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > Hi Tom,
> > > >
> > > > Thanks for the patch!  A few more notes, in no particular order:
> > > >
> > > > * There is no need to send a cover letter for just a single patch.
> > > > Typically cover letters are reserved for large patchsets that require
> > > > some additional explanation and/or instructions beyond the individual
> > > > commit descriptions.
> > >
> > > I was doing this to carry the repo name and tag info.
> > >
> > > So how do folks know which repo and commit the change applies to ?
> >
> > We read your mind ;)
> >
> > Generally it's pretty obvious, and in the rare occasion when it isn't,
> > we ask.  Most of the time you can deduce the destination repo by the
> > files changed and the mailing lists on the To/CC line.  From there it
> > is then just a matter of -next vs -stable and that is something that
> > is usually sorted out based on the context of the patch, and if
> > needed, a discussion on-list.
>
> Yes, it is normally not necessary, but I wouldn't discourage people
> from providing the info if they want to / are used to do that.

I would discourage adding this info into the commit.  It clutters up
the commit description and is of little value once the patch has been
merged.

> It can be really useful in some situations, especially in case of
> cross-subsystem changes that are sent to many mailing lists.

It has been my experience that those situations are rare enough that
in the case where there is some question it is easily resolved over
email.  It's not something worth worrying about.

> But of
> course this information belongs either to the cover letter or in case
> of single patches to the "informational" section between "---" and
> "diff --git [...]".

Here is my perspective ... Cover letters for single patches are
annoying, either the information should be included in the commit
description itself or the information is really not that important
anyway.  I also tend to like seeing only changelog information in that
"informational" section so that it stays relatively clean and
uncluttered.  This means there really is no *good* place to put the
repo information for single patches, which is okay, because as I've
said before this really isn't a problem in practice; or at least it
hasn't been a significant problem in the roughly seven years I've been
maintaining the SELinux repo.

If this ever becomes a common issue I'm open to discussing this
further, but for right now let's not clutter things up to solve a
problem that really isn't a major issue.

-- 
paul moore
www.paul-moore.com
