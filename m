Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA81C00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E6B20731
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEoN2+Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJ3V4O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbgJ3V4O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 17:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604094973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/UZDMZLpL/YPmJOm17U2OzGuTKId47kUof1LDACntc=;
        b=UEoN2+DcyYI0Mm/VFdsaG/JJZ7keXb+SV46o/TLucQPh9Z/UjUbDWh9qSBGkLOw5TMdOhw
        NFs6MaIeodnmFwC8FpCVuRMM8pwfFEzf+GGr+q3diWe5R9A1oUgJDsMhY+g5ZdlCecZ+pc
        EfVwT6XXs/QUaREGlVW+7wU15z7w8E4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-xlnA4EDENOKwWbAAsFJi0A-1; Fri, 30 Oct 2020 17:56:10 -0400
X-MC-Unique: xlnA4EDENOKwWbAAsFJi0A-1
Received: by mail-lj1-f198.google.com with SMTP id m11so3183304ljp.21
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 14:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/UZDMZLpL/YPmJOm17U2OzGuTKId47kUof1LDACntc=;
        b=fryk681b7u2MhMcFS2hjuMAUGzouo0bf3ybqqSBtazZDtbCSFs/5fdI8dWyjOHHgDy
         vW3f0ANPAw+oPiVAyILob4qGqB+KR9t8z+e7iCeM4n4ZI2x62k4qeGkNzFCyQTI2OZt4
         hVXdAe/0PnBtKj3s9hbb2skST73dVuuvwaOfQ0VOfgcEJG41KxYPT9mCHorC4ZPV/+2j
         pD5ONOv5C2FRiYQz+T+FpPM62imenmTOTVnr41JJpPgJ/pfbGQOnQBtb4A0aGUO07NYc
         Zby7gZtpSN7SQlCOuTcsC6YoSoY4VFpSYEaT4SZcs8hQUBRH+FLUnevJYVrKCTmmHYKL
         y0IA==
X-Gm-Message-State: AOAM530t3Q8ct2Ahh7ONvdDEjbiP0gVpcAZ1xjjGOklZblcgQdDL/ZLc
        hK0m+26xNlGodJ4DbuGisxh24rBZoQq3i05JApzUcKIk9XSbGfrdnMP8GFyUrSV5RqX2jM6f9iQ
        RJLiY6uUJu2hiMcVN56xSrOfLdTs/8toPeQ==
X-Received: by 2002:a19:5c2:: with SMTP id 185mr1887335lff.15.1604094968722;
        Fri, 30 Oct 2020 14:56:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKqatK0jJ5qpvRm1k+DE1hdEqBtv8VQ+z16Xez1jiA+8e62CgHCMcLXWXqV6NdzuXjJDLK6ZA7nD3iWKtwTHM=
X-Received: by 2002:a19:5c2:: with SMTP id 185mr1887329lff.15.1604094968498;
 Fri, 30 Oct 2020 14:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
In-Reply-To: <20201013145456.77253-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 30 Oct 2020 22:55:57 +0100
Message-ID: <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This patch allows BTRFS filesystems to be tested.
>
> The tests/filesystem all pass using './test -f btrfs' on Fedora 32.

For me, also these tests are failing (41 of 58):

Test Summary Report
-------------------
filesystem/btrfs/test     (Wstat: 10496 Tests: 58 Failed: 41)
  Failed tests:  3-4, 10, 13-15, 17-25, 27-28, 30-37, 39-45
                47-55
  Non-zero exit status: 41
fs_filesystem/btrfs/test  (Wstat: 10752 Tests: 57 Failed: 42)
  Failed tests:  3, 9-10, 13-26, 28-36, 38-44, 46-54
  Non-zero exit status: 42

See full log here:
https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422684295#L2711

(Don't be confused by the unusual test output - I'm experimenting with
running the tests for all filesystems in a single testsuite run.)

And on related note, the existing vfat tests are also failing:
Test Summary Report
-------------------
filesystem/vfat/test      (Wstat: 7936 Tests: 43 Failed: 31)
  Failed tests:  3-4, 6-7, 10-12, 14-19, 21-22, 24-36, 38-40
  Non-zero exit status: 31
fs_filesystem/vfat/test   (Wstat: 8192 Tests: 42 Failed: 32)
  Failed tests:  3, 5-7, 10-20, 22-35, 37-39
  Non-zero exit status: 32

Full log here: https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422652226#L2703

> The tests/fs_filesystem fail 42 of 57 using './test -f btrfs' on Fedora 32.
>
> As Fedora 33/Rawhide now defaults to using btrfs, running 'make test' will
> fail 42 of 57 fs_filesystem tests (tested on Rawhide).
>
> These fs_filesystem failures are caused by a bug when using the fsmount(2)
> type calls that was reported in [1].

I'll try to dig into this a little bit. It seems that FS maintainers
are not interested :(

>
> Note btrfs requires a much larger image size (min 115 MiB), and therefore
> takes more than 2x longer to run tests than ext4.
>
> [1] https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
>
> Richard Haines (1):
>   selinux-testsuite: Add BTRFS support for filesystem tests
>
>  tests/filesystem/Filesystem.pm | 10 +++++++++-
>  tests/filesystem/test          |  6 ++++++
>  tests/fs_filesystem/test       |  6 ++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> --
> 2.26.2
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

