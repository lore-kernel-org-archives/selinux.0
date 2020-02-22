Return-Path: <SRS0=hfZQ=4K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB005C35671
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3420702
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p5UEJMF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgBVQZC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:25:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46309 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVQZC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Feb 2020 11:25:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id p14so6333016edy.13
        for <selinux@vger.kernel.org>; Sat, 22 Feb 2020 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOovr1RmnXNKc0CFFUFqHNtKn7MByJ3Q15zvm2vnOys=;
        b=p5UEJMF8W/dOJJIufEOSTyyKpavf6zvdWSuZDwwkt067BuoXcCC6Pydnjj6ZjVRuZJ
         Rq3OPwLCsDribTzScTIlpK7+bjYjicGG7kJSE8Eo8n3yt3h9K9pSWFdGAT1nhR6Ij62D
         x8QHisjsa698VKQnO+5RXoof2/xkK7zrjRBNF/W66K0Bb6TMPIbBBz1S8Kw/ns+TmVp+
         R+JMU1mfihreNswz+HcBHV/wQODxspn/HF7R/+BGvtqPCym/FmmbkPga5oQvgH0fI9H0
         FRw+PiQ6Siw8tutcUnVMn3A7YDhqPumybx6T2rg0Ge8Cl1+/qbCOdxQAzeJJgMH/WFgz
         g4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOovr1RmnXNKc0CFFUFqHNtKn7MByJ3Q15zvm2vnOys=;
        b=QX4XfYtoS1G6vMdjkxn8KmU/RW52m+f7mQahSjZL5Br0kosYWxBZRmhYIz6zDKpRmJ
         z02JccHcfB6lxYubkRkjEmTkZjQRbaq5D8lXuWjwGW63Xxiwx+H7XggsKOC7OFrNGl+W
         wLz5TXepw5sx2yIy0mQ4FpbzLMqPScowQqFcSPGAyT9WmP27JkJJPdaX79SgLhin6Adc
         coILiCThni4lUNrl4hreS5FTuCXADDFgaMR204DT9LJsoxla/H72UigWaV2+Zl6mTdrq
         1ayALnZWBho+2MsCD+my4xw/GpO1bN44IMjdAtI9e0FwR3ysq5MNMdyazq2WyBbbWEDp
         mpvg==
X-Gm-Message-State: APjAAAWWSolIO/BjKa79AGEghVrF/ubfsQ5t+sThl7aWY99h1T10ikaf
        tJSHAk4kJoczhudp4qRoTlTBvKF5H9d+j0i/2r13VZcNPQ==
X-Google-Smtp-Source: APXvYqx99IgfCxdw70HddZp0xY0TLeksHArtYdlpvKhVdHn68mDrOqK7xHo/7O9aGd67Qa7WrJ+AuJTpPo7ZgKEnAFQ=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr39326514ejw.95.1582388699518;
 Sat, 22 Feb 2020 08:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20200218112734.116064-1-omosnace@redhat.com>
In-Reply-To: <20200218112734.116064-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Feb 2020 11:24:48 -0500
Message-ID: <CAHC9VhTX0==Bq6yO51YQvQC0EFzPi2Xmw68QfNpOcn5+EVZ0Pg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In these rules, each rule with the same (target type, target class,
> filename) values is (in practice) always mapped to the same result type.
> Therefore, it is much more efficient to group the rules by (ttype,
> tclass, filename).
>
> Thus, this patch drops the stype field from the key and changes the
> datum to be a linked list of one or more structures that contain a
> result type and an ebitmap of source types that map the given target to
> the given result type under the given filename. The size of the hash
> table is also incremented to 2048 to be more optimal for Fedora policy
> (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> regardless of whether the 'unconfined' module is enabled).
>
> Not only does this dramtically reduce memory usage when the policy
> contains a lot of unconfined domains (ergo a lot of filename based
> transitions), but it also slightly reduces memory usage of strongly
> confined policies (modeled on Fedora policy with 'unconfined' module
> disabled) and significantly reduces lookup times of these rules on
> Fedora (roughly matches the performance of the rhashtable conversion
> patch [1] posted recently to selinux@vger.kernel.org).
>
> An obvious next step is to change binary policy format to match this
> layout, so that disk space is also saved. However, since that requires
> more work (including matching userspace changes) and this patch is
> already beneficial on its own, I'm posting it separately.
>
> Performance/memory usage comparison:
>
> Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
>                  |             | (-unconfined) |           | (-unconfined) | (createfiles)
> -----------------|-------------|---------------|-----------|---------------|--------------
> reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
>
> (Memory usage is measured after boot. With SELinux disabled the memory
> usage was ~60MB on the same system.)
>
> [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v3:
>  - filename_trans_read_one()
>    - remove the 'newdatum' variable
>    - uintptr_t -> u32 (leftover from a WIP version of this patch)
>    - drop 'already_there', just goto out immediately
>    - allocate 'ft' using kmemdup() instead of kzalloc()
>  - filename_write_helper()
>    - move strlen() call outside the loop
>    - move declaration of 'node' outside the loop
>
>  security/selinux/ss/policydb.c | 166 +++++++++++++++++++--------------
>  security/selinux/ss/policydb.h |   8 +-
>  security/selinux/ss/services.c |  16 ++--
>  3 files changed, 110 insertions(+), 80 deletions(-)

Merged into selinux/next, thanks Ondrej.

-- 
paul moore
www.paul-moore.com
