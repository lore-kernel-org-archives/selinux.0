Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D249C4332E
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B62070A
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRGVH4sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgCSThg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:37:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45885 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSThg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:37:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id 9so3955825oiq.12
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AHCLuZw4348kyw5fAMUpmcnaugKRYDlRZr9GCwAnL4=;
        b=tRGVH4sXuuw9Qlq1iAqflULU92vhq9EI4tC3EZArAUhMcDFSYJRvMK1yjmiOv2UCG8
         IQONDCJAJoOxwqCNzEO8wxRd955wDGE/r5LKD1hJW8Wq6svz/4yGXtfu+Z6Kdv3KyPb8
         YA6aZUraomCj6FBdF8wv6CRSog0tc3U48kx+LBdEBxPLwrjnm1sEX8KnEd0VfKTRgpoe
         8PkU0DVZu5yTua07UQE8T+CyoGi6troH+7vqqWAOWcXt73TJHZlbXlFe1UUUSKzwL0xn
         6oZyOVDudkgznmOkQxtb0jAJwbm3xr3YSYku+JzHvrwlL1VKf4s3whZJyaK0GW2sOApM
         P5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AHCLuZw4348kyw5fAMUpmcnaugKRYDlRZr9GCwAnL4=;
        b=YyCRriGvbJW+uU9G0lzItYdnNs41GTGUX7eem+6EG1g1mbou+QvszgKJ4j+6wjIEf/
         6N5kCl/Kd2VIx9n5HQ63ZWqggZjCj8XPTeHWM4Z6kqjtUwNhBy6+Iv2UUmqW5HsZ4Vjo
         JQ6QWkwBc3/HI18Rm3/bKZaqctgxap/ssULRypScNazUw8gIdkuYWzZMyCUpHuI8G4Xf
         /iq00TR/92mzHhiOf3BMX/zsi0Ky4pZcux5YQmIMlCnpuMAgrISYrv318ehntQPLU9Mt
         bR9Z7uhM+42sR7VNu9YN0KqORu64PWr8NzF5HRIgn9tC5COQcSuzjypcDnsZ1nK+OksA
         rxCw==
X-Gm-Message-State: ANhLgQ1hrDoZo8sh0/BcgvNcLc6OTvO3wOTtKZJdOnReq/wnmm3Y8wrL
        EDWRIiT7ANXcQ7j8sAWsdIwYa7keACr+bYgsynQ=
X-Google-Smtp-Source: ADFU+vsyhKMmz4RCEK0TsFP41I6rSpWKhyqv3+Zk3igh9PAKndkcjIqNDz9fNhmZVbsk8hAZIkWYslJwYhxuHCjOM0E=
X-Received: by 2002:aca:be56:: with SMTP id o83mr3720040oif.25.1584646655488;
 Thu, 19 Mar 2020 12:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-2-omosnace@redhat.com>
 <CAEjxPJ7=e_RT0sEFr8i4pNyKmz2F3zVfScswWp6vwzO3CH3eGw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=e_RT0sEFr8i4pNyKmz2F3zVfScswWp6vwzO3CH3eGw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Mar 2020 15:39:02 -0400
Message-ID: <CAP+JOzSCdsxFUMht=ET7xE2ntFXSsX=KJ0PLPD-Cf_pChK=z=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: skip unnecessary check in build_type_map()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 17, 2020 at 2:20 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > I copy-pasted it from a different part of the code, which had to deal
> > with policydb that isn't final yet. Since we only deal with the final
> > kernel policy here, we can skip the check for the type datum being NULL.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
Thanks,
Jim
