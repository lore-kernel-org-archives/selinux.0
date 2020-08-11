Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F19C433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C83D20756
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 12:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttMmwalL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHKMO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgHKMOF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 08:14:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C80C06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 05:14:00 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so11948046oiv.13
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sWx0NnJQKzWhF9k3rgLmpcvmNto/qq2ZDDcYSHYuaoQ=;
        b=ttMmwalLquQLLVHtaxYZ7W9L11hep0I48ciRpUla7s9iPXbkcdVAk2W8iQHm7o3GeE
         kHi5CagVCIF30vdixylNu5+0ris4wiMfjibksT/BMxquScQBhzNthLWpCxJcNvLe7Ssb
         sglfay0Kbw5hJUsgOc0aZY9BBl+xhIiYuCiGYx4fCARedlBheCmIxC/rVS7ReWio35yr
         8/pxxLrz039V2xYesXlQDHDx/ZdW6E5gM8885sbY+QEMYVzdOStU0TwFM4G88ih3Q38w
         Nao+hmtdDLknTTVjAG4rrFvRIYD/322GkS9t+c4cwlxRBvu64eskFG8wLkLV5ngMSzDh
         cNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sWx0NnJQKzWhF9k3rgLmpcvmNto/qq2ZDDcYSHYuaoQ=;
        b=LVHSpFZqKWx1pb9ScQVyNj9iBV6TMJ5METf6MZiXgao+L8JSce7upu5Y4as7jn2liE
         46HHK6dHYZGKcdftCqTKzZE32MphzMeovjglTbaIYQ9k8kdazj5yuGeUrFIVuR48SoKN
         oJmzibqXPSEv0ri0KKWNnAspeawawXjJ8+BcMf/LyqR/hv5AqCkbFofeUfcoTQCJVmqu
         fgL0PbM22lxUL9stl92oo+4P/0ndWJcau27tNVsa3vgLv6IcMaWDtECe+ab5Bx1NNkb5
         odslRbfcG2L5bEwGkfD3cSw2BFJhVSgO/OihrWhyLdmAN3pL5nneL2J+UqVGhxA/V9C2
         ctZw==
X-Gm-Message-State: AOAM532Vv71zUjapUrm3EG/w1u2HjGbRlAcZQWKkHnFZVId4UHqv+oWj
        MyNsGX6Z9xROB+b+KVhoRPVPAT6fVexW2dA/mMH5lpAV
X-Google-Smtp-Source: ABdhPJzlhGAgPUXp1ABPE3l6bNOuEB4HwZn+ngHnKNGMqMJN0Hcrdiv7UdVcybvdPofBF+jyWRmLkvzCZrib8Nr2krw=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr2955074oii.160.1597148038418;
 Tue, 11 Aug 2020 05:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200805194312.7188-1-mike.palmiotto@crunchydata.com> <56f3aed8-03e3-f847-967c-e9c8630f692b@gmail.com>
In-Reply-To: <56f3aed8-03e3-f847-967c-e9c8630f692b@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 11 Aug 2020 08:13:47 -0400
Message-ID: <CAEjxPJ4F70OTPLi_u0Dz8LO7qs_1WuoaK9EqP4awVf92MViOtA@mail.gmail.com>
Subject: Re: [PATCH v6] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 8:05 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On 8/5/20 3:43 PM, Mike Palmiotto wrote:
>
> > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > /selinux/status") introduced the sestatus mechanism, which allows for
> > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> >
> > The mechanism was initially intended for userspace object managers that
> > were calculating access decisions within their application and did not
> > rely on the libselinux AVC implementation. In order to properly make use
> > of sestatus within avc_has_perm(), the status mechanism needs to
> > properly set avc internals during status events; else, avc_enforcing is
> > never updated upon sestatus changes.
> >
> > This commit gets rid of the default avc_netlink_open() in
> > avc_init_internal(), replacing it with selinux_status_open(). In the
> > event that the kernel status page cannot be mapped, the netlink fallback
> > will be used. By default, avc_has_perm_noaudit() and
> > selinux_check_access() will now attempt to read the kernel status page,
> > which removes a system call from two critical code paths.
> >
> > Since the AVC thread create/stop callbacks were intended to avoid a
> > system call in the critical code path, they no longer need to be created
> > by default. In the event that the kernel status page is successfully
> > mapped, threads will not be created. Threads will still be
> > created/stopped for the sestatus fallback codepaths.
> >
> > Userspace object managers that still need a netlink socket can call
> > avc_netlink_acquire_fd() to open and/or obtain one.
> >
> > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > functionality.
> >
> > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
