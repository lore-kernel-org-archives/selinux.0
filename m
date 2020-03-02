Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26887C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE80321775
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 14:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8/CrdIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCBO5F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:57:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34004 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBO5F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 09:57:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id g6so8834863oiy.1
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s25t53P1flFUzIDaCzt5hHgTu3dM7vGbaBJUGwe3iug=;
        b=V8/CrdInnRRSQ/IYeuYghHU1EoFQbfitkCdkI0In5qiPPNarwb+EsJVyami85OrXCk
         hpG9FuJJk7fJAgNR78KJ5JkbWXt9J2cKeyJgMcTwS/GTJVbMsg5bwhrJ+TLuL7a4IQTb
         keJVTCpBYU/96alc9BY/xR/NJimRzQDMuxUDoKoTlkCci1wz9yMINCjV14JcB+Fvl+nG
         hlFoUXnjGybAbeinv7/cjYD7GxZrC87TSLgKHEBpGO4LtPYtbmcieHDhy+BRyyBKmt72
         6NFxHgcnp5T2qcFkLkQm4uvM0UI6Ti+66UC/BgWbgBnVH6taRbsUvf7iWr5v65bKYayV
         somg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s25t53P1flFUzIDaCzt5hHgTu3dM7vGbaBJUGwe3iug=;
        b=PvtDsE3OKOatsRGqu+hm9aYzmX5EE11nhwmcnwi0Ojt59F2us45hxfWNmlejw3Zw7c
         gQV275B7PqqnmMbvx5mGQ4J/MSbmHCTne+WDFgKNNVr9aonrWOGV3ZeE5uIm7O7Of0qi
         AW62wKmivI/wCLQS/rBOC4O3wd7+gfvAXGTW5yrZgPg56fTin2zZ/NTnxwfGJ8jl27NO
         s7lGhKpzvCNm4UhBkH9Jn3U6VT7QRsb8M0tS31ezlOgEruYI3OFFfFW+3Tq0p65vBWbM
         l+Pjt3Cpz48ACuDUN11dP1gHg/xL3kJZMlcGXVwRPFObNM4qpVfANG2BnE7iGXvt3dSf
         HqpA==
X-Gm-Message-State: ANhLgQ1wP/crjMGz29e68nqiw+Aew49M6shwk/5xYMjZ9zY/4eheUKyC
        ZkAmhXVlqoqLFp7u15VplYLOFiAXGK++5DMrSrGPfJ2/
X-Google-Smtp-Source: ADFU+vv9K/6++76zGj+2AMvzAAEXCy8xQRMhtzGEkOLTJlcpRkW9I7AnB0vOypFz4wpoZkW9mC+3Hhqk+gwbP7BNayo=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr4522391oie.172.1583161024664;
 Mon, 02 Mar 2020 06:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 09:58:49 -0500
Message-ID: <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>, jwcart2@gmail.com
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 9:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 1:08 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This series contains two small changes (these don't seem to affect
> > > performance measurably, but are nonetheless logical) and a patch that
> > > changes how the policy optimization "type_map" helper structure is
> > > represented, which speeds up the whole process.
> > >
> > > Ondrej Mosnacek (3):
> > >   libsepol: skip unnecessary check in build_type_map()
> > >   libsepol: optimize inner loop in build_type_map()
> > >   libsepol: speed up policy optimization
> >
> > Not a comment on the patches themselves, but this made me wonder if
> > the optimization support is actually tested by our travis
> > configuration.
> > Doesn't appear to be (e.g. no usage of -O/--optimize or semanage.conf
> > with optimize-policy true).
>
> Adding optimize-policy = true to /etc/selinux/semanage.conf and
> running semodule -BN before and after these patches yields different
> binary kernel policy files (policy.32).
> Is that expected?

Here is one example difference between the policies, along with what
was present in the original unoptimized policy:
$ sesearch -A -s guest_t -t guest_t -c context -p contains policy.32.unoptimized
allow guest_t guest_t:context contains;
allow guest_usertype guest_usertype:context contains;

$ sesearch -A -s guest_t -t guest_t -c context -p contains
policy.32.optimizedbefore
allow guest_t guest_t:context contains;

$ sesearch -A -s guest_t -t guest_t -c context -p contains
policy.32.optimizedafter
allow guest_usertype guest_usertype:context contains;

Seems like the code prior to these changes yielded a more optimal
policy since guest_usertype only has a single type in it.
