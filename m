Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AAFC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4A20838
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ettavseM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbgAXTR2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:17:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43201 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgAXTR2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:17:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so3596232edb.10
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caAuTrtXcIBKX93VHZZ+u/3eTTjQ3S97M80KOIWDx3E=;
        b=ettavseMMDlQi1Xe4YbhqKeOi9vVmr4EdxvFDWRlScdrVAZhm4s2XooLIa9WrDepAT
         VRV1ZqcoQbLUbhJu4jOe85haxg3MQD1q6qke2H3u2SHlRWmXvNovmXctHwzebAE5gEgz
         frJENUABpDuPomavMaMKh7tdzVAM/x3tkRh/1EjlKZOjv+CMqKYcL4mESRZ9B9sh0Xru
         yHBxkgtrsuVoYokO9vnornN27qsL4FVDYxAZQu2SOl7GQ830ejoAspSZ857pYnStHfiT
         kv3UPdZfsAxlyw9y50isBJ7+lhgMfEiDx3+7j0/d0R1ExAFLXgEfMY4Wv9PPtCGYZAPT
         oFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caAuTrtXcIBKX93VHZZ+u/3eTTjQ3S97M80KOIWDx3E=;
        b=ZGT6n/DIjuZ2h35aXCTu8gCPn0uWdEwk5BcttxQ+euA7I8VKxrq5OHsm/LRqCZbHSl
         FzYliM3y1SKuAuJrguXHZCmUZA4CytMjs7vOZk0uFFX1CLQFOjbvl7cV2PLMqVuOSKOb
         QAi+giVnEbnAg0eW/gidtgqdYSExSTsQ8u08i/HLOQx6Y2kVBGy1F0ywuShl4RRGHyE7
         9rK+LHPt0ffq5jIEbOcDPBCO/dS/jqaY0If1QC4GJ4hMhL1wiPLV5h4mkKYWFzpXMoqY
         KjziEeDSdN9g4pbADISON6t8qb2Q60s+q9KuXtgc1mRIAGcsQXZX3/mpt752jU4q4Es9
         YU1Q==
X-Gm-Message-State: APjAAAWo8FiKL2o+v9K3m0mtQyIiwsEyUiKc+hMoH03KA6cNlvqG5ocC
        aGIOtkLfQGNTQ6rs4yCbZBGnqhx8ZjhdqmmU9Voe/8c=
X-Google-Smtp-Source: APXvYqyWg6p7auwjuYe0KWFD9VYO5sknYYajyQ5uSDZj7Rp4zGInDRq6XECJ5EftY/pR5nQGLIag3oEsDyoCDdF6tOY=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr3928080edr.164.1579893446842;
 Fri, 24 Jan 2020 11:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-3-richard_c_haines@btinternet.com> <8467a014-e9aa-c148-ebc3-25c79c1853c5@tycho.nsa.gov>
In-Reply-To: <8467a014-e9aa-c148-ebc3-25c79c1853c5@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Jan 2020 14:17:15 -0500
Message-ID: <CAHC9VhTkhrdTPfhBMD=tBqVbCZBGdQS+fPHO1y4k79-CQrAPiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 10:12 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/20/20 6:11 AM, Richard Haines wrote:
> > Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
> > fspick(2) and fsmount(2) api's introduced in kernel 5.2.
> >
> > Also tests move_mount(2) using open_tree(2).
> >
> > These tests use common code from tests/filesystem.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Only question I have is whether we want to enable the move_mount test
> unconditionally and let it break on kernels with the regression.  Otherwise,

Historically we haven't broken the test suite for older kernels, but I
will admit that testing older kernels is no longer a priority for me.

> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> > ---
> >   tests/Makefile                   |   6 +
> >   tests/fs_filesystem/.gitignore   |   3 +
> >   tests/fs_filesystem/Makefile     |  16 +
> >   tests/fs_filesystem/fs_common.c  | 110 ++++
> >   tests/fs_filesystem/fs_common.h  |  30 ++
> >   tests/fs_filesystem/fsmount.c    |  89 ++++
> >   tests/fs_filesystem/fspick.c     |  68 +++
> >   tests/fs_filesystem/move_mount.c |  76 +++
> >   tests/fs_filesystem/test         | 833 +++++++++++++++++++++++++++++++
> >   9 files changed, 1231 insertions(+)
> >   create mode 100644 tests/fs_filesystem/.gitignore
> >   create mode 100644 tests/fs_filesystem/Makefile
> >   create mode 100644 tests/fs_filesystem/fs_common.c
> >   create mode 100644 tests/fs_filesystem/fs_common.h
> >   create mode 100644 tests/fs_filesystem/fsmount.c
> >   create mode 100644 tests/fs_filesystem/fspick.c
> >   create mode 100644 tests/fs_filesystem/move_mount.c
> >   create mode 100755 tests/fs_filesystem/test

-- 
paul moore
www.paul-moore.com
