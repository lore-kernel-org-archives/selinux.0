Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C26C38A2B
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6058620732
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgDMIaK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:30:10 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37040 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgDMIaJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 04:30:09 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 14DD35612A5
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 10:30:06 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id l21so2809360otd.9
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 01:30:05 -0700 (PDT)
X-Gm-Message-State: AGi0PuakKujqktD/SQMOHnWJctFhUSZKhAdugpccCUHhTh7FuedkVSjA
        e1C/GsjGOrOiNrsgTHzSy9y+0gZ/G8VINv7vtGA=
X-Google-Smtp-Source: APiQypIrtaMRy1hXDWL6IzKixeqP5BYGkNRfdGzhA/gHcwvL8fiRkNdIn9sL1qttaHPZ6CPNVEt2Oevu0n7Wtpdhhjg=
X-Received: by 2002:a05:6830:60b:: with SMTP id w11mr11837448oti.96.1586766605002;
 Mon, 13 Apr 2020 01:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <921250f5-e2aa-f7a3-0455-8ebf76630a7d@linux.microsoft.com>
In-Reply-To: <921250f5-e2aa-f7a3-0455-8ebf76630a7d@linux.microsoft.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 13 Apr 2020 10:29:53 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nYriwqun-N+wTMYbc46F+VwZ8SN934AO6dK96vHFTivA@mail.gmail.com>
Message-ID: <CAJfZ7=nYriwqun-N+wTMYbc46F+VwZ8SN934AO6dK96vHFTivA@mail.gmail.com>
Subject: Re: [PATCH 0/2] setfiles: Add -E option to treat conflicting
 specifications as errors.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 10:30:06 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 2, 2020 at 5:45 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> The following patch set is for adding the -E option to setfiles which would
> treat conflicting specifications as errors, rather than choosing from one of the
> specifications.  Choosing one of the specs introduces non-determinism which is
> problematic, such as where filesystem images are being built in Yocto.  Without
> this option, the build is not repeatable, since you can have the same source
> tree and have different labeling outcomes in the output image.
>
> This results in setfiles output like the following:
>
> # ./setfiles -E file_contexts /tmp
> ./setfiles: conflicting specifications for /tmp/testfile and /tmp/hardlink,
> using system_u:object_r:no_access_t:s0.
> ./setfiles: treating conflicting specifications as an error.
> ./setfiles: filespec_add error: /tmp/testfile

This looks good to me. If nobody raises an objection, I will merge
this tomorrow.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

