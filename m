Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B401C433E2
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B90B20771
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0eK5iNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgGVPE5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVPE4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 11:04:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBCC0619DC
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 08:04:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w17so2134853oie.6
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVigxSjGi5REJYXD8IywFqSNSBSzaygXC1v/LPofipE=;
        b=A0eK5iNJmVIjKIKfM91p5riJbiF0TTFcDLaD2XQA+9oa0//j1cmnQejB3/+6etaCVM
         WtW/khCepSKZf+WC61p2geBOAXqchFJb3zUh0b4r32cCj4CDPu+xa8MjjthZRQ5qyRMZ
         d0h/o8SODCTXsNCPhhLNm/vev/nYwLGthyLJ3e5fvQ/FtSN0Rjrv4oSLuJh9yIHT0L66
         iYsKC/tMb62KUPU88FDmwp9D1viQU5btR4L8SRAkZ7GcycwV9N2bfk/f1GPWJNh6/ZD4
         Af9u4hwSigynUtxHskX2b+RENhle0GYsQNmNwXUSgU9Y41ZtWYXstZZzUsPw1cMEhsY7
         8LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVigxSjGi5REJYXD8IywFqSNSBSzaygXC1v/LPofipE=;
        b=HBg7e53LBfkjNGKLHJbQn0HuohLuYxgwJfqkpU++MaMIDfn1iqd44AU2kgzvXmlZlF
         Egy9OUiIj+oEc6jattkPwyw6pSs9hPgt801dnA70f4d150VQl9gkUnftrYmUADiTOC/s
         W7D/d3h0uV6PoeZCrQwPCiisjuAbwYjIcQLPP2nvmcI26SDRiqCWGxEjhaFmJURfB4FV
         0gekNEJ8K+LaFT3VAhTuToB0nFTDL3fnWNfAVTGq+Sx4sBjteEJ1BlFvuKToH+80U+Ib
         W0tiTjrMqGhBQcvKZO5MVrnikFCrK+2D9W65fyjbU+678peMaJrJk0I6Mh3eMAov1jWf
         hS3w==
X-Gm-Message-State: AOAM533JjGzK/vJeJ31tNifWHDj20pIYGsZsBBdf2qVOU9gNArLzjcEu
        x7Syg5/hOZxC9jfgAWINz84kiWauJGK0bBvx1xticw==
X-Google-Smtp-Source: ABdhPJydT2SpAfKnqt5ExWRjl0nUWEE3bbV+zdLmjpuPwye6H2vRQkd7AgXlL9+/ZcB1qfuyE0/jATMrclDUYbpoYFY=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr71009oif.160.1595430295879;
 Wed, 22 Jul 2020 08:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ49qjVJi1m-bJkaBg2ufx9xx5hPa_HupXbm-6eqXc_j5Q@mail.gmail.com>
 <20200721195726.1975554-1-dominick.grift@defensec.nl>
In-Reply-To: <20200721195726.1975554-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 22 Jul 2020 11:04:45 -0400
Message-ID: <CAEjxPJ7mUurV2XNuck+UEYuu8F_FUtQwRZfYuEe4MK2zxuwmjA@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v2] lsm_selinux: document
 genfs_seclabel_symlinks policy capability
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 3:58 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added with Linux 5.7 and SELinux 3.1
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
