Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9548BC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9202078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vY2tmCmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZOp5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgHZOp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:45:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25982C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:45:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k25so1949665edj.13
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3VGI4ZO4Lizn7CsokRl50LFyMV/C/p/NGzm7IxRmNw=;
        b=vY2tmCmo4W0jtZqs5TvQwnmYEnIQJzhLDUBY7CYym88eFsRdpJ4ZxJrn7MvyB+MFio
         bcxEvPMJy9wnjmR2lby9fDmqvN9fg3QVolvVd3QBvsX0462o88VSpraYnhKztalmhGd2
         Euybs+3DAaFUIuwJWRy3ToEqMxmBdJEa96Q2r7KTvb1z5/lfff1Puuerrb05ezIkrRTk
         E+twZsFag+XZzywBLPDuOLAzwZ5m9DSERvBFMzEr1Fo8FEjx7IePtPDKT6K/vxMpCEQB
         KqFF0L3zjlU+ho8M6oi1XdKm5YzeqHgXo3TyWNQJRh/GRIf9XqI/LLA4xIABFjBsHYms
         bzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3VGI4ZO4Lizn7CsokRl50LFyMV/C/p/NGzm7IxRmNw=;
        b=TJcNuFwAQvCtH8VkfhfNGglPz/c/fNL2Pa7ElId/n+M5OMRiWC44nVdMGNBPLI4U+r
         Ms2T0GQWKPu22WrAzGxX+UYE3jld/m9zLjOl+2JfD9cUS3Pmxqtkk77AWLxriVDaaueg
         8cmfYk84zzXFGbkuUoDhWEcm4Hy5t76UX6Dct0LFwwAdYVpcV6frfYT2IGDkUBHhsd3s
         CFniquLyhdDOb2a3ELPs06OyiK8RNOCvumFKfHKvEsJeuJmkk73SIiPbl5uuw0KW3oW9
         cu9nfeHj775yCzcqWi6tZGIhaXAUkPdPnyrpaKfGAdMtYE41tyNs5Cn8APq2RNfCWlNN
         t2JA==
X-Gm-Message-State: AOAM531njEV1mxe/Tc9BXYw1JYkzfPO05CSPuMsFL3UdE70D9QVlEoAc
        DN7ff+9OCQzwEcRCMU3UhyfTJqGM7zCpYfhHVoEv
X-Google-Smtp-Source: ABdhPJz7Lmrx2VSlzkwy+2+vA0HLtnclpWweWaL589faXH/mQoRuZjSVZToxRxXNSNqrVFhEzngnyK3dFQc5fOxqniU=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr14707237eds.196.1598453154646;
 Wed, 26 Aug 2020 07:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com> <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com>
In-Reply-To: <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 10:45:43 -0400
Message-ID: <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 8/26/20 3:42 PM, Paul Moore wrote:
> > On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
> > <peter.enderborg@sony.com> wrote:
> >> This adds tracing of all denies. They are grouped with trace_seq for
> >> each audit.
> >>
> >> A filter can be inserted with a write to it's filter section.
> >>
> >> echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter
> >>
> >> A output will be like:
> >>           runcon-1046  [002] .N..   156.351738: selinux_denied:
> >>           trace_seq=2 result=-13
> >>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
> >>           c1023 tcontext=system_u:object_r:bin_t:s0
> >>           tclass=file permission=entrypoint
> >>
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >> ---
> >>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
> >>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
> >>  2 files changed, 62 insertions(+), 2 deletions(-)
> > My most significant comment is that I don't think we want, or need,
> > two trace points in the avc_audit_post_callback() function.  Yes, I
> > understand they are triggered slightly differently, but from my
> > perspective there isn't enough difference between the two tracepoints
> > to warrant including both.  However, while the tracepoints may be
>
> We tried that but that was problematic too.

My apologies if I was on that thread, but can you remind me why it was
a problem?  Why can't we use a single tracepoint to capture the AVC
information?

> Having partly overlapping traces is not unheard off.  Check
> compaction.c where we have a     trace_mm_compaction_begin
> and a more detailed trace_mm_compaction_migratepages.
> (And a  trace_mm_compaction_end)

It may not be unique to SELinux, but that doesn't mean I like it :)

One of my concerns with adding tracepoints is that the code would get
littered with tracepoints; I accepted that it the AVC decision
codepath was an obvious place for one, so we added a tracepoint.
Having two tracepoints here is getting awfully close to my original
fears.

> > redundant in my mind, this new event does do the permission lookup in
> > the kernel so that the contexts/class/permissions are all available as
> > a string which is a good thing.
> >
> > Without going into the details, would the tracing folks be okay with
> > doing something similar with the existing selinux_audited tracepoint?
> > It's extra work in the kernel, but since it would only be triggered
> > when the tracepoint was active it seems bearable to me.
>
> I think the method for expanding lists is what we tried first on
> suggestion from Steven Rostedt.  Maybe we can do a trace_event
> from a TP_prink but that would be recursive.

Wait, why would you be adding a trace event to a trace event, or am I
misunderstanding you?

All I was talking about was adding the permission resolution code to
the already existing SELinux AVC tracepoint.

-- 
paul moore
www.paul-moore.com
