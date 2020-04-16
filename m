Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BDC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ED620732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hQ0ubLQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442651AbgDPPtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896679AbgDPNdD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 09:33:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C5EC061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:33:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e5so8571724edq.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx7hC/N/qPoRhYlHeshI3wMwx2LElhqdwNPJRsoSico=;
        b=hQ0ubLQXsiijiB9/NieROdPOTi4FfzPaBYYT6oXmgZE11BGTj55hbhlHHK+lcmQW4W
         kDAh9NWAn7OgT5YYBVXjpogVGjYZfkbdEGYZKqNb7UTH2wCgTR+/vnX0oQSma1694z/2
         DzVufB2PRi5TlEhm8BDeneqOC97ApC4gxPNXYP3wV4TXAfjX2PFDkSHZXfJrocHH6sSY
         Vuc5IhyWoR1XqhcBjPMdJojaHwtFgzlsTRfqyB8iBud5LUqObHN4Q/hEbZZVDNyLrE36
         l6xw/ld/CFFTP7dhvk/rITOE01h7rZkUr4H2a+MCwHmoAS/9qGC6+Agvo++/B04NV1gu
         GsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx7hC/N/qPoRhYlHeshI3wMwx2LElhqdwNPJRsoSico=;
        b=e2xG1/d2WFNnnM75sp6fUqEUd6VQO4xz5hrBjzBT/uAoiERfPCmjrbbnEMVHQlpd/Z
         LbcMEU3zEu6afM5nG6Gp8NvuWmN19yE5Kum9OQAS5e2KMmjeLkWGL9POkW6gAp/GgfJ0
         ObT/rbY/uLUx6KuutBOajXXfoBAhvZ2bfW9G4ygSIuZUCnwkeN29s3gAIG0uPG+14tJx
         uoSxwZCPJeyi+F4brmzCAPw7E4IWE7nrKbWkX8qG3fl9cN3WIbYsu64/m/Wz7KeHIk2r
         0i4196EZj6YwTdtEsja4lxCN5TfpxAYLqYAzVbaqjyVmvpilI+6d7iojVU+dfyFMfrfI
         mG8w==
X-Gm-Message-State: AGi0PuaJfvHhZ44tB1kC/TL1A42opFwzW1lSEoptGkVdJiPk5iq/uub8
        DBtIutCNb9fKP0qzOeI/kIRNPNSrzFxQU20hAlLclxTjkg==
X-Google-Smtp-Source: APiQypIFSvRZqJdeTqH9++74gpWvsyBWfzugQnZ4K7oehaSfsMP0MtCTSx5PdmYwgQeznPOo+3T1qaPaHrmo2bKE774=
X-Received: by 2002:aa7:cf1a:: with SMTP id a26mr29977697edy.12.1587043982018;
 Thu, 16 Apr 2020 06:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <158697587242.118532.14560996990720692395.stgit@chester> <CAFqZXNsTFv14wTc_aim7AZEi17rb562V=FAU8y-E82npF-Hh0g@mail.gmail.com>
In-Reply-To: <CAFqZXNsTFv14wTc_aim7AZEi17rb562V=FAU8y-E82npF-Hh0g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Apr 2020 09:32:51 -0400
Message-ID: <CAHC9VhSnP8MAiRh8sXbEEe=Ei7MdnYni4NN7KgBD8QEneZRJVA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add capability:sys_admin to the bpf()
 related test domains
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 6:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 15, 2020 at 9:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Historically the Fedora Kernels have been built with the
> > kernel.unprivileged_bpf_disabled set to 0, which skipped a
> > CAP_SYS_ADMIN check in the bpf() syscall.  However, starting
> > with the Fedora Rawhide v5.7-rcX kernel builds this sysctl
> > is now set to 1 which is triggering a CAP_SYS_ADMIN check
> > when performing bpf() operations.
> >
> > Add the capability:sys_admin to the BPF test domains so they can
> > pass this newly triggered check.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  policy/test_binder_bpf.te    |    2 +-
> >  policy/test_bpf.te           |   12 ++++++------
> >  policy/test_fdreceive_bpf.te |    6 +++---
> >  3 files changed, 10 insertions(+), 10 deletions(-)
>
> I have been applying a similar workaround in our RHEL testing, because
> I encountered the same setting on RHEL-8. Interesting that Fedora is
> doing the same thing now... Perhaps this is an unintended consequence
> of the recent workflow change?

I suspect it is due to CVE-2020-8835 and not the Fedora kernel workflow change.

Although the workflow change was annoying enough in its own way,
unrelated to this issue.  I had to add a bunch of hacks to my
kernel-secnext automation to get things working again (one of the
reasons the post-rc1 patch merging was delayed a day or two).

> Anyway, it seems better to have the
> test ready to work regardless of the sysctl value, so:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
paul moore
www.paul-moore.com
