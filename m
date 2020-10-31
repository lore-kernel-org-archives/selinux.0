Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE50C00A89
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 00:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7180B208B6
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 00:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWvE526/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgJaAEh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgJaAEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 20:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604102675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvQpeAPq1fn1e2nCNyhqyBtkOttYpKOhbP6+vuqrOkM=;
        b=jWvE526/ACcCc3zVc0dVXcFP36QBBVkrVlon4CFfZrGY335Rq4bqiYeMP21lFF4XGa8blO
        td9lHiZ/5w5OZ+q1j0kMBk+wPA6UQdfvvNX5TVdS/VlvPY4Q5IX/zVrIek6xYseKy0J8Wg
        Gp3Bn8Z+oNuCdqxMV1vXUsh4LS2NbiU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-mpLkZ84GOzKD1bObsEO0Uw-1; Fri, 30 Oct 2020 20:04:33 -0400
X-MC-Unique: mpLkZ84GOzKD1bObsEO0Uw-1
Received: by mail-lj1-f198.google.com with SMTP id v25so3322921ljh.4
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 17:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvQpeAPq1fn1e2nCNyhqyBtkOttYpKOhbP6+vuqrOkM=;
        b=R26YKYQD8ymMix7l1YclXV1hoLx6zHsvwnl3Jm6lj20NiWOEXzHag5LVRhCOLGS5uH
         MSMrg5MaCRe7IamsN/WmEIVsKKGMV0l2HwGrQSodEnD0zC6teb0vuK13itxQlmT5fHEk
         aBh221MpDzLX9m1QxIlmYB9AqTFvECEt3QYozL0WnzKtHpr97hILQUEtc93hQ/09qR1x
         Oo92mzHnjkVxhOPrB6s/lVvyUEmRooJkIlvo3Q7kAApIP2K1lrdUDAlgw0FXwSttDQJL
         JsR2f4nZB+zTafMrPStlbo1YOELlDDDOUjabnsLx7/ebblwa7OW+tx+/ofxZzluq3O8w
         6G8Q==
X-Gm-Message-State: AOAM533cIWxnLgqGcdSD8S6oXeBEbnatD4/4KWJon4BCydbWHKx3g15x
        BdbKmKAnmPlaseL+DL4R3L1biHb/SBrvMnRwHo1u7GFE2hrJ9+3iqH5DkxC2uXH1467RxVymK7U
        DI7a2icGRUXGylEKgRQArgieI1fhC54ARuA==
X-Received: by 2002:a19:f605:: with SMTP id x5mr1900682lfe.39.1604102671846;
        Fri, 30 Oct 2020 17:04:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcOs4TVkRSJYCN48w7k3SQkaJSOjpjfFjYd5jYNWxAfJCld/sOybbd+dF7EDld+rOhmkXCYmCNnM2w9Rn7Urs=
X-Received: by 2002:a19:f605:: with SMTP id x5mr1900673lfe.39.1604102671672;
 Fri, 30 Oct 2020 17:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
 <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com> <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
In-Reply-To: <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 01:04:20 +0100
Message-ID: <CAFqZXNvUiezPUTYgV+vWiS2LO5Nt0_Sb-p8GeELhLjVcPVTmRg@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 12:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > And on related note, the existing vfat tests are also failing:
> > Test Summary Report
> > -------------------
> > filesystem/vfat/test      (Wstat: 7936 Tests: 43 Failed: 31)
> >   Failed tests:  3-4, 6-7, 10-12, 14-19, 21-22, 24-36, 38-40
> >   Non-zero exit status: 31
> > fs_filesystem/vfat/test   (Wstat: 8192 Tests: 42 Failed: 32)
> >   Failed tests:  3, 5-7, 10-20, 22-35, 37-39
> >   Non-zero exit status: 32
>
> And this might be the same problem, but with dosfstools... I'll need to check.

Yeah, that was it. With dosfstools installed the tests pass.

There are some fsetfilecon(3) errors visible in the test output, though:
https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422914927#L2697

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

