Return-Path: <SRS0=OI58=4F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1655C7619F
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895520801
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtOvJvMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBQL5l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:57:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728773AbgBQL5l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Feb 2020 06:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581940659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eO61PZBrUFfAs06+BbbtThxErog8rlCcdFpoIDY7vU8=;
        b=RtOvJvMgIE5TYNkDihG2VNDIDNo7ZLQ1QkzmQzI0XS3kz4fYbhrB1QVEbZmsdjEY+m16l9
        SjsMwa6mUQDRMEKZCWz6aswv8GPqR4eU6qUE2Qg4r114VrS2s5U4QBOYAFB6TGlSZnxN9W
        RUOuHCgqp0GvV1x3r54TTtB3YUby4WI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-AVdZzIT6MJ6q5NHmyloqtA-1; Mon, 17 Feb 2020 06:57:34 -0500
X-MC-Unique: AVdZzIT6MJ6q5NHmyloqtA-1
Received: by mail-oi1-f199.google.com with SMTP id 21so8088128oiy.15
        for <selinux@vger.kernel.org>; Mon, 17 Feb 2020 03:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO61PZBrUFfAs06+BbbtThxErog8rlCcdFpoIDY7vU8=;
        b=ldNuwFOTpyWXz2Wx6iumoZXmb98Zs08y0mN08VEOS6YT3MrL8C2x6a/OggiEXXFZY7
         eqyp1dqXby7wEaHOkPJXItnepUWWozHWiCBFJ8vgurpo2zDQlkALb0lJjgcPkhAWDce4
         0r+Ndn0F4ABNI7nGex3l0ohnrSo+TZwQZKcfSU6iMYZGVDNhen5juQzuDPlhPENx3kXd
         OiSrGS7Z8E1fIdtpEA2LFohoW8yVSTUdWadMQ5KNkIM143bYYgOUwsGkxbKyfHdKZd26
         7QRI+QQR/g3dJ3WwijtJyJMg5vV2ce60AJ2ZdH2p1FERrWebxdA1l2KdU2Pt2mGqCaC4
         shFQ==
X-Gm-Message-State: APjAAAWG5OJIGw0z3HjarG7NrkYUkJT7VwVyni4wm7CmeqLx8zpPOeGw
        KjJ5zXoX5Oq1SCmA27fBnxdKrm4l9ee3zo3N2f7GsMZsbrHrJZJQ4DCI4jUCQ3YspeHi5cfYLX0
        8IbPpHvYO8Ly0FNsiCNQLLQjc8yJz4PSYBA==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr12095001oth.197.1581940653429;
        Mon, 17 Feb 2020 03:57:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKS4E2fHW5JN1gX2ogTsiBwDJVhbKAEXYOmp8ESSOWtKa7lIr0ImecIdXYFvc+E3GrWUfJo26gzkIVcnm6c9o=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr12094984oth.197.1581940653125;
 Mon, 17 Feb 2020 03:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20200217114943.67607-1-omosnace@redhat.com>
In-Reply-To: <20200217114943.67607-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 Feb 2020 12:57:22 +0100
Message-ID: <CAFqZXNsRjE6ka_m13ec8aQh7mmT3oTMP+GpkbQaa0=a_gipsSg@mail.gmail.com>
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 17, 2020 at 12:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
>
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> from 870 ms to 170 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
>
> The memory usage increases a bit after this patch, but only by ~1-2 MB
> (it is hard to measure precisely). I believe it is a small price to pay
> for the increased performance.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/hashtab.c  | 21 ++++++++++++--
>  security/selinux/ss/hashtab.h  |  2 +-
>  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
>  security/selinux/ss/policydb.h |  2 --
>  4 files changed, 40 insertions(+), 38 deletions(-)

Note: This patch applies on top of the filename transition series [1].

[1] https://lore.kernel.org/selinux/20200212112255.105678-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

