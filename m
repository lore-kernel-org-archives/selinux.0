Return-Path: <SRS0=GZQR=AR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A1BC433E0
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC482070C
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 13:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mldg+OLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgGFNXc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFNXc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jul 2020 09:23:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA7C061794
        for <selinux@vger.kernel.org>; Mon,  6 Jul 2020 06:23:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 5so29602872oty.11
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2020 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ApxzAntqCay/34Qc37HPH61cvwfmXUOKwBc/BeLOZQ=;
        b=Mldg+OLLT2PIqOMEfUxWreSuaAuvqr56LauSgAAtuOfwU2tI0AgGfXB1b2Bbmbk62M
         N4Gp6kgTOcERi5hHPfAA87HWAziOI185La5SPyE6QW0vgSJSThEiYpn8DhAdWqsGeMBj
         D3LO8zuG2vw684X1WVvXevJVoZPjIpdEQFJicwkUCe7RfKZwWfAXGaizaVyiax6bc7/j
         sEfV5RPjdwkWv9UULiuJ0fCOh7lM0U4UaUuWIvXwCKHp3uXsT/+1zLLMPAitHFYMkw+u
         QSbefuH1959WvpwCThwaxjmBrMtYJ0FbSPjUHlEBb+haT3IbFpvYK4kwuW7PQP0mw45Y
         GKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ApxzAntqCay/34Qc37HPH61cvwfmXUOKwBc/BeLOZQ=;
        b=gUVL0c4noLBElVt02vEjoHZLD8wUFzb1OZhdksHEa7lgL6R9hxPc+OIGLLp4A3Y8U6
         fM1plz0BPSen7BS3BrD6ALt1c2iVmwHjiK/JOq3ku5KFDrR1U8/hNY+iFRfFWAkqMrvN
         vhvf48mAKW3iGJMj9kI1EIGqPZoW2FTHjx4W+gjLG/Ga5Ghe+2Ucd8YT5C5aojAXUG7Q
         y1Awlt4ucrFJtxbGYAjVZwjeoNLOCiAacyf/UOm9pEwjLbp8NGRPJdavPf8AsIwisD6C
         nu46n+n4eIVbZMiDrAUDVWG+VLyshN5k4Zde5xR/0L4z5JR7JK1SDJdse0oe9nRoTHiK
         0hig==
X-Gm-Message-State: AOAM531LRDHS/j5b457165xvGazS3WDbDXfGY8rs1jhcGiPkk55nx3Qd
        1moOLiGmTDsTZeBojFCJRdUB6W348bkZ220YSmWzlSDX
X-Google-Smtp-Source: ABdhPJy3Ie/vjT83bY+N4kArDn6nYbHlMwE/VX8iFqA4HTtO8lOBBzLXgkBsImo8WjRTIi8Az4WnPabqj3x3i5+AhSw=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr27108650oti.162.1594041811392;
 Mon, 06 Jul 2020 06:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMN686EVbRLAiti82aRqQUHLYERe7fSydgz1NVttZNHS74dkFQ@mail.gmail.com>
In-Reply-To: <CAMN686EVbRLAiti82aRqQUHLYERe7fSydgz1NVttZNHS74dkFQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 6 Jul 2020 09:23:20 -0400
Message-ID: <CAEjxPJ5L0U5AvV9kKbbTkjbZ2eRd6Mvbp86izeN4ydvV1YG8Aw@mail.gmail.com>
Subject: Re: [RFC] userspace: netlink/sestatus feature parity
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 29, 2020 at 3:59 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> In looking at the userspace AVC netlink and sestatis code, I noticed
> there are a few discrepancies between the two mechanisms. Considering
> sestatus is intended (AFAICT) to be a swap-in replacement for netlink,
> I'd expect all of the same code paths to be covered. This doesn't seem
> to be the case.
>
> One such difference is the handling of `setenforce` events in
> `selinux_status_updated/setenforce()`. While netlink updates the
> internal `avc_enforcing` state, `selinux_status_updated/setenforce()`
> do not.
>
> Any userspace object manager wishing to use sestatus with the internal
> AVC is not guaranteed to have accurate state during calls to
> `avc_has_perm_noaudit`, unless they reach out to netlink. sestatus was
> initially implemented for use in sepgsql, which did not require use of
> `avc_has_perm_noaudit`.
>
> To more robustly support use of sestatus, I'm proposing that we
> improve upon the sestatus code by having it update/reset AVC internal
> state (avc_enforcing, for example) on status events.
>
> Would such a patch be of interest?

Yes, this makes sense to me.

> Or would it be simpler to just
> update `avc_has_perm_noaudit` to query sestatus for enforcing, rather
> than refer to `avc_enforcing`?

The current AVC interface allows an object manager to explicitly set
the enforcing mode and ignore the underlying system enforcing mode,
such that one can have an object manager running permissive while the
kernel and other userspace object managers running enforcing for
development purposes.  So we'd still need to support that scenario I
believe.  That said, providing an option to use sestatus instead of
netlink and potentially making that the default going forward might be
of interest as long as it doesn't break compatibility.  The sestatus
code already falls back to netlink if the kernel doesn't support the
status page.

>
> A few questions further questions in case this improvement is of interest:
>
> 1) Should there be separate callbacks for netlink counterparts in
> sestatus, or is the existing infrastructure suitable for implementing
> handling of those events?

I haven't looked closely but would guess that we could use the same callbacks.

> 2) With netlink we're guaranteed sequential processing of events. The
> same is not true for mmap()'ed status updates. Do we care about the
> order in which events are processed?

As long as the final state is correct, I don't think so, but I'm not
sure what scenario you are considering.
