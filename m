Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93953C8300E
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730DB2076D
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5YQ8cjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD3M7S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgD3M7R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 08:59:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19CC035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 05:59:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 72so4809562otu.1
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFf7gvoG2rS+Arf5IjR6n91dsPcWVd4+/QitG2vsKAs=;
        b=n5YQ8cjPNz6CD/lszMH/+bqV2ZmSlNVZvcG2skYoRFb6fmadqd+LasWxdDUkRIK/vQ
         LhGXYiLhOehY8xyTd8T08C637QPbqRy4osyKI0WQoSqE3xg9ZeT+L9MGk0fpyEHtYkCB
         cTH+T54NeSVAMxWEMXHmF8wB4vKSd9qO8g/NPV9bnIVtJOM9ePx/fUpgU8xPM9vai8Yu
         a2yUrJL1zrmoL9JvfwaGXQMWJvaCV3lxERtpVLXQlvVVPrk3O5or9COpkTckHBdSmToX
         oxRnQFTGozJA6A/9kjCDV8RgkQ1q/8I7p0rOG2O7NQ6x0sRQ+DIsTb8wOUxe14gKTtyC
         /Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFf7gvoG2rS+Arf5IjR6n91dsPcWVd4+/QitG2vsKAs=;
        b=pBE71YymRfAXgJURGOmwWpmPYYMsAqkQhWbc85c7+cC6qoD++KGRxTzjpTcSfzH/43
         Lk8FK2yroer0IO6sStkG5/UPp2z8DtRXDcqUr63uslyQUyQWawmy5rNVs4INO3zAGK7W
         SJS11X+gTSTaWWWzfL3i92W4PUAfcvRId+Y/VSP5gg1XNP9lCzWQaJPwa6/dmxnQhufR
         TZnP4SM/vJ6ixeQuIS2RBm7FFM79p+WEcL5mkc+N5a/1dIJnvzEClgzs5ILO5VSbXJAu
         BcyMyFhwFTekUsDqDHTmS1CKUiT255vCGyZlbwzKE8GQ2dQofaXJXWtkAHrIUlwCWij9
         Ytfg==
X-Gm-Message-State: AGi0PubbWsopg62yNpyv6hwdIrNbVkynlFT0MKmkSk0nFvfOsK7D3FGg
        vJGZDU4gtRQjD5dtcwToKPPnT5rUhEZiQcPFnIk=
X-Google-Smtp-Source: APiQypIi3p4VkE6h3qhFpsIgIa03KkEx/G1Nb3u5rmrCs6XjBdaVveBoEQuACXIibqiUbVMHZyWZldeXzUCNbHRgmqs=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr2443055otb.162.1588251556708;
 Thu, 30 Apr 2020 05:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
 <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com> <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
 <CAEjxPJ56Y1NM_4hsTLvVsxucWmmu9Ny22ao_gpR6Z1JBPxi5Hg@mail.gmail.com>
 <2f01b564-dc93-2aa5-8d77-455f30876876@gmail.com> <b6943521-f46f-6a7f-00f2-efaea4c8d04b@gmail.com>
In-Reply-To: <b6943521-f46f-6a7f-00f2-efaea4c8d04b@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Apr 2020 08:59:05 -0400
Message-ID: <CAEjxPJ7V3GS2ku2nj8OzkCb6kjTOtVG=JW2ojnJiOxAndusYjg@mail.gmail.com>
Subject: Re: Daemon cannot execute python
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 2:18 AM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> On 4/29/20 6:29 PM, Ian Pilcher wrote:
> > On 4/29/20 3:04 PM, Stephen Smalley wrote:
> >> On Wed, Apr 29, 2020 at 3:25 PM Ian Pilcher <arequipeno@gmail.com> wrote:
> >>> Slight update for posterity.  It looks like it's possible to use a
> >>> symbolic link, so ...
> >>
> >> I don't see how that could work.  Symbolic link should be resolved and
> >> its
> >> context only ever used to determine whether you could follow/read it.
> >> Not
> >> for the execute check.
> >>
> >
> > I can't speak to how it works, but it does work on CentOS 7.8.  I
> > suppose it's entirely possible that it would fail on a more up-to-date
> > distribution.
> >
>
> I was incorrect.  It doesn't work.
>
> The service does start, but it's running as unconfined_service_t (which
> makes even less sense to me).  So back to making an actual copy of the
> interpreter.

That makes sense to me.  The targeted policy in CentOS defaults to
transitioning to unconfined_service_t
for services that lack a specific domain/policy.  The context of the
symbolic link is irrelevant for the execve
because the link is read and resolved to the regular executable file
to which it refers before we even look at its context for
transition purposes, just as with setuid/setgid bits or file capabilities.
