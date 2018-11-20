Return-Path: <SRS0=awya=N7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB069C28CF8
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66432080F
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 21:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lRKwW85g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66432080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeKUITE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:19:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36178 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUITE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 03:19:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so3009900ljk.3
        for <selinux@vger.kernel.org>; Tue, 20 Nov 2018 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSFYHelkgjfcxltbgE0dJsjr5l0A/NVghmLiphOBPmQ=;
        b=lRKwW85gh1cAP/Jjh39OYKdYCB4nwCDKoDPcRhYT1ey/zqcKUqTB+Y1CpvJLmaAev4
         /9CWubx6wr533xCUMz1qRTKLdYq8V1Twzp5OW8z/yo4+05hykzatfb3+pAVBDSyELJs7
         QHjUKLWdcHj8lqTSDupfVZ1zBbwymPGR2w+MEgoFTU/gjDOuB9bKnFxlyTcNLoHV3b0H
         gAHxOHZVWyIuQcrLZvLbj/NODvjVvn1l8L5i9nWt6L6WoXq8j+91L8jbeTlqniqbsv4C
         WcYPbR5xf7xjruaEkuHGi+n9wuv7UFyX2k5OwUURKhHbBfQ4wElBtbPdzgbGDbck6CsU
         FDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSFYHelkgjfcxltbgE0dJsjr5l0A/NVghmLiphOBPmQ=;
        b=RAI53QoO/m7/lQKDndwFj/tR4YRUNWaRvHPY8Y6ZTvzfkVQsUj1o/tn/PCT0+WJvu0
         +pJOdSBtwQZ6P2Exk/rqs8NqqBObgpn7fJcdYXjVww8BvBbDLHaWNPyCXGZgY0f7iUI/
         861Zqy4btHIt9mh8T52uwaYS7Z2duWrV3hLMjhIOaeZ3PXDFqyrPluny7dEvki9BXWtu
         ULzd1zQW2Nbkf8yJ5eVaLBpKKPQTiNVgxtprVquTLS1gRQfbhdzTUU0NSJjTvcSF0PCH
         hXPrkJHJ2+MLwjNaTTBHtO6vsFzvJgNqS8ljpt2VMHkhWF1MxbGQA+AQ14T5LIgIMLov
         E/kA==
X-Gm-Message-State: AA+aEWZyHoTCBZkHvWoj25iVX4H81i62XCHjLR6+msOV1ua9o2LO6U58
        G7mP3RmZ35eBoRajoXhu7RxFu6PKygFIvq8l973C
X-Google-Smtp-Source: AFSGD/Vc5JLr9kcbBRDJ2sZesGGFEzg6wP0HH6A2iSHJG5GPpvu4tUZwEDKWaD2dKdBkSC1ixB+/rLmrsDLsR7vFFoA=
X-Received: by 2002:a2e:93ce:: with SMTP id p14-v6mr2192104ljh.42.1542750466818;
 Tue, 20 Nov 2018 13:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20181113135255.26045-1-omosnace@redhat.com> <20181113135255.26045-2-omosnace@redhat.com>
In-Reply-To: <20181113135255.26045-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Nov 2018 16:47:35 -0500
Message-ID: <CAHC9VhQoJk0KF2B+SEsVO4Av1qT8dTaOPDPkFV=R1J6W49qSYw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selinux: refactor sidtab conversion
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 13, 2018 at 8:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This is a purely cosmetic change that encapsulates the three-step sidtab
> conversion logic (shutdown -> clone -> map) into a single function
> defined in sidtab.c (as opposed to services.c).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 22 +--------------
>  security/selinux/ss/sidtab.c   | 50 ++++++++++++++++++++++++----------
>  security/selinux/ss/sidtab.h   | 11 ++++----
>  3 files changed, 42 insertions(+), 41 deletions(-)

Merged into selinux/next with some whitespace fixes (inherited from
code you cut n' pasted).  Please remember to run your patches through
scripts/checkpatch.pl before submission.

-- 
paul moore
www.paul-moore.com
