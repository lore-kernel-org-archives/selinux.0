Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B3C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4BD20656
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 16:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439849AbgDNQr6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:47:58 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48565 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439829AbgDNQr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 12:47:56 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7E75356121A
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 18:47:51 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id o25so10948343oic.11
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 09:47:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuamqqBKZlE21lDWoRuItsiVXXAjjNxGj2Z/owYkVr5ZQBoNDa+A
        w5DT67fLq01vJXVJ7tsT2nQXaSYjnU9dtqE6xR8=
X-Google-Smtp-Source: APiQypJuo8Z3RS+TNQ7AKAsPKoHCbVRwpPyIOZDUasLKljkZMsH0T+GNPV20ocGNR6VA+eXd1THA9Y5Z3SyKwWHUe18=
X-Received: by 2002:aca:57d6:: with SMTP id l205mr15403310oib.20.1586882870485;
 Tue, 14 Apr 2020 09:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <921250f5-e2aa-f7a3-0455-8ebf76630a7d@linux.microsoft.com> <CAJfZ7=nYriwqun-N+wTMYbc46F+VwZ8SN934AO6dK96vHFTivA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nYriwqun-N+wTMYbc46F+VwZ8SN934AO6dK96vHFTivA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 14 Apr 2020 18:47:39 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==ZxChZH0xJDdoP=yrk5MS12wFqGaA9h-+WYyNhAKAmeQ@mail.gmail.com>
Message-ID: <CAJfZ7==ZxChZH0xJDdoP=yrk5MS12wFqGaA9h-+WYyNhAKAmeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] setfiles: Add -E option to treat conflicting
 specifications as errors.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 14 18:47:51 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 10:29 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Apr 2, 2020 at 5:45 PM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > The following patch set is for adding the -E option to setfiles which would
> > treat conflicting specifications as errors, rather than choosing from one of the
> > specifications.  Choosing one of the specs introduces non-determinism which is
> > problematic, such as where filesystem images are being built in Yocto.  Without
> > this option, the build is not repeatable, since you can have the same source
> > tree and have different labeling outcomes in the output image.
> >
> > This results in setfiles output like the following:
> >
> > # ./setfiles -E file_contexts /tmp
> > ./setfiles: conflicting specifications for /tmp/testfile and /tmp/hardlink,
> > using system_u:object_r:no_access_t:s0.
> > ./setfiles: treating conflicting specifications as an error.
> > ./setfiles: filespec_add error: /tmp/testfile
>
> This looks good to me. If nobody raises an objection, I will merge
> this tomorrow.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.
Thanks,
Nicolas

