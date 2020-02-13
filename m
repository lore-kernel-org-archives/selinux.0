Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FDC352A3
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CCA21734
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qjrCRVGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBMWeo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:34:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46450 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWeo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 17:34:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id p14so648632edy.13
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJAaLYFePXCwivysGE+TTZiNcly4jtjI4GtJ48Fb1eU=;
        b=qjrCRVGoncHIlUl0+zZfYnV9dhOWivdhPDtl9OXA605udDkr1wVxDi/mNdnW5Meixx
         1wUkOXAgwxij8JpaIy/s3Vzm1lymMqlQpvgNv7VusheoliJy3ggE/hBNismxviQtXkbw
         1atb/CIsPpRV1wB0uwyUBXrjUq9symx31oitqsT2oei0vC9CS8gOgDbrOqnAiejqP6pz
         BzZPSj1InJE4+wM581sZspt0A6dFZ8a/NVsOVQFShK43kMZzbxQtgPw0aG6cipls27tr
         lXOQrfGZ1ogc/Q1cUXeM90D4KNVupYaU4wlDrQV/Utp+Q50rQZdodZu6NUgl281ZV5ak
         Ijdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJAaLYFePXCwivysGE+TTZiNcly4jtjI4GtJ48Fb1eU=;
        b=L8i4DUPtgR0p4f3a7jrBGvbuS2JkdscYRBAF2hviIVB/XeS6rLyBCMuSV7bwZpJa8b
         l9GlsKrk7XH2lr7FXYXniK0PxPqU+5yypwrh8s1r5b0CPywCzElw6UTY1uJz/HilTiyF
         VO64o4EG7hCISLgtwoxgA2553hil/f2JAQljndxcvF51molqJXWMc31LA2a3K51XXbp2
         3oJ0u/8BfVcWQ3cA3jBsJoPtoEFPnqHnh0Kt94fzT6ZXAJOj8Od2i4SH+TYRlW+C7TeG
         oTiF7TWGrnqgTCUAAvU+g13optr0pQoe9V+jBAtma0UbiC1t2rWbF3UcDfF1gfwJf33e
         tgQw==
X-Gm-Message-State: APjAAAWVtzRNmzHafUpC8WROcwHT30SwNQxGTItVsz92NSEIgP3CBwI7
        19WoNHxx3cQUewhW5LdLApoLg9lguzylyToC4yAT
X-Google-Smtp-Source: APXvYqyWCIytOZD8K2nNIPvnyXPbB0aTlDkbg0OskoCix/GwifzUQYV4Uy448OMrQ/7AGZocH5lfV+oAw8vbZBMOpWg=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr14803ejb.308.1581633283075;
 Thu, 13 Feb 2020 14:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20200129164256.3190-1-sds@tycho.nsa.gov> <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
In-Reply-To: <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 17:34:31 -0500
Message-ID: <CAHC9VhSQ4K-rVe=Y2wwk=7oY-6r67_M8DMo1VvyYUsXD-FOiUg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 13, 2020 at 9:12 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/29/20 11:42 AM, Stephen Smalley wrote:
> > Remove initial SIDs that have never been used or are no longer
> > used by the kernel from its string table, which is also used
> > to generate the SECINITSID_* symbols referenced in code.
> > Update the code to gracefully handle the fact that these can
> > now be NULL. Stop treating it as an error if a policy defines
> > additional initial SIDs unknown to the kernel.  Do not
> > load unused initial SID contexts into the sidtab.
> > Fix the incorrect usage of the name from the ocontext in error
> > messages when loading initial SIDs since these are not presently
> > written to the kernel policy and are therefore always NULL.
> >
> > This is a first step toward enabling future evolution of
> > initial SIDs. Further changes are required to both userspace
> > and the kernel to fully address
> > https://github.com/SELinuxProject/selinux-kernel/issues/12
> > but this takes a small step toward that end.
> >
> > Fully decoupling the policy and kernel initial SID values will
> > require introducing a mapping between them and dyhamically
> > mapping them at load time.
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Any objections, acks/reviews, or other questions/comments on this patch?
> The GitHub issue has a more detailed discussion of how we can safely
> reuse and eventually increase the number of initial SIDs in the future.

First let me climb up on my current favorite soapbox ... This is a
perfect example of an email where you could have trimmed the bulk of
it in your reply to the original patch posting. ;)

Yes, I've been somewhat avoiding this patch simply because I'm not yet
sure what I think of all this yet, and since it affects the
kernel-userspace API it needs some careful thought.  In other words,
yes, I see this patch and the associated GH issue, but no I don't have
any real comments yet.

Sorry.

-- 
paul moore
www.paul-moore.com
