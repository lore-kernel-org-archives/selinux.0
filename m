Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D8C433DF
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC216206F1
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 19:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="mfJUsoSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgF2T6a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgF2TkS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jun 2020 15:40:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E2C03E979
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 12:40:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t9so9844685lfl.5
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=MuwMThP3LYgSxMy5Tmpm3cUdSUZ+lQU+u8G3J3Prf/4=;
        b=mfJUsoStoTJES6jTVq/IIV8HNX5P6EqDZvAiRN2bSKn0iArLjpWYQHQSnqGJGBdVQZ
         s0wP+IyMJFIRHT74IY9nsAb5bLohBAWK5KbixRfx7N0AkJzKIaNkwazG5uzzjGVGZYd8
         OzNoGmJmf+N8QWYZb20Di9mbZIDAz2LjziQfwkRrcC9J6T6LYHvJIIVtNVOVhOgW3BZK
         hP3l2FxSPhzowBlKX1HOPzfJX6AVCBtgmlXEWE8fuiejscXRhQNRNHFO9ZYWe/TFTXb/
         RK/IaGTi/dUI9BYOJQpRbIUC27Fqo0QC3VoxD7LdQ5BNiPVTNFNd+AcTs4C7X/CDGcvN
         nPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MuwMThP3LYgSxMy5Tmpm3cUdSUZ+lQU+u8G3J3Prf/4=;
        b=B00ayCYS41OM6C9z6f2S5pDMl65GFKft2IqcWvQFiC190QjuljkE+BidRsUaYb8T7R
         eQSZM6vy3Vq7EZkfIBMlKtQn3ohbDEX+MhNye82XhUv5LVyhBKvW2lEHQKN3sEdgf52O
         V0uFcn8DBdsNb2YDYwZkJmMr+F8hlDDOMqSqxOVZBa0e8ZdRP5C1IoD+4nvC09rd5iDD
         B6ufRjkC4egAFs5H67sBQP45r5a0vp7VyidwTfS5gIjP4JM0kls0NtVQNexfOg4Oj5xd
         CygMffnCKPfBwf98Qs0LLc2RLCtnPcC5pJuJC53a3Rb5IP2rJgjCSRvz7qy3p6gNOD9g
         kWxA==
X-Gm-Message-State: AOAM530avsbR+yOsmuU38JzfZaY7kGLRwlFNKF2aYLBED455ABnbbonC
        bMyafTUf1AChNVh7e/jl4jv0yBmXUxltbPtHM/sY2NbP
X-Google-Smtp-Source: ABdhPJyQkZfoxTRoh4co3hsFB3EMnC1cH4ynBecqHt/ecBbLIBWWoQZiGVh2JAk0fLfURSCgFn1xVDMm5+/FOw+sE0Q=
X-Received: by 2002:a19:a417:: with SMTP id q23mr9669467lfc.181.1593459616153;
 Mon, 29 Jun 2020 12:40:16 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Mon, 29 Jun 2020 15:40:05 -0400
Message-ID: <CAMN686EVbRLAiti82aRqQUHLYERe7fSydgz1NVttZNHS74dkFQ@mail.gmail.com>
Subject: [RFC] userspace: netlink/sestatus feature parity
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In looking at the userspace AVC netlink and sestatis code, I noticed
there are a few discrepancies between the two mechanisms. Considering
sestatus is intended (AFAICT) to be a swap-in replacement for netlink,
I'd expect all of the same code paths to be covered. This doesn't seem
to be the case.

One such difference is the handling of `setenforce` events in
`selinux_status_updated/setenforce()`. While netlink updates the
internal `avc_enforcing` state, `selinux_status_updated/setenforce()`
do not.

Any userspace object manager wishing to use sestatus with the internal
AVC is not guaranteed to have accurate state during calls to
`avc_has_perm_noaudit`, unless they reach out to netlink. sestatus was
initially implemented for use in sepgsql, which did not require use of
`avc_has_perm_noaudit`.

To more robustly support use of sestatus, I'm proposing that we
improve upon the sestatus code by having it update/reset AVC internal
state (avc_enforcing, for example) on status events.

Would such a patch be of interest? Or would it be simpler to just
update `avc_has_perm_noaudit` to query sestatus for enforcing, rather
than refer to `avc_enforcing`?

A few questions further questions in case this improvement is of interest:

1) Should there be separate callbacks for netlink counterparts in
sestatus, or is the existing infrastructure suitable for implementing
handling of those events?

2) With netlink we're guaranteed sequential processing of events. The
same is not true for mmap()'ed status updates. Do we care about the
order in which events are processed?

Thanks in advance,
-- 
Mike Palmiotto
https://crunchydata.com
