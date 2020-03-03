Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9115CC3F2D1
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B1E2073B
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgULYLHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgCCUAV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:00:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36279 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgCCUAU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 15:00:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id t24so4373280oij.3
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2OphOVvKkzXP5WElMSfB3CiOSbqyPEoSqScCPQqa5Y=;
        b=fgULYLHTuLf82/MDf4x6qXqCMJCs59r2MrQuWXfpezFZ8EUu7DtwmzCUu9P6hU6pOr
         CHYAZp/dT+1ueZvQKm83IrX4JwQz5PJc6CTGRQVg4QOsOwgZjrua69cfoUJ7mEQSTlAV
         hiJKsWS9WHj7XNukpMbRZnUvSW5jOj3b8s7b8oilKD9DelajXbyr+xGQZxYx+hNAuUmt
         RsjjDgvk2oevYY7nkh9Ydl7KktbeMv1ATZE1W/wnFCfdchc5MJCTUi37t31dLSdMAhvd
         c65GCLibJyVYguw2aw7rfgryDnXqMNmftZ3oqXqRZ7FRqtzX3iFlI52ZvVf+OEt0I0hN
         H1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2OphOVvKkzXP5WElMSfB3CiOSbqyPEoSqScCPQqa5Y=;
        b=DrdFO2GI3YGuQhAAA02RKh8Xcw5qDmWF9uA3SYUb7wuHUOuesld7rH4TpW4ABiJAeO
         bsUU7WM46spoAAyL+YX25zCoJJ0oxC5Ibq5d7zDXgV50fZc8XhL/8KfARuCRgvgN8GGS
         JjzJTETg61SUX5ycSlk46pBgmFaexKpspMMDk5C23eKiVszhEj/xDK+2WU+VL+zfLvLV
         jk2KJGXAgCKbPaHG60axxLemEtY9OsWM0gGPoV0vCAMuyhm0L/edSNO1DVGtAY/oAk7i
         CZvAOEER0VszU1LvtHSB08tPODw5XPC1EPIWB4VqL5190Lh1KnJzlVv4WxVx6FeBEkFU
         jM4w==
X-Gm-Message-State: ANhLgQ0NjPZDNamBsJiq503x8+144Paq1gruNyZ9e8mZF3Yx0pt1+zC6
        DGqZI6o59KiXVrEU6N0ww50fONmvLDOMl9IozX4=
X-Google-Smtp-Source: ADFU+vv4TaDj0W1zvZ7CUaZhoFtgMm3gqTCxrrMTiir5kVrV5KiQHSgsh5JQCGn07MaxIhzjuef9PzWo0CuueK/s9Us=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr167521oie.172.1583265620308;
 Tue, 03 Mar 2020 12:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com>
In-Reply-To: <20200303085233.137371-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 3 Mar 2020 15:01:24 -0500
Message-ID: <CAEjxPJ5unBtG192WPVXFU5SWWfvY_cqO8Do+EsR_N4EeTS5mGA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Adds a basic test for the "glblub" default_range mode introduced in
> kernel commit [1] and userspace commit [2]. The test vectors are taken
> from the original commit messages.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42345b68c2e3e2b6549fc34b937ff44240dfc3b6
> [2] https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9
>
> Cc: Joshua Brindle <joshua.brindle@crunchydata.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

This raises some interesting possibilities by directly adding a CIL
module to the testsuite policy for the first time.
We could do likewise to define recently added classes (e.g. lockdown,
perf_event) even if they aren't defined
by the base policy in order to exercise those tests; in fact, such
.cil modules were posted along with the original
patches adding those tests in order to allow testing them so we could
just extract them from the list archives.
Unfortunately, we can't easily do the same for adding new permissions
to existing classes IIUC, so it isn't an option
for the watch permissions.
