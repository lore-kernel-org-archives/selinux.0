Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7591CC433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC4206F0
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU3X16Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHXPHB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgHXPGX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:06:23 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F85C06179F
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:55:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so8486018oie.11
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aqlVIBpdqJP6xDuhks8MMrSbd1w4Vz9bPxJLtEnD60=;
        b=eU3X16UwG31mwaDv7GE8rXGESvsR3n4DG67ivoovxxe/FyNtOhTxN9+oo0PKnz4QU9
         DNPujLX1s6Ytu+GCElxP9ZsNOl4TE3McxRc1b7kb3Ra7hxqAm/HtmJJT4rM3uIoEpsEx
         UyKz0rMotki0x3M9H9EUhV/lK1r8alDjppMttFZZi7JIKD2bf8jUw/EXqD144sr85rDO
         hnfdeuYotBeCSGjB/+nxcnN6oyaTkOUu5zAkdREHwBwUsnXpy+ZHIxIoD2ZXnTj3wlI6
         gll+ig7mumifPQHUjejsCCIk3LtJKG/p1Si4dxEAtBq1pFB4tYoIsS2IOVkFQ03PZblT
         d7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aqlVIBpdqJP6xDuhks8MMrSbd1w4Vz9bPxJLtEnD60=;
        b=NQqVYDwkYCEuPiH5SrYtOp2edDTsRC9HA0/yeOf7izZoouZK4j/cIsJR1yFvXXpupp
         A1b1stMNFVI1nmQFv+4lKl2ipF7e9vCaCH7a8A74NSQCs3+3zK0jAcCap9hjIkUSErKG
         Ep8t4o/P49xq1nVjpUMkRmxZ0KZQi7CVSma7q7g7OzpTe8k6PxpHdRK7XgGoj9yTZWLc
         G+N+eiMXiclTRmtzAqUuvTxfY1ZC43Xh8r6MJNeVw+I5eH4xkR0xE/1YUZbS+ZpZ/OPI
         bHJmhZXuU+LE0KPXg9Dg2+KvMZrArU/AQ9r16yjbcMYNj7/BuZrGeNz2/UnP6b+vWTBa
         uylA==
X-Gm-Message-State: AOAM532Z0SCilf1UFZlxde5gqtov/wEXgQduzqSiKSznMtsdKwZMpgGu
        ReImXKJbLV+T9BfLQVt6H7Esz3fHCCJSbphwqeh/GeEdZFk=
X-Google-Smtp-Source: ABdhPJyYeGLLaezDqLDRaXfnL3wfo4ZBvXK7bPaWSvC6WjpnPF+htTHfruhnT7tJ0rCdrfoyKjQwdp2ZMgs5dwAoC20=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr3151499oic.92.1598280956269;
 Mon, 24 Aug 2020 07:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200824134416.331220-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200824134416.331220-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 10:55:45 -0400
Message-ID: <CAEjxPJ5V+zX8cbZoM6o2w_Ae0p-md9CJje3rOEfcrE7Qw57GQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libselinux: Remove trailing slash on selabel_file lookups.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:45 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Having a trailing slash on a file lookup, e.g. "/some/path/", can
> cause a different result, for example,  when file contexts are written to have
> the directory have a different label than the contents.  This is inconsistent
> with normal Linux behaviors where trailing slashes are ignored.
>
> Many callers already strip the trailing slash before the lookup or users
> revise the file contexts to work around this.  This fixes it comprehensively.
>
> v2: fix length issues
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
