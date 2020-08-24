Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA0EC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE9A214F1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpOoiG+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXNJN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:09:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31299 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXNJM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598274551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpxCEb6z5q/70bK/yWzTTYOiOgDIQIyLkY1YchCfUCg=;
        b=ZpOoiG+A56NtfjueNNmDQj88CrPfSqwqx1m9dQ4gzkZTFP0hhowVsORowFwRPDM4E77ppW
        W55sIoEMZ5fPNkBC7zPBcEBVdOx/iNAxEXMxVceXoEqTB+1WCYXk6dLmfyvA3LqBqhtCLk
        aq0AR1JplOFfb52ISNXWE5JuLodPV8w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-cOtU1CBhO7qj6WzRCX0izQ-1; Mon, 24 Aug 2020 09:09:09 -0400
X-MC-Unique: cOtU1CBhO7qj6WzRCX0izQ-1
Received: by mail-lj1-f200.google.com with SMTP id l15so2773281lji.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpxCEb6z5q/70bK/yWzTTYOiOgDIQIyLkY1YchCfUCg=;
        b=l9dqOwJgp+oYFXGhIFq+phTqNrs0r/bkquNn7zibLOv5YOEz8t37DhCjatPhYlyWms
         BE5pW5tIZ4vKdLEBrguMfec+bWFYhK8bJMM8UVlyFlL4ngaUl/Xaab1Ia0FUrSbyCDAD
         CyJDhZwoz9S2L3tMaY4cD8ly3qw5/VLZ6+JUvU/JdjNWiveC3LSHmTJiSWNbJCXGmwy+
         bjVhbQEGnNK5UDvynm6RW52w32JKVIIafebiobSM+Vn7IOUkSCu4U/XKe6No8dt3m/gy
         7mSbgpd95UmVKtX8Hfb4vAvTXDni1hFvEqN77F+Q34zu4btWiRXaWZIeHWCy7TUpRzlD
         yZzw==
X-Gm-Message-State: AOAM531nd3uIA2BQcDfMPYokmoiFUrVNklNjLc9VLb6MKBDO0/I6weKu
        VJbV1++6mwCpaAPKgw8e39Rd4XKOapQTNTeI5HvqxtA1kHV/WzjlQmHlUvTB9MJaEVDuzze48to
        oK4RgT/3TOpV6fGvCYRDQQcfaSr0IeN2SXw==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr2408740ljh.372.1598274547879;
        Mon, 24 Aug 2020 06:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdsO+dU5Kd6b0KG8KTlraQwNbMCqlXxlyAtYB1XYbufd1hkndGyLcD/o3Yzb0Qx1WTEoiyqHtRy5lWp9vh04o=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr2408734ljh.372.1598274547692;
 Mon, 24 Aug 2020 06:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200820084447.1030353-1-omosnace@redhat.com> <20200820084447.1030353-3-omosnace@redhat.com>
 <899c6b08-13fa-b5d4-04aa-7002fb67c842@gmail.com>
In-Reply-To: <899c6b08-13fa-b5d4-04aa-7002fb67c842@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 15:08:56 +0200
Message-ID: <CAFqZXNtj2X_+GHFsTnU0AvZafx66pb9kFKiyUhk2pFqWb7ceyw@mail.gmail.com>
Subject: Re: [PATCH testsuite v3 2/2] travis: run the full testsuite on a
 Fedora VM
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 5:28 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 8/20/20 4:44 AM, Ondrej Mosnacek wrote:
>
> > This patch removes the old hackery to test-build the testsuite and
> > replaces it with scripts that run the full testsuite on a Fedora VM. The
> > scripts are based on William Roberts' work on SELinux userspace CI [1],
> > which does a similar thing.
> >
> > This patch enables testing on Fedora 32 (the image ships with kernel
> > 5.6.6) and Rawhide nightly images (with kernels close to mainline).
> > Switching to other versions can be controlled via CI environment
> > variables.
> >
> > One downside is that with this patch we lose the test build against
> > refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> > with refpolicy later on.
> >
> > [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, I just applied both patches along with Richard's SCTP patch.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

