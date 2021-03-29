Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FFC433E6
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E7761879
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 08:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhC2InT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 04:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235255AbhC2Imf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 04:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617007355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zslZwT4FVRHW0KUCX1bIPyr/rKNiLOxgP62mReUfosQ=;
        b=H2P/mM8U3GPRu/vY4SuSfj2FTSw5Qr8XoHaLRF/EnT2y7vL3nENJti/M2g7HYQXO40BewD
        7BGA32Uy+pS1PnJDpOuiK1HFiRbBiKfZqvBzTvph4wxuNHoHdDasu1u0n8lfVxPR2s87he
        Ujji6YhlS2Qqted0304Y5Tb4aeAGTj8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-lej5CQX6NA-i2MG1iExIrQ-1; Mon, 29 Mar 2021 04:42:32 -0400
X-MC-Unique: lej5CQX6NA-i2MG1iExIrQ-1
Received: by mail-yb1-f200.google.com with SMTP id v6so18454456ybk.9
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 01:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zslZwT4FVRHW0KUCX1bIPyr/rKNiLOxgP62mReUfosQ=;
        b=dxjRBxgF3iprJaHEDNPCNhZ2623t+sNExADgzckqCjn4GDxr8PfeoK1PlHx17nnJUI
         CKO29h5CRX74GJiukytTYG6OD9PLpOjSf0yp1LYUPUytYdQx2QamWLFUHnkemdgpQQ5c
         CGV9sL7NKRE+1pkmKcgPL0MJD1O36cTHxhYFfZ7pLr26xW/mNy1N5hP9a7O5OHR21oJF
         gaXMmQR/mXzPllCxKSADr7VhaF7buFW/daEcuSFm5UOzl05PagksCiDWyTsusBlfR1BA
         yUZVGJTTGOw4RRcFbRHaTgUvP3lJ5n7bjkHtx45wmtga8X5YhcjhaFMoEmY+Wv2UFTv+
         K+VA==
X-Gm-Message-State: AOAM530Hb3NcErQdQwCRyUGRvbf0GiyS4othiwdJ/ZzfarudWiJDj5Cr
        xVmcaqvC0srsksUgOoMcBrOMcKcBx2Jf5LRAavyenHWmgjfn1Fh68yRJzI5ZdOsdKaSRYqnlqjf
        jIdjVUsBKDF/6AWfgFfej12LK6YJkD1IB3Q==
X-Received: by 2002:a25:ad57:: with SMTP id l23mr36378813ybe.172.1617007351790;
        Mon, 29 Mar 2021 01:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/c2Q2yLo4GaiseOiWObdRY5YDaJ+q+N6eMaBRmkxzFNOG9W2muA3YjwF0ajVi8CcBmVSjNIqHpGCipYgk3Xs=
X-Received: by 2002:a25:ad57:: with SMTP id l23mr36378796ybe.172.1617007351613;
 Mon, 29 Mar 2021 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210324122616.406572-1-omosnace@redhat.com> <CA+EESO4km4ADU0mAcXWR_MjG_v69-4U6tHqgZfPTmCdacSL_sw@mail.gmail.com>
 <CAFqZXNt+0CU8gLR2ZmG+XwO9VCi3cdQCM=hnvzVqebG25qBpVw@mail.gmail.com>
In-Reply-To: <CAFqZXNt+0CU8gLR2ZmG+XwO9VCi3cdQCM=hnvzVqebG25qBpVw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Mar 2021 10:42:19 +0200
Message-ID: <CAFqZXNv9mpFnXZRxrG+xfmx1LUW+cOp0fG6gsSM+wxUrL3HqoA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/userfaultfd: handle __NR_userfaultfd not
 being defined
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 24, 2021 at 3:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Mar 24, 2021 at 1:41 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> >
> >
> > On Wed, Mar 24, 2021 at 5:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>
> >> On some old kernels (think RHEL-7) __NR_userfaultfd may not be defined
> >> on certain arches, even though the <linux/userfaultfd.h> header is
> >> available. To avoid build errors in such environments, abstract the
> >> userfaultfd syscall into a helper function and make it fail with ENOSYS
> >> when __NR_userfaultfd is not defined.
> >>
> >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> >
> > Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
>
> Thanks!

And now it's applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/611d5247e464c69c343e4c5268f346809cf09bbd

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

