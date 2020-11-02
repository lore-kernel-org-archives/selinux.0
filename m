Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A40C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0793B206C1
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 11:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBU0YIfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgKBLMn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbgKBLMn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 06:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604315562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rSMQXudaPI97BPSdtM81aojSYm3doaMgJYqSanPs9M=;
        b=OBU0YIfUuHOvI22EAUZwNxLKQ0eqISijUp0TIzgw9qiDLbBmer0gXV7qpzQTWC/MJlDCKk
        4RQzmxEAcuvsa7muPBcB1/qsCe5DtPjLuhGNB9xxuBNxDoo5cPAY2pGx1iA++Je1EuxLXr
        XUxuORXLH8SNIM/LyPlysiniCP/r3hE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-hjGlrOwxM0aafno54Ts7Lw-1; Mon, 02 Nov 2020 06:12:40 -0500
X-MC-Unique: hjGlrOwxM0aafno54Ts7Lw-1
Received: by mail-lj1-f197.google.com with SMTP id s185so5722792lja.5
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 03:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rSMQXudaPI97BPSdtM81aojSYm3doaMgJYqSanPs9M=;
        b=E8i08fRWhuzPzy2ybWI53TpwmwTna0PgRKPZ0A81317RoIpXDoeoiUutlzK5iKGc4G
         kh72lAiMmrkse3Uz2O91BvCB1v7wROEKRh2Fdq0UZ9rnfBHdrs5dCgO30bhuHNsOubXS
         x9MLAVwi/bU0nrHDFS6vvoRQSZ+uv7o/9FIwj2Ik2CdVd9WdacHtQt7rqQtpgXLNaU+R
         Y73GL52PWpwT4vhx591hS/sEbMh1syam3xigtJWOSoHQyFtGMusl0CF2Cv37PptQ/7SU
         +J0SRIOyOz6znfWkGyOnFwAkUDppkzqEpFf0v/aedQbsdiy5217Z+Q3biJzDvYEs2B24
         4oFg==
X-Gm-Message-State: AOAM53171PBOaB3L+3Pucs6+WSgfZbpnYeaRYiceTTEFZgeOVWkl+RRW
        pC/PgZgDaCLgKyCkS5t3WZFax4tiJaCL0zdOZCa8eMID5wpOW7eU2wocuRCcJsozcu59LLFKLcp
        GjRTh7AjSHhHUs3LsNUqBo2j5w04ev3vsLQ==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr5994807ljc.217.1604315556850;
        Mon, 02 Nov 2020 03:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBhhiYmOfiv/wQMb9xv3Oz0qbhco9hxkvIEM0wBaXtltq3DX0l6liZH5jDL2Fs+47qQphR9BpKTYYYdWvm34g=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr5994769ljc.217.1604315555185;
 Mon, 02 Nov 2020 03:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20201102094310.484837-1-omosnace@redhat.com> <20201102101710.GA210822@localhost.localdomain>
In-Reply-To: <20201102101710.GA210822@localhost.localdomain>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Nov 2020 12:12:24 +0100
Message-ID: <CAFqZXNvK=t4zGaLQzP-u-sbrM8KWBX3P7evUqTqcNKHEcYN+QQ@mail.gmail.com>
Subject: Re: [PATCH userspace] ci: bump Fedora image version to 33
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 11:17 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Mon, Nov 02, 2020 at 10:43:10AM +0100, Ondrej Mosnacek wrote:
> > The testsuite will soon be switching to testing multiple filesystems,
> > which exposes a bug in F32 image's kernel. Since Fedora 33 has been
> > released recently and the testsuite runs just fine on it, just bump the
> > image version to avoid the bug.
> >
> > This commit also fixes the script to read out the Fedora image version
> > from environment variables instead of using hard-coded values.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Would it make sense to use Rawhide images from the link bellow?
>
> https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud/x86_64/images/
>
> I think Paul already asked for it in past but I'm not sure what was the outcome.

It is possible and already being used for the testsuite CI. However,
it is a bit harder to get to work reliably and there is always the
possibility of rawhide being randomly broken. It would require some
more extensive updates to the scripts (including a couple fixes from
my pending patches for the testsuite CI), so IMHO it should be done as
a separate patch (if at all).

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

