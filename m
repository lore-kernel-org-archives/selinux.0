Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0228464E3E
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 07:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBRHjG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:39:06 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34448 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhBRHcT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 02:32:19 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id ED2EC564EE3
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 08:31:30 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id v16so1031786ote.12
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 23:31:30 -0800 (PST)
X-Gm-Message-State: AOAM533X0GiILbEG//6fDnotMs2Fx4Ilv38Mz+4rhZJyUfm4RKtYCKze
        HH0B5pn05ZmIo7M49nLQwl39bSY5oOaKDrVYy+Q=
X-Google-Smtp-Source: ABdhPJxwf63y8iHvhmXgZwGvNeTsUL6gFzHu8oNubxUHScQOz48mq7vkVhxfE63c8rJ0k2IDMe4imgSY9viladhCxWk=
X-Received: by 2002:a9d:151:: with SMTP id 75mr1980928otu.279.1613633489797;
 Wed, 17 Feb 2021 23:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20210205140800.275993-1-jwcart2@gmail.com>
In-Reply-To: <20210205140800.275993-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 18 Feb 2021 08:31:19 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kqX0xrHWkCcWMjB7m7VOFiScdcSff+ZWBDHNxy_iGMuw@mail.gmail.com>
Message-ID: <CAJfZ7=kqX0xrHWkCcWMjB7m7VOFiScdcSff+ZWBDHNxy_iGMuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] libsepol: Validate policydb values when reading binary
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb 18 08:31:31 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 3:08 PM James Carter <jwcart2@gmail.com> wrote:
>
> Nicolas Iooss reports that fuzzing /usr/libexec/hll/pp with the
> American Fuzzy Lop revealed that inconsistent policy modules could be
> created that caused NULL dereferences and other problems.
>
> This patch validates the policydb when reading in the binary policy. See
> the description of the second patch for more details.
>
> The validation requires a negligible amount of time to complete.
>
> James Carter (2):
>   libsepol: Create function ebitmap_highest_set_bit()
>   libsepol: Validate policydb values when reading binary policy
>
>  libsepol/include/sepol/policydb/ebitmap.h |   1 +
>  libsepol/src/ebitmap.c                    |  20 +
>  libsepol/src/policydb.c                   |  35 +-
>  libsepol/src/policydb_validate.c          | 764 ++++++++++++++++++++++
>  libsepol/src/policydb_validate.h          |   7 +
>  5 files changed, 815 insertions(+), 12 deletions(-)
>  create mode 100644 libsepol/src/policydb_validate.c
>  create mode 100644 libsepol/src/policydb_validate.h
>
> --
> 2.26.2
>

Hello,
Thanks for these patches! I tested them and the fuzzer I am using
(which consists in running AFL on "pp") no longer crashed :) So I
confirm they fixed the issues I was experiencing, and the code looks
good.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Nicolas

