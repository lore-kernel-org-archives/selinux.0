Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE2C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5351A21D7A
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE+ojBro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgK0OTo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730551AbgK0OTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 09:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606486782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Db0k5Zrjj2TAY1waZCK8rTGZ8REm8mTUv2xv0sAYcXc=;
        b=cE+ojBroxo/AsHzEMat/lXKciZ1p1Ueqa6HQufvHPaCl71/QasRn3SiTe+xrnhLrP7Pz6k
        xC5DpL59ePjAqZ5dJWQHGxqDWZpRI7HhFgfpO6+VgGK1VYbs5ACsflkIpm98EyK+d/pt0q
        iNKKEMF8nyU6/fA8lbzOyYUgo2eDBwo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-8xPoztUvPUSDT0j4Q6jHdQ-1; Fri, 27 Nov 2020 09:19:40 -0500
X-MC-Unique: 8xPoztUvPUSDT0j4Q6jHdQ-1
Received: by mail-lf1-f70.google.com with SMTP id s23so1988124lfi.1
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Db0k5Zrjj2TAY1waZCK8rTGZ8REm8mTUv2xv0sAYcXc=;
        b=HwAs/O+Ug7B3GwCGyGNQnMyq4AvEVHdWfFvPka1zShD0ADZJQfn1IeODe48oGDTnoo
         e188nluIfoLhLwjct4WQBxqzKgnstvtrfSmBSKI/o8sDPBn0Y7dcClDYkjLX975x+ApN
         3HdeuBcwl6oBxbkmQ/s5y3P+9XplXW8W1EbZoWdfOnVeSEdGu0NBxZkmy5WFyYxdr4/8
         txDCtzd6bQB+gxNU0h+ByFB20jf/N0af5Bni6NMUibyoItYqWGDPIYij3Dkzy94cfusU
         j5aNF+kPobRYxBMUXEBziilmqchd1ppnKq5COyG5X4bgN2QFez18ikbzhV8r4hv2HZOc
         Gn9g==
X-Gm-Message-State: AOAM530T/0nXHTGyZt2B9rvZUhFdLFgkHShMlc4cJrAniF1yAvbtPJnb
        GUAroSRp6MICl5MyEeWvwt3K7i0RGmK4Pw1fGecJnCWYpEWXNtTSSPsKo/xrNWj3/Iy644jgEC2
        1hbgY45vqRuoj7KQobUhkl+kRXazydLeZiA==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3398171ljg.123.1606486778557;
        Fri, 27 Nov 2020 06:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAvSrAa4EiPmmEhtnIGDGTOBqNylFt6LudXu/H57gWdI5V/SYxjsdTnJklv6Ntklsqr3zstzZBdoExy5D+WzY=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3398161ljg.123.1606486778391;
 Fri, 27 Nov 2020 06:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20201127141745.1579498-1-omosnace@redhat.com>
In-Reply-To: <20201127141745.1579498-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 27 Nov 2020 15:19:27 +0100
Message-ID: <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
Subject: Re: [PATCH userspace] travis: run only selinux-testsuite
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 27, 2020 at 3:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Now that the standard testing is run on GitHub Actions, we can remove it
> from .travis.yml, leaving only the selinux-testsuite sanity check, which
> can't be migrated. Hopefully this will save some precious minutesfrom
> the limited "plan" Travis gave us...
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  .travis.yml                    | 161 +--------------------------------
>  scripts/ci/travis-kvm-setup.sh |   1 +
>  2 files changed, 2 insertions(+), 160 deletions(-)

My intent is to apply this patch along with Nicholas's GH actions
patch. In case some issues pop up with GH actions, we can simply
revert it.

Thoughts?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

