Return-Path: <SRS0=bAF8=OP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D732C04EBF
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086520672
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeLFJdg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:33:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40959 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJdg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Dec 2018 04:33:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so20109433oie.7
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 01:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWo30I/qP+FnLzbYgweaOHk7C4TMrK39d4+5ajeJ6SA=;
        b=OXd3nZOsTTRpcU43L4uZr+Wy60BAqlV8pDsrrLz94vyujxKEOPbKNOS8xdJLUthj1m
         9ajgDLNmWLogzM6AZAi0X+CwKT5inO+iN5WKVVBsNmB8up0MkxCZ6ga6o0PdslFTi18q
         5NJNezi0+++2iHbvqnlp4da9XTwEQJt7qdASt0frDoKBFgyr0oFbiPDwP4KG0qPEjyLC
         1i5lrtJmzwiM4t8LDcSVKYn7jF376Dc3DoqNHkPVSRGOJWPoOmziJHrPiaiYjROInTGR
         epwrHpp8NhWUrJ2QwPejOLn1vfJXo1WKQBkNekfQsG0tuRHNgsH0x7DVAyCAyZzF6b7w
         fX2Q==
X-Gm-Message-State: AA+aEWbi1mAkpqVlguWGIkS8Di97hmAGl3qxkhEfWNO1UhCpRjYCxn7l
        UsDiKhPBO1be1UHKLkST5nIT1LPItWf2b/n3Y+ttkRkl
X-Google-Smtp-Source: AFSGD/W4WuyQlBWeKx41DDjXsFwaXW/RqsMpFIqeRLDKVGtWnAHqJegcBy1JChWkwEec4Sv+qLiE3W0Tt4D6Qlrd/wU=
X-Received: by 2002:aca:5c05:: with SMTP id q5mr16220943oib.146.1544088815248;
 Thu, 06 Dec 2018 01:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20181130152408.24513-1-omosnace@redhat.com> <20181130152408.24513-2-omosnace@redhat.com>
 <CAHC9VhRb0J4omofmE8j3sDi+EM8FSXTG2qhyzkuPh8i+SWbFHA@mail.gmail.com>
In-Reply-To: <CAHC9VhRb0J4omofmE8j3sDi+EM8FSXTG2qhyzkuPh8i+SWbFHA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 6 Dec 2018 10:33:23 +0100
Message-ID: <CAFqZXNv-k0ukrobnXu4dPEc_wHPZAgdUOPE1826+e4m4aArQYg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] selinux: use separate table for initial SID lookup
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 5, 2018 at 9:59 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Nov 30, 2018 at 10:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This moves handling of initial SIDs into a separate table. Note that the
> > SIDs stored in the main table are now shifted by SECINITSID_NUM and
> > converted to/from the actual SIDs transparently by helper functions.
> >
> > This change doesn't make much sense on its own, but it simplifies
> > further sidtab overhaul in a succeeding patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c |  10 +-
> >  security/selinux/ss/services.c |  88 +++++++++--------
> >  security/selinux/ss/services.h |   2 +-
> >  security/selinux/ss/sidtab.c   | 168 ++++++++++++++++++++-------------
> >  security/selinux/ss/sidtab.h   |  15 ++-
> >  5 files changed, 173 insertions(+), 110 deletions(-)
>
> Based on a quick look, this looks fine to me, and you've gone a couple
> rounds with Stephen giving it the okay so I'm merging this into
> selinux/next, but I've had to do some minor tweaks to make
> checkpatch.pl happy (line length) and cleanup the whitespace (no
> double vertical whitespace).
>
> Please start running checkpatch.pl on your patches.  I don't care if
> you run it via a git hook, by hand, or some other method - just do it.
> It isn't hard and it catches lots of silly mistakes.  I believe this
> is the second time I've mentioned this to you during this development
> cycle, if this continues I'm going to start rejecting your patches if
> they fail checkpatch.pl.
>
> I'll be the first to admit that checkpatch.pl isn't perfect, e.g.
> sometimes fixing lines to 80-chars can make things worse, so if you
> have any questions about checkpatch.pl errors please ask (preferably
> on-list so everyone can benefit).

I did run checkpatch.pl and I fixed all ERRORs reported. I also fixed
most WARNINGs, leaving only line length warnings that I wasn't sure
were worth fixing. Documentation/process/submitting-patches.rst [1]
does leave a room for exceptions and I know that at last some
maintainers strongly prefer slightly longer lines before awkward line
breaks (and I can see that you left a couple 80+ lines in the final
commit of the second patch as well). I took a bet on leaving most of
the lines as-is and now I see it was a bad choice... I'll tweak the
imaginary knob further in the strict direction, hopefully I'll have a
better accuracy next time.

As for the double empty line, I agree it shouldn't be there, but I
didn't spot it because chachpatch.pl isn't complaining about that at
all on my side. Did you spot it manually or am I missing some
checkpatch.pl flag?

Thank you for still having patience with me and thanks to Stephen for
the reviews! I hope the patches will cause more good than bad from now
on :)

[1] https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html#style-check-your-changes

> [...]

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
