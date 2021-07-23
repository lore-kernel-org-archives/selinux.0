Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE591C4338F
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D261660EB1
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGWQiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhGWQiD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jul 2021 12:38:03 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D87C061575
        for <selinux@vger.kernel.org>; Fri, 23 Jul 2021 10:18:36 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so1743303ott.9
        for <selinux@vger.kernel.org>; Fri, 23 Jul 2021 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bb4kjgX31MMLpPehfBw0GOOiwFpPPcuiTCq2zdbPw0=;
        b=B+SO4ubdplhnjkUhNt/NQjVN0h1s+9q2Ffa9j/vCV3OJv3PF47ER5XsXM4EKKOZJKq
         0amM9P8Q6EibQKKt3A6nntP6vph7A+VnPyBO3I2ryBiy/dDNXmR88VjSz3rDdyYAjYCc
         Tw2jidgRpdYymOyEe7Na+Q+A/z41rJkl3U4Hdqmw+TT+1hUoa5V/hN1F/y22QkDacCmV
         tvGEn6h7ivvmSHt3sddprQaxUU2Js2Cxpc5goRUHYk4LLcTBOdXXznzNFIrtpCdRhi5N
         PXAjrg0YPAoOQ0cERQ5QKCabO6tFcESd/VS/q5FRgvFwNwMAz+ZizIOKRvA8+Qk9OUMR
         +FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bb4kjgX31MMLpPehfBw0GOOiwFpPPcuiTCq2zdbPw0=;
        b=f3YOfaKHxWSM8DJ02feuYcz+qUAESglvmL3j0d4yTJ3XDZDw/rFmvWm4vFo8xioHL0
         Pk2AuSqS+MhfD6lrAp4aIk6kPxKb7Qwf/4XDYAgjadKXgdvTKQnBm52FEMVQKWP/XnRw
         6B36Q4ErXQNi8qw1M1k8xQiuIJCvCzFXaWzdlc3RPzPLCi6krGb9FciPUe8jgEUwzKMj
         BWnWNyguHtbE7kb0nS+UEBr48n80vxRWSgzc/W3UBu2DEeE26BpM2MKFdY785kX68yJf
         wIrtdwnv8zHx3Ic8kw0KSDKWgc2tfC89jYfCEeoXS8mhtV1w385PTc2Pp4e/wRe2s00P
         Q9qg==
X-Gm-Message-State: AOAM530K1qnyZWniLfR2wCYW2lcuHM/wiBzzQlBZNmfZBZ2lb03bR7L3
        cBHi8gKXdXvMmoRfE9i/NdmulQnby4GAWsVtcf0=
X-Google-Smtp-Source: ABdhPJxkdAiKf7Bt59HQw7UmGM69iKNIY//mvuQyk9eIvNQlTjE6x2L2/fNlSnnQio5bqeehPDI8YTXIw9kUOJ4aDUw=
X-Received: by 2002:a05:6830:4104:: with SMTP id w4mr3811490ott.59.1627060715931;
 Fri, 23 Jul 2021 10:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEN2sdo3wVKXnEUASFTbhR81kOYNgU1CbR0XMUNCTt8keOHC6A@mail.gmail.com>
In-Reply-To: <CAEN2sdo3wVKXnEUASFTbhR81kOYNgU1CbR0XMUNCTt8keOHC6A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 23 Jul 2021 13:18:24 -0400
Message-ID: <CAP+JOzT0++Kp1zNVDY77i92RcosdvC5hyFRQJ8vwmkCin1Ebig@mail.gmail.com>
Subject: Re: libsepol CVE patch issue
To:     Garrett Tucker <gtucker@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 23, 2021 at 11:43 AM Garrett Tucker <gtucker@redhat.com> wrote:
>
> Hi everyone, I'm a product security engineer at Red Hat and we noticed
> that libsepol CVE-2021-36087 was assigned, and marked as resolved
> within the OSS-Fuzz project. The patch info provided for the CVE
> appears to be wrong, and after looking into the provided commits and
> commit ranges, these seem to be the wrong commits and commit ranges
> for this CVE.
>
> Would anyone be able to confirm if there is a fix for this CVE, and if
> so, point us towards the correct patch for this.
>

It is very hard to figure out what is going on in the policy provided
by the fuzzer. The best I can figure out is that the problem was
caused by something in an optional block that had been disabled and
deleted being referred to outside of the optional block. Removing all
of the optional blocks that are going to be disabled anyway eliminates
the problem, so that seems to confirm that idea.

This commit prevents that whole class of bugs from occurring.
340f0eb7f3673e8aacaf0a96cbfcd4d12a405521
libsepol/cil: Check for statements not allowed in optional blocks

The problem is definitely there before this patch. After this patch an
error is produced because a block is declared in an optional.

I hope that helps,
Jim


> All the best,
>
> Garrett
>
