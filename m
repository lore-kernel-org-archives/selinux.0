Return-Path: <SRS0=GZQR=AR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723EC433DF
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F313720702
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="QoVAks99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgGFQzO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgGFQzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jul 2020 12:55:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF0C061755
        for <selinux@vger.kernel.org>; Mon,  6 Jul 2020 09:55:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 9so46215190ljv.5
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2020 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjmHnAtIE119KogFhSKYv/9av5MGrXg3ouTqE33B1G4=;
        b=QoVAks99ntkGpSgCyC1g7KK9HSI63m7koskTIdQ4SyJx8Xp3ot1yEOjZANOJZTEDoA
         RPUxBuWhTsg9FC/Q7qW+ICUbl1DZS9YASMNo/H33Kmcrr/kPIWNH5T+4IFiHBch7omK5
         IhNCOUkeNp4DxeZOjOrAgKMPjOTMWh70/plfrDbqilnjJgaK/rHVbvlWX9rvzjddZYxp
         C9PeIf40EwHeTWoJzzZM+5L0k5BjeMdPvtiO3CpwHJGCne9jkhF43+yQThG9pgbbYCgP
         SfRVrqID9pWRGWiD0KmLjLoI7ke5TjyVQKen8G74UYtf+1BQVWUVygPuupy7cZX/ljlz
         2Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjmHnAtIE119KogFhSKYv/9av5MGrXg3ouTqE33B1G4=;
        b=FlpDlP+Y1FAGc8M5tCYr/VxbLBWetceqtXYEZYzft8kYLgR2hWm/eXsCZ+9+nq1ORK
         gwPaslNWGBo996aSmZekvuZkgJZpZcEDekmv57ZxzcMcNTOmf2ntAn47PaDJIHLnQeQv
         U4oknZCE+vj36I8ebC8iLdZID8Q8F+ut58XOc7wmr90/bNxK/r8J06CkrF57eQW5bTaj
         RA817WFN8z90DMVrnEz66Cpk5vYR1w1N9Qgt0DdXOo5ZQQtWdr0aDFfQLZEwLIrwP+EK
         ERyHq90T/c17wicFI124OBmL40LpWfXPuMy9z3A5xJX2SzRJk+P+LKb6p3dh1+QNNRB3
         QKeA==
X-Gm-Message-State: AOAM530IowtW5sFyWIJklYD0nREf4Bet2GFLiWwBsFAXJoFA5DnOr8Cg
        6PFSEF19qH1psEC/voDPk4ubBY6wx2LG8CogISGCgH/2SVYLxA==
X-Google-Smtp-Source: ABdhPJyClZdWBJO/sfhsRUQrqCqVOeyo+tER8Uz3x2WHp8lPQK4P/kU1twVMigm8Lsfj0xtZ2U4vhfljyqF30Ff7MPc=
X-Received: by 2002:a2e:b889:: with SMTP id r9mr28184556ljp.92.1594054512493;
 Mon, 06 Jul 2020 09:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMN686EVbRLAiti82aRqQUHLYERe7fSydgz1NVttZNHS74dkFQ@mail.gmail.com>
 <CAEjxPJ5L0U5AvV9kKbbTkjbZ2eRd6Mvbp86izeN4ydvV1YG8Aw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5L0U5AvV9kKbbTkjbZ2eRd6Mvbp86izeN4ydvV1YG8Aw@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Mon, 6 Jul 2020 12:55:01 -0400
Message-ID: <CAMN686EWUPc=VGw4FZNrJXat2eM-TQwXYWPnMk=fraA9p+jcYA@mail.gmail.com>
Subject: Re: [RFC] userspace: netlink/sestatus feature parity
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 6, 2020 at 9:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 29, 2020 at 3:59 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
<snip>
> >
> > Or would it be simpler to just
> > update `avc_has_perm_noaudit` to query sestatus for enforcing, rather
> > than refer to `avc_enforcing`?
>
> The current AVC interface allows an object manager to explicitly set
> the enforcing mode and ignore the underlying system enforcing mode,
> such that one can have an object manager running permissive while the
> kernel and other userspace object managers running enforcing for
> development purposes.  So we'd still need to support that scenario I
> believe.  That said, providing an option to use sestatus instead of
> netlink and potentially making that the default going forward might be
> of interest as long as it doesn't break compatibility.  The sestatus
> code already falls back to netlink if the kernel doesn't support the
> status page.
>
> >
> > A few questions further questions in case this improvement is of interest:
> >
> > 1) Should there be separate callbacks for netlink counterparts in
> > sestatus, or is the existing infrastructure suitable for implementing
> > handling of those events?
>
> I haven't looked closely but would guess that we could use the same callbacks.

This all sounds good to me. I'll make sure the existing functionality
remains unchanged and see if I can leverage the current callbacks.

>
> > 2) With netlink we're guaranteed sequential processing of events. The
> > same is not true for mmap()'ed status updates. Do we care about the
> > order in which events are processed?
>
> As long as the final state is correct, I don't think so, but I'm not
> sure what scenario you are considering.

I was likely just getting wrapped up in semantics. We really only care
that seqno is incremented once a state is processed.

Thanks for the feedback. I should be able to send a patch sometime this week.

--
Mike Palmiotto
https://crunchydata.com
