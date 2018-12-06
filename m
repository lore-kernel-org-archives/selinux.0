Return-Path: <SRS0=bAF8=OP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92158C64EB1
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C39820878
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IZmT9VVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLFX0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:26:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42926 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLFX0o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Dec 2018 18:26:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so1665951lfh.9
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+KT+Y1jBoqSJbQHKz7jsESWu3LvlIYIoT6/8PimxJI=;
        b=IZmT9VVL3OMfZalOed0O8u7EVgRQf/drHcQxnFZ6hXfzBsu4hYiSFG7HRqDjMNx0h0
         +QnpgVVzeeUlVzYwX5xg6ney1Uzc84UpyStlVVRtk8t0RBC37LqLI/NV+UaVRw4PGweZ
         7eqXdshioSjrSNiTqxRUu1n+YjUNvIanDeZqeDbTtCw3Sewzobyh6iAiTI7leh288DBD
         1YuK0a3I2LrjlxwBQqfthYCzoSCssvb5T6YpKnKkP0WLR9WeELIE+Jpm/OYntW+70sqL
         dPPzhL9WZhAtT1Rls1v4PhpWyHlHiPumd91IKC/HuOUQJLGjOwwnEqdaKmylmq+N4J6v
         QPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+KT+Y1jBoqSJbQHKz7jsESWu3LvlIYIoT6/8PimxJI=;
        b=WtoF1N9ErIKhPOvpIPXadSsxWGaJu2kO+tPrnNs8z5vHYa74uO2AciY0Hjoj40Xviq
         UdqFtNc429OVS1/9r4rVhrsRXWDHIoskw74gHOW7W9zHU8GZeIkQrrMJAK7OIrqTp61t
         3wkzl2mp75rbD7BOy/WhmoAqF8jqhEfvkdZp+i953GRRXmD4a8fktYJeCgVu9z1a+umF
         jCx+J9n6ZZ7PBRElx2QPTvbbJDBbgY1xKQ3d0yBe9iueXqxTEJeVxwH6B5IgxKXwaW0e
         sDcpS2GmxJvl+2P3W7Y2ARIjX9bv0ok4W01avIVUqf0f5XJ1U04Mj4tUFWsum7X8Ts+K
         ibug==
X-Gm-Message-State: AA+aEWb+cu6TIGIzNo4WzsHGlp6hu+W/GKT5hBN2Fu+i1/javohXEm9w
        jHiNuWbnkxFcvsii4c2I9d13BDgYXHUTSrwtyPl8mQ4=
X-Google-Smtp-Source: AFSGD/UmNLz0rSUKB1K0I6ykwjFE5fWu1M79Q1msXGG1VdI4ptz+uRJa+ebOjrweIgxKGNYTH25dy1qQTV7ynyQjUPY=
X-Received: by 2002:a19:f115:: with SMTP id p21mr17714893lfh.20.1544138801897;
 Thu, 06 Dec 2018 15:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130152408.24513-1-omosnace@redhat.com> <20181130152408.24513-2-omosnace@redhat.com>
 <CAHC9VhRb0J4omofmE8j3sDi+EM8FSXTG2qhyzkuPh8i+SWbFHA@mail.gmail.com> <CAFqZXNv-k0ukrobnXu4dPEc_wHPZAgdUOPE1826+e4m4aArQYg@mail.gmail.com>
In-Reply-To: <CAFqZXNv-k0ukrobnXu4dPEc_wHPZAgdUOPE1826+e4m4aArQYg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Dec 2018 18:26:30 -0500
Message-ID: <CAHC9VhS98tw=CGGPpmWORPmsG6VG060ouke-QE9oevSZL5Zs-A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] selinux: use separate table for initial SID lookup
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 6, 2018 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Dec 5, 2018 at 9:59 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Nov 30, 2018 at 10:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This moves handling of initial SIDs into a separate table. Note that the
> > > SIDs stored in the main table are now shifted by SECINITSID_NUM and
> > > converted to/from the actual SIDs transparently by helper functions.
> > >
> > > This change doesn't make much sense on its own, but it simplifies
> > > further sidtab overhaul in a succeeding patch.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/policydb.c |  10 +-
> > >  security/selinux/ss/services.c |  88 +++++++++--------
> > >  security/selinux/ss/services.h |   2 +-
> > >  security/selinux/ss/sidtab.c   | 168 ++++++++++++++++++++-------------
> > >  security/selinux/ss/sidtab.h   |  15 ++-
> > >  5 files changed, 173 insertions(+), 110 deletions(-)
> >
> > Based on a quick look, this looks fine to me, and you've gone a couple
> > rounds with Stephen giving it the okay so I'm merging this into
> > selinux/next, but I've had to do some minor tweaks to make
> > checkpatch.pl happy (line length) and cleanup the whitespace (no
> > double vertical whitespace).
> >
> > Please start running checkpatch.pl on your patches.  I don't care if
> > you run it via a git hook, by hand, or some other method - just do it.
> > It isn't hard and it catches lots of silly mistakes.  I believe this
> > is the second time I've mentioned this to you during this development
> > cycle, if this continues I'm going to start rejecting your patches if
> > they fail checkpatch.pl.
> >
> > I'll be the first to admit that checkpatch.pl isn't perfect, e.g.
> > sometimes fixing lines to 80-chars can make things worse, so if you
> > have any questions about checkpatch.pl errors please ask (preferably
> > on-list so everyone can benefit).
>
> I did run checkpatch.pl and I fixed all ERRORs reported. I also fixed
> most WARNINGs, leaving only line length warnings that I wasn't sure
> were worth fixing.

If you aren't sure, ask.  If you can't ask, or don't want to ask, you
should assume that you need to fix the warnings.  I will say that line
length issues are one of the things I do genuinely care about, so
please do fix those.

As an aside, length length is also a great example of exceptions.
There are some cases where forcing the line length under 80 characters
is not advisable: function calls where splitting the line would leave
the first parameter on a second line, splitting a printf() format
string in an awkward spot, moving one or two closing parens to a
separate line, etc.

> Documentation/process/submitting-patches.rst [1]
> does leave a room for exceptions and I know that at last some
> maintainers strongly prefer slightly longer lines before awkward line
> breaks (and I can see that you left a couple 80+ lines in the final
> commit of the second patch as well). I took a bet on leaving most of
> the lines as-is and now I see it was a bad choice... I'll tweak the
> imaginary knob further in the strict direction, hopefully I'll have a
> better accuracy next time.

As I said, please don't hesitate to ask if you think leaving a
checkpatch violation as-is is preferable.

> As for the double empty line, I agree it shouldn't be there, but I
> didn't spot it because chachpatch.pl isn't complaining about that at
> all on my side. Did you spot it manually or am I missing some
> checkpatch.pl flag?

I spotted it manually during review.  If anyone knows how to get
checkpatch to flag this, let me know.

-- 
paul moore
www.paul-moore.com
