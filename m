Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06051C2BB1D
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE490206E2
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 19:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dib1b/7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMT41 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:56:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36640 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMT41 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 15:56:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so10741376oib.3
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF3CdcubO+LIf01Y9OkNloYP247G2Svxxev5UPE/4lw=;
        b=dib1b/7zPPvnYQxHTEPbZ80k8g334+dKnPphQOWaipeCX3uRJa3wcWCjWmR+YAz3DJ
         DweznWFMBj9fYadhTp/uiWpEEEU6AFMXGJHFcPnmLVW+sFfjiUdFspcQibocp6jorqS/
         8lalXgDG08yRfG+Qm8uM/bP+Fe8UoGjEA/qSOW357ilkdW9UVM0JDJn/VyQ4oK+I7wLJ
         9l9DA1487K36xUbk5JhqMWpX3zc8XzzHP28ZYLv8in1vZZCsdq6OXSe2SQT78X4Bjj7d
         223SvDJzMaIvsTT81fK08RLnP3ztAdTsz7ADXGeOkGVL8DMp3tSsNn9L9zhjfJMcVS/B
         iPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF3CdcubO+LIf01Y9OkNloYP247G2Svxxev5UPE/4lw=;
        b=d1HLn+WOpyY+SFiaBRf+BDdifFzANniKEdlxOC+6T7SveT1GBGvOOk8z6J+QO4RUIc
         q0YwKFsYxdhcVJezIF0xQc+t3P26df5fqyb0YW8JGQiAlu+tAAv166H+hVkbx9+qH1Kh
         zwXdduN5l6ErJrvZOyZcWNIsbJbteVt+g1Mg+kGOu8ZJBcdtZKoqGkQIkHSZ9JZJtik9
         NwFTCkuVGgDiio4HlIkGCcjTVnaNni6C/ZcIz6kFVw+Erbu6vgcgsVKkfxKQTPZkGY94
         hn95yU5kHfJpHBUBKUlneBsy8ibSFft560l1hAoqd84Tz6mgaCiEDCDMjRSeHs0th1AU
         0/dw==
X-Gm-Message-State: ANhLgQ28xvDz1yqchzkSAEnwuHYp0BQ5FDTCCp9GpzcBjLAL5i7PWJbn
        yvT7AyBMlr1R9tzdJqr2Wnx+7aS+JyIz14adJrc=
X-Google-Smtp-Source: ADFU+vu323JTTPRl3J2on8THbli94cyDFKvfSbHZM5byKnxAn7SF6Ft1+R9XY3Y96pjRfAYd+d9g9dyGx2q5wSucE+E=
X-Received: by 2002:aca:b803:: with SMTP id i3mr6468441oif.92.1584129384930;
 Fri, 13 Mar 2020 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAFqZXNvR6BKuk4Y3DAPUpy5kWkEJ409W1vysrQ5kxh5OsB14UQ@mail.gmail.com>
 <CAEjxPJ5cyjyrj1F7VrmzRLw6Mm0v+3WfP3RO0arsqRhC9MfBfA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cyjyrj1F7VrmzRLw6Mm0v+3WfP3RO0arsqRhC9MfBfA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 15:57:19 -0400
Message-ID: <CAEjxPJ7Di=9zCfb=9rJfgJjAp+-TmChoKmSW8=FV3qB_03MrgA@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 13, 2020 at 3:07 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 7:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 5:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This series contains two small changes (these don't seem to affect
> > > performance measurably, but are nonetheless logical) and a patch that
> > > changes how the policy optimization "type_map" helper structure is
> > > represented, which speeds up the whole process.
> > >
> > > Ondrej Mosnacek (3):
> > >   libsepol: skip unnecessary check in build_type_map()
> > >   libsepol: optimize inner loop in build_type_map()
> > >   libsepol: speed up policy optimization
> > >
> > >  libsepol/src/optimize.c | 119 +++++++++++++++++++++++++++++++---------
> > >  1 file changed, 94 insertions(+), 25 deletions(-)
> > >
> > > --
> > > 2.24.1
> >
> > I can see this series marked as "Changes Requested" in patchwork - is
> > there anything requested other than a test for policy optimization?
> > After 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to
> > 2") the second no longer leads to a different output (with expand size
> > >=2).
>
> I suppose you could move it back to New.

I can confirm that it no longer yields a different kernel policy.

Tested-by: Stephen Smalley <sds@tycho.nsa.gov>
