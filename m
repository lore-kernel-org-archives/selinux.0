Return-Path: <SRS0=pblC=5K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7EC54FCF
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDCE2073E
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtXLXLNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCYPjD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:39:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40458 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgCYPjD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Mar 2020 11:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585150742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YV63D7zdDvmfTatIhTgr8XnkhlO0qYwYkzHle72WTg=;
        b=HtXLXLNkXG+efwPfFPffkEDPvfdzpfZbBtGjpmTllkkhV0pE3SEA13Q8RHcXtMObm2qoiB
        C3LS2j8ehRyQThTXYk3GLLCHldDxTUACAzGzMuo07+JI1f6WeBNZsMgBitv0mULQVbi1q3
        RDAxFmDAsqV/z3Q/p6WJB/9wDCJqO78=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-6_bESBH_O9eWsXiPF4VaXw-1; Wed, 25 Mar 2020 11:38:55 -0400
X-MC-Unique: 6_bESBH_O9eWsXiPF4VaXw-1
Received: by mail-ot1-f70.google.com with SMTP id r23so1917939otp.4
        for <selinux@vger.kernel.org>; Wed, 25 Mar 2020 08:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YV63D7zdDvmfTatIhTgr8XnkhlO0qYwYkzHle72WTg=;
        b=OdDD7+rQNMunO7Q39G1AVueW80F3BaN8ZOStY2SeXOj+edlqC2vpIJ4aVHHuegL804
         XJ9FSCCnijNN9PaWYGfp/cfpjIk1aTYSmsvFiNZafiD748zkBZJ2ECDbEYrY49YTD0B+
         LNPVA+4Mxa1RCuvavnDz5lRJe+SECksIANBNoAInyAVaP8ETU/LzWecmDBLAGKqSr4vG
         BFgbLxGmbAr8+HB+vptc+E3JM9DOS7NTLczNdwgBlDQbPOwEu0bh+izYhevpcEtAUoDE
         Vzg0SC7prUwFaDP182dj9IG/AkejkTJLRT87dxaoYzOZzMJ+DsiCQWQ/dD+YP3wH4EKg
         HKfA==
X-Gm-Message-State: ANhLgQ1ILhMDwVcYfrc68KfRHPFWGu1eEQmcUC9G8w66LI8q6S9tMiVy
        e75eZ2ZP+F+Z0WofnxYXt/jv7S38JyLZBHeZNaQSEwjXDVdSBPjKg9q3yZWm+fYkdMUkKcNq1LT
        6gHgwZGlTQVa7vHUqiAVTZD4JFqnMLh9/ww==
X-Received: by 2002:a4a:df05:: with SMTP id i5mr1736487oou.9.1585150734893;
        Wed, 25 Mar 2020 08:38:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubO+A6bIW4H68AWWgZFRgit40ZrmQbYy8EKpgZvh+4A/Iif+VDxXtUVTL+RQxlJ6Qmab3KLYzz6OH/iAgldWc=
X-Received: by 2002:a4a:df05:: with SMTP id i5mr1736464oou.9.1585150734584;
 Wed, 25 Mar 2020 08:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200325130900.15047-1-richard_c_haines@btinternet.com> <CAEjxPJ5K7Aa=6sJ236b1Qoa9VUePpEJyY=S0bNF2cm3Gd_dqMw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5K7Aa=6sJ236b1Qoa9VUePpEJyY=S0bNF2cm3Gd_dqMw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 25 Mar 2020 16:38:41 +0100
Message-ID: <CAFqZXNs3_HXA1Mh0XXSFy-pmgbQKTBYhsGHP+qHH-tHdfxq8BQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Use native filesystem for tests
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 25, 2020 at 3:55 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 25, 2020 at 9:09 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > If tested on the selinux-next kernel (that has the XFS patch [1]) with
> > the "NFS: Ensure security label is set for root inode" patch [2], then all
> > tests should pass. Anything else will give varying amounts of fails.
> >
> > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > [2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
>
> Thanks, with this version of the patches, make test and ./tools/nfs.sh
> pass for me on the selinux next branch.
> Still need to review all the changes and confirm that it is all
> functioning as expected (e.g. getting the expected permission
> denials).
> Ondrej, how does this fare on RHEL-8, both with respect to differences
> there in policy/userspace and with respect to default use of
> xfs instead of ext4?

Just checked - two of the filesystem tests fail there:

filesystem/test ............. 25/65
#   Failed test at filesystem/test line 524.

#   Failed test at filesystem/test line 572.
filesystem/test ............. 46/65 # Looks like you failed 2 tests of 65.
filesystem/test ............. Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/65 subtests
[...]
Test Summary Report
-------------------
filesystem/test           (Wstat: 512 Tests: 65 Failed: 2)
 Failed tests:  26, 29
 Non-zero exit status: 2

In both cases the xfs_quotas_test program exits with 0, not with an
error as expected.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

