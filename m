Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2859BC433F5
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJEOsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEOsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:48:51 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848B7822A
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:48:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131dda37dddso19162782fac.0
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x9m2KPIkMFs2D2yiw457gRVTmhKzBy7aHKM5Qrb2rVg=;
        b=kCTacu2n5g7F/73kiKE6xwc+kaqsTNVaQJnxYyHAFt+MbJ0NNPrpRI8abcAB9IX5Id
         aBJd4UiIhisM2N5SpQXc9gfH4tOa816AIS8LQ+QbX4UUxmgjucn3DE51jAwwgURxsBPm
         8UvSGShlC1FHo7V7cHJTReXKxMCKernXVC1LKalG4xg2ngjHDn2ahbGINaGUDUkFHDeo
         xVvjAq61TCM8FmLBWT1mmPFCrQh9aOej+PvvneOmG1QSF33DZ0MjHEWKUUwMB+8H7drj
         jCmdesmm7o8uF7Llg+w8a8l8Ufzd1JtmOP3OG65XSaobcgWd7DG7vCSafq6jxw3PMXE/
         Lo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x9m2KPIkMFs2D2yiw457gRVTmhKzBy7aHKM5Qrb2rVg=;
        b=0phH8gfS8p1mrRLWpS4Fbwg4xKMMrCu0NYs2V/HsuwLTdLqKou/vFrSqHZ+tbcFmLF
         5e8pTbnbZGhXuEuBjn0F2ShzUZd/8ua6kiviEQwafZoYwt6YkHnfXhdG33B+43ySsGJ9
         mwXMf9CTmIcYTBf3Jb5yhv9aceWioU0LhdpAgnKYeuRSIBU9lBqzyygAodFtaiX3sj5X
         24YKKL6vjW76vzaKSnuFGU4XwaO/EyJ98PP00DPyTNmfwoM2+wRD7XFDbCxgxI+AvhgY
         NvYCjpZOOlubXD8AfTh8NOfJJRad0xYChTtknV6PCKzQp584OTIHym2uPppoUAoOvBKI
         p+ww==
X-Gm-Message-State: ACrzQf0T8kvFBwhFDJnkzEcZgSu+rNHCwiKF6bpJH61XZeU6EUstwSkc
        VUFdWZKEsktnsdt9XUM2BjNvhXY4HdNQ2BGuRyjQ8iJ/6g==
X-Google-Smtp-Source: AMsMyM7X9JT8gz1VoYINAAYtKnLA2IvUMBfulI8xbvEuyngp/Re++3xOcK8O7pgGMue8P13aLMEmPtDXYgjc2OThSro=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr2798131oac.51.1664981330259; Wed, 05
 Oct 2022 07:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <166387874213.1884920.6973035378183003234.stgit@olly>
 <CAP+JOzSaVG4asajffr2XbGND7sPRv1uQk=szegVPNV+GMfhboQ@mail.gmail.com> <CAP+JOzSeFMvgdF_V5JbRrUX5t6aSR0pUQGzvApH0HsSNm1-joA@mail.gmail.com>
In-Reply-To: <CAP+JOzSeFMvgdF_V5JbRrUX5t6aSR0pUQGzvApH0HsSNm1-joA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 10:48:39 -0400
Message-ID: <CAHC9VhSgNpj6PxisGDXbVKZmut5DGVm+Ouo2FGXGSBfw-5aJtw@mail.gmail.com>
Subject: Re: [PATCH] docs: add Paul Moore's GPG fingerprint
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 5, 2022 at 10:39 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Sep 27, 2022 at 3:45 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 4:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: James Carter <jwcart2@gmail.com>
>
> Merged.
> Thanks,
> Jim

Thanks again :)

I would encourage the other people listed in that file whose keys have
been signed by others in the project to list their key fingerprints in
that file.

-- 
paul-moore.com
