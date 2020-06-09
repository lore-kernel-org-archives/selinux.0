Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E818C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D2120737
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcl7bidz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFIOCK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 10:02:08 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E52C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 07:02:08 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t6so7448856otk.9
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPW4/mOR5GNdiRTuHGwVVs6UIv3eL5mG0bBru0GXNbQ=;
        b=lcl7bidzlkfFveSMKzeofiu4U0T4pk4FolpPLkKc6TyAjBm6xI+B6ghC0e7jMJDTef
         F9AGxAj4Jshmug/+AsuJPTiZcONLO33eZ++O4DZ2m+9eQFyYH9O3aSrIHEV5DsLhyRry
         If+9hurvCxJyqdimYGa3hdRFHaeu5XuKyJm8cXm7eSYzXYs8L2YfH+/KHTfwJXm4GEdm
         yOfzoULncuMuakt6bMFXDcK9bpbQjQ46st+jSVOxu8IRMrAGSVKb5OPyP+Zqb2OZ31bd
         JBjWMEXyUTR/9244O3FFFjFTTtbFGw2u1CSfWXWbJQ5jH5PvJJ1g3YJhA/e+5wMExtFP
         99ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPW4/mOR5GNdiRTuHGwVVs6UIv3eL5mG0bBru0GXNbQ=;
        b=SgxKmHFFg4+wFRNUuSNMAU5gQKYjhTlkXS2mqHy4AA08v6LXgay4qRie2e7cn4vxhF
         WVXIokXX5EV2sb0LMWMhwf7wf4bVHTvMBZZyr7Jqxd8nui8m6dpmOxG4jO2AMN0kObmh
         trSC7W+M9Aw+r55wVl4AWp/JMdDRTxfTxJkWqcU+knDea6q1MteZBimdcf2bViwSPDFn
         8z7ukNh8L4Uvex33sncDnx28V4m0HqWUqyFAa93FES8OGnCGpJjnqCs7o3umrXFpqh5l
         pZItJid1FmLOSDOlZxCmV6TWyxidr3Q/Bx8Y7ebIW4PoMYC8cECsFG9sLYClpVNH2+/a
         UhBA==
X-Gm-Message-State: AOAM531W8dI1fED4z5COtaMaERhZiDo8Nvf6VvOqqJwWgfDN/7L047pv
        oU4eyj5oFejZKZiHkVsEFZ52/g2GALHxZDfX/f+IfQ==
X-Google-Smtp-Source: ABdhPJxeqxPBvwOYkYpYKLwVAThyW/ZsmbU0+C6GfyDF7k0W8GnuRjuBxujqgGjuCjg7CGnNx1Ykz6AAYRbJQz6i5M8=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr20560370otp.89.1591711327395;
 Tue, 09 Jun 2020 07:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
In-Reply-To: <20200602191856.5040-2-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 10:01:56 -0400
Message-ID: <CAEjxPJ6E6G6WM0WkyRTEh5CiAyFgU3bU9kLRjXnxoWSgmqucGA@mail.gmail.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 3:19 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> The current Travis CI runs the userspace tooling and libraries against
> policy files, but cannot test against an SELinux enabled kernel. Thus,
> some tests are not being done in the CI. Travis, unfortunately only
> provides Ubuntu images, so in order to run against a modern distro with
> SELinux in enforcing mode, we need to launch a KVM with something like
> Fedora.
>
> This patch enables this support by launching a Fedora32 Cloud Image with
> the SELinux userspace library passed on from the Travis clone, it then
> builds and replaces the current SELinux bits on the Fedora32 image and
> runs the SELinux testsuite.
>
> The cloud image run can be controlled with the TRAVIS env variable:
> TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> version numbers in a colon delimited string, eg: "32:1.6".
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
