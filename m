Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB702C433E0
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E50820671
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8TjvUb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETPS2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbgETPS2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 11:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589987906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4ZBbdx93oYVQs2qLF1GdFUqjDP2EmG/cPCQwKxLwN0=;
        b=g8TjvUb4zVUA1aD7CMzEE+mC5ptKy6cjpT/+Wxf9DglDCXX2c4YJ0uYekugL3mXiCEdwv3
        dMSlUOxL1c47WXMBu4QBUEBQk0a98PzJNfP1gCoyDhDShPJH9ePK14CKW8TMFBqW7dLyK7
        Z3vy0bHwXYTmssslv9uQcmTLcjM2DP8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-nL0tNfihPSutnTwlK-WUcw-1; Wed, 20 May 2020 11:18:25 -0400
X-MC-Unique: nL0tNfihPSutnTwlK-WUcw-1
Received: by mail-oo1-f70.google.com with SMTP id 187so1865416oor.18
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4ZBbdx93oYVQs2qLF1GdFUqjDP2EmG/cPCQwKxLwN0=;
        b=sjy2c3F0uSaj4QespwKOH6s/UwMhQ4D5Aet1ik3r4QOBxLi+HTGgvImx1JQBj7h3sn
         wMo5zVgQdE/KovUiUrko0vIwHcThTgbVhrHNWUi8K0UAionATXWrgf71cXZ6+82dtoxB
         pPB5J0bq+Ugd/vTN2iXviIFXWN387PD4YK6r/rJ+Fm3j9Ltlico23V8gHTYFlCgPaHZn
         indVJSjZJ8HVke3hM3gKcTivR6jzySGLL5vat98UyrBONI9pilNff1wpgwz4QMH73HhL
         4WJKVUhHtqQNa2VhfkjCnb1GwIUNb7pF/2LzRzg99Bl34kpOI8T3u048Q2HwbmXGy448
         JujQ==
X-Gm-Message-State: AOAM533nt9Kz04L1z4yeyKs/r/M6ZRGySFmBVT+uNIAQuMp3cAdV91G7
        e0A1SDfck+Z5inAoaXlL/moKbsKBxkj5EPWhqCq6er/tMgkfl7NLCHy1U5hD5r55NxqfKRh2MHM
        zIjudz+yLf5/Q5LSQy29FMrzcTHpL/PysXg==
X-Received: by 2002:a9d:3a7:: with SMTP id f36mr3700905otf.197.1589987902538;
        Wed, 20 May 2020 08:18:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMBiPQLouoQKEzVfhhjAapC4D9PnQNnkA6jvCRnXytuluOUIk2l+mFMmTcnTRsxZ1wfy4N3118Rm/swYKuqSE=
X-Received: by 2002:a9d:3a7:: with SMTP id f36mr3700881otf.197.1589987902220;
 Wed, 20 May 2020 08:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <20200515212132.24204-1-william.c.roberts@intel.com> <CAFqZXNsWE6DDZ-jvzTTm-f+4YL5hMhqQBPktxS+UpZvs9OcCAQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsWE6DDZ-jvzTTm-f+4YL5hMhqQBPktxS+UpZvs9OcCAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 May 2020 17:18:10 +0200
Message-ID: <CAFqZXNvoBM_hai=uLNLmWX+sm3CsSrvDExUm7V+Durjm1J7Pog@mail.gmail.com>
Subject: Re: [PATCH v3] README: update kernel-devel package in dnf command
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 11:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, May 15, 2020 at 11:22 PM <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The README.md file in the selinux-testsuite states that kernel-devel
> > package is needed. However, for everything to work you need the
> > kernel-devel package specific to your kernel version.
> > Update the dnf command to include uname -r, so that a copy + paste
> > of the dnf command, results in a system with dependencies filled
> > for recent Fedora distro's like Fedora 32.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  README.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index 1f7e5d92a100..1bec9fe85c91 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -74,7 +74,7 @@ following command:
> >                 attr \
> >                 libbpf-devel \
> >                 keyutils-libs-devel \
> > -               kernel-devel \
> > +               kernel-devel-$(uname -r) \
> >                 quota \
> >                 xfsprogs-devel \
> >                 libuuid-devel
> > --
> > 2.17.1
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Applied.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

