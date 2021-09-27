Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE546C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCF76108E
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhI0Ii7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:38:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:45127 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhI0Ii5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 04:38:57 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F29B5564D60
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 10:37:18 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id q23so15107686pfs.9
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 01:37:18 -0700 (PDT)
X-Gm-Message-State: AOAM531NGB19NsokwgbeJwrBGb4gVVn8zUw1y4CDGLUT1fdYvmdbxfGF
        fDNvuGetMN9NUHVujyhfITW8lMf7YhUMC0oTycM=
X-Google-Smtp-Source: ABdhPJyNc54mZI241CukxyvBWtnTbIgfBISD1RqPAMYF5OJY+/BiRUIoc0DKjdVdzlfM+niqnJMu8Ew5seUoJVBmEvA=
X-Received: by 2002:a65:648b:: with SMTP id e11mr15418730pgv.138.1632731837617;
 Mon, 27 Sep 2021 01:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <8735pwvdau.fsf@redhat.com>
In-Reply-To: <8735pwvdau.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 27 Sep 2021 10:37:06 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mn=xiLkEwKtxFpx9wfrcheDrY7c8NO1pyybFWQ--rcXg@mail.gmail.com>
Message-ID: <CAJfZ7=mn=xiLkEwKtxFpx9wfrcheDrY7c8NO1pyybFWQ--rcXg@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.3-rc2 release candidate
To:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep 27 10:37:19 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 22, 2021 at 5:30 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> A 3.3-rc2 release candidate for the SELinux userspace is now
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Please give it a test and let us know if there are any issues.
>
> If there are specific changes that you think should be called out
> in release notes for packagers and users in the final release
> announcement, let us know.
>
> Thanks to all the contributors to this release candidate!

Hello,
Thanks for the work! For information I packaged this rc on Arch Linux
and used it (in a test virtual machine) without any issue. In case
other Arch Linux users want to give it a try, I published the package
sources on a "selinux-3.3-rc" branch of
https://github.com/archlinuxhardened
(https://github.com/archlinuxhardened/selinux/commits/selinux-3.3-rc)
and the compiled packages are available as build artifacts on
https://github.com/archlinuxhardened/selinux/actions/runs/1275713288.

Thanks,
Nicolas

