Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F9C2D0A3
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD06216FD
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXfOmC4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKLJRl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 04:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgKLJRk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 04:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605172658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ppJ1WvMCXvJK8DRXWaaVPte+EtVIZyz3W9s3pgh0+CY=;
        b=GXfOmC4OuFylS9+7iO8tzq+IKNz5n40Fn5GCy5H0JSnnyhLKjvcPTWx3pMBnNnkLPz2Bbw
        Mt7EXCrj1LNxOREFCtO+GJLBHUZzJ46R2hrX5UYqMXTRyRVZPDiHy73ZOPa7tUYmox5zp6
        0nO9U+Uee0M3Ecyr4QUGIvTqaS3uBNU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-PWqLF1MkNceNQFhrUI1zQA-1; Thu, 12 Nov 2020 04:17:35 -0500
X-MC-Unique: PWqLF1MkNceNQFhrUI1zQA-1
Received: by mail-lj1-f198.google.com with SMTP id m20so1816728ljj.11
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 01:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppJ1WvMCXvJK8DRXWaaVPte+EtVIZyz3W9s3pgh0+CY=;
        b=jJpPlpYs70KOZZp5CxgwShDp0+q6hjx4a2IJaa69JpKGJ6G1DjoDF9/jVKwW8fN+JS
         xv/VFX1Q787d2htn7pUFmZTS+jSOeyzuiVVAzuETDda1d/stxG/1rn+EMfjOyr6wwyZo
         Q5l64RLQ07qZds0+V+g5AlX3yX2SwY/lCpgkicsgZ/dWsTt2Vp5vGXRz5xWBRO/YoXop
         VtW3ku51XhgILC1TY+T+/ZAFt2NeEvCOWOApZEggNAtNzW88VofwHAySkR3E3Rgpp4GP
         WpzfUdaxLLcnqv5d2ArIqcHkVu2nOCW4nbELQGx+AK3luGuEQA8pdFqMM0/VU+NKwBii
         PkfA==
X-Gm-Message-State: AOAM533datHe7TeggXaV8Tnjm3n7TSCyXlRosY3fA7/QDvMAwy1l4fWQ
        pMqxdz1rImL4enJbE7jTkxPDXkbBYRDGxmyMVn8T1AW7Y8ukGBhGi/Dk1Vwd+AgFZXERA3lovnM
        8wFfC71/tpGM109rTpbypfVcz68RM3+189w==
X-Received: by 2002:a19:bd2:: with SMTP id 201mr9567630lfl.478.1605172653752;
        Thu, 12 Nov 2020 01:17:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEnpcwUUUfDcrLFXY7RxpOBXQ8j5zHKABvaGLoyA7MR0jy8Duj0JoycAcOC7lb04VaG4BN1najNGErFhA7Fso=
X-Received: by 2002:a19:bd2:: with SMTP id 201mr9567623lfl.478.1605172653569;
 Thu, 12 Nov 2020 01:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20201102094310.484837-1-omosnace@redhat.com> <20201102101710.GA210822@localhost.localdomain>
 <CAFqZXNvK=t4zGaLQzP-u-sbrM8KWBX3P7evUqTqcNKHEcYN+QQ@mail.gmail.com> <CAJfZ7=k4KXw_gX9QQp9pWZnL3CfGeNxn7jwq7LrZPg45s6zVUA@mail.gmail.com>
In-Reply-To: <CAJfZ7=k4KXw_gX9QQp9pWZnL3CfGeNxn7jwq7LrZPg45s6zVUA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Nov 2020 10:17:22 +0100
Message-ID: <CAFqZXNseRdNmstXNE4uTTGtMzqHWBGKpe0-xkXd7vMiEDFy9DQ@mail.gmail.com>
Subject: Re: [PATCH userspace] ci: bump Fedora image version to 33
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 10:15 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Mon, Nov 2, 2020 at 12:12 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Mon, Nov 2, 2020 at 11:17 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > On Mon, Nov 02, 2020 at 10:43:10AM +0100, Ondrej Mosnacek wrote:
> > > > The testsuite will soon be switching to testing multiple filesystems,
> > > > which exposes a bug in F32 image's kernel. Since Fedora 33 has been
> > > > released recently and the testsuite runs just fine on it, just bump the
> > > > image version to avoid the bug.
> > > >
> > > > This commit also fixes the script to read out the Fedora image version
> > > > from environment variables instead of using hard-coded values.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > Would it make sense to use Rawhide images from the link bellow?
> > >
> > > https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud/x86_64/images/
> > >
> > > I think Paul already asked for it in past but I'm not sure what was the outcome.
> >
> > It is possible and already being used for the testsuite CI. However,
> > it is a bit harder to get to work reliably and there is always the
> > possibility of rawhide being randomly broken. It would require some
> > more extensive updates to the scripts (including a couple fixes from
> > my pending patches for the testsuite CI), so IMHO it should be done as
> > a separate patch (if at all).
>
> Hi, the patch looks good, but it does not fix everything: e2fsprogs,
> jfsutils and dosfstools also need to be added to
> scripts/ci/fedora-test-runner.sh, like what
> https://github.com/SELinuxProject/selinux-testsuite/commit/d4e507f78a1784334611421cdfa3683a8214b22d
> documented. Do you want to submit a patch about this?

Yes, I forgot that those would also be needed... I just sent a patch
to the list.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

